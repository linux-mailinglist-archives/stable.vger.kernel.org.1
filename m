Return-Path: <stable+bounces-163708-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D97B0DA1E
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D22CAA5299
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAC9288528;
	Tue, 22 Jul 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Chy8gl8v"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE8228C2AA
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188566; cv=none; b=EToczSj7c8ZcGp4WnWW0VDyq5tlSfnV6UTtRLj+xJsl8Lttk1+TJjZ4nMfZ6D/DTXIF6YHuCLD0up2Q5xKBszVjYGXSG44ayLHsMcg10dSJO9WPtooCoHB5DFcoPrnh58Xez2lekb18uOsxc5CBcomaVMjl4oA6kX3WICYeTu94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188566; c=relaxed/simple;
	bh=3x+yQ5gBN0T6oK+ZYlpFyK/H8LSN+Mc3j3M0fhVQ7QU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XawZG2SlPr0EVHjFn7EcmsqPZ6PqRaVV9Z9INVAetF3XRNel4IMhUzIBz2d8jyZGsq5CzWt407KnUwxxJE2ervqrhxBVngcze/ciE3neeyWj+zLHO4w5oUVfLWGRZBLLBYpPX7VKqzAwu20rAXpnXx442QkP1P542og/1K1cx1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Chy8gl8v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EA8C4CEEB;
	Tue, 22 Jul 2025 12:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753188565;
	bh=3x+yQ5gBN0T6oK+ZYlpFyK/H8LSN+Mc3j3M0fhVQ7QU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Chy8gl8vu+txIisbsjejLiPKfF1TMnb8pltus0v4bGuQqdLM8G9bdUsMFRswSwfvR
	 0VprpOwMZ0wxpU91NJrSQyOmD8sDqpSmoIAkxZJTqGs+KLd3I+jGI73wegp88mlZah
	 0bLDb/2osgM/G1KnS3COOKIp2hT0sfqLW1anoqfAmJGKmPRsBWt+R9bHCYHz3hzFQa
	 erj1ELL2//G/V4JSdLvhR/CPq2FXOIsVsciWO7pxm8wTdnvKz/xSnIdMbL/5/PpZbO
	 xw/Ngc5aTAVCcW98dXAgrfUF8c/UwgnycVKkw5ShDe06r81LtRSC2tJr6qE7yVxsmG
	 4pr7gKr6pBdBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
	Ravi Kumar Vodapalli <ravi.kumar.vodapalli@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/xe/mocs: Initialize MOCS index early
Date: Tue, 22 Jul 2025 08:49:17 -0400
Message-Id: <20250722124918.937589-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072101-drastic-gentile-dc59@gregkh>
References: <2025072101-drastic-gentile-dc59@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>

[ Upstream commit 2a58b21adee3df10ca6f4491af965c4890d2d8e3 ]

MOCS uc_index is used even before it is initialized in the following
callstack
    guc_prepare_xfer()
    __xe_guc_upload()
    xe_guc_min_load_for_hwconfig()
    xe_uc_init_hwconfig()
    xe_gt_init_hwconfig()

Do MOCS index initialization earlier in the device probe.

Signed-off-by: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>
Reviewed-by: Ravi Kumar Vodapalli <ravi.kumar.vodapalli@intel.com>
Link: https://lore.kernel.org/r/20250520142445.2792824-1-balasubramani.vivekanandan@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
(cherry picked from commit 241cc827c0987d7173714fc5a95a7c8fc9bf15c0)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Stable-dep-of: 3155ac89251d ("drm/xe: Move page fault init after topology init")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index 231ed53cf907c..b3a5083b1c848 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -389,6 +389,8 @@ int xe_gt_init_early(struct xe_gt *gt)
 	if (err)
 		return err;
 
+	xe_mocs_init_early(gt);
+
 	return 0;
 }
 
@@ -596,8 +598,6 @@ int xe_gt_init(struct xe_gt *gt)
 	if (err)
 		return err;
 
-	xe_mocs_init_early(gt);
-
 	err = xe_gt_sysfs_init(gt);
 	if (err)
 		return err;
-- 
2.39.5


