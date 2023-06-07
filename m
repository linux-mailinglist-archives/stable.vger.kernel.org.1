Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2917C726B9A
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:26:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233372AbjFGU0h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjFGU0c (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:26:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09A82721
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:26:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11AC064457
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABD6C433D2;
        Wed,  7 Jun 2023 20:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686169569;
        bh=wUUPDJ7oxjmYaBSkq+fnMwUktitXjVLulGSnwpjis3U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ACCFK2bsSi7IYP+AIaTlQ5yXv0wJa7N1uoeKIlI5GdDreCxOrVuux7boVXxhtnlnR
         xhGCkXHvYNCD4UZ36Ie+87vjlU/MUspvE9UnIFeJm9dv/aOcYhs/Fb6aUSsV2umQBj
         l+GNpfuCiRMf31DbmEaWAqE7Z85ZZGbQguk3nYA8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 101/286] media: rcar-vin: Select correct interrupt mode for V4L2_FIELD_ALTERNATE
Date:   Wed,  7 Jun 2023 22:13:20 +0200
Message-ID: <20230607200926.367387769@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200922.978677727@linuxfoundation.org>
References: <20230607200922.978677727@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

[ Upstream commit e10707d5865c90d3dfe4ef589ce02ff4287fef85 ]

When adding proper support for V4L2_FIELD_ALTERNATE it was missed that
this field format should trigger an interrupt for each field, not just
for the whole frame. Fix this by marking it as progressive in the
capture setup, which will then select the correct interrupt mode.

Tested on both Gen2 and Gen3 with the result of a doubling of the frame
rate for V4L2_FIELD_ALTERNATE. From a PAL video source the frame rate is
now 50, which is expected for alternate field capture.

Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/media/platform/renesas/rcar-vin/rcar-dma.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
index 23598e22adc72..2a77353f10b59 100644
--- a/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
+++ b/drivers/media/platform/renesas/rcar-vin/rcar-dma.c
@@ -728,11 +728,9 @@ static int rvin_setup(struct rvin_dev *vin)
 	case V4L2_FIELD_SEQ_TB:
 	case V4L2_FIELD_SEQ_BT:
 	case V4L2_FIELD_NONE:
-		vnmc = VNMC_IM_ODD_EVEN;
-		progressive = true;
-		break;
 	case V4L2_FIELD_ALTERNATE:
 		vnmc = VNMC_IM_ODD_EVEN;
+		progressive = true;
 		break;
 	default:
 		vnmc = VNMC_IM_ODD;
-- 
2.39.2



