Return-Path: <stable+bounces-78576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C986D98C49C
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:35:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527E81F249E9
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BCD1CDFD5;
	Tue,  1 Oct 2024 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="ZpD5hmcs"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A041CEE8F
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803944; cv=none; b=Rntz4WWRh8LozTCGjiezMqxKJaZnO6bBRsI10rS2r4t7vYOGrr5qKhX9eR0tpyA0a0P7sp6PZgQgkMcjXDvIVj8L5YxwlbNQI0+QvWJ5IIJIcFaTepWZrQtvppdu2GCd9ZZnpmGDKbaOQ03lyTi000frQ56/6MFw+6ZN2KKfPbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803944; c=relaxed/simple;
	bh=o2lbj287EJsRj7sQHip58MRo9G/2DFfFjfeXt6sr9+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDr3kqqQ9YGXwIRweCs4tZR4czmP3D0wrkxaqfSN7MnUufLWOBKMB6IXzpxJDziy1prccnThAor1exQ6O4whVBPD4hWXW+XvuRDJ/VshkHxXI2NL6IApJN44591O8ZHq0p1ZC10qXIK2O0pB3o+LsJxcO8zoenhgrd57/IvFEU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=ZpD5hmcs; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803941;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=we2/gdzQ7DJTwX/x8DaC/A7w8CojI9uOFEjYiTZJppk=;
	b=ZpD5hmcspifh7SDTnw3Ab/rhmrTulbyzDGYhJZA81IO6sm9psuSeeu3Px54K7IR29WcP5a
	GOmNTA0msCP4x4j493nBMQKli/jQBUAnBiggJvPh7o2C9HdGJijYy5smig0XMmVOY/V5cv
	JcdBqJRS4LHDx0o08Bcz8nIk65jsOmc=
Received: from g7t16454g.inc.hp.com (hpifallback.mail.core.hp.com
 [15.73.128.143]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-YhyUp16wMMamEyq0VKFiVg-1; Tue, 01 Oct 2024 13:32:20 -0400
X-MC-Unique: YhyUp16wMMamEyq0VKFiVg-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g7t16454g.inc.hp.com (Postfix) with ESMTPS id 12C476000C06;
	Tue,  1 Oct 2024 17:32:19 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 70A3118;
	Tue,  1 Oct 2024 17:32:17 +0000 (UTC)
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
Subject: [PATCH 6.6 12/14] thunderbolt: Add support for asymmetric link
Date: Tue,  1 Oct 2024 17:31:07 +0000
Message-Id: <20241001173109.1513-13-alexandru.gagniuc@hp.com>
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

[ Upstream commit 81af2952e60603d12415e1a6fd200f8073a2ad8b ]

USB4 v2 spec defines a Gen 4 link that can operate as an aggregated
symmetric (80/80G) or asymmetric (120/40G). When the link is asymmetric,
the USB4 port on one side of the link operates with three TX lanes and
one RX lane, while the USB4 port on the opposite side of the link
operates with three RX lanes and one TX lane.

Add support for the asymmetric link and provide functions that can be
used to transition the link to asymmetric and back.

Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Co-developed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/thunderbolt/switch.c  | 294 +++++++++++++++++++++++++++++-----
 drivers/thunderbolt/tb.c      |  11 +-
 drivers/thunderbolt/tb.h      |  16 +-
 drivers/thunderbolt/tb_regs.h |   9 +-
 drivers/thunderbolt/usb4.c    | 106 ++++++++++++
 5 files changed, 381 insertions(+), 55 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index c7f16fd0a043..6393ce44c253 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -947,6 +947,22 @@ int tb_port_get_link_generation(struct tb_port *port)
 =09}
 }
=20
+static const char *width_name(enum tb_link_width width)
+{
+=09switch (width) {
+=09case TB_LINK_WIDTH_SINGLE:
+=09=09return "symmetric, single lane";
+=09case TB_LINK_WIDTH_DUAL:
+=09=09return "symmetric, dual lanes";
+=09case TB_LINK_WIDTH_ASYM_TX:
+=09=09return "asymmetric, 3 transmitters, 1 receiver";
+=09case TB_LINK_WIDTH_ASYM_RX:
+=09=09return "asymmetric, 3 receivers, 1 transmitter";
+=09default:
+=09=09return "unknown";
+=09}
+}
+
 /**
  * tb_port_get_link_width() - Get current link width
  * @port: Port to check (USB4 or CIO)
@@ -972,8 +988,15 @@ int tb_port_get_link_width(struct tb_port *port)
 =09=09LANE_ADP_CS_1_CURRENT_WIDTH_SHIFT;
 }
=20
-static bool tb_port_is_width_supported(struct tb_port *port,
-=09=09=09=09       unsigned int width_mask)
+/**
+ * tb_port_width_supported() - Is the given link width supported
+ * @port: Port to check
+ * @width: Widths to check (bitmask)
+ *
+ * Can be called to any lane adapter. Checks if given @width is
+ * supported by the hardware and returns %true if it is.
+ */
+bool tb_port_width_supported(struct tb_port *port, unsigned int width)
 {
 =09u32 phy, widths;
 =09int ret;
@@ -981,15 +1004,23 @@ static bool tb_port_is_width_supported(struct tb_por=
t *port,
 =09if (!port->cap_phy)
 =09=09return false;
=20
+=09if (width & (TB_LINK_WIDTH_ASYM_TX | TB_LINK_WIDTH_ASYM_RX)) {
+=09=09if (tb_port_get_link_generation(port) < 4 ||
+=09=09    !usb4_port_asym_supported(port))
+=09=09=09return false;
+=09}
+
 =09ret =3D tb_port_read(port, &phy, TB_CFG_PORT,
 =09=09=09   port->cap_phy + LANE_ADP_CS_0, 1);
 =09if (ret)
 =09=09return false;
=20
-=09widths =3D (phy & LANE_ADP_CS_0_SUPPORTED_WIDTH_MASK) >>
-=09=09LANE_ADP_CS_0_SUPPORTED_WIDTH_SHIFT;
-
-=09return widths & width_mask;
+=09/*
+=09 * The field encoding is the same as &enum tb_link_width (which is
+=09 * passed to @width).
+=09 */
+=09widths =3D FIELD_GET(LANE_ADP_CS_0_SUPPORTED_WIDTH_MASK, phy);
+=09return widths & width;
 }
=20
 /**
@@ -1024,10 +1055,18 @@ int tb_port_set_link_width(struct tb_port *port, en=
um tb_link_width width)
 =09=09val |=3D LANE_ADP_CS_1_TARGET_WIDTH_SINGLE <<
 =09=09=09LANE_ADP_CS_1_TARGET_WIDTH_SHIFT;
 =09=09break;
+
 =09case TB_LINK_WIDTH_DUAL:
+=09=09if (tb_port_get_link_generation(port) >=3D 4)
+=09=09=09return usb4_port_asym_set_link_width(port, width);
 =09=09val |=3D LANE_ADP_CS_1_TARGET_WIDTH_DUAL <<
 =09=09=09LANE_ADP_CS_1_TARGET_WIDTH_SHIFT;
 =09=09break;
+
+=09case TB_LINK_WIDTH_ASYM_TX:
+=09case TB_LINK_WIDTH_ASYM_RX:
+=09=09return usb4_port_asym_set_link_width(port, width);
+
 =09default:
 =09=09return -EINVAL;
 =09}
@@ -1152,7 +1191,7 @@ void tb_port_lane_bonding_disable(struct tb_port *por=
t)
 /**
  * tb_port_wait_for_link_width() - Wait until link reaches specific width
  * @port: Port to wait for
- * @width_mask: Expected link width mask
+ * @width: Expected link width (bitmask)
  * @timeout_msec: Timeout in ms how long to wait
  *
  * Should be used after both ends of the link have been bonded (or
@@ -1161,14 +1200,14 @@ void tb_port_lane_bonding_disable(struct tb_port *p=
ort)
  * within the given timeout, %0 if it did. Can be passed a mask of
  * expected widths and succeeds if any of the widths is reached.
  */
-int tb_port_wait_for_link_width(struct tb_port *port, unsigned int width_m=
ask,
+int tb_port_wait_for_link_width(struct tb_port *port, unsigned int width,
 =09=09=09=09int timeout_msec)
 {
 =09ktime_t timeout =3D ktime_add_ms(ktime_get(), timeout_msec);
 =09int ret;
=20
 =09/* Gen 4 link does not support single lane */
-=09if ((width_mask & TB_LINK_WIDTH_SINGLE) &&
+=09if ((width & TB_LINK_WIDTH_SINGLE) &&
 =09    tb_port_get_link_generation(port) >=3D 4)
 =09=09return -EOPNOTSUPP;
=20
@@ -1182,7 +1221,7 @@ int tb_port_wait_for_link_width(struct tb_port *port,=
 unsigned int width_mask,
 =09=09=09 */
 =09=09=09if (ret !=3D -EACCES)
 =09=09=09=09return ret;
-=09=09} else if (ret & width_mask) {
+=09=09} else if (ret & width) {
 =09=09=09return 0;
 =09=09}
=20
@@ -2821,6 +2860,38 @@ static int tb_switch_update_link_attributes(struct t=
b_switch *sw)
 =09return 0;
 }
=20
+/* Must be called after tb_switch_update_link_attributes() */
+static void tb_switch_link_init(struct tb_switch *sw)
+{
+=09struct tb_port *up, *down;
+=09bool bonded;
+
+=09if (!tb_route(sw) || tb_switch_is_icm(sw))
+=09=09return;
+
+=09tb_sw_dbg(sw, "current link speed %u.0 Gb/s\n", sw->link_speed);
+=09tb_sw_dbg(sw, "current link width %s\n", width_name(sw->link_width));
+
+=09bonded =3D sw->link_width >=3D TB_LINK_WIDTH_DUAL;
+
+=09/*
+=09 * Gen 4 links come up as bonded so update the port structures
+=09 * accordingly.
+=09 */
+=09up =3D tb_upstream_port(sw);
+=09down =3D tb_switch_downstream_port(sw);
+
+=09up->bonded =3D bonded;
+=09if (up->dual_link_port)
+=09=09up->dual_link_port->bonded =3D bonded;
+=09tb_port_update_credits(up);
+
+=09down->bonded =3D bonded;
+=09if (down->dual_link_port)
+=09=09down->dual_link_port->bonded =3D bonded;
+=09tb_port_update_credits(down);
+}
+
 /**
  * tb_switch_lane_bonding_enable() - Enable lane bonding
  * @sw: Switch to enable lane bonding
@@ -2829,24 +2900,20 @@ static int tb_switch_update_link_attributes(struct =
tb_switch *sw)
  * switch. If conditions are correct and both switches support the feature=
,
  * lanes are bonded. It is safe to call this to any switch.
  */
-int tb_switch_lane_bonding_enable(struct tb_switch *sw)
+static int tb_switch_lane_bonding_enable(struct tb_switch *sw)
 {
 =09struct tb_port *up, *down;
-=09u64 route =3D tb_route(sw);
-=09unsigned int width_mask;
+=09unsigned int width;
 =09int ret;
=20
-=09if (!route)
-=09=09return 0;
-
 =09if (!tb_switch_lane_bonding_possible(sw))
 =09=09return 0;
=20
 =09up =3D tb_upstream_port(sw);
 =09down =3D tb_switch_downstream_port(sw);
=20
-=09if (!tb_port_is_width_supported(up, TB_LINK_WIDTH_DUAL) ||
-=09    !tb_port_is_width_supported(down, TB_LINK_WIDTH_DUAL))
+=09if (!tb_port_width_supported(up, TB_LINK_WIDTH_DUAL) ||
+=09    !tb_port_width_supported(down, TB_LINK_WIDTH_DUAL))
 =09=09return 0;
=20
 =09/*
@@ -2870,21 +2937,10 @@ int tb_switch_lane_bonding_enable(struct tb_switch =
*sw)
 =09}
=20
 =09/* Any of the widths are all bonded */
-=09width_mask =3D TB_LINK_WIDTH_DUAL | TB_LINK_WIDTH_ASYM_TX |
-=09=09     TB_LINK_WIDTH_ASYM_RX;
+=09width =3D TB_LINK_WIDTH_DUAL | TB_LINK_WIDTH_ASYM_TX |
+=09=09TB_LINK_WIDTH_ASYM_RX;
=20
-=09ret =3D tb_port_wait_for_link_width(down, width_mask, 100);
-=09if (ret) {
-=09=09tb_port_warn(down, "timeout enabling lane bonding\n");
-=09=09return ret;
-=09}
-
-=09tb_port_update_credits(down);
-=09tb_port_update_credits(up);
-=09tb_switch_update_link_attributes(sw);
-
-=09tb_sw_dbg(sw, "lane bonding enabled\n");
-=09return ret;
+=09return tb_port_wait_for_link_width(down, width, 100);
 }
=20
 /**
@@ -2894,20 +2950,27 @@ int tb_switch_lane_bonding_enable(struct tb_switch =
*sw)
  * Disables lane bonding between @sw and parent. This can be called even
  * if lanes were not bonded originally.
  */
-void tb_switch_lane_bonding_disable(struct tb_switch *sw)
+static int tb_switch_lane_bonding_disable(struct tb_switch *sw)
 {
 =09struct tb_port *up, *down;
 =09int ret;
=20
-=09if (!tb_route(sw))
-=09=09return;
-
 =09up =3D tb_upstream_port(sw);
 =09if (!up->bonded)
-=09=09return;
+=09=09return 0;
=20
-=09down =3D tb_switch_downstream_port(sw);
+=09/*
+=09 * If the link is Gen 4 there is no way to switch the link to
+=09 * two single lane links so avoid that here. Also don't bother
+=09 * if the link is not up anymore (sw is unplugged).
+=09 */
+=09ret =3D tb_port_get_link_generation(up);
+=09if (ret < 0)
+=09=09return ret;
+=09if (ret >=3D 4)
+=09=09return -EOPNOTSUPP;
=20
+=09down =3D tb_switch_downstream_port(sw);
 =09tb_port_lane_bonding_disable(up);
 =09tb_port_lane_bonding_disable(down);
=20
@@ -2915,15 +2978,160 @@ void tb_switch_lane_bonding_disable(struct tb_swit=
ch *sw)
 =09 * It is fine if we get other errors as the router might have
 =09 * been unplugged.
 =09 */
-=09ret =3D tb_port_wait_for_link_width(down, TB_LINK_WIDTH_SINGLE, 100);
-=09if (ret =3D=3D -ETIMEDOUT)
-=09=09tb_sw_warn(sw, "timeout disabling lane bonding\n");
+=09return tb_port_wait_for_link_width(down, TB_LINK_WIDTH_SINGLE, 100);
+}
+
+static int tb_switch_asym_enable(struct tb_switch *sw, enum tb_link_width =
width)
+{
+=09struct tb_port *up, *down, *port;
+=09enum tb_link_width down_width;
+=09int ret;
+
+=09up =3D tb_upstream_port(sw);
+=09down =3D tb_switch_downstream_port(sw);
+
+=09if (width =3D=3D TB_LINK_WIDTH_ASYM_TX) {
+=09=09down_width =3D TB_LINK_WIDTH_ASYM_RX;
+=09=09port =3D down;
+=09} else {
+=09=09down_width =3D TB_LINK_WIDTH_ASYM_TX;
+=09=09port =3D up;
+=09}
+
+=09ret =3D tb_port_set_link_width(up, width);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D tb_port_set_link_width(down, down_width);
+=09if (ret)
+=09=09return ret;
+
+=09/*
+=09 * Initiate the change in the router that one of its TX lanes is
+=09 * changing to RX but do so only if there is an actual change.
+=09 */
+=09if (sw->link_width !=3D width) {
+=09=09ret =3D usb4_port_asym_start(port);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09ret =3D tb_port_wait_for_link_width(up, width, 100);
+=09=09if (ret)
+=09=09=09return ret;
+=09}
+
+=09sw->link_width =3D width;
+=09return 0;
+}
+
+static int tb_switch_asym_disable(struct tb_switch *sw)
+{
+=09struct tb_port *up, *down;
+=09int ret;
+
+=09up =3D tb_upstream_port(sw);
+=09down =3D tb_switch_downstream_port(sw);
+
+=09ret =3D tb_port_set_link_width(up, TB_LINK_WIDTH_DUAL);
+=09if (ret)
+=09=09return ret;
+
+=09ret =3D tb_port_set_link_width(down, TB_LINK_WIDTH_DUAL);
+=09if (ret)
+=09=09return ret;
+
+=09/*
+=09 * Initiate the change in the router that has three TX lanes and
+=09 * is changing one of its TX lanes to RX but only if there is a
+=09 * change in the link width.
+=09 */
+=09if (sw->link_width > TB_LINK_WIDTH_DUAL) {
+=09=09if (sw->link_width =3D=3D TB_LINK_WIDTH_ASYM_TX)
+=09=09=09ret =3D usb4_port_asym_start(up);
+=09=09else
+=09=09=09ret =3D usb4_port_asym_start(down);
+=09=09if (ret)
+=09=09=09return ret;
+
+=09=09ret =3D tb_port_wait_for_link_width(up, TB_LINK_WIDTH_DUAL, 100);
+=09=09if (ret)
+=09=09=09return ret;
+=09}
+
+=09sw->link_width =3D TB_LINK_WIDTH_DUAL;
+=09return 0;
+}
+
+/**
+ * tb_switch_set_link_width() - Configure router link width
+ * @sw: Router to configure
+ * @width: The new link width
+ *
+ * Set device router link width to @width from router upstream port
+ * perspective. Supports also asymmetric links if the routers boths side
+ * of the link supports it.
+ *
+ * Does nothing for host router.
+ *
+ * Returns %0 in case of success, negative errno otherwise.
+ */
+int tb_switch_set_link_width(struct tb_switch *sw, enum tb_link_width widt=
h)
+{
+=09struct tb_port *up, *down;
+=09int ret =3D 0;
+
+=09if (!tb_route(sw))
+=09=09return 0;
+
+=09up =3D tb_upstream_port(sw);
+=09down =3D tb_switch_downstream_port(sw);
+
+=09switch (width) {
+=09case TB_LINK_WIDTH_SINGLE:
+=09=09ret =3D tb_switch_lane_bonding_disable(sw);
+=09=09break;
+
+=09case TB_LINK_WIDTH_DUAL:
+=09=09if (sw->link_width =3D=3D TB_LINK_WIDTH_ASYM_TX ||
+=09=09    sw->link_width =3D=3D TB_LINK_WIDTH_ASYM_RX) {
+=09=09=09ret =3D tb_switch_asym_disable(sw);
+=09=09=09if (ret)
+=09=09=09=09break;
+=09=09}
+=09=09ret =3D tb_switch_lane_bonding_enable(sw);
+=09=09break;
+
+=09case TB_LINK_WIDTH_ASYM_TX:
+=09case TB_LINK_WIDTH_ASYM_RX:
+=09=09ret =3D tb_switch_asym_enable(sw, width);
+=09=09break;
+=09}
+
+=09switch (ret) {
+=09case 0:
+=09=09break;
+
+=09case -ETIMEDOUT:
+=09=09tb_sw_warn(sw, "timeout changing link width\n");
+=09=09return ret;
+
+=09case -ENOTCONN:
+=09case -EOPNOTSUPP:
+=09case -ENODEV:
+=09=09return ret;
+
+=09default:
+=09=09tb_sw_dbg(sw, "failed to change link width: %d\n", ret);
+=09=09return ret;
+=09}
=20
 =09tb_port_update_credits(down);
 =09tb_port_update_credits(up);
+
 =09tb_switch_update_link_attributes(sw);
=20
-=09tb_sw_dbg(sw, "lane bonding disabled\n");
+=09tb_sw_dbg(sw, "link width set to %s\n", width_name(width));
+=09return ret;
 }
=20
 /**
@@ -3090,6 +3298,8 @@ int tb_switch_add(struct tb_switch *sw)
 =09=09if (ret)
 =09=09=09return ret;
=20
+=09=09tb_switch_link_init(sw);
+
 =09=09ret =3D tb_switch_clx_init(sw);
 =09=09if (ret)
 =09=09=09return ret;
diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 39ec8da576ef..550f1c9a1170 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -985,7 +985,7 @@ static void tb_scan_port(struct tb_port *port)
 =09}
=20
 =09/* Enable lane bonding if supported */
-=09tb_switch_lane_bonding_enable(sw);
+=09tb_switch_set_link_width(sw, TB_LINK_WIDTH_DUAL);
 =09/* Set the link configured */
 =09tb_switch_configure_link(sw);
 =09/*
@@ -1103,7 +1103,8 @@ static void tb_free_unplugged_children(struct tb_swit=
ch *sw)
 =09=09=09tb_retimer_remove_all(port);
 =09=09=09tb_remove_dp_resources(port->remote->sw);
 =09=09=09tb_switch_unconfigure_link(port->remote->sw);
-=09=09=09tb_switch_lane_bonding_disable(port->remote->sw);
+=09=09=09tb_switch_set_link_width(port->remote->sw,
+=09=09=09=09=09=09 TB_LINK_WIDTH_SINGLE);
 =09=09=09tb_switch_remove(port->remote->sw);
 =09=09=09port->remote =3D NULL;
 =09=09=09if (port->dual_link_port)
@@ -1766,7 +1767,8 @@ static void tb_handle_hotplug(struct work_struct *wor=
k)
 =09=09=09tb_remove_dp_resources(port->remote->sw);
 =09=09=09tb_switch_tmu_disable(port->remote->sw);
 =09=09=09tb_switch_unconfigure_link(port->remote->sw);
-=09=09=09tb_switch_lane_bonding_disable(port->remote->sw);
+=09=09=09tb_switch_set_link_width(port->remote->sw,
+=09=09=09=09=09=09 TB_LINK_WIDTH_SINGLE);
 =09=09=09tb_switch_remove(port->remote->sw);
 =09=09=09port->remote =3D NULL;
 =09=09=09if (port->dual_link_port)
@@ -2258,7 +2260,8 @@ static void tb_restore_children(struct tb_switch *sw)
 =09=09=09continue;
=20
 =09=09if (port->remote) {
-=09=09=09tb_switch_lane_bonding_enable(port->remote->sw);
+=09=09=09tb_switch_set_link_width(port->remote->sw,
+=09=09=09=09=09=09 port->remote->sw->link_width);
 =09=09=09tb_switch_configure_link(port->remote->sw);
=20
 =09=09=09tb_restore_children(port->remote->sw);
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index d2ef9575231c..920dac8a63e1 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -164,11 +164,6 @@ struct tb_switch_tmu {
  * switches) you need to have domain lock held.
  *
  * In USB4 terminology this structure represents a router.
- *
- * Note @link_width is not the same as whether link is bonded or not.
- * For Gen 4 links the link is also bonded when it is asymmetric. The
- * correct way to find out whether the link is bonded or not is to look
- * @bonded field of the upstream port.
  */
 struct tb_switch {
 =09struct device dev;
@@ -969,8 +964,7 @@ static inline bool tb_switch_is_icm(const struct tb_swi=
tch *sw)
 =09return !sw->config.enabled;
 }
=20
-int tb_switch_lane_bonding_enable(struct tb_switch *sw);
-void tb_switch_lane_bonding_disable(struct tb_switch *sw);
+int tb_switch_set_link_width(struct tb_switch *sw, enum tb_link_width widt=
h);
 int tb_switch_configure_link(struct tb_switch *sw);
 void tb_switch_unconfigure_link(struct tb_switch *sw);
=20
@@ -1103,10 +1097,11 @@ static inline bool tb_port_use_credit_allocation(co=
nst struct tb_port *port)
 int tb_port_get_link_speed(struct tb_port *port);
 int tb_port_get_link_generation(struct tb_port *port);
 int tb_port_get_link_width(struct tb_port *port);
+bool tb_port_width_supported(struct tb_port *port, unsigned int width);
 int tb_port_set_link_width(struct tb_port *port, enum tb_link_width width)=
;
 int tb_port_lane_bonding_enable(struct tb_port *port);
 void tb_port_lane_bonding_disable(struct tb_port *port);
-int tb_port_wait_for_link_width(struct tb_port *port, unsigned int width_m=
ask,
+int tb_port_wait_for_link_width(struct tb_port *port, unsigned int width,
 =09=09=09=09int timeout_msec);
 int tb_port_update_credits(struct tb_port *port);
=20
@@ -1304,6 +1299,11 @@ int usb4_port_router_online(struct tb_port *port);
 int usb4_port_enumerate_retimers(struct tb_port *port);
 bool usb4_port_clx_supported(struct tb_port *port);
 int usb4_port_margining_caps(struct tb_port *port, u32 *caps);
+
+bool usb4_port_asym_supported(struct tb_port *port);
+int usb4_port_asym_set_link_width(struct tb_port *port, enum tb_link_width=
 width);
+int usb4_port_asym_start(struct tb_port *port);
+
 int usb4_port_hw_margin(struct tb_port *port, unsigned int lanes,
 =09=09=09unsigned int ber_level, bool timing, bool right_high,
 =09=09=09u32 *results);
diff --git a/drivers/thunderbolt/tb_regs.h b/drivers/thunderbolt/tb_regs.h
index 736e28beac11..4419e274d2b4 100644
--- a/drivers/thunderbolt/tb_regs.h
+++ b/drivers/thunderbolt/tb_regs.h
@@ -348,10 +348,14 @@ struct tb_regs_port_header {
 #define LANE_ADP_CS_1=09=09=09=090x01
 #define LANE_ADP_CS_1_TARGET_SPEED_MASK=09=09GENMASK(3, 0)
 #define LANE_ADP_CS_1_TARGET_SPEED_GEN3=09=090xc
-#define LANE_ADP_CS_1_TARGET_WIDTH_MASK=09=09GENMASK(9, 4)
+#define LANE_ADP_CS_1_TARGET_WIDTH_MASK=09=09GENMASK(5, 4)
 #define LANE_ADP_CS_1_TARGET_WIDTH_SHIFT=094
 #define LANE_ADP_CS_1_TARGET_WIDTH_SINGLE=090x1
 #define LANE_ADP_CS_1_TARGET_WIDTH_DUAL=09=090x3
+#define LANE_ADP_CS_1_TARGET_WIDTH_ASYM_MASK=09GENMASK(7, 6)
+#define LANE_ADP_CS_1_TARGET_WIDTH_ASYM_TX=090x1
+#define LANE_ADP_CS_1_TARGET_WIDTH_ASYM_RX=090x2
+#define LANE_ADP_CS_1_TARGET_WIDTH_ASYM_DUAL=090x0
 #define LANE_ADP_CS_1_CL0S_ENABLE=09=09BIT(10)
 #define LANE_ADP_CS_1_CL1_ENABLE=09=09BIT(11)
 #define LANE_ADP_CS_1_CL2_ENABLE=09=09BIT(12)
@@ -384,6 +388,8 @@ struct tb_regs_port_header {
 #define PORT_CS_18_WOCS=09=09=09=09BIT(16)
 #define PORT_CS_18_WODS=09=09=09=09BIT(17)
 #define PORT_CS_18_WOU4S=09=09=09BIT(18)
+#define PORT_CS_18_CSA=09=09=09=09BIT(22)
+#define PORT_CS_18_TIP=09=09=09=09BIT(24)
 #define PORT_CS_19=09=09=09=090x13
 #define PORT_CS_19_DPR=09=09=09=09BIT(0)
 #define PORT_CS_19_PC=09=09=09=09BIT(3)
@@ -391,6 +397,7 @@ struct tb_regs_port_header {
 #define PORT_CS_19_WOC=09=09=09=09BIT(16)
 #define PORT_CS_19_WOD=09=09=09=09BIT(17)
 #define PORT_CS_19_WOU4=09=09=09=09BIT(18)
+#define PORT_CS_19_START_ASYM=09=09=09BIT(24)
=20
 /* Display Port adapter registers */
 #define ADP_DP_CS_0=09=09=09=090x00
diff --git a/drivers/thunderbolt/usb4.c b/drivers/thunderbolt/usb4.c
index 3aa32d7f9f6a..e048e81c3027 100644
--- a/drivers/thunderbolt/usb4.c
+++ b/drivers/thunderbolt/usb4.c
@@ -1494,6 +1494,112 @@ bool usb4_port_clx_supported(struct tb_port *port)
 =09return !!(val & PORT_CS_18_CPS);
 }
=20
+/**
+ * usb4_port_asym_supported() - If the port supports asymmetric link
+ * @port: USB4 port
+ *
+ * Checks if the port and the cable supports asymmetric link and returns
+ * %true in that case.
+ */
+bool usb4_port_asym_supported(struct tb_port *port)
+{
+=09u32 val;
+
+=09if (!port->cap_usb4)
+=09=09return false;
+
+=09if (tb_port_read(port, &val, TB_CFG_PORT, port->cap_usb4 + PORT_CS_18, =
1))
+=09=09return false;
+
+=09return !!(val & PORT_CS_18_CSA);
+}
+
+/**
+ * usb4_port_asym_set_link_width() - Set link width to asymmetric or symme=
tric
+ * @port: USB4 port
+ * @width: Asymmetric width to configure
+ *
+ * Sets USB4 port link width to @width. Can be called for widths where
+ * usb4_port_asym_width_supported() returned @true.
+ */
+int usb4_port_asym_set_link_width(struct tb_port *port, enum tb_link_width=
 width)
+{
+=09u32 val;
+=09int ret;
+
+=09if (!port->cap_phy)
+=09=09return -EINVAL;
+
+=09ret =3D tb_port_read(port, &val, TB_CFG_PORT,
+=09=09=09   port->cap_phy + LANE_ADP_CS_1, 1);
+=09if (ret)
+=09=09return ret;
+
+=09val &=3D ~LANE_ADP_CS_1_TARGET_WIDTH_ASYM_MASK;
+=09switch (width) {
+=09case TB_LINK_WIDTH_DUAL:
+=09=09val |=3D FIELD_PREP(LANE_ADP_CS_1_TARGET_WIDTH_ASYM_MASK,
+=09=09=09=09  LANE_ADP_CS_1_TARGET_WIDTH_ASYM_DUAL);
+=09=09break;
+=09case TB_LINK_WIDTH_ASYM_TX:
+=09=09val |=3D FIELD_PREP(LANE_ADP_CS_1_TARGET_WIDTH_ASYM_MASK,
+=09=09=09=09  LANE_ADP_CS_1_TARGET_WIDTH_ASYM_TX);
+=09=09break;
+=09case TB_LINK_WIDTH_ASYM_RX:
+=09=09val |=3D FIELD_PREP(LANE_ADP_CS_1_TARGET_WIDTH_ASYM_MASK,
+=09=09=09=09  LANE_ADP_CS_1_TARGET_WIDTH_ASYM_RX);
+=09=09break;
+=09default:
+=09=09return -EINVAL;
+=09}
+
+=09return tb_port_write(port, &val, TB_CFG_PORT,
+=09=09=09     port->cap_phy + LANE_ADP_CS_1, 1);
+}
+
+/**
+ * usb4_port_asym_start() - Start symmetry change and wait for completion
+ * @port: USB4 port
+ *
+ * Start symmetry change of the link to asymmetric or symmetric
+ * (according to what was previously set in tb_port_set_link_width().
+ * Wait for completion of the change.
+ *
+ * Returns %0 in case of success, %-ETIMEDOUT if case of timeout or
+ * a negative errno in case of a failure.
+ */
+int usb4_port_asym_start(struct tb_port *port)
+{
+=09int ret;
+=09u32 val;
+
+=09ret =3D tb_port_read(port, &val, TB_CFG_PORT,
+=09=09=09   port->cap_usb4 + PORT_CS_19, 1);
+=09if (ret)
+=09=09return ret;
+
+=09val &=3D ~PORT_CS_19_START_ASYM;
+=09val |=3D FIELD_PREP(PORT_CS_19_START_ASYM, 1);
+
+=09ret =3D tb_port_write(port, &val, TB_CFG_PORT,
+=09=09=09    port->cap_usb4 + PORT_CS_19, 1);
+=09if (ret)
+=09=09return ret;
+
+=09/*
+=09 * Wait for PORT_CS_19_START_ASYM to be 0. This means the USB4
+=09 * port started the symmetry transition.
+=09 */
+=09ret =3D usb4_port_wait_for_bit(port, port->cap_usb4 + PORT_CS_19,
+=09=09=09=09     PORT_CS_19_START_ASYM, 0, 1000);
+=09if (ret)
+=09=09return ret;
+
+=09/* Then wait for the transtion to be completed */
+=09return usb4_port_wait_for_bit(port, port->cap_usb4 + PORT_CS_18,
+=09=09=09=09      PORT_CS_18_TIP, 0, 5000);
+}
+
 /**
  * usb4_port_margining_caps() - Read USB4 port marginig capabilities
  * @port: USB4 port
--=20
2.45.1


