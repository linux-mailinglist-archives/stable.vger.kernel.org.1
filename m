Return-Path: <stable+bounces-188340-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D3880BF6CE5
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 15:36:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 71BAB19A5219
	for <lists+stable@lfdr.de>; Tue, 21 Oct 2025 13:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA62337BB1;
	Tue, 21 Oct 2025 13:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pX3d2qyk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD84B338925
	for <stable@vger.kernel.org>; Tue, 21 Oct 2025 13:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053671; cv=none; b=Myfo0MFYQWUidUn4DVpq8R89wVJIZYHOnFUqEZ4EpInMR3CFurZA2H/3YPkzR+2IxG7z6/qHK5ezVTUtLue5ha4q6sIVqoJwoP0wYjIuM5pPQMKTHzbbAsL3s6J10nUWeKdPzBOKPT0T0GjzW9f9e2M/hIBCzU0WU36l3SMxsTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053671; c=relaxed/simple;
	bh=Dq7S7LeTi/bpFiyORvfRHefIsZr/phDdAweGVfP75WA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YMa1SZUjyNTEc922WGn2B9QPR5321PVA2EXf94tqOE56tvKFwYZHDYIx1WIh8qhWrqurrZr5z2bPrKgj0kHAx2ic1FUMvEsHKjnVKclY8mComFhXeB2QDLaEfx0/IUjuGOEqat8Z9PB+VL4MWNCjNxh5Vol+X489kIXfKaDennI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pX3d2qyk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7B9C4CEF1;
	Tue, 21 Oct 2025 13:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761053670;
	bh=Dq7S7LeTi/bpFiyORvfRHefIsZr/phDdAweGVfP75WA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pX3d2qykF8gFSV+Zepp7EdCH590K9wFTOwYOUkSvu677C0f7BTDeRcsyA/dzrUAA+
	 ODGVGqk7qBRB0qm+6c1mNNgqx+PvluIsK4B9qkz/dhEyG+xBNWkfrRqOIRucB6a6IF
	 JXQQGG/GhupHX/OR/gMso6mxx3dGLjyBURljwY9M9pV9ykH+zhlUtM69aVmyPxoZqF
	 GNbX/ovtr+EKTvNyI81W3Vgg2+LWyEwj6CMS7rxIOSLvuK6Pjgp1vIo/wLt8+dJ5cM
	 iKZQOF15Bw0KKYeu+eDZK40DvfatczEQ6lKcV2hIcbMEFKPuNJqTUYhbxmPCadYUet
	 TzDTCRccglsYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Piotr=20Pi=C3=B3rkowski?= <piotr.piorkowski@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17.y 1/5] drm/xe: Use devm_ioremap_wc for VRAM mapping and drop manual unmap
Date: Tue, 21 Oct 2025 09:34:23 -0400
Message-ID: <20251021133427.2079917-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102055-prayer-clock-414f@gregkh>
References: <2025102055-prayer-clock-414f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Piotr Piórkowski <piotr.piorkowski@intel.com>

[ Upstream commit 922ae875230be91c7f05f2aa90d176b6693e2601 ]

Let's replace the manual call to ioremap_wc function with devm_ioremap_wc
function, ensuring that VRAM mappings are automatically released when
the driver is detached.
Since devm_ioremap_wc registers the mapping with the device's managed
resources, the explicit iounmap call in vram_fini is no longer needed,
so let's remove it.

Signed-off-by: Piotr Piórkowski <piotr.piorkowski@intel.com>
Suggested-by: Matthew Auld <matthew.auld@intel.com>
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Acked-by: Matthew Brost <matthew.brost@intel.com>
Link: https://lore.kernel.org/r/20250714184818.89201-2-piotr.piorkowski@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Stable-dep-of: d30203739be7 ("drm/xe: Move rebar to be done earlier")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_vram.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index e421a74fb87c6..3a4c84e9efc66 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -156,7 +156,8 @@ static int determine_lmem_bar_size(struct xe_device *xe)
 	xe->mem.vram.dpa_base = 0;
 
 	/* set up a map to the total memory area. */
-	xe->mem.vram.mapping = ioremap_wc(xe->mem.vram.io_start, xe->mem.vram.io_size);
+	xe->mem.vram.mapping = devm_ioremap_wc(&pdev->dev, xe->mem.vram.io_start,
+					       xe->mem.vram.io_size);
 
 	return 0;
 }
@@ -278,9 +279,6 @@ static void vram_fini(void *arg)
 	struct xe_tile *tile;
 	int id;
 
-	if (xe->mem.vram.mapping)
-		iounmap(xe->mem.vram.mapping);
-
 	xe->mem.vram.mapping = NULL;
 
 	for_each_tile(tile, xe, id)
-- 
2.51.0


