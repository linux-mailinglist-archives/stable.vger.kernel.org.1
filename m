Return-Path: <stable+bounces-241021-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +ADPMlCz62kJQgAAu9opvQ
	(envelope-from <stable+bounces-241021-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:15:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2B462534
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 055A4303207F
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 275A23EDAC6;
	Fri, 24 Apr 2026 18:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="icSrAtwl"
X-Original-To: stable@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster2-host8-snip4-10.eps.apple.com [57.103.74.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B953ED5D5
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.74.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054422; cv=none; b=JqzsEoXJt7dgXVdoCrCYRRbefec4M7kPUgsCbIcbOiSLcW4ZVgmZFJU1W1CqabMVeuuqVuLaeHgzTzhmS2Nu1gZKZojqPC8zJ5bwapmSUSMyjaTz5ZYDPGwyVyATSGy2+vn0vofjQb8MlaR9cowwTSb/H1St5JfeEBGa5Z17X1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054422; c=relaxed/simple;
	bh=LYDREB4Bqps9FC+aFIm1KtvUspKg1EblFTB8f6AIayI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoSdxn8uo45xxGXU9XdEgM8QG/hjIZIw9AXuUyZvjQLKXacqctjud01epSnapos+uIpJMy+66rAQvYwjy2ZYOQ07a0eoPB/FwyzWeC1BKPrD/bbnqOVAOvyHC08PunUdHt5RN/4pPgqhbX6BlBRbNRCffgsF4Iav+L8nhBNVnmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=icSrAtwl; arc=none smtp.client-ip=57.103.74.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPS id 026DD180010C;
	Fri, 24 Apr 2026 18:13:39 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVQORQNFF0sCTVIPDwNXF0QaWwpZFXkRUAFYHlZeWhdeTVEPDwNXF0QaWwpZFXkRUAFYHlZeWhdeTUUID0EJWFsIWwQPH0wMUQJCBVZeVAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEEVABWB5WXloXXk1aAlZNBUoDXwFbBkINSQtcBFsFXgpAAl0AWQVdClVAA1gcRRxYE1YtXgheH0wcHQ5YBgxQTQFDCAoCURxWDVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777054421; x=1779646421; bh=v030gjjOMNdPgby97TC8nj4zkzBFhagiFjfmyAJggcY=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=icSrAtwllG94XuTiVeds4KgLS8Ei5mJqNDFNSNNSFd605TuHH8t5X0TniVZ6GTxc5lhlqmYK1GPKM+adChYqC0WfvmZxesVsiVIkbeU0Xp93+vZ+CBbFW0HgDwueXky3wOC84P2zdrnghn8WnwQH1Dm22zh0iyY1O2mFt00LG1F3nKr5WprzUrw7N9C54vDjhh43IQBNC7DC5u6j8Z57kAJ4Hw9l04WHcYbzExu5+SSR/qdXYDBRPVfAcM81ydpOkdmgHK1VGa03fok/qjz/nLWEhGIqmSfzAiOgr3rPYT57t31d4tpd1rnO9tXPQt+7y+IoLeNxh/apY9Zrk3gV0g==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPSA id 9869E1800139;
	Fri, 24 Apr 2026 18:13:37 +0000 (UTC)
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
Subject: [PATCH net v4 5/5] nfc: llcp: fix TLV parsing OOB in nfc_llcp_connect_sn
Date: Fri, 24 Apr 2026 20:13:07 +0200
Message-ID: <20260424181307.3810727-3-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260424181307.3810727-1-snowwlake@icloud.com>
References: <20260424180151.3808557-1-snowwlake@icloud.com>
 <20260424181307.3810727-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE3NyBTYWx0ZWRfXxCRZcrhPZuVN
 CQsEMSMWQfqY9TWtGuwUBuiV/oI7+5roEXa6uNCvw1qrqfDVCIi913HLrEvYqPTizFHbnbi43xo
 Jp18yjOMCWRdhBERIMiMAM1lyXo9/oj6vofLg9xHLrhXMX2I7FmoSf5yegd9bDYkNLa+cityVTx
 wXTPNq2Z1hXCMxs0JG5W1EMya6NuD1csXo1BVUlOSNw6mgkoWi4jWQyFxYZYJ1iyOi9BbiNwJkG
 a7A+teS2KWvekNEjdL3+SgS7da1t4bRFTqlScXW/NP2aNnUqEKf8bji/b00sBuY0uq6Gh64lU2n
 2B9Rz4DlocUuNH36xHqxDL1OcwjeicEV2n8Gnwd4DGze3BakfD5Z8RLsKTXKC8=
X-Proofpoint-GUID: EcR2TPKI8emhvf9-ySeavq2QvEzc48iT
X-Authority-Info-Out: v=2.4 cv=QdNrf8bv c=1 sm=1 tr=0 ts=69ebb2d4
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=MCyzZkT_QOhwK6_fNwUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: EcR2TPKI8emhvf9-ySeavq2QvEzc48iT
X-Rspamd-Queue-Id: 3DF2B462534
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.53 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[icloud.com:+];
	TAGGED_FROM(0.00)[bounces-241021-lists,stable=lfdr.de];
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

nfc_llcp_connect_sn() walks the TLV array of an LLCP CONNECT PDU
looking for the Service Name TLV, but shares the same class of bugs
as nfc_llcp_recv_snl() / nfc_llcp_parse_gb_tlv():

 1. tlv_array_len = skb->len - LLCP_HEADER_SIZE wraps when skb->len
    is 0 or 1.  The subsequent loop then runs far past the buffer.

 2. The per-iteration guard `offset < tlv_array_len` only proves one
    byte is available, but the body reads both tlv[0] (type) and
    tlv[1] (length).

 3. The peer-supplied `length` field is used to advance `tlv` without
    being checked against the remaining array space, so a crafted
    length walks `tlv` past the buffer.  On the following iteration
    tlv[0]/tlv[1] are read from adjacent memory.

 4. When an LLCP_TLV_SN is found, the function returns &tlv[2] with
    *sn_len = length but without verifying that `length` bytes at
    tlv[2..] are still inside the TLV array.  The caller in
    nfc_llcp_recv_connect() then uses this (pointer, length) pair as
    a service name, so it may read past the PDU.

Fix: reject frames smaller than LLCP_HEADER_SIZE up front; add TLV
header and TLV value guards at the top of each iteration.  The value
guard also ensures that the (&tlv[2], length) pair returned on
LLCP_TLV_SN lies fully inside the TLV array.

Also use LLCP_HEADER_SIZE instead of the magic literal `2` to match
the style of neighbouring LLCP receive paths.

Reported-by: Simon Horman <horms@kernel.org>
Closes: https://lore.kernel.org/netdev/20260417160438.GH31784@horms.kernel.org/
Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
---
 net/nfc/llcp_core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index ca0abfd329e5..df5567ca7fa8 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -849,12 +849,22 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 {
 	u8 type, length;
-	const u8 *tlv = &skb->data[2];
-	size_t tlv_array_len = skb->len - LLCP_HEADER_SIZE, offset = 0;
+	const u8 *tlv;
+	size_t tlv_array_len, offset = 0;
+
+	if (skb->len < LLCP_HEADER_SIZE)
+		return NULL;
+
+	tlv = &skb->data[LLCP_HEADER_SIZE];
+	tlv_array_len = skb->len - LLCP_HEADER_SIZE;
 
 	while (offset < tlv_array_len) {
+		if (tlv_array_len - offset < 2)
+			break;
 		type = tlv[0];
 		length = tlv[1];
+		if (tlv_array_len - offset - 2 < length)
+			break;
 
 		pr_debug("type 0x%x length %d\n", type, length);
 
-- 
2.51.0


