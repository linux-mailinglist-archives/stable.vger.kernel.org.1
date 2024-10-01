Return-Path: <stable+bounces-78573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9324598C495
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:34:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BEE22B233EC
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA9B1CEAC0;
	Tue,  1 Oct 2024 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="HdpR7uB0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B6A1CDFBC
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803940; cv=none; b=J0w45Ow77tPGezEQsPLlHjLkB18rTdVZU1pnLY/zK0ipxWKx3rwDY3ZZjv1RYeexBbMpgCllyHYc8xWTHWapoDKHDf7FP5NFajV53AT6mbYHVURcvDb72UhICGGh/IkLFTA1rLe6OEl1yj4u06cF8g9hD9X4fUyjfPyNsYoIHv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803940; c=relaxed/simple;
	bh=vvqaqbYxZyCCLWrD5t0qxu/3Bn5uWXKD6rgCCsrg+Wc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FgpP8Npk7TLu6l3rniT0ety4jsbmhoJ1tlDOGE9GsENBc53Hu5lUBlKrHLk213lnjgkWLHGbDEbBrZ2EwZuPqUdtfmtFl6oPXvkIeCozDzHNkwTkoveAHYWFpkqn6b0H6Yrkfj5UXYiTM7XQqr/rkH5iSPrDiKA8ltqnyxZ0VgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=HdpR7uB0; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ch5qqPD68czI4VQ55H/x4IwmJfUibR6hfTWfzqJbV2Y=;
	b=HdpR7uB053DAvPf2IzZnHrT756OipZUHivtNMuP2sEvUrb3DsyBPdCdSjlWgMdRx7qpdqF
	xkNMwar42v7uVJtdVOo+hgyBDrp32s8wzdsYNw8PLCT1ol44BRlFgKR3NvwQ6T/pD/zCa6
	a6eZob+nQZdpUodGy9t8fWyQEtgyR18=
Received: from g7t16451g.inc.hp.com (hpifallback.mail.core.hp.com
 [15.73.128.137]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-4zLU7p1sMCGRT1V_T3Hzwg-1; Tue, 01 Oct 2024 13:32:16 -0400
X-MC-Unique: 4zLU7p1sMCGRT1V_T3Hzwg-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g7t16451g.inc.hp.com (Postfix) with ESMTPS id 3282160000B2;
	Tue,  1 Oct 2024 17:32:15 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 92ED220;
	Tue,  1 Oct 2024 17:32:13 +0000 (UTC)
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
Subject: [PATCH 6.6 09/14] thunderbolt: Introduce tb_port_path_direction_downstream()
Date: Tue,  1 Oct 2024 17:31:04 +0000
Message-Id: <20241001173109.1513-10-alexandru.gagniuc@hp.com>
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

[ Upstream commit 2bfeca73e94567c1a117ca45d2e8a25d63e5bd2c ]

Introduce tb_port_path_direction_downstream() to check if path from
source adapter to destination adapter is directed towards downstream.
Convert existing users to call this helper instead of open-coding.

No functional changes.

Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/thunderbolt/tb.c     |  6 +++---
 drivers/thunderbolt/tb.h     | 15 +++++++++++++++
 drivers/thunderbolt/tunnel.c | 14 +++++++-------
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 183225bdbbf5..4ea0536ec5cf 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -553,7 +553,7 @@ static struct tb_tunnel *tb_find_first_usb3_tunnel(stru=
ct tb *tb,
 =09struct tb_switch *sw;
=20
 =09/* Pick the router that is deepest in the topology */
-=09if (dst_port->sw->config.depth > src_port->sw->config.depth)
+=09if (tb_port_path_direction_downstream(src_port, dst_port))
 =09=09sw =3D dst_port->sw;
 =09else
 =09=09sw =3D src_port->sw;
@@ -1223,7 +1223,7 @@ tb_recalc_estimated_bandwidth_for_group(struct tb_ban=
dwidth_group *group)
 =09=09tb_port_dbg(in, "re-calculated estimated bandwidth %u/%u Mb/s\n",
 =09=09=09    estimated_up, estimated_down);
=20
-=09=09if (in->sw->config.depth < out->sw->config.depth)
+=09=09if (tb_port_path_direction_downstream(in, out))
 =09=09=09estimated_bw =3D estimated_down;
 =09=09else
 =09=09=09estimated_bw =3D estimated_up;
@@ -2002,7 +2002,7 @@ static void tb_handle_dp_bandwidth_request(struct wor=
k_struct *work)
=20
 =09out =3D tunnel->dst_port;
=20
-=09if (in->sw->config.depth < out->sw->config.depth) {
+=09if (tb_port_path_direction_downstream(in, out)) {
 =09=09requested_up =3D -1;
 =09=09requested_down =3D requested_bw;
 =09} else {
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 2f5f85666302..6d66dd2a3ab0 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1044,6 +1044,21 @@ void tb_port_release_out_hopid(struct tb_port *port,=
 int hopid);
 struct tb_port *tb_next_port_on_path(struct tb_port *start, struct tb_port=
 *end,
 =09=09=09=09     struct tb_port *prev);
=20
+/**
+ * tb_port_path_direction_downstream() - Checks if path directed downstrea=
m
+ * @src: Source adapter
+ * @dst: Destination adapter
+ *
+ * Returns %true only if the specified path from source adapter (@src)
+ * to destination adapter (@dst) is directed downstream.
+ */
+static inline bool
+tb_port_path_direction_downstream(const struct tb_port *src,
+=09=09=09=09  const struct tb_port *dst)
+{
+=09return src->sw->config.depth < dst->sw->config.depth;
+}
+
 static inline bool tb_port_use_credit_allocation(const struct tb_port *por=
t)
 {
 =09return tb_port_is_null(port) && port->sw->credit_allocation;
diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index e296ab5d657b..8aec678d80d3 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -677,7 +677,7 @@ static int tb_dp_xchg_caps(struct tb_tunnel *tunnel)
 =09=09      "DP OUT maximum supported bandwidth %u Mb/s x%u =3D %u Mb/s\n"=
,
 =09=09      out_rate, out_lanes, bw);
=20
-=09if (in->sw->config.depth < out->sw->config.depth)
+=09if (tb_port_path_direction_downstream(in, out))
 =09=09max_bw =3D tunnel->max_down;
 =09else
 =09=09max_bw =3D tunnel->max_up;
@@ -802,7 +802,7 @@ static int tb_dp_bandwidth_alloc_mode_enable(struct tb_=
tunnel *tunnel)
 =09 * max_up/down fields. For discovery we just read what the
 =09 * estimation was set to.
 =09 */
-=09if (in->sw->config.depth < out->sw->config.depth)
+=09if (tb_port_path_direction_downstream(in, out))
 =09=09estimated_bw =3D tunnel->max_down;
 =09else
 =09=09estimated_bw =3D tunnel->max_up;
@@ -972,7 +972,7 @@ static int tb_dp_bandwidth_mode_consumed_bandwidth(stru=
ct tb_tunnel *tunnel,
 =09if (allocated_bw =3D=3D max_bw)
 =09=09allocated_bw =3D ret;
=20
-=09if (in->sw->config.depth < out->sw->config.depth) {
+=09if (tb_port_path_direction_downstream(in, out)) {
 =09=09*consumed_up =3D 0;
 =09=09*consumed_down =3D allocated_bw;
 =09} else {
@@ -1007,7 +1007,7 @@ static int tb_dp_allocated_bandwidth(struct tb_tunnel=
 *tunnel, int *allocated_up
 =09=09if (allocated_bw =3D=3D max_bw)
 =09=09=09allocated_bw =3D ret;
=20
-=09=09if (in->sw->config.depth < out->sw->config.depth) {
+=09=09if (tb_port_path_direction_downstream(in, out)) {
 =09=09=09*allocated_up =3D 0;
 =09=09=09*allocated_down =3D allocated_bw;
 =09=09} else {
@@ -1035,7 +1035,7 @@ static int tb_dp_alloc_bandwidth(struct tb_tunnel *tu=
nnel, int *alloc_up,
 =09if (ret < 0)
 =09=09return ret;
=20
-=09if (in->sw->config.depth < out->sw->config.depth) {
+=09if (tb_port_path_direction_downstream(in, out)) {
 =09=09tmp =3D min(*alloc_down, max_bw);
 =09=09ret =3D usb4_dp_port_allocate_bandwidth(in, tmp);
 =09=09if (ret)
@@ -1133,7 +1133,7 @@ static int tb_dp_maximum_bandwidth(struct tb_tunnel *=
tunnel, int *max_up,
 =09if (ret < 0)
 =09=09return ret;
=20
-=09if (in->sw->config.depth < tunnel->dst_port->sw->config.depth) {
+=09if (tb_port_path_direction_downstream(in, tunnel->dst_port)) {
 =09=09*max_up =3D 0;
 =09=09*max_down =3D ret;
 =09} else {
@@ -1191,7 +1191,7 @@ static int tb_dp_consumed_bandwidth(struct tb_tunnel =
*tunnel, int *consumed_up,
 =09=09return 0;
 =09}
=20
-=09if (in->sw->config.depth < tunnel->dst_port->sw->config.depth) {
+=09if (tb_port_path_direction_downstream(in, tunnel->dst_port)) {
 =09=09*consumed_up =3D 0;
 =09=09*consumed_down =3D tb_dp_bandwidth(rate, lanes);
 =09} else {
--=20
2.45.1


