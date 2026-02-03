Return-Path: <stable+bounces-213251-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELyiDqwGgmn2OAMAu9opvQ
	(envelope-from <stable+bounces-213251-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:31:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A9518DA9BE
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 15:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 115A63124B27
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 14:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610433A9604;
	Tue,  3 Feb 2026 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LMNDLoEd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FAB341076
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770128705; cv=none; b=FoG+sMK4sCPRf1LhxD+GXZ/JFCSWJvU/UQIH8v4tJbKW6GsX2WmpU/fFKg+Etq737dMCvSG20BAoZyDBo/rrbYlScpYX5SjcDcUdPUl6T3jdkuXg7I/2k1ubto8LE9uxBTxShGLNulMT/VgNZRmSVgQVoNWYWXfXvFG9NWZZ1VI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770128705; c=relaxed/simple;
	bh=uBfdMjvtqFSpv7JP2snduD1Yu8vBCv9etc0Yf0VVapo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=toFvUtPnzXjXnsVVjXrhWO7jTrroYkrkthPQ/YkuNQEzFBSmZKPV9NJxnSRGlhapLfAy35TzOepwX60gQsIxhMM09pLPZPF+ZsB88vGdXce6I/UtNAHVNxlu4+e17Ljz/SCYUKcxS82VmPoCWhkl4mS/fSf5VnR/Q1a8mkN/c8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LMNDLoEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39953C116D0;
	Tue,  3 Feb 2026 14:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770128704;
	bh=uBfdMjvtqFSpv7JP2snduD1Yu8vBCv9etc0Yf0VVapo=;
	h=Subject:To:Cc:From:Date:From;
	b=LMNDLoEdhP4WwpoJoayVdYKekN+IsiqTOOE5/wxe+u7lepM/ZwYPr2RPal0aqX+iU
	 ekxWKppUtaoOqrQHU5F/CyitLqc0++i11QHk0rQmJJNJYicIxZhVs9a1XCmtwrdbQk
	 QihVXhHxx2tdkMTm+Tw6qthSmEzTUe+yk/wZEplo=
Subject: FAILED: patch "[PATCH] drm/msm/a6xx: fix bogus hwcg register updates" failed to apply to 6.6-stable tree
To: johan@kernel.org,akhilpo@oss.qualcomm.com,andersson@kernel.org,konrad.dybcio@oss.qualcomm.com,konradybcio@kernel.org,robin.clark@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 03 Feb 2026 15:25:01 +0100
Message-ID: <2026020301-scam-headband-6c32@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213251-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gregkh:email,linuxfoundation.org:dkim,patchwork.freedesktop.org:url]
X-Rspamd-Queue-Id: A9518DA9BE
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x dedb897f11c5d7e32c0e0a0eff7cec23a8047167
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026020301-scam-headband-6c32@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From dedb897f11c5d7e32c0e0a0eff7cec23a8047167 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Sun, 21 Dec 2025 17:45:52 +0100
Subject: [PATCH] drm/msm/a6xx: fix bogus hwcg register updates

The hw clock gating register sequence consists of register value pairs
that are written to the GPU during initialisation.

The a690 hwcg sequence has two GMU registers in it that used to amount
to random writes in the GPU mapping, but since commit 188db3d7fe66
("drm/msm/a6xx: Rebase GMU register offsets") they trigger a fault as
the updated offsets now lie outside the mapping. This in turn breaks
boot of machines like the Lenovo ThinkPad X13s.

Note that the updates of these GMU registers is already taken care of
properly since commit 40c297eb245b ("drm/msm/a6xx: Set GMU CGC
properties on a6xx too"), but for some reason these two entries were
left in the table.

Fixes: 5e7665b5e484 ("drm/msm/adreno: Add Adreno A690 support")
Cc: stable@vger.kernel.org	# 6.5
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konradybcio@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Fixes: 188db3d7fe66 ("drm/msm/a6xx: Rebase GMU register offsets")
Patchwork: https://patchwork.freedesktop.org/patch/695778/
Message-ID: <20251221164552.19990-1-johan@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
(cherry picked from commit dcbd2f8280eea2c965453ed8c3c69d6f121e950b)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index ac9a95aab2fb..4c042133261c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -501,8 +501,6 @@ static const struct adreno_reglist a690_hwcg[] = {
 	{REG_A6XX_RBBM_CLOCK_CNTL_GMU_GX, 0x00000222},
 	{REG_A6XX_RBBM_CLOCK_DELAY_GMU_GX, 0x00000111},
 	{REG_A6XX_RBBM_CLOCK_HYST_GMU_GX, 0x00000555},
-	{REG_A6XX_GPU_GMU_AO_GMU_CGC_DELAY_CNTL, 0x10111},
-	{REG_A6XX_GPU_GMU_AO_GMU_CGC_HYST_CNTL, 0x5555},
 	{}
 };
 


