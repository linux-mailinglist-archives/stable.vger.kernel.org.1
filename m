Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66F757B89A3
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbjJDS1s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244231AbjJDS1s (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:27:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D2AD7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:27:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EEEFC433C7;
        Wed,  4 Oct 2023 18:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444063;
        bh=JDKMKrK9jNbYL/pBpOiWY/8iU54C6SdP8ZVQtg6F13E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KoFXa6yAxPJXNFI1GzyojqpbSkhSfgOiEXNoiTiI3a3lkpIHgsJfIn97vFfLusyKW
         Be0aY9rkWSNQHEBJt+0XOYUnobHln1IDHFgopBBtFLiO40AFsAiWm6uNooi3+L7k+n
         z1aVLlwVUmkWYG+PZGR8hqU/Kqk8l9GJnyzQZrz8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ming Lei <ming.lei@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Baokun Li <libaokun1@huawei.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 089/321] locking/atomic: scripts: fix fallback ifdeffery
Date:   Wed,  4 Oct 2023 19:53:54 +0200
Message-ID: <20231004175233.337198324@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Rutland <mark.rutland@arm.com>

[ Upstream commit 6d2779ecaeb56f92d7105c56772346c71c88c278 ]

Since commit:

  9257959a6e5b4fca ("locking/atomic: scripts: restructure fallback ifdeffery")

The ordering fallbacks for atomic*_read_acquire() and
atomic*_set_release() erroneously fall back to the implictly relaxed
atomic*_read() and atomic*_set() variants respectively, without any
additional barriers. This loses the ACQUIRE and RELEASE ordering
semantics, which can result in a wide variety of problems, even on
strongly-ordered architectures where the implementation of
atomic*_read() and/or atomic*_set() allows the compiler to reorder those
relative to other accesses.

In practice this has been observed to break bit spinlocks on arm64,
resulting in dentry cache corruption.

The fallback logic was intended to allow ACQUIRE/RELEASE/RELAXED ops to
be defined in terms of FULL ops, but where an op had RELAXED ordering by
default, this unintentionally permitted the ACQUIRE/RELEASE ops to be
defined in terms of the implicitly RELAXED default.

This patch corrects the logic to avoid falling back to implicitly
RELAXED ops, resulting in the same behaviour as prior to commit
9257959a6e5b4fca.

I've verified the resulting assembly on arm64 by generating outlined
wrappers of the atomics. Prior to this patch the compiler generates
sequences using relaxed load (LDR) and store (STR) instructions, e.g.

| <outlined_atomic64_read_acquire>:
|         ldr     x0, [x0]
|         ret
|
| <outlined_atomic64_set_release>:
|         str     x1, [x0]
|         ret

With this patch applied the compiler generates sequences using the
intended load-acquire (LDAR) and store-release (STLR) instructions, e.g.

| <outlined_atomic64_read_acquire>:
|         ldar    x0, [x0]
|         ret
|
| <outlined_atomic64_set_release>:
|         stlr    x1, [x0]
|         ret

To make sure that there were no other victims of the ifdeffery rewrite,
I generated outlined copies of all of the {atomic,atomic64,atomic_long}
atomic operations before and after commit 9257959a6e5b4fca. A diff of
the generated assembly on arm64 shows that only the read_acquire() and
set_release() operations were changed, and only lost their intended
ordering:

| [mark@lakrids:~/src/linux]% diff -u \
| 	<(aarch64-linux-gnu-objdump -d before-9257959a6e5b4fca.o)
| 	<(aarch64-linux-gnu-objdump -d after-9257959a6e5b4fca.o)
| --- /proc/self/fd/11    2023-09-19 16:51:51.114779415 +0100
| +++ /proc/self/fd/16    2023-09-19 16:51:51.114779415 +0100
| @@ -1,5 +1,5 @@
|
| -before-9257959a6e5b4fca.o:     file format elf64-littleaarch64
| +after-9257959a6e5b4fca.o:     file format elf64-littleaarch64
|
|
|  Disassembly of section .text:
| @@ -9,7 +9,7 @@
|         4:      d65f03c0        ret
|
|  0000000000000008 <outlined_atomic_read_acquire>:
| -       8:      88dffc00        ldar    w0, [x0]
| +       8:      b9400000        ldr     w0, [x0]
|         c:      d65f03c0        ret
|
|  0000000000000010 <outlined_atomic_set>:
| @@ -17,7 +17,7 @@
|        14:      d65f03c0        ret
|
|  0000000000000018 <outlined_atomic_set_release>:
| -      18:      889ffc01        stlr    w1, [x0]
| +      18:      b9000001        str     w1, [x0]
|        1c:      d65f03c0        ret
|
|  0000000000000020 <outlined_atomic_add>:
| @@ -1230,7 +1230,7 @@
|      1070:      d65f03c0        ret
|
|  0000000000001074 <outlined_atomic64_read_acquire>:
| -    1074:      c8dffc00        ldar    x0, [x0]
| +    1074:      f9400000        ldr     x0, [x0]
|      1078:      d65f03c0        ret
|
|  000000000000107c <outlined_atomic64_set>:
| @@ -1238,7 +1238,7 @@
|      1080:      d65f03c0        ret
|
|  0000000000001084 <outlined_atomic64_set_release>:
| -    1084:      c89ffc01        stlr    x1, [x0]
| +    1084:      f9000001        str     x1, [x0]
|      1088:      d65f03c0        ret
|
|  000000000000108c <outlined_atomic64_add>:
| @@ -2427,7 +2427,7 @@
|      207c:      d65f03c0        ret
|
|  0000000000002080 <outlined_atomic_long_read_acquire>:
| -    2080:      c8dffc00        ldar    x0, [x0]
| +    2080:      f9400000        ldr     x0, [x0]
|      2084:      d65f03c0        ret
|
|  0000000000002088 <outlined_atomic_long_set>:
| @@ -2435,7 +2435,7 @@
|      208c:      d65f03c0        ret
|
|  0000000000002090 <outlined_atomic_long_set_release>:
| -    2090:      c89ffc01        stlr    x1, [x0]
| +    2090:      f9000001        str     x1, [x0]
|      2094:      d65f03c0        ret
|
|  0000000000002098 <outlined_atomic_long_add>:

I've build tested this with a variety of configs for alpha, arm, arm64,
csky, i386, m68k, microblaze, mips, nios2, openrisc, powerpc, riscv,
s390, sh, sparc, x86_64, and xtensa, for which I've seen no issues. I
was unable to build test for ia64 and parisc due to existing build
breakage in v6.6-rc2.

Fixes: 9257959a6e5b4fca ("locking/atomic: scripts: restructure fallback ifdeffery")
Reported-by: Ming Lei <ming.lei@redhat.com>
Reported-by: Darrick J. Wong <djwong@kernel.org>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Baokun Li <libaokun1@huawei.com>
Link: https://lkml.kernel.org/r/20230919171430.2697727-1-mark.rutland@arm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/atomic/atomic-arch-fallback.h | 10 +---------
 scripts/atomic/gen-atomic-fallback.sh       |  2 +-
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linux/atomic/atomic-arch-fallback.h
index 18f5744dfb5d8..b83ef19da13de 100644
--- a/include/linux/atomic/atomic-arch-fallback.h
+++ b/include/linux/atomic/atomic-arch-fallback.h
@@ -459,8 +459,6 @@ raw_atomic_read_acquire(const atomic_t *v)
 {
 #if defined(arch_atomic_read_acquire)
 	return arch_atomic_read_acquire(v);
-#elif defined(arch_atomic_read)
-	return arch_atomic_read(v);
 #else
 	int ret;
 
@@ -508,8 +506,6 @@ raw_atomic_set_release(atomic_t *v, int i)
 {
 #if defined(arch_atomic_set_release)
 	arch_atomic_set_release(v, i);
-#elif defined(arch_atomic_set)
-	arch_atomic_set(v, i);
 #else
 	if (__native_word(atomic_t)) {
 		smp_store_release(&(v)->counter, i);
@@ -2575,8 +2571,6 @@ raw_atomic64_read_acquire(const atomic64_t *v)
 {
 #if defined(arch_atomic64_read_acquire)
 	return arch_atomic64_read_acquire(v);
-#elif defined(arch_atomic64_read)
-	return arch_atomic64_read(v);
 #else
 	s64 ret;
 
@@ -2624,8 +2618,6 @@ raw_atomic64_set_release(atomic64_t *v, s64 i)
 {
 #if defined(arch_atomic64_set_release)
 	arch_atomic64_set_release(v, i);
-#elif defined(arch_atomic64_set)
-	arch_atomic64_set(v, i);
 #else
 	if (__native_word(atomic64_t)) {
 		smp_store_release(&(v)->counter, i);
@@ -4657,4 +4649,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
 }
 
 #endif /* _LINUX_ATOMIC_FALLBACK_H */
-// 202b45c7db600ce36198eb1f1fc2c2d5268ace2d
+// 2fdd6702823fa842f9cea57a002e6e4476ae780c
diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen-atomic-fallback.sh
index c0c8a85d7c81b..a45154cefa487 100755
--- a/scripts/atomic/gen-atomic-fallback.sh
+++ b/scripts/atomic/gen-atomic-fallback.sh
@@ -102,7 +102,7 @@ gen_proto_order_variant()
 	fi
 
 	# Allow ACQUIRE/RELEASE/RELAXED ops to be defined in terms of FULL ops
-	if [ ! -z "${order}" ]; then
+	if [ ! -z "${order}" ] && ! meta_is_implicitly_relaxed "${meta}"; then
 		printf "#elif defined(arch_${basename})\n"
 		printf "\t${retstmt}arch_${basename}(${args});\n"
 	fi
-- 
2.40.1



