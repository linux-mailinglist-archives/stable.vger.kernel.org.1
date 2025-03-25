Return-Path: <stable+bounces-126492-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B332A7010B
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 14:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65CE717B0DF
	for <lists+stable@lfdr.de>; Tue, 25 Mar 2025 13:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F8A26E157;
	Tue, 25 Mar 2025 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MIn/R6T7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8721118BC3B;
	Tue, 25 Mar 2025 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742906325; cv=none; b=iATrZI0f5lpwBddct/1mHt0vdvLV7DrzFXUPdQrYhzJtGVi8DncLl3Sjp1nTtL9slcGSu4jnEKGm+ctv846Hirch8CIoWolXZA+kSZ1sxymSFO8OX/qLG85AJ9ke65BaOhRgGfs05yY1rD9/EDlaWv6Zry0V4pPzXdmVjOhZgXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742906325; c=relaxed/simple;
	bh=DHlMgyBFVGACPGG0/N7RlXojviTQmFixd/NJueHHgCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uJ77Efg+v0REZtH4B+6nIM+WaAAtG7h2jxN0b8cjfNJT1B0amJlZjDbaXqNYOdxyNV0qVxqu/Bm+vHA9bhjr7ZFW/Ywj4MMA+uXkkr6JqywWtKQYylQD0Bt/VSIzC4oyCxLBhoCJLMcjQRuD7Zg8hajxW1klibrOaRMit8Jd3ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MIn/R6T7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38115C4CEE4;
	Tue, 25 Mar 2025 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742906325;
	bh=DHlMgyBFVGACPGG0/N7RlXojviTQmFixd/NJueHHgCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIn/R6T7Q2fbotGumrMVNKZBa+1PT0+OwVS1650qHHhPSno9dtmp3GXWCAq05rAOq
	 4kSWFhfGTyyswWXyqjqO/QVxWuBDa1XUfTKoKsZG43i+BPDElXtyv1jjAe6XnrNrsq
	 lli6HWq0PaBL01DZN8sb0mNYYmTxGIqWdMNs64s0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haibo Chen <haibo.chen@nxp.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.12 057/116] can: flexcan: only change CAN state when link up in system PM
Date: Tue, 25 Mar 2025 08:22:24 -0400
Message-ID: <20250325122150.667625162@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250325122149.207086105@linuxfoundation.org>
References: <20250325122149.207086105@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haibo Chen <haibo.chen@nxp.com>

commit fd99d6ed20234b83d65b9c5417794343577cf3e5 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/can/flexcan/flexcan-core.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -2266,8 +2266,9 @@ static int __maybe_unused flexcan_suspen
 		}
 		netif_stop_queue(dev);
 		netif_device_detach(dev);
+
+		priv->can.state = CAN_STATE_SLEEPING;
 	}
-	priv->can.state = CAN_STATE_SLEEPING;
 
 	return 0;
 }
@@ -2278,7 +2279,6 @@ static int __maybe_unused flexcan_resume
 	struct flexcan_priv *priv = netdev_priv(dev);
 	int err;
 
-	priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	if (netif_running(dev)) {
 		netif_device_attach(dev);
 		netif_start_queue(dev);
@@ -2298,6 +2298,8 @@ static int __maybe_unused flexcan_resume
 
 			flexcan_chip_interrupts_enable(dev);
 		}
+
+		priv->can.state = CAN_STATE_ERROR_ACTIVE;
 	}
 
 	return 0;



