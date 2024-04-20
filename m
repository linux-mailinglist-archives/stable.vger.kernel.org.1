Return-Path: <stable+bounces-40339-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7248ABC4D
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 18:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10EE51F210A3
	for <lists+stable@lfdr.de>; Sat, 20 Apr 2024 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC73439877;
	Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r3EE1Zz7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9EE625
	for <stable@vger.kernel.org>; Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713628813; cv=none; b=TWCKB8kmDpOBhOh3K90FLAatwc2vdg7OZrIj8mlQoP9HVtLOCcm49dnaY93OaazMpL05jVOZFSyrBPcBXsKMOYXUdsyWWaDUCgvjChoYO6B5L41K0lSY/sz7iTSYx4FU4S9aZKqdvGdCAsrI6xDGvhHk0Qv9tpe2qd2+QkBwunI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713628813; c=relaxed/simple;
	bh=0MnRZPC2mrEpE8ymUREoYSqsX42ph6TtnZV8MuSI1OM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E98g+ZRIacXxZUgPQfYQet5yeMHhdL340eyo/OhFvkGOVypAMdAHEZH+kEfHw0QAGzhIyD7CrtxGHo1pxeP3S/1PYMaUtIKRrGDB1vuY74YefZ51o1bT9UAw5vXYmJBi/eNyQus9DhbxnPlXdA+Xqoq8fV2qs5b+Tw8hHCA5nCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r3EE1Zz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2E7D2C32781;
	Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713628813;
	bh=0MnRZPC2mrEpE8ymUREoYSqsX42ph6TtnZV8MuSI1OM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r3EE1Zz7cLA6cHUuT5SeGFOuIfh9nzDajC/7eEkLaGzD6oBmwlk5o5Tx7IivrMGwf
	 6Uq96d9zPH4jM/+97HeG2qnwRiRfcaM49ukeg2kxOWK8uVe4o5Kh7jtQd9oc1BhM46
	 RPG/+8IKQ1M9cqVSu0uDH1Klwk4rgUPPMAreShX8nze4n8e2fIvaYVNHk3Q+LBGHRB
	 qXO1uWPCb165WwyGRhFaH53oUahOBpfzIWb34Amk7Gc0IhzmNXt3U7lomCsBFRvGCr
	 nR5KKiW450KD6U3oB04XSrC+3BNIlQYpv7KC0rXELI/0uu2l6MRr62nFiyVuf9o4DW
	 MiY2Sbu1QlTHw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9D6C07E8D;
	Sat, 20 Apr 2024 16:00:13 +0000 (UTC)
From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL_via_B4_Relay?= <devnull+arinc.unal.arinc9.com@kernel.org>
Date: Sat, 20 Apr 2024 18:59:51 +0300
Subject: [PATCH 2/4] net: dsa: introduce preferred_default_local_cpu_port
 and use on MT7530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240420-for-stable-6-1-backports-v1-2-0c50ca4324ea@arinc9.com>
References: <20240420-for-stable-6-1-backports-v1-0-0c50ca4324ea@arinc9.com>
In-Reply-To: <20240420-for-stable-6-1-backports-v1-0-0c50ca4324ea@arinc9.com>
To: stable@vger.kernel.org
Cc: Daniel Golle <daniel@makrotopia.org>, 
 =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 "David S. Miller" <davem@davemloft.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713628810; l=6747;
 i=arinc.unal@arinc9.com; s=arinc9-Xeront; h=from:subject:message-id;
 bh=5Q6+daNRNnoFsxM8TLKf/QZJoFgO0+0Y6455XO+INgQ=;
 b=gxmUSoVjMfZtPiEfeBHVHXtVVeDXlIHQCH2vNATITffAh8Yml/jC4L4DmkBjUGi8UPirUQCxW
 mytIiXD1XrhA+6L5+qmBmqGs28BZeqklFPvX8/CnECBX4+yRu1d/dUx
X-Developer-Key: i=arinc.unal@arinc9.com; a=ed25519;
 pk=z49tLn29CyiL4uwBTrqH9HO1Wu3sZIuRp4DaLZvtP9M=
X-Endpoint-Received: by B4 Relay for arinc.unal@arinc9.com/arinc9-Xeront
 with auth_id=137
X-Original-From: =?utf-8?q?Ar=C4=B1n=C3=A7_=C3=9CNAL?= <arinc.unal@arinc9.com>
Reply-To: arinc.unal@arinc9.com

From: Vladimir Oltean <olteanv@gmail.com>

[ Upstream commit b79d7c14f48083abb3fb061370c0c64a569edf4c ]

Since the introduction of the OF bindings, DSA has always had a policy that
in case multiple CPU ports are present in the device tree, the numerically
smallest one is always chosen.

The MT7530 switch family, except the switch on the MT7988 SoC, has 2 CPU
ports, 5 and 6, where port 6 is preferable on the MT7531BE switch because
it has higher bandwidth.

The MT7530 driver developers had 3 options:
- to modify DSA when the MT7531 switch support was introduced, such as to
  prefer the better port
- to declare both CPU ports in device trees as CPU ports, and live with the
  sub-optimal performance resulting from not preferring the better port
- to declare just port 6 in the device tree as a CPU port

Of course they chose the path of least resistance (3rd option), kicking the
can down the road. The hardware description in the device tree is supposed
to be stable - developers are not supposed to adopt the strategy of
piecemeal hardware description, where the device tree is updated in
lockstep with the features that the kernel currently supports.

Now, as a result of the fact that they did that, any attempts to modify the
device tree and describe both CPU ports as CPU ports would make DSA change
its default selection from port 6 to 5, effectively resulting in a
performance degradation visible to users with the MT7531BE switch as can be
seen below.

Without preferring port 6:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-20.00  sec   374 MBytes   157 Mbits/sec  734    sender
[  5][TX-C]   0.00-20.00  sec   373 MBytes   156 Mbits/sec    receiver
[  7][RX-C]   0.00-20.00  sec  1.81 GBytes   778 Mbits/sec    0    sender
[  7][RX-C]   0.00-20.00  sec  1.81 GBytes   777 Mbits/sec    receiver

With preferring port 6:

[ ID][Role] Interval           Transfer     Bitrate         Retr
[  5][TX-C]   0.00-20.00  sec  1.99 GBytes   856 Mbits/sec  273    sender
[  5][TX-C]   0.00-20.00  sec  1.99 GBytes   855 Mbits/sec    receiver
[  7][RX-C]   0.00-20.00  sec  1.72 GBytes   737 Mbits/sec   15    sender
[  7][RX-C]   0.00-20.00  sec  1.71 GBytes   736 Mbits/sec    receiver

Using one port for WAN and the other ports for LAN is a very popular use
case which is what this test emulates.

As such, this change proposes that we retroactively modify stable kernels
(which don't support the modification of the CPU port assignments, so as to
let user space fix the problem and restore the throughput) to keep the
mt7530 driver preferring port 6 even with device trees where the hardware
is more fully described.

Fixes: c288575f7810 ("net: dsa: mt7530: Add the support of MT7531 switch")
Signed-off-by: Vladimir Oltean <olteanv@gmail.com>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Arınç ÜNAL <arinc.unal@arinc9.com>
---
 drivers/net/dsa/mt7530.c | 15 +++++++++++++++
 include/net/dsa.h        |  8 ++++++++
 net/dsa/dsa2.c           | 24 +++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index ddeafd7e7a81..7a70695d1182 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -419,6 +419,20 @@ static void mt7530_pll_setup(struct mt7530_priv *priv)
 	core_set(priv, CORE_TRGMII_GSW_CLK_CG, REG_GSWCK_EN);
 }
 
+/* If port 6 is available as a CPU port, always prefer that as the default,
+ * otherwise don't care.
+ */
+static struct dsa_port *
+mt753x_preferred_default_local_cpu_port(struct dsa_switch *ds)
+{
+	struct dsa_port *cpu_dp = dsa_to_port(ds, 6);
+
+	if (dsa_port_is_cpu(cpu_dp))
+		return cpu_dp;
+
+	return NULL;
+}
+
 /* Setup port 6 interface mode and TRGMII TX circuit */
 static int
 mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
@@ -3399,6 +3413,7 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 static const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_tag_protocol	= mtk_get_tag_protocol,
 	.setup			= mt753x_setup,
+	.preferred_default_local_cpu_port = mt753x_preferred_default_local_cpu_port,
 	.get_strings		= mt7530_get_strings,
 	.get_ethtool_stats	= mt7530_get_ethtool_stats,
 	.get_sset_count		= mt7530_get_sset_count,
diff --git a/include/net/dsa.h b/include/net/dsa.h
index ee369670e20e..f96b61d9768e 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -968,6 +968,14 @@ struct dsa_switch_ops {
 			       struct phy_device *phy);
 	void	(*port_disable)(struct dsa_switch *ds, int port);
 
+	/*
+	 * Compatibility between device trees defining multiple CPU ports and
+	 * drivers which are not OK to use by default the numerically smallest
+	 * CPU port of a switch for its local ports. This can return NULL,
+	 * meaning "don't know/don't care".
+	 */
+	struct dsa_port *(*preferred_default_local_cpu_port)(struct dsa_switch *ds);
+
 	/*
 	 * Port's MAC EEE settings
 	 */
diff --git a/net/dsa/dsa2.c b/net/dsa/dsa2.c
index 5417f7b1187c..98f864879175 100644
--- a/net/dsa/dsa2.c
+++ b/net/dsa/dsa2.c
@@ -425,6 +425,24 @@ static int dsa_tree_setup_default_cpu(struct dsa_switch_tree *dst)
 	return 0;
 }
 
+static struct dsa_port *
+dsa_switch_preferred_default_local_cpu_port(struct dsa_switch *ds)
+{
+	struct dsa_port *cpu_dp;
+
+	if (!ds->ops->preferred_default_local_cpu_port)
+		return NULL;
+
+	cpu_dp = ds->ops->preferred_default_local_cpu_port(ds);
+	if (!cpu_dp)
+		return NULL;
+
+	if (WARN_ON(!dsa_port_is_cpu(cpu_dp) || cpu_dp->ds != ds))
+		return NULL;
+
+	return cpu_dp;
+}
+
 /* Perform initial assignment of CPU ports to user ports and DSA links in the
  * fabric, giving preference to CPU ports local to each switch. Default to
  * using the first CPU port in the switch tree if the port does not have a CPU
@@ -432,12 +450,16 @@ static int dsa_tree_setup_default_cpu(struct dsa_switch_tree *dst)
  */
 static int dsa_tree_setup_cpu_ports(struct dsa_switch_tree *dst)
 {
-	struct dsa_port *cpu_dp, *dp;
+	struct dsa_port *preferred_cpu_dp, *cpu_dp, *dp;
 
 	list_for_each_entry(cpu_dp, &dst->ports, list) {
 		if (!dsa_port_is_cpu(cpu_dp))
 			continue;
 
+		preferred_cpu_dp = dsa_switch_preferred_default_local_cpu_port(cpu_dp->ds);
+		if (preferred_cpu_dp && preferred_cpu_dp != cpu_dp)
+			continue;
+
 		/* Prefer a local CPU port */
 		dsa_switch_for_each_port(dp, cpu_dp->ds) {
 			/* Prefer the first local CPU port found */

-- 
2.40.1



