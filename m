Return-Path: <stable+bounces-78578-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1425F98C4A2
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:35:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC513286543
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C01D1CF5D3;
	Tue,  1 Oct 2024 17:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="hQF0hzBg"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.129.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE11CF5C1
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803949; cv=none; b=FIkT4pF+axiXDV8YtuLuMwVZSVcv6XSRUxbCigKB74XCLeW9RQknrYO+yrPuiHsjyhGRVmZ8dkJFOsQsBdvTxqwepeeV//CBZsaV3tRCegLO3I6/t7pNX+7pa7F+XDXsrmOMCnux/mpWJRk37Oum1aUtZsdHX0X27h7L4PtceQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803949; c=relaxed/simple;
	bh=E4LgHLrWgF1RKt3FIMRF2EcRz70JSi2sS8gv4RwlqDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q5Oyd2q8XN8Iit9iId9b5CBhihxFUJNwzVM75B0j7nN3Jv+JODObZtL0Di551kKfcIQdGN1eT5zl/9YpAM0tajDIov3TNNVHKcnDW06jCE33e0RjiDSE3ZG01vxBl7nwBeXOzE9qsZGKleFyfeVa8yculBqnPQSIU2S/cxcrGyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=hQF0hzBg; arc=none smtp.client-ip=170.10.129.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lD2i1Q6tTo9IRdXlsPnDOoVcWUOqej5qY4Gl2VuLzfE=;
	b=hQF0hzBg/PGSs85RufzgYKLUFOJuTo1cjgvdrFkxs1kphyQwYmKlEnS4JhP2yXYD2FTzhN
	NVJBWqdNoeuJW5uMDZhV8Kjc4qaWF06+lN9uquObWht8Zl9dI898D0OOyF1r4gFbqjek8K
	XuKymVetx5k9GMIOqe4O4mCWrbCJDuA=
Received: from g8t13017g.inc.hp.com (hpi-bastion.austin2.mail.core.hp.com
 [15.72.64.135]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-gSUzTbAsM5alVaa2JaNgjQ-1; Tue, 01 Oct 2024 13:32:24 -0400
X-MC-Unique: gSUzTbAsM5alVaa2JaNgjQ-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g8t13017g.inc.hp.com (Postfix) with ESMTPS id 136236000DFA;
	Tue,  1 Oct 2024 17:32:22 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 6E05318;
	Tue,  1 Oct 2024 17:32:20 +0000 (UTC)
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
Subject: [PATCH 6.6 14/14] thunderbolt: Improve DisplayPort tunnel setup process to be more robust
Date: Tue,  1 Oct 2024 17:31:09 +0000
Message-Id: <20241001173109.1513-15-alexandru.gagniuc@hp.com>
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

[ Upstream commit b4734507ac55cc7ea1380e20e83f60fcd7031955 ]

After DisplayPort tunnel setup, we add verification that the DPRX
capabilities read process completed. Otherwise, we bail out, teardown
the tunnel, and try setup another DisplayPort tunnel using next
available DP IN adapter. We do so till all DP IN adapters tried. This
way, we avoid allocating DP IN adapter and (bandwidth for it) for
unusable tunnel.

Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/thunderbolt/tb.c | 84 ++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 41 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index c52cbd5194f1..ea155547e871 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -1699,48 +1699,14 @@ static struct tb_port *tb_find_dp_out(struct tb *tb=
, struct tb_port *in)
 =09return NULL;
 }
=20
-static bool tb_tunnel_one_dp(struct tb *tb)
+static bool tb_tunnel_one_dp(struct tb *tb, struct tb_port *in,
+=09=09=09     struct tb_port *out)
 {
 =09int available_up, available_down, ret, link_nr;
 =09struct tb_cm *tcm =3D tb_priv(tb);
-=09struct tb_port *port, *in, *out;
 =09int consumed_up, consumed_down;
 =09struct tb_tunnel *tunnel;
=20
-=09/*
-=09 * Find pair of inactive DP IN and DP OUT adapters and then
-=09 * establish a DP tunnel between them.
-=09 */
-=09tb_dbg(tb, "looking for DP IN <-> DP OUT pairs:\n");
-
-=09in =3D NULL;
-=09out =3D NULL;
-=09list_for_each_entry(port, &tcm->dp_resources, list) {
-=09=09if (!tb_port_is_dpin(port))
-=09=09=09continue;
-
-=09=09if (tb_port_is_enabled(port)) {
-=09=09=09tb_port_dbg(port, "DP IN in use\n");
-=09=09=09continue;
-=09=09}
-
-=09=09in =3D port;
-=09=09tb_port_dbg(in, "DP IN available\n");
-
-=09=09out =3D tb_find_dp_out(tb, port);
-=09=09if (out)
-=09=09=09break;
-=09}
-
-=09if (!in) {
-=09=09tb_dbg(tb, "no suitable DP IN adapter available, not tunneling\n");
-=09=09return false;
-=09}
-=09if (!out) {
-=09=09tb_dbg(tb, "no suitable DP OUT adapter available, not tunneling\n");
-=09=09return false;
-=09}
-
 =09/*
 =09 * This is only applicable to links that are not bonded (so
 =09 * when Thunderbolt 1 hardware is involved somewhere in the
@@ -1801,15 +1767,19 @@ static bool tb_tunnel_one_dp(struct tb *tb)
 =09=09goto err_free;
 =09}
=20
+=09/* If fail reading tunnel's consumed bandwidth, tear it down */
+=09ret =3D tb_tunnel_consumed_bandwidth(tunnel, &consumed_up, &consumed_do=
wn);
+=09if (ret)
+=09=09goto err_deactivate;
+
 =09list_add_tail(&tunnel->list, &tcm->tunnel_list);
-=09tb_reclaim_usb3_bandwidth(tb, in, out);
=20
+=09tb_reclaim_usb3_bandwidth(tb, in, out);
 =09/*
 =09 * Transition the links to asymmetric if the consumption exceeds
 =09 * the threshold.
 =09 */
-=09if (!tb_tunnel_consumed_bandwidth(tunnel, &consumed_up, &consumed_down)=
)
-=09=09tb_configure_asym(tb, in, out, consumed_up, consumed_down);
+=09tb_configure_asym(tb, in, out, consumed_up, consumed_down);
=20
 =09/* Update the domain with the new bandwidth estimation */
 =09tb_recalc_estimated_bandwidth(tb);
@@ -1821,6 +1791,8 @@ static bool tb_tunnel_one_dp(struct tb *tb)
 =09tb_increase_tmu_accuracy(tunnel);
 =09return true;
=20
+err_deactivate:
+=09tb_tunnel_deactivate(tunnel);
 err_free:
 =09tb_tunnel_free(tunnel);
 err_reclaim_usb:
@@ -1840,13 +1812,43 @@ static bool tb_tunnel_one_dp(struct tb *tb)
=20
 static void tb_tunnel_dp(struct tb *tb)
 {
+=09struct tb_cm *tcm =3D tb_priv(tb);
+=09struct tb_port *port, *in, *out;
+
 =09if (!tb_acpi_may_tunnel_dp()) {
 =09=09tb_dbg(tb, "DP tunneling disabled, not creating tunnel\n");
 =09=09return;
 =09}
=20
-=09while (tb_tunnel_one_dp(tb))
-=09=09;
+=09/*
+=09 * Find pair of inactive DP IN and DP OUT adapters and then
+=09 * establish a DP tunnel between them.
+=09 */
+=09tb_dbg(tb, "looking for DP IN <-> DP OUT pairs:\n");
+
+=09in =3D NULL;
+=09out =3D NULL;
+=09list_for_each_entry(port, &tcm->dp_resources, list) {
+=09=09if (!tb_port_is_dpin(port))
+=09=09=09continue;
+
+=09=09if (tb_port_is_enabled(port)) {
+=09=09=09tb_port_dbg(port, "DP IN in use\n");
+=09=09=09continue;
+=09=09}
+
+=09=09in =3D port;
+=09=09tb_port_dbg(in, "DP IN available\n");
+
+=09=09out =3D tb_find_dp_out(tb, port);
+=09=09if (out)
+=09=09=09tb_tunnel_one_dp(tb, in, out);
+=09=09else
+=09=09=09tb_port_dbg(in, "no suitable DP OUT adapter available, not tunnel=
ing\n");
+=09}
+
+=09if (!in)
+=09=09tb_dbg(tb, "no suitable DP IN adapter available, not tunneling\n");
 }
=20
 static void tb_enter_redrive(struct tb_port *port)
--=20
2.45.1


