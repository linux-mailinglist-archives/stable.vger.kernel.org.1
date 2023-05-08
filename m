Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BA26FA776
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234455AbjEHKap (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:30:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbjEHKak (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:30:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601BED84F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:30:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC177626BA
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:30:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8514C4339B;
        Mon,  8 May 2023 10:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541838;
        bh=I6YvetD1qWttRXEm+8celIczEEwvdQxK3G7osOUiPUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U2kg9T4WP0s35h0ZrWb++ZhKF8PsgwfSFDDYzOG4jSSA77P8qKGYQ1/G3QcYjVCsv
         LUDsl5sisBGNLidHRWf0twJ+QyAWIa2GrdoeasTmmCaHH9NSmC8Uo73dpYYru6a4fy
         vC9DDkn+gUw0FTbbF7/0Ju2K8QILR+0ZLV0tUoHc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Qiang Yu <yuq825@gmail.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 208/663] drm/lima/lima_drv: Add missing unwind goto in lima_pdev_probe()
Date:   Mon,  8 May 2023 11:40:34 +0200
Message-Id: <20230508094435.110788606@linuxfoundation.org>
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

From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

[ Upstream commit c5647cae2704e58d1c4e5fedbf63f11bca6376c9 ]

Smatch reports:
drivers/gpu/drm/lima/lima_drv.c:396 lima_pdev_probe() warn:
	missing unwind goto?

Store return value in err and goto 'err_out0' which has
lima_sched_slab_fini() before returning.

Fixes: a1d2a6339961 ("drm/lima: driver for ARM Mali4xx GPUs")
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Qiang Yu <yuq825@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230314052711.4061652-1-harshit.m.mogalapalli@oracle.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/lima/lima_drv.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
index 7b8d7178d09aa..39cab4a55f572 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -392,8 +392,10 @@ static int lima_pdev_probe(struct platform_device *pdev)
 
 	/* Allocate and initialize the DRM device. */
 	ddev = drm_dev_alloc(&lima_drm_driver, &pdev->dev);
-	if (IS_ERR(ddev))
-		return PTR_ERR(ddev);
+	if (IS_ERR(ddev)) {
+		err = PTR_ERR(ddev);
+		goto err_out0;
+	}
 
 	ddev->dev_private = ldev;
 	ldev->ddev = ddev;
-- 
2.39.2



