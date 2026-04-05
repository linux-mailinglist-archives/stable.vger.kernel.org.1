Return-Path: <stable+bounces-233328-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kNXtBrJA0mkxUwcAu9opvQ
	(envelope-from <stable+bounces-233328-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 13:00:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CFAA39E170
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 13:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0EBF3008A5C
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 10:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32E1341ACA;
	Sun,  5 Apr 2026 10:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="A3kAlNBb"
X-Original-To: stable@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2004e-snip4-3.eps.apple.com [57.103.84.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A3E33688D
	for <stable@vger.kernel.org>; Sun,  5 Apr 2026 10:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.84.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775386794; cv=none; b=G5zl1yVlrBmh3jjJnzeE88XpPVnXnYCP9DBaQRrjWjcYMVSYS9zDnNBdbvRspwdOhLgCVtUWH2e1UdXq7RVNshyAux8kQ3HN2TpMidbajx0ivts4nNKY5mGgrfkO3JMNvQ9Pq8nkM5M8qFz8m60ycmE+sKg0VgTi7U5VuAZod2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775386794; c=relaxed/simple;
	bh=SNdpv4JRA5I36bK4d/GA8qtPnuUS1SMcMYwTnvzMszs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ac7x8+mGoJjanLDWveO1sABcXAmaOv2mZiqUBtWIad0kGq/DK96nx7ZbOpFtHNe9NJ7WeLUJ3EzzIg2paPknAldwiOcecnLS50FfIxL4tHjgKhATWVfTOw3XnnlMOoyJh8GZYmQW2cDz/7xmFvwGMDLrE/FM10YlET3utVW4+Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=A3kAlNBb; arc=none smtp.client-ip=57.103.84.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPS id 3BCD518000B4;
	Sun, 05 Apr 2026 10:59:50 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775386792; x=1777978792; bh=mmYSizGCcd+w6h0JNWD+gW/hsM7aqETjUFhWj+G2v9w=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=A3kAlNBbj5D+GFPzHHGMpXymiZN+WbEwrx2ddJnowDCsxKlwJvgTH6KOushpM4pVlZ8HQTZN7jf4sMgOFscZ3X5DL4bO5dQNctcluwa2vJ/0pzsOhkblKNIbC/0gumE3sUmsKtPNlQSa7FJvupfTLdEObMdMYKqU9t74z4/R5mG4tGME/eVeWUYUjKDdjRQweTNzG2N8T+idLYRYhWLMXRue7dcI8Cd67iL16RFsPQV4LJQraDPpZBtIqS4GlM1bHP2ppY57+DPLXVkijfzCXEwZqsme9V4x95D5mHp5QKsh64m++Ba0HVbgCF5fPfX0U4777Rzt7GFs1DsQazTWcQ==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-100-percent-10 (Postfix) with ESMTPSA id 127821800101;
	Sun, 05 Apr 2026 10:59:47 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <framemain@outlook.com>
Subject: [PATCH] nfc: llcp: fix u8 offset truncation in LLCP TLV parsers
Date: Sun,  5 Apr 2026 12:59:38 +0200
Message-ID: <20260405105938.1334488-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=B4u0EetM c=1 sm=1 tr=0 ts=69d240a6
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10
 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=PHAGy2fEgbgclJbIeasA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=JKcXVnpmuwdQ7RL0mgk_:22 a=0rGzeHJzHG8Rmdz0oRec:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDExMiBTYWx0ZWRfX4MstjNE/34Ti
 x0250eUQHe6FBGwGSZ56cdv2t/3NZlS0qCfZ89l/9m8o8tjkZhZZ8hjAvk4bEDpnw4NXuOhLHiE
 RlWO32XcZLSrKb/4PXxsHs7iprNfp8BEbs+c1MLXRAlw1Q9qW9bQ+a26B9gY4ToV+pr341B4Jt7
 AFxQM2de63lD0NaA24i9fd6TKpt8txR0EDYGWfu4vsfJ2KJgcYIH9WC03GrJfdoY4jhjfEpGLBE
 4K4++W7D3znJR4qqtP3m/LIIT17AUjGXkkOYKVdTvv9Xp/sXud8Yn7lLrMV9Yfz75oe9otckSFa
 n1PGnyvm8gd7D0qlPYMyshvqw/IRS+bSGaK7Ucj05RsPKWwW1hlxcTaGzdDxvw=
X-Proofpoint-ORIG-GUID: jZAnaIJfMRWJ3GmR1iCkeLrhfLLw1jic
X-Proofpoint-GUID: jZAnaIJfMRWJ3GmR1iCkeLrhfLLw1jic
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_04,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1011 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604050112
X-Spamd-Result: default: False [-0.45 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.71)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,outlook.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233328-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,icloud.com:dkim,icloud.com:mid,outlook.com:email]
X-Rspamd-Queue-Id: 5CFAA39E170
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lekë Hapçiu <framemain@outlook.com>

nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv() declare
'offset' as u8, but compare it against a u16 tlv_array_len:

    u8 type, length, offset = 0;
    while (offset < tlv_array_len) {   /* tlv_array_len is u16 */
        ...
        offset += length + 2;          /* wraps at 256 */
        tlv    += length + 2;
    }

When tlv_array_len > 255 -- possible in nfc_llcp_parse_connection_tlv()
when the peer has negotiated MIUX = 0x7FF (MIU = 2175 bytes), so that
a CONNECT PDU can carry a TLV array of up to 2173 bytes -- the u8
offset wraps back below tlv_array_len after every 128 zero-length TLV
entries and the loop never terminates.  The 'tlv' pointer meanwhile
advances without bound into adjacent kernel heap, causing:

  * an OOB read of kernel heap content past the skb end;
  * a kernel page fault / oops once 'tlv' leaves mapped memory.

This is reachable from any NFC P2P peer device within ~4 cm without
requiring compromised NFCC firmware.

Fix: promote 'offset' from u8 to u16 in both parsers, matching the
type of their tlv_array_len parameter.

nfc_llcp_parse_gb_tlv() takes GB bytes from the ATR_RES (max 44 bytes),
so the wrap cannot occur in practice there.  Change it anyway for
correctness and to prevent copy-paste reintroduction.

Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
---
 net/nfc/llcp_commands.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 291f26fac..6937dcb3b 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -193,7 +193,8 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 			  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -243,7 +244,8 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 				  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
-- 
2.51.0


