Return-Path: <stable+bounces-125910-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 137D8A6DEA3
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F21C16634A
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 15:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22CD925FA04;
	Mon, 24 Mar 2025 15:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GophNTyM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D7325E444
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 15:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742830119; cv=none; b=ez3NNkmfKZYcC4U2vc9mD3gQA/2UEVTsj5u63lRSdTS3EMy7RgG7tX6TYbpnjAqfxwMN1V5Hd3UoRdrtHIrdGrx3S48nRarUTgDMm2XfHLnKewOoWHE//wCULrOs5BDQ3YrewQ9UxEaM/jGp3O+rtqdCa8d7elguItwt+ZRWVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742830119; c=relaxed/simple;
	bh=XsWKykld3WpAZJSnaMJcqIe+0oxwy0R5oRF4Noq0xm8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=IYNHuoXlSsVXhma5iOV1nhBH75sgRRPFYgk7dZF///weDoJlHfdm6z3gs7GN/KD/MQxrkh1zzp5A30R2zdM3JY0BnnZyCRFA1ENP84nFx81ADY/U3MBXSMPuaeBosvegqStmr/nN34KcJL+OZoKnijqVRoFEBSU+FXMla1YIH+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GophNTyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3258EC4CEDD;
	Mon, 24 Mar 2025 15:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742830119;
	bh=XsWKykld3WpAZJSnaMJcqIe+0oxwy0R5oRF4Noq0xm8=;
	h=Subject:To:Cc:From:Date:From;
	b=GophNTyM4pbiEdBf4lVy71Is9bTbB+vzZ1XwSb7JhBz8qy5XdiT3Cc9rfCV946P8a
	 kz/3vlR8b3FV5AKRG9tVJjRiyCvmyX/57wxa9xopWyE5vqsX5wBdeStbO+iV5b6WKo
	 8D4lA9fyY2+uuJ9VMu91KP25FMxFTXV8cE/ZU20Y=
Subject: FAILED: patch "[PATCH] can: flexcan: only change CAN state when link up in system PM" failed to apply to 5.4-stable tree
To: haibo.chen@nxp.com,mkl@pengutronix.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 24 Mar 2025 08:27:08 -0700
Message-ID: <2025032408-modular-regally-492c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x fd99d6ed20234b83d65b9c5417794343577cf3e5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032408-modular-regally-492c@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fd99d6ed20234b83d65b9c5417794343577cf3e5 Mon Sep 17 00:00:00 2001
From: Haibo Chen <haibo.chen@nxp.com>
Date: Fri, 14 Mar 2025 19:01:44 +0800
Subject: [PATCH] can: flexcan: only change CAN state when link up in system PM

After a suspend/resume cycle on a down interface, it will come up as
ERROR-ACTIVE.

$ ip -details -s -s a s dev flexcan0
3: flexcan0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN group default qlen 10
    link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
    can state STOPPED (berr-counter tx 0 rx 0) restart-ms 1000

$ sudo systemctl suspend

$ ip -details -s -s a s dev flexcan0
3: flexcan0: <NOARP,ECHO> mtu 16 qdisc pfifo_fast state DOWN group default qlen 10
    link/can  promiscuity 0 allmulti 0 minmtu 0 maxmtu 0
    can state ERROR-ACTIVE (berr-counter tx 0 rx 0) restart-ms 1000

And only set CAN state to CAN_STATE_ERROR_ACTIVE when resume process
has no issue, otherwise keep in CAN_STATE_SLEEPING as suspend did.

Fixes: 4de349e786a3 ("can: flexcan: fix resume function")
Cc: stable@vger.kernel.org
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Link: https://patch.msgid.link/20250314110145.899179-1-haibo.chen@nxp.com
Reported-by: Marc Kleine-Budde <mkl@pengutronix.de>
Closes: https://lore.kernel.org/all/20250314-married-polar-elephant-b15594-mkl@pengutronix.de
[mkl: add newlines]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index ac1a860986df..3a71fd235722 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2266,8 +2266,9 @@ static int __maybe_unused flexcan_suspend(struct device *device)
 		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
+
+		priv->can.state = CAN_STATE_SLEEPING;
 	}
-	priv->can.state = CAN_STATE_SLEEPING;
 
 	return 0;
 }
@@ -2278,7 +2279,6 @@ static int __maybe_unused flexcan_resume(struct device *device)
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	if (netif_running(dev)) {
 		netif_device_attach(dev);
 		netif_start_queue(dev);
@@ -2298,6 +2298,8 @@ static int __maybe_unused flexcan_resume(struct device *device)
 
 			flexcan_chip_interrupts_enable(dev);
 		}
+
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	}
 
 	return 0;


