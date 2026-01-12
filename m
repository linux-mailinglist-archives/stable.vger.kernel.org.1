Return-Path: <stable+bounces-208116-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D48D129C2
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 13:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E5108301967A
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 12:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A90283FCD;
	Mon, 12 Jan 2026 12:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b="eZgjLnds"
X-Original-To: stable@vger.kernel.org
Received: from gw.hale.at (gw.hale.at [89.26.116.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FBD34DB7C;
	Mon, 12 Jan 2026 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.26.116.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768222165; cv=none; b=pcrtf6LK1Aah68A/1DUi9LMD0fcitTR0TJC5atsnTw1ZB+7fnL/Hw38hU9bDIRFeqAfXUmlklNoUXhnJ2/dP5NHSODIAbYJv4qHqdOk3yZ+MnRQa1c6JPymuVmX1Fh6Sys5z6E7b0sOtPPOj2ja9wUfi4OmjSUyPxmrA9TmzXtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768222165; c=relaxed/simple;
	bh=YqL04ZyUdtOKzCk3+3np+Zeqc117SjsUdyYoRuLv9NM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ny7wAD0hB41Zg/pwKQwI3iWoQzD35rJUUo9Mdye14s936g4WVfvOlXcULEDACpDhTk1fnH1Tzv9GvwhGn+mi5uXpEWLp2LY0BHNVs9G0b7oEPSKajKQoedQPs+NwHtEbowhIJliuzKkrtQzH0He3m8a3BSaMI3nNZepgdu3LWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at; spf=pass smtp.mailfrom=hale.at; dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b=eZgjLnds; arc=none smtp.client-ip=89.26.116.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hale.at
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=hale.at; i=@hale.at; q=dns/txt; s=mail;
  t=1768222161; x=1799758161;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YqL04ZyUdtOKzCk3+3np+Zeqc117SjsUdyYoRuLv9NM=;
  b=eZgjLndsD6bOYpZR8r/azM9PfWjeoeeKQrTtZ28Mf+GIYOYahen49plx
   uCjWt7Efh8aHnI4doSEJ1pqmxLDd8QDHJol+moh11Dd+5iSw9MoTAI8mo
   yEFedhcwVPPK9j7Q3rYKh7iiqP+KtS0Xp5YzRGuUGaytmjAg8Wlr0K36T
   ckPEeflezYTwAycAIn4pxYDfFftt0U3hhydfOztz+sSv+i77B+JQmNWIs
   gE1FErbU0urn6wMIrZlcR9e5K3wAgkn1sb9eOBGEH1LDQmX3yim32wFH+
   GstA0ZhzLlAmDdkMU9LQ5Gm+PrfJCvX/S0Q/eTluF0tO4PKNccQPSWxE6
   w==;
X-CSE-ConnectionGUID: RV1hAOUbTFG0uyAjrXfJCw==
X-CSE-MsgGUID: vlW7TtVtTjmZ20cxcFlIRw==
IronPort-SDR: 6964edb8_lTWIqnAUU6OJKrlt/zz+rgfIDJgco1AakTZl9kVzQQ+4gCJ
 gq9aL6irRMuJKJBBOsXHbJKK109ojRaB2BgA5Rw==
X-IronPort-AV: E=Sophos;i="6.21,219,1763420400"; 
   d="scan'208";a="1585063"
Received: from unknown (HELO mail4.hale.at) ([192.168.100.5])
  by mgmt.hale.at with ESMTP; 12 Jan 2026 13:48:56 +0100
Received: from mail4.hale.at (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTPS id 99A2E1300713;
	Mon, 12 Jan 2026 13:48:36 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTP id 8175C1300729;
	Mon, 12 Jan 2026 13:48:36 +0100 (CET)
X-Virus-Scanned: amavis at mail4.hale.at
Received: from mail4.hale.at ([127.0.0.1])
 by localhost (mail4.hale.at [127.0.0.1]) (amavis, port 10026) with ESMTP
 id rpK-zk17lpnU; Mon, 12 Jan 2026 13:48:36 +0100 (CET)
Received: from entw47.HALE.at (entw47 [192.168.100.117])
	by mail4.hale.at (Postfix) with ESMTPSA id 5DDA91300713;
	Mon, 12 Jan 2026 13:48:36 +0100 (CET)
From: Michael Thalmeier <michael.thalmeier@hale.at>
To: Deepak Sharma <deepak.sharma.472935@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Michael Thalmeier <michael@thalmeier.at>,
	Michael Thalmeier <michael.thalmeier@hale.at>,
	stable@vger.kernel.org
Subject: [PATCH net v5] net: nfc: nci: Fix parameter validation for packet data
Date: Mon, 12 Jan 2026 13:48:18 +0100
Message-ID: <20260112124819.171028-1-michael.thalmeier@hale.at>
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
v5:
- also check helper functions in nci_extract_rf_params_nfcf_passive_liste=
n
  and nci_rf_discover_ntf_packet

v4:
- formatting fixes

v3:
- perform complete checks
- replace magic numbers with offsetofend and sizeof

v2:
- Reference correct commit hash

---
 net/nfc/nci/ntf.c | 164 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 146 insertions(+), 18 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 418b84e2b260..d9532ae9cd39 100644
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
@@ -138,23 +142,49 @@ static int nci_core_conn_intf_error_ntf_packet(stru=
ct nci_dev *ndev,
 static const __u8 *
 nci_extract_rf_params_nfca_passive_poll(struct nci_dev *ndev,
 					struct rf_tech_specific_params_nfca_poll *nfca_poll,
-					const __u8 *data)
+					const __u8 *data, size_t data_len)
 {
+	/* Check if we have enough data for sens_res (2 bytes) */
+	if (data_len < 2)
+		return ERR_PTR(-EINVAL);
+
 	nfca_poll->sens_res =3D __le16_to_cpu(*((__le16 *)data));
 	data +=3D 2;
+	data_len -=3D 2;
+
+	/* Check if we have enough data for nfcid1_len (1 byte) */
+	if (data_len < 1)
+		return ERR_PTR(-EINVAL);
=20
 	nfca_poll->nfcid1_len =3D min_t(__u8, *data++, NFC_NFCID1_MAXSIZE);
+	data_len--;
=20
 	pr_debug("sens_res 0x%x, nfcid1_len %d\n",
 		 nfca_poll->sens_res, nfca_poll->nfcid1_len);
=20
+	/* Check if we have enough data for nfcid1 */
+	if (data_len < nfca_poll->nfcid1_len)
+		return ERR_PTR(-EINVAL);
+
 	memcpy(nfca_poll->nfcid1, data, nfca_poll->nfcid1_len);
 	data +=3D nfca_poll->nfcid1_len;
+	data_len -=3D nfca_poll->nfcid1_len;
+
+	/* Check if we have enough data for sel_res_len (1 byte) */
+	if (data_len < 1)
+		return ERR_PTR(-EINVAL);
=20
 	nfca_poll->sel_res_len =3D *data++;
+	data_len--;
+
+	if (nfca_poll->sel_res_len !=3D 0) {
+		/* Check if we have enough data for sel_res (1 byte) */
+		if (data_len < 1)
+			return ERR_PTR(-EINVAL);
=20
-	if (nfca_poll->sel_res_len !=3D 0)
 		nfca_poll->sel_res =3D *data++;
+		data_len--;
+	}
=20
 	pr_debug("sel_res_len %d, sel_res 0x%x\n",
 		 nfca_poll->sel_res_len,
@@ -166,14 +196,24 @@ nci_extract_rf_params_nfca_passive_poll(struct nci_=
dev *ndev,
 static const __u8 *
 nci_extract_rf_params_nfcb_passive_poll(struct nci_dev *ndev,
 					struct rf_tech_specific_params_nfcb_poll *nfcb_poll,
-					const __u8 *data)
+					const __u8 *data, size_t data_len)
 {
+	/* Check if we have enough data for sensb_res_len (1 byte) */
+	if (data_len < 1)
+		return ERR_PTR(-EINVAL);
+
 	nfcb_poll->sensb_res_len =3D min_t(__u8, *data++, NFC_SENSB_RES_MAXSIZE=
);
+	data_len--;
=20
 	pr_debug("sensb_res_len %d\n", nfcb_poll->sensb_res_len);
=20
+	/* Check if we have enough data for sensb_res */
+	if (data_len < nfcb_poll->sensb_res_len)
+		return ERR_PTR(-EINVAL);
+
 	memcpy(nfcb_poll->sensb_res, data, nfcb_poll->sensb_res_len);
 	data +=3D nfcb_poll->sensb_res_len;
+	data_len -=3D nfcb_poll->sensb_res_len;
=20
 	return data;
 }
@@ -181,16 +221,32 @@ nci_extract_rf_params_nfcb_passive_poll(struct nci_=
dev *ndev,
 static const __u8 *
 nci_extract_rf_params_nfcf_passive_poll(struct nci_dev *ndev,
 					struct rf_tech_specific_params_nfcf_poll *nfcf_poll,
-					const __u8 *data)
+					const __u8 *data, size_t data_len)
 {
+	/* Check if we have enough data for bit_rate (1 byte) */
+	if (data_len < 1)
+		return ERR_PTR(-EINVAL);
+
 	nfcf_poll->bit_rate =3D *data++;
+	data_len--;
+
+	/* Check if we have enough data for sensf_res_len (1 byte) */
+	if (data_len < 1)
+		return ERR_PTR(-EINVAL);
+
 	nfcf_poll->sensf_res_len =3D min_t(__u8, *data++, NFC_SENSF_RES_MAXSIZE=
);
+	data_len--;
=20
 	pr_debug("bit_rate %d, sensf_res_len %d\n",
 		 nfcf_poll->bit_rate, nfcf_poll->sensf_res_len);
=20
+	/* Check if we have enough data for sensf_res */
+	if (data_len < nfcf_poll->sensf_res_len)
+		return ERR_PTR(-EINVAL);
+
 	memcpy(nfcf_poll->sensf_res, data, nfcf_poll->sensf_res_len);
 	data +=3D nfcf_poll->sensf_res_len;
+	data_len -=3D nfcf_poll->sensf_res_len;
=20
 	return data;
 }
@@ -198,24 +254,53 @@ nci_extract_rf_params_nfcf_passive_poll(struct nci_=
dev *ndev,
 static const __u8 *
 nci_extract_rf_params_nfcv_passive_poll(struct nci_dev *ndev,
 					struct rf_tech_specific_params_nfcv_poll *nfcv_poll,
-					const __u8 *data)
+					const __u8 *data, size_t data_len)
 {
+	/* Skip 1 byte (reserved) */
+	if (data_len < 1)
+		return ERR_PTR(-EINVAL);
+
 	++data;
+	data_len--;
+
+	/* Check if we have enough data for dsfid (1 byte) */
+	if (data_len < 1)
+		return ERR_PTR(-EINVAL);
+
 	nfcv_poll->dsfid =3D *data++;
+	data_len--;
+
+	/* Check if we have enough data for uid (8 bytes) */
+	if (data_len < NFC_ISO15693_UID_MAXSIZE)
+		return ERR_PTR(-EINVAL);
+
 	memcpy(nfcv_poll->uid, data, NFC_ISO15693_UID_MAXSIZE);
 	data +=3D NFC_ISO15693_UID_MAXSIZE;
+	data_len -=3D NFC_ISO15693_UID_MAXSIZE;
+
 	return data;
 }
=20
 static const __u8 *
 nci_extract_rf_params_nfcf_passive_listen(struct nci_dev *ndev,
 					  struct rf_tech_specific_params_nfcf_listen *nfcf_listen,
-					  const __u8 *data)
+					  const __u8 *data, size_t data_len)
 {
+	/* Check if we have enough data for local_nfcid2_len (1 byte) */
+	if (data_len < 1)
+		return ERR_PTR(-EINVAL);
+
 	nfcf_listen->local_nfcid2_len =3D min_t(__u8, *data++,
 					      NFC_NFCID2_MAXSIZE);
+	data_len--;
+
+	/* Check if we have enough data for local_nfcid2 */
+	if (data_len < nfcf_listen->local_nfcid2_len)
+		return ERR_PTR(-EINVAL);
+
 	memcpy(nfcf_listen->local_nfcid2, data, nfcf_listen->local_nfcid2_len);
 	data +=3D nfcf_listen->local_nfcid2_len;
+	data_len -=3D nfcf_listen->local_nfcid2_len;
=20
 	return data;
 }
@@ -364,7 +449,7 @@ static int nci_rf_discover_ntf_packet(struct nci_dev =
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
@@ -380,26 +465,42 @@ static int nci_rf_discover_ntf_packet(struct nci_de=
v *ndev,
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
 			data =3D nci_extract_rf_params_nfca_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfca_poll), data);
+				&(ntf.rf_tech_specific_params.nfca_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
 			break;
=20
 		case NCI_NFC_B_PASSIVE_POLL_MODE:
 			data =3D nci_extract_rf_params_nfcb_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfcb_poll), data);
+				&(ntf.rf_tech_specific_params.nfcb_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
 			break;
=20
 		case NCI_NFC_F_PASSIVE_POLL_MODE:
 			data =3D nci_extract_rf_params_nfcf_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfcf_poll), data);
+				&(ntf.rf_tech_specific_params.nfcf_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
 			break;
=20
 		case NCI_NFC_V_PASSIVE_POLL_MODE:
 			data =3D nci_extract_rf_params_nfcv_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfcv_poll), data);
+				&(ntf.rf_tech_specific_params.nfcv_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
 			break;
=20
 		default:
@@ -596,7 +697,7 @@ static int nci_rf_intf_activated_ntf_packet(struct nc=
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
@@ -628,26 +729,41 @@ static int nci_rf_intf_activated_ntf_packet(struct =
nci_dev *ndev,
 	if (ntf.rf_interface =3D=3D NCI_RF_INTERFACE_NFCEE_DIRECT)
 		goto listen;
=20
+	if (skb->len < (data - skb->data) + ntf.rf_tech_specific_params_len)
+		return -EINVAL;
+
 	if (ntf.rf_tech_specific_params_len > 0) {
 		switch (ntf.activation_rf_tech_and_mode) {
 		case NCI_NFC_A_PASSIVE_POLL_MODE:
 			data =3D nci_extract_rf_params_nfca_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfca_poll), data);
+				&(ntf.rf_tech_specific_params.nfca_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return -EINVAL;
 			break;
=20
 		case NCI_NFC_B_PASSIVE_POLL_MODE:
 			data =3D nci_extract_rf_params_nfcb_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfcb_poll), data);
+				&(ntf.rf_tech_specific_params.nfcb_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return -EINVAL;
 			break;
=20
 		case NCI_NFC_F_PASSIVE_POLL_MODE:
 			data =3D nci_extract_rf_params_nfcf_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfcf_poll), data);
+				&(ntf.rf_tech_specific_params.nfcf_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return -EINVAL;
 			break;
=20
 		case NCI_NFC_V_PASSIVE_POLL_MODE:
 			data =3D nci_extract_rf_params_nfcv_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfcv_poll), data);
+				&(ntf.rf_tech_specific_params.nfcv_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return -EINVAL;
 			break;
=20
 		case NCI_NFC_A_PASSIVE_LISTEN_MODE:
@@ -657,7 +773,9 @@ static int nci_rf_intf_activated_ntf_packet(struct nc=
i_dev *ndev,
 		case NCI_NFC_F_PASSIVE_LISTEN_MODE:
 			data =3D nci_extract_rf_params_nfcf_passive_listen(ndev,
 				&(ntf.rf_tech_specific_params.nfcf_listen),
-				data);
+				data, ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return -EINVAL;
 			break;
=20
 		default:
@@ -668,6 +786,13 @@ static int nci_rf_intf_activated_ntf_packet(struct n=
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
@@ -679,6 +804,9 @@ static int nci_rf_intf_activated_ntf_packet(struct nc=
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


