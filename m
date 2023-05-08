Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03FD6FA832
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234882AbjEHKin (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234884AbjEHKiT (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17EF828930
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:38:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2C9661D23
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:38:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90E7EC4339B;
        Mon,  8 May 2023 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542295;
        bh=DQ4AHIURjp05gqZfjRGsnRd4L6R1i7csRpCpCbEfDKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DCIksJeVxAG0baoz53izAH9ktTDEOtKbThpwYLOOr4K3yn2Sl0lLj/Iio8Y1Ebz2I
         3ZO/7Twc2EJQoo4Wh4IJZtOdDko9q9UUs9rNd2EzsVVTOWH0TmPNuXN3FIx3yCvl/Z
         tYOO1OOLSS9YVJJ8vXvivwb82/8zs32qX208rdWk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lorenz Brun <lorenz@brun.one>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 390/663] wifi: mt76: mt7915: expose device tree match table
Date:   Mon,  8 May 2023 11:43:36 +0200
Message-Id: <20230508094440.760778146@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
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

From: Lorenz Brun <lorenz@brun.one>

[ Upstream commit 90fb69212c60e26ef70ed0e8532b116c7649ac88 ]

On MT7986 the WiFi driver currently does not get automatically loaded,
requiring manual modprobing because the device tree compatibles are not
exported into metadata.

Add the missing MODULE_DEVICE_TABLE macro to fix this.

Fixes: 99ad32a4ca3a2 ("mt76: mt7915: add support for MT7986")
Signed-off-by: Lorenz Brun <lorenz@brun.one>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7915/soc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
index 686c9bbd59293..7303b690a64dc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/soc.c
@@ -1237,6 +1237,8 @@ static const struct of_device_id mt7986_wmac_of_match[] = {
 	{},
 };
 
+MODULE_DEVICE_TABLE(of, mt7986_wmac_of_match);
+
 struct platform_driver mt7986_wmac_driver = {
 	.driver = {
 		.name = "mt7986-wmac",
-- 
2.39.2



