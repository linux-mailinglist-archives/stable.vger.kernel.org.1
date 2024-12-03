Return-Path: <stable+bounces-97372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 317F99E23D6
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEE628754F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C788C1F8933;
	Tue,  3 Dec 2024 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Tr6bhjOX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F891F76B0;
	Tue,  3 Dec 2024 15:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733240295; cv=none; b=TxeXKIm5oNGYGnbM86E60xUqnmC7VzImodndEnve+5fntjxXFtEgwjoe+vDmIzOXGcpB+cAJBDKg6jdy4hF/1dexeFk6J7M25mBpJa6+U88UdStvBPPtMILC9rPv/b0SeeV6I/4z7GPe4UVMBnEJvSfe9O6gtb9mHhbD+zhNRBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733240295; c=relaxed/simple;
	bh=ldoZ9royYJbGmmM7AvVZ14/cVcsG7rmn+w+URmNBW1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H7dkLx4vN/xP1UY5rdBVb/6BDxWTSnR/8NlbUDe6qs3FUDn2rCfLqZcW19OdC/mhpWAEL4TNahHaDA2gnrA73y8ULnCJnsXD3hYhfnJ9LUsajV5O/q1APqWAy7XaPX7P+UIWUPib2h16Ik1srS6qr2MlPjMQYB7nupjYZjsr2yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Tr6bhjOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11291C4CECF;
	Tue,  3 Dec 2024 15:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733240295;
	bh=ldoZ9royYJbGmmM7AvVZ14/cVcsG7rmn+w+URmNBW1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tr6bhjOXNJyyO/1sVdvqfEPAhJ7Ub856m00NJE36aRXIRhDnaU4zLot2Sq4c/z1/F
	 3pqgZMSQIigqlBwymQRZzwILEr2ytfrCkAyMk0vRXjRirawL7l4WbVvm8ONYm4q4ZN
	 PWlKfWIP+STIn1aYjfGR3UsJ5PmM1yFwivbasiOQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Uros Bizjak <ubizjak@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 090/826] locking/atomic/x86: Use ALT_OUTPUT_SP() for __arch_{,try_}cmpxchg64_emu()
Date: Tue,  3 Dec 2024 15:36:57 +0100
Message-ID: <20241203144747.242117438@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203144743.428732212@linuxfoundation.org>
References: <20241203144743.428732212@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Uros Bizjak <ubizjak@gmail.com>

[ Upstream commit 25cf4fbb596d730476afcc0fb87a9d708db14078 ]

x86_32 __arch_{,try_}cmpxchg64_emu()() macros use CALL instruction
inside asm statement. Use ALT_OUTPUT_SP() macro to add required
dependence on %esp register.

Fixes: 79e1dd05d1a2 ("x86: Provide an alternative() based cmpxchg64()")
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241103160954.3329-2-ubizjak@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/cmpxchg_32.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg_32.h b/arch/x86/include/asm/cmpxchg_32.h
index 62cef2113ca74..fd1282a783ddb 100644
--- a/arch/x86/include/asm/cmpxchg_32.h
+++ b/arch/x86/include/asm/cmpxchg_32.h
@@ -94,7 +94,7 @@ static __always_inline bool __try_cmpxchg64_local(volatile u64 *ptr, u64 *oldp,
 	asm volatile(ALTERNATIVE(_lock_loc				\
 				 "call cmpxchg8b_emu",			\
 				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
-		     : "+a" (o.low), "+d" (o.high)			\
+		     : ALT_OUTPUT_SP("+a" (o.low), "+d" (o.high))	\
 		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
 		     : "memory");					\
 									\
@@ -123,8 +123,8 @@ static __always_inline u64 arch_cmpxchg64_local(volatile u64 *ptr, u64 old, u64
 				 "call cmpxchg8b_emu",			\
 				 _lock "cmpxchg8b %a[ptr]", X86_FEATURE_CX8) \
 		     CC_SET(e)						\
-		     : CC_OUT(e) (ret),					\
-		       "+a" (o.low), "+d" (o.high)			\
+		     : ALT_OUTPUT_SP(CC_OUT(e) (ret),			\
+				     "+a" (o.low), "+d" (o.high))	\
 		     : "b" (n.low), "c" (n.high), [ptr] "S" (_ptr)	\
 		     : "memory");					\
 									\
-- 
2.43.0




