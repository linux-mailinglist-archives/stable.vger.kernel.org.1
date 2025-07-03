Return-Path: <stable+bounces-159486-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4FDAF78E8
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45B8A17DAE1
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFED2EF656;
	Thu,  3 Jul 2025 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O18bDbt/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACFF2EAD1B;
	Thu,  3 Jul 2025 14:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554384; cv=none; b=T9J2PBT2WoeKPr6a+qp2lxklbN8g2Y6F2wlzvjJY03GVIRA1iLckclb3sFV+c7h5BFroyQg43VAjSsz3Wimbr3XdYgWPhlRc+f2QJ2ZzFK/RkpathvQaNl+/LDSZ3C6Hu5vMTSjzKytIoZ2ii3Z5RNDuGsoaqZgQJc+gKdKKLOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554384; c=relaxed/simple;
	bh=5BcUljdeGtahIFt1UsuwPDE2LEQ0j70yhJo3zuB4e+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hplSYRPotoBsdPGrNZ6FwRorzbZVYg2WT4ujDTrbfXewXN7y7c1b9Fxh/h+PHaAwyxfhEIzAOVTMjKAFmgUM+ha3U+M+JMVxkD3FT968T1K/Cxx9pgTRUrHYKnGkSQ+e+eVForI/K9lSEkuMmneqJVR76NIl2divj2IIlJpq6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O18bDbt/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B73C4CEE3;
	Thu,  3 Jul 2025 14:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554383;
	bh=5BcUljdeGtahIFt1UsuwPDE2LEQ0j70yhJo3zuB4e+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O18bDbt/3Awk6va95jzJ6t+FmZaWlwtLzqoelIYMH4p4pVHEU3yP10yPM7AMfH4Nr
	 0EvtGPQLaZZeUSYPKo/Vj9WZuNzdatVka5+s5vNHPzubjzSY/PcLOHITmS5BiafI6p
	 Df5lGFHtNgLIoKLwZD81jSmcpHoazyZEZ1sO1FqY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthew Brost <matthew.brost@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.12 170/218] drm/xe: Fix memset on iomem
Date: Thu,  3 Jul 2025 16:41:58 +0200
Message-ID: <20250703144002.971457681@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
User-Agent: quilt/0.68
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lucas De Marchi <lucas.demarchi@intel.com>

commit 87a15c89d8c7b00b0fc94e0d4f554f7ee2fe6961 upstream.

It should rather use xe_map_memset() as the BO is created with
XE_BO_FLAG_VRAM_IF_DGFX in xe_guc_pc_init().

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Brost <matthew.brost@intel.com>
Link: https://lore.kernel.org/r/20250612-vmap-vaddr-v1-1-26238ed443eb@intel.com
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
(cherry picked from commit 21cf47d89fba353b2d5915ba4718040c4cb955d3)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_guc_pc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/xe/xe_guc_pc.c
+++ b/drivers/gpu/drm/xe/xe_guc_pc.c
@@ -975,7 +975,7 @@ int xe_guc_pc_start(struct xe_guc_pc *pc
 		goto out;
 	}
 
-	memset(pc->bo->vmap.vaddr, 0, size);
+	xe_map_memset(xe, &pc->bo->vmap, 0, 0, size);
 	slpc_shared_data_write(pc, header.size, size);
 
 	ret = pc_action_reset(pc);



