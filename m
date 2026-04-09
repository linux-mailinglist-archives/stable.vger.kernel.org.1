Return-Path: <stable+bounces-235493-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IG5BF5v312mrVAgAu9opvQ
	(envelope-from <stable+bounces-235493-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:01:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B75473CEED7
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A1B6301DCC5
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40A5336EF1;
	Thu,  9 Apr 2026 19:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="q+Iu5rIp"
X-Original-To: stable@vger.kernel.org
Received: from outbound.pv.icloud.com (pv-2002j-snip4-11.eps.apple.com [57.103.64.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FF12FFDE3
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 19:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.64.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775761277; cv=none; b=g6ZSZLHAfz/EtBRAAtee/nrPL14ztzeuU75jG6GbcaOVRs+uIejr9PY93wwjE5x+drfINqtrY5ktdcd9bMm3MEVpwEqdnvnVqBhIKTdaflTPS8ZFs7UvN/+94SPCu1H6sdpGTOOTyftGEJ+zedJIHu/LAeRm8DMLH9OyXUfIvwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775761277; c=relaxed/simple;
	bh=Cu6nP4nJcqFR6ZHUeGb8Qgl6vJU1b+WPHlOIdIfhE+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GjAtWWM3oxaCKkinjVAX3lYprNfmrB4b0NX0dGLyS4cNqEpm0sBv8T3p4C1QfsgsD3hzjfgS3TNV9UAk7fpTs/tZzS5JMTT609fROtpXTKckOp3j6qwgkE/PFZAAIbjBWgnMNUqKVicTuPXNbl3JM4vw28U/10ybn6E2BciV+0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=q+Iu5rIp; arc=none smtp.client-ip=57.103.64.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.pv.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPS id C5A451800244;
	Thu, 09 Apr 2026 19:00:47 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775761249; x=1778353249; bh=kHYiEm+Ioqbrf9u37UGaWfjubqZGzJqVa/wjFOedTOo=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=q+Iu5rIpKSwUm5VbkhiOsSuVWFvclmC65n3BbeQ7Ztmsa89gsWq4I5Zneeq7/gJ44h+FDFFwKHTz182QvRYxsMoiCVrlinCLe8jwIyHJ9l9/p3fWraydkhUOI1eGiOdLPs1Ji2FD2I7ejz5+IaL4Kc2NakJq7IJwbb97UsMbh84/ZPQ4CrZv+J0/wdKJUVioUN6XDD2uRRXMdhm0gdsVpYY8YBJKJLxMU/CC5MVbIZSpgXkaq/t4kuWdsbb84Pl01xlnNBVVSS7G5NRW7pBINW7fv3FM5h2XRAgiiK+zKw1sPXkdGjsNvIQdID8fC8hr/uq9EYifCS7DSwWeV5I+gQ==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.56.9.36])
	by p00-icloudmta-asmtp-us-west-1a-60-percent-0 (Postfix) with ESMTPSA id 443471800979;
	Thu, 09 Apr 2026 19:00:45 +0000 (UTC)
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
Subject: [PATCH net v2 2/3] nfc: llcp: add TLV length bounds checks in parse_gb_tlv and parse_connection_tlv
Date: Thu,  9 Apr 2026 20:59:57 +0200
Message-ID: <20260409185958.1821242-3-snowwlake@icloud.com>
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
X-Proofpoint-GUID: cQDNo1pIe9AOiYTuf_BS5aPPuBbhE8Y0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3NSBTYWx0ZWRfX7sMM7JS7ESjs
 ETCQVmMMO1y4YbsYUaMZsS/lCal3lMrK98lZ0fGVw7ao6NdFsO1V15yQ5nt+uI6RABoAb+kFAM8
 iG9UDc7hQdAvraq2L8RQxTwqTUuFcGXNGpK+J4K1JwGdnDDKHGag7svbWhcx4vEvVPp8Hau+zGB
 hOnRtXIfRbAhR+rd/mG25oQVDQseNPPq5ZP1uald6ph4/yDRiAlHbfoJHxa0F+ZZ1SJSjceuPvr
 cyX+qouKKiOw1etXZAMphojevEj8oWsInA4NHbMV26sUcWy0O0uUz+Tr6eOoUJLiRnJrtfq0ct1
 3wdRouKBd0tcrCZO46EQYQPX9mzcxyRdmq/4SlzLOd92phTmAjEHdgc6Nx/HWg=
X-Proofpoint-ORIG-GUID: cQDNo1pIe9AOiYTuf_BS5aPPuBbhE8Y0
X-Authority-Info-Out: v=2.4 cv=M45A6iws c=1 sm=1 tr=0 ts=69d7f760
 cx=c_apl:c_pps:t_out a=azHRBMxVc17uSn+fyuI/eg==:117
 a=azHRBMxVc17uSn+fyuI/eg==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=HT8XlELXz0Cu0VbjAesA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JKcXVnpmuwdQ7RL0mgk_:22 a=zesNzv29S0FE4YlguZl3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 mlxscore=0 adultscore=0 suspectscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604090175
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
	TAGGED_FROM(0.00)[bounces-235493-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,icloud.com:dkim,icloud.com:mid]
X-Rspamd-Queue-Id: B75473CEED7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lekë Hapçiu <framemain@outlook.com>

v1 of this fix promoted `offset` from u8 to u16 in both TLV parsers,
preventing the infinite loop when a connection TLV array exceeds 255 bytes.
During review, Simon Horman identified two additional issues that the u16
promotion alone does not address.

Issue 1 - truncated TLV header:

  The loop guard `offset < tlv_array_len` is not sufficient to guarantee
  that reading tlv[0] (type) and tlv[1] (length) is safe.  When exactly
  one byte remains (offset == tlv_array_len - 1) the loop body reads
  tlv[1] one byte past the end of the array.

Issue 2 - peer-controlled `length` field:

  `length` is read from peer-supplied frame data and is not checked against
  the remaining array space before advancing `tlv` and `offset`:

    offset += length + 2;   /* always */
    tlv    += length + 2;   /* may now point past buffer end */

  A crafted `length` advances `tlv` past the array boundary; the following
  iteration reads tlv[0]/tlv[1] from adjacent kernel memory.

  For nfc_llcp_parse_gb_tlv() this is particularly impactful: its input is
  &local->remote_gb[3], a field within nfc_llcp_local.  A large `length`
  can walk `tlv` into adjacent struct fields including sdreq_timer and
  sdreq_timeout_work which contain kernel function pointers at approximately
  +176 and +216 bytes past remote_gb[].  The parsed `type` byte at those
  positions may match a recognized TLV type causing the parser to store
  bytes from the function pointer into local->remote_miu, which is
  subsequently readable via getsockopt().

Issue 3 - zero-length TLV value:

  The llcp_tlv8() and llcp_tlv16() accessor helpers read tlv[2] and
  tlv[2..3] respectively.  The outer guard guarantees `length` bytes of
  value are available past the two-byte header, but when length == 0 it
  only guarantees offset+2 <= tlv_array_len (non-strict), leaving tlv[2]
  out of bounds.  Per-type minimum-length checks are required before each
  accessor call.  Note: llcp_tlv8/16 additionally validate against the
  llcp_tlv_length[] table, providing a second safety layer; the per-type
  checks here make the rejection explicit and avoid silent zero-defaults.

Fix: add two loop-level guards inside each parsing loop:

  if (tlv_array_len - offset < 2)            /* need type + length */
      break;
  [read type, length]
  if (tlv_array_len - offset - 2 < length)   /* need length value bytes */
      break;

Both subtractions are safe: the loop condition guarantees offset <
tlv_array_len; the first guard then guarantees the difference is >= 2,
making the second subtraction non-negative.

Add per-type minimum-length checks before each accessor call:
  - tlv8-based (VERSION, LTO, OPT, RW): require length >= 1
  - tlv16-based (MIUX, WKS):            require length >= 2

Reachability: nfc_llcp_parse_connection_tlv() is reached on receipt of a
CONNECT or CC PDU before any connection is established.
nfc_llcp_parse_gb_tlv() is reached during ATR_RES processing.  Both are
triggerable from any NFC peer within ~4 cm with no authentication.

Reported-by: Simon Horman <horms@kernel.org>
Fixes: 7a06e586b9bf ("NFC: Move LLCP receiver window value to socket structure")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
---
 net/nfc/llcp_commands.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 6937dcb3b..7cc237a6d 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -202,25 +202,39 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 		return -ENODEV;
 
 	while (offset < tlv_array_len) {
+		if (tlv_array_len - offset < 2)
+			break;
 		type = tlv[0];
 		length = tlv[1];
+		if (tlv_array_len - offset - 2 < length)
+			break;
 
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
 		case LLCP_TLV_VERSION:
+			if (length < 1)
+				break;
 			local->remote_version = llcp_tlv_version(tlv);
 			break;
 		case LLCP_TLV_MIUX:
+			if (length < 2)
+				break;
 			local->remote_miu = llcp_tlv_miux(tlv) + 128;
 			break;
 		case LLCP_TLV_WKS:
+			if (length < 2)
+				break;
 			local->remote_wks = llcp_tlv_wks(tlv);
 			break;
 		case LLCP_TLV_LTO:
+			if (length < 1)
+				break;
 			local->remote_lto = llcp_tlv_lto(tlv) * 10;
 			break;
 		case LLCP_TLV_OPT:
+			if (length < 1)
+				break;
 			local->remote_opt = llcp_tlv_opt(tlv);
 			break;
 		default:
@@ -253,16 +267,24 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 		return -ENOTCONN;
 
 	while (offset < tlv_array_len) {
+		if (tlv_array_len - offset < 2)
+			break;
 		type = tlv[0];
 		length = tlv[1];
+		if (tlv_array_len - offset - 2 < length)
+			break;
 
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
 		case LLCP_TLV_MIUX:
+			if (length < 2)
+				break;
 			sock->remote_miu = llcp_tlv_miux(tlv) + 128;
 			break;
 		case LLCP_TLV_RW:
+			if (length < 1)
+				break;
 			sock->remote_rw = llcp_tlv_rw(tlv);
 			break;
 		case LLCP_TLV_SN:
-- 
2.51.0


