Return-Path: <stable+bounces-235494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Cw9DaL312mrVAgAu9opvQ
	(envelope-from <stable+bounces-235494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:01:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEF763CEEE5
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC2AF3022969
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F24430BB97;
	Thu,  9 Apr 2026 19:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="wyTYmw4m"
X-Original-To: stable@vger.kernel.org
Received: from outbound.pv.icloud.com (p-west1-cluster6-host11-snip4-10.eps.apple.com [57.103.67.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCF2331205
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 19:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.67.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761278; cv=none; b=R4vUdOk99/GoZlIWgOkdk6fgROxtRSH0jWKucDzcgg3An6nJ7inGBEuHLDGUNf6k7ip3LULTULROwLidhTMjVbF2Dio32GpRsellgvQAbSkBv5OIH/DVmAOKVrjnJ21cooqUXI78vLM1XOILMdl+SQ4LvUy3SGc9YXorAKOUl8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761278; c=relaxed/simple;
	bh=vPGgef9aLQxni1nXn6YUCevYHZq9qzBbbpi73isvh88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DxNSoGOljMTg3eZTFAqq717lofmxJyo9Huk0tCVDNgu6JU7QlxNosL/hDY9u98i8xLi2xbYvTez723tJX+hKUjwvgKbpEhEwus1P2ADgJA0lNfnuF6TfO1ipZlZYmhSmVRDZn3WZ3HXtlsUzexI5OZnvV1d77AWnxxeKWtmNXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=wyTYmw4m; arc=none smtp.client-ip=57.103.67.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPS id 41CCF180097C;
	Thu, 09 Apr 2026 19:00:59 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775761260; x=1778353260; bh=iX7m0e68m8rGvVRNTzaWuccLGp3V1QlVU1TsthtLfIg=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=wyTYmw4mg0A2Lnd7X3ct/V8doD/4JvwiF/XHgLgNDmYKN+FXotHKoUtdlzQvgX9KVkWVSqxYvNXbCFpYF+rZUIas7gG9LqM8zudbtunVBXQHhcRE7ANQ8e0ABzpCzVm4s1zDDQCU45nlEsxDMGewPSZxtTH0vPlCFwJtJFKqSqZ4/9/Hsv/dtSALo2+t5CTx8BNeAvFdtwgneYZ5mvu83Vw4TDQm7l7PKuT19PQTa3lGj98sXAQVcQcjxG643/HFodt09e2+EnIgW0a0Li5lfxhZrK+O6uR8v5hcy3zZlR/SGR+ziWU30tW3Wxj93J5ufT9iLQnKGMthFSyiKtwEtQ==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPSA id 548F11800BC9;
	Thu, 09 Apr 2026 19:00:52 +0000 (UTC)
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
Subject: [PATCH net v2 3/3] nfc: llcp: fix TLV parsing OOB and length underflow in nfc_llcp_recv_snl
Date: Thu,  9 Apr 2026 20:59:58 +0200
Message-ID: <20260409185958.1821242-4-snowwlake@icloud.com>
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
X-Proofpoint-GUID: 8s_-UT2knZ1a1875Aa0F42z9IQhatXoM
X-Proofpoint-ORIG-GUID: 8s_-UT2knZ1a1875Aa0F42z9IQhatXoM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3NSBTYWx0ZWRfXzTeXj3euZ6UX
 bzZz+0tZXKy7OHWf4E8wfwFImtS+9tGIhwTYND77vytvUK/niQeEChEin3JG5NC6MDcxidq63VW
 FHupYWwhujAKXhuz8X2dE8/agWjmFtwSdKWpoGiEr9B6R7wsbLa6ptVQR7ui9ITlQ4B9B7wXYtv
 UEZSyv6M50+qfg8ij+bsZo0OMQmCEiP11bcxTMp1Yzo2/YpwSVCGp02Y90oU419lUGFsSZB5tu4
 kWE8Qs/E6c181rA5+Di67EYGfbRk4BmA94G5I3ri23dYtq48KfRwENt/24aUDUqvu1mNhRvw0l/
 8/ZZI5ZxOzDqa6nA9HlubzURSS1N+lDfpc2B7VY8BckuscE+Xe5eKr/09b12bg=
X-Authority-Info-Out: v=2.4 cv=WIFyn3sR c=1 sm=1 tr=0 ts=69d7f76b
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=h198WebNHr3hihf7tCMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JKcXVnpmuwdQ7RL0mgk_:22 a=zesNzv29S0FE4YlguZl3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 adultscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604090175
X-Spamd-Result: default: False [-0.63 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lists.01.org,vger.kernel.org,outlook.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235494-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[icloud.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,outlook.com:email,icloud.com:dkim,icloud.com:mid]
X-Rspamd-Queue-Id: BEF763CEEE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lekë Hapçiu <framemain@outlook.com>

nfc_llcp_recv_snl() contains four distinct vulnerabilities.

Issue 1 - missing minimum-length guard on skb:

  nfc_llcp_dsap() and nfc_llcp_ssap() access pdu->data[0] and pdu->data[1]
  unconditionally.  The subsequent computation:

    tlv_len = skb->len - LLCP_HEADER_SIZE;   /* LLCP_HEADER_SIZE = 2 */

  truncates to u16.  If skb->len < 2, the unsigned subtraction wraps at
  unsigned int width and the truncation to u16 yields up to 65534, causing
  the while loop to iterate far beyond the skb data.  No guard exists at
  the dispatch path to prevent this.

  Fix: add `if (skb->len < LLCP_HEADER_SIZE) return;` before any skb->data
  access, matching the pattern already used in nfc_llcp_recv_agf().

Issue 2 - missing per-iteration TLV header guard:

  The loop reads tlv[0] and tlv[1] with no prior check that two bytes
  remain.  When one byte remains, tlv[1] is one byte past the array end.

  Fix: `if (tlv_len - offset < 2) break;`

Issue 3 - peer-controlled `length` field advances tlv past skb end:

  `length` (tlv[1]) is advanced unconditionally into `offset` and `tlv`
  without verifying that `length` bytes of TLV value exist.  A malicious
  peer sets `length` large enough that `offset` remains below `tlv_len` on
  the next iteration while `tlv` points into adjacent kernel heap.

  Fix: `if (tlv_len - offset - 2 < length) break;`

Issue 4 - per-type minimum-length hazards:

  LLCP_TLV_SDREQ: `service_name_len = length - 1` is u8 arithmetic.  When
  length == 0 this wraps to 255, causing a 255-byte kernel memory scan via
  strncmp.  tlv[2] (tid) is also accessed unconditionally.
  Fix: require length >= 1 before the tid/service_name access.

  LLCP_TLV_SDRES: tlv[2] and tlv[3] are accessed without verifying
  length >= 2.  Unlike the GB/connection parsers, SDREQ/SDRES are not
  processed via llcp_tlv8/16, so the llcp_tlv_length[] table provides no
  protection here.
  Fix: require length >= 2 before the tlv[2]/tlv[3] accesses.

  In both cases a `break` from the inner switch falls through to the
  unconditional `offset += length + 2; tlv += length + 2` at the loop
  tail, correctly advancing past the malformed TLV.  The outer two guards
  break from the while loop entirely.

Reachability: SNL PDUs are processed during LLCP service discovery, before
any connection is established, from any NFC peer within ~4 cm with no
authentication or pairing.

Fixes: 19cfe5843e86 ("NFC: Initial SNL support")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
---
 net/nfc/llcp_core.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index db5bc6a87..16acf7c2b 100644
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
 
@@ -1300,11 +1305,17 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
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
+			if (length < 1)
+				break;
 			tid = tlv[2];
 			service_name = (char *) &tlv[3];
 			service_name_len = length - 1;
@@ -1369,6 +1380,8 @@ static void nfc_llcp_recv_snl(struct nfc_llcp_local *local,
 			break;
 
 		case LLCP_TLV_SDRES:
+			if (length < 2)
+				break;
 			mutex_lock(&local->sdreq_lock);
 
 			pr_debug("LLCP_TLV_SDRES: searching tid %d\n", tlv[2]);
-- 
2.51.0


