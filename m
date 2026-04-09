Return-Path: <stable+bounces-235520-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCGoEAs42GlWaAgAu9opvQ
	(envelope-from <stable+bounces-235520-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 01:36:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D4B3D082F
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 01:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1CD93022635
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 23:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B46A3A3828;
	Thu,  9 Apr 2026 23:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="s2xoKGca"
X-Original-To: stable@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2006c-snip4-11.eps.apple.com [57.103.85.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE023A2569
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 23:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.85.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775777764; cv=none; b=JNiAgTVVHy6MkTHqhJahcuYakBZ9aXVocM9t26EZwR1a+M8OSV+0wk3sdKFhkyK9Jn8LgGApWuRVKex4+oNYkX/i+jGUvTTznHs3i0eK94J0AgpvC17iqYkm77OYJf4aW95ZGku4aByHlYUwHsEZJDgoABBiaXjfjRNkSAFaRrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775777764; c=relaxed/simple;
	bh=RYbFDhdX7fkWoG806yqB7SHMv6+YWj33EAnCq2ZdDzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u8NlRM+QMrVtWkMN3Yot6RsPUG5YMPyjIZ39Ix3YlY1DGzI15uHAVSnVTO9NzV+XwAOXxYLcnNekGoQUBj/d2ooCjuSXYYZ//OmHlb8sHX6E0FRoZFVoUQt7LPWjGgRmyEXkHx89SytBbBe7yCU38rjX3vZNfqLl92u4R5AWvyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=s2xoKGca; arc=none smtp.client-ip=57.103.85.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-5 (Postfix) with ESMTPS id AF76E180011B;
	Thu, 09 Apr 2026 23:35:57 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775777760; x=1778369760; bh=jxNonVp/UZyij6iyYk46/5gMGC8iDxkJH/YjjyLjCmE=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=s2xoKGcaVB7y8E69GDBRXbW1NWH3ViMzOnVmXxHC6obN+bKzvMpc3Qpt9vw0ck/QhjHJngFBnFanXwHEWpLqH1F7rTrREKY0oHhLIHbz3a7g2FWmIjkla2JnddHmmNG6Dai3GcqTxTH+pHN0FIC2E2odbrvN0au3gug/iOyyeJfoAKGIclgTU7ZvbDeXbbLCkoy4E47mC6PxKcpw/wlpL9biQEYEosiGchXabpjv4mLE8fmDhfEMKMNQX/jp/TfFoOHilAomRUwh14rKNsXaAMK3A3FOZ5iRNjxr3cXFeXJ4l8t4i6ybCS3yBGeLUaRkhcNqy+nDNUTJ/YneQsf2MQ==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-5 (Postfix) with ESMTPSA id 75D8518000BF;
	Thu, 09 Apr 2026 23:35:55 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: linux-nfc@lists.01.org,
	stable@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
Subject: [PATCH net 2/3] nfc: llcp: fix TLV parsing OOB and length underflow in nfc_llcp_recv_snl
Date: Fri, 10 Apr 2026 01:35:15 +0200
Message-ID: <20260409233517.1891497-3-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260409233517.1891497-1-snowwlake@icloud.com>
References: <20260409233517.1891497-1-snowwlake@icloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y90yU5F4X2-y1St_1MqM43KIuaP9Avsk
X-Proofpoint-GUID: Y90yU5F4X2-y1St_1MqM43KIuaP9Avsk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDIxOCBTYWx0ZWRfX1DpB2RQdMcDb
 47TSRa5wNw7Nrr0sKjRtsuG9md5OoQb3cLSoTjcQcjbCBNNFUR/fauySopdYY3HjbeCLcKbWhG8
 pbAnSwm7Of4CpkHEy17xrYPKP6Zvzu7fhwZbAX6tv+5CZOXn4o1hsPa5zazceNdXahVN63qScBW
 CgHikQt4ptavt48YT+TrD0/pgtCIl8/3OPhTmqT0hKXKNlu234XggKUfRMd0J5OtHoRipkj1HJY
 ojxbigmGt9bv2oC1wStNv53Qwa2id9BAWK3eT2sIVl+b9Knl8cyWyl0+jgUE0TCrcPkZoA7nIWI
 pQ4CgPuFL9pbMHuyq3AL24V2/unTVfASsIp/8M5s1e1TkcmGKqn/ckqB15jyNM=
X-Authority-Info-Out: v=2.4 cv=RpvI7SmK c=1 sm=1 tr=0 ts=69d837de
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=h198WebNHr3hihf7tCMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JKcXVnpmuwdQ7RL0mgk_:22 a=5Q-93EyGrU3sW_9myDOF:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxlogscore=999 adultscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090218
X-Spamd-Result: default: False [-0.60 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.01.org,vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,icloud.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235520-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[icloud.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,icloud.com:dkim,icloud.com:email,icloud.com:mid]
X-Rspamd-Queue-Id: A8D4B3D082F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Fixes: 7a06f0ee2823 ("NFC: llcp: Service Name Lookup implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
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


