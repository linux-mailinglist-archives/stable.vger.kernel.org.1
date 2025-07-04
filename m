Return-Path: <stable+bounces-160221-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A72AF9A2C
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 19:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AEFF6E22DD
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 17:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05FA72D839D;
	Fri,  4 Jul 2025 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="laJYEap6"
X-Original-To: stable@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F77E6A8D2;
	Fri,  4 Jul 2025 17:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751651718; cv=none; b=oCKy1HBK07AQ2lm5kOC0Odm4GEVevfTy1bZygAyC9PYifh03U891Svf0HWyvjA0xpPvIg+LgOXChwofBADu0FBXHCY8pgV84lWhZBxjgt2lyaSRuzOQ5MZ3daDTu6yQ8sIDbFsSqc8Tp1BQtZMvGBaj9RoHMcIHPdMqwcuhlUbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751651718; c=relaxed/simple;
	bh=EGZgrTldAmn1FZT1xY8Fa7a4iDUzyJQCZj4MIa86epo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=fDW5XCPKpBEwdOvEJSOyWRBN274X+tOyBjsH7zbhm/3+vqKun36cIVQl4qzYyvWB8K7oQ7Y09OXRQTGC8QzHKnan/dL7RMJNcDFFvzVQ8AanlOUSFM+CMF6SAEfVUBaUjiR45AlKRthA1K/R5glVQhLrOc6Prb4sdeZLSpnys+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=laJYEap6; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1751651714;
	bh=EGZgrTldAmn1FZT1xY8Fa7a4iDUzyJQCZj4MIa86epo=;
	h=From:Date:Subject:To:Cc:From;
	b=laJYEap6GFb00/wn9mafhf6IQMTeVeTmHAp3Z1aH5hcXDbhfrjsbYKxW/6y3kZCIF
	 VxX7ZYhtlXTFlflXQ2JIdxHv8/T9mTCMMms/cyORHU8c3RGvTCrbjWFSLohXNugMUL
	 koMhLx+ocHvd21DwRV3pN1sjRfd26HfgVXHi+pnOdEGDleXJzNxz5r9H6Cr/yuplDH
	 /liGDIl6/IbD2JAbJs5t2IqKf2MtTAscUDZJ2HKc2Y/M/COYWF6m5W7Z817/8V8e/1
	 EI6L46X5kaEOiNvzfxXaELx2v0LsEJ9a/poEvPZLvLDU7guFMpLYrlL2u8v0EBZ+LM
	 qexsRXxVaFl/w==
Received: from jupiter.universe (dyndsl-091-248-191-229.ewe-ip-backbone.de [91.248.191.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6889817E0497;
	Fri,  4 Jul 2025 19:55:14 +0200 (CEST)
Received: by jupiter.universe (Postfix, from userid 1000)
	id 112CB480039; Fri, 04 Jul 2025 19:55:14 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 04 Jul 2025 19:55:06 +0200
Subject: [PATCH] usb: typec: fusb302: cache PD RX state
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250704-fusb302-race-condition-fix-v1-1-239012c0e27a@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHkVaGgC/x2MQQqEMAwAvyI5byBbFdGvLHuoaaq5VGlVBPHvB
 o8zMHNBkaxSYKguyHJo0SUZfD8V8OzTJKjBGBy5ljpqMO5lrMlh9izISwq6WYJRT+yZ+yBdHak
 NYIM1i+l3/vvf9wNQuEiKbAAAAA==
X-Change-ID: 20250704-fusb302-race-condition-fix-9cc9de73f05d
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>, Yueyao Zhu <yueyao@google.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@collabora.com, stable@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3679; i=sre@kernel.org;
 h=from:subject:message-id; bh=EGZgrTldAmn1FZT1xY8Fa7a4iDUzyJQCZj4MIa86epo=;
 b=owJ4nAFtApL9kA0DAAoB2O7X88g7+poByyZiAGhoFYIutKbFxG9ZC7pfUe7LakRxyic00Kn6J
 RegVdFTUvnHCYkCMwQAAQoAHRYhBO9mDQdGP4tyanlUE9ju1/PIO/qaBQJoaBWCAAoJENju1/PI
 O/qaw8oP/2AkpSbmrL4MBvRB0UsZydDjXTxJSk10nHqhOql+jqM+PlvaFhQkwSZu3ooTZCFG84Q
 QDONauuJWwOw/TIhe7X2rE5Oew3cGsK5J1EAH2/q0Tm9HFjgh2eMkANJNfXcctweUv67/CUAWDH
 lgxm9iox3xp0Ul1grabgGtwy/asTMDjNPngWj3rdau7iHOmn1LPg1F0ySZGlWlnkTaXeEOhi9FP
 ayWkLHdBEidWCI42f+5L3mHgxd4+dJc4lkozhiyiCQB5py2/GkQtfF5wDWwkhBHvpJssSF+pLjk
 OCwLeTqBt8o572OP9ivDXAMDe93bWQhcVfpdteo+5HfUTvvC5B/UmGUvsDXQoMvp9x289XKeqwB
 aOqMu1h5P5nW815CSci4X+hY9HZZFO+ILtFIJnZldZ01jHASQrRPDDaRkl90f0DlNin3A2wXBn+
 pWwX608ze/BkOuVNToU8RRJ5u0jc/eOh6Tdh+KuVxsfs6IJmnlPwW7T7pNbvG1MG69vjgB6RkUz
 K47lV0qp1lbnvntfF9BwBWW661DgpQ3sfXeqPvqTcdaN8OotnVWihbIQt4zPJ3QIO1k9c66ZHK5
 pJaEMgoVsgFGTcCZZivi0YjgQPMJwtNN/3dzzuaUQKdW6fBZAt7V6iWrJPuBL3gImuCkWyXtIM/
 KCsSI50GcYO3YQGDMWWIvkA==
X-Developer-Key: i=sre@kernel.org; a=openpgp;
 fpr=EF660D07463F8B726A795413D8EED7F3C83BFA9A

This patch fixes a race condition communication error, which ends up in
PD hard resets when losing the race. Some systems, like the Radxa ROCK
5B are powered through USB-C without any backup power source and use a
FUSB302 chip to do the PD negotiation. This means it is quite important
to avoid hard resets, since that effectively kills the system's
power-supply.

I've found the following race condition while debugging unplanned power
loss during booting the board every now and then:

1. lots of TCPM/FUSB302/PD initialization stuff
2. TCPM ends up in SNK_WAIT_CAPABILITIES (tcpm_set_pd_rx is enabled here)
3. the remote PD source does not send anything, so TCPM does a SOFT RESET
4. TCPM ends up in SNK_WAIT_CAPABILITIES for the second time
   (tcpm_set_pd_rx is enabled again, even though it is still on)

At this point I've seen broken CRC good messages being send by the
FUSB302 with a logic analyzer sniffing the CC lines. Also it looks like
messages are being lost and things generally going haywire with one of
the two sides doing a hard reset once a broken CRC good message was send
to the bus.

I think the system is running into a race condition, that the FIFOs are
being cleared and/or the automatic good CRC message generation flag is
being updated while a message is already arriving.

Let's avoid this by caching the PD RX enabled state, as we have already
processed anything in the FIFOs and are in a good state. As a side
effect that this also optimizes I2C bus usage :)

As far as I can tell the problem theoretically also exists when TCPM
enters SNK_WAIT_CAPABILITIES the first time, but I believe this is less
critical for the following reason:

On devices like the ROCK 5B, which are powered through a TCPM backed
USB-C port, the bootloader must have done some prior PD communication
(initial communication must happen within 5 seconds after plugging the
USB-C plug). This means the first time the kernel TCPM state machine
reaches SNK_WAIT_CAPABILITIES, the remote side is not sending messages
actively. On other devices a hard reset simply adds some extra delay and
things should be good afterwards.

Fixes: c034a43e72dda ("staging: typec: Fairchild FUSB302 Type-c chip driver")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/usb/typec/tcpm/fusb302.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index f15c63d3a8f441569ec98302f5b241430d8e4547..870a71f953f6cd8dfc618caea56f72782e40ee1c 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -104,6 +104,7 @@ struct fusb302_chip {
 	bool vconn_on;
 	bool vbus_on;
 	bool charge_on;
+	bool pd_rx_on;
 	bool vbus_present;
 	enum typec_cc_polarity cc_polarity;
 	enum typec_cc_status cc1;
@@ -841,6 +842,11 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
 	int ret = 0;
 
 	mutex_lock(&chip->lock);
+	if (chip->pd_rx_on == on) {
+		fusb302_log(chip, "pd is already %s", str_on_off(on));
+		goto done;
+	}
+
 	ret = fusb302_pd_rx_flush(chip);
 	if (ret < 0) {
 		fusb302_log(chip, "cannot flush pd rx buffer, ret=%d", ret);
@@ -863,6 +869,8 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
 			    str_on_off(on), ret);
 		goto done;
 	}
+
+	chip->pd_rx_on = on;
 	fusb302_log(chip, "pd := %s", str_on_off(on));
 done:
 	mutex_unlock(&chip->lock);

---
base-commit: c435a4f487e8c6a3b23dafbda87d971d4fd14e0b
change-id: 20250704-fusb302-race-condition-fix-9cc9de73f05d

Best regards,
-- 
Sebastian Reichel <sre@kernel.org>


