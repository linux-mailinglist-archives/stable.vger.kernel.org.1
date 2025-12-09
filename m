Return-Path: <stable+bounces-200462-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB755CB00C3
	for <lists+stable@lfdr.de>; Tue, 09 Dec 2025 14:23:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CA983030D89
	for <lists+stable@lfdr.de>; Tue,  9 Dec 2025 13:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EE9328249;
	Tue,  9 Dec 2025 13:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b="jh16viRD"
X-Original-To: stable@vger.kernel.org
Received: from gw.hale.at (gw.hale.at [89.26.116.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A218819005E;
	Tue,  9 Dec 2025 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.26.116.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765286598; cv=none; b=abdjwR44uuvS1bvP+XEfx4uRoJfg8yLl0QvRrgPs61vEUAHK47rtOAfvQM/h0j/Kd7n6wnpznXqBpvWf8NluXd/6r/4bIJh9uw6jDUs6HE8kseJyVWVrRlb3ME4VZOTjUiIbyjT5JQtlffMgH/L4BYFvEhMpTav7Gd0OXVbPhEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765286598; c=relaxed/simple;
	bh=HCzKo2UWhyuJCYqj8TBsfFFHqIxpvvKOIjla3phcQ6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HyDFcr6PMQCARnyosa1ICxUEQAsCizqMvXhZaQFFAXz9sKWLXg62SMHbtVNbZd9X3VKVn9z7u2NtvyHSDvn8FS85QzPmFUWElT6KGyESv5zvI7TDYRBIJksZOO1jJt0mBDffmH0Bkwj0XKIMjqzCTgQzJdDyGi5/XmFlTf1o4Zo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at; spf=pass smtp.mailfrom=hale.at; dkim=pass (2048-bit key) header.d=hale.at header.i=@hale.at header.b=jh16viRD; arc=none smtp.client-ip=89.26.116.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hale.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hale.at
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=hale.at; i=@hale.at; q=dns/txt; s=mail;
  t=1765286594; x=1796822594;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HCzKo2UWhyuJCYqj8TBsfFFHqIxpvvKOIjla3phcQ6M=;
  b=jh16viRDGo99SV5pSuNc3PjDw2V36EmJ34y8otCUMmFFaMX71+5iSW3U
   tO1t2qF9PzwIJMinnHU2G3w85I0MgmNv5p1XX9Hn1+qCRgAj77x6/NwqM
   VGuT4KGyxJykxEGcQDL0GXDEy6y6vVDJY0gvxSZL9uYX1sJL2ekZfK+EI
   KVr1ly157GyJ+anMMl4zoFDSPLFsdH2wQsCrSO4vlSpf1xHZNvI0QHseD
   ZGBsrhBRwy7Fn0fhPyuFja63WZNNQKXZBnGJChdCigv7LKqBEmFv5TFbv
   tkQrkHY/rO/3Un50PlQq4YD68bgfLDtnFx2UkufBW8NNlacHmSIMAEQSR
   g==;
X-CSE-ConnectionGUID: KGueqkirSBiC/3C9NlgBEQ==
X-CSE-MsgGUID: eD78PgnZR96zMCF3/Qb+Ug==
IronPort-SDR: 69382263_3NtiH9HBNf9mH2ZwwHM14d08ogxzZpJE1rWfD5kQnACWmWy
 3Cn7qEn8m1CDUg/b4xj+rjqb0qCRc83kQ++uFkA==
X-IronPort-AV: E=Sophos;i="6.20,261,1758578400"; 
   d="scan'208";a="1474756"
Received: from unknown (HELO mail4.hale.at) ([192.168.100.5])
  by mgmt.hale.at with ESMTP; 09 Dec 2025 14:21:39 +0100
Received: from mail4.hale.at (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTPS id B64BE13005C4;
	Tue,  9 Dec 2025 14:21:19 +0100 (CET)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail4.hale.at (Postfix) with ESMTP id 9EBD513005DF;
	Tue,  9 Dec 2025 14:21:19 +0100 (CET)
X-Virus-Scanned: amavis at mail4.hale.at
Received: from mail4.hale.at ([127.0.0.1])
 by localhost (mail4.hale.at [127.0.0.1]) (amavis, port 10026) with ESMTP
 id Z2CyTqiBAzSF; Tue,  9 Dec 2025 14:21:19 +0100 (CET)
Received: from entw47.HALE.at (entw47 [192.168.100.117])
	by mail4.hale.at (Postfix) with ESMTPSA id 7FF6E13005C4;
	Tue,  9 Dec 2025 14:21:19 +0100 (CET)
From: Michael Thalmeier <michael.thalmeier@hale.at>
To: Deepak Sharma <deepak.sharma.472935@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Michael Thalmeier <michael.thalmeier@hale.at>,
	stable@vger.kernel.org
Subject: [PATCH] net: nfc: nci: Fix parameter validation for packet data
Date: Tue,  9 Dec 2025 14:21:03 +0100
Message-ID: <20251209132103.3736761-1-michael.thalmeier@hale.at>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Since commit 8fcc7315a10a ("net: nfc: nci: Add parameter validation for
packet data") communication with nci nfc chips is not working any more.

The mentioned commit tries to fix access of uninitialized data, but
failed to understand that in some cases the data packet is of variable
length and can therefore not be compared to the maximum packet length
given by the sizeof(struct).

For these cases it is only possible to check for minimum packet length.

Fixes: 8fcc7315a10a ("net: nfc: nci: Add parameter validation for packet =
data")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Thalmeier <michael.thalmeier@hale.at>
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


