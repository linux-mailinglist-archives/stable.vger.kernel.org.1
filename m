Return-Path: <stable+bounces-241019-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8DIHJt6y62kJQgAAu9opvQ
	(envelope-from <stable+bounces-241019-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:13:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F42204624EA
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:13:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E533730071F8
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB343ED5D9;
	Fri, 24 Apr 2026 18:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="uH/CYjPi"
X-Original-To: stable@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster1-host9-snip4-5.eps.apple.com [57.103.73.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012BA3E5EDB
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 18:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.73.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777054407; cv=none; b=KHJX6YTtzTE6wKNMLIH6W7tuZWwVkVozNo/Y9iva1nlV0qH/tCx1wIMzblM55LZpIOg+dV/8RFPMsoYUWTLr3kyZ3wsnOuut1AzjYg4qhyOtsTw9ccIQ5sj0UaDk/vQ7Hx/p2jaG1czI2bVbl3F74dacEX+9YHtoWnSVrXZn1Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777054407; c=relaxed/simple;
	bh=5ADZvk8Zd+jjdNBYIpeTUZKKotpgMX+iHrYLUf1skjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z7n8bgYHB/PhiiEsPmp/PcXmlXOIZauZld3UnogGosqZxVoWg+8kiPVleuCL6/THiClEaBbEebapa1h1HZ8dzMuGJSTbAMYu5W7JG63xorPyPfr2yGs2G8GETD8yQfUHbHxG6pEgo7oK5o3ZmTmchjNpfHDXmV6sNoX2vmTHuLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=uH/CYjPi; arc=none smtp.client-ip=57.103.73.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPS id 6E3D7180041D;
	Fri, 24 Apr 2026 18:13:23 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVQORQNFF0sCTVIPDwNXF0QaWwpZFXkRUAFYHlZeWhdeTVEPDwNXF0QaWwpZFXkRUAFYHlZeWhdeTUUID0EJWFsIWwQPH0wMUQJCBVZeVAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEEVABWB5WXloXXk1aAlZNBUoDXwFbBkINSQtcBFsFXgpAAl0AWQVdCFVAA1gcRRxYE1YtXgheH0wcHQ5YBgxQTQFDCAoCURxWDVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777054405; x=1779646405; bh=on9dJlf7WQp626I4hkgi8ojcmtfnVM3S5RjDwvQLF9U=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=uH/CYjPiO4Mch2ET0AhBtWsqpuKQ6/Cb0prllo+KqM3jkeffaLqe0yd7zQ9GLG+QxgGx8ldXsH2GA19KmDLN6SBkxCtCW7gM6niP5vO6Hko0G4ocZn15TjUwZKS5d4KjZHLNZ0WCZ48I0ffvZrKQn+dhAOFx29FksZVwD/6Z9T0ihTJlAab3wD800AVkq8kZ0alQrbjLQVs/IXrWv5HRjL4h77zaH79wcNc0GaB4g7tdzbOl8tNtklhv/P/tpPBppQoqlr68Fw7MljxlVnulGC+4swionqTZ/pLeeC84yIiUMy4vb3qVtlhAg9TttCfqlqQXRYCzYiywaaRUG4VcrQ==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-9 (Postfix) with ESMTPSA id C98741800149;
	Fri, 24 Apr 2026 18:13:20 +0000 (UTC)
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
Subject: [PATCH net v4 3/5] nfc: llcp: fix TLV parsing OOB in nfc_llcp_recv_snl
Date: Fri, 24 Apr 2026 20:13:05 +0200
Message-ID: <20260424181307.3810727-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260424180151.3808557-1-snowwlake@icloud.com>
References: <20260424180151.3808557-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: so7tkkE6baDjJJZv6oLPwr-5jdl7X9_e
X-Proofpoint-ORIG-GUID: so7tkkE6baDjJJZv6oLPwr-5jdl7X9_e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE3NyBTYWx0ZWRfXwkxpS8rmGmfq
 QGW6NOCtJxL9T3BxKC9CBUSTiHRhx2YDkFmHvF8bAbkCiPGNkaHJPyEPzpcyIUKfelwA8YvxirQ
 v+qzDabcw3O7y/4oATa8/bAoniT4JUq4ft4Cp+LZOe8//lTT/mEdCZYoR2/ugoDenonrEtFsHsg
 D8BFL3/nzL6A1MkTfkJjs9v/w7bjG4LszdXmdnKS+xqKy7SAzE1a6Wy0apdMBd3o8wp4lxE4hdp
 MisglbvD9CwS1j/Jo0OtOI8b7uUGAt3NRetwNFHfeERJmSBEh5ymgDwOAqTjVoBew3GXUb/flfu
 jipDGaMyL36lJWEQovrF1bOThrVTLIFsKA/4O226+B0zqrWEDIVY5/4HSr0pEA=
X-Authority-Info-Out: v=2.4 cv=fd6gCkQF c=1 sm=1 tr=0 ts=69ebb2c4
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=7u9s_NCwlmaW5FMPgJwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Rspamd-Queue-Id: F42204624EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.53 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[icloud.com:+];
	TAGGED_FROM(0.00)[bounces-241019-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,icloud.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[icloud.com]

nfc_llcp_recv_snl() has five problems when handling a hostile peer:

 1. nfc_llcp_dsap()/nfc_llcp_ssap() dereference skb->data[0..1] without
    verifying skb->len; a 0- or 1-byte frame leads to an OOB read.
    Additionally tlv_len = skb->len - LLCP_HEADER_SIZE wraps when
    skb->len < 2, causing the following loop to run far past the
    buffer.

 2. The per-iteration loop guard `offset < tlv_len` only proves one
    byte is available, but the body reads tlv[0] and tlv[1].

 3. The peer-supplied `length` field is used to advance `tlv` without
    being checked against the remaining array space.

 4. The SDREQ handler reads tid (tlv[2]) and the first byte of
    service_name (tlv[3]) whenever length >= 1, so length == 1 reads
    one byte past the TLV.  A length of 2 is required to cover both
    accesses and to yield a non-empty service_name.

    The pr_debug("Looking for %.16s\n", service_name) additionally
    treats the buffer as a NUL-terminated string and can read up to
    15 bytes past service_name_len.  Use a length-bounded format
    ("%.*s") so the print cannot escape the validated TLV region.

 5. The SDRES handler reads tlv[2] (tid) and tlv[3] (sap) without
    checking length.  A length of 0 or 1 therefore triggers the same
    1- or 2-byte OOB read as SDREQ; require length >= 2 here as well.

Fix: reject frames smaller than LLCP_HEADER_SIZE up front; add TLV
header and TLV value guards at the top of each iteration; require
length >= 2 for SDREQ and SDRES; bound the pr_debug of service_name
with %.*s.

Fixes: 19cfe5843e86 ("NFC: Initial SNL support")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
---
 net/nfc/llcp_core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index db5bc6a878dd..3284be517204 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1284,6 +1284,11 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 	size_t sdres_tlvs_len;
 	HLIST_HEAD(nl_sdres_list);
 
+	if (skb->len < LLCP_HEADER_SIZE) {
+		pr_err("Malformed SNL PDU\n");
+		return;
+	}
+
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
 
@@ -1300,16 +1305,23 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
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
 
-			pr_debug("Looking for %.16s\n", service_name);
+			pr_debug("Looking for %.*s\n",
+				 (int)service_name_len, service_name);
 
 			if (service_name_len == strlen("urn:nfc:sn:sdp") &&
 			    !strncmp(service_name, "urn:nfc:sn:sdp",
@@ -1369,6 +1381,8 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 			break;
 
 		case LLCP_TLV_SDRES:
+			if (length < 2)
+				break;
 			mutex_lock(&local->sdreq_lock);
 
 			pr_debug("LLCP_TLV_SDRES: searching tid %d\n", tlv[2]);
-- 
2.51.0


