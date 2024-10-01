Return-Path: <stable+bounces-78566-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C47C498C47E
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82AC1C2349D
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C01CC8AB;
	Tue,  1 Oct 2024 17:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="jrZI2jzU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D911CC15F
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803930; cv=none; b=OXymNP7tOzEGDTQ6Vq018toX8DK7yrbGsZKc5vWGiRFUELZQRZw28BRLBhJkKvSH/0l2zKm01wz67iBcgyyGYj5YJ9BlVkcZE8D8LTvxqSxLyawSCbTdSB8YImgq9Vz0w7p0jjRppA+/mrdPSE2TG5Qrz68aV0o5/KIunS5Nwjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803930; c=relaxed/simple;
	bh=95uHAVLhn3dwbvkj1bSKFguBoCiULtcN730jVEMT60M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8p6P6lZsehtSHmxc/8EBALa3EgJF/z0Ve3dN8/EWb0MD3+LCAHAsMePN8ATY30atbnvYKpto6VOJE2vMB1CYRR7iynH7EhiqKahecOZMXXxfAdkuYOSuQ18HymVnj/ZDKxbDUlAga+Ew7TEQcM6uBKMs3UL5/LWOjLCaTtX15k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=jrZI2jzU; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803927;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9FDkauejoxz2XTpH28ePbl2EFJ+/zapfPnhifYMCH08=;
	b=jrZI2jzUa5XKqQamxTArYVngKqkz6Ox0p3xKKo1zY2to8zUeda07S0NuFVOEkis+5U41QH
	iZs+zygvFNMIf+8CcNerteNQ49HnKQBFBALqisDfmmo3Q3LvnwWvBOO4IwMOwAD6XIn1pU
	/dsCfWVKygrbFlki7lGx65+IRvMR2WE=
Received: from g7t16451g.inc.hp.com (hpi-bastion.austin1.mail.core.hp.com
 [15.73.128.137]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-400-ohbBEXR0ML-V0qPm_19wDw-1; Tue, 01 Oct 2024 13:32:06 -0400
X-MC-Unique: ohbBEXR0ML-V0qPm_19wDw-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g7t16451g.inc.hp.com (Postfix) with ESMTPS id 30CFD6000E52;
	Tue,  1 Oct 2024 17:32:05 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id C8BD118;
	Tue,  1 Oct 2024 17:32:03 +0000 (UTC)
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
	Alexandru Gagniuc <alexandru.gagniuc@hp.com>
Subject: [PATCH 6.6 02/14] thunderbolt: Use tb_tunnel_dbg() where possible to make logging more consistent
Date: Tue,  1 Oct 2024 17:30:57 +0000
Message-Id: <20241001173109.1513-3-alexandru.gagniuc@hp.com>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

[ Upstream commit fe8a0293c922ee8bc1ff0cf9048075afb264004a ]

This makes it easier to find out the tunnel in question. Also drop a
couple of lines that generate duplicate information.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/thunderbolt/tunnel.c | 65 +++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 35 deletions(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index a6810fb36860..c0a8142f73f4 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -614,8 +614,9 @@ static int tb_dp_xchg_caps(struct tb_tunnel *tunnel)
=20
 =09in_rate =3D tb_dp_cap_get_rate(in_dp_cap);
 =09in_lanes =3D tb_dp_cap_get_lanes(in_dp_cap);
-=09tb_port_dbg(in, "maximum supported bandwidth %u Mb/s x%u =3D %u Mb/s\n"=
,
-=09=09    in_rate, in_lanes, tb_dp_bandwidth(in_rate, in_lanes));
+=09tb_tunnel_dbg(tunnel,
+=09=09      "DP IN maximum supported bandwidth %u Mb/s x%u =3D %u Mb/s\n",
+=09=09      in_rate, in_lanes, tb_dp_bandwidth(in_rate, in_lanes));
=20
 =09/*
 =09 * If the tunnel bandwidth is limited (max_bw is set) then see
@@ -624,8 +625,9 @@ static int tb_dp_xchg_caps(struct tb_tunnel *tunnel)
 =09out_rate =3D tb_dp_cap_get_rate(out_dp_cap);
 =09out_lanes =3D tb_dp_cap_get_lanes(out_dp_cap);
 =09bw =3D tb_dp_bandwidth(out_rate, out_lanes);
-=09tb_port_dbg(out, "maximum supported bandwidth %u Mb/s x%u =3D %u Mb/s\n=
",
-=09=09    out_rate, out_lanes, bw);
+=09tb_tunnel_dbg(tunnel,
+=09=09      "DP OUT maximum supported bandwidth %u Mb/s x%u =3D %u Mb/s\n"=
,
+=09=09      out_rate, out_lanes, bw);
=20
 =09if (in->sw->config.depth < out->sw->config.depth)
 =09=09max_bw =3D tunnel->max_down;
@@ -639,13 +641,14 @@ static int tb_dp_xchg_caps(struct tb_tunnel *tunnel)
 =09=09=09=09=09     out_rate, out_lanes, &new_rate,
 =09=09=09=09=09     &new_lanes);
 =09=09if (ret) {
-=09=09=09tb_port_info(out, "not enough bandwidth for DP tunnel\n");
+=09=09=09tb_tunnel_info(tunnel, "not enough bandwidth\n");
 =09=09=09return ret;
 =09=09}
=20
 =09=09new_bw =3D tb_dp_bandwidth(new_rate, new_lanes);
-=09=09tb_port_dbg(out, "bandwidth reduced to %u Mb/s x%u =3D %u Mb/s\n",
-=09=09=09    new_rate, new_lanes, new_bw);
+=09=09tb_tunnel_dbg(tunnel,
+=09=09=09      "bandwidth reduced to %u Mb/s x%u =3D %u Mb/s\n",
+=09=09=09      new_rate, new_lanes, new_bw);
=20
 =09=09/*
 =09=09 * Set new rate and number of lanes before writing it to
@@ -662,7 +665,7 @@ static int tb_dp_xchg_caps(struct tb_tunnel *tunnel)
 =09 */
 =09if (tb_route(out->sw) && tb_switch_is_titan_ridge(out->sw)) {
 =09=09out_dp_cap |=3D DP_COMMON_CAP_LTTPR_NS;
-=09=09tb_port_dbg(out, "disabling LTTPR\n");
+=09=09tb_tunnel_dbg(tunnel, "disabling LTTPR\n");
 =09}
=20
 =09return tb_port_write(in, &out_dp_cap, TB_CFG_PORT,
@@ -712,8 +715,8 @@ static int tb_dp_bandwidth_alloc_mode_enable(struct tb_=
tunnel *tunnel)
 =09lanes =3D min(in_lanes, out_lanes);
 =09tmp =3D tb_dp_bandwidth(rate, lanes);
=20
-=09tb_port_dbg(in, "non-reduced bandwidth %u Mb/s x%u =3D %u Mb/s\n", rate=
,
-=09=09    lanes, tmp);
+=09tb_tunnel_dbg(tunnel, "non-reduced bandwidth %u Mb/s x%u =3D %u Mb/s\n"=
,
+=09=09      rate, lanes, tmp);
=20
 =09ret =3D usb4_dp_port_set_nrd(in, rate, lanes);
 =09if (ret)
@@ -728,15 +731,15 @@ static int tb_dp_bandwidth_alloc_mode_enable(struct t=
b_tunnel *tunnel)
 =09rate =3D min(in_rate, out_rate);
 =09tmp =3D tb_dp_bandwidth(rate, lanes);
=20
-=09tb_port_dbg(in,
-=09=09    "maximum bandwidth through allocation mode %u Mb/s x%u =3D %u Mb=
/s\n",
-=09=09    rate, lanes, tmp);
+=09tb_tunnel_dbg(tunnel,
+=09=09      "maximum bandwidth through allocation mode %u Mb/s x%u =3D %u =
Mb/s\n",
+=09=09      rate, lanes, tmp);
=20
 =09for (granularity =3D 250; tmp / granularity > 255 && granularity <=3D 1=
000;
 =09     granularity *=3D 2)
 =09=09;
=20
-=09tb_port_dbg(in, "granularity %d Mb/s\n", granularity);
+=09tb_tunnel_dbg(tunnel, "granularity %d Mb/s\n", granularity);
=20
 =09/*
 =09 * Returns -EINVAL if granularity above is outside of the
@@ -756,7 +759,7 @@ static int tb_dp_bandwidth_alloc_mode_enable(struct tb_=
tunnel *tunnel)
 =09else
 =09=09estimated_bw =3D tunnel->max_up;
=20
-=09tb_port_dbg(in, "estimated bandwidth %d Mb/s\n", estimated_bw);
+=09tb_tunnel_dbg(tunnel, "estimated bandwidth %d Mb/s\n", estimated_bw);
=20
 =09ret =3D usb4_dp_port_set_estimated_bandwidth(in, estimated_bw);
 =09if (ret)
@@ -767,7 +770,7 @@ static int tb_dp_bandwidth_alloc_mode_enable(struct tb_=
tunnel *tunnel)
 =09if (ret)
 =09=09return ret;
=20
-=09tb_port_dbg(in, "bandwidth allocation mode enabled\n");
+=09tb_tunnel_dbg(tunnel, "bandwidth allocation mode enabled\n");
 =09return 0;
 }
=20
@@ -788,7 +791,7 @@ static int tb_dp_init(struct tb_tunnel *tunnel)
 =09if (!usb4_dp_port_bandwidth_mode_supported(in))
 =09=09return 0;
=20
-=09tb_port_dbg(in, "bandwidth allocation mode supported\n");
+=09tb_tunnel_dbg(tunnel, "bandwidth allocation mode supported\n");
=20
 =09ret =3D usb4_dp_port_set_cm_id(in, tb->index);
 =09if (ret)
@@ -805,7 +808,7 @@ static void tb_dp_deinit(struct tb_tunnel *tunnel)
 =09=09return;
 =09if (usb4_dp_port_bandwidth_mode_enabled(in)) {
 =09=09usb4_dp_port_set_cm_bandwidth_mode_supported(in, false);
-=09=09tb_port_dbg(in, "bandwidth allocation mode disabled\n");
+=09=09tb_tunnel_dbg(tunnel, "bandwidth allocation mode disabled\n");
 =09}
 }
=20
@@ -921,9 +924,6 @@ static int tb_dp_bandwidth_mode_consumed_bandwidth(stru=
ct tb_tunnel *tunnel,
 =09if (allocated_bw =3D=3D max_bw)
 =09=09allocated_bw =3D ret;
=20
-=09tb_port_dbg(in, "consumed bandwidth through allocation mode %d Mb/s\n",
-=09=09    allocated_bw);
-
 =09if (in->sw->config.depth < out->sw->config.depth) {
 =09=09*consumed_up =3D 0;
 =09=09*consumed_down =3D allocated_bw;
@@ -1006,9 +1006,6 @@ static int tb_dp_alloc_bandwidth(struct tb_tunnel *tu=
nnel, int *alloc_up,
 =09/* Now we can use BW mode registers to figure out the bandwidth */
 =09/* TODO: need to handle discovery too */
 =09tunnel->bw_mode =3D true;
-
-=09tb_port_dbg(in, "allocated bandwidth through allocation mode %d Mb/s\n"=
,
-=09=09    tmp);
 =09return 0;
 }
=20
@@ -1035,8 +1032,7 @@ static int tb_dp_read_dprx(struct tb_tunnel *tunnel, =
u32 *rate, u32 *lanes,
 =09=09=09*rate =3D tb_dp_cap_get_rate(val);
 =09=09=09*lanes =3D tb_dp_cap_get_lanes(val);
=20
-=09=09=09tb_port_dbg(in, "consumed bandwidth through DPRX %d Mb/s\n",
-=09=09=09=09    tb_dp_bandwidth(*rate, *lanes));
+=09=09=09tb_tunnel_dbg(tunnel, "DPRX read done\n");
 =09=09=09return 0;
 =09=09}
 =09=09usleep_range(100, 150);
@@ -1073,9 +1069,6 @@ static int tb_dp_read_cap(struct tb_tunnel *tunnel, u=
nsigned int cap, u32 *rate,
=20
 =09*rate =3D tb_dp_cap_get_rate(val);
 =09*lanes =3D tb_dp_cap_get_lanes(val);
-
-=09tb_port_dbg(in, "bandwidth from %#x capability %d Mb/s\n", cap,
-=09=09    tb_dp_bandwidth(*rate, *lanes));
 =09return 0;
 }
=20
@@ -1253,8 +1246,9 @@ static void tb_dp_dump(struct tb_tunnel *tunnel)
 =09rate =3D tb_dp_cap_get_rate(dp_cap);
 =09lanes =3D tb_dp_cap_get_lanes(dp_cap);
=20
-=09tb_port_dbg(in, "maximum supported bandwidth %u Mb/s x%u =3D %u Mb/s\n"=
,
-=09=09    rate, lanes, tb_dp_bandwidth(rate, lanes));
+=09tb_tunnel_dbg(tunnel,
+=09=09      "DP IN maximum supported bandwidth %u Mb/s x%u =3D %u Mb/s\n",
+=09=09      rate, lanes, tb_dp_bandwidth(rate, lanes));
=20
 =09out =3D tunnel->dst_port;
=20
@@ -1265,8 +1259,9 @@ static void tb_dp_dump(struct tb_tunnel *tunnel)
 =09rate =3D tb_dp_cap_get_rate(dp_cap);
 =09lanes =3D tb_dp_cap_get_lanes(dp_cap);
=20
-=09tb_port_dbg(out, "maximum supported bandwidth %u Mb/s x%u =3D %u Mb/s\n=
",
-=09=09    rate, lanes, tb_dp_bandwidth(rate, lanes));
+=09tb_tunnel_dbg(tunnel,
+=09=09      "DP OUT maximum supported bandwidth %u Mb/s x%u =3D %u Mb/s\n"=
,
+=09=09      rate, lanes, tb_dp_bandwidth(rate, lanes));
=20
 =09if (tb_port_read(in, &dp_cap, TB_CFG_PORT,
 =09=09=09 in->cap_adap + DP_REMOTE_CAP, 1))
@@ -1275,8 +1270,8 @@ static void tb_dp_dump(struct tb_tunnel *tunnel)
 =09rate =3D tb_dp_cap_get_rate(dp_cap);
 =09lanes =3D tb_dp_cap_get_lanes(dp_cap);
=20
-=09tb_port_dbg(in, "reduced bandwidth %u Mb/s x%u =3D %u Mb/s\n",
-=09=09    rate, lanes, tb_dp_bandwidth(rate, lanes));
+=09tb_tunnel_dbg(tunnel, "reduced bandwidth %u Mb/s x%u =3D %u Mb/s\n",
+=09=09      rate, lanes, tb_dp_bandwidth(rate, lanes));
 }
=20
 /**
--=20
2.45.1


