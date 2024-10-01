Return-Path: <stable+bounces-78575-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A1F98C499
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F22611C2379E
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1191CEE9E;
	Tue,  1 Oct 2024 17:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="NsJC86Af"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AF71CEAB9
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803942; cv=none; b=DfSoZRaaZmxzE0dLzYERxWV1AGWrHKm7R/LL7uSGOM8r/t/D8uYHgJCbdyQgjkym4Sv9i76d7gwz3wg/B0KnpNJjL+AcjbwkZOO9uyBc+OJcZsrZi5wLFEhXje/ZhrwjVS++X42Hu4jHhpUh4ouxPrs++CR/oyjuhPaeVs1b5WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803942; c=relaxed/simple;
	bh=E1zRdRY7CREGHcB8DQSWRV+OAnZp8YYwBtEFQ7UBRX4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7FfZldB4cljjHf4EyOowMfIwwmmXI3FfK2sNNRvpv18KPqM2wE0OwVNIk27LBPv8jJFUTjvc2u7xA0kmZdDLAr2Qc7XfxQHjRM3q84gwRBbw6BjlnKnR4p9xWMc6Bxg0amW9GaFP5X0FR6rwKHymZlvr8CjeNvkvza90ufwNFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=NsJC86Af; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803939;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E1zRdRY7CREGHcB8DQSWRV+OAnZp8YYwBtEFQ7UBRX4=;
	b=NsJC86Af5JQkuGsmgNoYXSNbEj2rjUdGdEv/Ev3bVtq+hUIth7/fti6W8HuQfbEyVdh5Gt
	DReaYY02CDEj7I4WGO5k/Liv6Kw67BjT10RmleyGLa5lOhnSXIshrUboq/p6EB9WWKMZYw
	kS9Cs0rFlOdBTgyjKY8yJMvrKLSXs8g=
Received: from g8t13016g.inc.hp.com (g8t13016g.inc.hp.com [15.72.64.134]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-508-KUgP6ZiFNtm5Mpq2zu-GLA-1; Tue,
 01 Oct 2024 13:32:18 -0400
X-MC-Unique: KUgP6ZiFNtm5Mpq2zu-GLA-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g8t13016g.inc.hp.com (Postfix) with ESMTPS id 9BFE76000FE9;
	Tue,  1 Oct 2024 17:32:17 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 446371E;
	Tue,  1 Oct 2024 17:32:16 +0000 (UTC)
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
Subject: [PATCH 6.6 11/14] thunderbolt: Introduce tb_switch_depth()
Date: Tue,  1 Oct 2024 17:31:06 +0000
Message-Id: <20241001173109.1513-12-alexandru.gagniuc@hp.com>
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

[ Upstream commit c4ff14436952c3d0dd05769d76cf48e73a253b48 ]

This is useful helper to find out the depth of a connected router.
Convert the existing users to call this helper instead of open-coding.

No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/thunderbolt/tb.c | 4 ++--
 drivers/thunderbolt/tb.h | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/tb.c b/drivers/thunderbolt/tb.c
index 4ea0536ec5cf..39ec8da576ef 100644
--- a/drivers/thunderbolt/tb.c
+++ b/drivers/thunderbolt/tb.c
@@ -255,13 +255,13 @@ static int tb_enable_clx(struct tb_switch *sw)
 =09 * this in the future to cover the whole topology if it turns
 =09 * out to be beneficial.
 =09 */
-=09while (sw && sw->config.depth > 1)
+=09while (sw && tb_switch_depth(sw) > 1)
 =09=09sw =3D tb_switch_parent(sw);
=20
 =09if (!sw)
 =09=09return 0;
=20
-=09if (sw->config.depth !=3D 1)
+=09if (tb_switch_depth(sw) !=3D 1)
 =09=09return 0;
=20
 =09/*
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 4cd5f48e3dee..d2ef9575231c 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -868,6 +868,15 @@ static inline struct tb_port *tb_switch_downstream_por=
t(struct tb_switch *sw)
 =09return tb_port_at(tb_route(sw), tb_switch_parent(sw));
 }
=20
+/**
+ * tb_switch_depth() - Returns depth of the connected router
+ * @sw: Router
+ */
+static inline int tb_switch_depth(const struct tb_switch *sw)
+{
+=09return sw->config.depth;
+}
+
 static inline bool tb_switch_is_light_ridge(const struct tb_switch *sw)
 {
 =09return sw->config.vendor_id =3D=3D PCI_VENDOR_ID_INTEL &&
--=20
2.45.1


