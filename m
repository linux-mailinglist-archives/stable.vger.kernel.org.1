Return-Path: <stable+bounces-132588-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0359AA883A0
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 16:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D8411891D4D
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5501F2D7FDA;
	Mon, 14 Apr 2025 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mp1q4vep"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111B92D7FD4;
	Mon, 14 Apr 2025 13:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637472; cv=none; b=U9MyiaFFg+LesMoLwOhZLJXRyLc6xRa7nh/pY/8XeeNnhU4Gui4R8XPMweCQXvgvGu6AkxBFI5WPz6AdDrBBXsDsV8iJ1lpVyafg+YJO8riUPV1yaVOVMfB+QWRlD/ucaCWltMHyVUOBCfxGAPoGYGY/yl0ytAsfCz51QmiAtqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637472; c=relaxed/simple;
	bh=p1YNscPHnD9q0ry9tfgRP1Fu8zOjJ1pcXTSkJrt5How=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tlzlO3YU8rrxwczvZQa6Uk0JixEnExbBsWi9B73Fu7j0HsJTQarD5lTuTyU3j3A3p1w3yX818dYMULM2YVVbNYYXNeu7JOVCfeyNdumOrcatKrjFHJV/v6NW6a/uNIYwJOBAcBcXWLB7Ua1boIgVcwiRNj+PV3LHES3vZbG+JiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mp1q4vep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D3A7C4CEE9;
	Mon, 14 Apr 2025 13:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637471;
	bh=p1YNscPHnD9q0ry9tfgRP1Fu8zOjJ1pcXTSkJrt5How=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mp1q4vep6LM5A8NXl2DcEnnxzKNChzwSIjBW2VT8vGvxiJqf16RhLW5AgWh0u2KQC
	 +63TzNPw6fsNqDG8Pncc5SO1jJHMrYOeJ1yepN7SpBY0RPc6OB0VkP1oESpw8yAril
	 XhU8Viot67igUuywQ/ByOtYEcHumH1QIwpNZgpClEIy47GgIjl3MamMzq7i7wOphfe
	 6QZ751uatE/8lsvXW/y6Rv31yGYuYE7hCLNLWwBHtrmTcmuyhsriOb5w0+bOFGBmEi
	 eWeBdFvJYMw6Lvsnf47qvmYPw3dgPwZ7eOEHkcYwgitD979cY9/jAG3YByaj/9HInv
	 V6EGfKFY148mw==
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
Subject: [PATCH AUTOSEL 6.1 11/17] x86/bugs: Use SBPB in write_ibpb() if applicable
Date: Mon, 14 Apr 2025 09:30:42 -0400
Message-Id: <20250414133048.680608-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414133048.680608-1-sashal@kernel.org>
References: <20250414133048.680608-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.134
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


