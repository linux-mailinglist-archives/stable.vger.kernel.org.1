Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 430DA719E1D
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233855AbjFAN3Q (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjFAN27 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:28:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F621B3
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:28:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B244D64502
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:28:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7F40C433EF;
        Thu,  1 Jun 2023 13:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685626108;
        bh=LClHBa7uMSl95ldE29wtjSpu3bmaXYOaiTkJ++CAUnA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ttf/ZYXj61QsgMVHMx8mVKmg0y+hy3Ij2nV+yt5f8RSFLdMxX6in9WUfOJCyG6Jo9
         bXsctNxo0vJHoNG1XL4KQ0g/omkMDHofsoSOBg8BTWZxxLEPHKkqTThK7wpFpLf5kP
         Xcgus/VHGoVVR6iIoE97PbZHb7G6vUVhefInweMs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 33/42] dmaengine: at_xdmac: restore the content of grws register
Date:   Thu,  1 Jun 2023 14:21:42 +0100
Message-Id: <20230601131940.522389309@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131939.051934720@linuxfoundation.org>
References: <20230601131939.051934720@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

[ Upstream commit 7c5eb63d16b01c202aaa95f374ae15a807745a73 ]

In case the system suspends to a deep sleep state where power to DMA
controller is cut-off we need to restore the content of GRWS register.
This is a write only register and writing bit X tells the controller
to suspend read and write requests for channel X. Thus set GRWS before
restoring the content of GE (Global Enable) regiter.

Fixes: e1f7c9eee707 ("dmaengine: at_xdmac: creation of the atmel eXtended DMA Controller driver")
Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Link: https://lore.kernel.org/r/20230214151827.1050280-5-claudiu.beznea@microchip.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/dma/at_xdmac.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/dma/at_xdmac.c b/drivers/dma/at_xdmac.c
index cb1374b161291..fc018b633822e 100644
--- a/drivers/dma/at_xdmac.c
+++ b/drivers/dma/at_xdmac.c
@@ -2064,6 +2064,15 @@ static int __maybe_unused atmel_xdmac_resume(struct device *dev)
 		if (at_xdmac_chan_is_cyclic(atchan)) {
 			if (at_xdmac_chan_is_paused(atchan))
 				at_xdmac_device_resume_internal(atchan);
+
+			/*
+			 * We may resume from a deep sleep state where power
+			 * to DMA controller is cut-off. Thus, restore the
+			 * suspend state of channels set though dmaengine API.
+			 */
+			else if (at_xdmac_chan_is_paused(atchan))
+				at_xdmac_device_pause_set(atxdmac, atchan);
+
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDA, atchan->save_cnda);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CNDC, atchan->save_cndc);
 			at_xdmac_chan_write(atchan, AT_XDMAC_CIE, atchan->save_cim);
-- 
2.39.2



