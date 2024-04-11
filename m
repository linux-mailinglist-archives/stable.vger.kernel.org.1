Return-Path: <stable+bounces-38399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26C58A0E61
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3BC41C21932
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 390C214600E;
	Thu, 11 Apr 2024 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qDelFw5F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C6145B0E;
	Thu, 11 Apr 2024 10:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712830452; cv=none; b=fJS9PPD+IPiUU6QFEJTYFvsr7WBDbvP+f5vK1RImPm2QuZFpIV0eoyf8hRfuz8ptI6/rW/eI4i7GTWyI+lIZO76IQc0761sa6n8+fBjTIi6chTHBp1vcVvtjN5p149xnlch/Cav8jWhxL/ojNusgRqbRTAAr13+yKGi9hTF58S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712830452; c=relaxed/simple;
	bh=Pe3narQ63IUAgDmTxscRGyZPUAWofvw8t01yqaNi+gI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHu+qQna4v82Narg0ooCk5DZEy81rtnRkzKyxp+Rs7yBJLm3VjvXO9cgM86GO5ubp/Ndnvnuu+KelGY8LG5n3WUKTSEKaZF+UK02+PQ3mrgS+dsLFP0kfDgEZN4fX+Cau7jqNfQg+3NiVKxyAQmeHqX8j4z3CWJVV91GXDSkd1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qDelFw5F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C39DC433F1;
	Thu, 11 Apr 2024 10:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712830451;
	bh=Pe3narQ63IUAgDmTxscRGyZPUAWofvw8t01yqaNi+gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDelFw5FGvzefRR+xmpVj2K+lUC21gDWro0/Z6qpGsMhK9cTXDEMJYkvTSMf7CEmb
	 kzWwjxxSe+J3JvOqptR99D/h6F2HFWT5Cpz94eBKpZWEW+ePmYx5FiAcSPO4Xcsir/
	 lp345zKAqTn1obgI9JkNcwZu01TZdTcFn6xX22Yc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Jun <Jun.Ma2@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.8 143/143] Revert "drm/amd/amdgpu: Fix potential ioremap() memory leaks in amdgpu_device_init()"
Date: Thu, 11 Apr 2024 11:56:51 +0200
Message-ID: <20240411095425.202113942@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>
References: <20240411095420.903937140@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Jun <Jun.Ma2@amd.com>

commit 03c6284df179de3a4a6e0684764b1c71d2a405e2 upstream.

This patch causes the following iounmap erorr and calltrace
iounmap: bad address 00000000d0b3631f

The original patch was unjustified because amdgpu_device_fini_sw() will
always cleanup the rmmio mapping.

This reverts commit eb4f139888f636614dab3bcce97ff61cefc4b3a7.

Signed-off-by: Ma Jun <Jun.Ma2@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |   16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4025,10 +4025,8 @@ int amdgpu_device_init(struct amdgpu_dev
 	 * early on during init and before calling to RREG32.
 	 */
 	adev->reset_domain = amdgpu_reset_create_reset_domain(SINGLE_DEVICE, "amdgpu-reset-dev");
-	if (!adev->reset_domain) {
-		r = -ENOMEM;
-		goto unmap_memory;
-	}
+	if (!adev->reset_domain)
+		return -ENOMEM;
 
 	/* detect hw virtualization here */
 	amdgpu_detect_virtualization(adev);
@@ -4038,20 +4036,20 @@ int amdgpu_device_init(struct amdgpu_dev
 	r = amdgpu_device_get_job_timeout_settings(adev);
 	if (r) {
 		dev_err(adev->dev, "invalid lockup_timeout parameter syntax\n");
-		goto unmap_memory;
+		return r;
 	}
 
 	/* early init functions */
 	r = amdgpu_device_ip_early_init(adev);
 	if (r)
-		goto unmap_memory;
+		return r;
 
 	amdgpu_device_set_mcbp(adev);
 
 	/* Get rid of things like offb */
 	r = drm_aperture_remove_conflicting_pci_framebuffers(adev->pdev, &amdgpu_kms_driver);
 	if (r)
-		goto unmap_memory;
+		return r;
 
 	/* Enable TMZ based on IP_VERSION */
 	amdgpu_gmc_tmz_set(adev);
@@ -4061,7 +4059,7 @@ int amdgpu_device_init(struct amdgpu_dev
 	if (adev->gmc.xgmi.supported) {
 		r = adev->gfxhub.funcs->get_xgmi_info(adev);
 		if (r)
-			goto unmap_memory;
+			return r;
 	}
 
 	/* enable PCIE atomic ops */
@@ -4330,8 +4328,6 @@ release_ras_con:
 failed:
 	amdgpu_vf_error_trans_all(adev);
 
-unmap_memory:
-	iounmap(adev->rmmio);
 	return r;
 }
 



