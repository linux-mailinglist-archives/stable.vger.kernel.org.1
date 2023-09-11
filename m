Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B97C79B0FD
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238582AbjIKVG3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241005AbjIKO7e (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:59:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8B81B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:59:29 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3700C433C8;
        Mon, 11 Sep 2023 14:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444369;
        bh=G2rzCcmODKJjdC8cS2Hcz+1232Rw5UzLol0vD4l7x9A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2Lq79aVuZfu903a8a7YtgapIhRAThfZtIUU7XGmgVv+GwbX7297ycSZDSdNJRYswF
         sT1qW9WOGnk9TzRkbya2hr8NB2zbG1B3vuJjo8XYYDf0FRLlVV4TbuIy9jX+D9Tw1d
         D/ZEZlcXxq5CUBhd9pW5GcP2kv35IkW/Y9YxIl3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yang Yingliang <yangyingliang@huawei.com>,
        Fabio Estevam <festevam@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.4 676/737] media: nxp: Fix wrong return pointer check in mxc_isi_crossbar_init()
Date:   Mon, 11 Sep 2023 15:48:55 +0200
Message-ID: <20230911134709.421539353@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.286315610@linuxfoundation.org>
References: <20230911134650.286315610@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yang Yingliang <yangyingliang@huawei.com>

commit 4b60db99babad0254129ddc58e0927ffa9e93e35 upstream.

It should check 'xbar->inputs', when allocate memory for it.

Cc: stable@vger.kernel.org
Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
index f7447b2f4d77..9fcfc3925733 100644
--- a/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
+++ b/drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c
@@ -483,7 +483,7 @@ int mxc_isi_crossbar_init(struct mxc_isi_dev *isi)
 
 	xbar->inputs = kcalloc(xbar->num_sinks, sizeof(*xbar->inputs),
 			       GFP_KERNEL);
-	if (!xbar->pads) {
+	if (!xbar->inputs) {
 		ret = -ENOMEM;
 		goto err_free;
 	}
-- 
2.42.0



