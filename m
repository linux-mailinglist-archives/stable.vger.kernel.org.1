Return-Path: <stable+bounces-78572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52ECB98C491
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 119AA28576E
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85E971CEAA2;
	Tue,  1 Oct 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="b0yTpGv2"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7A11CDA26
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803939; cv=none; b=smjzeJeln2BmhC3DcJfQexSbTBi0+14S5DAyScx9tOvuVlChfr2Ew1MV/ikdNAFLAZyGRKdSVSQHn3J3kj7HUAB0+r7GwyBryGVafuzBx147nCVdPZ/HQUHWxTYO6XtBkvfYCzSFZhN+HVjmhP6HpbmQ8kW3reKuqIXIf4vOWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803939; c=relaxed/simple;
	bh=wD5UzNOGnwoP9ZSWg2h3fTpS7wT4w7eNnEoqlpkN8m8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R0EW/9aSDPyPPkgT9DCOGaIaWWEWtCf3mhheeiPvqBjp81/h/pSPQFV8CnududchYysC4WiMWuOfG9altZ1o+idaRH/JK1iQrVMInnMVHaqv71u5MZB4u570wvoZgtpi0DgLBmKHoKB9js9r4lD5zbG2FiPbH8y49ePTPgT8Q4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=b0yTpGv2; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HzqaCbz4br+TId6QRJQ5oLRsFXW/A1tLqhS1ZmhX9J0=;
	b=b0yTpGv2AdHDqTg3mZ9GFJ7dZ8aho0wFTMbh9zYvPE9D1p/mS6Hu6EDPslkvxdi2+C+T/Y
	u9rrduZWsJ5eMpuTx9p9dyhPnVdEuFcTZiV23Y2RysnIt1DREJcYaDijGSHs13MymfLlsi
	cyzfS3qA/OXz48Hsv4jZ2g5MsT/HpQw=
Received: from g7t16454g.inc.hp.com (hpifallback.mail.core.hp.com
 [15.73.128.143]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-onVi1qf5N7uGwN-3Q-fnWg-1; Tue, 01 Oct 2024 13:32:15 -0400
X-MC-Unique: onVi1qf5N7uGwN-3Q-fnWg-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g7t16454g.inc.hp.com (Postfix) with ESMTPS id B3E7A6000C06;
	Tue,  1 Oct 2024 17:32:13 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 146C818;
	Tue,  1 Oct 2024 17:32:11 +0000 (UTC)
From: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: qin.wan@hp.com,
	andreas.noever@gmail.com,
	michael.jamet@intel.com,
	mika.westerberg@linux.intel.com,
	YehezkelShB@gmail.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gil Fine <gil.fine@linux.intel.com>,
	Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Subject: [PATCH 6.6 08/14] thunderbolt: Change bandwidth reservations to comply USB4 v2
Date: Tue,  1 Oct 2024 17:31:03 +0000
Message-Id: <20241001173109.1513-9-alexandru.gagniuc@hp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001173109.1513-1-alexandru.gagniuc@hp.com>
References: <20241001173109.1513-1-alexandru.gagniuc@hp.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: hp.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=WINDOWS-1252; x-default=true

From: Gil Fine <gil.fine@linux.intel.com>

[ Upstream commit 582e70b0d3a412d15389a3c9c07a44791b311715 ]

USB4 v2 Connection Manager guide (section 6.1.2.3) suggests to reserve
bandwidth in a sligthly different manner. It suggests to keep minimum of
1500 Mb/s for each path that carry a bulk traffic. Here we change the
bandwidth reservations to comply to the above for USB 3.x and PCIe
protocols over Gen 4 link, taking weights into account (that's 1500 Mb/s
for PCIe and 3000 Mb/s for USB 3.x).

For Gen 3 and below we use the existing reservation.

Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/thunderbolt/tb.c     | 11 ++++++
 drivers/thunderbolt/tunnel.c | 66 ++++++++++++++++++++++++++++++++++--
 drivers/thunderbolt/tunnel.h |  2 ++
 3 files changed, 76 insertions(+), 3 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index e37fb1081420..183225bdbbf5 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -602,6 +602,7 @@ static int tb_available_bandwidth(struct tb *tb, struct=
 tb_port *src_port,
 =09/* Find the minimum available bandwidth over all links */
 =09tb_for_each_port_on_path(src_port, dst_port, port) {
 =09=09int link_speed, link_width, up_bw, down_bw;
+=09=09int pci_reserved_up, pci_reserved_down;
=20
 =09=09if (!tb_port_is_null(port))
 =09=09=09continue;
@@ -695,6 +696,16 @@ static int tb_available_bandwidth(struct tb *tb, struc=
t tb_port *src_port,
 =09=09up_bw -=3D usb3_consumed_up;
 =09=09down_bw -=3D usb3_consumed_down;
=20
+=09=09/*
+=09=09 * If there is anything reserved for PCIe bulk traffic
+=09=09 * take it into account here too.
+=09=09 */
+=09=09if (tb_tunnel_reserved_pci(port, &pci_reserved_up,
+=09=09=09=09=09   &pci_reserved_down)) {
+=09=09=09up_bw -=3D pci_reserved_up;
+=09=09=09down_bw -=3D pci_reserved_down;
+=09=09}
+
 =09=09if (up_bw < *available_up)
 =09=09=09*available_up =3D up_bw;
 =09=09if (down_bw < *available_down)
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index b81344c6c06a..e296ab5d657b 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -31,7 +31,7 @@
 #define TB_USB3_PATH_UP=09=09=091
=20
 #define TB_USB3_PRIORITY=09=093
-#define TB_USB3_WEIGHT=09=09=093
+#define TB_USB3_WEIGHT=09=09=092
=20
 /* DP adapters use HopID 8 for AUX and 9 for Video */
 #define TB_DP_AUX_TX_HOPID=09=098
@@ -61,6 +61,15 @@
 #define TB_DMA_PRIORITY=09=09=095
 #define TB_DMA_WEIGHT=09=09=091
=20
+/*
+ * Reserve additional bandwidth for USB 3.x and PCIe bulk traffic
+ * according to USB4 v2 Connection Manager guide. This ends up reserving
+ * 1500 Mb/s for PCIe and 3000 Mb/s for USB 3.x taking weights into
+ * account.
+ */
+#define USB4_V2_PCI_MIN_BANDWIDTH=09(1500 * TB_PCI_WEIGHT)
+#define USB4_V2_USB3_MIN_BANDWIDTH=09(1500 * TB_USB3_WEIGHT)
+
 static unsigned int dma_credits =3D TB_DMA_CREDITS;
 module_param(dma_credits, uint, 0444);
 MODULE_PARM_DESC(dma_credits, "specify custom credits for DMA tunnels (def=
ault: "
@@ -150,11 +159,11 @@ static struct tb_tunnel *tb_tunnel_alloc(struct tb *t=
b, size_t npaths,
=20
 static int tb_pci_set_ext_encapsulation(struct tb_tunnel *tunnel, bool ena=
ble)
 {
+=09struct tb_port *port =3D tb_upstream_port(tunnel->dst_port->sw);
 =09int ret;
=20
 =09/* Only supported of both routers are at least USB4 v2 */
-=09if (usb4_switch_version(tunnel->src_port->sw) < 2 ||
-=09    usb4_switch_version(tunnel->dst_port->sw) < 2)
+=09if (tb_port_get_link_generation(port) < 4)
 =09=09return 0;
=20
 =09ret =3D usb4_pci_port_set_ext_encapsulation(tunnel->src_port, enable);
@@ -370,6 +379,51 @@ struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, s=
truct tb_port *up,
 =09return NULL;
 }
=20
+/**
+ * tb_tunnel_reserved_pci() - Amount of bandwidth to reserve for PCIe
+ * @port: Lane 0 adapter
+ * @reserved_up: Upstream bandwidth in Mb/s to reserve
+ * @reserved_down: Downstream bandwidth in Mb/s to reserve
+ *
+ * Can be called to any connected lane 0 adapter to find out how much
+ * bandwidth needs to be left in reserve for possible PCIe bulk traffic.
+ * Returns true if there is something to be reserved and writes the
+ * amount to @reserved_down/@reserved_up. Otherwise returns false and
+ * does not touch the parameters.
+ */
+bool tb_tunnel_reserved_pci(struct tb_port *port, int *reserved_up,
+=09=09=09    int *reserved_down)
+{
+=09if (WARN_ON_ONCE(!port->remote))
+=09=09return false;
+
+=09if (!tb_acpi_may_tunnel_pcie())
+=09=09return false;
+
+=09if (tb_port_get_link_generation(port) < 4)
+=09=09return false;
+
+=09/* Must have PCIe adapters */
+=09if (tb_is_upstream_port(port)) {
+=09=09if (!tb_switch_find_port(port->sw, TB_TYPE_PCIE_UP))
+=09=09=09return false;
+=09=09if (!tb_switch_find_port(port->remote->sw, TB_TYPE_PCIE_DOWN))
+=09=09=09return false;
+=09} else {
+=09=09if (!tb_switch_find_port(port->sw, TB_TYPE_PCIE_DOWN))
+=09=09=09return false;
+=09=09if (!tb_switch_find_port(port->remote->sw, TB_TYPE_PCIE_UP))
+=09=09=09return false;
+=09}
+
+=09*reserved_up =3D USB4_V2_PCI_MIN_BANDWIDTH;
+=09*reserved_down =3D USB4_V2_PCI_MIN_BANDWIDTH;
+
+=09tb_port_dbg(port, "reserving %u/%u Mb/s for PCIe\n", *reserved_up,
+=09=09    *reserved_down);
+=09return true;
+}
+
 static bool tb_dp_is_usb4(const struct tb_switch *sw)
 {
 =09/* Titan Ridge DP adapters need the same treatment as USB4 */
@@ -1747,6 +1801,7 @@ static int tb_usb3_activate(struct tb_tunnel *tunnel,=
 bool activate)
 static int tb_usb3_consumed_bandwidth(struct tb_tunnel *tunnel,
 =09=09int *consumed_up, int *consumed_down)
 {
+=09struct tb_port *port =3D tb_upstream_port(tunnel->dst_port->sw);
 =09int pcie_weight =3D tb_acpi_may_tunnel_pcie() ? TB_PCI_WEIGHT : 0;
=20
 =09/*
@@ -1758,6 +1813,11 @@ static int tb_usb3_consumed_bandwidth(struct tb_tunn=
el *tunnel,
 =09*consumed_down =3D tunnel->allocated_down *
 =09=09(TB_USB3_WEIGHT + pcie_weight) / TB_USB3_WEIGHT;
=20
+=09if (tb_port_get_link_generation(port) >=3D 4) {
+=09=09*consumed_up =3D max(*consumed_up, USB4_V2_USB3_MIN_BANDWIDTH);
+=09=09*consumed_down =3D max(*consumed_down, USB4_V2_USB3_MIN_BANDWIDTH);
+=09}
+
 =09return 0;
 }
=20
diff --git a/drivers/thunderbolt/tunnel.h b/drivers/thunderbolt/tunnel.h
index 750ebb570d99..b4cff5482112 100644
--- a/drivers/thunderbolt/tunnel.h
+++ b/drivers/thunderbolt/tunnel.h
@@ -80,6 +80,8 @@ struct tb_tunnel *tb_tunnel_discover_pci(struct tb *tb, s=
truct tb_port *down,
 =09=09=09=09=09 bool alloc_hopid);
 struct tb_tunnel *tb_tunnel_alloc_pci(struct tb *tb, struct tb_port *up,
 =09=09=09=09      struct tb_port *down);
+bool tb_tunnel_reserved_pci(struct tb_port *port, int *reserved_up,
+=09=09=09    int *reserved_down);
 struct tb_tunnel *tb_tunnel_discover_dp(struct tb *tb, struct tb_port *in,
 =09=09=09=09=09bool alloc_hopid);
 struct tb_tunnel *tb_tunnel_alloc_dp(struct tb *tb, struct tb_port *in,
--=20
2.45.1


