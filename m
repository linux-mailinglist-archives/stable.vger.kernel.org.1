Return-Path: <stable+bounces-217233-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CP2fABl5lWl8RwIAu9opvQ
	(envelope-from <stable+bounces-217233-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 09:32:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D5C154181
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 09:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 35AFB301E9A8
	for <lists+stable@lfdr.de>; Wed, 18 Feb 2026 08:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F95318142;
	Wed, 18 Feb 2026 08:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b="A2XKqFtX"
X-Original-To: stable@vger.kernel.org
Received: from gw.hale.at (gw.hale.at [89.26.116.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A1019F13F;
	Wed, 18 Feb 2026 08:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.26.116.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771403535; cv=none; b=Hf5l6lIL2ywrXT6qrHVa/HQYJP1FeqIkKqG7AKgn0aS4SBZ8/KdqM7T+yc5agVNZpZLCSTSdluiieMClReN+qMj8GUSXVLC63jYUKf85ie+9dde1lDtQuPep9i6fvoCbfzxnJ1P7+mnIj++pV0l6EqbExVx5yX2FxQFYkQXVxW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771403535; c=relaxed/simple;
	bh=49YUch5onaQ2WHbr8c49jX9uAnaB39U/YdIX/4d77Pw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B957Q1RF1L9qt4ogZi8jTSstbA4njRwBVfvQHq938MxY7zsTbb9ZLlDtyvJWDNcJWCnCqtzq1fG4CKZazlP+ZvUSCusowRjSHaIGSbsf++iUvMt0YazRs2A/R3yWTNPflLWbJ0m0bLpSrzeb7OWFV24k/bfCQvYcMW6LZUUYQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at; spf=pass smtp.mailfrom=hale.at; dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b=A2XKqFtX; arc=none smtp.client-ip=89.26.116.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hale.at
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=hale.at; i=@hale.at; q=dns/txt; s=mail;
  t=1771403532; x=1802939532;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=49YUch5onaQ2WHbr8c49jX9uAnaB39U/YdIX/4d77Pw=;
  b=A2XKqFtXZqt1zbh5hGi9ug/KaMoEGI0YWN3TP6Zl8qYn0h0xY0mOjUVx
   v5q57Ldcbnk1vIxglvE79YcG6vYVnb13lt/6qxB2yuZStOnw+5mr7y8Gy
   hbqK+FZrky6i0fUXfhaFLGjNGqgbYM3Dfv6EIXxWB9GAGwHeSXwwsThTA
   eFxiqlutl+i90Zm9T8/7pa5ItAZ742Io3lAWaOPyczR6zLdNaQ3zIhPjm
   dCbIATX7wx1e13whvxuq3vZ/L2opb/g+kqvJ0AiPeOrfhL88a+Xcm4N3g
   I27HNq5JBojWZgWK5K2I8W8bG3kq8sZ73zjYB6XRFD0cGJZmdmZq4JSO6
   A==;
X-CSE-ConnectionGUID: VIJgaDgUTzOPWEd7J70KBw==
X-CSE-MsgGUID: Z/y1bBSrSSWL3T+LdVRSMg==
IronPort-SDR: 699578ad_WBwOGxo9+nSL8ugg8EEur8lQwg6mv1i648pWmhW7QhhU/Q4
 ExWoaOEXQCgusw8qw6Ch8B95uVhKIhM+3dlZ6Ew==
X-IronPort-AV: E=Sophos;i="6.21,297,1763420400"; 
   d="scan'208";a="1699743"
Received: from unknown (HELO mail4.hale.at) ([192.168.100.5])
  by mgmt.hale.at with ESMTP; 18 Feb 2026 09:30:37 +0100
Received: from mail4.hale.at (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTPS id 8F15513005BC;
	Wed, 18 Feb 2026 09:30:17 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTP id 774F81300712;
	Wed, 18 Feb 2026 09:30:17 +0100 (CET)
X-Virus-Scanned: amavis at mail4.hale.at
Received: from mail4.hale.at ([127.0.0.1])
 by localhost (mail4.hale.at [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 3tvIuPKNxwyW; Wed, 18 Feb 2026 09:30:17 +0100 (CET)
Received: from entw47.HALE.at (entw47 [192.168.100.117])
	by mail4.hale.at (Postfix) with ESMTPSA id 5E25713005BC;
	Wed, 18 Feb 2026 09:30:17 +0100 (CET)
From: Michael Thalmeier <michael.thalmeier@hale.at>
To: Deepak Sharma <deepak.sharma.472935@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"Lukas K ." <kernel@0x83.eu>,
	Michael Thalmeier <michael@thalmeier.at>,
	Michael Thalmeier <michael.thalmeier@hale.at>,
	stable@vger.kernel.org
Subject: [PATCH net v6] net: nfc: nci: Fix parameter validation for packet data
Date: Wed, 18 Feb 2026 09:30:00 +0100
Message-ID: <20260218083000.301354-1-michael.thalmeier@hale.at>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[hale.at,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[hale.at:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217233-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,linux.dev,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[hale.at:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.thalmeier@hale.at,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 76D5C154181
X-Rspamd-Action: no action

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
v6:
- use ssize_t for data_len parameter to guard against underflows
- omit unneeded data_len decrements at the end of the functions

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
 net/nfc/nci/ntf.c | 159 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 141 insertions(+), 18 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 418b84e2b260..c96512bb8653 100644
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
@@ -138,23 +142,48 @@ static int nci_core_conn_intf_error_ntf_packet(stru=
ct nci_dev *ndev,
 static const __u8 *
 nci_extract_rf_params_nfca_passive_poll(struct nci_dev *ndev,
 					struct rf_tech_specific_params_nfca_poll *nfca_poll,
-					const __u8 *data)
+					const __u8 *data, ssize_t data_len)
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
+	}
=20
 	pr_debug("sel_res_len %d, sel_res 0x%x\n",
 		 nfca_poll->sel_res_len,
@@ -166,12 +195,21 @@ nci_extract_rf_params_nfca_passive_poll(struct nci_=
dev *ndev,
 static const __u8 *
 nci_extract_rf_params_nfcb_passive_poll(struct nci_dev *ndev,
 					struct rf_tech_specific_params_nfcb_poll *nfcb_poll,
-					const __u8 *data)
+					const __u8 *data, ssize_t data_len)
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
=20
@@ -181,14 +219,29 @@ nci_extract_rf_params_nfcb_passive_poll(struct nci_=
dev *ndev,
 static const __u8 *
 nci_extract_rf_params_nfcf_passive_poll(struct nci_dev *ndev,
 					struct rf_tech_specific_params_nfcf_poll *nfcf_poll,
-					const __u8 *data)
+					const __u8 *data, ssize_t data_len)
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
=20
@@ -198,22 +251,49 @@ nci_extract_rf_params_nfcf_passive_poll(struct nci_=
dev *ndev,
 static const __u8 *
 nci_extract_rf_params_nfcv_passive_poll(struct nci_dev *ndev,
 					struct rf_tech_specific_params_nfcv_poll *nfcv_poll,
-					const __u8 *data)
+					const __u8 *data, ssize_t data_len)
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
+
 	return data;
 }
=20
 static const __u8 *
 nci_extract_rf_params_nfcf_passive_listen(struct nci_dev *ndev,
 					  struct rf_tech_specific_params_nfcf_listen *nfcf_listen,
-					  const __u8 *data)
+					  const __u8 *data, ssize_t data_len)
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
=20
@@ -364,7 +444,7 @@ static int nci_rf_discover_ntf_packet(struct nci_dev =
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
@@ -380,26 +460,42 @@ static int nci_rf_discover_ntf_packet(struct nci_de=
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
@@ -596,7 +692,7 @@ static int nci_rf_intf_activated_ntf_packet(struct nc=
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
@@ -628,26 +724,41 @@ static int nci_rf_intf_activated_ntf_packet(struct =
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
@@ -657,7 +768,9 @@ static int nci_rf_intf_activated_ntf_packet(struct nc=
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
@@ -668,6 +781,13 @@ static int nci_rf_intf_activated_ntf_packet(struct n=
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
@@ -679,6 +799,9 @@ static int nci_rf_intf_activated_ntf_packet(struct nc=
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
2.53.0


