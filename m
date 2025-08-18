Return-Path: <stable+bounces-171657-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3B2B2B26C
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 22:31:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC3443BE5C1
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 20:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D25220F3E;
	Mon, 18 Aug 2025 20:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CoDPC1pT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB23E1EDA0E
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755549030; cv=none; b=lSqVj2Uweftffrpdxo7sLmcj44EyRSvQOHcZLPomEJtPTokaj+SvaJI11ptQB65yphFk2A3qzI4ZP2k+vkeK//QVPrPtq02QmCu03zB7QSDh+2HA7G/sp6SJl5YnM++L2c2fCeX0hGLHkwzJQ7F/tuHqk79gT95JjiZ1qv4KWgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755549030; c=relaxed/simple;
	bh=yw/dBMz3R/I0QXjLvJ6S/SxCuFsQHU75DOAW3TM7iG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hqJ2bvp2bvYRI/HiN7y3g8j0PCURoxmbTSLicN8quAkkp2vXLdEaB1MML8ThHvZvfjti96U2+xOfZPQGFDoU7CupWhiRiIq87zyvManCscqG9SEh3v+xSyLcXxIP46/1nZxBtkSxaeaPsB4R/PODYK4GgwpAfbxnBPbhmUQjQ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CoDPC1pT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF23C4CEEB;
	Mon, 18 Aug 2025 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755549029;
	bh=yw/dBMz3R/I0QXjLvJ6S/SxCuFsQHU75DOAW3TM7iG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CoDPC1pT01q+r1QJlkLLsLPG5+YLqNgMyxq0AtKaMnN9XxLtQNPdIj0s1AXcSWBtG
	 BRhOKOK3xSd+VBJQ5y2O1Lamt1BnNL5zkHgpiiJOv7wq4ji9+X0i55w4uFggIFRtaW
	 p1PCjOwDCHX3U7AdR8cHgVWtVtzoTD/yRxTdG7Eh+lTA4WpjPBZ9FYVv93MLMIOgCh
	 KaMG8hdApg1XbZPCGnW1QSSpaU/KCH9lwOyLdiRuQ9mz8Pd9Vzl0EA+8vrJ+IX6ytq
	 64BImkeGDH0SVmzgUVMjCJJeYIwz9jiFbLiYL7nLuXaeIPjntuVueVLwdcLjdrGFCL
	 hR7eJrjx+b3ow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: typec: fusb302: cache PD RX state
Date: Mon, 18 Aug 2025 16:30:26 -0400
Message-ID: <20250818203026.76749-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081832-rental-utter-f3e1@gregkh>
References: <2025081832-rental-utter-f3e1@gregkh>
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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/tcpm/fusb302.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index 721b2a548084..ded3f6fe8b00 100644
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
+		fusb302_log(chip, "pd is already %s", str_on_off(on));
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


