Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59728755643
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232828AbjGPUtS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbjGPUtG (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:49:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217B9173F
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:48:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D85AE60EBD
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:48:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FCFC433C7;
        Sun, 16 Jul 2023 20:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540532;
        bh=s3R8g4QE40GllNpqSeri+HBhfyFpnkFaMvtFqGoMgPs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7iAYChmI/iRwt87wfDLuwjsYYmm4OlfWQcTbpRoM65ncxxgKn8ArRoUEJYk7LVJQ
         epvYM/oxwmZtyLMekG+2SwPx0/Zejtam/R0wFBEGbd4DQvxmW99bESTYKgx0SRHLGu
         xvVEEPqQYf9CH2sQYmdAHTBpHJPXyatolIs2CpMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ming Qian <ming.qian@nxp.com>,
        "xiahong.bao" <xiahong.bao@nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 396/591] media: amphion: drop repeated codec data for vc1g format
Date:   Sun, 16 Jul 2023 21:48:55 +0200
Message-ID: <20230716194934.163737503@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ming Qian <ming.qian@nxp.com>

[ Upstream commit e1d2ccc2cdd6333584aa3d5386dc667d0837c48f ]

For format V4L2_PIX_FMT_VC1_ANNEX_G,
the separate codec data is required only once.
The repeated codec data may introduce some decoding error.
so drop the repeated codec data.

It's amphion vpu's limitation

Fixes: e670f5d672ef ("media: amphion: only insert the first sequence startcode for vc1l format")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Tested-by: xiahong.bao <xiahong.bao@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vpu_malone.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index 36e563d29621f..c2f4fb12c3b64 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -1286,6 +1286,15 @@ static int vpu_malone_insert_scode_pic(struct malone_scode_t *scode, u32 codec_i
 	return sizeof(hdr);
 }
 
+static int vpu_malone_insert_scode_vc1_g_seq(struct malone_scode_t *scode)
+{
+	if (!scode->inst->total_input_count)
+		return 0;
+	if (vpu_vb_is_codecconfig(to_vb2_v4l2_buffer(scode->vb)))
+		scode->need_data = 0;
+	return 0;
+}
+
 static int vpu_malone_insert_scode_vc1_g_pic(struct malone_scode_t *scode)
 {
 	struct vb2_v4l2_buffer *vbuf;
@@ -1423,6 +1432,7 @@ static const struct malone_scode_handler scode_handlers[] = {
 	},
 	{
 		.pixelformat = V4L2_PIX_FMT_VC1_ANNEX_G,
+		.insert_scode_seq = vpu_malone_insert_scode_vc1_g_seq,
 		.insert_scode_pic = vpu_malone_insert_scode_vc1_g_pic,
 	},
 	{
-- 
2.39.2



