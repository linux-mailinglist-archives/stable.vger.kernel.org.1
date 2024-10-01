Return-Path: <stable+bounces-78569-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4391598C486
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 19:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01A9F2858E6
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 17:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 483341CCEC9;
	Tue,  1 Oct 2024 17:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b="WVtfgS7w"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-162.mimecast.com (us-smtp-delivery-162.mimecast.com [170.10.133.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458591CCB3A
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 17:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727803934; cv=none; b=hNUOirw6hYZbghyR7YuPCSeU+XhaCLsY6EIZUJADRh+Px847KfPbpqOTMOSXCePJAAvjykOvzwiRTA5jc8Xy7eCn853wDXZKym7kTk8udNYZG2FAss89dHaTZ/AfBTv82Xz8nP+FR1k7VfEuenMYuYHZs5l8D+olfEYCOcACp2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727803934; c=relaxed/simple;
	bh=NrO6P5oycsDCrsZvxiJrZTKeIEbsDkKLOs0SvA0S750=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPhVW0MIDPgTuGTDm59+G++MWprtkZyoLfatinyuqIVKMcLVOxT66W9hLfRjrWzzod5hUv5EuU8TZVJnGAxVWCW820GV3UxWLjjdPREI2pz96i2dxQYaRQcCNy13Dp+5+Hf7SV3axnjxXKgn65ESQMzxwmlrI8D9rLwDi1yl/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com; spf=pass smtp.mailfrom=hp.com; dkim=pass (1024-bit key) header.d=hp.com header.i=@hp.com header.b=WVtfgS7w; arc=none smtp.client-ip=170.10.133.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hp.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hp.com; s=mimecast20180716;
	t=1727803931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NrO6P5oycsDCrsZvxiJrZTKeIEbsDkKLOs0SvA0S750=;
	b=WVtfgS7wiay484A35VQ2F9A03NQta2yRyOtqeUdfWD5KuTu1WlnG3ek/73d02PXR0K81tp
	nVJ97wnogeKzfaxkNwTz72zwELv/U4F+m3ywV5ebmW65WcJdaqbFuRUvp/Ht4a19nxPl4V
	n0XVsbN597iLGK843ebhZa9VmktQypA=
Received: from g7t16451g.inc.hp.com (hpifallback.mail.core.hp.com
 [15.73.128.137]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-338-3dSQa8JsOKODyGQBkEqtWg-1; Tue, 01 Oct 2024 13:32:10 -0400
X-MC-Unique: 3dSQa8JsOKODyGQBkEqtWg-1
Received: from g7t14407g.inc.hpicorp.net (g7t14407g.inc.hpicorp.net [15.63.19.131])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by g7t16451g.inc.hp.com (Postfix) with ESMTPS id 6E3BD6000B74;
	Tue,  1 Oct 2024 17:32:09 +0000 (UTC)
Received: from localhost.localdomain (unknown [15.53.255.151])
	by g7t14407g.inc.hpicorp.net (Postfix) with ESMTP id 0DE881E;
	Tue,  1 Oct 2024 17:32:07 +0000 (UTC)
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
Subject: [PATCH 6.6 05/14] thunderbolt: Use constants for path weight and priority
Date: Tue,  1 Oct 2024 17:31:00 +0000
Message-Id: <20241001173109.1513-6-alexandru.gagniuc@hp.com>
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

[ Upstream commit f73edddfa2a64a185c65a33f100778169c92fc25 ]

Makes it easier to follow and update. No functional changes.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Qin Wan <qin.wan@hp.com>
Signed-off-by: Alexandru Gagniuc <alexandru.gagniuc@hp.com>
---
 drivers/thunderbolt/tunnel.c | 39 +++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/thunderbolt/tunnel.c b/drivers/thunderbolt/tunnel.c
index 389b8dfc2447..9947b9d0d51a 100644
--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -21,12 +21,18 @@
 #define TB_PCI_PATH_DOWN=09=090
 #define TB_PCI_PATH_UP=09=09=091
=20
+#define TB_PCI_PRIORITY=09=09=093
+#define TB_PCI_WEIGHT=09=09=091
+
 /* USB3 adapters use always HopID of 8 for both directions */
 #define TB_USB3_HOPID=09=09=098
=20
 #define TB_USB3_PATH_DOWN=09=090
 #define TB_USB3_PATH_UP=09=09=091
=20
+#define TB_USB3_PRIORITY=09=093
+#define TB_USB3_WEIGHT=09=09=093
+
 /* DP adapters use HopID 8 for AUX and 9 for Video */
 #define TB_DP_AUX_TX_HOPID=09=098
 #define TB_DP_AUX_RX_HOPID=09=098
@@ -36,6 +42,12 @@
 #define TB_DP_AUX_PATH_OUT=09=091
 #define TB_DP_AUX_PATH_IN=09=092
=20
+#define TB_DP_VIDEO_PRIORITY=09=091
+#define TB_DP_VIDEO_WEIGHT=09=091
+
+#define TB_DP_AUX_PRIORITY=09=092
+#define TB_DP_AUX_WEIGHT=09=091
+
 /* Minimum number of credits needed for PCIe path */
 #define TB_MIN_PCIE_CREDITS=09=096U
 /*
@@ -46,6 +58,9 @@
 /* Minimum number of credits for DMA path */
 #define TB_MIN_DMA_CREDITS=09=091
=20
+#define TB_DMA_PRIORITY=09=09=095
+#define TB_DMA_WEIGHT=09=09=091
+
 static unsigned int dma_credits =3D TB_DMA_CREDITS;
 module_param(dma_credits, uint, 0444);
 MODULE_PARM_DESC(dma_credits, "specify custom credits for DMA tunnels (def=
ault: "
@@ -213,8 +228,8 @@ static int tb_pci_init_path(struct tb_path *path)
 =09path->egress_shared_buffer =3D TB_PATH_NONE;
 =09path->ingress_fc_enable =3D TB_PATH_ALL;
 =09path->ingress_shared_buffer =3D TB_PATH_NONE;
-=09path->priority =3D 3;
-=09path->weight =3D 1;
+=09path->priority =3D TB_PCI_PRIORITY;
+=09path->weight =3D TB_PCI_WEIGHT;
 =09path->drop_packages =3D 0;
=20
 =09tb_path_for_each_hop(path, hop) {
@@ -1152,8 +1167,8 @@ static void tb_dp_init_aux_path(struct tb_path *path)
 =09path->egress_shared_buffer =3D TB_PATH_NONE;
 =09path->ingress_fc_enable =3D TB_PATH_ALL;
 =09path->ingress_shared_buffer =3D TB_PATH_NONE;
-=09path->priority =3D 2;
-=09path->weight =3D 1;
+=09path->priority =3D TB_DP_AUX_PRIORITY;
+=09path->weight =3D TB_DP_AUX_WEIGHT;
=20
 =09tb_path_for_each_hop(path, hop)
 =09=09tb_dp_init_aux_credits(hop);
@@ -1196,8 +1211,8 @@ static int tb_dp_init_video_path(struct tb_path *path=
)
 =09path->egress_shared_buffer =3D TB_PATH_NONE;
 =09path->ingress_fc_enable =3D TB_PATH_NONE;
 =09path->ingress_shared_buffer =3D TB_PATH_NONE;
-=09path->priority =3D 1;
-=09path->weight =3D 1;
+=09path->priority =3D TB_DP_VIDEO_PRIORITY;
+=09path->weight =3D TB_DP_VIDEO_WEIGHT;
=20
 =09tb_path_for_each_hop(path, hop) {
 =09=09int ret;
@@ -1471,8 +1486,8 @@ static int tb_dma_init_rx_path(struct tb_path *path, =
unsigned int credits)
 =09path->ingress_fc_enable =3D TB_PATH_ALL;
 =09path->egress_shared_buffer =3D TB_PATH_NONE;
 =09path->ingress_shared_buffer =3D TB_PATH_NONE;
-=09path->priority =3D 5;
-=09path->weight =3D 1;
+=09path->priority =3D TB_DMA_PRIORITY;
+=09path->weight =3D TB_DMA_WEIGHT;
 =09path->clear_fc =3D true;
=20
 =09/*
@@ -1505,8 +1520,8 @@ static int tb_dma_init_tx_path(struct tb_path *path, =
unsigned int credits)
 =09path->ingress_fc_enable =3D TB_PATH_ALL;
 =09path->egress_shared_buffer =3D TB_PATH_NONE;
 =09path->ingress_shared_buffer =3D TB_PATH_NONE;
-=09path->priority =3D 5;
-=09path->weight =3D 1;
+=09path->priority =3D TB_DMA_PRIORITY;
+=09path->weight =3D TB_DMA_WEIGHT;
 =09path->clear_fc =3D true;
=20
 =09tb_path_for_each_hop(path, hop) {
@@ -1845,8 +1860,8 @@ static void tb_usb3_init_path(struct tb_path *path)
 =09path->egress_shared_buffer =3D TB_PATH_NONE;
 =09path->ingress_fc_enable =3D TB_PATH_ALL;
 =09path->ingress_shared_buffer =3D TB_PATH_NONE;
-=09path->priority =3D 3;
-=09path->weight =3D 3;
+=09path->priority =3D TB_USB3_PRIORITY;
+=09path->weight =3D TB_USB3_WEIGHT;
 =09path->drop_packages =3D 0;
=20
 =09tb_path_for_each_hop(path, hop)
--=20
2.45.1


