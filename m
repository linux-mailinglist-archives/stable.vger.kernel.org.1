Return-Path: <stable+bounces-169968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 485C8B29F54
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 12:44:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82D8918890E3
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 10:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6642765D3;
	Mon, 18 Aug 2025 10:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="g/FwBXaW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4F62765C9
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 10:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755513875; cv=none; b=hMKKzCCI2ZsV2ziBKKNiP0Ve/adsmIIBDTn6If716sb3aewz2h/dATGBSRa8OHnjJDqOF2fsRyhD/Mg0iZ5noW5wQvbKieNCcoeCVNkSu7Mtt5zWRf/hkt3+5n2h3uD94REfM6lpHX7RiLNjXC/3FViJn7uD6crN7pSWiw4UVQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755513875; c=relaxed/simple;
	bh=N5EpnPlTE+mAu+tfs/Mf8eqzzhIB/8Q1orqBob0r12Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a9qZC+QxF2IYwdz3voo2NIf8E6e0gH9eV1FpsoOkFE3Jdmz+u6JQb2iUevNI+M0lEMoRPDaoYmPIHdTBPt5c/yA8aZsyWgXm1K2Azk8ywfcPUQejtIfePSA0JoE/LN+urPetrmoHgQI+CD5zkDMgjgwE8gPiJNSglpGoAk1/SE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=g/FwBXaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26936C4CEEB;
	Mon, 18 Aug 2025 10:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755513873;
	bh=N5EpnPlTE+mAu+tfs/Mf8eqzzhIB/8Q1orqBob0r12Q=;
	h=Subject:To:Cc:From:Date:From;
	b=g/FwBXaWw1q54Y3TGYqM9eCUKLCxG7ZDq1OPqn8x7wfUKy/OwbjOrhFl0HKmex2jo
	 N5bibTMapdtJKSnkf7G027fyfX7qsuENtLiifa5ucvEoKbYFfwJn2mUmth4c5c6UO1
	 GSnagustIhZEttPUYf9e+rX8BKPrNFhQFcgrN7f8=
Subject: FAILED: patch "[PATCH] usb: typec: fusb302: cache PD RX state" failed to apply to 6.12-stable tree
To: sebastian.reichel@collabora.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 18 Aug 2025 12:44:30 +0200
Message-ID: <2025081830-selected-dandelion-46ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1e61f6ab08786d66a11cfc51e13d6f08a6b06c56
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025081830-selected-dandelion-46ec@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


