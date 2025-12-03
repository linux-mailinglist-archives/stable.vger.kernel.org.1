Return-Path: <stable+bounces-198693-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E176C9FE3D
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 17:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC9F73088BB9
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 16:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC297340A70;
	Wed,  3 Dec 2025 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZLW84r5o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6B23385A8;
	Wed,  3 Dec 2025 15:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764777379; cv=none; b=rtyDeiHwSCi200C2gQozg4G1cVKtsuwmhY4yorsYJK9HRVBlwTZGLGGxRJKqEBiLWIYU1Rcfjd/vcBuoqG2C1sMHWD4EPNS3POrxljlE5Xj0eGdwDCuD/DRcn2ABWJzExcPxmEXaz18D5CdfAMzTErW2djO1ctdH5dbR+bQ6LII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764777379; c=relaxed/simple;
	bh=okIhussHpSyCdVCqcpId7QnmxbswnRW2hrQG5zpphZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dxa6BhAu/UOfQ2ZJt7Rj5EnVwj6LvAEueXKF3E8vnaj5qPv7tnxhqgCZAFKYPA8OyxNqpRp9rJ+9/OfOQclJUNQ1D0kq4n9KZ68GvHP2paSSuOv22UgJqTyp2SvlZWC6wRNpk11OVCnfA+AtCXiNMAGfT5nVxMLLYfvUjVTqMbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZLW84r5o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0640C4CEF5;
	Wed,  3 Dec 2025 15:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764777379;
	bh=okIhussHpSyCdVCqcpId7QnmxbswnRW2hrQG5zpphZg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZLW84r5ouYAxhmS2+8gQryg1BKZTyMxWR/hr1K9O8TpKmrUblCBCgyTK8CF0Pg51t
	 rAyRvq3aYNyCqSM6KRqFegtbom5SwIO7Of1ZThhQTU5QDcLmikM4OK8smwQ26ju7L6
	 MMVjy9MIa87vSLF0Cp1xGK4+uZhtLoUdXFo7y7aM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Kaplan <david.kaplan@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 002/392] x86/bugs: Fix reporting of LFENCE retpoline
Date: Wed,  3 Dec 2025 16:22:32 +0100
Message-ID: <20251203152414.181126749@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251203152414.082328008@linuxfoundation.org>
References: <20251203152414.082328008@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Kaplan <david.kaplan@amd.com>

[ Upstream commit d1cc1baef67ac6c09b74629ca053bf3fb812f7dc ]

The LFENCE retpoline mitigation is not secure but the kernel prints
inconsistent messages about this fact.  The dmesg log says 'Mitigation:
LFENCE', implying the system is mitigated.  But sysfs reports 'Vulnerable:
LFENCE' implying the system (correctly) is not mitigated.

Fix this by printing a consistent 'Vulnerable: LFENCE' string everywhere
when this mitigation is selected.

Signed-off-by: David Kaplan <david.kaplan@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250915134706.3201818-1-david.kaplan@amd.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/kernel/cpu/bugs.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 1628c00145892..8df48691f4910 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1539,7 +1539,7 @@ spectre_v2_user_select_mitigation(void)
 static const char * const spectre_v2_strings[] = {
 	[SPECTRE_V2_NONE]			= "Vulnerable",
 	[SPECTRE_V2_RETPOLINE]			= "Mitigation: Retpolines",
-	[SPECTRE_V2_LFENCE]			= "Mitigation: LFENCE",
+	[SPECTRE_V2_LFENCE]			= "Vulnerable: LFENCE",
 	[SPECTRE_V2_EIBRS]			= "Mitigation: Enhanced / Automatic IBRS",
 	[SPECTRE_V2_EIBRS_LFENCE]		= "Mitigation: Enhanced / Automatic IBRS + LFENCE",
 	[SPECTRE_V2_EIBRS_RETPOLINE]		= "Mitigation: Enhanced / Automatic IBRS + Retpolines",
@@ -3168,9 +3168,6 @@ static const char *spectre_bhi_state(void)
 
 static ssize_t spectre_v2_show_state(char *buf)
 {
-	if (spectre_v2_enabled == SPECTRE_V2_LFENCE)
-		return sysfs_emit(buf, "Vulnerable: LFENCE\n");
-
 	if (spectre_v2_enabled == SPECTRE_V2_EIBRS && unprivileged_ebpf_enabled())
 		return sysfs_emit(buf, "Vulnerable: eIBRS with unprivileged eBPF\n");
 
-- 
2.51.0




