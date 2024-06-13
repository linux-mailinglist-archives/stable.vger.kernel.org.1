Return-Path: <stable+bounces-51150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E773D906E8C
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 14:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063351C22996
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 12:11:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C88144D28;
	Thu, 13 Jun 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hVmQ2A/q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1458982C76;
	Thu, 13 Jun 2024 12:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718280456; cv=none; b=fXDhk1uI0MNI1nStK0j4RZljz4jUZXglXoIOzRUacrJNWLs7Gs0jYZGvPGq8JtVN1e7pO9a4K7gUVxtbm/rmywO6Crvho+/MikuBgaIv04OY5uwUhuFB3bBSDUaTrF/b0AH3GlPuwZ/+KAm98fcCs7EMoeMPTcH2eSo06kFC+Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718280456; c=relaxed/simple;
	bh=gD2qWKbsBbgg7pRl3FVE2LJQsxEdMvSdTbdcsKFD+CU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DOa5D9QBNd8Qu651G9mfBFv+w8oyKvv2ePcwPBCiOp7SSF9S9//0c3T7OJFobAUMjVJzuPfJOjIQ/jMoTMvDdP+cdZ2unYejVy3n2nTHp2p2F8FKhaR4ljVJcZKYsdXN5gGVIciHVISWVyoUHkgSNKEToPa//XfMkp3AZxBo9XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hVmQ2A/q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0F3C2BBFC;
	Thu, 13 Jun 2024 12:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718280455;
	bh=gD2qWKbsBbgg7pRl3FVE2LJQsxEdMvSdTbdcsKFD+CU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hVmQ2A/qtKfnPiX30B0QTn1CIgS3Y+2cgpra7j8hPciLtC4djMvnGJLgxq9hMEhXG
	 hjMHZ//7tr31ozUmRBqmpnDyI++n8BPikg3G02znk33J8lH77YItIXE+TnUQ4UW5V0
	 gjMg14vHSmetY/8OSqKP1wKLK1U58rVESSnhWSVA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Feifei Xu <Feifei.Xu@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Feifei Xu <feifei.xu@amd.com>
Subject: [PATCH 6.6 059/137] Revert "drm/amdkfd: fix gfx_target_version for certain 11.0.3 devices"
Date: Thu, 13 Jun 2024 13:33:59 +0200
Message-ID: <20240613113225.592459227@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240613113223.281378087@linuxfoundation.org>
References: <20240613113223.281378087@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit dd2b75fd9a79bf418e088656822af06fc253dbe3 upstream.

This reverts commit 28ebbb4981cb1fad12e0b1227dbecc88810b1ee8.

Revert this commit as apparently the LLVM code to take advantage of
this never landed.

Reviewed-by: Feifei Xu <Feifei.Xu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Feifei Xu <feifei.xu@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdkfd/kfd_device.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
@@ -402,15 +402,8 @@ struct kfd_dev *kgd2kfd_probe(struct amd
 			f2g = &gfx_v11_kfd2kgd;
 			break;
 		case IP_VERSION(11, 0, 3):
-			if ((adev->pdev->device == 0x7460 &&
-			     adev->pdev->revision == 0x00) ||
-			    (adev->pdev->device == 0x7461 &&
-			     adev->pdev->revision == 0x00))
-				/* Note: Compiler version is 11.0.5 while HW version is 11.0.3 */
-				gfx_target_version = 110005;
-			else
-				/* Note: Compiler version is 11.0.1 while HW version is 11.0.3 */
-				gfx_target_version = 110001;
+			/* Note: Compiler version is 11.0.1 while HW version is 11.0.3 */
+			gfx_target_version = 110001;
 			f2g = &gfx_v11_kfd2kgd;
 			break;
 		default:



