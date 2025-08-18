Return-Path: <stable+bounces-171668-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4748CB2B440
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 00:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A04CA7A2E11
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 22:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5564B253B43;
	Mon, 18 Aug 2025 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iECbXGNe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B95BAF0
	for <stable@vger.kernel.org>; Mon, 18 Aug 2025 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755557669; cv=none; b=PmH/0X3R9ID/05TUrJhCNUEGlR0FGYYGQhBvuH/zf4AP5HzkPYC7Mtpwf6uSbtfHfsZIOLPuna2yPW4yFekArLlnLGYpxdPZEuDH8afmSGrerarVQo57D6UvJ6+5ShV6LLCmnMVI1IO+S9U+LGw7ULIpPU+oCdsj74dJGpE9a9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755557669; c=relaxed/simple;
	bh=m9W4KMr37jGZ/0gLVa7+CzbmcGYqPaTvSpN31p+nLyA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbeX5N+5R4LqyDJkwOVj+jO6teFC/7mtla9DkgABfyUJa73fVYjFsXW0IqtDrqaWMh+e7bsCAz2Cc3Q/atkcp/yrdOE1v1NoJ+vCm29OHwPZMlSHq/ZyW6G44vmFu9LGhhRaCKSq9PA2JvL7S2iz2O6MgrNdx25ZPJg6GPiO2Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iECbXGNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C2CC4CEEB;
	Mon, 18 Aug 2025 22:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755557668;
	bh=m9W4KMr37jGZ/0gLVa7+CzbmcGYqPaTvSpN31p+nLyA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iECbXGNeUzfmsT5VMA0N4Btrh8BapbZZVFrMOiOrfluXSpbJ5ZB8vFGDvr8yeEOUk
	 fWg5REW4jO+lVmouJ/X46hk40bG/RxJ7FuD437Qc1Yk9waTGrOI6kWbhHlKYWhWXs/
	 wqCizhN3hSPJ+RiKrr+gFKU7VZrm5tBimYxpYLdzvOVO6C1F5t5pfqHL/aljU4Mml4
	 FgB7hKqnuAQqM5HDVd73AHlS2iIeQucUPiF4AriIWWAOWQlZcK/qsQHQWVqTRRmtec
	 3fMBJE/d818/z5St55ua8JI+QI95ZzGNb1hQG+G1ryxA6OEsfxrZ0twkrYchXBIf3L
	 o+Ran/bV4hbSA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sebastian Reichel <sebastian.reichel@collabora.com>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: typec: fusb302: cache PD RX state
Date: Mon, 18 Aug 2025 18:54:25 -0400
Message-ID: <20250818225425.129459-1-sashal@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <2025081834-staff-ranged-09c8@gregkh>
References: <2025081834-staff-ranged-09c8@gregkh>
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
index 700e38e92152..f0eb65cf9393 100644
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


