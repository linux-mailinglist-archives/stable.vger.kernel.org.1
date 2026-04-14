Return-Path: <stable+bounces-237986-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKlFFtTP3ml0IgAAu9opvQ
	(envelope-from <stable+bounces-237986-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:37:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A5143FF13C
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 21EE730AC47F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED893CE49E;
	Tue, 14 Apr 2026 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="GBSgCzXm"
X-Original-To: stable@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster5-host4-snip4-10.eps.apple.com [57.103.72.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC73CCA12
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 23:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209778; cv=none; b=YqlDtcHIDiPlFlCcv2VhS6vB5HRWmkTuGIZTuKUAFGuAPG4u7JQKuee+Xs93QGMamB66eiBVdiYBI6/rB3w5WLYCndjLORsO2qDd9/4xPjisQ62zgjAkgez7wGdDebXnEd61EgKALSDAh1jGU42RXco7mswFNMEHvwh/fjopDCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209778; c=relaxed/simple;
	bh=NTH8L6A5uN9gDX01gingrIRSHGeCFE3LwsuD2j4G3tA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CJwNIoeHm3qmUmzL4rc9z+HsiFPRpyouBG1GdxvZpOVyvDYxzr1dn0KzJYlkczNVtG+rpnCL+UhZRKUzHy8oSpWoc6z+U+ETKqm6Jzj5qvzdJHwVpZxnbIJ+jRp4476cLfz5APIra6XdOJr34TOrLNTV8M9ju0aLQ1hol906mZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=GBSgCzXm; arc=none smtp.client-ip=57.103.72.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPS id A05661800287;
	Tue, 14 Apr 2026 23:36:13 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1776209775; x=1778801775; bh=f29yKHrwa9iIBPj34PwSjACiAVxDvnknzD1WoQR3FcU=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=GBSgCzXmhUOmS3N5Xf/7qhahqI6RSHPW09KuEhSQotV0VLn11fw/xvXS5SUWOMmKtP37fuYWgRFJDHRF1PQcriQpUZ5/N/YL94FJd3yE6WUszoaRFlz8PH5R3O1yLfPhZ6bsaX1pgTMmNQGkBDkWW23YIVjz/SPH5B1OrBwWNIhG3ofv7ITG0pnydZW0VyajqYFW0PiohAbNIRsebdl/zffwv3Y21ORNhtHSmP8aR0qJ2a700UtM8eMwWHHx/cr4QkJNCe2oMrrBZiuGM5MdxXkeDdflfF5Qtxww/bwhxxgXzY7HyDBj+1dhg2dhtdUP6vRZAeemmLvp42vsqTdG6w==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPSA id 0FA2B18000CE;
	Tue, 14 Apr 2026 23:36:10 +0000 (UTC)
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
Subject: [PATCH net v3 3/4] nfc: llcp: fix TLV parsing OOB in nfc_llcp_recv_snl
Date: Wed, 15 Apr 2026 01:35:32 +0200
Message-ID: <20260414233534.55973-4-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDIyMSBTYWx0ZWRfX4kD8tMfnfwsf
 GyU/Z47PkFAG60h45sbG+1E8pQkgu5OKj/NuWd3H5YmXcOFx8uSA8dCwNI3cayjiXmonJj1mCH9
 1k/UagAq1QHMJjhPkZfdDji1b0Ir4CpBOEx0aaJpvAKawLpjMfI04uwZt0SRNVO7DvqT0ZQCcm8
 sAANAIyCVDB2/nY96odOz4G2/m5SGEwQEhPW/K12RRPHhXgsViY29uaJDu54bsLnLfPGQYL+f0M
 qW7r8/U8d5FEh94JY4VQs9gJJkGRyt5X8r8DHN7jAzTiv3887zQS2b7ZYXzwV7UmrUUA3OWWQVP
 vJSgc7GDPYEqIKI4oXsjuGTYq5gEqyau5IasdTlB1jAOM8lFfzjKtDMZ8sflw8=
X-Authority-Info-Out: v=2.4 cv=KJ1XzVFo c=1 sm=1 tr=0 ts=69decf6e
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=UvREsjlsMCWqai_vkagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 479Roj26fuTPZBTg36FmnmHt4nPpA8R5
X-Proofpoint-ORIG-GUID: 479Roj26fuTPZBTg36FmnmHt4nPpA8R5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 mlxlogscore=895
 spamscore=0 phishscore=0 malwarescore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604140221
X-Spamd-Result: default: False [-0.53 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,outlook.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237986-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[icloud.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:dkim,icloud.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,outlook.com:email]
X-Rspamd-Queue-Id: 1A5143FF13C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lekë Hapçiu <framemain@outlook.com>

nfc_llcp_recv_snl() has four problems when handling a hostile peer:

 1. nfc_llcp_dsap()/nfc_llcp_ssap() dereference skb->data[0..1] without
    verifying skb->len; a 0- or 1-byte frame leads to an OOB read.
    Additionally tlv_len = skb->len - LLCP_HEADER_SIZE wraps when
    skb->len < 2, causing the following loop to run far past the
    buffer.

 2. The per-iteration loop guard `offset < tlv_len` only proves one
    byte is available, but the body reads tlv[0] and tlv[1].

 3. The peer-supplied `length` field is used to advance `tlv` without
    being checked against the remaining array space.

 4. The SDREQ handler previously only required length >= 1 but reads
    both tid (tlv[2]) and the first byte of service_name (tlv[3], via
    the pr_debug("%.16s") print and the service_name_len = length - 1
    string usage), so length >= 2 is required.

Fix: reject frames smaller than LLCP_HEADER_SIZE up front; add TLV
header and TLV value guards at the top of each iteration; bump the
SDREQ minimum length to 2.

Reachable from any NFC peer within ~4 cm once an LLCP link is up.

Fixes: 7a06f0ee2823 ("NFC: llcp: Service Name Lookup implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
---
 net/nfc/llcp_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 366d75663..efe228f96 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1282,6 +1282,11 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 	size_t sdres_tlvs_len;
 	HLIST_HEAD(nl_sdres_list);
 
+	if (skb->len < LLCP_HEADER_SIZE) {
+		pr_err("Malformed SNL PDU\n");
+		return;
+	}
+
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
 
@@ -1298,11 +1303,17 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 	sdres_tlvs_len = 0;
 
 	while (offset < tlv_len) {
+		if (tlv_len - offset < 2)
+			break;
 		type = tlv[0];
 		length = tlv[1];
+		if (tlv_len - offset - 2 < length)
+			break;
 
 		switch (type) {
 		case LLCP_TLV_SDREQ:
+			if (length < 2)
+				break;
 			tid = tlv[2];
 			service_name = (char *) &tlv[3];
 			service_name_len = length - 1;
-- 
2.51.0


