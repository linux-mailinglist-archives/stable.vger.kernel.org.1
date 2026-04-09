Return-Path: <stable+bounces-235492-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHujF3z312mrVAgAu9opvQ
	(envelope-from <stable+bounces-235492-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:01:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 669B23CEEC1
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 720953008089
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 19:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FC9F30C63A;
	Thu,  9 Apr 2026 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="cn/lKCN/"
X-Original-To: stable@vger.kernel.org
Received: from outbound.pv.icloud.com (pv-2002f-snip4-3.eps.apple.com [57.103.64.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DFC29B78F
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 19:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761271; cv=none; b=FnOInnw9u43NhT1WKlACtbVznvx20qBXEZZJga3UAgPjrb8+O5KyNydKw1BLvVqcshnywquCIc1Nf8BQ598ZprqLY37OY9qBBrA3Qp5diNWzUVJLOxK4kWBunJOtOq8DiKtX+Ybi3kv4U+pPuAs0eP6TjMoxLCdFuU9P1BeI6LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761271; c=relaxed/simple;
	bh=WhQn1TLvWU9St4DjkQSJMyWRghH/FuKKWoY7mLcBaZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sL9lgvPk1R6VI4UQxUNz7nQYVt+jqErsX5H2S5oeWFDL+K6RUZW9i2+OgfW7nkCmiydj6Uo/dwz8/4wons6Z960JwqdLYb3H7baMfEwwqB/1M30HM/Ewm+eiJTGCkYQyvxuE9cHiRest5fKJS+RPtblQDMr44NHHBRkq+YN1drg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=cn/lKCN/; arc=none smtp.client-ip=57.103.64.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPS id B71991800959;
	Thu, 09 Apr 2026 19:00:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775761244; x=1778353244; bh=18rHgE4FglA26qFEIVxOeI4LQgCwxHIBAtnvSWPcjZY=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=cn/lKCN/1RsXcIAEU3qG/bX21efwKaDof4Lho2XlWWigNrl7UqJJo1VI+Wb/0bpluwoZrgEcIi9V2fo6x/bA274Gn/p1MZh2mNNiFx7aN2bt6LN0jKYKjINnOk0cBREbkrnn8YgpIV4GmZcIQKAg/YhUh3ktHUaJvneud5JjgbfGANatOHRqMysFo+NevQpnmnAHCnnA6VS1abIBZaA7IDnjYl1hM2mTJQwh6gK0UpX39xuDr8qWPRMRnTsJuomUeKKfIy+F0DQ8lVrjsvv9MSLsD2YA4eoOHb8ljl4Di5HbELIAV3QtLQ6bjBrqpcYOtyk5+8KOAI1l1jQIs2KJfg==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPSA id 4485B18000B2;
	Thu, 09 Apr 2026 19:00:40 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-nfc@lists.01.org,
	stable@vger.kernel.org,
	horms@kernel.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <framemain@outlook.com>
Subject: [PATCH net v2 1/3] nfc: nci: fix u8 underflow in nci_store_general_bytes_nfc_dep
Date: Thu,  9 Apr 2026 20:59:56 +0200
Message-ID: <20260409185958.1821242-2-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260409185958.1821242-1-snowwlake@icloud.com>
References: <20260409164129.GO469338@kernel.org>
 <20260409185958.1821242-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Biu2_1VQzktoXvwo8mm14jMhHIViS6PD
X-Authority-Info-Out: v=2.4 cv=BPa+bVQG c=1 sm=1 tr=0 ts=69d7f75b
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=P3KuyvigeCtTAzkl2O8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JKcXVnpmuwdQ7RL0mgk_:22 a=zesNzv29S0FE4YlguZl3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3NCBTYWx0ZWRfX6WUe6deqVUvB
 KY5yTXZozmXHbFuBkTsZt9xjZcZ87CIt88cTjb9+HogERkO031Nf3L4K7mvl1cBPtIKU8gjMrvP
 bwoQz9AhiZizcEPh/Uj2nYdkJWKtkkJn+ELSpuH2/+IAKMCtxaoGubGKuN1ZGkkbSC67tfT52l2
 XneckRBkc8kxuWFWiUBGzuikT2RJ+3rg6BA5RhiYX7B5YY/bq3W2fJ1evzaUbGY15sNNvIR3+Ly
 fp0MxLBoq8Ww7JycQ6teB2Tn2iXSTok4Y7ehCLs/szVPuJhCNB2IhkNbCOWDtL9UqCJYnEGBWQk
 6PCZIuRP8+/IWZIW8osMeSP/JMu5ShlrssfNZZ/CqpYiZx8pBjJCjvkEgvtca8=
X-Proofpoint-GUID: Biu2_1VQzktoXvwo8mm14jMhHIViS6PD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 adultscore=0 phishscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 bulkscore=0 mlxlogscore=936
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604090174
X-Spamd-Result: default: False [-0.49 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lists.01.org,vger.kernel.org,outlook.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235492-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[icloud.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,outlook.com:email,icloud.com:dkim,icloud.com:mid]
X-Rspamd-Queue-Id: 669B23CEEC1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lekë Hapçiu <framemain@outlook.com>

nci_store_general_bytes_nfc_dep() computes the number of General Bytes
to copy from an ATR_RES or ATR_REQ frame by subtracting a fixed header
offset from the peer-supplied length field:

  ndev->remote_gb_len = min_t(__u8,
      (atr_res_len - NFC_ATR_RES_GT_OFFSET),   /* offset = 15 */
      NFC_ATR_RES_GB_MAXSIZE);

Both length fields are __u8.  When a malicious NFC-DEP target (POLL mode)
or initiator (LISTEN mode) sends an ATR_RES/ATR_REQ whose length field is
smaller than the fixed offset (< 15 or < 14 respectively), the subtraction
wraps in unsigned u8 arithmetic:

  e.g. atr_res_len = 0 -> (u8)(0 - 15) = 241

min_t(__u8, 241, 47) then yields 47, so the subsequent memcpy reads
47 bytes from beyond the end of the valid activation parameter data into
ndev->remote_gb[].  This buffer is later passed to nfc_llcp_parse_gb_tlv()
as a TLV array, feeding directly into the TLV parser hardened by the
companion patch.

Fix: add an explicit lower-bound check on each length field before the
subtraction.  If the length is smaller than the required offset the frame
is malformed; leave remote_gb_len at zero and skip the memcpy.

Both the POLL (atr_res_len / NFC_ATR_RES_GT_OFFSET = 15) and the LISTEN
(atr_req_len / NFC_ATR_REQ_GT_OFFSET = 14) paths are affected; both are
fixed symmetrically.

Reachability: the ATR_RES is sent by an NFC-DEP target during RF
activation, before any authentication or pairing.  The bug is therefore
reachable from any NFC peer within ~4 cm.

Fixes: a99903ec4566 ("NFC: NCI: Handle Target mode activation")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
---
 net/nfc/nci/ntf.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb8..8eb295580 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -631,25 +631,31 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
+		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
+		    NFC_ATR_RES_GT_OFFSET)
+			break;
 		ndev->remote_gb_len = min_t(__u8,
-			(ntf->activation_params.poll_nfc_dep.atr_res_len
-						- NFC_ATR_RES_GT_OFFSET),
+			ntf->activation_params.poll_nfc_dep.atr_res_len
+						- NFC_ATR_RES_GT_OFFSET,
 			NFC_ATR_RES_GB_MAXSIZE);
 		memcpy(ndev->remote_gb,
-		       (ntf->activation_params.poll_nfc_dep.atr_res
-						+ NFC_ATR_RES_GT_OFFSET),
+		       ntf->activation_params.poll_nfc_dep.atr_res
+						+ NFC_ATR_RES_GT_OFFSET,
 		       ndev->remote_gb_len);
 		break;
 
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
+		if (ntf->activation_params.listen_nfc_dep.atr_req_len <
+		    NFC_ATR_REQ_GT_OFFSET)
+			break;
 		ndev->remote_gb_len = min_t(__u8,
-			(ntf->activation_params.listen_nfc_dep.atr_req_len
-						- NFC_ATR_REQ_GT_OFFSET),
+			ntf->activation_params.listen_nfc_dep.atr_req_len
+						- NFC_ATR_REQ_GT_OFFSET,
 			NFC_ATR_REQ_GB_MAXSIZE);
 		memcpy(ndev->remote_gb,
-		       (ntf->activation_params.listen_nfc_dep.atr_req
-						+ NFC_ATR_REQ_GT_OFFSET),
+		       ntf->activation_params.listen_nfc_dep.atr_req
+						+ NFC_ATR_REQ_GT_OFFSET,
 		       ndev->remote_gb_len);
 		break;
 
-- 
2.51.0


