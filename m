Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55E976FA4CD
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbjEHKDW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjEHKDV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:03:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6923B2E072
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:03:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D97286209B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0F6FC433A0;
        Mon,  8 May 2023 10:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540197;
        bh=iXV8JeiLFr1c9JNnMdLYWkC5T6pYP0bA0y0pgYuWMd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GEdp6rNEGj3PZI+Y4/TxbFowwr/tBz1FFwG6LALTa08Zs1aTolSDAlfFmtSA4KKuz
         X6YMqh+RhGQkmD1JqAQMafCYGeiclAdWAG/rTNH8pGJs4bDMbKa1lo5E9ykgbMZ+sV
         I2G17nFJ8eCKxbJDphvsPeRL18tnKz+sP/fMKon8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, John Keeping <john@metanate.com>,
        Kalle Valo <kvalo@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 272/611] wifi: brcmfmac: support CQM RSSI notification with older firmware
Date:   Mon,  8 May 2023 11:41:54 +0200
Message-Id: <20230508094431.225050001@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: John Keeping <john@metanate.com>

[ Upstream commit ec52d77d077529f198fd874c550a26b9cc86a331 ]

Using the BCM4339 firmware from linux-firmware (version "BCM4339/2 wl0:
Sep  5 2019 11:05:52 version 6.37.39.113 (r722271 CY)" from
cypress/cyfmac4339-sdio.bin) the RSSI respose is only 4 bytes, which
results in an error being logged.

It seems that older devices send only the RSSI field and neither SNR nor
noise is included.  Handle this by accepting a 4 byte message and
reading only the RSSI from it.

Fixes: 7dd56ea45a66 ("brcmfmac: add support for CQM RSSI notifications")
Signed-off-by: John Keeping <john@metanate.com>
Signed-off-by: Kalle Valo <kvalo@kernel.org>
Link: https://lore.kernel.org/r/20230124104248.2917465-1-john@metanate.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../broadcom/brcm80211/brcmfmac/cfg80211.c         | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
index 12c4408bbc3b6..2cc913acfc2d7 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/cfg80211.c
@@ -6210,18 +6210,20 @@ static s32 brcmf_notify_rssi(struct brcmf_if *ifp,
 {
 	struct brcmf_cfg80211_vif *vif = ifp->vif;
 	struct brcmf_rssi_be *info = data;
-	s32 rssi, snr, noise;
+	s32 rssi, snr = 0, noise = 0;
 	s32 low, high, last;
 
-	if (e->datalen < sizeof(*info)) {
+	if (e->datalen >= sizeof(*info)) {
+		rssi = be32_to_cpu(info->rssi);
+		snr = be32_to_cpu(info->snr);
+		noise = be32_to_cpu(info->noise);
+	} else if (e->datalen >= sizeof(rssi)) {
+		rssi = be32_to_cpu(*(__be32 *)data);
+	} else {
 		brcmf_err("insufficient RSSI event data\n");
 		return 0;
 	}
 
-	rssi = be32_to_cpu(info->rssi);
-	snr = be32_to_cpu(info->snr);
-	noise = be32_to_cpu(info->noise);
-
 	low = vif->cqm_rssi_low;
 	high = vif->cqm_rssi_high;
 	last = vif->cqm_rssi_last;
-- 
2.39.2



