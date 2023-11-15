Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B22557ED30A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 21:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjKOUpy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 15:45:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233680AbjKOUpt (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 15:45:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BCC1AE
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 12:45:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC9CC433C9;
        Wed, 15 Nov 2023 20:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700081146;
        bh=dbzGcAXaqlRqmXNiGHni3wiwMpqbW4M9Fbdi8fL6nXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bxlAbyCJ51tML3WHEA5P67LOJZQg5AR7vOOqiZrmcAGglNjlGO7En1EDAKl/6/xzV
         ZryWJF2inh1wfVbhseC9MvhAu2lyw+LNxT6lVct+UQurpMV4oxYE98FEdwMGCoOQAr
         LBo2Dcmbezxv9ureOnou3Re5bjeqEfkDXwSiTOkk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Katya Orlova <e.orlova@ispras.ru>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 66/88] media: s3c-camif: Avoid inappropriate kfree()
Date:   Wed, 15 Nov 2023 15:36:18 -0500
Message-ID: <20231115191430.094148300@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191426.221330369@linuxfoundation.org>
References: <20231115191426.221330369@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Katya Orlova <e.orlova@ispras.ru>

[ Upstream commit 61334819aca018c3416ee6c330a08a49c1524fc3 ]

s3c_camif_register_video_node() works with video_device structure stored
as a field of camif_vp, so it should not be kfreed.
But there is video_device_release() on error path that do it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: babde1c243b2 ("[media] V4L: Add driver for S3C24XX/S3C64XX SoC series camera interface")
Signed-off-by: Katya Orlova <e.orlova@ispras.ru>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/s3c-camif/camif-capture.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/platform/s3c-camif/camif-capture.c b/drivers/media/platform/s3c-camif/camif-capture.c
index c02dce8b4c6c7..6e150fc64e0a0 100644
--- a/drivers/media/platform/s3c-camif/camif-capture.c
+++ b/drivers/media/platform/s3c-camif/camif-capture.c
@@ -1142,12 +1142,12 @@ int s3c_camif_register_video_node(struct camif_dev *camif, int idx)
 
 	ret = vb2_queue_init(q);
 	if (ret)
-		goto err_vd_rel;
+		return ret;
 
 	vp->pad.flags = MEDIA_PAD_FL_SINK;
 	ret = media_entity_pads_init(&vfd->entity, 1, &vp->pad);
 	if (ret)
-		goto err_vd_rel;
+		return ret;
 
 	video_set_drvdata(vfd, vp);
 
@@ -1179,8 +1179,6 @@ int s3c_camif_register_video_node(struct camif_dev *camif, int idx)
 	v4l2_ctrl_handler_free(&vp->ctrl_handler);
 err_me_cleanup:
 	media_entity_cleanup(&vfd->entity);
-err_vd_rel:
-	video_device_release(vfd);
 	return ret;
 }
 
-- 
2.42.0



