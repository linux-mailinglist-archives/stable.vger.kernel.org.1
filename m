Return-Path: <stable+bounces-203274-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD4F7CD8631
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 08:26:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38D4B3010CE6
	for <lists+stable@lfdr.de>; Tue, 23 Dec 2025 07:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659F130BBA5;
	Tue, 23 Dec 2025 07:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b="qMEi1lKZ"
X-Original-To: stable@vger.kernel.org
Received: from gw.hale.at (gw.hale.at [89.26.116.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C4E1D47B4;
	Tue, 23 Dec 2025 07:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.26.116.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766474805; cv=none; b=PBXC2n0vod6BmvdtHkpMjFit8odvLy9dwzgQzSIMsxcRGwxM3e9xtVxTM+hUDgePWsicyngH5P+eG2xg3P7C+AovK7A9hqHUz1pJp/qLa+VkfHeXnpFZS7ojEF+uP3yAldb8bN6l4QuBJFk38aRch7dDrAEYL+NPe/g2INWyI9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766474805; c=relaxed/simple;
	bh=xT4HzxmUGePoEVqAPjuR2DmPxc+ApISnJX+XLCn/U+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHbQmDD32W2RJLCx5bmXAshzON02RzchUyH67KdKAbliXocFqwzBhhFUXcrUbl0suA17+qEAUJm6ayQ7J6ZKBT6CyFaVlI4X2Orz7NxaialaBccB1wji9uUHjmFo95jAcJcSv1YGzXMNh7WpQJdc7NKeNwACzmaluuaKlM+VKWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at; spf=pass smtp.mailfrom=hale.at; dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b=qMEi1lKZ; arc=none smtp.client-ip=89.26.116.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hale.at
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=hale.at; i=@hale.at; q=dns/txt; s=mail;
  t=1766474801; x=1798010801;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xT4HzxmUGePoEVqAPjuR2DmPxc+ApISnJX+XLCn/U+0=;
  b=qMEi1lKZln+vf/X3mCJ3GF9jMOLtULD4CCbjA44XTQWHgxH+AhaqsLRn
   YBMWE8+OyEFwfJF9MibDvSMJpNgLmCKtQwY/aSPfyh+PeTZdbiYyZ60g2
   zknzKhpxwZWlRaHaw6h1yCzm3Uun+Sigi13oS4gyvcv3yAgLdUZzhCYga
   RXBdGqDdN6y6E0VmLOfC71arcogf6oAbqLrkHAlDn2YUpXTvq1H/W833x
   tTFbsMEdovpvZoZUBDYCad9ioKy2ByTLAjPULez/Kn4s9PM3zsxXH3e5b
   vM5MpNPsETS9bNyGR7KLc3o4RBasf73jIFcU86Y3jPv1/NHSiSC/3JILe
   w==;
X-CSE-ConnectionGUID: LhuvwJU0TZ2mzKYVOPvWjg==
X-CSE-MsgGUID: nQzZsdlcRi2QYd32IC4m0w==
IronPort-SDR: 694a4417_HcEKRiGZW8j22Zv/M/fLgOui9T+Vk07cFctkCdgMplxIXHr
 QSvEllD5Ba8aGiudvXQBNGH+duiL9tUW8y2Xo/A==
X-IronPort-AV: E=Sophos;i="6.21,170,1763420400"; 
   d="scan'208";a="1527459"
Received: from unknown (HELO mail4.hale.at) ([192.168.100.5])
  by mgmt.hale.at with ESMTP; 23 Dec 2025 08:26:15 +0100
Received: from mail4.hale.at (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTPS id B5D2C13005B9;
	Tue, 23 Dec 2025 08:25:55 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTP id 9DADE1300765;
	Tue, 23 Dec 2025 08:25:55 +0100 (CET)
X-Virus-Scanned: amavis at mail4.hale.at
Received: from mail4.hale.at ([127.0.0.1])
 by localhost (mail4.hale.at [127.0.0.1]) (amavis, port 10026) with ESMTP
 id YrHoA0tD3vI9; Tue, 23 Dec 2025 08:25:55 +0100 (CET)
Received: from entw47.HALE.at (entw47 [192.168.100.117])
	by mail4.hale.at (Postfix) with ESMTPSA id 8861013005B9;
	Tue, 23 Dec 2025 08:25:55 +0100 (CET)
From: Michael Thalmeier <michael.thalmeier@hale.at>
To: Deepak Sharma <deepak.sharma.472935@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Michael Thalmeier <michael@thalmeier.at>,
	Michael Thalmeier <michael.thalmeier@hale.at>,
	stable@vger.kernel.org
Subject: [PATCH net v4] net: nfc: nci: Fix parameter validation for packet data
Date: Tue, 23 Dec 2025 08:25:52 +0100
Message-ID: <20251223072552.297922-1-michael.thalmeier@hale.at>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit 9c328f54741b ("net: nfc: nci: Add parameter validation for
packet data") communication with nci nfc chips is not working any more.

The mentioned commit tries to fix access of uninitialized data, but
failed to understand that in some cases the data packet is of variable
length and can therefore not be compared to the maximum packet length
given by the sizeof(struct).

Fixes: 9c328f54741b ("net: nfc: nci: Add parameter validation for packet =
data")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
---
v4:
- formatting fixes

v3:
- perform complete checks
- replace magic numbers with offsetofend and sizeof

v2:
- Reference correct commit hash

---
 net/nfc/nci/ntf.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 418b84e2b260..a5cafcd10cc3 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -58,7 +58,7 @@ static int nci_core_conn_credits_ntf_packet(struct nci_=
dev *ndev,
 	struct nci_conn_info *conn_info;
 	int i;
=20
-	if (skb->len < sizeof(struct nci_core_conn_credit_ntf))
+	if (skb->len < offsetofend(struct nci_core_conn_credit_ntf, num_entries=
))
 		return -EINVAL;
=20
 	ntf =3D (struct nci_core_conn_credit_ntf *)skb->data;
@@ -68,6 +68,10 @@ static int nci_core_conn_credits_ntf_packet(struct nci=
_dev *ndev,
 	if (ntf->num_entries > NCI_MAX_NUM_CONN)
 		ntf->num_entries =3D NCI_MAX_NUM_CONN;
=20
+	if (skb->len < offsetofend(struct nci_core_conn_credit_ntf, num_entries=
) +
+			ntf->num_entries * sizeof(struct conn_credit_entry))
+		return -EINVAL;
+
 	/* update the credits */
 	for (i =3D 0; i < ntf->num_entries; i++) {
 		ntf->conn_entries[i].conn_id =3D
@@ -364,7 +368,7 @@ static int nci_rf_discover_ntf_packet(struct nci_dev =
*ndev,
 	const __u8 *data;
 	bool add_target =3D true;
=20
-	if (skb->len < sizeof(struct nci_rf_discover_ntf))
+	if (skb->len < offsetofend(struct nci_rf_discover_ntf, rf_tech_specific=
_params_len))
 		return -EINVAL;
=20
 	data =3D skb->data;
@@ -380,6 +384,10 @@ static int nci_rf_discover_ntf_packet(struct nci_dev=
 *ndev,
 	pr_debug("rf_tech_specific_params_len %d\n",
 		 ntf.rf_tech_specific_params_len);
=20
+	if (skb->len < (data - skb->data) +
+			ntf.rf_tech_specific_params_len + sizeof(ntf.ntf_type))
+		return -EINVAL;
+
 	if (ntf.rf_tech_specific_params_len > 0) {
 		switch (ntf.rf_tech_and_mode) {
 		case NCI_NFC_A_PASSIVE_POLL_MODE:
@@ -596,7 +604,7 @@ static int nci_rf_intf_activated_ntf_packet(struct nc=
i_dev *ndev,
 	const __u8 *data;
 	int err =3D NCI_STATUS_OK;
=20
-	if (skb->len < sizeof(struct nci_rf_intf_activated_ntf))
+	if (skb->len < offsetofend(struct nci_rf_intf_activated_ntf, rf_tech_sp=
ecific_params_len))
 		return -EINVAL;
=20
 	data =3D skb->data;
@@ -628,6 +636,9 @@ static int nci_rf_intf_activated_ntf_packet(struct nc=
i_dev *ndev,
 	if (ntf.rf_interface =3D=3D NCI_RF_INTERFACE_NFCEE_DIRECT)
 		goto listen;
=20
+	if (skb->len < (data - skb->data) + ntf.rf_tech_specific_params_len)
+		return -EINVAL;
+
 	if (ntf.rf_tech_specific_params_len > 0) {
 		switch (ntf.activation_rf_tech_and_mode) {
 		case NCI_NFC_A_PASSIVE_POLL_MODE:
@@ -668,6 +679,13 @@ static int nci_rf_intf_activated_ntf_packet(struct n=
ci_dev *ndev,
 		}
 	}
=20
+	if (skb->len < (data - skb->data) +
+			sizeof(ntf.data_exch_rf_tech_and_mode) +
+			sizeof(ntf.data_exch_tx_bit_rate) +
+			sizeof(ntf.data_exch_rx_bit_rate) +
+			sizeof(ntf.activation_params_len))
+		return -EINVAL;
+
 	ntf.data_exch_rf_tech_and_mode =3D *data++;
 	ntf.data_exch_tx_bit_rate =3D *data++;
 	ntf.data_exch_rx_bit_rate =3D *data++;
@@ -679,6 +697,9 @@ static int nci_rf_intf_activated_ntf_packet(struct nc=
i_dev *ndev,
 	pr_debug("data_exch_rx_bit_rate 0x%x\n", ntf.data_exch_rx_bit_rate);
 	pr_debug("activation_params_len %d\n", ntf.activation_params_len);
=20
+	if (skb->len < (data - skb->data) + ntf.activation_params_len)
+		return -EINVAL;
+
 	if (ntf.activation_params_len > 0) {
 		switch (ntf.rf_interface) {
 		case NCI_RF_INTERFACE_ISO_DEP:
--=20
2.52.0


