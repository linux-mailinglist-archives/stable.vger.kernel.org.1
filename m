Return-Path: <stable+bounces-150031-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9330ACB532
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 17:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 72CC47B0EC1
	for <lists+stable@lfdr.de>; Mon,  2 Jun 2025 14:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071B223875D;
	Mon,  2 Jun 2025 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ghTNRnvZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C2D238177;
	Mon,  2 Jun 2025 14:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748875815; cv=none; b=gNWvVcD/cdoeuTROS2Z8lecBqlkQ4GUq8gJ6XFiIOYkqgW4No5grYcg8Xoi9rfaf1RvcoMpe+7gWKvX4z6QswYCo9lZcrYQDoceqy3gZStHLEYTlZqPuTw/Q+/oP5AOPRLYl2AkKrpWwJfUsfxs5q2DovavjGWSTIhUts+tCYQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748875815; c=relaxed/simple;
	bh=76K8QDU/zTfZZIcOLAtMQtw9Pcotmxa3+egaMvCbSVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inJy8XGGIdM2Bv13N4OGtPLH3T9yjPVLXWTq3JnA8zxqAIYCQTxhQUEJZC1lfJpJ6z2DVgAi2GFiasTnkOQKO1k5oayqfkZ4oaSVYnj93l0TlI7uTyeAeFnjsc5gJ0hQsNP/yGCFzMIjT6NfFtrjKZHm7od7+KuZM08hjUyJLUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ghTNRnvZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220A4C4CEEB;
	Mon,  2 Jun 2025 14:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1748875815;
	bh=76K8QDU/zTfZZIcOLAtMQtw9Pcotmxa3+egaMvCbSVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghTNRnvZCdp1tMEMShcQtLpSoipH4Sy716QllOv/rN6TmgJpY/F+SFWlE7wdBBfjb
	 8pBLhRwoh6d4jGYibqfUj6XLPs/Rzyb95iwXi5q+p9Vr0kiB7ACo7hD/TczmIa7KZT
	 +/0lvFsukdwEQ3ShPbU3ieLFxxvWtsamUAjfPF7Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Linux Kernel Functional Testing <lkft@linaro.org>,
	Marcus Seyfarth <m.seyfarth@gmail.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5.10 252/270] kbuild: Disable -Wdefault-const-init-unsafe
Date: Mon,  2 Jun 2025 15:48:57 +0200
Message-ID: <20250602134317.632920110@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250602134307.195171844@linuxfoundation.org>
References: <20250602134307.195171844@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nathan Chancellor <nathan@kernel.org>

commit d0afcfeb9e3810ec89d1ffde1a0e36621bb75dca upstream.

A new on by default warning in clang [1] aims to flags instances where
const variables without static or thread local storage or const members
in aggregate types are not initialized because it can lead to an
indeterminate value. This is quite noisy for the kernel due to
instances originating from header files such as:

  drivers/gpu/drm/i915/gt/intel_ring.h:62:2: error: default initialization of an object of type 'typeof (ring->size)' (aka 'const unsigned int') leaves the object uninitialized [-Werror,-Wdefault-const-init-var-unsafe]
     62 |         typecheck(typeof(ring->size), next);
        |         ^
  include/linux/typecheck.h:10:9: note: expanded from macro 'typecheck'
     10 | ({      type __dummy; \
        |              ^

  include/net/ip.h:478:14: error: default initialization of an object of type 'typeof (rt->dst.expires)' (aka 'const unsigned long') leaves the object uninitialized [-Werror,-Wdefault-const-init-var-unsafe]
    478 |                 if (mtu && time_before(jiffies, rt->dst.expires))
        |                            ^
  include/linux/jiffies.h:138:26: note: expanded from macro 'time_before'
    138 | #define time_before(a,b)        time_after(b,a)
        |                                 ^
  include/linux/jiffies.h:128:3: note: expanded from macro 'time_after'
    128 |         (typecheck(unsigned long, a) && \
        |          ^
  include/linux/typecheck.h:11:12: note: expanded from macro 'typecheck'
     11 |         typeof(x) __dummy2; \
        |                   ^

  include/linux/list.h:409:27: warning: default initialization of an object of type 'union (unnamed union at include/linux/list.h:409:27)' with const member leaves the object uninitialized [-Wdefault-const-init-field-unsafe]
    409 |         struct list_head *next = smp_load_acquire(&head->next);
        |                                  ^
  include/asm-generic/barrier.h:176:29: note: expanded from macro 'smp_load_acquire'
    176 | #define smp_load_acquire(p) __smp_load_acquire(p)
        |                             ^
  arch/arm64/include/asm/barrier.h:164:59: note: expanded from macro '__smp_load_acquire'
    164 |         union { __unqual_scalar_typeof(*p) __val; char __c[1]; } __u;   \
        |                                                                  ^
  include/linux/list.h:409:27: note: member '__val' declared 'const' here

  crypto/scatterwalk.c:66:22: error: default initialization of an object of type 'struct scatter_walk' with const member leaves the object uninitialized [-Werror,-Wdefault-const-init-field-unsafe]
     66 |         struct scatter_walk walk;
        |                             ^
  include/crypto/algapi.h:112:15: note: member 'addr' declared 'const' here
    112 |                 void *const addr;
        |                             ^

  fs/hugetlbfs/inode.c:733:24: error: default initialization of an object of type 'struct vm_area_struct' with const member leaves the object uninitialized [-Werror,-Wdefault-const-init-field-unsafe]
    733 |         struct vm_area_struct pseudo_vma;
        |                               ^
  include/linux/mm_types.h:803:20: note: member 'vm_flags' declared 'const' here
    803 |                 const vm_flags_t vm_flags;
        |                                  ^

Silencing the instances from typecheck.h is difficult because '= {}' is
not available in older but supported compilers and '= {0}' would cause
warnings about a literal 0 being treated as NULL. While it might be
possible to come up with a local hack to silence the warning for
clang-21+, it may not be worth it since -Wuninitialized will still
trigger if an uninitialized const variable is actually used.

In all audited cases of the "field" variant of the warning, the members
are either not used in the particular call path, modified through other
means such as memset() / memcpy() because the containing object is not
const, or are within a union with other non-const members.

Since this warning does not appear to have a high signal to noise ratio,
just disable it.

Cc: stable@vger.kernel.org
Link: https://github.com/llvm/llvm-project/commit/576161cb6069e2c7656a8ef530727a0f4aefff30 [1]
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Closes: https://lore.kernel.org/CA+G9fYuNjKcxFKS_MKPRuga32XbndkLGcY-PVuoSwzv6VWbY=w@mail.gmail.com/
Reported-by: Marcus Seyfarth <m.seyfarth@gmail.com>
Closes: https://github.com/ClangBuiltLinux/linux/issues/2088
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
[nathan: Apply change to Makefile instead of scripts/Makefile.extrawarn
         due to lack of e88ca24319e4 in older stable branches]
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/Makefile
+++ b/Makefile
@@ -795,6 +795,18 @@ KBUILD_CFLAGS += -Wno-gnu
 # source of a reference will be _MergedGlobals and not on of the whitelisted names.
 # See modpost pattern 2
 KBUILD_CFLAGS += -mno-global-merge
+
+# Clang may emit a warning when a const variable, such as the dummy variables
+# in typecheck(), or const member of an aggregate type are not initialized,
+# which can result in unexpected behavior. However, in many audited cases of
+# the "field" variant of the warning, this is intentional because the field is
+# never used within a particular call path, the field is within a union with
+# other non-const members, or the containing object is not const so the field
+# can be modified via memcpy() / memset(). While the variable warning also gets
+# disabled with this same switch, there should not be too much coverage lost
+# because -Wuninitialized will still flag when an uninitialized const variable
+# is used.
+KBUILD_CFLAGS += $(call cc-disable-warning, default-const-init-unsafe)
 else
 
 # Warn about unmarked fall-throughs in switch statement.



