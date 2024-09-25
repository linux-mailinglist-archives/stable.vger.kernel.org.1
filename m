Return-Path: <stable+bounces-77408-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAA6985CEA
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 14:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B2241C24160
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 12:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73A41D61B5;
	Wed, 25 Sep 2024 12:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cC+2i+VJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756981D61B3;
	Wed, 25 Sep 2024 12:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265660; cv=none; b=to+PIas2AsN6565ZTjftjMsoVpQkR9rqVyav+JlKvFjX8iWTTMVhv7Ue/CTIPmvXC53tHy/ydQmTfFgcZ5DBy5LiYsiPMWqVa1Ksr9Wy9vbFG6Ucz5dW4A9c9MWW/ai211XfMuiEn6Y1yWHkWyGUdFqTPCi9KupXtgv8LAx+LLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265660; c=relaxed/simple;
	bh=v5BZI/pHtagTFjk+0vh5nJRNaKXYyhr725+mokekLPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3Y/2dR9nwrcXF4AidmzeZwmm92JbBAprfZDLg94kawCD0QwV+xdRNUcxX4xa8VMP+zaKm9DKYecbiiaOSoxd29W1t80eqZrCKJGlh0SAhdCPNh33mlL00E1Bsd1CJr8i2FzAkSTao4FaYmujZX0+SSW1p3aBc/t66ZX/f71BjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cC+2i+VJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC03C4CEC3;
	Wed, 25 Sep 2024 12:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265659;
	bh=v5BZI/pHtagTFjk+0vh5nJRNaKXYyhr725+mokekLPI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cC+2i+VJnLSK1HnFr7b3Q0YlfcQ2sUbmiJ2HVJSg2EvPN4kJx9Md8lJ5bB0wIZUXf
	 dEFAbhqMyF7RQ62sg3diFimB0FCs8NKgRdEtM9PRaYk1ahYlNF0Tbv9Hn9wobJ70BA
	 BOXeOiEhk3S6+KQqzOvEFMSvtrP+eoKlOM9eh98Jp5iNvxDmLKvkp/6yd5kbN5lmOk
	 LX7yjba9PPgFdYFdt6jk6nGkKRg30Z/tiUud2RGFNVFAxFuUiqCZKSffOgtUicKY44
	 lTnU0lweSvR1KJ2UXBx5Oayk9lQOq278J6UY6r8PeXmNrt4WJf8M8V8vGLm2VVOa8A
	 cD8n2Qf9wDIpA==
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
Subject: [PATCH AUTOSEL 6.10 063/197] x86/bugs: Fix handling when SRSO mitigation is disabled
Date: Wed, 25 Sep 2024 07:51:22 -0400
Message-ID: <20240925115823.1303019-63-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
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
index b6f927f6c567e..47c84503ad9be 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -2545,10 +2545,9 @@ static void __init srso_select_mitigation(void)
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
@@ -2579,11 +2578,6 @@ static void __init srso_select_mitigation(void)
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
@@ -2637,6 +2631,8 @@ static void __init srso_select_mitigation(void)
 			pr_err("WARNING: kernel not compiled with MITIGATION_SRSO.\n");
                 }
 		break;
+	default:
+		break;
 	}
 
 out:
-- 
2.43.0


