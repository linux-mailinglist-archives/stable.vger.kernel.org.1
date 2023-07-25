Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B147612DE
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234006AbjGYLGR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233861AbjGYLF4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:05:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F028C4208
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:04:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D109A6164D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09DDC433C8;
        Tue, 25 Jul 2023 11:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690283041;
        bh=1XeDw4OdYLZSeLMwsfwmY4myXT098xFwcPj5JHF7uZs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itRQRSgx9+IZ5RV4tN6SMYEYYWfMVKbtpqPcfYNOj0lJ4k2co4qY29+Pk3c9vmiuP
         kAg6YT4vL3/4viPkAtlqaZ8iwYFf4/S0fF6NFCXwv8cvm1rpcx4fR5B4RkVmxDPfYb
         IfkxXVtogCGVH9Z9k8a2K7WaD6x3B1kuC/S5Q2WA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tristram Ha <Tristram.Ha@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 117/183] net: dsa: microchip: correct KSZ8795 static MAC table access
Date:   Tue, 25 Jul 2023 12:45:45 +0200
Message-ID: <20230725104512.171866416@linuxfoundation.org>
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

From: Tristram Ha <Tristram.Ha@microchip.com>

[ Upstream commit 4bdf79d686b49ac49373b36466acfb93972c7d7c ]

The KSZ8795 driver code was modified to use on KSZ8863/73, which has
different register definitions.  Some of the new KSZ8795 register
information are wrong compared to previous code.

KSZ8795 also behaves differently in that the STATIC_MAC_TABLE_USE_FID
and STATIC_MAC_TABLE_FID bits are off by 1 when doing MAC table reading
than writing.  To compensate that a special code was added to shift the
register value by 1 before applying those bits.  This is wrong when the
code is running on KSZ8863, so this special code is only executed when
KSZ8795 is detected.

Fixes: 4b20a07e103f ("net: dsa: microchip: ksz8795: add support for ksz88xx chips")
Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>
Reviewed-by: Horatiu Vultur <horatiu.vultur@microchip.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/microchip/ksz8795.c    | 8 +++++++-
 drivers/net/dsa/microchip/ksz_common.c | 8 ++++----
 drivers/net/dsa/microchip/ksz_common.h | 7 +++++++
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index 6639fae56da7f..c63e082dc57dc 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -437,7 +437,13 @@ static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
 		(data_hi & masks[STATIC_MAC_TABLE_FWD_PORTS]) >>
 			shifts[STATIC_MAC_FWD_PORTS];
 	alu->is_override = (data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0;
-	data_hi >>= 1;
+
+	/* KSZ8795 family switches have STATIC_MAC_TABLE_USE_FID and
+	 * STATIC_MAC_TABLE_FID definitions off by 1 when doing read on the
+	 * static MAC table compared to doing write.
+	 */
+	if (ksz_is_ksz87xx(dev))
+		data_hi >>= 1;
 	alu->is_static = true;
 	alu->is_use_fid = (data_hi & masks[STATIC_MAC_TABLE_USE_FID]) ? 1 : 0;
 	alu->fid = (data_hi & masks[STATIC_MAC_TABLE_FID]) >>
diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 3d59298eaa5cf..8c492d56d2c36 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -286,13 +286,13 @@ static const u32 ksz8795_masks[] = {
 	[STATIC_MAC_TABLE_VALID]	= BIT(21),
 	[STATIC_MAC_TABLE_USE_FID]	= BIT(23),
 	[STATIC_MAC_TABLE_FID]		= GENMASK(30, 24),
-	[STATIC_MAC_TABLE_OVERRIDE]	= BIT(26),
-	[STATIC_MAC_TABLE_FWD_PORTS]	= GENMASK(24, 20),
+	[STATIC_MAC_TABLE_OVERRIDE]	= BIT(22),
+	[STATIC_MAC_TABLE_FWD_PORTS]	= GENMASK(20, 16),
 	[DYNAMIC_MAC_TABLE_ENTRIES_H]	= GENMASK(6, 0),
-	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	= BIT(8),
+	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	= BIT(7),
 	[DYNAMIC_MAC_TABLE_NOT_READY]	= BIT(7),
 	[DYNAMIC_MAC_TABLE_ENTRIES]	= GENMASK(31, 29),
-	[DYNAMIC_MAC_TABLE_FID]		= GENMASK(26, 20),
+	[DYNAMIC_MAC_TABLE_FID]		= GENMASK(22, 16),
 	[DYNAMIC_MAC_TABLE_SRC_PORT]	= GENMASK(26, 24),
 	[DYNAMIC_MAC_TABLE_TIMESTAMP]	= GENMASK(28, 27),
 	[P_MII_TX_FLOW_CTRL]		= BIT(5),
diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index 9cfa179575ce8..d1b2db8e65331 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -512,6 +512,13 @@ static inline void ksz_regmap_unlock(void *__mtx)
 	mutex_unlock(mtx);
 }
 
+static inline bool ksz_is_ksz87xx(struct ksz_device *dev)
+{
+	return dev->chip_id == KSZ8795_CHIP_ID ||
+	       dev->chip_id == KSZ8794_CHIP_ID ||
+	       dev->chip_id == KSZ8765_CHIP_ID;
+}
+
 static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
 {
 	return dev->chip_id == KSZ8830_CHIP_ID;
-- 
2.39.2



