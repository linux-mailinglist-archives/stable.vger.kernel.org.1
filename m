Return-Path: <stable+bounces-37951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A0889EF4F
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 11:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D88C81C21384
	for <lists+stable@lfdr.de>; Wed, 10 Apr 2024 09:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249571591F3;
	Wed, 10 Apr 2024 09:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iHOlmG/s"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6678C157E6E
	for <stable@vger.kernel.org>; Wed, 10 Apr 2024 09:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742991; cv=none; b=SVFWTRt+WGKu2lzn1on0lQTNmISSowxVNnds61KnRUd/1r0/owe+mgZPQskhy6Q9xfqufe/TgaudwwPOh2Boxa/DY+mtHvaaYHbp4HGZerbcQVXiqJX4b+zXlKYUaPpoUR8k3UrDtLzV9hMeEI4yiV2dTUf+SioZMP5RExkULmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742991; c=relaxed/simple;
	bh=6RyjuDcWsZO20Mdq+RG05EtCrq1VHou3GzobE5FL86k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YAOKI3aflpx0cI2wb4qMpOkms/lrJ5aUAfYxxRTVIfvZsZ7VyI7rFTgDVGRVIaqHBLuT3OTcEfP6vas+4nB088QvGfYFREmnyaHUI1e/UOP4nQpKbuOmf48AEoTgkkxk2MhbCVMxY1EOHoPiDdqr7KzKgf8nLg5A8Ui/UBc3Gwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iHOlmG/s; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712742989;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GpBfMhS04qgT23TOMbDyVoHFEuB0U5xK3Cly3cM2U5g=;
	b=iHOlmG/sJJ5iqf/1JlajhqrXtUKT+7Mzx2GP2wLx8oIPXC6/QWrt0a2oWSVPgXSLOV42TY
	P6OyqTdIPKuzRcbCcad6K5EQ+fvmAkJwwfX/U0ixE/Q8g0Gq49NXTydHPhcJQdQnGLz+Nj
	f43KIfDeRWI30WcbPwxEMZPc6iURDiI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-LXAg-BT_NdmBkTKRCBGFEg-1; Wed,
 10 Apr 2024 05:56:24 -0400
X-MC-Unique: LXAg-BT_NdmBkTKRCBGFEg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80ECC1C4C381;
	Wed, 10 Apr 2024 09:56:23 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.244])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 170DA2166B34;
	Wed, 10 Apr 2024 09:56:19 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>,
	stable@vger.kernel.org,
	Jarkko Palviainen <jarkko.palviainen@gmail.com>
Subject: [PATCH] net: usb: ax88179_178a: avoid writing the mac address before first reading
Date: Wed, 10 Apr 2024 11:55:49 +0200
Message-ID: <20240410095603.502566-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

After the commit d2689b6a86b9 ("net: usb: ax88179_178a: avoid two
consecutive device resets"), reset operation, in which the default mac
address from the device is read, is not executed from bind operation and
the random address, that is pregenerated just in case, is direclty written
the first time in the device, so the default one from the device is not
even read. This writing is not dangerous because is volatile and the
default mac address is not missed.

In order to avoid this, do not allow writing a mac address directly into
the device, if the default mac address from the device has not been read
yet.

cc: stable@vger.kernel.org # 6.6+
Fixes: d2689b6a86b9 ("net: usb: ax88179_178a: avoid two consecutive device resets")
Reported-by: Jarkko Palviainen <jarkko.palviainen@gmail.com>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/usb/ax88179_178a.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 69169842fa2f..650bb7b6badf 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -174,6 +174,7 @@ struct ax88179_data {
 	u32 wol_supported;
 	u32 wolopts;
 	u8 disconnecting;
+	u8 mac_address_read;
 };
 
 struct ax88179_int_data {
@@ -969,9 +970,12 @@ static int ax88179_change_mtu(struct net_device *net, int new_mtu)
 static int ax88179_set_mac_addr(struct net_device *net, void *p)
 {
 	struct usbnet *dev = netdev_priv(net);
+	struct ax88179_data *ax179_data = dev->driver_priv;
 	struct sockaddr *addr = p;
 	int ret;
 
+	if (!ax179_data->mac_address_read)
+		return -EAGAIN;
 	if (netif_running(net))
 		return -EBUSY;
 	if (!is_valid_ether_addr(addr->sa_data))
@@ -1256,6 +1260,7 @@ static int ax88179_led_setting(struct usbnet *dev)
 
 static void ax88179_get_mac_addr(struct usbnet *dev)
 {
+	struct ax88179_data *ax179_data = dev->driver_priv;
 	u8 mac[ETH_ALEN];
 
 	memset(mac, 0, sizeof(mac));
@@ -1281,6 +1286,9 @@ static void ax88179_get_mac_addr(struct usbnet *dev)
 
 	ax88179_write_cmd(dev, AX_ACCESS_MAC, AX_NODE_ID, ETH_ALEN, ETH_ALEN,
 			  dev->net->dev_addr);
+
+	ax179_data->mac_address_read = 1;
+	netdev_info(dev->net, "MAC address: %pM\n", dev->net->dev_addr);
 }
 
 static int ax88179_bind(struct usbnet *dev, struct usb_interface *intf)
-- 
2.44.0


