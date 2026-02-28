Return-Path: <stable+bounces-220407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2JKsAew4o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:50:20 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 828231C64FE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7036F31BF8CF
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA7B3AE112;
	Sat, 28 Feb 2026 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pku0/fjo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF93E3AE0FF;
	Sat, 28 Feb 2026 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300298; cv=none; b=YH/kggDo21Y1laS41i8pree3tDUXItwZbUHyrn7mS0d6n2lwk8g1I2DYzP3+Bl/hokStWSCfeavWVd9nXvj/3nnCU0smZ2nCkEwTTcJKUKiWR0TutQMI+lEn4pH/CVkwtYmIDbrjcKz9B4DV5yyeegqyyYshWO799nWx9kadrBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300298; c=relaxed/simple;
	bh=waZC0sqlFxLnN6MicwwPXP13l/tZFkfFMAngKrbv+pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mwEwd6NOEpoYwNKUk+1pUIzLA6fg8e8uF+YFCf6Gq+PhvAZ8I0ufH/pocCU1sdUr3B4ZoKRWI+/DZn8gtTVr1vjZMUhvjYq8Kzp776JJEf1jdp1evKO8DkvYrIZUiFlTNriqJmLWO0K1yHl3YLa6RQYEjtKBN0w80SQQM44Fhh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pku0/fjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB679C19425;
	Sat, 28 Feb 2026 17:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300298;
	bh=waZC0sqlFxLnN6MicwwPXP13l/tZFkfFMAngKrbv+pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pku0/fjoIb85F2s9ykB4KzZMnG1PLEe+BKTqi9LRK0dyoNLsz+vQ/7Wjtiv8fxbGV
	 ml03rX7oZ5MBkYPIRP4Po8zhT4hi691hcOtS/Gpe/CfQ59RRSm3B0ojgifRrd7UAQa
	 bzJFoiXeLuz6llfqJg9qNFDfmA33lcqDrBk8dt/2pDGwaXKP9J/dCIKpC+to29lMxN
	 ZBGd9ggpxQnOQVeXJwYFPauU06W/kPYGAVxhkIgfU9sDxZhFeIG1ad4WrOn78rE/LM
	 B/OyQHykbiDnqqUatzmgSQdl5uVPyOvO4VDu+oRQ1Avtcw7OgcEnjqTSNF11BO0VbQ
	 IM7xfjxbrdY4w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 328/844] net: usb: sr9700: remove code to drive nonexistent multicast filter
Date: Sat, 28 Feb 2026 12:24:01 -0500
Message-ID: <20260228173244.1509663-329-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220407-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 828231C64FE
X-Rspamd-Action: no action

From: Ethan Nelson-Moore <enelsonmoore@gmail.com>

[ Upstream commit 9a9424c756feee9ee6e717405a9d6fa7bacdef08 ]

Several registers referenced in this driver's source code do not
actually exist (they are not writable and read as zero in my testing).
They exist in this driver because it originated as a copy of the dm9601
driver. Notably, these include the multicast filter registers - this
causes the driver to not support multicast packets correctly. Remove
the multicast filter code and register definitions. Instead, set the
chip to receive all multicast filter packets when any multicast
addresses are in the list.

Reviewed-by: Simon Horman <horms@kernel.org> (from v1)
Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Link: https://patch.msgid.link/20260203013924.28582-1-enelsonmoore@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/Kconfig  |  1 -
 drivers/net/usb/sr9700.c | 25 ++++---------------------
 drivers/net/usb/sr9700.h |  7 +------
 3 files changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 856e648d804e0..da0f6a138f4fc 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -319,7 +319,6 @@ config USB_NET_DM9601
 config USB_NET_SR9700
 	tristate "CoreChip-sz SR9700 based USB 1.1 10/100 ethernet devices"
 	depends on USB_USBNET
-	select CRC32
 	help
 	  This option adds support for CoreChip-sz SR9700 based USB 1.1
 	  10/100 Ethernet adapters.
diff --git a/drivers/net/usb/sr9700.c b/drivers/net/usb/sr9700.c
index 820c4c5069792..a5d364fbc3639 100644
--- a/drivers/net/usb/sr9700.c
+++ b/drivers/net/usb/sr9700.c
@@ -18,7 +18,6 @@
 #include <linux/ethtool.h>
 #include <linux/mii.h>
 #include <linux/usb.h>
-#include <linux/crc32.h>
 #include <linux/usb/usbnet.h>
 
 #include "sr9700.h"
@@ -265,31 +264,15 @@ static const struct ethtool_ops sr9700_ethtool_ops = {
 static void sr9700_set_multicast(struct net_device *netdev)
 {
 	struct usbnet *dev = netdev_priv(netdev);
-	/* We use the 20 byte dev->data for our 8 byte filter buffer
-	 * to avoid allocating memory that is tricky to free later
-	 */
-	u8 *hashes = (u8 *)&dev->data;
 	/* rx_ctl setting : enable, disable_long, disable_crc */
 	u8 rx_ctl = RCR_RXEN | RCR_DIS_CRC | RCR_DIS_LONG;
 
-	memset(hashes, 0x00, SR_MCAST_SIZE);
-	/* broadcast address */
-	hashes[SR_MCAST_SIZE - 1] |= SR_MCAST_ADDR_FLAG;
-	if (netdev->flags & IFF_PROMISC) {
+	if (netdev->flags & IFF_PROMISC)
 		rx_ctl |= RCR_PRMSC;
-	} else if (netdev->flags & IFF_ALLMULTI ||
-		   netdev_mc_count(netdev) > SR_MCAST_MAX) {
-		rx_ctl |= RCR_RUNT;
-	} else if (!netdev_mc_empty(netdev)) {
-		struct netdev_hw_addr *ha;
-
-		netdev_for_each_mc_addr(ha, netdev) {
-			u32 crc = ether_crc(ETH_ALEN, ha->addr) >> 26;
-			hashes[crc >> 3] |= 1 << (crc & 0x7);
-		}
-	}
+	else if (netdev->flags & IFF_ALLMULTI || !netdev_mc_empty(netdev))
+		/* The chip has no multicast filter */
+		rx_ctl |= RCR_ALL;
 
-	sr_write_async(dev, SR_MAR, SR_MCAST_SIZE, hashes);
 	sr_write_reg_async(dev, SR_RCR, rx_ctl);
 }
 
diff --git a/drivers/net/usb/sr9700.h b/drivers/net/usb/sr9700.h
index ea2b4de621c86..c479908f7d823 100644
--- a/drivers/net/usb/sr9700.h
+++ b/drivers/net/usb/sr9700.h
@@ -104,9 +104,7 @@
 #define		WCR_LINKEN		(1 << 5)
 /* Physical Address Reg */
 #define	SR_PAR			0x10	/* 0x10 ~ 0x15 6 bytes for PAR */
-/* Multicast Address Reg */
-#define	SR_MAR			0x16	/* 0x16 ~ 0x1D 8 bytes for MAR */
-/* 0x1e unused */
+/* 0x16 --> 0x1E unused */
 /* Phy Reset Reg */
 #define	SR_PRR			0x1F
 #define		PRR_PHY_RST		(1 << 0)
@@ -161,9 +159,6 @@
 /* parameters */
 #define	SR_SHARE_TIMEOUT	1000
 #define	SR_EEPROM_LEN		256
-#define	SR_MCAST_SIZE		8
-#define	SR_MCAST_ADDR_FLAG	0x80
-#define	SR_MCAST_MAX		64
 #define	SR_TX_OVERHEAD		2	/* 2bytes header */
 #define	SR_RX_OVERHEAD		7	/* 3bytes header + 4crc tail */
 
-- 
2.51.0


