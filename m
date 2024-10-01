Return-Path: <stable+bounces-78571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D40A998C48D
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:34:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96AB0285A5B
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:34:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 025D41CDFC8;
	Tue,  1 Oct 2024 17:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="Li+ZYDGm"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7B01CDA35
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803938; cv=none; b=LCnKyPwJ83O966hG9sh1RhdC2V8cjYyz3XW41PkhJYv/CO2UqphnosAwxhX4pFxF/cvpmQZUa1b0BKbQ9ZmMWDG55IqxaMvWiU4TfNBtSN6JJU4V4n5h4JIvwHnhxzHRTMv5QoN6zsjDdp7okXKkvScRzit3PC6LAejSWuN6CsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803938; c=relaxed/simple;
	bh=2ng+RV1VbPbxMmDv0Xm5/UVcAWuKCHRdeXUIR4phYZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FN6Cd+DTgrDi9h5jow+8O/Gi09jQMPgaGEmQYuaCHcTdB+zSBl3BqK0WZXbNE5Y1U44HA6ZoiUuzesLwvx/5TrAsCdHZ18HYTXRnpKjwXYzjh85vouEntzWqQfuXEiaOtWCsBH7nV3q1bg3YIT0SjCWDzuMWMWC39sn/MGnfb2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=Li+ZYDGm; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJXCUAuPokK3CibSKfom0IbRsRkVfnieOynAhDn4f3Q=;
	b=Li+ZYDGmQ2GavKQRkfYeXb0b+robeYMVI4mHJyWJ60qhXIC6lzK6HfPjsXT2rWxn9JRBN8
	Sr1hTJUNPdAj79Q3Hx0+yTOGMYdGAFzypNgZ5KnVNamg82ABPN6adg/uzXcWqqOKZQN9lV
	ncKPY0VxFCBQg0YFBFnMlzrrGr1zRjo=
Received: from g8t13017g.inc.hp.com (hpi-bastion.austin2.mail.core.hp.com
 [15.72.64.135]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-548-JWTzcliXPGihSWoAhSSUmA-1; Tue, 01 Oct 2024 13:32:13 -0400
X-MC-Unique: JWTzcliXPGihSWoAhSSUmA-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g8t13017g.inc.hp.com (Postfix) with ESMTPS id 456866000DFA;
	Tue,  1 Oct 2024 17:32:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 8CBB41E;
	Tue,  1 Oct 2024 17:32:10 +0000 (UTC)
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
Subject: [PATCH 6.6 07/14] thunderbolt: Make is_gen4_link() available to the rest of the driver
Date: Tue,  1 Oct 2024 17:31:02 +0000
Message-Id: <20241001173109.1513-8-alexandru.gagniuc@hp.com>
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

[ Upstream commit aa673d606078da36ebc379f041c794228ac08cb5 ]

Rework the function to return the link generation, update the name to
tb_port_get_link_generation(), and make available to the rest of the
driver. This is needed in the subsequent patches.

Signed-off-by: Gil Fine <gil.fine@linux.intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/thunderbolt/switch.c | 36 +++++++++++++++++++++++++++++-------
 drivers/thunderbolt/tb.h     |  1 +
 2 files changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/thunderbolt/switch.c b/drivers/thunderbolt/switch.c
index f9f40c0e9add..c7f16fd0a043 100644
--- a/drivers/thunderbolt/switch.c
+++ b/drivers/thunderbolt/switch.c
@@ -921,6 +921,32 @@ int tb_port_get_link_speed(struct tb_port *port)
 =09}
 }
=20
+/**
+ * tb_port_get_link_generation() - Returns link generation
+ * @port: Lane adapter
+ *
+ * Returns link generation as number or negative errno in case of
+ * failure. Does not distinguish between Thunderbolt 1 and Thunderbolt 2
+ * links so for those always returns 2.
+ */
+int tb_port_get_link_generation(struct tb_port *port)
+{
+=09int ret;
+
+=09ret =3D tb_port_get_link_speed(port);
+=09if (ret < 0)
+=09=09return ret;
+
+=09switch (ret) {
+=09case 40:
+=09=09return 4;
+=09case 20:
+=09=09return 3;
+=09default:
+=09=09return 2;
+=09}
+}
+
 /**
  * tb_port_get_link_width() - Get current link width
  * @port: Port to check (USB4 or CIO)
@@ -966,11 +992,6 @@ static bool tb_port_is_width_supported(struct tb_port =
*port,
 =09return widths & width_mask;
 }
=20
-static bool is_gen4_link(struct tb_port *port)
-{
-=09return tb_port_get_link_speed(port) > 20;
-}
-
 /**
  * tb_port_set_link_width() - Set target link width of the lane adapter
  * @port: Lane adapter
@@ -998,7 +1019,7 @@ int tb_port_set_link_width(struct tb_port *port, enum =
tb_link_width width)
 =09switch (width) {
 =09case TB_LINK_WIDTH_SINGLE:
 =09=09/* Gen 4 link cannot be single */
-=09=09if (is_gen4_link(port))
+=09=09if (tb_port_get_link_generation(port) >=3D 4)
 =09=09=09return -EOPNOTSUPP;
 =09=09val |=3D LANE_ADP_CS_1_TARGET_WIDTH_SINGLE <<
 =09=09=09LANE_ADP_CS_1_TARGET_WIDTH_SHIFT;
@@ -1147,7 +1168,8 @@ int tb_port_wait_for_link_width(struct tb_port *port,=
 unsigned int width_mask,
 =09int ret;
=20
 =09/* Gen 4 link does not support single lane */
-=09if ((width_mask & TB_LINK_WIDTH_SINGLE) && is_gen4_link(port))
+=09if ((width_mask & TB_LINK_WIDTH_SINGLE) &&
+=09    tb_port_get_link_generation(port) >=3D 4)
 =09=09return -EOPNOTSUPP;
=20
 =09do {
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 8a75aabb9ce8..2f5f85666302 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -1062,6 +1062,7 @@ static inline bool tb_port_use_credit_allocation(cons=
t struct tb_port *port)
 =09     (p) =3D tb_next_port_on_path((src), (dst), (p)))
=20
 int tb_port_get_link_speed(struct tb_port *port);
+int tb_port_get_link_generation(struct tb_port *port);
 int tb_port_get_link_width(struct tb_port *port);
 int tb_port_set_link_width(struct tb_port *port, enum tb_link_width width)=
;
 int tb_port_lane_bonding_enable(struct tb_port *port);
--=20
2.45.1


