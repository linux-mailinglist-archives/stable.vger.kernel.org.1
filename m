Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D12703B13
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242528AbjEOR7L (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244202AbjEOR6n (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:58:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB48E18994
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:56:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 561FB62FD0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:55:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469FFC433D2;
        Mon, 15 May 2023 17:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173305;
        bh=ixhXjcUVw55FqI6hOXHTTexbt1hc3sptsu/8l88U1gg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LpyjH6J01JV68+Eh5j+eK1WEtXs7m0e8EgmYmgySEtEejR4UVIVjV2WIgPL1q313s
         wjhwOdGexuEr0UZ38IX3Kg+A8kd5QJs81X+uY2rpDgrucM2pXKyHOmPug7k24D74RG
         5tVdA1J7iQ9XXAxKaCK6CL5MDKNZ/UlH5/w76ETs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Qiang Yu <yuq825@gmail.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 052/282] drm/lima/lima_drv: Add missing unwind goto in lima_pdev_probe()
Date:   Mon, 15 May 2023 18:27:10 +0200
Message-Id: <20230515161723.813600910@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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
index 75ec703d22e03..89513c7c50d55 100644
--- a/drivers/gpu/drm/lima/lima_drv.c
+++ b/drivers/gpu/drm/lima/lima_drv.c
@@ -300,8 +300,10 @@ static int lima_pdev_probe(struct platform_device *pdev)
 
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



