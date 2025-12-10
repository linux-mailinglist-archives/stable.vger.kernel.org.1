Return-Path: <stable+bounces-200689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B32CB25FC
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 09:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 25F96302CC94
	for <lists+stable@lfdr.de>; Wed, 10 Dec 2025 08:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657CA27C866;
	Wed, 10 Dec 2025 08:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b="ICMDKnU8"
X-Original-To: stable@vger.kernel.org
Received: from gw.hale.at (gw.hale.at [89.26.116.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1DD3B8D6A;
	Wed, 10 Dec 2025 08:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.26.116.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765354595; cv=none; b=egyNmJuZp3S8VjBXzrYNd1g6R7TnNXBmjIH8mZAlo+js/70EeZxcphb/AeNoCYcPk1lvRLtx9Ml0nySqIe32dT0DzdOuVWLgvAlrcST5XHT0lHyaTiL1LL533d4KWVpNsKMb5fLlX9+IVo7y7muXnaZfxgPVAWaXflXZfOpQPvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765354595; c=relaxed/simple;
	bh=ZsmqiADQt0pzuhEybWFRe2+Z/cW03ilikPhPOMX3Rbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TGv2UmRuQM+0XMvnTh9SKbSSFTAPsFhHO6lpZgPbXnr5p9XbYo4zER3boHFuatbUGC6Qm5v+7KfE7ebgmnIISMpflSpS7c+8ZOqf2shcExMHU4q5nOUK24zDFfbdDubUTEDNQ4Ilv5BPHP4UWJyVWV74Z2dWfNj6f+LMbz6fMlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at; spf=pass smtp.mailfrom=hale.at; dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b=ICMDKnU8; arc=none smtp.client-ip=89.26.116.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hale.at
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=hale.at; i=@hale.at; q=dns/txt; s=mail;
  t=1765354593; x=1796890593;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZsmqiADQt0pzuhEybWFRe2+Z/cW03ilikPhPOMX3Rbg=;
  b=ICMDKnU8PIy84Qau+joHySnLjLZAyETeaxdV3U+b2PT/So3DCfXi7fCL
   JBHwiPESw9TUE5p6vdaxUVv2b4GBE5wOG/uDOnQ5QjDMZfmjRmzdPL6aR
   Q0Bt7UTKrYMnDGJGL8dORHXxfupLPtygP/Py9dNV1Nmu47t/Y7uLmQcXf
   6r3TmrF4GyhgAiEywovhJ6O71ZZgQXNiYYFY7EGgAE7Im+d16kXIIor0h
   m9lOFP0ZVQ2R5pxRJLI4om1aJHt+xbQyPw6NFu+86IsTnyTuXOkq/ORyq
   nR4sOdbTxYlTX8osK6lslvjQ7F3BGpScyVeBA73yjJdphsQt0KKQxVRbe
   A==;
X-CSE-ConnectionGUID: kWDB6ak1SB2KKbxM0/Ne3Q==
X-CSE-MsgGUID: 7S80rsPBQ3uFoWKWTNRdGw==
IronPort-SDR: 69392c5e_VuZGNkkZd+YKzU6fk4RLtG3V2QslQOO4Iqwhwm1+wWzcw1E
 CJkO8P8M4u4OJWTO37LPeyULGydtJOl4ldwqigA==
X-IronPort-AV: E=Sophos;i="6.20,263,1758578400"; 
   d="scan'208";a="1478371"
Received: from unknown (HELO mail4.hale.at) ([192.168.100.5])
  by mgmt.hale.at with ESMTP; 10 Dec 2025 09:16:31 +0100
Received: from mail4.hale.at (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTPS id D1D70130075A;
	Wed, 10 Dec 2025 09:16:10 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTP id BA311130076A;
	Wed, 10 Dec 2025 09:16:10 +0100 (CET)
X-Virus-Scanned: amavis at mail4.hale.at
Received: from mail4.hale.at ([127.0.0.1])
 by localhost (mail4.hale.at [127.0.0.1]) (amavis, port 10026) with ESMTP
 id hdFGQtDLzFOl; Wed, 10 Dec 2025 09:16:10 +0100 (CET)
Received: from entw47.HALE.at (entw47 [192.168.100.117])
	by mail4.hale.at (Postfix) with ESMTPSA id A4D70130075A;
	Wed, 10 Dec 2025 09:16:10 +0100 (CET)
From: Michael Thalmeier <michael.thalmeier@hale.at>
To: Deepak Sharma <deepak.sharma.472935@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Michael Thalmeier <michael.thalmeier@hale.at>,
	stable@vger.kernel.org
Subject: [PATCH v2] net: nfc: nci: Fix parameter validation for packet data
Date: Wed, 10 Dec 2025 09:16:05 +0100
Message-ID: <20251210081605.3855663-1-michael.thalmeier@hale.at>
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

For these cases it is only possible to check for minimum packet length.

Fixes: 9c328f54741b ("net: nfc: nci: Add parameter validation for packet =
data")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
---
Changes in v2:
- Reference correct commit hash

---
 net/nfc/nci/ntf.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index 418b84e2b260..5161e94f067f 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -58,7 +58,8 @@ static int nci_core_conn_credits_ntf_packet(struct nci_=
dev *ndev,
 	struct nci_conn_info *conn_info;
 	int i;
=20
-	if (skb->len < sizeof(struct nci_core_conn_credit_ntf))
+	/* Minimal packet size for num_entries=3D1 is 1 x __u8 + 1 x conn_credi=
t_entry */
+	if (skb->len < (sizeof(__u8) + sizeof(struct conn_credit_entry)))
 		return -EINVAL;
=20
 	ntf =3D (struct nci_core_conn_credit_ntf *)skb->data;
@@ -364,7 +365,8 @@ static int nci_rf_discover_ntf_packet(struct nci_dev =
*ndev,
 	const __u8 *data;
 	bool add_target =3D true;
=20
-	if (skb->len < sizeof(struct nci_rf_discover_ntf))
+	/* Minimal packet size is 5 if rf_tech_specific_params_len=3D0 */
+	if (skb->len < (5 * sizeof(__u8)))
 		return -EINVAL;
=20
 	data =3D skb->data;
@@ -596,7 +598,10 @@ static int nci_rf_intf_activated_ntf_packet(struct n=
ci_dev *ndev,
 	const __u8 *data;
 	int err =3D NCI_STATUS_OK;
=20
-	if (skb->len < sizeof(struct nci_rf_intf_activated_ntf))
+	/* Minimal packet size is 11 if
+	 * f_tech_specific_params_len=3D0 and activation_params_len=3D0
+	 */
+	if (skb->len < (11 * sizeof(__u8)))
 		return -EINVAL;
=20
 	data =3D skb->data;
--=20
2.52.0


