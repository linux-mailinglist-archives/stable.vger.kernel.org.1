Return-Path: <stable+bounces-132477-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FC5A88252
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 15:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F3B8189AD51
	for <lists+stable@lfdr.de>; Mon, 14 Apr 2025 13:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4AC0274646;
	Mon, 14 Apr 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YCKABBX5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA21274641;
	Mon, 14 Apr 2025 13:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637225; cv=none; b=pQuOoHPvCgROgxtQPa1/ht/ElRPMqh7/qX8BH600OBhfZfcuOo8KLQ2PCUQVxgvC0iNwPvzTMXCF/4Usd3QBhNqj9rrNEg77Aojh8za7YDM+z4c1s5m2QX1w5iUSJblwyxeVNGlQs9yVTWv0TKiGQQKjR3BkBdm82wWzZGesH9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637225; c=relaxed/simple;
	bh=49YGaSD6SeXvqANPAfCZgo1Q9VCPLjXUjddcErUMfVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rp8s4aVOJMHm+guyyAyqdqKOg8Nj294q2z9bk8/IudpdTyRSDilnZX6TC+RhFsADwYjJ41QNJZEgbE2A/6ONOwih45QeVcarAiAtO8LzXF7CBjMQRsb8WFwc4unMH9c6mymCD5NqAREkw8up6a9l3bozqsky7lpIISZsKmYEDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YCKABBX5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868BAC4CEEC;
	Mon, 14 Apr 2025 13:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637225;
	bh=49YGaSD6SeXvqANPAfCZgo1Q9VCPLjXUjddcErUMfVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YCKABBX5DhRqXnA24oEz9G8E39lLmQ8WN29k70daW5g4fT0RkM1zzQ8S5DaysUmtj
	 tQjFFnJW8Xb3368PClKlMx6QozIdWgrIRQlab8bBqz0cNhZP8G5sk+BqlNw5cdU4nS
	 nMgyAikVR2QNpLYkW/K1Z0tyY7fGoYfMTM9v466eAgOSfn6s+Wurh4Uiw6o7AwU+ji
	 iuXIwkt37rFP2ETnvHiAClh5jXEAUTOXyr4UkrbE8YAqcV5XudiHduE6C/cjXp21hx
	 cBodzpN/5zdCPsLMyCB/YOVQ8kSNHHKXcryNRSC5ra1lo73hDiKiu8b/yPSBn2kzop
	 B5oa5dwU+VuDQ==
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
Subject: [PATCH AUTOSEL 6.14 23/34] x86/bugs: Use SBPB in write_ibpb() if applicable
Date: Mon, 14 Apr 2025 09:25:59 -0400
Message-Id: <20250414132610.677644-23-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
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
index b7ea3e8e9eccd..58e3124ee2b42 100644
--- a/arch/x86/entry/entry.S
+++ b/arch/x86/entry/entry.S
@@ -18,7 +18,7 @@
 
 SYM_FUNC_START(entry_ibpb)
 	movl	$MSR_IA32_PRED_CMD, %ecx
-	movl	$PRED_CMD_IBPB, %eax
+	movl	_ASM_RIP(x86_pred_cmd), %eax
 	xorl	%edx, %edx
 	wrmsr
 
-- 
2.39.5


