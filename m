Return-Path: <stable+bounces-237985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CKuDY3P3ml0IgAAu9opvQ
	(envelope-from <stable+bounces-237985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:36:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 08F0E3FF109
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:36:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CB01302F4B0
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E587A3BD22C;
	Tue, 14 Apr 2026 23:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="tg/jSApU"
X-Original-To: stable@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster5-host5-snip4-5.eps.apple.com [57.103.72.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7909A3CCA1A
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 23:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209774; cv=none; b=awCjpz4FsJD4GTM1of0Yl7Qg04GN5hVzG6KdYcJgLe2a3LAhsmMExS0bNPTjuBd6mYwRpfYK7jUyIjL4MyIxfs0gaDEoFqwoB62TE8/YOsGCrb0DLZsA3kX/xx/VxSrzJVgpE9zDIbwCF6p1ZX8Qr3qAugF6R/PVgbTeKMrVo80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209774; c=relaxed/simple;
	bh=33clpOs74IFdTY8qsNLEhYvBCvA94+PxnkVvmJeLwr4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YY1qgVvdEJY2IH1R99X8mXznTvIhSg5rh9eFJ3KfsVdR+3fsZjmRtMPN1TgjoyoFQMD39opYGkLkZqqt6MvwFZV2MoIYnKt5W6qJ7T1xUmH6kmT2uXGK4CbvBquRwItPeU3U5d9MTO5Lp7j7Qs9EN/6oXBclhgqi4WfC7N+5c5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=tg/jSApU; arc=none smtp.client-ip=57.103.72.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPS id 40F7418000FC;
	Tue, 14 Apr 2026 23:36:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1776209772; x=1778801772; bh=UfErZLy5ZvFzKOKvB7oSO3xop+8N4Og1XiKR0ye2+1M=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=tg/jSApUa/MkSJBn1jjpKocxBNucrcV83l0Rq/xS/NgM47KySoq/C1XnURm73o7ZJBumMT9TQ9EV7bxtuAo3Xa7x2bAy7+nDXJ8ZCvtQlXSgkrrzD8YJ7Z+lxpsbkwhW1kIfS8xsvt4oGEfGpRsKSXqPwaSEhOus4SjcrWOubLzWzRi3wdeAoShO5S3LeEMDCLeK6m689IE9UaKRxRmry7BKfzhEs1qfZkwIciYiexxLoejgjzE4Kb43wCFHvBP5FN/Q2VK0u4/E8jGJq8scP7C/bg8QOIQEZh3DiNiotS2bKbzvFZ4yEc7V9gkB+2uD1zrdOoK6Fdc0ugT0c0mqDg==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPSA id D462018000CD;
	Tue, 14 Apr 2026 23:36:08 +0000 (UTC)
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
Subject: [PATCH net v3 2/4] nfc: llcp: fix TLV parsing in parse_gb_tlv and parse_connection_tlv
Date: Wed, 15 Apr 2026 01:35:31 +0200
Message-ID: <20260414233534.55973-3-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nlx_WRlroHkA6v_jf9G-g5CvIjh6b5Ac
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDIyMSBTYWx0ZWRfX1t+IWhvF9fF5
 WfMrQ1eluJk9vREB2bonRYOIlIXgoH2tr73wpv2TR1bj2JaPSzgLnZn2lKWuhbFv4pp/5vjsIB+
 WAkqlQWcCcZnVntQl4mgbL1EiZthWhEkuKk4GVKJuKBNBHg/4lF1V2m4M/OKXLA4LJXiCHBPCgt
 AEnQbbadOSF/3d10zT+4BAyIyfCW+zFtZMVNbByDtuyEDQ6/aviAyDu82+l8cgm9WfhfyAXAaAd
 Qjn0RJMhKiZXIQgYMe2onciDbuJQ1x8rmzCSKN+rREV9eNtgxeQYPW3clwFUFes7CFOVxELQW53
 kSFIxJ1/rQ3RHSiiuNlw8vxr4SbnLFqGp3wj9kNDOVWyiETb6akgQ8YyGRQI5Y=
X-Authority-Info-Out: v=2.4 cv=KKBXzVFo c=1 sm=1 tr=0 ts=69decf6b
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=sym2L8O1NbaxQZQDF_4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: nlx_WRlroHkA6v_jf9G-g5CvIjh6b5Ac
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 suspectscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 bulkscore=0 lowpriorityscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604140221
X-Spamd-Result: default: False [-0.57 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,outlook.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237985-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[icloud.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,outlook.com:email,icloud.com:dkim,icloud.com:mid]
X-Rspamd-Queue-Id: 08F0E3FF109
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lekë Hapçiu <framemain@outlook.com>

nfc_llcp_parse_gb_tlv() and nfc_llcp_parse_connection_tlv() walk TLV
arrays whose length and content come from a peer-supplied frame.  The
parsing loop has three weaknesses:

 1. `offset` is declared u8 while `tlv_array_len` is u16.  In
    parse_connection_tlv() the TLV array can reach ~2173 bytes (MIUX
    up to 0x7FF), so 128 zero-length TLVs wrap `offset` back to 0 and
    the loop never terminates while `tlv` advances past the buffer.

 2. The guard `offset < tlv_array_len` only proves one byte is
    available, but the body reads tlv[0] (type) and tlv[1] (length).
    When one byte remains, tlv[1] is out of bounds.

 3. `length` is read from peer data and used to advance `tlv` without
    being checked against the remaining array space.  A crafted length
    walks `tlv` past the buffer; the next iteration reads tlv[0]/tlv[1]
    from adjacent memory.

The llcp_tlv8() and llcp_tlv16() accessors additionally read tlv[2]
and tlv[2..3]; a zero-length TLV makes those reads out of bounds.

Fix: promote `offset` to u16; add two per-iteration guards, one for
the TLV header and one for the TLV value; require length >= 1 for all
TLVs before the type dispatch and length >= 2 for the llcp_tlv16()
accessors (MIUX, WKS).  Return -EINVAL on malformed input.

Reached on ATR_RES (parse_gb_tlv) and on CONNECT/CC PDUs before a
connection is established (parse_connection_tlv).  Both are
triggerable from any NFC peer within ~4 cm, without authentication.

Reported-by: Simon Horman <horms@kernel.org>
Fixes: d646960f7986 ("NFC: Add LLCP sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
---
 net/nfc/llcp_commands.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 291f26fac..b6dcfb2d1 100644
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
 
@@ -201,8 +202,14 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 		return -ENODEV;
 
 	while (offset < tlv_array_len) {
+		if (tlv_array_len - offset < 2)
+			return -EINVAL;
 		type = tlv[0];
 		length = tlv[1];
+		if (tlv_array_len - offset - 2 < length)
+			return -EINVAL;
+		if (length < 1)
+			return -EINVAL;
 
 		pr_debug("type 0x%x length %d\n", type, length);
 
@@ -211,9 +218,13 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 			local->remote_version = llcp_tlv_version(tlv);
 			break;
 		case LLCP_TLV_MIUX:
+			if (length < 2)
+				return -EINVAL;
 			local->remote_miu = llcp_tlv_miux(tlv) + 128;
 			break;
 		case LLCP_TLV_WKS:
+			if (length < 2)
+				return -EINVAL;
 			local->remote_wks = llcp_tlv_wks(tlv);
 			break;
 		case LLCP_TLV_LTO:
@@ -243,7 +254,8 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 				  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -251,13 +263,21 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 		return -ENOTCONN;
 
 	while (offset < tlv_array_len) {
+		if (tlv_array_len - offset < 2)
+			return -EINVAL;
 		type = tlv[0];
 		length = tlv[1];
+		if (tlv_array_len - offset - 2 < length)
+			return -EINVAL;
+		if (length < 1)
+			return -EINVAL;
 
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
 		case LLCP_TLV_MIUX:
+			if (length < 2)
+				return -EINVAL;
 			sock->remote_miu = llcp_tlv_miux(tlv) + 128;
 			break;
 		case LLCP_TLV_RW:
-- 
2.51.0


