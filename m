Return-Path: <stable+bounces-77176-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BDA29859A7
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41FF81F24990
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 11:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE4061ABED1;
	Wed, 25 Sep 2024 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OyFq9QzZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1EB1ABEC8;
	Wed, 25 Sep 2024 11:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264388; cv=none; b=hZzuJMNwgc5SYBz5JkTvtOPZ2vviy3h8Hj6ZROSLbLea8p3adbiBL/D219J0j5btfLnUdgZC/J/zJyX/TR+Yo7fEG+qNrtO7Ig0AsJyo4EF8OPZ3kyOG3Yx8n/GQm5+iJpr4zO43t54XLXHQ7wrmBMtPrh+NKnsv1UHvo2dMxx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264388; c=relaxed/simple;
	bh=aNVXV+8C6m0unYaJWVK7x8OCaQfkDGtP7RJ46VdKT4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A2Z2H4cL44JvHyXAWQ3ZF75XOYhtGukybCp8pE50kSBO2bB0QRNdqz8tF8mraRPwBcgEdo4+q6GCjEAdaUahjeIdMvX+ZbKNZ4+v7NlbWV1k3LSym1HAwThCNwBf74hTl0EV09wtTQqUAeC+/YcEaVhXA+OEfKZk7/pS/xX6xYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OyFq9QzZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE918C4CEC3;
	Wed, 25 Sep 2024 11:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727264388;
	bh=aNVXV+8C6m0unYaJWVK7x8OCaQfkDGtP7RJ46VdKT4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OyFq9QzZPNazJQvvXOiSwK0L2YWqA9srR8t2oaa/V/JSxRl0UoFlL/TQf6zoiq7Pr
	 Os3cdsVw1ajeb7Z6HPs0N2v3y5OsKc+OxP5Pqx5R0fDXck1doiqoUy2G44EuNfFvn/
	 NoeNn2SJLsZOO4Zyu09M/G7HOCTXrkOKfPT1mOhzOF3vi1GcoUtVLmVQ1RLF35SFNk
	 jXPWNApccVd03zRaCNk5WqsQw+6dXhdGwXjdxEDkcsdfwvVJDWH4Isw9WY/jFEB543
	 9OA+Cj3QVzon0CzzjTUYbET1I6lnGGIAB43WS+HmOn8+qRzikPh5pDhljbg/sin7SB
	 HHgbaw/ghOK0g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Kaplan <david.kaplan@amd.com>,
	Borislav Petkov <bp@alien8.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	tglx@linutronix.de,
	peterz@infradead.org,
	mingo@redhat.com,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Subject: [PATCH AUTOSEL 6.11 078/244] x86/bugs: Fix handling when SRSO mitigation is disabled
Date: Wed, 25 Sep 2024 07:24:59 -0400
Message-ID: <20240925113641.1297102-78-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: David Kaplan <david.kaplan@amd.com>

[ Upstream commit 1dbb6b1495d472806fef1f4c94f5b3e4c89a3c1d ]

When the SRSO mitigation is disabled, either via mitigations=off or
spec_rstack_overflow=off, the warning about the lack of IBPB-enhancing
microcode is printed anyway.

This is unnecessary since the user has turned off the mitigation.

  [ bp: Massage, drop SBPB rationale as it doesn't matter because when
    mitigations are disabled x86_pred_cmd is not being used anyway. ]

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20240904150711.193022-1-david.kaplan@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 45675da354f33..468449f73a957 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2551,10 +2551,9 @@ static void __init srso_select_mitigation(void)
 {
 	bool has_microcode = boot_cpu_has(X86_FEATURE_IBPB_BRTYPE);
 
-	if (cpu_mitigations_off())
-		return;
-
-	if (!boot_cpu_has_bug(X86_BUG_SRSO)) {
+	if (!boot_cpu_has_bug(X86_BUG_SRSO) ||
+	    cpu_mitigations_off() ||
+	    srso_cmd == SRSO_CMD_OFF) {
 		if (boot_cpu_has(X86_FEATURE_SBPB))
 			x86_pred_cmd = PRED_CMD_SBPB;
 		return;
@@ -2585,11 +2584,6 @@ static void __init srso_select_mitigation(void)
 	}
 
 	switch (srso_cmd) {
-	case SRSO_CMD_OFF:
-		if (boot_cpu_has(X86_FEATURE_SBPB))
-			x86_pred_cmd = PRED_CMD_SBPB;
-		return;
-
 	case SRSO_CMD_MICROCODE:
 		if (has_microcode) {
 			srso_mitigation = SRSO_MITIGATION_MICROCODE;
@@ -2643,6 +2637,8 @@ static void __init srso_select_mitigation(void)
 			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
                 }
 		break;
+	default:
+		break;
 	}
 
 out:
-- 
2.43.0


