Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F08AC6FA795
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjEHKch (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjEHKcE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:32:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A3726764
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:31:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9051626E8
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:31:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A3DC433D2;
        Mon,  8 May 2023 10:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683541895;
        bh=/PxnHSArEIzcdqlsIpz5kh7HkrZk3vIOP5r85rtzA68=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B5Vr5Y/qdDqe5kpFytKy2FCKlfbmrEBOFhZoW6U6JKi5oTJvoy+45KIhSh22Uun2y
         8DqBM8IgVtNi7W7/y3ogWDu+YLWxp/GyO8gjOabP2qMKP5t4W+/OFNRWGSWhEqfP4P
         xBbUUtBkOUk1UsS4H3Nf0cnguS6ika3EzxS1b+c0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Chen <harperchen1110@gmail.com>,
        Martin Kepplinger <martin.kepplinger@puri.sm>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 261/663] media: hi846: Fix memleak in hi846_init_controls()
Date:   Mon,  8 May 2023 11:41:27 +0200
Message-Id: <20230508094436.713263439@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Wei Chen <harperchen1110@gmail.com>

[ Upstream commit 2649c1a20e8e399ee955d0e22192f9992662c3d2 ]

hi846_init_controls doesn't clean the allocated ctrl_hdlr
in case there is a failure, which causes memleak. Add
v4l2_ctrl_handler_free to free the resource properly.

Fixes: e8c0882685f9 ("media: i2c: add driver for the SK Hynix Hi-846 8M pixel camera")
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Reviewed-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/i2c/hi846.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/media/i2c/hi846.c b/drivers/media/i2c/hi846.c
index 7c61873b71981..306dc35e925fd 100644
--- a/drivers/media/i2c/hi846.c
+++ b/drivers/media/i2c/hi846.c
@@ -1472,21 +1472,26 @@ static int hi846_init_controls(struct hi846 *hi846)
 	if (ctrl_hdlr->error) {
 		dev_err(&client->dev, "v4l ctrl handler error: %d\n",
 			ctrl_hdlr->error);
-		return ctrl_hdlr->error;
+		ret = ctrl_hdlr->error;
+		goto error;
 	}
 
 	ret = v4l2_fwnode_device_parse(&client->dev, &props);
 	if (ret)
-		return ret;
+		goto error;
 
 	ret = v4l2_ctrl_new_fwnode_properties(ctrl_hdlr, &hi846_ctrl_ops,
 					      &props);
 	if (ret)
-		return ret;
+		goto error;
 
 	hi846->sd.ctrl_handler = ctrl_hdlr;
 
 	return 0;
+
+error:
+	v4l2_ctrl_handler_free(ctrl_hdlr);
+	return ret;
 }
 
 static int hi846_set_video_mode(struct hi846 *hi846, int fps)
-- 
2.39.2



