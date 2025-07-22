Return-Path: <stable+bounces-163709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F102B0DA20
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E9747AD598
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98AD2E88A8;
	Tue, 22 Jul 2025 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hoU7J5dF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3EB7DA7F
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188567; cv=none; b=fUOYrLEHBUfiLGxjgP/70joEdYWecD8CDzZW3GCUX7dLjGtGC8KXmieCxh4DZ5zn9VBtyYFasvnGpFYVFRX2zcDkmU3u4D1HZzRhu9ei/7Kt7iUSB6iYuLuCAVZQNJFEFH/v6PKjoIie1tSw/vewdJQgme5kP3JAFLi14BTKECI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188567; c=relaxed/simple;
	bh=/JeUNFWMWGbLjEV5AoUr26eWNyaP8gvVPbr7Ula5B2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZXWsFHntLyKnYdXUVTn4t+qVlwf+k5eb8olkVoL+2MVglr9XWpadXPRIBaOyAR0dAhO3Tt/95ptxol4yRZwbl5Cv1h9R97KgJqkm4z4PC3TiwYe4GIYHhsj1zo7SZIw0qBtwK13IFBdmkLLTt4/AV2jvI25+0wy7PO9mMt6MPFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hoU7J5dF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172F9C4CEF5;
	Tue, 22 Jul 2025 12:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753188567;
	bh=/JeUNFWMWGbLjEV5AoUr26eWNyaP8gvVPbr7Ula5B2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hoU7J5dFSpqtmkmTUp7kJJW4w+H91Ax1PtjohOFyXZ/JYw9Pb+SELAXISzGEpK4Fy
	 /NMmnvEWCLYLckbX4IH6ViXooiNx4dy+pZJvPaXGwaX+OGMf2Ygay4jykBXoaCfnhB
	 JoqsPTBSN+oT2YanG5aNopI1kaVURrFnH5QfZx76fHA1v9LTDvojOlBaF7rcfWvOQR
	 nX+oeC5x/pwUpt9zGfdoK3a9Q0qPqVe8oICqrxqjdiFlo28XJpoYXduUXWHw7gGs55
	 zgz2S2d1PAs5xu6f1oXWXuJD8H1NXsllYRF9ivvLaJaPO74WtppoNBWRWMzRTKsqaz
	 NOjEfWvxQtWDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Stuart Summers <stuart.summers@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/xe: Move page fault init after topology init
Date: Tue, 22 Jul 2025 08:49:18 -0400
Message-Id: <20250722124918.937589-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722124918.937589-1-sashal@kernel.org>
References: <2025072101-drastic-gentile-dc59@gregkh>
 <20250722124918.937589-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matthew Brost <matthew.brost@intel.com>

[ Upstream commit 3155ac89251dcb5e35a3ec2f60a74a6ed22c56fd ]

We need the topology to determine GT page fault queue size, move page
fault init after topology init.

Cc: stable@vger.kernel.org
Fixes: 3338e4f90c14 ("drm/xe: Use topology to determine page fault queue size")
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Reviewed-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Reviewed-by: Stuart Summers <stuart.summers@intel.com>
Link: https://lore.kernel.org/r/20250710191208.1040215-1-matthew.brost@intel.com
(cherry picked from commit beb72acb5b38dbe670d8eb752d1ad7a32f9c4119)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_gt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_gt.c b/drivers/gpu/drm/xe/xe_gt.c
index b3a5083b1c848..da692a7fc8866 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -594,15 +594,15 @@ int xe_gt_init(struct xe_gt *gt)
 		xe_hw_fence_irq_init(&gt->fence_irq[i]);
 	}
 
-	err = xe_gt_pagefault_init(gt);
+	err = xe_gt_sysfs_init(gt);
 	if (err)
 		return err;
 
-	err = xe_gt_sysfs_init(gt);
+	err = gt_fw_domain_init(gt);
 	if (err)
 		return err;
 
-	err = gt_fw_domain_init(gt);
+	err = xe_gt_pagefault_init(gt);
 	if (err)
 		return err;
 
-- 
2.39.5


