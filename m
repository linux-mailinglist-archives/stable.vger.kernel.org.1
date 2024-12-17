Return-Path: <stable+bounces-104976-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 806099F544C
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 18:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894BB188B274
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 17:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C781FC10E;
	Tue, 17 Dec 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h+DjkX8w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9BC1FC10A;
	Tue, 17 Dec 2024 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734456695; cv=none; b=C/0w+PQB6Ej1dgNZjtB/MnaAXhD4W3GkXTzxXeDKuDFWAhMasE6PUFFbyFWUJ5RyIVCjnTxwRZwKnVoA4Ay1ghU3UICzcHp5LxsWjphIgkiKIZOMeqVe0Bg4aWbDBScq4HGRTg+ZMqurgY/vSwpEqvB3BM2CXIY3Dw+fdADx3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734456695; c=relaxed/simple;
	bh=8OedC+5yyzVIJXWQjxrMiS1rRwuozDpkSiEdGrgFqHE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osJ+32/0Xo9THeivPxAsjCYqFtsdfOVCgfP6u/3xOxb4Ktaly4is7Xlh7/IJfIvtpx049oEbAymbwgguIH9ry4hKza2ROGT7Ujhy2kNnCOMRrUEwew0wDz4wZgfY3QDYEhbx2QX5ezZJUN4QzHXLQP6f4AjB8hBfbedPnWiqrSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h+DjkX8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337A3C4CED3;
	Tue, 17 Dec 2024 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734456695;
	bh=8OedC+5yyzVIJXWQjxrMiS1rRwuozDpkSiEdGrgFqHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h+DjkX8wDJoV+OBonARfP8+FhZXFp233sJUPRBgsPpWoowySdH0ogQnedFN2SFXW7
	 vzJPEC2ostFriOhLfazbokCjBGKJRhNr31Ti1TPX3UIuoF6Lp3KS/NseHzNtw77qjr
	 hV2oaMbzWxHPiIUBixcJZpJRoDXEFQcPfsOczC2s=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Michael Walle <mwalle@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 138/172] net: dsa: felix: fix stuck CPU-injected packets with short taprio windows
Date: Tue, 17 Dec 2024 18:08:14 +0100
Message-ID: <20241217170552.061715025@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217170546.209657098@linuxfoundation.org>
References: <20241217170546.209657098@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vladimir Oltean <vladimir.oltean@nxp.com>

[ Upstream commit acfcdb78d5d4cdb78e975210c8825b9a112463f6 ]

With this port schedule:

tc qdisc replace dev $send_if parent root handle 100 taprio \
	num_tc 8 queues 1@0 1@1 1@2 1@3 1@4 1@5 1@6 1@7 \
	map 0 1 2 3 4 5 6 7 \
	base-time 0 cycle-time 10000 \
	sched-entry S 01 1250 \
	sched-entry S 02 1250 \
	sched-entry S 04 1250 \
	sched-entry S 08 1250 \
	sched-entry S 10 1250 \
	sched-entry S 20 1250 \
	sched-entry S 40 1250 \
	sched-entry S 80 1250 \
	flags 2

ptp4l would fail to take TX timestamps of Pdelay_Resp messages like this:

increasing tx_timestamp_timeout may correct this issue, but it is likely caused by a driver bug
ptp4l[4134.168]: port 2: send peer delay response failed

It turns out that the driver can't take their TX timestamps because it
can't transmit them in the first place. And there's nothing special
about the Pdelay_Resp packets - they're just regular 68 byte packets.
But with this taprio configuration, the switch would refuse to send even
the ETH_ZLEN minimum packet size.

This should have definitely not been the case. When applying the taprio
config, the driver prints:

mscc_felix 0000:00:00.5: port 0 tc 0 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 1 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 2 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 3 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 4 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 5 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 6 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 7 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 132 octets including FCS

and thus, everything under 132 bytes - ETH_FCS_LEN should have been sent
without problems. Yet it's not.

For the forwarding path, the configuration is fine, yet packets injected
from Linux get stuck with this schedule no matter what.

The first hint that the static guard bands are the cause of the problem
is that reverting Michael Walle's commit 297c4de6f780 ("net: dsa: felix:
re-enable TAS guard band mode") made things work. It must be that the
guard bands are calculated incorrectly.

I remembered that there is a magic constant in the driver, set to 33 ns
for no logical reason other than experimentation, which says "never let
the static guard bands get so large as to leave less than this amount of
remaining space in the time slot, because the queue system will refuse
to schedule packets otherwise, and they will get stuck". I had a hunch
that my previous experimentally-determined value was only good for
packets coming from the forwarding path, and that the CPU injection path
needed more.

I came to the new value of 35 ns through binary search, after seeing
that with 544 ns (the bit time required to send the Pdelay_Resp packet
at gigabit) it works. Again, this is purely experimental, there's no
logic and the manual doesn't say anything.

The new driver prints for this schedule look like this:

mscc_felix 0000:00:00.5: port 0 tc 0 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 1 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 2 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 3 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 4 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 5 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 6 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS
mscc_felix 0000:00:00.5: port 0 tc 7 min gate length 1250 ns not enough for max frame size 1526 at 1000 Mbps, dropping frames over 131 octets including FCS

So yes, the maximum MTU is now even smaller by 1 byte than before.
This is maybe counter-intuitive, but makes more sense with a diagram of
one time slot.

Before:

 Gate open                                   Gate close
 |                                                    |
 v           1250 ns total time slot duration         v
 <---------------------------------------------------->
 <----><---------------------------------------------->
  33 ns            1217 ns static guard band
  useful

 Gate open                                   Gate close
 |                                                    |
 v           1250 ns total time slot duration         v
 <---------------------------------------------------->
 <-----><--------------------------------------------->
  35 ns            1215 ns static guard band
  useful

The static guard band implemented by this switch hardware directly
determines the maximum allowable MTU for that traffic class. The larger
it is, the earlier the switch will stop scheduling frames for
transmission, because otherwise they might overrun the gate close time
(and avoiding that is the entire purpose of Michael's patch).
So, we now have guard bands smaller by 2 ns, thus, in this particular
case, we lose a byte of the maximum MTU.

Fixes: 11afdc6526de ("net: dsa: felix: tc-taprio intervals smaller than MTU should send at least one packet")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Link: https://patch.msgid.link/20241210132640.3426788-1-vladimir.oltean@nxp.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/ocelot/felix_vsc9959.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/ocelot/felix_vsc9959.c b/drivers/net/dsa/ocelot/felix_vsc9959.c
index 0102a82e88cc..940f1b71226d 100644
--- a/drivers/net/dsa/ocelot/felix_vsc9959.c
+++ b/drivers/net/dsa/ocelot/felix_vsc9959.c
@@ -24,7 +24,7 @@
 #define VSC9959_NUM_PORTS		6
 
 #define VSC9959_TAS_GCL_ENTRY_MAX	63
-#define VSC9959_TAS_MIN_GATE_LEN_NS	33
+#define VSC9959_TAS_MIN_GATE_LEN_NS	35
 #define VSC9959_VCAP_POLICER_BASE	63
 #define VSC9959_VCAP_POLICER_MAX	383
 #define VSC9959_SWITCH_PCI_BAR		4
@@ -1056,11 +1056,15 @@ static void vsc9959_mdio_bus_free(struct ocelot *ocelot)
 	mdiobus_free(felix->imdio);
 }
 
-/* The switch considers any frame (regardless of size) as eligible for
- * transmission if the traffic class gate is open for at least 33 ns.
+/* The switch considers any frame (regardless of size) as eligible
+ * for transmission if the traffic class gate is open for at least
+ * VSC9959_TAS_MIN_GATE_LEN_NS.
+ *
  * Overruns are prevented by cropping an interval at the end of the gate time
- * slot for which egress scheduling is blocked, but we need to still keep 33 ns
- * available for one packet to be transmitted, otherwise the port tc will hang.
+ * slot for which egress scheduling is blocked, but we need to still keep
+ * VSC9959_TAS_MIN_GATE_LEN_NS available for one packet to be transmitted,
+ * otherwise the port tc will hang.
+ *
  * This function returns the size of a gate interval that remains available for
  * setting the guard band, after reserving the space for one egress frame.
  */
@@ -1303,7 +1307,8 @@ static void vsc9959_tas_guard_bands_update(struct ocelot *ocelot, int port)
 			 * per-tc static guard band lengths, so it reduces the
 			 * useful gate interval length. Therefore, be careful
 			 * to calculate a guard band (and therefore max_sdu)
-			 * that still leaves 33 ns available in the time slot.
+			 * that still leaves VSC9959_TAS_MIN_GATE_LEN_NS
+			 * available in the time slot.
 			 */
 			max_sdu = div_u64(remaining_gate_len_ps, picos_per_byte);
 			/* A TC gate may be completely closed, which is a
-- 
2.39.5




