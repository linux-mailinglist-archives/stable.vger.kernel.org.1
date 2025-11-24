Return-Path: <stable+bounces-196742-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF3CC80DE3
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3A504E201A
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA43D30BBBB;
	Mon, 24 Nov 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DDxAV+z6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794503019CD
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992549; cv=none; b=IGgnsDO0wqM/eVpY0xup50SfPd2e4lZM75rXz97HHO61IWPXilmNcD5QRgA/37NFeL23V9VbaKcw6lMcNFSnOPqr+wHDZRZNM42CVQRsaFSn1r7cdc5Byk5Gp8xglsemRZygAxiJAMqMLZ3TXJeugWhfxKU+Sl9pyLFMki+8XrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992549; c=relaxed/simple;
	bh=gmTW5BeCu+c0JsRByalgfxzt2Up+HXEx4ghjgCUR3AU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=e5MpTyCumhG6BHC4sJf2GKtPRNXNVIUnnSUORiHETsai698uzIZC2muEGOiqyi/2fqkXbSR9c4+AQVRIT28BnKUb3P55H3RstaMAnD/A1Dp4FfawaZwUPjVcXUKWWKK2Hw7Le7L1IhApiYMHZdT96XmAkwzcLrGsR2yE9mFRR0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DDxAV+z6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2927C4CEF1;
	Mon, 24 Nov 2025 13:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763992549;
	bh=gmTW5BeCu+c0JsRByalgfxzt2Up+HXEx4ghjgCUR3AU=;
	h=Subject:To:Cc:From:Date:From;
	b=DDxAV+z6iaGc7D3K6j2X9+fwifuFfhTMe5uktdkvAVmfhf5/QuI1PIJB3Pw6kuQTV
	 9nOIWlFN4BgdfEhbpcN7TKrom/scHPsIsx9KHKDxTOUqgtx9gjWVgt6fQNiQ+d0+zG
	 lf3hjLbfscbdkFsm3h03eFgB+Atz1vCVP77W/h+c=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Add sriov vf check for VCN per queue reset" failed to apply to 6.1-stable tree
To: shikang.fan@amd.com,alexander.deucher@amd.com,lijo.lazar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:55:36 +0100
Message-ID: <2025112436-uninsured-scrutiny-e92e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c156c7f27ecdb7b89dbbeaaa1f40d9fadc3c1680
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112436-uninsured-scrutiny-e92e@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c156c7f27ecdb7b89dbbeaaa1f40d9fadc3c1680 Mon Sep 17 00:00:00 2001
From: Shikang Fan <shikang.fan@amd.com>
Date: Wed, 19 Nov 2025 18:05:10 +0800
Subject: [PATCH] drm/amdgpu: Add sriov vf check for VCN per queue reset
 support.

Add SRIOV check when setting VCN ring's supported reset mask.

Signed-off-by: Shikang Fan <shikang.fan@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit ee9b603ad43f9870eb75184f9fb0a84f8c3cc852)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
index eacf4e93ba2f..cb7123ec1a5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c
@@ -141,7 +141,7 @@ static int vcn_v4_0_3_late_init(struct amdgpu_ip_block *ip_block)
 	adev->vcn.supported_reset =
 		amdgpu_get_soft_full_reset_mask(&adev->vcn.inst[0].ring_enc[0]);
 
-	if (amdgpu_dpm_reset_vcn_is_supported(adev))
+	if (amdgpu_dpm_reset_vcn_is_supported(adev) && !amdgpu_sriov_vf(adev))
 		adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
index 714350cabf2f..8bd457dea4cf 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c
@@ -122,7 +122,9 @@ static int vcn_v5_0_1_late_init(struct amdgpu_ip_block *ip_block)
 
 	switch (amdgpu_ip_version(adev, MP0_HWIP, 0)) {
 	case IP_VERSION(13, 0, 12):
-		if ((adev->psp.sos.fw_version >= 0x00450025) && amdgpu_dpm_reset_vcn_is_supported(adev))
+		if ((adev->psp.sos.fw_version >= 0x00450025) &&
+			amdgpu_dpm_reset_vcn_is_supported(adev) &&
+			!amdgpu_sriov_vf(adev))
 			adev->vcn.supported_reset |= AMDGPU_RESET_TYPE_PER_QUEUE;
 		break;
 	default:


