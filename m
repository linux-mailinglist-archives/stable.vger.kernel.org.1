Return-Path: <stable+bounces-104699-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2195C9F528D
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 872E81893537
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:18:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EACE1F75A6;
	Tue, 17 Dec 2024 17:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0UaRAcsW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C55E13DBB6;
	Tue, 17 Dec 2024 17:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734455837; cv=none; b=Zg8RrtmcgZ/HXO2pfF0XZSVMZqbOiRanu+60hTwr+xJbNtpFoktOKwb3yH1puHAgCF5lQ1tqW//ti5eyDTSR4GlYCX/IN4S4EipPCwFcpGw04m9i0++zHXeBYGZljKknCOlaAhyUMhUhF044fPt1bgDB2qorsDdT+prz319FwOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734455837; c=relaxed/simple;
	bh=d/NR9yskenGmxsHNEPQlUA9XTO8yhdZi/ZrVNxlB36M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G6YPNTqR/HyAfngSzIjLQjQBOkNKzxl6kv2vY7Q99KQkSB3StWCelycAMzU0o2vcZpo0A2t7Oo8tk17EzNa+MNDVVl/pizRTM2Dye6CFOIT9NWOXuKZx4vzl/8c23qLxAq1ilgFJBvthjgsPbLb9IIjQZkcFpU6wMj2olaSZYnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0UaRAcsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC8FC4CED3;
	Tue, 17 Dec 2024 17:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734455835;
	bh=d/NR9yskenGmxsHNEPQlUA9XTO8yhdZi/ZrVNxlB36M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0UaRAcsWM4sWmr01SkuqO9QhKCNnsT/rXkcWmAxhnSNXgCi0NRb+RRz0w09EmUSTn
	 Yn7En8fC5mRB/NaQenbJVt8IxvZHp/gU/a1bXtvOeG6b95bgjgiFlI8ihoZWkDvuOr
	 ZyR7c5Rr10WLjBG/9iyvnKnskroh+B+zIgxhs6pM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 47/76] net: mscc: ocelot: be resilient to loss of PTP packets during transmission
Date: Tue, 17 Dec 2024 18:07:27 +0100
Message-ID: <20241217170528.217201398@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170526.232803729@linuxfoundation.org>
References: <20241217170526.232803729@linuxfoundation.org>
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

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit b454abfab52543c44b581afc807b9f97fc1e7a3a ]

The Felix DSA driver presents unique challenges that make the simplistic
ocelot PTP TX timestamping procedure unreliable: any transmitted packet
may be lost in hardware before it ever leaves our local system.

This may happen because there is congestion on the DSA conduit, the
switch CPU port or even user port (Qdiscs like taprio may delay packets
indefinitely by design).

The technical problem is that the kernel, i.e. ocelot_port_add_txtstamp_skb(),
runs out of timestamp IDs eventually, because it never detects that
packets are lost, and keeps the IDs of the lost packets on hold
indefinitely. The manifestation of the issue once the entire timestamp
ID range becomes busy looks like this in dmesg:

mscc_felix 0000:00:00.5: port 0 delivering skb without TX timestamp
mscc_felix 0000:00:00.5: port 1 delivering skb without TX timestamp

At the surface level, we need a timeout timer so that the kernel knows a
timestamp ID is available again. But there is a deeper problem with the
implementation, which is the monotonically increasing ocelot_port->ts_id.
In the presence of packet loss, it will be impossible to detect that and
reuse one of the holes created in the range of free timestamp IDs.

What we actually need is a bitmap of 63 timestamp IDs tracking which one
is available. That is able to use up holes caused by packet loss, but
also gives us a unique opportunity to not implement an actual timer_list
for the timeout timer (very complicated in terms of locking).

We could only declare a timestamp ID stale on demand (lazily), aka when
there's no other timestamp ID available. There are pros and cons to this
approach: the implementation is much more simple than per-packet timers
would be, but most of the stale packets would be quasi-leaked - not
really leaked, but blocked in driver memory, since this algorithm sees
no reason to free them.

An improved technique would be to check for stale timestamp IDs every
time we allocate a new one. Assuming a constant flux of PTP packets,
this avoids stale packets being blocked in memory, but of course,
packets lost at the end of the flux are still blocked until the flux
resumes (nobody left to kick them out).

Since implementing per-packet timers is way too complicated, this should
be good enough.

Testing procedure:

Persistently block traffic class 5 and try to run PTP on it:
$ tc qdisc replace dev swp3 parent root taprio num_tc 8 \
	map 0 1 2 3 4 5 6 7 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
	base-time 0 sched-entry S 0xdf 100000 flags 0x2
[  126.948141] mscc_felix 0000:00:00.5: port 3 tc 5 min gate length 0 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 1 octets including FCS
$ ptp4l -i swp3 -2 -P -m --socket_priority 5 --fault_reset_interval ASAP --logSyncInterval -3
ptp4l[70.351]: port 1 (swp3): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[70.354]: port 0 (/var/run/ptp4l): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[70.358]: port 0 (/var/run/ptp4lro): INITIALIZING to LISTENING on INIT_COMPLETE
[   70.394583] mscc_felix 0000:00:00.5: port 3 timestamp id 0
ptp4l[70.406]: timed out while polling for tx timestamp
ptp4l[70.406]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[70.406]: port 1 (swp3): send peer delay response failed
ptp4l[70.407]: port 1 (swp3): clearing fault immediately
ptp4l[70.952]: port 1 (swp3): new foreign master d858d7.fffe.00ca6d-1
[   71.394858] mscc_felix 0000:00:00.5: port 3 timestamp id 1
ptp4l[71.400]: timed out while polling for tx timestamp
ptp4l[71.400]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[71.401]: port 1 (swp3): send peer delay response failed
ptp4l[71.401]: port 1 (swp3): clearing fault immediately
[   72.393616] mscc_felix 0000:00:00.5: port 3 timestamp id 2
ptp4l[72.401]: timed out while polling for tx timestamp
ptp4l[72.402]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[72.402]: port 1 (swp3): send peer delay response failed
ptp4l[72.402]: port 1 (swp3): clearing fault immediately
ptp4l[72.952]: port 1 (swp3): new foreign master d858d7.fffe.00ca6d-1
[   73.395291] mscc_felix 0000:00:00.5: port 3 timestamp id 3
ptp4l[73.400]: timed out while polling for tx timestamp
ptp4l[73.400]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[73.400]: port 1 (swp3): send peer delay response failed
ptp4l[73.400]: port 1 (swp3): clearing fault immediately
[   74.394282] mscc_felix 0000:00:00.5: port 3 timestamp id 4
ptp4l[74.400]: timed out while polling for tx timestamp
ptp4l[74.401]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[74.401]: port 1 (swp3): send peer delay response failed
ptp4l[74.401]: port 1 (swp3): clearing fault immediately
ptp4l[74.953]: port 1 (swp3): new foreign master d858d7.fffe.00ca6d-1
[   75.396830] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 0 which seems lost
[   75.405760] mscc_felix 0000:00:00.5: port 3 timestamp id 0
ptp4l[75.410]: timed out while polling for tx timestamp
ptp4l[75.411]: increasing tx_timestamp_timeout or increasing kworker priority may correct this issue, but a driver bug likely causes it
ptp4l[75.411]: port 1 (swp3): send peer delay response failed
ptp4l[75.411]: port 1 (swp3): clearing fault immediately
(...)

Remove the blocking condition and see that the port recovers:
$ same tc command as above, but use "sched-entry S 0xff" instead
$ same ptp4l command as above
ptp4l[99.489]: port 1 (swp3): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[99.490]: port 0 (/var/run/ptp4l): INITIALIZING to LISTENING on INIT_COMPLETE
ptp4l[99.492]: port 0 (/var/run/ptp4lro): INITIALIZING to LISTENING on INIT_COMPLETE
[  100.403768] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 0 which seems lost
[  100.412545] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 1 which seems lost
[  100.421283] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 2 which seems lost
[  100.430015] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 3 which seems lost
[  100.438744] mscc_felix 0000:00:00.5: port 3 invalidating stale timestamp ID 4 which seems lost
[  100.447470] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  100.505919] mscc_felix 0000:00:00.5: port 3 timestamp id 0
ptp4l[100.963]: port 1 (swp3): new foreign master d858d7.fffe.00ca6d-1
[  101.405077] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  101.507953] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  102.405405] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  102.509391] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  103.406003] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  103.510011] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  104.405601] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  104.510624] mscc_felix 0000:00:00.5: port 3 timestamp id 0
ptp4l[104.965]: selected best master clock d858d7.fffe.00ca6d
ptp4l[104.966]: port 1 (swp3): assuming the grand master role
ptp4l[104.967]: port 1 (swp3): LISTENING to GRAND_MASTER on RS_GRAND_MASTER
[  105.106201] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.232420] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.359001] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.405500] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.485356] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.511220] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.610938] mscc_felix 0000:00:00.5: port 3 timestamp id 0
[  105.737237] mscc_felix 0000:00:00.5: port 3 timestamp id 0
(...)

Notice that in this new usage pattern, a non-congested port should
basically use timestamp ID 0 all the time, progressing to higher numbers
only if there are unacknowledged timestamps in flight. Compare this to
the old usage, where the timestamp ID used to monotonically increase
modulo OCELOT_MAX_PTP_ID.

In terms of implementation, this simplifies the bookkeeping of the
ocelot_port :: ts_id and ptp_skbs_in_flight. Since we need to traverse
the list of two-step timestampable skbs for each new packet anyway, the
information can already be computed and does not need to be stored.
Also, ocelot_port->tx_skbs is always accessed under the switch-wide
ocelot->ts_id_lock IRQ-unsafe spinlock, so we don't need the skb queue's
lock and can use the unlocked primitives safely.

This problem was actually detected using the tc-taprio offload, and is
causing trouble in TSN scenarios, which Felix (NXP LS1028A / VSC9959)
supports but Ocelot (VSC7514) does not. Thus, I've selected the commit
to blame as the one adding initial timestamping support for the Felix
switch.

Fixes: c0bcf537667c ("net: dsa: ocelot: add hardware timestamping support for Felix")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Link: https://patch.msgid.link/20241205145519.1236778-5-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mscc/ocelot_ptp.c | 134 +++++++++++++++----------
 include/linux/dsa/ocelot.h             |   1 +
 include/soc/mscc/ocelot.h              |   2 -
 3 files changed, 80 insertions(+), 57 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot_ptp.c b/drivers/net/ethernet/mscc/ocelot_ptp.c
index c54e96ff3976..bc44aa635d49 100644
--- a/drivers/net/ethernet/mscc/ocelot_ptp.c
+++ b/drivers/net/ethernet/mscc/ocelot_ptp.c
@@ -14,6 +14,8 @@
 #include <soc/mscc/ocelot.h>
 #include "ocelot.h"
 
+#define OCELOT_PTP_TX_TSTAMP_TIMEOUT		(5 * HZ)
+
 int ocelot_ptp_gettime64(struct ptp_clock_info *ptp, struct timespec64 *ts)
 {
 	struct ocelot *ocelot = container_of(ptp, struct ocelot, ptp_info);
@@ -607,34 +609,88 @@ int ocelot_get_ts_info(struct ocelot *ocelot, int port,
 }
 EXPORT_SYMBOL(ocelot_get_ts_info);
 
-static int ocelot_port_add_txtstamp_skb(struct ocelot *ocelot, int port,
+static struct sk_buff *ocelot_port_dequeue_ptp_tx_skb(struct ocelot *ocelot,
+						      int port, u8 ts_id,
+						      u32 seqid)
+{
+	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
+	struct ptp_header *hdr;
+
+	spin_lock(&ocelot->ts_id_lock);
+
+	skb_queue_walk_safe(&ocelot_port->tx_skbs, skb, skb_tmp) {
+		if (OCELOT_SKB_CB(skb)->ts_id != ts_id)
+			continue;
+
+		/* Check that the timestamp ID is for the expected PTP
+		 * sequenceId. We don't have to test ptp_parse_header() against
+		 * NULL, because we've pre-validated the packet's ptp_class.
+		 */
+		hdr = ptp_parse_header(skb, OCELOT_SKB_CB(skb)->ptp_class);
+		if (seqid != ntohs(hdr->sequence_id))
+			continue;
+
+		__skb_unlink(skb, &ocelot_port->tx_skbs);
+		ocelot->ptp_skbs_in_flight--;
+		skb_match = skb;
+		break;
+	}
+
+	spin_unlock(&ocelot->ts_id_lock);
+
+	return skb_match;
+}
+
+static int ocelot_port_queue_ptp_tx_skb(struct ocelot *ocelot, int port,
 					struct sk_buff *clone)
 {
 	struct ocelot_port *ocelot_port = ocelot->ports[port];
+	DECLARE_BITMAP(ts_id_in_flight, OCELOT_MAX_PTP_ID);
+	struct sk_buff *skb, *skb_tmp;
+	unsigned long n;
 
 	spin_lock(&ocelot->ts_id_lock);
 
-	if (ocelot_port->ptp_skbs_in_flight == OCELOT_MAX_PTP_ID ||
-	    ocelot->ptp_skbs_in_flight == OCELOT_PTP_FIFO_SIZE) {
+	/* To get a better chance of acquiring a timestamp ID, first flush the
+	 * stale packets still waiting in the TX timestamping queue. They are
+	 * probably lost.
+	 */
+	skb_queue_walk_safe(&ocelot_port->tx_skbs, skb, skb_tmp) {
+		if (time_before(OCELOT_SKB_CB(skb)->ptp_tx_time +
+				OCELOT_PTP_TX_TSTAMP_TIMEOUT, jiffies)) {
+			dev_warn_ratelimited(ocelot->dev,
+					     "port %d invalidating stale timestamp ID %u which seems lost\n",
+					     port, OCELOT_SKB_CB(skb)->ts_id);
+			__skb_unlink(skb, &ocelot_port->tx_skbs);
+			kfree_skb(skb);
+			ocelot->ptp_skbs_in_flight--;
+		} else {
+			__set_bit(OCELOT_SKB_CB(skb)->ts_id, ts_id_in_flight);
+		}
+	}
+
+	if (ocelot->ptp_skbs_in_flight == OCELOT_PTP_FIFO_SIZE) {
 		spin_unlock(&ocelot->ts_id_lock);
 		return -EBUSY;
 	}
 
-	skb_shinfo(clone)->tx_flags |= SKBTX_IN_PROGRESS;
-	/* Store timestamp ID in OCELOT_SKB_CB(clone)->ts_id */
-	OCELOT_SKB_CB(clone)->ts_id = ocelot_port->ts_id;
-
-	ocelot_port->ts_id++;
-	if (ocelot_port->ts_id == OCELOT_MAX_PTP_ID)
-		ocelot_port->ts_id = 0;
+	n = find_first_zero_bit(ts_id_in_flight, OCELOT_MAX_PTP_ID);
+	if (n == OCELOT_MAX_PTP_ID) {
+		spin_unlock(&ocelot->ts_id_lock);
+		return -EBUSY;
+	}
 
-	ocelot_port->ptp_skbs_in_flight++;
+	/* Found an available timestamp ID, use it */
+	OCELOT_SKB_CB(clone)->ts_id = n;
+	OCELOT_SKB_CB(clone)->ptp_tx_time = jiffies;
 	ocelot->ptp_skbs_in_flight++;
-
-	skb_queue_tail(&ocelot_port->tx_skbs, clone);
+	__skb_queue_tail(&ocelot_port->tx_skbs, clone);
 
 	spin_unlock(&ocelot->ts_id_lock);
 
+	dev_dbg_ratelimited(ocelot->dev, "port %d timestamp id %lu\n", port, n);
+
 	return 0;
 }
 
@@ -690,12 +746,14 @@ int ocelot_port_txtstamp_request(struct ocelot *ocelot, int port,
 		if (!(*clone))
 			return -ENOMEM;
 
-		err = ocelot_port_add_txtstamp_skb(ocelot, port, *clone);
+		/* Store timestamp ID in OCELOT_SKB_CB(clone)->ts_id */
+		err = ocelot_port_queue_ptp_tx_skb(ocelot, port, *clone);
 		if (err) {
 			kfree_skb(*clone);
 			return err;
 		}
 
+		skb_shinfo(*clone)->tx_flags |= SKBTX_IN_PROGRESS;
 		OCELOT_SKB_CB(skb)->ptp_cmd = ptp_cmd;
 		OCELOT_SKB_CB(*clone)->ptp_class = ptp_class;
 	}
@@ -731,26 +789,14 @@ static void ocelot_get_hwtimestamp(struct ocelot *ocelot,
 	spin_unlock_irqrestore(&ocelot->ptp_clock_lock, flags);
 }
 
-static bool ocelot_validate_ptp_skb(struct sk_buff *clone, u16 seqid)
-{
-	struct ptp_header *hdr;
-
-	hdr = ptp_parse_header(clone, OCELOT_SKB_CB(clone)->ptp_class);
-	if (WARN_ON(!hdr))
-		return false;
-
-	return seqid == ntohs(hdr->sequence_id);
-}
-
 void ocelot_get_txtstamp(struct ocelot *ocelot)
 {
 	int budget = OCELOT_PTP_QUEUE_SZ;
 
 	while (budget--) {
-		struct sk_buff *skb, *skb_tmp, *skb_match = NULL;
 		struct skb_shared_hwtstamps shhwtstamps;
 		u32 val, id, seqid, txport;
-		struct ocelot_port *port;
+		struct sk_buff *skb_match;
 		struct timespec64 ts;
 
 		val = ocelot_read(ocelot, SYS_PTP_STATUS);
@@ -766,36 +812,14 @@ void ocelot_get_txtstamp(struct ocelot *ocelot)
 		txport = SYS_PTP_STATUS_PTP_MESS_TXPORT_X(val);
 		seqid = SYS_PTP_STATUS_PTP_MESS_SEQ_ID(val);
 
-		port = ocelot->ports[txport];
-
-		spin_lock(&ocelot->ts_id_lock);
-		port->ptp_skbs_in_flight--;
-		ocelot->ptp_skbs_in_flight--;
-		spin_unlock(&ocelot->ts_id_lock);
-
 		/* Retrieve its associated skb */
-try_again:
-		spin_lock(&port->tx_skbs.lock);
-
-		skb_queue_walk_safe(&port->tx_skbs, skb, skb_tmp) {
-			if (OCELOT_SKB_CB(skb)->ts_id != id)
-				continue;
-			__skb_unlink(skb, &port->tx_skbs);
-			skb_match = skb;
-			break;
-		}
-
-		spin_unlock(&port->tx_skbs.lock);
-
-		if (WARN_ON(!skb_match))
+		skb_match = ocelot_port_dequeue_ptp_tx_skb(ocelot, txport, id,
+							   seqid);
+		if (!skb_match) {
+			dev_warn_ratelimited(ocelot->dev,
+					     "port %d received TX timestamp (seqid %d, ts id %u) for packet previously declared stale\n",
+					     txport, seqid, id);
 			goto next_ts;
-
-		if (!ocelot_validate_ptp_skb(skb_match, seqid)) {
-			dev_err_ratelimited(ocelot->dev,
-					    "port %d received stale TX timestamp for seqid %d, discarding\n",
-					    txport, seqid);
-			kfree_skb(skb);
-			goto try_again;
 		}
 
 		/* Get the h/w timestamp */
diff --git a/include/linux/dsa/ocelot.h b/include/linux/dsa/ocelot.h
index 6fbfbde68a37..620a3260fc08 100644
--- a/include/linux/dsa/ocelot.h
+++ b/include/linux/dsa/ocelot.h
@@ -15,6 +15,7 @@
 struct ocelot_skb_cb {
 	struct sk_buff *clone;
 	unsigned int ptp_class; /* valid only for clones */
+	unsigned long ptp_tx_time; /* valid only for clones */
 	u32 tstamp_lo;
 	u8 ptp_cmd;
 	u8 ts_id;
diff --git a/include/soc/mscc/ocelot.h b/include/soc/mscc/ocelot.h
index 9b5562f54548..99cfaa9347c9 100644
--- a/include/soc/mscc/ocelot.h
+++ b/include/soc/mscc/ocelot.h
@@ -941,7 +941,6 @@ struct ocelot_port {
 
 	phy_interface_t			phy_mode;
 
-	unsigned int			ptp_skbs_in_flight;
 	struct sk_buff_head		tx_skbs;
 
 	unsigned int			trap_proto;
@@ -949,7 +948,6 @@ struct ocelot_port {
 	u16				mrp_ring_id;
 
 	u8				ptp_cmd;
-	u8				ts_id;
 
 	u8				index;
 
-- 
2.39.5




