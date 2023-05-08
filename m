Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC12A6FABA3
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbjEHLPr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbjEHLPq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:15:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED62936CEF
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:15:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E2B562BDE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16D37C433D2;
        Mon,  8 May 2023 11:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544538;
        bh=Pcm9NjD0tWqqHwFUtCDpqhZXaCNABcDIt2eScz57qdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nccIhlKZ277e2XeLqSmaIast8hQctprYPvOFEVpe6CgkqnwLKVok6ciKyOMilKgAw
         yPN4DJ7kzDocHTXJge219MAf9cDXW+xm80I7bnIYgZzoXmiW/89JnLd9El6lVJfGf9
         VtFsX4777KYYMTD+tg2UfhNy7pbOaZud76nYOvmo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        StanleyYP Wang <StanleyYP.Wang@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Felix Fietkau <nbd@nbd.name>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 441/694] wifi: mt76: mt7996: fix eeprom tx path bitfields
Date:   Mon,  8 May 2023 11:44:36 +0200
Message-Id: <20230508094447.778164261@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: StanleyYP Wang <StanleyYP.Wang@mediatek.com>

[ Upstream commit 72fc0df3006ce5c109f9c68f0724e44c47b4ec7b ]

Swap the tx path bitfields of band1 and band2 to read correct setting.

Fixes: 98686cd21624 ("wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices")
Signed-off-by: StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
index 8da599e0abeac..cfc48698539b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/eeprom.h
@@ -31,11 +31,11 @@ enum mt7996_eeprom_field {
 #define MT_EE_WIFI_CONF2_BAND_SEL		GENMASK(2, 0)
 
 #define MT_EE_WIFI_CONF1_TX_PATH_BAND0		GENMASK(5, 3)
-#define MT_EE_WIFI_CONF2_TX_PATH_BAND1		GENMASK(5, 3)
-#define MT_EE_WIFI_CONF2_TX_PATH_BAND2		GENMASK(2, 0)
+#define MT_EE_WIFI_CONF2_TX_PATH_BAND1		GENMASK(2, 0)
+#define MT_EE_WIFI_CONF2_TX_PATH_BAND2		GENMASK(5, 3)
 #define MT_EE_WIFI_CONF4_STREAM_NUM_BAND0	GENMASK(5, 3)
-#define MT_EE_WIFI_CONF5_STREAM_NUM_BAND1	GENMASK(5, 3)
-#define MT_EE_WIFI_CONF5_STREAM_NUM_BAND2	GENMASK(2, 0)
+#define MT_EE_WIFI_CONF5_STREAM_NUM_BAND1	GENMASK(2, 0)
+#define MT_EE_WIFI_CONF5_STREAM_NUM_BAND2	GENMASK(5, 3)
 
 #define MT_EE_RATE_DELTA_MASK			GENMASK(5, 0)
 #define MT_EE_RATE_DELTA_SIGN			BIT(6)
-- 
2.39.2



