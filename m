Return-Path: <stable+bounces-163704-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60110B0D9C4
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9460E16B91A
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD6C22E498E;
	Tue, 22 Jul 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PVasgRr8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBBB2E424D
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 12:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187840; cv=none; b=Y/aoQTt6E5IKpWGXfGGGAO/o7+jufszNhxDjkGfNUZYnDI4sVJ2wxYeyfgPygVBBr1EGwgevANkhCs5DzaiJkYfc2M2ThaHsn33ta4oncjrJeXkpjQ728Hxlhn1daj/TZl7HtBLHkMFT5FGZE7pvlhCu9SHV5xWS8UPyyirwc3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187840; c=relaxed/simple;
	bh=i2PnhgO75/OYA2wuekAHHPextS9f7VZCv0ygEiEL850=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bOje5d2/xBQN/WlI6MrzRyjrUj/W+TkOgrWMPNiDRogHbRDQiaWQ2EFCVxhgR5WxJJ/syfARsbmP58FBkywZOM3SXjyeASeQN2rsjcVbggDfkvv05QKL1I3Usadh76zcaSXzkgqfaGSRgEBjtXVTeiUSpRXifV2fixYtP4TYaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PVasgRr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B88C4CEEB;
	Tue, 22 Jul 2025 12:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753187839;
	bh=i2PnhgO75/OYA2wuekAHHPextS9f7VZCv0ygEiEL850=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PVasgRr8ZtS3R+5czge01VA0PS112XkrV3iL1zP7mZ0BxUePBDj291vLBCRRuQXp5
	 Fusi9eVkrDPFK7oUnY96ax+0hsNdFy87RUjvUgCQsGlzypwmZpwYtFowY3cBuaLPXd
	 p0pipKg8k2qgHY4Dn4KmZ6SwiZzKaNOeAQXv3BQO2PZ3XcrTRl87HZcTXekimwDVgD
	 z2PuyV6xfy6/G1nsX2w0ufM3NWgzTjRRKvAA1ah7R/bwvNXx/coT3sezGpRhSOSShD
	 m8eGkZ1SCepT1CQBojq0EmSoLipqcasujhjnXysodlab7ebUxXatabznRF1wXP9cWW
	 6n7aZGM6A/xiw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Balasubramani Vivekanandan <balasubramani.vivekanandan@intel.com>,
	Ravi Kumar Vodapalli <ravi.kumar.vodapalli@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 1/2] drm/xe/mocs: Initialize MOCS index early
Date: Tue, 22 Jul 2025 08:37:12 -0400
Message-Id: <20250722123713.935344-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <2025072101-canola-aspect-c5c7@gregkh>
References: <2025072101-canola-aspect-c5c7@gregkh>
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
index 4bad8894fa12c..ba7a7f275c4d5 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -375,6 +375,8 @@ int xe_gt_init_early(struct xe_gt *gt)
 	if (err)
 		return err;
 
+	xe_mocs_init_early(gt);
+
 	return 0;
 }
 
@@ -592,8 +594,6 @@ int xe_gt_init(struct xe_gt *gt)
 	if (err)
 		return err;
 
-	xe_mocs_init_early(gt);
-
 	err = xe_gt_sysfs_init(gt);
 	if (err)
 		return err;
-- 
2.39.5


