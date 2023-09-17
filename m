Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83CBC7A39BE
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239539AbjIQTxh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240156AbjIQTxR (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:53:17 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1019F
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:53:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120B0C433C8;
        Sun, 17 Sep 2023 19:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980391;
        bh=c+y+VWb1Gv85N5ERrYD+6JfJoFuQUaPfe+9Ok2gSB+M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xelwlNP1f5e8YcK95NC+KW2SB+eWcDxTOS+OR+nOyg8sXnYDudgc6Bwi4+0/U28R9
         IemXRy0O8hIQrmqPbyYI+qXGtNz+mVoq67dtE8nF/sI5GTLV3xzeR1PHWJI+fGfPSy
         mVuS8Jizz6R4QIbGsHUg9xgYeM3THzaFYAx/GEp8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pavel Kozlov <pavel.kozlov@synopsys.com>,
        Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH 6.5 179/285] ARC: atomics: Add compiler barrier to atomic operations...
Date:   Sun, 17 Sep 2023 21:12:59 +0200
Message-ID: <20230917191057.819490325@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

From: Pavel Kozlov <pavel.kozlov@synopsys.com>

commit 42f51fb24fd39cc547c086ab3d8a314cc603a91c upstream.

... to avoid unwanted gcc optimizations

SMP kernels fail to boot with commit 596ff4a09b89
("cpumask: re-introduce constant-sized cpumask optimizations").

|
| percpu: BUG: failure at mm/percpu.c:2981/pcpu_build_alloc_info()!
|

The write operation performed by the SCOND instruction in the atomic
inline asm code is not properly passed to the compiler. The compiler
cannot correctly optimize a nested loop that runs through the cpumask
in the pcpu_build_alloc_info() function.

Fix this by add a compiler barrier (memory clobber in inline asm).

Apparently atomic ops used to have memory clobber implicitly via
surrounding smp_mb(). However commit b64be6836993c431e
("ARC: atomics: implement relaxed variants") removed the smp_mb() for
the relaxed variants, but failed to add the explicit compiler barrier.

Link: https://github.com/foss-for-synopsys-dwc-arc-processors/linux/issues/135
Cc: <stable@vger.kernel.org> # v6.3+
Fixes: b64be6836993c43 ("ARC: atomics: implement relaxed variants")
Signed-off-by: Pavel Kozlov <pavel.kozlov@synopsys.com>
Signed-off-by: Vineet Gupta <vgupta@kernel.org>
[vgupta: tweaked the changelog and added Fixes tag]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arc/include/asm/atomic-llsc.h    |    6 +++---
 arch/arc/include/asm/atomic64-arcv2.h |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

--- a/arch/arc/include/asm/atomic-llsc.h
+++ b/arch/arc/include/asm/atomic-llsc.h
@@ -18,7 +18,7 @@ static inline void arch_atomic_##op(int
 	: [val]	"=&r"	(val) /* Early clobber to prevent reg reuse */	\
 	: [ctr]	"r"	(&v->counter), /* Not "m": llock only supports reg direct addr mode */	\
 	  [i]	"ir"	(i)						\
-	: "cc");							\
+	: "cc", "memory");						\
 }									\
 
 #define ATOMIC_OP_RETURN(op, asm_op)				\
@@ -34,7 +34,7 @@ static inline int arch_atomic_##op##_ret
 	: [val]	"=&r"	(val)						\
 	: [ctr]	"r"	(&v->counter),					\
 	  [i]	"ir"	(i)						\
-	: "cc");							\
+	: "cc", "memory");						\
 									\
 	return val;							\
 }
@@ -56,7 +56,7 @@ static inline int arch_atomic_fetch_##op
 	  [orig] "=&r" (orig)						\
 	: [ctr]	"r"	(&v->counter),					\
 	  [i]	"ir"	(i)						\
-	: "cc");							\
+	: "cc", "memory");						\
 									\
 	return orig;							\
 }
--- a/arch/arc/include/asm/atomic64-arcv2.h
+++ b/arch/arc/include/asm/atomic64-arcv2.h
@@ -60,7 +60,7 @@ static inline void arch_atomic64_##op(s6
 	"	bnz     1b		\n"				\
 	: "=&r"(val)							\
 	: "r"(&v->counter), "ir"(a)					\
-	: "cc");							\
+	: "cc", "memory");						\
 }									\
 
 #define ATOMIC64_OP_RETURN(op, op1, op2)		        	\
@@ -77,7 +77,7 @@ static inline s64 arch_atomic64_##op##_r
 	"	bnz     1b		\n"				\
 	: [val] "=&r"(val)						\
 	: "r"(&v->counter), "ir"(a)					\
-	: "cc");	/* memory clobber comes from smp_mb() */	\
+	: "cc", "memory");						\
 									\
 	return val;							\
 }
@@ -99,7 +99,7 @@ static inline s64 arch_atomic64_fetch_##
 	"	bnz     1b		\n"				\
 	: "=&r"(orig), "=&r"(val)					\
 	: "r"(&v->counter), "ir"(a)					\
-	: "cc");	/* memory clobber comes from smp_mb() */	\
+	: "cc", "memory");						\
 									\
 	return orig;							\
 }


