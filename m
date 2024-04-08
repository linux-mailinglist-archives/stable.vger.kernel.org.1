Return-Path: <stable+bounces-36613-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD3F89C0B1
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 15:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6177E1F226F8
	for <lists+stable@lfdr.de>; Mon,  8 Apr 2024 13:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FFC7CF17;
	Mon,  8 Apr 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Hby+mHx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3277C0BE;
	Mon,  8 Apr 2024 13:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712581838; cv=none; b=V//uSL73Ey92/RH+RhFY+rfXqUwjgQve7BO1vX5jIpPCPRq/NK3uYivOVLdg2qlFFcXVqcqZC9D47aYCX+35k4GWEA981Yye/VqpNz9LiUl2qm0d3B7m0tAHcoLmBXMGykHmANZ1Sfrart9ts1tSnTHhgiMKHcaK+mgJ28biar8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712581838; c=relaxed/simple;
	bh=WSDB9ym0v8BnIXPsMY1CU7QzZKVVht3vd2V80oB5n4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGtk+UqMaIbJ5lJasKglUVLA0LdtMRNPPAyNUlb9JdWjy5+LyWXIWGTMvvxSfA+gLwpV+xJEGsmYo+kSPrXWBCtImGBhd1uBIfxQMyZ9ZTVGg6C+GWxZGiGTnPAbplZeQ/8eo5KuJ6aXg2b5VfVub0yRAKxXy3AiCBi++XAqjpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Hby+mHx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C062FC433A6;
	Mon,  8 Apr 2024 13:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712581838;
	bh=WSDB9ym0v8BnIXPsMY1CU7QzZKVVht3vd2V80oB5n4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2Hby+mHxZh4DpMDX3Yah6/s2y21l40JIq4WjvZcjg+BAHKs8JdgU9FicVaPGUQBGc
	 fc/B2esXaT6YT6GYzC0H29Hba5m67mVsVUJQrzKB4bLpY16Wq2SCPk14Z5oFKHoQ8R
	 nMGB+13+b3LJGyb5zo2J9QCdNDX3nOIXABkZSatM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Auld <matthew.auld@intel.com>,
	Nirmoy Das <nirmoy.das@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 024/273] drm/xe/device: fix XE_MAX_TILES_PER_DEVICE check
Date: Mon,  8 Apr 2024 14:54:59 +0200
Message-ID: <20240408125310.043345419@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408125309.280181634@linuxfoundation.org>
References: <20240408125309.280181634@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Auld <matthew.auld@intel.com>

[ Upstream commit b45f20fa69cedb6038fdaec31bd600c273c865a5 ]

Here XE_MAX_TILES_PER_DEVICE is the gt array size, therefore the gt
index should always be less than.

v2 (Lucas):
  - Add fixes tag.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240318180532.57522-6-matthew.auld@intel.com
(cherry picked from commit a96cd71ec7be0790f9fc4039ad21be8d214b03a4)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_device.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
index ee8be4c6b59b1..bf8efb44edf60 100644
--- a/drivers/gpu/drm/xe/xe_device.h
+++ b/drivers/gpu/drm/xe/xe_device.h
@@ -79,7 +79,7 @@ static inline struct xe_gt *xe_device_get_gt(struct xe_device *xe, u8 gt_id)
 	if (MEDIA_VER(xe) >= 13) {
 		gt = xe_tile_get_gt(root_tile, gt_id);
 	} else {
-		if (drm_WARN_ON(&xe->drm, gt_id > XE_MAX_TILES_PER_DEVICE))
+		if (drm_WARN_ON(&xe->drm, gt_id >= XE_MAX_TILES_PER_DEVICE))
 			gt_id = 0;
 
 		gt = xe->tiles[gt_id].primary_gt;
-- 
2.43.0




