Return-Path: <stable+bounces-43524-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2B08C203A
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 11:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A20E21C216DF
	for <lists+stable@lfdr.de>; Fri, 10 May 2024 09:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E5C77119;
	Fri, 10 May 2024 09:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gLuJtcW+"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2714901F
	for <stable@vger.kernel.org>; Fri, 10 May 2024 09:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715332139; cv=none; b=fWVYpAgyRzFLKRZ1EcCXJElEUv8YT7rdDX5ysbWbEvT3Hx6RG5zj34Vn3XbPZVJHhpCePP1LMqeKG0Xtkedpm+/W5bSr+dsUHwI0FUD6yPFiJrmJQzNKtnk2lJAqGuWqaezARa4AAdo5rh/z7rcsQhlV/CE8a6xe+6vz2zoRlDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715332139; c=relaxed/simple;
	bh=I04nZi4eDHjXV0NwFmOXhSYav1tj+JZIjFxquAOBChw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PL7DP5IpJgxHRPr0kEkVxRZdnp2Vp0UNR9ebZUy7QNbzVmbyKXfZjIE8dAJhS7qrdlZOjb20dqqN6xrF/SSvfChMNbDtSvE9M0fqm1sPnMnT+KoiM4ZCaCcedLRUV1pAKEDV/DwIIhB7CmV+sqS2axp+TasEAwCXTRcgrilbvE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gLuJtcW+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715332136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=G0EvWCNfwA9x7KaIVr6ruCAINAZy8qYnlw/yafFrBXk=;
	b=gLuJtcW+NhBYTPLyyGhBr6zJIvJETDkMKPvlvIkO4Kk4zNz1bPFb0MA6AjqCEck1Wfx/EW
	FX4yN1cGgk3nm8bkvoSW9qX+NkUsemym+GzIceKb13MIC5e4pUEj617Teilh5K3k/s6DXY
	B+aOGqcYJTMf1Pmsh2ZO/9bgbMl8zdw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-P6WCIJl4MZWzY1hAMHkBrA-1; Fri, 10 May 2024 05:08:54 -0400
X-MC-Unique: P6WCIJl4MZWzY1hAMHkBrA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3EBE7800206;
	Fri, 10 May 2024 09:08:54 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.109])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0A6A9200A612;
	Fri, 10 May 2024 09:08:51 +0000 (UTC)
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
	Isaac Ganoung <inventor500@vivaldi.net>,
	Yongqin Liu <yongqin.liu@linaro.org>
Subject: [PATCH] net: usb: ax88179_178a: fix link status when link is set to down/up
Date: Fri, 10 May 2024 11:08:28 +0200
Message-ID: <20240510090846.328201-1-jtornosm@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

The idea was to keep only one reset at initialization stage in order to
reduce the total delay, or the reset from usbnet_probe or the reset from
usbnet_open.

I have seen that restarting from usbnet_probe is necessary to avoid doing
too complex things. But when the link is set to down/up (for example to
configure a different mac address) the link is not correctly recovered
unless a reset is commanded from usbnet_open.

So, detect the initialization stage (first call) to not reset from
usbnet_open after the reset from usbnet_probe and after this stage, always
reset from usbnet_open too (when the link needs to be rechecked).

Apply to all the possible devices, the behavior now is going to be the same.

cc: stable@vger.kernel.org # 6.6+
Fixes: 56f78615bcb1 ("net: usb: ax88179_178a: avoid writing the mac address before first reading")
Reported-by: Isaac Ganoung <inventor500@vivaldi.net>
Reported-by: Yongqin Liu <yongqin.liu@linaro.org>
Signed-off-by: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
---
 drivers/net/usb/ax88179_178a.c | 37 ++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 377be0d9ef14..a0edb410f746 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -174,6 +174,7 @@ struct ax88179_data {
 	u32 wol_supported;
 	u32 wolopts;
 	u8 disconnecting;
+	u8 initialized;
 };
 
 struct ax88179_int_data {
@@ -1672,6 +1673,18 @@ static int ax88179_reset(struct usbnet *dev)
 	return 0;
 }
 
+static int ax88179_net_reset(struct usbnet *dev)
+{
+	struct ax88179_data *ax179_data = dev->driver_priv;
+
+	if (ax179_data->initialized)
+		ax88179_reset(dev);
+	else
+		ax179_data->initialized = 1;
+
+	return 0;
+}
+
 static int ax88179_stop(struct usbnet *dev)
 {
 	u16 tmp16;
@@ -1691,6 +1704,7 @@ static const struct driver_info ax88179_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1703,6 +1717,7 @@ static const struct driver_info ax88178a_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1715,7 +1730,7 @@ static const struct driver_info cypress_GX3_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1728,7 +1743,7 @@ static const struct driver_info dlink_dub1312_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1741,7 +1756,7 @@ static const struct driver_info sitecom_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1754,7 +1769,7 @@ static const struct driver_info samsung_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1767,7 +1782,7 @@ static const struct driver_info lenovo_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset = ax88179_reset,
+	.reset = ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1780,7 +1795,7 @@ static const struct driver_info belkin_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset	= ax88179_reset,
+	.reset	= ax88179_net_reset,
 	.stop	= ax88179_stop,
 	.flags	= FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1793,7 +1808,7 @@ static const struct driver_info toshiba_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset	= ax88179_reset,
+	.reset	= ax88179_net_reset,
 	.stop = ax88179_stop,
 	.flags	= FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1806,7 +1821,7 @@ static const struct driver_info mct_info = {
 	.unbind	= ax88179_unbind,
 	.status	= ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset	= ax88179_reset,
+	.reset	= ax88179_net_reset,
 	.stop	= ax88179_stop,
 	.flags	= FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1819,7 +1834,7 @@ static const struct driver_info at_umc2000_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset  = ax88179_reset,
+	.reset  = ax88179_net_reset,
 	.stop   = ax88179_stop,
 	.flags  = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1832,7 +1847,7 @@ static const struct driver_info at_umc200_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset  = ax88179_reset,
+	.reset  = ax88179_net_reset,
 	.stop   = ax88179_stop,
 	.flags  = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
@@ -1845,7 +1860,7 @@ static const struct driver_info at_umc2000sp_info = {
 	.unbind = ax88179_unbind,
 	.status = ax88179_status,
 	.link_reset = ax88179_link_reset,
-	.reset  = ax88179_reset,
+	.reset  = ax88179_net_reset,
 	.stop   = ax88179_stop,
 	.flags  = FLAG_ETHER | FLAG_FRAMING_AX,
 	.rx_fixup = ax88179_rx_fixup,
-- 
2.44.0


