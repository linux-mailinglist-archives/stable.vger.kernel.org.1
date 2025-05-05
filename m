Return-Path: <stable+bounces-140611-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A3AAAA30
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 03:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEF5A3BDCF2
	for <lists+stable@lfdr.de>; Tue,  6 May 2025 01:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66A137C732;
	Mon,  5 May 2025 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiSv/zCH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490C02C0329;
	Mon,  5 May 2025 22:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485346; cv=none; b=cXXUkIcfQYOS0HxzzHWchBwN0HVoHB22LvfZ8HSfwJ7qlS6y5TZw4O7oO8CtrN36xyVVhFse8Uv0V8q9cjLZL8/vQLvevikVhlSRSdWkOE2REnum4hrFF62XUO9BIzBZBbmU9VtCFAJtj9BxgsVP115dxB+kiy8HFuKaLqCPxuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485346; c=relaxed/simple;
	bh=6OcSanAB1MDnq10VVZ/IraBnmb8NqcMQqhsFA04BXu0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AQnjfv2zbJcw8IPGbE7AAD9oTs3+ji9sQ9UdC0+fzf0e7gurH8K1QFzea6UpQKW70RZP1Tu0PPhcKOhN6A3hjazf/K/jHxDdGoRQX1q3p3aBdhJYl4aDcHtTW3gcasQf7X8yuwHxps1aGtcQlz88VHPxjVlgxbltUhymjdFfCrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiSv/zCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A6AAC4CEEE;
	Mon,  5 May 2025 22:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485345;
	bh=6OcSanAB1MDnq10VVZ/IraBnmb8NqcMQqhsFA04BXu0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qiSv/zCHb6zrQCLwe5ShQ5oG0O2UNc5Uob4gKfK3lPULRfwS/9e9ajooAoaEMoQYz
	 sJLduKdAhvkU+40faw8V1dNvqBYJXDY32MXG3cYmBeg9fAi3wIZp3Bo8dwejY3qp8R
	 NcYV7erR2Fw3vua1UGWUenv8UwnVVyrs95TlraYrURmBi2dQT4/83ixDisIqgGyFW3
	 e75oXkUgGKIPvKVbk+zBgE740WhzdAsBCdUESJwpRq5GCIRVr7iTXsOULdgPAR7hO+
	 E5hFnqy2UfI+1BdS8lpwI28BaiKUNtyL3elhJpK5mQmWM5Ru9R6FDLMR5MyootzEc8
	 CK5atFrh9CEug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>,
	dennis@kernel.org,
	tj@kernel.org,
	cl@linux.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-mm@kvack.org
Subject: [PATCH AUTOSEL 6.12 278/486] x86/locking: Use ALT_OUTPUT_SP() for percpu_{,try_}cmpxchg{64,128}_op()
Date: Mon,  5 May 2025 18:35:54 -0400
Message-Id: <20250505223922.2682012-278-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Uros Bizjak <ubizjak@gmail.com>

[ Upstream commit 4087e16b033140cf2ce509ec23503bddec818a16 ]

percpu_{,try_}cmpxchg{64,128}() macros use CALL instruction inside
asm statement in one of their alternatives. Use ALT_OUTPUT_SP()
macro to add required dependence on %esp register.

ALT_OUTPUT_SP() implements the above dependence by adding
ASM_CALL_CONSTRAINT to its arguments. This constraint should be used
for any inline asm which has a CALL instruction, otherwise the
compiler may schedule the asm before the frame pointer gets set up
by the containing function, causing objtool to print a "call without
frame pointer save/setup" warning.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250214150929.5780-1-ubizjak@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/include/asm/percpu.h | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/percpu.h b/arch/x86/include/asm/percpu.h
index c55a79d5feaeb..2d9c250b3c8d8 100644
--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -349,9 +349,9 @@ do {									\
 									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
-		  : [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
+				  "+a" (old__.low),			\
+				  "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -380,10 +380,10 @@ do {									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg8b_emu",		\
 			      "cmpxchg8b " __percpu_arg([var]), X86_FEATURE_CX8) \
 		  CC_SET(z)						\
-		  : CC_OUT(z) (success),				\
-		    [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+				  [var] "+m" (__my_cpu_var(_var)),	\
+				  "+a" (old__.low),			\
+				  "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -420,9 +420,9 @@ do {									\
 									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
-		  : [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP([var] "+m" (__my_cpu_var(_var)),	\
+				  "+a" (old__.low),			\
+				  "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
@@ -451,10 +451,10 @@ do {									\
 	asm qual (ALTERNATIVE("call this_cpu_cmpxchg16b_emu",		\
 			      "cmpxchg16b " __percpu_arg([var]), X86_FEATURE_CX16) \
 		  CC_SET(z)						\
-		  : CC_OUT(z) (success),				\
-		    [var] "+m" (__my_cpu_var(_var)),			\
-		    "+a" (old__.low),					\
-		    "+d" (old__.high)					\
+		  : ALT_OUTPUT_SP(CC_OUT(z) (success),			\
+				  [var] "+m" (__my_cpu_var(_var)),	\
+				  "+a" (old__.low),			\
+				  "+d" (old__.high))			\
 		  : "b" (new__.low),					\
 		    "c" (new__.high),					\
 		    "S" (&(_var))					\
-- 
2.39.5


