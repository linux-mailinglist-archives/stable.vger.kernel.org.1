Return-Path: <stable+bounces-100462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 685639EB6EA
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 17:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2202F28332F
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 16:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BC632343D4;
	Tue, 10 Dec 2024 16:47:02 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from s1.jo-so.de (s1.jo-so.de [37.221.195.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F2E2153DC
	for <stable@vger.kernel.org>; Tue, 10 Dec 2024 16:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.221.195.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733849221; cv=none; b=ApNPZJO1pU+Wtc7eGbscJM6Q2O3PTBwmsjEoyLQFH+oB2cwlHaBcWHkZqJZDKAARYZACUOAo6FNz+SY2Zh7JCJzZQwCCvOs52aLxlit7nU36QlavsnTuFMJsLVIbg+HzaysZGJu5mNTKVWdv0s6AhGv2A36mzwl8bzwZrNUQbz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733849221; c=relaxed/simple;
	bh=3FMOYMMfpcQ3U2nuU5cEtyFoMGJEedalThxD5wiIBSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OwRh05o6/FsxJnVfp6M6cJP5GVV/X/UOPtxb47DIKnv/vEVmeo2w4zq5rPdhq/+084uPTU8hR9o59xhD/IHFtFjOdgmgbIzcEkwp0CLfOnTsgIHqWAs9FeGVHG7uZkihfGYgqCWDGAtKT+4n3ivyNdQDWaZTfwlSdT2TbYMfilU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de; spf=pass smtp.mailfrom=jo-so.de; arc=none smtp.client-ip=37.221.195.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jo-so.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jo-so.de
Received: from mail-relay (helo=jo-so.de)
	by s1.jo-so.de with local-bsmtp (Exim 4.96)
	(envelope-from <joerg@jo-so.de>)
	id 1tL3Nv-001aN4-1p;
	Tue, 10 Dec 2024 17:46:55 +0100
Received: from joerg by zenbook.jo-so.de with local (Exim 4.98)
	(envelope-from <joerg@jo-so.de>)
	id 1tL3Nu-00000000Nrf-463u;
	Tue, 10 Dec 2024 17:46:54 +0100
From: =?UTF-8?q?J=C3=B6rg=20Sommer?= <joerg@jo-so.de>
To: stable@vger.kernel.org
Cc: Tristram Ha <Tristram.Ha@microchip.com>,
	Michael Grzeschik <m.grzeschik@pengutronix.de>
Subject: [PATCH v2] net: dsa: microchip: correct KSZ8795 static MAC table access
Date: Tue, 10 Dec 2024 17:46:54 +0100
Message-ID: <8d4be70022292e9db1980a2527c2e5d927643f42.1733849214.git.joerg@jo-so.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[Backport of 4bdf79d686b49ac49373b36466acfb93972c7d7c to v5.15]

The rewrite in 9f73e11250fb3948a8599d72318951d5e93b1eaf contained some
mistakes they where fixed with 4bdf79d686b49ac49373b36466acfb93972c7d7c in
master. The code in 4bdf to support the bit shift is only required for
KSZ8795, because support for KSZ8794 and KSZ8765 does not exist in v5.15.

Signed-off-by: Jörg Sommer <joerg@jo-so.de>
Cc: Tristram Ha <Tristram.Ha@microchip.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/net/dsa/microchip/ksz8795.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
index c5142f86a3c7..ef88e26aedf2 100644
--- a/drivers/net/dsa/microchip/ksz8795.c
+++ b/drivers/net/dsa/microchip/ksz8795.c
@@ -25,6 +25,8 @@
 #include "ksz8795_reg.h"
 #include "ksz8.h"
 
+#define KSZ8795_CHIP_ID         0x09
+
 static const u8 ksz8795_regs[] = {
 	[REG_IND_CTRL_0]		= 0x6E,
 	[REG_IND_DATA_8]		= 0x70,
@@ -52,13 +54,13 @@ static const u32 ksz8795_masks[] = {
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
 };
@@ -601,7 +603,13 @@ static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
 				shifts[STATIC_MAC_FWD_PORTS];
 		alu->is_override =
 			(data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0;
-		data_hi >>= 1;
+
+		/* KSZ8795 family switches have STATIC_MAC_TABLE_USE_FID and
+		 * STATIC_MAC_TABLE_FID definitions off by 1 when doing read on the
+		 * static MAC table compared to doing write.
+		 */
+		if (dev->chip_id == KSZ8795_CHIP_ID)
+			data_hi >>= 1;
 		alu->is_static = true;
 		alu->is_use_fid =
 			(data_hi & masks[STATIC_MAC_TABLE_USE_FID]) ? 1 : 0;
-- 
2.45.2


