Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27E47ECF9A
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235360AbjKOTtd (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjKOTtb (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:49:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EC2AB
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:49:28 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18D3BC433C8;
        Wed, 15 Nov 2023 19:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700077768;
        bh=u0xVzQdQnQzxaVLdAshX2RjHaOLkBVxMXAm2nyGualA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZZeKADW3TSA5mf764tAlGhodg5UG2ciPUy7ytMgjJAmpboabnnA5t3oMP809rX/wK
         ZDmqRYBTQicR3Ww10/MNmxD7LHkI1gYF1swEizOvTpeYPpqBHWmJtcsxbsF9B5MwwO
         cXlcYsP8myzhYFt3aufW7DFZ2YvrouSGZZ3D/iqo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Marek Vasut <marex@denx.de>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Adam Ford <aford173@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 508/603] media: hantro: Check whether reset op is defined before use
Date:   Wed, 15 Nov 2023 14:17:33 -0500
Message-ID: <20231115191647.303149172@linuxfoundation.org>
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

From: Marek Vasut <marex@denx.de>

[ Upstream commit 88d4b23a629ebd34f682f770cb6c2116c851f7b8 ]

The i.MX8MM/N/P does not define the .reset op since reset of the VPU is
done by genpd. Check whether the .reset op is defined before calling it
to avoid NULL pointer dereference.

Note that the Fixes tag is set to the commit which removed the reset op
from i.MX8M Hantro G2 implementation, this is because before this commit
all the implementations did define the .reset op.

Fixes: 6971efb70ac3 ("media: hantro: Allow i.MX8MQ G1 and G2 to run independently")
Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Adam Ford <aford173@gmail.com>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/verisilicon/hantro_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
index 423fc85d79ee3..50ec24c753e9e 100644
--- a/drivers/media/platform/verisilicon/hantro_drv.c
+++ b/drivers/media/platform/verisilicon/hantro_drv.c
@@ -125,7 +125,8 @@ void hantro_watchdog(struct work_struct *work)
 	ctx = v4l2_m2m_get_curr_priv(vpu->m2m_dev);
 	if (ctx) {
 		vpu_err("frame processing timed out!\n");
-		ctx->codec_ops->reset(ctx);
+		if (ctx->codec_ops->reset)
+			ctx->codec_ops->reset(ctx);
 		hantro_job_finish(vpu, ctx, VB2_BUF_STATE_ERROR);
 	}
 }
-- 
2.42.0



