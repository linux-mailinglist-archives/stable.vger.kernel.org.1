Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E95A97ECFAD
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235382AbjKOTuE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:50:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235376AbjKOTuD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:50:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51BE31A3
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:50:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99A81C433C7;
        Wed, 15 Nov 2023 19:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077799;
        bh=a8AEcAvbEs7v68bcI3ia5douVYlNNWJnCPMMLHumwPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZljXxfvSwKSR7qLdY14v0WGFk1pDKjr7bCtZ686nE0fJmE5YcfPWqM+vKPAZ0X53+
         OtPMYBdgpYQl/puq0fgzVobedBhiUylKDLet6VRWrVlwEWs4bQWz5Ys1i2OOFtfbcq
         vumE3L4tCBc+f6Mc0hwCpiBNY42UmqQbeWvTaz7Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Irui Wang <irui.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 527/603] media: mediatek: vcodec: Handle invalid encoder vsi
Date:   Wed, 15 Nov 2023 14:17:52 -0500
Message-ID: <20231115191648.410183857@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191613.097702445@linuxfoundation.org>
References: <20231115191613.097702445@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Irui Wang <irui.wang@mediatek.com>

[ Upstream commit 19e2e01f30b5d2b448b5db097130486ea95af36f ]

Handle invalid encoder vsi in vpu_enc_init to ensure the encoder
vsi is valid for future use.

Fixes: 1972e32431ed ("media: mediatek: vcodec: Fix possible invalid memory access for encoder")

Signed-off-by: Irui Wang <irui.wang@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
index ae6290d28f8e9..84ad1cc6ad171 100644
--- a/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
+++ b/drivers/media/platform/mediatek/vcodec/encoder/venc_vpu_if.c
@@ -154,6 +154,11 @@ int vpu_enc_init(struct venc_vpu_inst *vpu)
 		return -EINVAL;
 	}
 
+	if (IS_ERR_OR_NULL(vpu->vsi)) {
+		mtk_venc_err(vpu->ctx, "invalid venc vsi");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.42.0



