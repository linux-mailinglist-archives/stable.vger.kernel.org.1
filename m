Return-Path: <stable+bounces-208191-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95856D1482D
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 18:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 358823010E72
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FE621D599;
	Mon, 12 Jan 2026 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ml6sEg4z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7737E29BDAB
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 17:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239885; cv=none; b=Qayd4Iv1it3bekcoTBwHZN2HZDBSoVu2nk9OLnjkgcispRsnx2S26hh2ENDOuaxn28/RzQEybZP/peN0Da9HOPiersliAB6gW2mGFdiL7D2Ik6botTnc10AiyFWAQ4ICvDCNPJsXLM6Q9NgNCCW+nQGMXZVE+L3R+TlQGsCYysg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239885; c=relaxed/simple;
	bh=LWh5x5G3jMTRKW0hDoum0VXDTzlAc1WYRy7mFvfibZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEbf6UBz37CI9XeLdUSuYE/5S9X6iNT9whDvoj6TgOLu0o3P3GTeTD9mHoxIQVX9AC4mNoMj77s9cicFD+D+SV4B6MjlKU2bFniabIXDO8hpxrUG3ilb7VuYS/m1FgkC8zOvZSiTDdSq2K7h1xQtm0AMee8lrRruozy5wx9X7H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ml6sEg4z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8BFC116D0;
	Mon, 12 Jan 2026 17:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768239885;
	bh=LWh5x5G3jMTRKW0hDoum0VXDTzlAc1WYRy7mFvfibZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ml6sEg4z3PFR5Jxz9oK/X7cKZ4TYKtc2UZftkmTI9E0Qz/nGDzb/xMrygdK1P+IUY
	 jvI1PNFV0k3h2CvlTh3UqM79dEsF6PpHX6bL+allRhL93dNRSeQnSb7ACXVq247VNP
	 +vTyeI4As1dOzGmuOdlv6Sevoq4xb7huJuXjMRv5DRCepwQdTd/74t2i1xDOP35wwA
	 k2v30ka1eLY4v2FMjAAzAj3FtFUH/J96sEOdV3cQZIh5YkHpMNa9Fqqjo89EK8wUVx
	 yQa6CaaE34+WpUFhVtQJaslvZaZcE98f+KsBCea8LNaqB9R95/qUe4oYr/1gz4eE50
	 Z+uHT/nSpQsHw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Abdun Nihaal <nihaal@cse.iitm.ac.in>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] gpio: mpsse: fix reference leak in gpio_mpsse_probe() error paths
Date: Mon, 12 Jan 2026 12:44:41 -0500
Message-ID: <20260112174441.830780-3-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260112174441.830780-1-sashal@kernel.org>
References: <2026011202-scheming-operating-3cbb@gregkh>
 <20260112174441.830780-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Abdun Nihaal <nihaal@cse.iitm.ac.in>

[ Upstream commit 1e876e5a0875e71e34148c9feb2eedd3bf6b2b43 ]

The reference obtained by calling usb_get_dev() is not released in the
gpio_mpsse_probe() error paths. Fix that by using device managed helper
functions. Also remove the usb_put_dev() call in the disconnect function
since now it will be released automatically.

Cc: stable@vger.kernel.org
Fixes: c46a74ff05c0 ("gpio: add support for FTDI's MPSSE as GPIO")
Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Link: https://lore.kernel.org/r/20251226060414.20785-1-nihaal@cse.iitm.ac.in
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpio-mpsse.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mpsse.c b/drivers/gpio/gpio-mpsse.c
index e68179caafa62..120b27183b1d9 100644
--- a/drivers/gpio/gpio-mpsse.c
+++ b/drivers/gpio/gpio-mpsse.c
@@ -538,6 +538,13 @@ static void gpio_mpsse_ida_remove(void *data)
 	ida_free(&gpio_mpsse_ida, priv->id);
 }
 
+static void gpio_mpsse_usb_put_dev(void *data)
+{
+	struct mpsse_priv *priv = data;
+
+	usb_put_dev(priv->udev);
+}
+
 static int mpsse_init_valid_mask(struct gpio_chip *chip,
 				 unsigned long *valid_mask,
 				 unsigned int ngpios)
@@ -582,6 +589,10 @@ static int gpio_mpsse_probe(struct usb_interface *interface,
 	INIT_LIST_HEAD(&priv->workers);
 
 	priv->udev = usb_get_dev(interface_to_usbdev(interface));
+	err = devm_add_action_or_reset(dev, gpio_mpsse_usb_put_dev, priv);
+	if (err)
+		return err;
+
 	priv->intf = interface;
 	priv->intf_id = interface->cur_altsetting->desc.bInterfaceNumber;
 
@@ -703,7 +714,6 @@ static void gpio_mpsse_disconnect(struct usb_interface *intf)
 
 	priv->intf = NULL;
 	usb_set_intfdata(intf, NULL);
-	usb_put_dev(priv->udev);
 }
 
 static struct usb_driver gpio_mpsse_driver = {
-- 
2.51.0


