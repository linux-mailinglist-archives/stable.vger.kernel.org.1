Return-Path: <stable+bounces-237984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPn2BpPP3ml0IgAAu9opvQ
	(envelope-from <stable+bounces-237984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:36:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 235153FF118
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07FAB302E724
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A71873CBE6F;
	Tue, 14 Apr 2026 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Jut9te/4"
X-Original-To: stable@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster5-host12-snip4-1.eps.apple.com [57.103.72.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12373BB9E0
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 23:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209772; cv=none; b=dE5zEGk0mqPfT60JvDdtbVM7B9e05R9a4S641y/MLqad+ZsGnwE+tsCqqOYUKXWj2hSdRaiI89QO4f77rMOmtWxVySXaCppNM+QcMuGMsLnFHV6WZrEczv+CLTvrL/bx7KcfRj91XlogFO5s9MmBlMuT6s1cBSqcLqOzAuYsoSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209772; c=relaxed/simple;
	bh=ofkxzTgQBnEjAtR64hZW8DsshN9NNFn9W8ss/32ljgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=twVmfhgJ1YZhpqxF3j5xPGLr6WdAXWUzzT1QBZ6+7/jbFSrRMAxJmKyEwkuaiDOv4vnbgaVoT6H1tt9+exH8vEyBg/a8LrXvaEPgWqqvoIUIJ1PJ+3+9fs5bjupCD3EdKoQ4RCCKCZR5U6odlG8FAH0cCkSLKirWJ+8SImxS2TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Jut9te/4; arc=none smtp.client-ip=57.103.72.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPS id E445C18000D2;
	Tue, 14 Apr 2026 23:36:08 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1776209770; x=1778801770; bh=zesyeUxXB65frhdA/SU7inZ1zXlKHJ858b3cIrqXvd4=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=Jut9te/4iVgKutctSAVSFWywH3SuhT/oEajXDiqeqixokljFWzPLjFmo2tmpjoNSuJtuU8/xnLrBhYie2sb/NnECndmOjE6HTYxnu+tAlAVxic0wkMFJ1x8q9AO28XJggNWxYJOPVmW6WvoAewTOPqSmJOggVp+PXYbVrPo+dw2GGXdkzEziyM7/FpHuv9cbylAaUfEMGfHUZqiTofIpBxdczj0SreTooZqIR4QC1FI3ORc5EZ+TEJ1AYUhE269nNTJbMqVeNT7RTirhvsY0qkCKCX4iZk9bCgZ6z9dnscVarjdIkky22aShPjWEwCEAsx5nwuHCTjH12ffL3uDuWw==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPSA id A3E0918002A3;
	Tue, 14 Apr 2026 23:36:06 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <framemain@outlook.com>
Subject: [PATCH net v3 1/4] nfc: nci: fix u8 underflow in nci_store_general_bytes_nfc_dep
Date: Wed, 15 Apr 2026 01:35:30 +0200
Message-ID: <20260414233534.55973-2-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5wEmxLNTcG7tIsS-lq5-REprOMEKc9sw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDIyMSBTYWx0ZWRfX+LJJqx5tj0Dn
 GOaWX5MEKaeGUPuJRFgjj4OhcYU7fctpW1sTPwvAYta1Zkd8QiJLL15IChNQfhXIqCdgiFCyJS0
 FZIyHKKOA3cnjOGX4hy27GST8fIlB4ZqUFh7p+Croe0CZQgDZdy9K/MWyodZG5sNrVytu+pHr7u
 UlGIZbCAIbjjk7Dbp4wd+F/qDJoKFrmbKMzrXSgbultJn4rD00Rym4+o+LW4con+NcCWqrAnH6Q
 ExX1GigOCc7R8pmGr9pffz7P7f3N2k2y5rhyT3eq9+1pGxlXb26udTFUJ+6WpoBjJY0Zifr3lhe
 oflKMPW4fIbd8Ukpti8SiLuiZyxcYUQqWOUpXx+VtO50/9ktt5kZcdfeA1SYm4=
X-Authority-Info-Out: v=2.4 cv=KKBXzVFo c=1 sm=1 tr=0 ts=69decf69
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=vBVpjAaxRTdfT_h5DWkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 5wEmxLNTcG7tIsS-lq5-REprOMEKc9sw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604140221
X-Spamd-Result: default: False [-0.49 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.67)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,outlook.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237984-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[icloud.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: 235153FF118
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lekë Hapçiu <framemain@outlook.com>

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
below the required offset, and propagate the error out of
nci_rf_intf_activated_ntf_packet() instead of silently accepting the
malformed packet.

Reachable from any NFC peer within ~4 cm during RF activation, prior
to any pairing.

Fixes: c4fbb6515709 ("NFC: NCI: Add NFC-DEP support to NCI data exchange")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
---
 net/nfc/nci/ntf.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb8..eb8c6e5a1 100644
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
@@ -842,8 +848,10 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 		/* store general bytes to be reported later in dep_link_up */
 		if (ntf.rf_interface == NCI_RF_INTERFACE_NFC_DEP) {
 			err = nci_store_general_bytes_nfc_dep(ndev, &ntf);
-			if (err != NCI_STATUS_OK)
+			if (err != NCI_STATUS_OK) {
 				pr_err("unable to store general bytes\n");
+				return -EINVAL;
+			}
 		}
 
 		/* store ATS to be reported later in nci_activate_target */
-- 
2.51.0


