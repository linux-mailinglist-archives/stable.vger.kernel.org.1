Return-Path: <stable+bounces-171665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0456B2B431
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 744A41BA027C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 22:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36C30199931;
	Mon, 18 Aug 2025 22:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFEe2DLs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E868E3451BF
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 22:46:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755557211; cv=none; b=R22RVep9dz72dwkxit+jGdjkWgZYNCKQ+iAXmmFEpgrHEZYlK35rAMi0ct6nVQvpW7Gw3IezdhapvdPgVXMa2VIiTavawFSThh1Q93iAykKrYU5VKsNKZHrBwyDD907C5aWPSR55YxDnYEl9rHsBrdyRXhoLiG1YTjJI0dVrsww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755557211; c=relaxed/simple;
	bh=AMIQ3lvP0Ukd5np1+g1tvQrmkNtu1GcEjqGGrk1DPAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JHaxB1YNBjrIsn49WoYiUOYUdoUd6hckC5/d69Y2sCv5BS1mF/R4mbdQMECnuWRdaOeirSasD7Fz6wDX0EMqWSNVjLWbGcm1zsI0bGaUr7gqG8DhCysfV1FOYcSoH0Aw9mFVhRTzrY9FX1WiTOdqgWH23MqyojP7HXx6Q33gL8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFEe2DLs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5E8C4CEEB;
	Mon, 18 Aug 2025 22:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755557210;
	bh=AMIQ3lvP0Ukd5np1+g1tvQrmkNtu1GcEjqGGrk1DPAw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gFEe2DLsfKGN0qyLgzqEMpENFred9CMTd/tutTJd24L4IqwIOFTz9zwPMUQsSFQkj
	 +mQ9+9QcJO+TKQl7kw6Fo7wvlqgwVDpEYSecsfznyuKsd1s7y8mh9NHrQvt7CdiPN6
	 tYMIjuQFT8O6WNi9o4KA9N9s3AzeYW0CL4Hm8av4IaamikK5fl6+EAWLFBb6DOm4LI
	 eelw9Hr/56WrfdpfQYrlfJFn7yR9y8+Tv+/oQ1qCHNuQmkEJxzOQ1Mi+zYMzk5/Kv5
	 z10rzRP38VI5lVOTZGVoROBkqrYJ5ir7CPs1TrVIdMD3vhYXZbMgK3Ym+/Y2h0O4gw
	 ofVVXBMaFwd8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: typec: fusb302: cache PD RX state
Date: Mon, 18 Aug 2025 18:46:47 -0400
Message-ID: <20250818224647.124559-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081833-chatting-dragging-a84b@gregkh>
References: <2025081833-chatting-dragging-a84b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sebastian Reichel <sebastian.reichel@collabora.com>

[ Upstream commit 1e61f6ab08786d66a11cfc51e13d6f08a6b06c56 ]

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
Cc: stable <stable@kernel.org>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20250704-fusb302-race-condition-fix-v1-1-239012c0e27a@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ replaced str_on_off(on) with ternary operator ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/fusb302.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 96c55eaf3f80..2ec67debc4ce 100644
--- a/drivers/usb/typec/tcpm/fusb302.c
+++ b/drivers/usb/typec/tcpm/fusb302.c
@@ -103,6 +103,7 @@ struct fusb302_chip {
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
+		fusb302_log(chip, "pd is already %s", on ? "on" : "off");
+		goto done;
+	}
+
 	ret = fusb302_pd_rx_flush(chip);
 	if (ret < 0) {
 		fusb302_log(chip, "cannot flush pd rx buffer, ret=%d", ret);
@@ -863,6 +869,8 @@ static int tcpm_set_pd_rx(struct tcpc_dev *dev, bool on)
 			    on ? "on" : "off", ret);
 		goto done;
 	}
+
+	chip->pd_rx_on = on;
 	fusb302_log(chip, "pd := %s", on ? "on" : "off");
 done:
 	mutex_unlock(&chip->lock);
-- 
2.50.1


