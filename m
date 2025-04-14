Return-Path: <stable+bounces-132619-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2D4A883B3
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C2CA7A5FD9
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 14:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 751482DDD08;
	Mon, 14 Apr 2025 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZDdBtWu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 318D52DDD03;
	Mon, 14 Apr 2025 13:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637538; cv=none; b=bJNEtU0UY/q6noKkJiJhR3Le/NX4+WEZ56DaJlTqFguKEkcFpRfV2f5+3iMW1VzuE4ba8cgPXJ80r7KHC17Sp4tGJgFVQhYsOsokZCSF3nibHzc1TId1jJGfGtsazqakpIUzuKVTKcVwEjjsQPkvxzu0D22YNKtu886kaJDiX2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637538; c=relaxed/simple;
	bh=p1YNscPHnD9q0ry9tfgRP1Fu8zOjJ1pcXTSkJrt5How=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zjvftr02p6WLydN277AiH3qXMJjoPCl0mNS6dCPAufBizAxwZVZ5QNZ1JRAPO3nYX7NTBKPjq8Xr/Sc+L6TBnbVaEHPjmoDQ9/5piVN9oKdm5sA94GtzK7TjU/5N+xfV0L+cp7HmlOA0yg20pjfJQ2b0mLasgDnC9WkDJMH0WPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZDdBtWu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853C1C4CEE2;
	Mon, 14 Apr 2025 13:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637538;
	bh=p1YNscPHnD9q0ry9tfgRP1Fu8zOjJ1pcXTSkJrt5How=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DZDdBtWuIQ6eqjfxVsyWlW2JzXiiC+NAdO1ZEewYTK3qhew4x89eIZRy+LA+QKpMy
	 BNUp9u4JVsi/3H91bNnoN6lJLxvt87M00cBX83zoW2Y1c8sOW59zQ6TCxsMUEAlv6v
	 OQ0987TbGRXdGD98kO3RjnRLpInNKwK1LfbJhvcaDbMSISR5abGyuPd9GXPVZ8gMz8
	 WgbhFuoz353aYtmSXNsXIvjyCPZWfIn0vj2BYE/hwysGDYCGBJMQGM3KKcbEhldD05
	 Qhu6bHSZiYo08ZGbmlXL7GLFkCfAlk/YSfOue7r0SnbesbbJsb/hW1LqVQKiI5jw4T
	 MvROL6OprnVoQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	luto@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 5.10 09/11] x86/bugs: Use SBPB in write_ibpb() if applicable
Date: Mon, 14 Apr 2025 09:31:56 -0400
Message-Id: <20250414133158.681045-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133158.681045-1-sashal@kernel.org>
References: <20250414133158.681045-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.236
Content-Transfer-Encoding: 8bit

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit fc9fd3f98423367c79e0bd85a9515df26dc1b3cc ]

write_ibpb() does IBPB, which (among other things) flushes branch type
predictions on AMD.  If the CPU has SRSO_NO, or if the SRSO mitigation
has been disabled, branch type flushing isn't needed, in which case the
lighter-weight SBPB can be used.

The 'x86_pred_cmd' variable already keeps track of whether IBPB or SBPB
should be used.  Use that instead of hardcoding IBPB.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/17c5dcd14b29199b75199d67ff7758de9d9a4928.1744148254.git.jpoimboe@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/entry/entry.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/entry.S b/arch/x86/entry/entry.S
index f4419afc7147d..bda217961172b 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -16,7 +16,7 @@
 
 SYM_FUNC_START(entry_ibpb)
 	movl	$MSR_IA32_PRED_CMD, %ecx
-	movl	$PRED_CMD_IBPB, %eax
+	movl	_ASM_RIP(x86_pred_cmd), %eax
 	xorl	%edx, %edx
 	wrmsr
 
-- 
2.39.5


