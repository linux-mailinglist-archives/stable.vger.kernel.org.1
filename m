Return-Path: <stable+bounces-196741-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F2F0C80DF5
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 14:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D2E3A66EB
	for <lists+stable@lfdr.de>; Mon, 24 Nov 2025 13:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC3530BB87;
	Mon, 24 Nov 2025 13:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eeBiiSvH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD97530B533
	for <stable@vger.kernel.org>; Mon, 24 Nov 2025 13:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763992546; cv=none; b=gsEKKtILwpn4WjJvRIC5wlTe31K9Ot4dBps8ifii1La9oIduXqVXuxH5uFHC7SvYX0fwHi6yn/aJSGF+7PK36fyUCl+6xAv5epTc/OPc1F7t1sJ8SPFT8uZ9Pn8KIQKl0zKQEH8n3ChdTcqZDCOe+WdoTubckHSQymulD5umfqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763992546; c=relaxed/simple;
	bh=S4ICCZLa24jLJcGixO0ow+amXjaAr5CBOC3Z7aHOKyY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LTklzRMTORV/TQc6doRKj+qcwhHSDVrSNBoLKeg5+7ZRsuZ5vQl/8RAVmH9uVXH65UacbGthBZQQCVwRc+HljgFGwq/aNi/TMMKnvavVqHaq/7fBwiVem6nH88Jra32C5slm5tbTA0QksfuzO68xmZVq1TjXdTVDuI3T29eCAUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eeBiiSvH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 095DEC4CEF1;
	Mon, 24 Nov 2025 13:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763992546;
	bh=S4ICCZLa24jLJcGixO0ow+amXjaAr5CBOC3Z7aHOKyY=;
	h=Subject:To:Cc:From:Date:From;
	b=eeBiiSvHXaJ7QZ/MWKqhZnAOt+a62PlLrtfETysBm6G6SpBMQN+w7G77KeutNFLes
	 IYM90mZCDBITNuFx+VBPOcT6ChDv2TYQAdSgNH5vkEWiAc5il2JDX8Ykxqa7BNZGqQ
	 16+5uQMf9KamHb9pkQ1qq8moytearTDne9IX5ric=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Add sriov vf check for VCN per queue reset" failed to apply to 6.12-stable tree
To: shikang.fan@amd.com,alexander.deucher@amd.com,lijo.lazar@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Nov 2025 14:55:35 +0100
Message-ID: <2025112435-nutlike-subsiding-17df@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c156c7f27ecdb7b89dbbeaaa1f40d9fadc3c1680
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112435-nutlike-subsiding-17df@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


