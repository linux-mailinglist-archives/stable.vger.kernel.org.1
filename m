Return-Path: <stable+bounces-17994-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC888480F2
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 05:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74B6B1F23AAB
	for <lists+stable@lfdr.de>; Sat,  3 Feb 2024 04:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857F310A26;
	Sat,  3 Feb 2024 04:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IWHLblVX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DA2FC03;
	Sat,  3 Feb 2024 04:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933469; cv=none; b=Ic4Q5KSw3/WdabLtRED9ejDaGnAntxyU2uVdiUfto7PipmWN9N8Adaek3xY+xo+GnvFbZQ07lt3Q8U2wJpwPrzj5qHDQ8GCmwJ5dtnVilLzT1x96rOypsrn8+L6j/HtuC60mhq3147anzXN9NKT0g08CB3pi/Z9n61QqhlYQ5oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933469; c=relaxed/simple;
	bh=sRJE3Dh4FcohSWs5AuKrqOeYv3gC+y9J9TNVwygBdKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hOVLqfvZQrtLwe2z1rvNIIGhzY96qBtCA2gpczoqQ8/CA1KFV8qfyJa6jiFG6A4YBuj5MyX8kNeuIOCivP4aC2wDshhrUzaYLFuz8b2wl4N3nhCxbpNsMBMwbusb0bQyARwtohOXy+/k5MQPzEu+fPPLZYZO5h/i/DvqZHII6bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=IWHLblVX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CD95C43394;
	Sat,  3 Feb 2024 04:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706933469;
	bh=sRJE3Dh4FcohSWs5AuKrqOeYv3gC+y9J9TNVwygBdKM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IWHLblVXTPF7LKlE7aBHv20Mil4z0Rky7YFlTHUJRnyGNQsnakIjLrKxMGnbPDkLr
	 RULJGntjvfidF50ewijGndCHl96YIeMs4GzZSS72bZR6zLXhh5r199C4h/8vSBPJ40
	 KmnpG8LGIoycBrwyr0y2qnJLV1Q5NcbKcDH5PwMQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Breno Leitao <leitao@debian.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 210/219] net: sysfs: Fix /sys/class/net/<iface> path
Date: Fri,  2 Feb 2024 20:06:23 -0800
Message-ID: <20240203035346.379721422@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240203035317.354186483@linuxfoundation.org>
References: <20240203035317.354186483@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Breno Leitao <leitao@debian.org>

[ Upstream commit ae3f4b44641dfff969604735a0dcbf931f383285 ]

The documentation is pointing to the wrong path for the interface.
Documentation is pointing to /sys/class/<iface>, instead of
/sys/class/net/<iface>.

Fix it by adding the `net/` directory before the interface.

Fixes: 1a02ef76acfa ("net: sysfs: add documentation entries for /sys/class/<iface>/queues")
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/r/20240131102150.728960-2-leitao@debian.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ABI/testing/sysfs-class-net-queues        | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-net-queues b/Documentation/ABI/testing/sysfs-class-net-queues
index 978b76358661..40d5aab8452d 100644
--- a/Documentation/ABI/testing/sysfs-class-net-queues
+++ b/Documentation/ABI/testing/sysfs-class-net-queues
@@ -1,4 +1,4 @@
-What:		/sys/class/<iface>/queues/rx-<queue>/rps_cpus
+What:		/sys/class/net/<iface>/queues/rx-<queue>/rps_cpus
 Date:		March 2010
 KernelVersion:	2.6.35
 Contact:	netdev@vger.kernel.org
@@ -8,7 +8,7 @@ Description:
 		network device queue. Possible values depend on the number
 		of available CPU(s) in the system.
 
-What:		/sys/class/<iface>/queues/rx-<queue>/rps_flow_cnt
+What:		/sys/class/net/<iface>/queues/rx-<queue>/rps_flow_cnt
 Date:		April 2010
 KernelVersion:	2.6.35
 Contact:	netdev@vger.kernel.org
@@ -16,7 +16,7 @@ Description:
 		Number of Receive Packet Steering flows being currently
 		processed by this particular network device receive queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/tx_timeout
+What:		/sys/class/net/<iface>/queues/tx-<queue>/tx_timeout
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -24,7 +24,7 @@ Description:
 		Indicates the number of transmit timeout events seen by this
 		network interface transmit queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/tx_maxrate
+What:		/sys/class/net/<iface>/queues/tx-<queue>/tx_maxrate
 Date:		March 2015
 KernelVersion:	4.1
 Contact:	netdev@vger.kernel.org
@@ -32,7 +32,7 @@ Description:
 		A Mbps max-rate set for the queue, a value of zero means disabled,
 		default is disabled.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/xps_cpus
+What:		/sys/class/net/<iface>/queues/tx-<queue>/xps_cpus
 Date:		November 2010
 KernelVersion:	2.6.38
 Contact:	netdev@vger.kernel.org
@@ -42,7 +42,7 @@ Description:
 		network device transmit queue. Possible vaules depend on the
 		number of available CPU(s) in the system.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/xps_rxqs
+What:		/sys/class/net/<iface>/queues/tx-<queue>/xps_rxqs
 Date:		June 2018
 KernelVersion:	4.18.0
 Contact:	netdev@vger.kernel.org
@@ -53,7 +53,7 @@ Description:
 		number of available receive queue(s) in the network device.
 		Default is disabled.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/hold_time
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/hold_time
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -62,7 +62,7 @@ Description:
 		of this particular network device transmit queue.
 		Default value is 1000.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/inflight
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/inflight
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -70,7 +70,7 @@ Description:
 		Indicates the number of bytes (objects) in flight on this
 		network device transmit queue.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -79,7 +79,7 @@ Description:
 		on this network device transmit queue. This value is clamped
 		to be within the bounds defined by limit_max and limit_min.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit_max
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit_max
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
@@ -88,7 +88,7 @@ Description:
 		queued on this network device transmit queue. See
 		include/linux/dynamic_queue_limits.h for the default value.
 
-What:		/sys/class/<iface>/queues/tx-<queue>/byte_queue_limits/limit_min
+What:		/sys/class/net/<iface>/queues/tx-<queue>/byte_queue_limits/limit_min
 Date:		November 2011
 KernelVersion:	3.3
 Contact:	netdev@vger.kernel.org
-- 
2.43.0




