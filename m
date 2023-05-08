Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17B626FA789
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbjEHKbr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234722AbjEHKbX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:31:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B6225267
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:31:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1B6F626E4
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:31:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA99CC433EF;
        Mon,  8 May 2023 10:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541874;
        bh=oJGSdN700irTBfOAhWe/HAnxt0W7uX5X0mBBazGBAQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yB/cy4v3QOY0VpPDHquHldpbRVYKVBwUbSYzTjlAl+DsZnBemROKNIOXwHA9sxqyt
         h8Jk+0l2ogICmbXy77oxE9+P32ro66UHRHtKDUF7JLlURvQiiLapJjlatVmu3aCt7o
         voISOyP48pqVx2WgMP291j8lDh3iJQdr+IqRY4+8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Moudy Ho <moudy.ho@mediatek.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 255/663] media: platform: mtk-mdp3: fix potential frame size overflow in mdp_try_fmt_mplane()
Date:   Mon,  8 May 2023 11:41:21 +0200
Message-Id: <20230508094436.533119983@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Moudy Ho <moudy.ho@mediatek.com>

[ Upstream commit 4168720753ce6c14c5d3a35302fc2e1841383443 ]

Fix overflow risk when setting certain formats whose frame size exceeds
a RGB24 with 7723x7723 resolution.

For example, a 7723x7724 RGB24 frame:
    1. bpl (byte per line) = 7723 * 3.
    2. Overflow occurs when bpl * 7724 * depth.

Fixes: 61890ccaefaf ("media: platform: mtk-mdp3: add MediaTek MDP3 driver")
Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
index 4e84a37ecdfc1..36336d169bd91 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-regs.c
@@ -4,6 +4,7 @@
  * Author: Ping-Hsun Wu <ping-hsun.wu@mediatek.com>
  */
 
+#include <linux/math64.h>
 #include <media/v4l2-common.h>
 #include <media/videobuf2-v4l2.h>
 #include <media/videobuf2-dma-contig.h>
@@ -428,14 +429,15 @@ const struct mdp_format *mdp_try_fmt_mplane(struct v4l2_format *f,
 		u32 bpl = pix_mp->plane_fmt[i].bytesperline;
 		u32 min_si, max_si;
 		u32 si = pix_mp->plane_fmt[i].sizeimage;
+		u64 di;
 
 		bpl = clamp(bpl, min_bpl, max_bpl);
 		pix_mp->plane_fmt[i].bytesperline = bpl;
 
-		min_si = (bpl * pix_mp->height * fmt->depth[i]) /
-			 fmt->row_depth[i];
-		max_si = (bpl * s.max_height * fmt->depth[i]) /
-			 fmt->row_depth[i];
+		di = (u64)bpl * pix_mp->height * fmt->depth[i];
+		min_si = (u32)div_u64(di, fmt->row_depth[i]);
+		di = (u64)bpl * s.max_height * fmt->depth[i];
+		max_si = (u32)div_u64(di, fmt->row_depth[i]);
 
 		si = clamp(si, min_si, max_si);
 		pix_mp->plane_fmt[i].sizeimage = si;
-- 
2.39.2



