Return-Path: <stable+bounces-114555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73390A2EE99
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 14:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDD2C1883073
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 13:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 780A422F397;
	Mon, 10 Feb 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KtPpe26u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3644618E1A
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 13:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739195081; cv=none; b=Ekg1PjmUgaJ9Yr/ZQJO33Nckf0ipF5OCRunytGZXpced4k+2p6ewO8dowuGnDFcQ8XGVdI8Y6JYmEqjFVvK1i4SKlv/gWL2CN8I3wZqjYMqiDFcXVnLDaA51CBvBBZ4dFkyDAf2uITIQs6cdr/Ht0WAmOKZap/axzy90MZUx2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739195081; c=relaxed/simple;
	bh=UbnUQdPtnxfb18R9r797KRMYX+iDSXg8FZ3dlywx2Uw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kv4wITau61bZQbHn6ZoCsbWbSaU2k4nQMGiTA+S63vAK2K0UFhCpAKd8unaq2mgTLeI5v2TvJll3TLic6A/AksSYWIdqG4okzE7xMf4mi20al301FyFfA0w5u60Ue+EnYs3eufrEeqXepFZ2mjfV1/LkIo697vDLYAJFBDeRNy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KtPpe26u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B40CC4CED1;
	Mon, 10 Feb 2025 13:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739195081;
	bh=UbnUQdPtnxfb18R9r797KRMYX+iDSXg8FZ3dlywx2Uw=;
	h=Subject:To:Cc:From:Date:From;
	b=KtPpe26uIiETy4vAfcacXD93LAChO0put+4L8vP3450L6mB/sZXg8RXvmL+B+7+4h
	 gZSBU50g1z86JYV49gdBjKc1gMr4K5XQYiN7VA5bRYT5npqqTSE0/LdGFPdxoEIM33
	 15x5gfG/2v7rjvcsB64LZi8cRJJxyiqpSTzBj0Fw=
Subject: FAILED: patch "[PATCH] wifi: mt76: mt7915: add module param to select 5 GHz or 6 GHz" failed to apply to 6.1-stable tree
To: shayne.chen@mediatek.com,nbd@nbd.name
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 14:44:37 +0100
Message-ID: <2025021037-retype-jaunt-6b0b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 57af267d2b8f5d88485c6372761386d79c5e6a1a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021037-retype-jaunt-6b0b@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 57af267d2b8f5d88485c6372761386d79c5e6a1a Mon Sep 17 00:00:00 2001
From: Shayne Chen <shayne.chen@mediatek.com>
Date: Thu, 10 Oct 2024 10:38:16 +0200
Subject: [PATCH] wifi: mt76: mt7915: add module param to select 5 GHz or 6 GHz
 on MT7916

Due to a limitation in available memory, the MT7916 firmware can only
handle either 5 GHz or 6 GHz at a time. It does not support runtime
switching without a full restart.

On older firmware, this accidentally worked to some degree due to missing
checks, but couldn't be supported properly, because it left the 6 GHz
channels uncalibrated.
Newer firmware refuses to start on either band if the passed EEPROM
data indicates support for both.

Deal with this limitation by using a module parameter to specify the
preferred band in case both are supported.

Fixes: b4d093e321bd ("mt76: mt7915: add 6 GHz support")
Cc: stable@vger.kernel.org
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Link: https://patch.msgid.link/20241010083816.51880-1-nbd@nbd.name
Signed-off-by: Felix Fietkau <nbd@nbd.name>

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
index bfdbc15abaa9..928e0b07a9bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/eeprom.c
@@ -2,9 +2,14 @@
 /* Copyright (C) 2020 MediaTek Inc. */
 
 #include <linux/firmware.h>
+#include <linux/moduleparam.h>
 #include "mt7915.h"
 #include "eeprom.h"
 
+static bool enable_6ghz;
+module_param(enable_6ghz, bool, 0644);
+MODULE_PARM_DESC(enable_6ghz, "Enable 6 GHz instead of 5 GHz on hardware that supports both");
+
 static int mt7915_eeprom_load_precal(struct mt7915_dev *dev)
 {
 	struct mt76_dev *mdev = &dev->mt76;
@@ -170,8 +175,20 @@ static void mt7915_eeprom_parse_band_config(struct mt7915_phy *phy)
 			phy->mt76->cap.has_6ghz = true;
 			return;
 		case MT_EE_V2_BAND_SEL_5GHZ_6GHZ:
-			phy->mt76->cap.has_5ghz = true;
-			phy->mt76->cap.has_6ghz = true;
+			if (enable_6ghz) {
+				phy->mt76->cap.has_6ghz = true;
+				u8p_replace_bits(&eeprom[MT_EE_WIFI_CONF + band],
+						 MT_EE_V2_BAND_SEL_6GHZ,
+						 MT_EE_WIFI_CONF0_BAND_SEL);
+			} else {
+				phy->mt76->cap.has_5ghz = true;
+				u8p_replace_bits(&eeprom[MT_EE_WIFI_CONF + band],
+						 MT_EE_V2_BAND_SEL_5GHZ,
+						 MT_EE_WIFI_CONF0_BAND_SEL);
+			}
+			/* force to buffer mode */
+			dev->flash_mode = true;
+
 			return;
 		default:
 			phy->mt76->cap.has_2ghz = true;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 6bef96e3d2a3..f82216d1bda0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -1239,14 +1239,14 @@ int mt7915_register_device(struct mt7915_dev *dev)
 	if (ret)
 		goto unreg_dev;
 
-	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
-
 	if (phy2) {
 		ret = mt7915_register_ext_phy(dev, phy2);
 		if (ret)
 			goto unreg_thermal;
 	}
 
+	ieee80211_queue_work(mt76_hw(dev), &dev->init_work);
+
 	dev->recovery.hw_init_done = true;
 
 	ret = mt7915_init_debugfs(&dev->phy);


