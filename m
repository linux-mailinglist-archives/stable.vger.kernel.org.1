Return-Path: <stable+bounces-78577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25DCC98C49F
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:35:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74229B238E4
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D13A1CC88D;
	Tue,  1 Oct 2024 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="c/3cmU0P"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4461CC880
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803946; cv=none; b=cEA8Zj3IG3b1j4ytplVcx8Lr9rZ1NZjSozjODaJxy4Hz3bznqBnwT41l9swogZrFeotPIx93cT3ftP7LRngHl4Rhc69HTbMq6KRcj/ay8mJwgVjfbLJ290F3lVwS0xPzev6Zvjd9xCiLDM6UmShfuBlc2rT82k1u6ifQtZVzU50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803946; c=relaxed/simple;
	bh=DIINOT42YchIWJ+zd0FHdcvBKnl6XN3kJQP4Iq5jl5A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDK/5LPIVKgUQ4DDXZezcBa0WkWDCTABRYRyhNF91hiF/fS05ULtr1DbThmCKKmkdXEfEw/tFyGmMBE9TgXVImj/s1qfjcauBcBoQGvey3aPQmLMLb5lukffIX1c8vkA/9GZP30t/L/SZFsF++MCa+zvC5eCRZ9fhzOJ7KGojKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=c/3cmU0P; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803942;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZjZhgctZtpP6DpugbtO933fRuYTRgFbd3PqLZMvoOHk=;
	b=c/3cmU0PXfp/3Jclzmq1vumUZeYFslBKb16wskWBSf7nctwC376CSZug4KmQbXUD1MbfhP
	49NamqjbKuTJ7lZ2i4uRxA6gQef4iEnc8fiH1vprcv1oGZlYwSu5g6wM7yt7yWhFX3CnpK
	UEATEAI+qbz37X2sySdd4ftnzCzVhUs=
Received: from g7t16454g.inc.hp.com (g7t16454g.inc.hp.com [15.73.128.143])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-121-ksSeZ18TMZaubxo49BurlA-1; Tue,
 01 Oct 2024 13:32:21 -0400
X-MC-Unique: ksSeZ18TMZaubxo49BurlA-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g7t16454g.inc.hp.com (Postfix) with ESMTPS id 8F6376000D9B;
	Tue,  1 Oct 2024 17:32:20 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id E53261E;
	Tue,  1 Oct 2024 17:32:18 +0000 (UTC)
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
Subject: [PATCH 6.6 13/14] thunderbolt: Configure asymmetric link if needed and bandwidth allows
Date: Tue,  1 Oct 2024 17:31:08 +0000
Message-Id: <20241001173109.1513-14-alexandru.gagniuc@hp.com>
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

[ Upstream commit 3e36528c1127b20492ffaea53930bcc3df46a718 ]

USB4 v2 spec defines a Gen 4 link that can operate as an asymmetric
120/40G. When the link is asymmetric, the USB4 port on one side of the
link operates with three TX lanes and one RX lane, while the USB4 port
on the opposite side of the link operates with three RX lanes and one TX
lane. Using asymmetric link we can get much more bandwidth from one
direction and that allows us to support the new Ultra High Bit Rate
DisplayPort modes (that consume up to 77.37 Gb/s).

Add the basic logic for changing Gen 4 links to asymmetric and back
following the below rules:

  1) The default threshold is 45 Gb/s (tunable by asym_threshold)
  2) When DisplayPort tunnel is established, or when there is bandwidth
     request through bandwidth allocation mode, the links can be
     transitioned to asymmetric or symmetric (depending on the
     required bandwidth).
  3) Only DisplayPort bandwidth on a link, is taken into account when
     deciding whether a link is transitioned to asymmetric or symmetric
  4) If bandwidth on a link is >=3D asym_threshold transition the link to
     asymmetric
  5) If bandwidth on a link < asym_threshold transition the link to
     symmetric (unless the bandwidth request is above currently
     allocated on a tunnel).
  6) If a USB4 v2 device router with symmetric link is connected,
     transition all the links above it to symmetric if the bandwidth
     allows.

Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Co-developed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/thunderbolt/tb.c | 681 ++++++++++++++++++++++++++++++++-------
 1 file changed, 558 insertions(+), 123 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 550f1c9a1170..c52cbd5194f1 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -16,8 +16,31 @@
 #include "tb_regs.h"
 #include "tunnel.h"
=20
-#define TB_TIMEOUT=09100=09/* ms */
-#define MAX_GROUPS=097=09/* max Group_ID is 7 */
+#define TB_TIMEOUT=09=09100=09/* ms */
+
+/*
+ * Minimum bandwidth (in Mb/s) that is needed in the single transmitter/re=
ceiver
+ * direction. This is 40G - 10% guard band bandwidth.
+ */
+#define TB_ASYM_MIN=09=09(40000 * 90 / 100)
+
+/*
+ * Threshold bandwidth (in Mb/s) that is used to switch the links to
+ * asymmetric and back. This is selected as 45G which means when the
+ * request is higher than this, we switch the link to asymmetric, and
+ * when it is less than this we switch it back. The 45G is selected so
+ * that we still have 27G (of the total 72G) for bulk PCIe traffic when
+ * switching back to symmetric.
+ */
+#define TB_ASYM_THRESHOLD=0945000
+
+#define MAX_GROUPS=09=097=09/* max Group_ID is 7 */
+
+static unsigned int asym_threshold =3D TB_ASYM_THRESHOLD;
+module_param_named(asym_threshold, asym_threshold, uint, 0444);
+MODULE_PARM_DESC(asym_threshold,
+=09=09"threshold (Mb/s) when to Gen 4 switch link symmetry. 0 disables. (d=
efault: "
+=09=09__MODULE_STRING(TB_ASYM_THRESHOLD) ")");
=20
 /**
  * struct tb_cm - Simple Thunderbolt connection manager
@@ -285,14 +308,32 @@ static int tb_enable_clx(struct tb_switch *sw)
 =09return ret =3D=3D -EOPNOTSUPP ? 0 : ret;
 }
=20
-/* Disables CL states up to the host router */
-static void tb_disable_clx(struct tb_switch *sw)
+/**
+ * tb_disable_clx() - Disable CL states up to host router
+ * @sw: Router to start
+ *
+ * Disables CL states from @sw up to the host router. Returns true if
+ * any CL state were disabled. This can be used to figure out whether
+ * the link was setup by us or the boot firmware so we don't
+ * accidentally enable them if they were not enabled during discovery.
+ */
+static bool tb_disable_clx(struct tb_switch *sw)
 {
+=09bool disabled =3D false;
+
 =09do {
-=09=09if (tb_switch_clx_disable(sw) < 0)
+=09=09int ret;
+
+=09=09ret =3D tb_switch_clx_disable(sw);
+=09=09if (ret > 0)
+=09=09=09disabled =3D true;
+=09=09else if (ret < 0)
 =09=09=09tb_sw_warn(sw, "failed to disable CL states\n");
+
 =09=09sw =3D tb_switch_parent(sw);
 =09} while (sw);
+
+=09return disabled;
 }
=20
 static int tb_increase_switch_tmu_accuracy(struct device *dev, void *data)
@@ -572,144 +613,294 @@ static struct tb_tunnel *tb_find_first_usb3_tunnel(=
struct tb *tb,
 =09return tb_find_tunnel(tb, TB_TUNNEL_USB3, usb3_down, NULL);
 }
=20
-static int tb_available_bandwidth(struct tb *tb, struct tb_port *src_port,
-=09struct tb_port *dst_port, int *available_up, int *available_down)
-{
-=09int usb3_consumed_up, usb3_consumed_down, ret;
-=09struct tb_cm *tcm =3D tb_priv(tb);
+/**
+ * tb_consumed_usb3_pcie_bandwidth() - Consumed USB3/PCIe bandwidth over a=
 single link
+ * @tb: Domain structure
+ * @src_port: Source protocol adapter
+ * @dst_port: Destination protocol adapter
+ * @port: USB4 port the consumed bandwidth is calculated
+ * @consumed_up: Consumed upsream bandwidth (Mb/s)
+ * @consumed_down: Consumed downstream bandwidth (Mb/s)
+ *
+ * Calculates consumed USB3 and PCIe bandwidth at @port between path
+ * from @src_port to @dst_port. Does not take tunnel starting from
+ * @src_port and ending from @src_port into account.
+ */
+static int tb_consumed_usb3_pcie_bandwidth(struct tb *tb,
+=09=09=09=09=09   struct tb_port *src_port,
+=09=09=09=09=09   struct tb_port *dst_port,
+=09=09=09=09=09   struct tb_port *port,
+=09=09=09=09=09   int *consumed_up,
+=09=09=09=09=09   int *consumed_down)
+{
+=09int pci_consumed_up, pci_consumed_down;
 =09struct tb_tunnel *tunnel;
-=09struct tb_port *port;
=20
-=09tb_dbg(tb, "calculating available bandwidth between %llx:%u <-> %llx:%u=
\n",
-=09       tb_route(src_port->sw), src_port->port, tb_route(dst_port->sw),
-=09       dst_port->port);
+=09*consumed_up =3D *consumed_down =3D 0;
=20
 =09tunnel =3D tb_find_first_usb3_tunnel(tb, src_port, dst_port);
 =09if (tunnel && tunnel->src_port !=3D src_port &&
 =09    tunnel->dst_port !=3D dst_port) {
-=09=09ret =3D tb_tunnel_consumed_bandwidth(tunnel, &usb3_consumed_up,
-=09=09=09=09=09=09   &usb3_consumed_down);
+=09=09int ret;
+
+=09=09ret =3D tb_tunnel_consumed_bandwidth(tunnel, consumed_up,
+=09=09=09=09=09=09   consumed_down);
 =09=09if (ret)
 =09=09=09return ret;
-=09} else {
-=09=09usb3_consumed_up =3D 0;
-=09=09usb3_consumed_down =3D 0;
 =09}
=20
-=09/* Maximum possible bandwidth asymmetric Gen 4 link is 120 Gb/s */
-=09*available_up =3D *available_down =3D 120000;
+=09/*
+=09 * If there is anything reserved for PCIe bulk traffic take it
+=09 * into account here too.
+=09 */
+=09if (tb_tunnel_reserved_pci(port, &pci_consumed_up, &pci_consumed_down))=
 {
+=09=09*consumed_up +=3D pci_consumed_up;
+=09=09*consumed_down +=3D pci_consumed_down;
+=09}
=20
-=09/* Find the minimum available bandwidth over all links */
-=09tb_for_each_port_on_path(src_port, dst_port, port) {
-=09=09int link_speed, link_width, up_bw, down_bw;
-=09=09int pci_reserved_up, pci_reserved_down;
+=09return 0;
+}
=20
-=09=09if (!tb_port_is_null(port))
+/**
+ * tb_consumed_dp_bandwidth() - Consumed DP bandwidth over a single link
+ * @tb: Domain structure
+ * @src_port: Source protocol adapter
+ * @dst_port: Destination protocol adapter
+ * @port: USB4 port the consumed bandwidth is calculated
+ * @consumed_up: Consumed upsream bandwidth (Mb/s)
+ * @consumed_down: Consumed downstream bandwidth (Mb/s)
+ *
+ * Calculates consumed DP bandwidth at @port between path from @src_port
+ * to @dst_port. Does not take tunnel starting from @src_port and ending
+ * from @src_port into account.
+ */
+static int tb_consumed_dp_bandwidth(struct tb *tb,
+=09=09=09=09    struct tb_port *src_port,
+=09=09=09=09    struct tb_port *dst_port,
+=09=09=09=09    struct tb_port *port,
+=09=09=09=09    int *consumed_up,
+=09=09=09=09    int *consumed_down)
+{
+=09struct tb_cm *tcm =3D tb_priv(tb);
+=09struct tb_tunnel *tunnel;
+=09int ret;
+
+=09*consumed_up =3D *consumed_down =3D 0;
+
+=09/*
+=09 * Find all DP tunnels that cross the port and reduce
+=09 * their consumed bandwidth from the available.
+=09 */
+=09list_for_each_entry(tunnel, &tcm->tunnel_list, list) {
+=09=09int dp_consumed_up, dp_consumed_down;
+
+=09=09if (tb_tunnel_is_invalid(tunnel))
 =09=09=09continue;
=20
-=09=09if (tb_is_upstream_port(port)) {
-=09=09=09link_speed =3D port->sw->link_speed;
+=09=09if (!tb_tunnel_is_dp(tunnel))
+=09=09=09continue;
+
+=09=09if (!tb_tunnel_port_on_path(tunnel, port))
+=09=09=09continue;
+
+=09=09/*
+=09=09 * Ignore the DP tunnel between src_port and dst_port
+=09=09 * because it is the same tunnel and we may be
+=09=09 * re-calculating estimated bandwidth.
+=09=09 */
+=09=09if (tunnel->src_port =3D=3D src_port &&
+=09=09    tunnel->dst_port =3D=3D dst_port)
+=09=09=09continue;
+
+=09=09ret =3D tb_tunnel_consumed_bandwidth(tunnel, &dp_consumed_up,
+=09=09=09=09=09=09   &dp_consumed_down);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09*consumed_up +=3D dp_consumed_up;
+=09=09*consumed_down +=3D dp_consumed_down;
+=09}
+
+=09return 0;
+}
+
+static bool tb_asym_supported(struct tb_port *src_port, struct tb_port *ds=
t_port,
+=09=09=09      struct tb_port *port)
+{
+=09bool downstream =3D tb_port_path_direction_downstream(src_port, dst_por=
t);
+=09enum tb_link_width width;
+
+=09if (tb_is_upstream_port(port))
+=09=09width =3D downstream ? TB_LINK_WIDTH_ASYM_RX : TB_LINK_WIDTH_ASYM_TX=
;
+=09else
+=09=09width =3D downstream ? TB_LINK_WIDTH_ASYM_TX : TB_LINK_WIDTH_ASYM_RX=
;
+
+=09return tb_port_width_supported(port, width);
+}
+
+/**
+ * tb_maximum_banwidth() - Maximum bandwidth over a single link
+ * @tb: Domain structure
+ * @src_port: Source protocol adapter
+ * @dst_port: Destination protocol adapter
+ * @port: USB4 port the total bandwidth is calculated
+ * @max_up: Maximum upstream bandwidth (Mb/s)
+ * @max_down: Maximum downstream bandwidth (Mb/s)
+ * @include_asym: Include bandwidth if the link is switched from
+ *=09=09  symmetric to asymmetric
+ *
+ * Returns maximum possible bandwidth in @max_up and @max_down over a
+ * single link at @port. If @include_asym is set then includes the
+ * additional banwdith if the links are transitioned into asymmetric to
+ * direction from @src_port to @dst_port.
+ */
+static int tb_maximum_bandwidth(struct tb *tb, struct tb_port *src_port,
+=09=09=09=09struct tb_port *dst_port, struct tb_port *port,
+=09=09=09=09int *max_up, int *max_down, bool include_asym)
+{
+=09bool downstream =3D tb_port_path_direction_downstream(src_port, dst_por=
t);
+=09int link_speed, link_width, up_bw, down_bw;
+
+=09/*
+=09 * Can include asymmetric, only if it is actually supported by
+=09 * the lane adapter.
+=09 */
+=09if (!tb_asym_supported(src_port, dst_port, port))
+=09=09include_asym =3D false;
+
+=09if (tb_is_upstream_port(port)) {
+=09=09link_speed =3D port->sw->link_speed;
+=09=09/*
+=09=09 * sw->link_width is from upstream perspective so we use
+=09=09 * the opposite for downstream of the host router.
+=09=09 */
+=09=09if (port->sw->link_width =3D=3D TB_LINK_WIDTH_ASYM_TX) {
+=09=09=09up_bw =3D link_speed * 3 * 1000;
+=09=09=09down_bw =3D link_speed * 1 * 1000;
+=09=09} else if (port->sw->link_width =3D=3D TB_LINK_WIDTH_ASYM_RX) {
+=09=09=09up_bw =3D link_speed * 1 * 1000;
+=09=09=09down_bw =3D link_speed * 3 * 1000;
+=09=09} else if (include_asym) {
 =09=09=09/*
-=09=09=09 * sw->link_width is from upstream perspective
-=09=09=09 * so we use the opposite for downstream of the
-=09=09=09 * host router.
+=09=09=09 * The link is symmetric at the moment but we
+=09=09=09 * can switch it to asymmetric as needed. Report
+=09=09=09 * this bandwidth as available (even though it
+=09=09=09 * is not yet enabled).
 =09=09=09 */
-=09=09=09if (port->sw->link_width =3D=3D TB_LINK_WIDTH_ASYM_TX) {
-=09=09=09=09up_bw =3D link_speed * 3 * 1000;
-=09=09=09=09down_bw =3D link_speed * 1 * 1000;
-=09=09=09} else if (port->sw->link_width =3D=3D TB_LINK_WIDTH_ASYM_RX) {
+=09=09=09if (downstream) {
 =09=09=09=09up_bw =3D link_speed * 1 * 1000;
 =09=09=09=09down_bw =3D link_speed * 3 * 1000;
 =09=09=09} else {
-=09=09=09=09up_bw =3D link_speed * port->sw->link_width * 1000;
-=09=09=09=09down_bw =3D up_bw;
+=09=09=09=09up_bw =3D link_speed * 3 * 1000;
+=09=09=09=09down_bw =3D link_speed * 1 * 1000;
 =09=09=09}
 =09=09} else {
-=09=09=09link_speed =3D tb_port_get_link_speed(port);
-=09=09=09if (link_speed < 0)
-=09=09=09=09return link_speed;
-
-=09=09=09link_width =3D tb_port_get_link_width(port);
-=09=09=09if (link_width < 0)
-=09=09=09=09return link_width;
-
-=09=09=09if (link_width =3D=3D TB_LINK_WIDTH_ASYM_TX) {
+=09=09=09up_bw =3D link_speed * port->sw->link_width * 1000;
+=09=09=09down_bw =3D up_bw;
+=09=09}
+=09} else {
+=09=09link_speed =3D tb_port_get_link_speed(port);
+=09=09if (link_speed < 0)
+=09=09=09return link_speed;
+
+=09=09link_width =3D tb_port_get_link_width(port);
+=09=09if (link_width < 0)
+=09=09=09return link_width;
+
+=09=09if (link_width =3D=3D TB_LINK_WIDTH_ASYM_TX) {
+=09=09=09up_bw =3D link_speed * 1 * 1000;
+=09=09=09down_bw =3D link_speed * 3 * 1000;
+=09=09} else if (link_width =3D=3D TB_LINK_WIDTH_ASYM_RX) {
+=09=09=09up_bw =3D link_speed * 3 * 1000;
+=09=09=09down_bw =3D link_speed * 1 * 1000;
+=09=09} else if (include_asym) {
+=09=09=09/*
+=09=09=09 * The link is symmetric at the moment but we
+=09=09=09 * can switch it to asymmetric as needed. Report
+=09=09=09 * this bandwidth as available (even though it
+=09=09=09 * is not yet enabled).
+=09=09=09 */
+=09=09=09if (downstream) {
 =09=09=09=09up_bw =3D link_speed * 1 * 1000;
 =09=09=09=09down_bw =3D link_speed * 3 * 1000;
-=09=09=09} else if (link_width =3D=3D TB_LINK_WIDTH_ASYM_RX) {
+=09=09=09} else {
 =09=09=09=09up_bw =3D link_speed * 3 * 1000;
 =09=09=09=09down_bw =3D link_speed * 1 * 1000;
-=09=09=09} else {
-=09=09=09=09up_bw =3D link_speed * link_width * 1000;
-=09=09=09=09down_bw =3D up_bw;
 =09=09=09}
+=09=09} else {
+=09=09=09up_bw =3D link_speed * link_width * 1000;
+=09=09=09down_bw =3D up_bw;
 =09=09}
+=09}
=20
-=09=09/* Leave 10% guard band */
-=09=09up_bw -=3D up_bw / 10;
-=09=09down_bw -=3D down_bw / 10;
-
-=09=09tb_port_dbg(port, "link total bandwidth %d/%d Mb/s\n", up_bw,
-=09=09=09    down_bw);
-
-=09=09/*
-=09=09 * Find all DP tunnels that cross the port and reduce
-=09=09 * their consumed bandwidth from the available.
-=09=09 */
-=09=09list_for_each_entry(tunnel, &tcm->tunnel_list, list) {
-=09=09=09int dp_consumed_up, dp_consumed_down;
+=09/* Leave 10% guard band */
+=09*max_up =3D up_bw - up_bw / 10;
+=09*max_down =3D down_bw - down_bw / 10;
=20
-=09=09=09if (tb_tunnel_is_invalid(tunnel))
-=09=09=09=09continue;
+=09tb_port_dbg(port, "link maximum bandwidth %d/%d Mb/s\n", *max_up, *max_=
down);
+=09return 0;
+}
=20
-=09=09=09if (!tb_tunnel_is_dp(tunnel))
-=09=09=09=09continue;
+/**
+ * tb_available_bandwidth() - Available bandwidth for tunneling
+ * @tb: Domain structure
+ * @src_port: Source protocol adapter
+ * @dst_port: Destination protocol adapter
+ * @available_up: Available bandwidth upstream (Mb/s)
+ * @available_down: Available bandwidth downstream (Mb/s)
+ * @include_asym: Include bandwidth if the link is switched from
+ *=09=09  symmetric to asymmetric
+ *
+ * Calculates maximum available bandwidth for protocol tunneling between
+ * @src_port and @dst_port at the moment. This is minimum of maximum
+ * link bandwidth across all links reduced by currently consumed
+ * bandwidth on that link.
+ *
+ * If @include_asym is true then includes also bandwidth that can be
+ * added when the links are transitioned into asymmetric (but does not
+ * transition the links).
+ */
+static int tb_available_bandwidth(struct tb *tb, struct tb_port *src_port,
+=09=09=09=09 struct tb_port *dst_port, int *available_up,
+=09=09=09=09 int *available_down, bool include_asym)
+{
+=09struct tb_port *port;
+=09int ret;
=20
-=09=09=09if (!tb_tunnel_port_on_path(tunnel, port))
-=09=09=09=09continue;
+=09/* Maximum possible bandwidth asymmetric Gen 4 link is 120 Gb/s */
+=09*available_up =3D *available_down =3D 120000;
=20
-=09=09=09/*
-=09=09=09 * Ignore the DP tunnel between src_port and
-=09=09=09 * dst_port because it is the same tunnel and we
-=09=09=09 * may be re-calculating estimated bandwidth.
-=09=09=09 */
-=09=09=09if (tunnel->src_port =3D=3D src_port &&
-=09=09=09    tunnel->dst_port =3D=3D dst_port)
-=09=09=09=09continue;
+=09/* Find the minimum available bandwidth over all links */
+=09tb_for_each_port_on_path(src_port, dst_port, port) {
+=09=09int max_up, max_down, consumed_up, consumed_down;
=20
-=09=09=09ret =3D tb_tunnel_consumed_bandwidth(tunnel,
-=09=09=09=09=09=09=09   &dp_consumed_up,
-=09=09=09=09=09=09=09   &dp_consumed_down);
-=09=09=09if (ret)
-=09=09=09=09return ret;
+=09=09if (!tb_port_is_null(port))
+=09=09=09continue;
=20
-=09=09=09up_bw -=3D dp_consumed_up;
-=09=09=09down_bw -=3D dp_consumed_down;
-=09=09}
+=09=09ret =3D tb_maximum_bandwidth(tb, src_port, dst_port, port,
+=09=09=09=09=09   &max_up, &max_down, include_asym);
+=09=09if (ret)
+=09=09=09return ret;
=20
-=09=09/*
-=09=09 * If USB3 is tunneled from the host router down to the
-=09=09 * branch leading to port we need to take USB3 consumed
-=09=09 * bandwidth into account regardless whether it actually
-=09=09 * crosses the port.
-=09=09 */
-=09=09up_bw -=3D usb3_consumed_up;
-=09=09down_bw -=3D usb3_consumed_down;
+=09=09ret =3D tb_consumed_usb3_pcie_bandwidth(tb, src_port, dst_port,
+=09=09=09=09=09=09      port, &consumed_up,
+=09=09=09=09=09=09      &consumed_down);
+=09=09if (ret)
+=09=09=09return ret;
+=09=09max_up -=3D consumed_up;
+=09=09max_down -=3D consumed_down;
=20
-=09=09/*
-=09=09 * If there is anything reserved for PCIe bulk traffic
-=09=09 * take it into account here too.
-=09=09 */
-=09=09if (tb_tunnel_reserved_pci(port, &pci_reserved_up,
-=09=09=09=09=09   &pci_reserved_down)) {
-=09=09=09up_bw -=3D pci_reserved_up;
-=09=09=09down_bw -=3D pci_reserved_down;
-=09=09}
+=09=09ret =3D tb_consumed_dp_bandwidth(tb, src_port, dst_port, port,
+=09=09=09=09=09       &consumed_up, &consumed_down);
+=09=09if (ret)
+=09=09=09return ret;
+=09=09max_up -=3D consumed_up;
+=09=09max_down -=3D consumed_down;
=20
-=09=09if (up_bw < *available_up)
-=09=09=09*available_up =3D up_bw;
-=09=09if (down_bw < *available_down)
-=09=09=09*available_down =3D down_bw;
+=09=09if (max_up < *available_up)
+=09=09=09*available_up =3D max_up;
+=09=09if (max_down < *available_down)
+=09=09=09*available_down =3D max_down;
 =09}
=20
 =09if (*available_up < 0)
@@ -747,7 +938,7 @@ static void tb_reclaim_usb3_bandwidth(struct tb *tb, st=
ruct tb_port *src_port,
 =09 * That determines the whole USB3 bandwidth for this branch.
 =09 */
 =09ret =3D tb_available_bandwidth(tb, tunnel->src_port, tunnel->dst_port,
-=09=09=09=09     &available_up, &available_down);
+=09=09=09=09     &available_up, &available_down, false);
 =09if (ret) {
 =09=09tb_warn(tb, "failed to calculate available bandwidth\n");
 =09=09return;
@@ -805,8 +996,8 @@ static int tb_tunnel_usb3(struct tb *tb, struct tb_swit=
ch *sw)
 =09=09=09return ret;
 =09}
=20
-=09ret =3D tb_available_bandwidth(tb, down, up, &available_up,
-=09=09=09=09     &available_down);
+=09ret =3D tb_available_bandwidth(tb, down, up, &available_up, &available_=
down,
+=09=09=09=09     false);
 =09if (ret)
 =09=09goto err_reclaim;
=20
@@ -867,6 +1058,225 @@ static int tb_create_usb3_tunnels(struct tb_switch *=
sw)
 =09return 0;
 }
=20
+/**
+ * tb_configure_asym() - Transition links to asymmetric if needed
+ * @tb: Domain structure
+ * @src_port: Source adapter to start the transition
+ * @dst_port: Destination adapter
+ * @requested_up: Additional bandwidth (Mb/s) required upstream
+ * @requested_down: Additional bandwidth (Mb/s) required downstream
+ *
+ * Transition links between @src_port and @dst_port into asymmetric, with
+ * three lanes in the direction from @src_port towards @dst_port and one l=
ane
+ * in the opposite direction, if the bandwidth requirements
+ * (requested + currently consumed) on that link exceed @asym_threshold.
+ *
+ * Must be called with available >=3D requested over all links.
+ */
+static int tb_configure_asym(struct tb *tb, struct tb_port *src_port,
+=09=09=09     struct tb_port *dst_port, int requested_up,
+=09=09=09     int requested_down)
+{
+=09struct tb_switch *sw;
+=09bool clx, downstream;
+=09struct tb_port *up;
+=09int ret =3D 0;
+
+=09if (!asym_threshold)
+=09=09return 0;
+
+=09/* Disable CL states before doing any transitions */
+=09downstream =3D tb_port_path_direction_downstream(src_port, dst_port);
+=09/* Pick up router deepest in the hierarchy */
+=09if (downstream)
+=09=09sw =3D dst_port->sw;
+=09else
+=09=09sw =3D src_port->sw;
+
+=09clx =3D tb_disable_clx(sw);
+
+=09tb_for_each_upstream_port_on_path(src_port, dst_port, up) {
+=09=09int consumed_up, consumed_down;
+=09=09enum tb_link_width width;
+
+=09=09ret =3D tb_consumed_dp_bandwidth(tb, src_port, dst_port, up,
+=09=09=09=09=09       &consumed_up, &consumed_down);
+=09=09if (ret)
+=09=09=09break;
+
+=09=09if (downstream) {
+=09=09=09/*
+=09=09=09 * Downstream so make sure upstream is within the 36G
+=09=09=09 * (40G - guard band 10%), and the requested is above
+=09=09=09 * what the threshold is.
+=09=09=09 */
+=09=09=09if (consumed_up + requested_up >=3D TB_ASYM_MIN) {
+=09=09=09=09ret =3D -ENOBUFS;
+=09=09=09=09break;
+=09=09=09}
+=09=09=09/* Does consumed + requested exceed the threshold */
+=09=09=09if (consumed_down + requested_down < asym_threshold)
+=09=09=09=09continue;
+
+=09=09=09width =3D TB_LINK_WIDTH_ASYM_RX;
+=09=09} else {
+=09=09=09/* Upstream, the opposite of above */
+=09=09=09if (consumed_down + requested_down >=3D TB_ASYM_MIN) {
+=09=09=09=09ret =3D -ENOBUFS;
+=09=09=09=09break;
+=09=09=09}
+=09=09=09if (consumed_up + requested_up < asym_threshold)
+=09=09=09=09continue;
+
+=09=09=09width =3D TB_LINK_WIDTH_ASYM_TX;
+=09=09}
+
+=09=09if (up->sw->link_width =3D=3D width)
+=09=09=09continue;
+
+=09=09if (!tb_port_width_supported(up, width))
+=09=09=09continue;
+
+=09=09tb_sw_dbg(up->sw, "configuring asymmetric link\n");
+
+=09=09/*
+=09=09 * Here requested + consumed > threshold so we need to
+=09=09 * transtion the link into asymmetric now.
+=09=09 */
+=09=09ret =3D tb_switch_set_link_width(up->sw, width);
+=09=09if (ret) {
+=09=09=09tb_sw_warn(up->sw, "failed to set link width\n");
+=09=09=09break;
+=09=09}
+=09}
+
+=09/* Re-enable CL states if they were previosly enabled */
+=09if (clx)
+=09=09tb_enable_clx(sw);
+
+=09return ret;
+}
+
+/**
+ * tb_configure_sym() - Transition links to symmetric if possible
+ * @tb: Domain structure
+ * @src_port: Source adapter to start the transition
+ * @dst_port: Destination adapter
+ * @requested_up: New lower bandwidth request upstream (Mb/s)
+ * @requested_down: New lower bandwidth request downstream (Mb/s)
+ *
+ * Goes over each link from @src_port to @dst_port and tries to
+ * transition the link to symmetric if the currently consumed bandwidth
+ * allows.
+ */
+static int tb_configure_sym(struct tb *tb, struct tb_port *src_port,
+=09=09=09    struct tb_port *dst_port, int requested_up,
+=09=09=09    int requested_down)
+{
+=09struct tb_switch *sw;
+=09bool clx, downstream;
+=09struct tb_port *up;
+=09int ret =3D 0;
+
+=09if (!asym_threshold)
+=09=09return 0;
+
+=09/* Disable CL states before doing any transitions */
+=09downstream =3D tb_port_path_direction_downstream(src_port, dst_port);
+=09/* Pick up router deepest in the hierarchy */
+=09if (downstream)
+=09=09sw =3D dst_port->sw;
+=09else
+=09=09sw =3D src_port->sw;
+
+=09clx =3D tb_disable_clx(sw);
+
+=09tb_for_each_upstream_port_on_path(src_port, dst_port, up) {
+=09=09int consumed_up, consumed_down;
+
+=09=09/* Already symmetric */
+=09=09if (up->sw->link_width <=3D TB_LINK_WIDTH_DUAL)
+=09=09=09continue;
+=09=09/* Unplugged, no need to switch */
+=09=09if (up->sw->is_unplugged)
+=09=09=09continue;
+
+=09=09ret =3D tb_consumed_dp_bandwidth(tb, src_port, dst_port, up,
+=09=09=09=09=09       &consumed_up, &consumed_down);
+=09=09if (ret)
+=09=09=09break;
+
+=09=09if (downstream) {
+=09=09=09/*
+=09=09=09 * Downstream so we want the consumed_down < threshold.
+=09=09=09 * Upstream traffic should be less than 36G (40G
+=09=09=09 * guard band 10%) as the link was configured asymmetric
+=09=09=09 * already.
+=09=09=09 */
+=09=09=09if (consumed_down + requested_down >=3D asym_threshold)
+=09=09=09=09continue;
+=09=09} else {
+=09=09=09if (consumed_up + requested_up >=3D asym_threshold)
+=09=09=09=09continue;
+=09=09}
+
+=09=09if (up->sw->link_width =3D=3D TB_LINK_WIDTH_DUAL)
+=09=09=09continue;
+
+=09=09tb_sw_dbg(up->sw, "configuring symmetric link\n");
+
+=09=09ret =3D tb_switch_set_link_width(up->sw, TB_LINK_WIDTH_DUAL);
+=09=09if (ret) {
+=09=09=09tb_sw_warn(up->sw, "failed to set link width\n");
+=09=09=09break;
+=09=09}
+=09}
+
+=09/* Re-enable CL states if they were previosly enabled */
+=09if (clx)
+=09=09tb_enable_clx(sw);
+
+=09return ret;
+}
+
+static void tb_configure_link(struct tb_port *down, struct tb_port *up,
+=09=09=09      struct tb_switch *sw)
+{
+=09struct tb *tb =3D sw->tb;
+
+=09/* Link the routers using both links if available */
+=09down->remote =3D up;
+=09up->remote =3D down;
+=09if (down->dual_link_port && up->dual_link_port) {
+=09=09down->dual_link_port->remote =3D up->dual_link_port;
+=09=09up->dual_link_port->remote =3D down->dual_link_port;
+=09}
+
+=09/*
+=09 * Enable lane bonding if the link is currently two single lane
+=09 * links.
+=09 */
+=09if (sw->link_width < TB_LINK_WIDTH_DUAL)
+=09=09tb_switch_set_link_width(sw, TB_LINK_WIDTH_DUAL);
+
+=09/*
+=09 * Device router that comes up as symmetric link is
+=09 * connected deeper in the hierarchy, we transition the links
+=09 * above into symmetric if bandwidth allows.
+=09 */
+=09if (tb_switch_depth(sw) > 1 &&
+=09    tb_port_get_link_generation(up) >=3D 4 &&
+=09    up->sw->link_width =3D=3D TB_LINK_WIDTH_DUAL) {
+=09=09struct tb_port *host_port;
+
+=09=09host_port =3D tb_port_at(tb_route(sw), tb->root_switch);
+=09=09tb_configure_sym(tb, host_port, up, 0, 0);
+=09}
+
+=09/* Set the link configured */
+=09tb_switch_configure_link(sw);
+}
+
 static void tb_scan_port(struct tb_port *port);
=20
 /*
@@ -975,19 +1385,9 @@ static void tb_scan_port(struct tb_port *port)
 =09=09goto out_rpm_put;
 =09}
=20
-=09/* Link the switches using both links if available */
 =09upstream_port =3D tb_upstream_port(sw);
-=09port->remote =3D upstream_port;
-=09upstream_port->remote =3D port;
-=09if (port->dual_link_port && upstream_port->dual_link_port) {
-=09=09port->dual_link_port->remote =3D upstream_port->dual_link_port;
-=09=09upstream_port->dual_link_port->remote =3D port->dual_link_port;
-=09}
+=09tb_configure_link(port, upstream_port, sw);
=20
-=09/* Enable lane bonding if supported */
-=09tb_switch_set_link_width(sw, TB_LINK_WIDTH_DUAL);
-=09/* Set the link configured */
-=09tb_switch_configure_link(sw);
 =09/*
 =09 * CL0s and CL1 are enabled and supported together.
 =09 * Silently ignore CLx enabling in case CLx is not supported.
@@ -1051,6 +1451,11 @@ static void tb_deactivate_and_free_tunnel(struct tb_=
tunnel *tunnel)
 =09=09 * deallocated properly.
 =09=09 */
 =09=09tb_switch_dealloc_dp_resource(src_port->sw, src_port);
+=09=09/*
+=09=09 * If bandwidth on a link is < asym_threshold
+=09=09 * transition the link to symmetric.
+=09=09 */
+=09=09tb_configure_sym(tb, src_port, dst_port, 0, 0);
 =09=09/* Now we can allow the domain to runtime suspend again */
 =09=09pm_runtime_mark_last_busy(&dst_port->sw->dev);
 =09=09pm_runtime_put_autosuspend(&dst_port->sw->dev);
@@ -1208,7 +1613,7 @@ tb_recalc_estimated_bandwidth_for_group(struct tb_ban=
dwidth_group *group)
=20
 =09=09out =3D tunnel->dst_port;
 =09=09ret =3D tb_available_bandwidth(tb, in, out, &estimated_up,
-=09=09=09=09=09     &estimated_down);
+=09=09=09=09=09     &estimated_down, true);
 =09=09if (ret) {
 =09=09=09tb_port_warn(in,
 =09=09=09=09"failed to re-calculate estimated bandwidth\n");
@@ -1299,6 +1704,7 @@ static bool tb_tunnel_one_dp(struct tb *tb)
 =09int available_up, available_down, ret, link_nr;
 =09struct tb_cm *tcm =3D tb_priv(tb);
 =09struct tb_port *port, *in, *out;
+=09int consumed_up, consumed_down;
 =09struct tb_tunnel *tunnel;
=20
 =09/*
@@ -1375,7 +1781,8 @@ static bool tb_tunnel_one_dp(struct tb *tb)
 =09=09goto err_detach_group;
 =09}
=20
-=09ret =3D tb_available_bandwidth(tb, in, out, &available_up, &available_d=
own);
+=09ret =3D tb_available_bandwidth(tb, in, out, &available_up, &available_d=
own,
+=09=09=09=09     true);
 =09if (ret)
 =09=09goto err_reclaim_usb;
=20
@@ -1397,6 +1804,13 @@ static bool tb_tunnel_one_dp(struct tb *tb)
 =09list_add_tail(&tunnel->list, &tcm->tunnel_list);
 =09tb_reclaim_usb3_bandwidth(tb, in, out);
=20
+=09/*
+=09 * Transition the links to asymmetric if the consumption exceeds
+=09 * the threshold.
+=09 */
+=09if (!tb_tunnel_consumed_bandwidth(tunnel, &consumed_up, &consumed_down)=
)
+=09=09tb_configure_asym(tb, in, out, consumed_up, consumed_down);
+
 =09/* Update the domain with the new bandwidth estimation */
 =09tb_recalc_estimated_bandwidth(tb);
=20
@@ -1903,6 +2317,11 @@ static int tb_alloc_dp_bandwidth(struct tb_tunnel *t=
unnel, int *requested_up,
=20
 =09if ((*requested_up >=3D 0 && requested_up_corrected <=3D allocated_up) =
||
 =09    (*requested_down >=3D 0 && requested_down_corrected <=3D allocated_=
down)) {
+=09=09/*
+=09=09 * If bandwidth on a link is < asym_threshold transition
+=09=09 * the link to symmetric.
+=09=09 */
+=09=09tb_configure_sym(tb, in, out, *requested_up, *requested_down);
 =09=09/*
 =09=09 * If requested bandwidth is less or equal than what is
 =09=09 * currently allocated to that tunnel we simply change
@@ -1928,7 +2347,8 @@ static int tb_alloc_dp_bandwidth(struct tb_tunnel *tu=
nnel, int *requested_up,
 =09 * are also in the same group but we use the same function here
 =09 * that we use with the normal bandwidth allocation).
 =09 */
-=09ret =3D tb_available_bandwidth(tb, in, out, &available_up, &available_d=
own);
+=09ret =3D tb_available_bandwidth(tb, in, out, &available_up, &available_d=
own,
+=09=09=09=09     true);
 =09if (ret)
 =09=09goto reclaim;
=20
@@ -1937,8 +2357,23 @@ static int tb_alloc_dp_bandwidth(struct tb_tunnel *t=
unnel, int *requested_up,
=20
 =09if ((*requested_up >=3D 0 && available_up >=3D requested_up_corrected) =
||
 =09    (*requested_down >=3D 0 && available_down >=3D requested_down_corre=
cted)) {
+=09=09/*
+=09=09 * If bandwidth on a link is >=3D asym_threshold
+=09=09 * transition the link to asymmetric.
+=09=09 */
+=09=09ret =3D tb_configure_asym(tb, in, out, *requested_up,
+=09=09=09=09=09*requested_down);
+=09=09if (ret) {
+=09=09=09tb_configure_sym(tb, in, out, 0, 0);
+=09=09=09return ret;
+=09=09}
+
 =09=09ret =3D tb_tunnel_alloc_bandwidth(tunnel, requested_up,
 =09=09=09=09=09=09requested_down);
+=09=09if (ret) {
+=09=09=09tb_tunnel_warn(tunnel, "failed to allocate bandwidth\n");
+=09=09=09tb_configure_sym(tb, in, out, 0, 0);
+=09=09}
 =09} else {
 =09=09ret =3D -ENOBUFS;
 =09}
--=20
2.45.1


