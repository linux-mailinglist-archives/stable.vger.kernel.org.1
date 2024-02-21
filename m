Return-Path: <stable+bounces-22047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F42C85D9DD
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A4F3B25C41
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3B973161;
	Wed, 21 Feb 2024 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oNFS90Uk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC469953;
	Wed, 21 Feb 2024 13:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521797; cv=none; b=oBpCvt+dXrdl3GzvgwfWmk5hgrc7M9pd2R3y99V+a3IxS9DRWxivCY4AkM0atec2OXlUnZQ2pT3k0/rn7EclQuvJkTk9QlUPk4lGi/5iTmixk1d/gAKRzT/joKRcfRqJbRilhr6P1GrcBgWs3LQgvug8PGzRrb1KRXMBD1UFswI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521797; c=relaxed/simple;
	bh=+A6n0AyoadFEzd4VfxOnxjY1E8VgMAFiEaNDsCL8LCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OCn3/3wmmkjnAZewjqNj9Hq/rf811mfJZJRl+w29BhV7bwmZQyc5+DlyW6rA9EOWnmbDkzHT/PF27Y9nTpq3CbnA3oUeuxjNPYfaJEpgIEdoZRoktEDQsZUJh6K7q42i5Ugq/V/uGYngt/rFsl26auHDlb1dmpBQb4N/NhJYREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oNFS90Uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D34C433C7;
	Wed, 21 Feb 2024 13:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708521797;
	bh=+A6n0AyoadFEzd4VfxOnxjY1E8VgMAFiEaNDsCL8LCY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oNFS90UkaNo3C4vflGPiQ/rqsOe6r2hfiWuKOSgP9thu4TUzlIUYzm2+BgPM9YfY4
	 2zaCpy/nVxt9cB/mwK1mtoqU+pBBMOnt6o3FXwSkQs9M+r+6Adq4gCMntoVrh1acsq
	 nhCZ2Y6JWwvrrl6gXm/5PuNoRQClkEFTmnq/hvLY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 170/202] net: sysfs: Fix /sys/class/net/<iface> path for statistics
Date: Wed, 21 Feb 2024 14:07:51 +0100
Message-ID: <20240221125937.250786539@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125931.742034354@linuxfoundation.org>
References: <20240221125931.742034354@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 5b3fbd61b9d1f4ed2db95aaf03f9adae0373784d ]

The Documentation/ABI/testing/sysfs-class-net-statistics documentation
is pointing to the wrong path for the interface.  Documentation is
pointing to /sys/class/<iface>, instead of /sys/class/net/<iface>.

Fix it by adding the `net/` directory before the interface.

Fixes: 6044f9700645 ("net: sysfs: document /sys/class/net/statistics/*")
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ABI/testing/sysfs-class-net-statistics    | 48 +++++++++----------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-statistics b/Documentation/ABI/testing/sysfs-class-net-statistics
index 55db27815361..53e508c6936a 100644
--- a/Documentation/ABI/testing/sysfs-class-net-statistics
+++ b/Documentation/ABI/testing/sysfs-class-net-statistics
@@ -1,4 +1,4 @@
-What:		/sys/class/<iface>/statistics/collisions
+What:		/sys/class/net/<iface>/statistics/collisions
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -6,7 +6,7 @@ Description:
 		Indicates the number of collisions seen by this network device.
 		This value might not be relevant with all MAC layers.
 
-What:		/sys/class/<iface>/statistics/multicast
+What:		/sys/class/net/<iface>/statistics/multicast
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -14,7 +14,7 @@ Description:
 		Indicates the number of multicast packets received by this
 		network device.
 
-What:		/sys/class/<iface>/statistics/rx_bytes
+What:		/sys/class/net/<iface>/statistics/rx_bytes
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -23,7 +23,7 @@ Description:
 		See the network driver for the exact meaning of when this
 		value is incremented.
 
-What:		/sys/class/<iface>/statistics/rx_compressed
+What:		/sys/class/net/<iface>/statistics/rx_compressed
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -32,7 +32,7 @@ Description:
 		network device. This value might only be relevant for interfaces
 		that support packet compression (e.g: PPP).
 
-What:		/sys/class/<iface>/statistics/rx_crc_errors
+What:		/sys/class/net/<iface>/statistics/rx_crc_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -41,7 +41,7 @@ Description:
 		by this network device. Note that the specific meaning might
 		depend on the MAC layer used by the interface.
 
-What:		/sys/class/<iface>/statistics/rx_dropped
+What:		/sys/class/net/<iface>/statistics/rx_dropped
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -51,7 +51,7 @@ Description:
 		packet processing. See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_errors
+What:		/sys/class/net/<iface>/statistics/rx_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -59,7 +59,7 @@ Description:
 		Indicates the number of receive errors on this network device.
 		See the network driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_fifo_errors
+What:		/sys/class/net/<iface>/statistics/rx_fifo_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -68,7 +68,7 @@ Description:
 		network device. See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_frame_errors
+What:		/sys/class/net/<iface>/statistics/rx_frame_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -78,7 +78,7 @@ Description:
 		on the MAC layer protocol used. See the network driver for
 		the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_length_errors
+What:		/sys/class/net/<iface>/statistics/rx_length_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -87,7 +87,7 @@ Description:
 		error, oversized or undersized. See the network driver for the
 		exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_missed_errors
+What:		/sys/class/net/<iface>/statistics/rx_missed_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -96,7 +96,7 @@ Description:
 		due to lack of capacity in the receive side. See the network
 		driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_nohandler
+What:		/sys/class/net/<iface>/statistics/rx_nohandler
 Date:		February 2016
 KernelVersion:	4.6
 Contact:	netdev@vger.kernel.org
@@ -104,7 +104,7 @@ Description:
 		Indicates the number of received packets that were dropped on
 		an inactive device by the network core.
 
-What:		/sys/class/<iface>/statistics/rx_over_errors
+What:		/sys/class/net/<iface>/statistics/rx_over_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -114,7 +114,7 @@ Description:
 		(e.g: larger than MTU). See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/rx_packets
+What:		/sys/class/net/<iface>/statistics/rx_packets
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -122,7 +122,7 @@ Description:
 		Indicates the total number of good packets received by this
 		network device.
 
-What:		/sys/class/<iface>/statistics/tx_aborted_errors
+What:		/sys/class/net/<iface>/statistics/tx_aborted_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -132,7 +132,7 @@ Description:
 		a medium collision). See the network driver for the exact
 		meaning of this value.
 
-What:		/sys/class/<iface>/statistics/tx_bytes
+What:		/sys/class/net/<iface>/statistics/tx_bytes
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -143,7 +143,7 @@ Description:
 		transmitted packets or all packets that have been queued for
 		transmission.
 
-What:		/sys/class/<iface>/statistics/tx_carrier_errors
+What:		/sys/class/net/<iface>/statistics/tx_carrier_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -152,7 +152,7 @@ Description:
 		because of carrier errors (e.g: physical link down). See the
 		network driver for the exact meaning of this value.
 
-What:		/sys/class/<iface>/statistics/tx_compressed
+What:		/sys/class/net/<iface>/statistics/tx_compressed
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -161,7 +161,7 @@ Description:
 		this might only be relevant for devices that support
 		compression (e.g: PPP).
 
-What:		/sys/class/<iface>/statistics/tx_dropped
+What:		/sys/class/net/<iface>/statistics/tx_dropped
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -170,7 +170,7 @@ Description:
 		See the driver for the exact reasons as to why the packets were
 		dropped.
 
-What:		/sys/class/<iface>/statistics/tx_errors
+What:		/sys/class/net/<iface>/statistics/tx_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -179,7 +179,7 @@ Description:
 		a network device. See the driver for the exact reasons as to
 		why the packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_fifo_errors
+What:		/sys/class/net/<iface>/statistics/tx_fifo_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -188,7 +188,7 @@ Description:
 		FIFO error. See the driver for the exact reasons as to why the
 		packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_heartbeat_errors
+What:		/sys/class/net/<iface>/statistics/tx_heartbeat_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -197,7 +197,7 @@ Description:
 		reported as heartbeat errors. See the driver for the exact
 		reasons as to why the packets were dropped.
 
-What:		/sys/class/<iface>/statistics/tx_packets
+What:		/sys/class/net/<iface>/statistics/tx_packets
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
@@ -206,7 +206,7 @@ Description:
 		device. See the driver for whether this reports the number of all
 		attempted or successful transmissions.
 
-What:		/sys/class/<iface>/statistics/tx_window_errors
+What:		/sys/class/net/<iface>/statistics/tx_window_errors
 Date:		April 2005
 KernelVersion:	2.6.12
 Contact:	netdev@vger.kernel.org
-- 
2.43.0




