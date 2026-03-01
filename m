Return-Path: <stable+bounces-222214-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH48GTmto2kmJwUAu9opvQ
	(envelope-from <stable+bounces-222214-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:06:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A143E1CE371
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C11031C6926
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 01:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C2D2F3C19;
	Sun,  1 Mar 2026 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW5u+Hw2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C34E76026;
	Sun,  1 Mar 2026 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772330323; cv=none; b=hKxRaWoTzeklGdVf+nuHy+zbfgbvY4g2M1Kuz7V059A4d99nlY5qr13nJuNzfR4a4tRgmidCEvm3u9eVjjULniCoGoM6lwqRv6q5e72i2wJQjfjUMUB7/RC6XN10sRhML16jD1hfZAu+JzEhlDWMCl5WVZx9n+Z5wZBwOBupHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772330323; c=relaxed/simple;
	bh=cm+dF9JVPy9JTO7eIEGwUr7kCxDnM/qZ7sf0ISCb+CQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nyen1CiKUxlmaNg0clGxSNey5nfRBNDd5RRX8Y44bsly16tclJvJaurwHExHCTZBFmH05UU/sdqfTBn6I4uqaGsJPyJGAy0RrI/UMmGFtjx7C7soWHV0uEHcR5ID9cGdKK3pv+9RrfGQ94cs6bgnXn0QwG/HPLHZKPMsBkZUiAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW5u+Hw2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C0AC19421;
	Sun,  1 Mar 2026 01:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772330322;
	bh=cm+dF9JVPy9JTO7eIEGwUr7kCxDnM/qZ7sf0ISCb+CQ=;
	h=From:To:Cc:Subject:Date:From;
	b=ZW5u+Hw203lvg4NM8xxNfqjwpu5ad6qH2ykF0Ar3wWwwWXSlLg1RhQuRcS66CIgkT
	 9uZEMNai10ld1jMyLLQ0f54ZqhXumPW2ELVLXti2eY3BeVDJ5ZFdDZXMbEW6XS3V4i
	 4iAWBiZQ8L+t0eaoGvm9aRwo/H1FbnU6nrTASff5raD5tvuMk8+glgNYreIhidn2Sx
	 dWwooPOF/YiI6IdjTF/X5KoE5Ao0pyfDcXi74qKvKdD8Sc+28X9/3dbaEJvCjAet6l
	 2GLt3wKaynYDB7IiO9uHQGnFazoC7TxyAm50OdGLOBfT4q6apj7IHUfNe4Xz2/hqOP
	 4uYNgzwGTvGiQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	michael.thalmeier@hale.at
Cc: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Subject: FAILED: Patch "net: nfc: nci: Fix parameter validation for packet data" failed to apply to 5.15-stable tree
Date: Sat, 28 Feb 2026 20:58:40 -0500
Message-ID: <20260301015841.1724246-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-222214-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.978];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,740e04c2a93467a0f8c8];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email]
X-Rspamd-Queue-Id: A143E1CE371
X-Rspamd-Action: no action

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 571dcbeb8e635182bb825ae758399831805693c2 Mon Sep 17 00:00:00 2001
From: Michael Thalmeier <michael.thalmeier@hale.at>
Date: Wed, 18 Feb 2026 09:30:00 +0100
Subject: [PATCH] net: nfc: nci: Fix parameter validation for packet data

Since commit 9c328f54741b ("net: nfc: nci: Add parameter validation for
packet data") communication with nci nfc chips is not working any more.

The mentioned commit tries to fix access of uninitialized data, but
failed to understand that in some cases the data packet is of variable
length and can therefore not be compared to the maximum packet length
given by the sizeof(struct).

Fixes: 9c328f54741b ("net: nfc: nci: Add parameter validation for packet data")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
Reported-by: syzbot+740e04c2a93467a0f8c8@syzkaller.appspotmail.com
Link: https://patch.msgid.link/20260218083000.301354-1-michael.thalmeier@hale.at
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/nfc/nci/ntf.c | 159 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 141 insertions(+), 18 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 418b84e2b2605..c96512bb86531 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -58,7 +58,7 @@ static int nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
 	struct nci_conn_info *conn_info;
 	int i;
 
-	if (skb->len < sizeof(struct nci_core_conn_credit_ntf))
+	if (skb->len < offsetofend(struct nci_core_conn_credit_ntf, num_entries))
 		return -EINVAL;
 
 	ntf = (struct nci_core_conn_credit_ntf *)skb->data;
@@ -68,6 +68,10 @@ static int nci_core_conn_credits_ntf_packet(struct nci_dev *ndev,
 	if (ntf->num_entries > NCI_MAX_NUM_CONN)
 		ntf->num_entries = NCI_MAX_NUM_CONN;
 
+	if (skb->len < offsetofend(struct nci_core_conn_credit_ntf, num_entries) +
+			ntf->num_entries * sizeof(struct conn_credit_entry))
+		return -EINVAL;
+
 	/* update the credits */
 	for (i = 0; i < ntf->num_entries; i++) {
 		ntf->conn_entries[i].conn_id =
@@ -138,23 +142,48 @@ static int nci_core_conn_intf_error_ntf_packet(struct nci_dev *ndev,
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
 	nfca_poll->sens_res = __le16_to_cpu(*((__le16 *)data));
 	data += 2;
+	data_len -= 2;
+
+	/* Check if we have enough data for nfcid1_len (1 byte) */
+	if (data_len < 1)
+		return ERR_PTR(-EINVAL);
 
 	nfca_poll->nfcid1_len = min_t(__u8, *data++, NFC_NFCID1_MAXSIZE);
+	data_len--;
 
 	pr_debug("sens_res 0x%x, nfcid1_len %d\n",
 		 nfca_poll->sens_res, nfca_poll->nfcid1_len);
 
+	/* Check if we have enough data for nfcid1 */
+	if (data_len < nfca_poll->nfcid1_len)
+		return ERR_PTR(-EINVAL);
+
 	memcpy(nfca_poll->nfcid1, data, nfca_poll->nfcid1_len);
 	data += nfca_poll->nfcid1_len;
+	data_len -= nfca_poll->nfcid1_len;
+
+	/* Check if we have enough data for sel_res_len (1 byte) */
+	if (data_len < 1)
+		return ERR_PTR(-EINVAL);
 
 	nfca_poll->sel_res_len = *data++;
+	data_len--;
+
+	if (nfca_poll->sel_res_len != 0) {
+		/* Check if we have enough data for sel_res (1 byte) */
+		if (data_len < 1)
+			return ERR_PTR(-EINVAL);
 
-	if (nfca_poll->sel_res_len != 0)
 		nfca_poll->sel_res = *data++;
+	}
 
 	pr_debug("sel_res_len %d, sel_res 0x%x\n",
 		 nfca_poll->sel_res_len,
@@ -166,12 +195,21 @@ nci_extract_rf_params_nfca_passive_poll(struct nci_dev *ndev,
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
 	nfcb_poll->sensb_res_len = min_t(__u8, *data++, NFC_SENSB_RES_MAXSIZE);
+	data_len--;
 
 	pr_debug("sensb_res_len %d\n", nfcb_poll->sensb_res_len);
 
+	/* Check if we have enough data for sensb_res */
+	if (data_len < nfcb_poll->sensb_res_len)
+		return ERR_PTR(-EINVAL);
+
 	memcpy(nfcb_poll->sensb_res, data, nfcb_poll->sensb_res_len);
 	data += nfcb_poll->sensb_res_len;
 
@@ -181,14 +219,29 @@ nci_extract_rf_params_nfcb_passive_poll(struct nci_dev *ndev,
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
 	nfcf_poll->bit_rate = *data++;
+	data_len--;
+
+	/* Check if we have enough data for sensf_res_len (1 byte) */
+	if (data_len < 1)
+		return ERR_PTR(-EINVAL);
+
 	nfcf_poll->sensf_res_len = min_t(__u8, *data++, NFC_SENSF_RES_MAXSIZE);
+	data_len--;
 
 	pr_debug("bit_rate %d, sensf_res_len %d\n",
 		 nfcf_poll->bit_rate, nfcf_poll->sensf_res_len);
 
+	/* Check if we have enough data for sensf_res */
+	if (data_len < nfcf_poll->sensf_res_len)
+		return ERR_PTR(-EINVAL);
+
 	memcpy(nfcf_poll->sensf_res, data, nfcf_poll->sensf_res_len);
 	data += nfcf_poll->sensf_res_len;
 
@@ -198,22 +251,49 @@ nci_extract_rf_params_nfcf_passive_poll(struct nci_dev *ndev,
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
 	nfcv_poll->dsfid = *data++;
+	data_len--;
+
+	/* Check if we have enough data for uid (8 bytes) */
+	if (data_len < NFC_ISO15693_UID_MAXSIZE)
+		return ERR_PTR(-EINVAL);
+
 	memcpy(nfcv_poll->uid, data, NFC_ISO15693_UID_MAXSIZE);
 	data += NFC_ISO15693_UID_MAXSIZE;
+
 	return data;
 }
 
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
 	nfcf_listen->local_nfcid2_len = min_t(__u8, *data++,
 					      NFC_NFCID2_MAXSIZE);
+	data_len--;
+
+	/* Check if we have enough data for local_nfcid2 */
+	if (data_len < nfcf_listen->local_nfcid2_len)
+		return ERR_PTR(-EINVAL);
+
 	memcpy(nfcf_listen->local_nfcid2, data, nfcf_listen->local_nfcid2_len);
 	data += nfcf_listen->local_nfcid2_len;
 
@@ -364,7 +444,7 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 	const __u8 *data;
 	bool add_target = true;
 
-	if (skb->len < sizeof(struct nci_rf_discover_ntf))
+	if (skb->len < offsetofend(struct nci_rf_discover_ntf, rf_tech_specific_params_len))
 		return -EINVAL;
 
 	data = skb->data;
@@ -380,26 +460,42 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 	pr_debug("rf_tech_specific_params_len %d\n",
 		 ntf.rf_tech_specific_params_len);
 
+	if (skb->len < (data - skb->data) +
+			ntf.rf_tech_specific_params_len + sizeof(ntf.ntf_type))
+		return -EINVAL;
+
 	if (ntf.rf_tech_specific_params_len > 0) {
 		switch (ntf.rf_tech_and_mode) {
 		case NCI_NFC_A_PASSIVE_POLL_MODE:
 			data = nci_extract_rf_params_nfca_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfca_poll), data);
+				&(ntf.rf_tech_specific_params.nfca_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
 			break;
 
 		case NCI_NFC_B_PASSIVE_POLL_MODE:
 			data = nci_extract_rf_params_nfcb_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfcb_poll), data);
+				&(ntf.rf_tech_specific_params.nfcb_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
 			break;
 
 		case NCI_NFC_F_PASSIVE_POLL_MODE:
 			data = nci_extract_rf_params_nfcf_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfcf_poll), data);
+				&(ntf.rf_tech_specific_params.nfcf_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
 			break;
 
 		case NCI_NFC_V_PASSIVE_POLL_MODE:
 			data = nci_extract_rf_params_nfcv_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfcv_poll), data);
+				&(ntf.rf_tech_specific_params.nfcv_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
 			break;
 
 		default:
@@ -596,7 +692,7 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 	const __u8 *data;
 	int err = NCI_STATUS_OK;
 
-	if (skb->len < sizeof(struct nci_rf_intf_activated_ntf))
+	if (skb->len < offsetofend(struct nci_rf_intf_activated_ntf, rf_tech_specific_params_len))
 		return -EINVAL;
 
 	data = skb->data;
@@ -628,26 +724,41 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 	if (ntf.rf_interface == NCI_RF_INTERFACE_NFCEE_DIRECT)
 		goto listen;
 
+	if (skb->len < (data - skb->data) + ntf.rf_tech_specific_params_len)
+		return -EINVAL;
+
 	if (ntf.rf_tech_specific_params_len > 0) {
 		switch (ntf.activation_rf_tech_and_mode) {
 		case NCI_NFC_A_PASSIVE_POLL_MODE:
 			data = nci_extract_rf_params_nfca_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfca_poll), data);
+				&(ntf.rf_tech_specific_params.nfca_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return -EINVAL;
 			break;
 
 		case NCI_NFC_B_PASSIVE_POLL_MODE:
 			data = nci_extract_rf_params_nfcb_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfcb_poll), data);
+				&(ntf.rf_tech_specific_params.nfcb_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return -EINVAL;
 			break;
 
 		case NCI_NFC_F_PASSIVE_POLL_MODE:
 			data = nci_extract_rf_params_nfcf_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfcf_poll), data);
+				&(ntf.rf_tech_specific_params.nfcf_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return -EINVAL;
 			break;
 
 		case NCI_NFC_V_PASSIVE_POLL_MODE:
 			data = nci_extract_rf_params_nfcv_passive_poll(ndev,
-				&(ntf.rf_tech_specific_params.nfcv_poll), data);
+				&(ntf.rf_tech_specific_params.nfcv_poll), data,
+				ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return -EINVAL;
 			break;
 
 		case NCI_NFC_A_PASSIVE_LISTEN_MODE:
@@ -657,7 +768,9 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 		case NCI_NFC_F_PASSIVE_LISTEN_MODE:
 			data = nci_extract_rf_params_nfcf_passive_listen(ndev,
 				&(ntf.rf_tech_specific_params.nfcf_listen),
-				data);
+				data, ntf.rf_tech_specific_params_len);
+			if (IS_ERR(data))
+				return -EINVAL;
 			break;
 
 		default:
@@ -668,6 +781,13 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 		}
 	}
 
+	if (skb->len < (data - skb->data) +
+			sizeof(ntf.data_exch_rf_tech_and_mode) +
+			sizeof(ntf.data_exch_tx_bit_rate) +
+			sizeof(ntf.data_exch_rx_bit_rate) +
+			sizeof(ntf.activation_params_len))
+		return -EINVAL;
+
 	ntf.data_exch_rf_tech_and_mode = *data++;
 	ntf.data_exch_tx_bit_rate = *data++;
 	ntf.data_exch_rx_bit_rate = *data++;
@@ -679,6 +799,9 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 	pr_debug("data_exch_rx_bit_rate 0x%x\n", ntf.data_exch_rx_bit_rate);
 	pr_debug("activation_params_len %d\n", ntf.activation_params_len);
 
+	if (skb->len < (data - skb->data) + ntf.activation_params_len)
+		return -EINVAL;
+
 	if (ntf.activation_params_len > 0) {
 		switch (ntf.rf_interface) {
 		case NCI_RF_INTERFACE_ISO_DEP:
-- 
2.51.0





