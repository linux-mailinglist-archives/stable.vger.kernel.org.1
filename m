Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D42772810
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 16:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231784AbjHGOnh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 10:43:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbjHGOng (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 10:43:36 -0400
Received: from www.linuxtv.org (www.linuxtv.org [130.149.80.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006B710DC
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:43:35 -0700 (PDT)
Received: from hverkuil by www.linuxtv.org with local (Exim 4.92)
        (envelope-from <hverkuil@linuxtv.org>)
        id 1qT1SI-00CX0P-A5; Mon, 07 Aug 2023 14:43:34 +0000
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:   Mon, 07 Aug 2023 14:43:17 +0000
Subject: [git:media_stage/master] media: nxp: Fix wrong return pointer check in mxc_isi_crossbar_init()
To:     linuxtv-commits@linuxtv.org
Cc:     stable@vger.kernel.org, Yang Yingliang <yangyingliang@huawei.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Fabio Estevam <festevam@gmail.com>
Mail-followup-to: linux-media@vger.kernel.org
Forward-to: linux-media@vger.kernel.org
Reply-to: linux-media@vger.kernel.org
Message-Id: <E1qT1SI-00CX0P-A5@www.linuxtv.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

This is an automatic generated email to let you know that the following patch were queued:

Subject: media: nxp: Fix wrong return pointer check in mxc_isi_crossbar_init()
Author:  Yang Yingliang <yangyingliang@huawei.com>
Date:    Tue Jul 25 21:00:24 2023 +0800

It should check 'xbar->inputs', when allocate memory for it.

Cc: stable@vger.kernel.org
Fixes: cf21f328fcaf ("media: nxp: Add i.MX8 ISI driver")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Reviewed-by: Fabio Estevam <festevam@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>

 drivers/media/platform/nxp/imx8-isi/imx8-isi-crossbar.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

---

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
