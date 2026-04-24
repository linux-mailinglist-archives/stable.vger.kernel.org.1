Return-Path: <stable+bounces-241017-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCf7MFCw62mRQQAAu9opvQ
	(envelope-from <stable+bounces-241017-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:02:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFAD462391
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC227300F116
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E0A3E717F;
	Fri, 24 Apr 2026 18:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="gb2AXoBU"
X-Original-To: stable@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster4-host10-snip4-7.eps.apple.com [57.103.74.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36BF3E8C40
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 18:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053752; cv=none; b=d//fSycUI0+bdWjothYmdz+RdEMIJPfVXD/H9ZQlrA/j110G/pIuSSpevAol/vWKp44k6rNUqjtEFEbFWJvPtiiNGrhFBYzrzKW6wG0gdTpogjeo6M3k4rvUYYGJhDs8YNYhdZsMEJGT0XS0WYTQkoZNc9+bjHiMKNu85GNE9cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053752; c=relaxed/simple;
	bh=v/CglMceXSXp5uyPFwubo4d2OH7KIKxHBEdJD0JeRh4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DOIJmq9B2fg2oy3lPtb/9by9IDdvty4X0IzqVqnN7yBd96vXPF0TYWnHzs7n1tWFAaXC/jEmwZAhH+E1w+5KOANuvWgnTzQwyulRHm5TSlMrXtHFSglDUXpNhH/C3+LvemEU3PnwukH5chELP2WSKjuC0bQx527qHDJTw4PIYfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=gb2AXoBU; arc=none smtp.client-ip=57.103.74.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-10 (Postfix) with ESMTPS id 77ACD1800E97;
	Fri, 24 Apr 2026 18:02:29 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVQORQNFF0sCTVIPDwNXF0QaWwpZFXkRUAFYHlZeWhdeTVEPDwNXF0QaWwpZFXkRUAFYHlZeWhdeTUUID0EJWFsIWwQPH0wMUQJCBVZeVAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEEVABWB5WXloXXk1aAlZNBUoDXwFbBkINSQtdBl4DXgpAA1UCXgVdC1VAA1gcRRxYE1YtXgheH0wcHQ5YBgxQTQFDCAoCURxWDVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777053751; x=1779645751; bh=HK6H+UEf86PKCh6va1EI1pCBbHE8Rs2TVCBuKrfndQA=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=gb2AXoBUbj++sQy+oblax9Vrugg9z/gya4+hh2WVwphRjPeokfAIH24tr4m0sUIjuT0ne/joRwiEtg4LxhJLME/d3VP3z4SAHpXzTfnk/YV9Bl7KRnfdWWHOw8kDs/IvGJXXGUY5s2MycfNXlIcvyG3mUDY6g+iP7bqqUtMGK5IbqHg5oIfjJDxDq7D4pY5URA+KG62py2gbH+dX1L7kGuP+tyl4eB3Cfnv2mhUqfgrYn57TX7DRAdCsrTCJeXFGk/r2NoSSzoJye5XmIO5J/ZXd38fTv77K7m3dMIrRjS4uAYklc/8GrMW0ELwiP1YgP+UtAYM6oG8hrdruh5EPaQ==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-10 (Postfix) with ESMTPSA id 1903A18000B5;
	Fri, 24 Apr 2026 18:02:26 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	krzk@kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
Subject: [PATCH net v4 1/5] nfc: nci: fix u8 underflow in nci_store_general_bytes_nfc_dep
Date: Fri, 24 Apr 2026 20:01:47 +0200
Message-ID: <20260424180151.3808557-2-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE3NSBTYWx0ZWRfXyjw0SXtyYncL
 cPbBkhgPHgN0tZv+ZATE6EybqPqYMTHEMBQ1Tn4pW/UB+L0C/NlR9yjWSpeO4jmW4hzKDj025UL
 J9i2Qy8duMTHR94rm15xAvIku2r+0jMuFN20OxBmHGcF2NmuVF7QzBtLWUvPx6lh69jmgMhgZEi
 A6+cYpIHyR0mcGx/9m/wBXmKn17OLxSs52wXuTmQrZwGrcz0eXwm/EM5nIlOjtCwmSPPorzyWmv
 jUBdRBSjAk3mI0eghhCGChE8J44qX05njplsxt+Df24mNbPtm4ku2BcobaANvOFjrIBZPGhus58
 7LwJlHuYAp2A0Ml42BrR6P033tfOTted7DbdGLJ2TotYMiRPjxnwxQGFmnkxe0=
X-Proofpoint-GUID: sdBLb7Jjkj95MF0htQ-Y1ixk_aaQ7Cfc
X-Authority-Info-Out: v=2.4 cv=S7PUAYsP c=1 sm=1 tr=0 ts=69ebb036
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=D1Ezx_vhIy9DZtWJ5osA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sdBLb7Jjkj95MF0htQ-Y1ixk_aaQ7Cfc
X-Rspamd-Queue-Id: 6FFAD462391
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.49 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[icloud.com:+];
	TAGGED_FROM(0.00)[bounces-241017-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,icloud.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[icloud.com]

nci_store_general_bytes_nfc_dep() computes the General Bytes length by
subtracting a fixed header offset from the peer-supplied atr_res_len
(POLL) or atr_req_len (LISTEN) field:

    ndev->remote_gb_len = min_t(__u8,
        atr_res_len - NFC_ATR_RES_GT_OFFSET,   /* offset = 15 */
        NFC_ATR_RES_GB_MAXSIZE);

Both length fields are __u8.  When a malicious NFC-DEP peer sends an
ATR_RES/ATR_REQ whose length is smaller than the fixed offset (< 15
or < 14 respectively), the subtraction wraps:

    atr_res_len = 0  ->  (u8)(0 - 15) = 241
    min_t(__u8, 241, NFC_ATR_RES_GB_MAXSIZE=47) = 47

The subsequent memcpy then reads 47 bytes beyond the valid activation
parameter data into ndev->remote_gb[].  This buffer is later fed to
nfc_llcp_parse_gb_tlv() as a TLV array.

Reject the frame with NCI_STATUS_RF_PROTOCOL_ERROR when the length is
below the required offset.  The existing caller already logs and
continues for other helpers that return a non-OK status from this
switch, so no change is required on the caller side.

Fixes: 767f19ae698e ("NFC: Implement NCI dep_link_up and dep_link_down")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
---
 net/nfc/nci/ntf.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb8653..c2352eaa009f 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -631,6 +631,9 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
+		if (ntf->activation_params.poll_nfc_dep.atr_res_len <
+		    NFC_ATR_RES_GT_OFFSET)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.poll_nfc_dep.atr_res_len
 						- NFC_ATR_RES_GT_OFFSET),
@@ -643,6 +646,9 @@ static int nci_store_general_bytes_nfc_dep(struct nci_dev *ndev,
 
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
+		if (ntf->activation_params.listen_nfc_dep.atr_req_len <
+		    NFC_ATR_REQ_GT_OFFSET)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		ndev->remote_gb_len = min_t(__u8,
 			(ntf->activation_params.listen_nfc_dep.atr_req_len
 						- NFC_ATR_REQ_GT_OFFSET),
-- 
2.51.0


