Return-Path: <stable+bounces-169970-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C96B29F55
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BFB716EFFF
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107482765DC;
	Mon, 18 Aug 2025 10:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wZbg41yK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53162765D5
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513881; cv=none; b=WKQ+Orjw3PeF9Jlt8NVD5ELKTO34v67qy1z9AvKzXumztQ8KZ+9SdFCgljOeuo2QhnToG861auKZ2TaqBz9d1WrnjRG8eCAMVgvT1I6KriiUu1Q+so8TkL2XeZdAmFoqm35un8tTQ5u3Di7WYavqD5LflI2DyTpdBMA8rDQbxfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513881; c=relaxed/simple;
	bh=EnesZJruMu9KFKIPhZKmOwEzhiX1uwfwGOfUG++OC9U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=H2qKgDNtrenxxvgFhzVgKyapZFNbbXMEXHoCc2DSURL1Dg/eZquZfg3ixMtm7XLx5+CA6yDLf1iS1okDPT9P7/joUaXCPHYqYOnRSXXIqwCKis10ocxb9p+el7yx0lA1/jARfMdWe6GM+7lV2vv9uwWn+QONUH48ihc7n9dYrf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wZbg41yK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EA0C4CEEB;
	Mon, 18 Aug 2025 10:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755513881;
	bh=EnesZJruMu9KFKIPhZKmOwEzhiX1uwfwGOfUG++OC9U=;
	h=Subject:To:Cc:From:Date:From;
	b=wZbg41yKEt0Kke4hXKmrt+Jg/N7GUiIn6/0nxC3HqRs3UxxLMznDNdTyfgB7L9Q23
	 77sPCEsZzTO/Ut3T8+HD5CxZxCcI4K0wSTh6ak3EkTpQ3mHm4ATs+0NQgXAZpU+pZM
	 NCu+N4SQZEwCUJw4llD2G5lbjXpO43deRXhD3TPM=
Subject: FAILED: patch "[PATCH] usb: typec: fusb302: cache PD RX state" failed to apply to 6.1-stable tree
To: sebastian.reichel@collabora.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:44:32 +0200
Message-ID: <2025081832-rental-utter-f3e1@gregkh>
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
git cherry-pick -x 1e61f6ab08786d66a11cfc51e13d6f08a6b06c56
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081832-rental-utter-f3e1@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1e61f6ab08786d66a11cfc51e13d6f08a6b06c56 Mon Sep 17 00:00:00 2001
From: Sebastian Reichel <sebastian.reichel@collabora.com>
Date: Fri, 4 Jul 2025 19:55:06 +0200
Subject: [PATCH] usb: typec: fusb302: cache PD RX state

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

diff --git a/drivers/usb/typec/tcpm/fusb302.c b/drivers/usb/typec/tcpm/fusb302.c
index f2801279c4b5..a4ff2403ddd6 100644
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


