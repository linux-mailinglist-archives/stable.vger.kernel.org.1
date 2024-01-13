Return-Path: <stable+bounces-10791-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6CF82CBA1
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 11:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89459284553
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215141EEE6;
	Sat, 13 Jan 2024 10:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DA9dWA34"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8951869;
	Sat, 13 Jan 2024 10:01:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD1AC433C7;
	Sat, 13 Jan 2024 10:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705140114;
	bh=mlRzqZEuA/EbWorqg5gN1p4Xw9SMCSlPrqYOyccnADU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DA9dWA34AbE29hi4emUEkRU9fQZonwICT1nYKQheXXdIihI2LbzIKMRF3BtrSQp9F
	 HOXu7J94iAUvvKRYOp3IE/YC/3KBEzUtlJoQG1htZLcZHroP7TaCokEKX1ynEoN35k
	 SdZegyIbJ9pc6zF0wqgmzT/5XPwzFjNopG3yp1Zw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Chen <justinpopo6@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jeffery Miller <jefferymiller@google.com>
Subject: [PATCH 5.15 59/59] net: usb: ax88179_178a: move priv to driver_priv
Date: Sat, 13 Jan 2024 10:50:30 +0100
Message-ID: <20240113094211.086372029@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094209.301672391@linuxfoundation.org>
References: <20240113094209.301672391@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Justin Chen <justinpopo6@gmail.com>

commit 2bcbd3d8a7b4525cdb741fe82330edb6f5452c7f upstream.

We need more space to save WoL context. So lets allocate memory
for ax88179_data instead of using struct usbnet data field which
only supports 5 words. We continue to use the struct usbnet data
field for multicast filters. However since we no longer have the
private data stored there, we can shift it to the beginning.

Signed-off-by: Justin Chen <justinpopo6@gmail.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Cc: Jeffery Miller <jefferymiller@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/ax88179_178a.c |   32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -170,7 +170,6 @@ struct ax88179_data {
 	u8  eee_enabled;
 	u8  eee_active;
 	u16 rxctl;
-	u16 reserved;
 	u8 in_pm;
 	u32 wol_supported;
 	u32 wolopts;
@@ -193,14 +192,14 @@ static const struct {
 
 static void ax88179_set_pm_mode(struct usbnet *dev, bool pm_mode)
 {
-	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+	struct ax88179_data *ax179_data = dev->driver_priv;
 
 	ax179_data->in_pm = pm_mode;
 }
 
 static int ax88179_in_pm(struct usbnet *dev)
 {
-	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+	struct ax88179_data *ax179_data = dev->driver_priv;
 
 	return ax179_data->in_pm;
 }
@@ -733,7 +732,7 @@ ax88179_ethtool_set_eee(struct usbnet *d
 static int ax88179_chk_eee(struct usbnet *dev)
 {
 	struct ethtool_cmd ecmd = { .cmd = ETHTOOL_GSET };
-	struct ax88179_data *priv = (struct ax88179_data *)dev->data;
+	struct ax88179_data *priv = dev->driver_priv;
 
 	mii_ethtool_gset(&dev->mii, &ecmd);
 
@@ -836,7 +835,7 @@ static void ax88179_enable_eee(struct us
 static int ax88179_get_eee(struct net_device *net, struct ethtool_eee *edata)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = (struct ax88179_data *)dev->data;
+	struct ax88179_data *priv = dev->driver_priv;
 
 	edata->eee_enabled = priv->eee_enabled;
 	edata->eee_active = priv->eee_active;
@@ -847,7 +846,7 @@ static int ax88179_get_eee(struct net_de
 static int ax88179_set_eee(struct net_device *net, struct ethtool_eee *edata)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *priv = (struct ax88179_data *)dev->data;
+	struct ax88179_data *priv = dev->driver_priv;
 	int ret;
 
 	priv->eee_enabled = edata->eee_enabled;
@@ -898,8 +897,8 @@ static const struct ethtool_ops ax88179_
 static void ax88179_set_multicast(struct net_device *net)
 {
 	struct usbnet *dev = netdev_priv(net);
-	struct ax88179_data *data = (struct ax88179_data *)dev->data;
-	u8 *m_filter = ((u8 *)dev->data) + 12;
+	struct ax88179_data *data = dev->driver_priv;
+	u8 *m_filter = ((u8 *)dev->data);
 
 	data->rxctl = (AX_RX_CTL_START | AX_RX_CTL_AB | AX_RX_CTL_IPE);
 
@@ -911,7 +910,7 @@ static void ax88179_set_multicast(struct
 	} else if (netdev_mc_empty(net)) {
 		/* just broadcast and directed */
 	} else {
-		/* We use the 20 byte dev->data for our 8 byte filter buffer
+		/* We use dev->data for our 8 byte filter buffer
 		 * to avoid allocating memory that is tricky to free later
 		 */
 		u32 crc_bits;
@@ -1310,11 +1309,15 @@ static void ax88179_get_mac_addr(struct
 
 static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
 {
-	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+	struct ax88179_data *ax179_data;
 
 	usbnet_get_endpoints(dev, intf);
 
-	memset(ax179_data, 0, sizeof(*ax179_data));
+	ax179_data = kzalloc(sizeof(*ax179_data), GFP_KERNEL);
+	if (!ax179_data)
+		return -ENOMEM;
+
+	dev->driver_priv = ax179_data;
 
 	dev->net->netdev_ops = &ax88179_netdev_ops;
 	dev->net->ethtool_ops = &ax88179_ethtool_ops;
@@ -1343,6 +1346,7 @@ static int ax88179_bind(struct usbnet *d
 
 static void ax88179_unbind(struct usbnet *dev, struct usb_interface *intf)
 {
+	struct ax88179_data *ax179_data = dev->driver_priv;
 	u16 tmp16;
 
 	/* Configure RX control register => stop operation */
@@ -1355,6 +1359,8 @@ static void ax88179_unbind(struct usbnet
 	/* Power down ethernet PHY */
 	tmp16 = 0;
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_PHYPWR_RSTCTL, 2, 2, &tmp16);
+
+	kfree(ax179_data);
 }
 
 static void
@@ -1527,7 +1533,7 @@ ax88179_tx_fixup(struct usbnet *dev, str
 
 static int ax88179_link_reset(struct usbnet *dev)
 {
-	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+	struct ax88179_data *ax179_data = dev->driver_priv;
 	u8 tmp[5], link_sts;
 	u16 mode, tmp16, delay = HZ / 10;
 	u32 tmp32 = 0x40000000;
@@ -1602,7 +1608,7 @@ static int ax88179_reset(struct usbnet *
 	u8 buf[5];
 	u16 *tmp16;
 	u8 *tmp;
-	struct ax88179_data *ax179_data = (struct ax88179_data *)dev->data;
+	struct ax88179_data *ax179_data = dev->driver_priv;
 	struct ethtool_eee eee_data;
 
 	tmp16 = (u16 *)buf;



