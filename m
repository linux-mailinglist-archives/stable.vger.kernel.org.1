Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 468CB78AAA3
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbjH1KXx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjH1KX1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:23:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96F8127
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:23:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D60F6399A
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:23:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E532C433C8;
        Mon, 28 Aug 2023 10:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693218203;
        bh=R3xLnGBwWM1ymesuyGmIGbcEur12xatq2zXtw9iGr8Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xub4ZMC8cJCY8gOn1ArNdMj2eQoe23/yVhQI6qgPxTBlTaJFFZ+EAx9VdCFov7Ief
         fhJSTJ7fcweRdXVsHcazOPudPkkpu3SfTs2VwNzMdwXUHuAfmeos6bN08ajOMj9/gd
         qMv0Mm819gpRpxsABiCzpRm/HfZ8sSyTgC90bYpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Wei Chen <harperchen1110@gmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Subject: [PATCH 6.4 106/129] media: vcodec: Fix potential array out-of-bounds in encoder queue_setup
Date:   Mon, 28 Aug 2023 12:13:05 +0200
Message-ID: <20230828101200.887041174@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
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

6.4-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
+++ b/drivers/media/platform/mediatek/vcodec/mtk_vcodec_enc.c
@@ -821,6 +821,8 @@ static int vb2ops_venc_queue_setup(struc
 		return -EINVAL;
 
 	if (*nplanes) {
+		if (*nplanes != q_data->fmt->num_planes)
+			return -EINVAL;
 		for (i = 0; i < *nplanes; i++)
 			if (sizes[i] < q_data->sizeimage[i])
 				return -EINVAL;


