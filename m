Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5106FA7A6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbjEHKdc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbjEHKdK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:33:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F712786E
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:32:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A6B6C626E5
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:32:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA352C433D2;
        Mon,  8 May 2023 10:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541926;
        bh=zg/FSjekkU4algjXcqm//2iYeTCGAsgTynUgScWizjU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWHmUcBvribAzOaLdIOYj/EhNH371ljm0rKN5+W2BrdNchDf2xKXuHCFZx6bHm8+G
         pkRQATMIO4DTP51XNGvqS1otQg5pUlJS2p00UDfKNNTFXZLRxTXDUY21EI4IhyAyDZ
         JCl/7qzmpZEMbSOekimUosLttI20M3X8rMD2/Q2U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zheng Wang <zyytlz.wz@163.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 244/663] media: cedrus: fix use after free bug in cedrus_remove due to race condition
Date:   Mon,  8 May 2023 11:41:10 +0200
Message-Id: <20230508094436.193146512@linuxfoundation.org>
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

From: Zheng Wang <zyytlz.wz@163.com>

[ Upstream commit 50d0a7aea4809cef87979d4669911276aa23b71f ]

In cedrus_probe, dev->watchdog_work is bound with cedrus_watchdog function.
In cedrus_device_run, it will started by schedule_delayed_work. If there is
an unfinished work in cedrus_remove, there may be a race condition and
trigger UAF bug.

CPU0                  CPU1

                    |cedrus_watchdog
cedrus_remove       |
  v4l2_m2m_release  |
  kfree(m2m_dev)    |
                    |
                    | v4l2_m2m_get_curr_priv
                    |   m2m_dev //use

Fix it by canceling the worker in cedrus_remove.

Fixes: 7c38a551bda1 ("media: cedrus: Add watchdog for job completion")
Signed-off-by: Zheng Wang <zyytlz.wz@163.com>
Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/media/sunxi/cedrus/cedrus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
index a43d5ff667163..a50a4d0a8f715 100644
--- a/drivers/staging/media/sunxi/cedrus/cedrus.c
+++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
@@ -547,6 +547,7 @@ static int cedrus_remove(struct platform_device *pdev)
 {
 	struct cedrus_dev *dev = platform_get_drvdata(pdev);
 
+	cancel_delayed_work_sync(&dev->watchdog_work);
 	if (media_devnode_is_registered(dev->mdev.devnode)) {
 		media_device_unregister(&dev->mdev);
 		v4l2_m2m_unregister_media_controller(dev->m2m_dev);
-- 
2.39.2



