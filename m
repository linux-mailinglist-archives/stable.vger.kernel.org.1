Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0900755396
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjGPUUm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231786AbjGPUUl (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:20:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CC1A1B7
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:20:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2F4C60E88
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B0CC433C7;
        Sun, 16 Jul 2023 20:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689538839;
        bh=XehyylC2d9D6er+3hfXKPZFfmzxhnqqrpkAQsN836xg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LXvlDeWjOnjYtbcGlZOSJd4sP5Yp2QFKS+6gulLzv7t6n+O4aus+L2NpUTwnID4KH
         1i4Fq9X0heIo92mNK7aVGRADD1xoVMW0e6clZtAMUBGMPB3pOxMZ4Wc+GXMpBP44Jw
         pNHG1+F63eIfBUaZBnwmG9J4p3zq1d0M0hY/CN4E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ming Qian <ming.qian@nxp.com>,
        "xiahong.bao" <xiahong.bao@nxp.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 566/800] media: amphion: drop repeated codec data for vc1l format
Date:   Sun, 16 Jul 2023 21:46:59 +0200
Message-ID: <20230716195002.235382217@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Ming Qian <ming.qian@nxp.com>

[ Upstream commit 668ee1a3a1870381225002c246972419b98e4253 ]

For format V4L2_PIX_FMT_VC1_ANNEX_L,
the codec data is replaced with startcode,
and then driver drop it, otherwise it may led to decoding error.

It's amphion vpu's limitation

Driver has dropped the first codec data,
but need to drop the repeated codec data too.

Fixes: e670f5d672ef ("media: amphion: only insert the first sequence startcode for vc1l format")
Signed-off-by: Ming Qian <ming.qian@nxp.com>
Tested-by: xiahong.bao <xiahong.bao@nxp.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/amphion/vpu_malone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/platform/amphion/vpu_malone.c b/drivers/media/platform/amphion/vpu_malone.c
index ef44bff9fbaf6..e96994437429f 100644
--- a/drivers/media/platform/amphion/vpu_malone.c
+++ b/drivers/media/platform/amphion/vpu_malone.c
@@ -1344,6 +1344,8 @@ static int vpu_malone_insert_scode_vc1_l_seq(struct malone_scode_t *scode)
 	int size = 0;
 	u8 rcv_seqhdr[MALONE_VC1_RCV_SEQ_HEADER_LEN];
 
+	if (vpu_vb_is_codecconfig(to_vb2_v4l2_buffer(scode->vb)))
+		scode->need_data = 0;
 	if (scode->inst->total_input_count)
 		return 0;
 	scode->need_data = 0;
-- 
2.39.2



