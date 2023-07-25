Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC7F7612DF
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233879AbjGYLGS (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233853AbjGYLFy (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 371C24202
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:03:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 017BE615BA
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13150C433C8;
        Tue, 25 Jul 2023 11:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283038;
        bh=njRaw3mogpFUeb28QN4+v1DkZp2ISppWike+/gvGlDY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WlSoreh16FGEi6czz58bLVr/hnldd/bF5dmYtmpamT+KJvUGqSs1jZ640UKBtVhtK
         KT8QbhxyCx9GIGFgdQvhC6OPAM/mwD6ykusbt/pdOPl7gs7q2J9xZhMvGLlygK3won
         I9Ezlju+Fq2Ygxh18+pnTVe51OHPzHkFhVjciUKg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Oleksij Rempel <o.rempel@pengutronix.de>,
        Vladimir Oltean <olteanv@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 116/183] net: dsa: microchip: ksz8_r_sta_mac_table(): Avoid using error code for empty entries
Date:   Tue, 25 Jul 2023 12:45:44 +0200
Message-ID: <20230725104512.140523334@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104507.756981058@linuxfoundation.org>
References: <20230725104507.756981058@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

[ Upstream commit 559901b46810e82ba5321a5e789f994b65d3bc3d ]

Prepare for the next patch by ensuring that ksz8_r_sta_mac_table() does
not use error codes for empty entries. This change will enable better
handling of read/write errors in the upcoming patch.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Stable-dep-of: 4bdf79d686b4 ("net: dsa: microchip: correct KSZ8795 static MAC table access")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz8795.c | 87 +++++++++++++++++------------
 1 file changed, 50 insertions(+), 37 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index a2f67be66b97d..6639fae56da7f 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -407,7 +407,7 @@ int ksz8_r_dyn_mac_table(struct ksz_device *dev, u16 addr, u8 *mac_addr,
 }
 
 static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
-				struct alu_struct *alu)
+				struct alu_struct *alu, bool *valid)
 {
 	u32 data_hi, data_lo;
 	const u8 *shifts;
@@ -420,28 +420,32 @@ static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
 	ksz8_r_table(dev, TABLE_STATIC_MAC, addr, &data);
 	data_hi = data >> 32;
 	data_lo = (u32)data;
-	if (data_hi & (masks[STATIC_MAC_TABLE_VALID] |
-			masks[STATIC_MAC_TABLE_OVERRIDE])) {
-		alu->mac[5] = (u8)data_lo;
-		alu->mac[4] = (u8)(data_lo >> 8);
-		alu->mac[3] = (u8)(data_lo >> 16);
-		alu->mac[2] = (u8)(data_lo >> 24);
-		alu->mac[1] = (u8)data_hi;
-		alu->mac[0] = (u8)(data_hi >> 8);
-		alu->port_forward =
-			(data_hi & masks[STATIC_MAC_TABLE_FWD_PORTS]) >>
-				shifts[STATIC_MAC_FWD_PORTS];
-		alu->is_override =
-			(data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0;
-		data_hi >>= 1;
-		alu->is_static = true;
-		alu->is_use_fid =
-			(data_hi & masks[STATIC_MAC_TABLE_USE_FID]) ? 1 : 0;
-		alu->fid = (data_hi & masks[STATIC_MAC_TABLE_FID]) >>
-				shifts[STATIC_MAC_FID];
+
+	if (!(data_hi & (masks[STATIC_MAC_TABLE_VALID] |
+			 masks[STATIC_MAC_TABLE_OVERRIDE]))) {
+		*valid = false;
 		return 0;
 	}
-	return -ENXIO;
+
+	alu->mac[5] = (u8)data_lo;
+	alu->mac[4] = (u8)(data_lo >> 8);
+	alu->mac[3] = (u8)(data_lo >> 16);
+	alu->mac[2] = (u8)(data_lo >> 24);
+	alu->mac[1] = (u8)data_hi;
+	alu->mac[0] = (u8)(data_hi >> 8);
+	alu->port_forward =
+		(data_hi & masks[STATIC_MAC_TABLE_FWD_PORTS]) >>
+			shifts[STATIC_MAC_FWD_PORTS];
+	alu->is_override = (data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0;
+	data_hi >>= 1;
+	alu->is_static = true;
+	alu->is_use_fid = (data_hi & masks[STATIC_MAC_TABLE_USE_FID]) ? 1 : 0;
+	alu->fid = (data_hi & masks[STATIC_MAC_TABLE_FID]) >>
+		shifts[STATIC_MAC_FID];
+
+	*valid = true;
+
+	return 0;
 }
 
 void ksz8_w_sta_mac_table(struct ksz_device *dev, u16 addr,
@@ -930,20 +934,25 @@ static int ksz8_add_sta_mac(struct ksz_device *dev, int port,
 			    const unsigned char *addr, u16 vid)
 {
 	struct alu_struct alu;
-	int index;
+	int index, ret;
 	int empty = 0;
 
 	alu.port_forward = 0;
 	for (index = 0; index < dev->info->num_statics; index++) {
-		if (!ksz8_r_sta_mac_table(dev, index, &alu)) {
-			/* Found one already in static MAC table. */
-			if (!memcmp(alu.mac, addr, ETH_ALEN) &&
-			    alu.fid == vid)
-				break;
-		/* Remember the first empty entry. */
-		} else if (!empty) {
-			empty = index + 1;
+		bool valid;
+
+		ret = ksz8_r_sta_mac_table(dev, index, &alu, &valid);
+		if (ret)
+			return ret;
+		if (!valid) {
+			/* Remember the first empty entry. */
+			if (!empty)
+				empty = index + 1;
+			continue;
 		}
+
+		if (!memcmp(alu.mac, addr, ETH_ALEN) && alu.fid == vid)
+			break;
 	}
 
 	/* no available entry */
@@ -973,15 +982,19 @@ static int ksz8_del_sta_mac(struct ksz_device *dev, int port,
 			    const unsigned char *addr, u16 vid)
 {
 	struct alu_struct alu;
-	int index;
+	int index, ret;
 
 	for (index = 0; index < dev->info->num_statics; index++) {
-		if (!ksz8_r_sta_mac_table(dev, index, &alu)) {
-			/* Found one already in static MAC table. */
-			if (!memcmp(alu.mac, addr, ETH_ALEN) &&
-			    alu.fid == vid)
-				break;
-		}
+		bool valid;
+
+		ret = ksz8_r_sta_mac_table(dev, index, &alu, &valid);
+		if (ret)
+			return ret;
+		if (!valid)
+			continue;
+
+		if (!memcmp(alu.mac, addr, ETH_ALEN) && alu.fid == vid)
+			break;
 	}
 
 	/* no available entry */
-- 
2.39.2



