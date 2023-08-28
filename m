Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF92278AD30
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjH1Kq0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbjH1KqE (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:46:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1955C1BD
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:45:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BAC664244
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71503C433C9;
        Mon, 28 Aug 2023 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693219517;
        bh=DZAgK5VGrL3fkiJJfwCR7J/OY/Eoy8xIGfIIP+kNwF0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CzWNOnSEpFFpYH0oMaGkaO+Eg5gjyvwm+3DlovrKdsNk6rPjRq94ByWQROC5vJ4Qb
         u2s19GOMpcwnu8FISVYUyytNe+fujkr79CC92q8uhxTm90tzGZ3UA00Trs9GvOztnF
         DUOLnWjapk3pW98uf1vBXKKqxcfQTAKJj8B45E1s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Chen <harperchen1110@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 5.15 65/89] media: vcodec: Fix potential array out-of-bounds in encoder queue_setup
Date:   Mon, 28 Aug 2023 12:14:06 +0200
Message-ID: <20230828101152.362980866@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101150.163430842@linuxfoundation.org>
References: <20230828101150.163430842@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wei Chen <harperchen1110@gmail.com>

commit e7f2e65699e2290fd547ec12a17008764e5d9620 upstream.

variable *nplanes is provided by user via system call argument. The
possible value of q_data->fmt->num_planes is 1-3, while the value
of *nplanes can be 1-8. The array access by index i can cause array
out-of-bounds.

Fix this bug by checking *nplanes against the array size.

Fixes: 4e855a6efa54 ("[media] vcodec: mediatek: Add Mediatek V4L2 Video Encoder Driver")
Signed-off-by: Wei Chen <harperchen1110@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
@@ -733,6 +733,8 @@ static int vb2ops_venc_queue_setup(struc
 		return -EINVAL;
 
 	if (*nplanes) {
+		if (*nplanes != q_data->fmt->num_planes)
+			return -EINVAL;
 		for (i = 0; i < *nplanes; i++)
 			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;


