Return-Path: <stable+bounces-163705-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A08AB0D9C5
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 14:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 856E6188C84D
	for <lists+stable@lfdr.de>; Tue, 22 Jul 2025 12:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45A432BF012;
	Tue, 22 Jul 2025 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVoPW/9C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F052E4269
	for <stable@vger.kernel.org>; Tue, 22 Jul 2025 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753187842; cv=none; b=ghZ8+G6fmjccYyE1eN8cKi/f/ZK/tJXNR29HzcRtm8otdsovjP1ZQQsgg4UDuAatUhH8cNCwf70pLo1S66z33aphSIxry7YLCsVq03P3/uVguA2I7cJ4VkU2ytkaTv1MaRAmVtPU0t7m3QS4rbGkd8nhRQ+T72q1THB+hP+ti58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753187842; c=relaxed/simple;
	bh=Zw9G40dfWCMsZtb3T06O/tYwFJAySmyDjvRTVIwYGzE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bY30Ug7Y4q5ZZgkO0iAbI4/BB8e5nAidKV32wuSvTeaD6zhSORDfgdYTLuQvIes6oDrLpq4b/cBLE2p8SsfkHdpbfPInZakp6bBfJ4HrXf9IyWrxJwlCGPaXmaVdtDAyEkJHcRN8bETz2bMaSMxJNfGOqaoq/IU4B2NL3Ojcyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVoPW/9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64EF9C4CEF1;
	Tue, 22 Jul 2025 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753187840;
	bh=Zw9G40dfWCMsZtb3T06O/tYwFJAySmyDjvRTVIwYGzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TVoPW/9CxRbmq5FXpZV+gvCksCTcvhumZZgUGCLT4OTW6RYTPDcvbKFGATKo+vbQX
	 i3SG/P8Ipabr8ww/NRAKJ6b+V9eE5TgIAX8Ga65dy4jh/EUPYDBgmueJB9jAR2XzBo
	 OpPzvXQ1rcZGn5PUBxJAXHg35GjIufhTZQHqysKLfqfIyW8ibJXo7HyvmA1pSPMfTa
	 my89kf9MhfHvfi5MgK2pu3XVAYZYGI6NDsgrQ/Pgjo3D5pA7FpKLKE3U2sN7wRzp8T
	 t5GdUftqsyNToWsMXa+1xodAMzy0h9ym6BBYdiXF8W+6RtctIRvbsQiD1JpLmayFWW
	 rlVCCqWALFFFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Matthew Brost <matthew.brost@intel.com>,
	Jonathan Cavitt <jonathan.cavitt@intel.com>,
	Stuart Summers <stuart.summers@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.15.y 2/2] drm/xe: Move page fault init after topology init
Date: Tue, 22 Jul 2025 08:37:13 -0400
Message-Id: <20250722123713.935344-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250722123713.935344-1-sashal@kernel.org>
References: <2025072101-canola-aspect-c5c7@gregkh>
 <20250722123713.935344-1-sashal@kernel.org>
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
index ba7a7f275c4d5..fb90bc6e4d0ec 100644
--- a/drivers/gpu/drm/xe/xe_gt.c
+++ b/drivers/gpu/drm/xe/xe_gt.c
@@ -590,15 +590,15 @@ int xe_gt_init(struct xe_gt *gt)
 	if (err)
 		return err;
 
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


