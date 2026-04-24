Return-Path: <stable+bounces-241018-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHHpDpWw62mRQQAAu9opvQ
	(envelope-from <stable+bounces-241018-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:04:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3AF64623CD
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C97D4301ECC5
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBA4F3D567B;
	Fri, 24 Apr 2026 18:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="Q8PxS9h4"
X-Original-To: stable@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster6-host6-snip4-1.eps.apple.com [57.103.75.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9F933ADBA
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.75.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777053786; cv=none; b=N+hUmbhwfqvaXZFSDSzyRFm6ZcMbvDgz22xcmJ2m36aWsem6Zv/wMVshQgS6JzlbwrjyvxbYPNlWgeYWawlcGnHJQT5RQovMnSZepACrS2ywbMLWLv4RF4b2d5tKkNZxBA4Gx1tILLOBX3rFHmJM/FYrjHtj+rtdyD9R9EUthx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777053786; c=relaxed/simple;
	bh=wk6jxo0ixtins3iKYFIbBO+IaQ3FUKR0X6l4zbnfgQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S0hmd0ExCOMMMcbR7t0eaAyfOXnOHjfiZ9NM99w8bBFmVW+Od8hth6AMqjZM4N2wxDw2f5bXfEWYBUu2iPbEDS8A5EA+YnbFtKcIou3iI1b4ttmLWZ9oqruOfU0+qWAKLQcLXfq+73bVKY3ZRzE9ZSPMyk2n7l429djyEjGK4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=Q8PxS9h4; arc=none smtp.client-ip=57.103.75.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-10 (Postfix) with ESMTPS id EE81D1800E80;
	Fri, 24 Apr 2026 18:03:02 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMEWwJACUgBTUQeDx5WFlZNRAJCTQ1OHVQORQNFF0sCTVIPDwNXF0QaWwpZFXkRUAFYHlZeWhdeTVEPDwNXF0QaWwpZFXkRUAFYHlZeWhdeTUUID0EJWFsIWwQPH0wMUQJCBVZeVAsdBFQHXQVdVlACWktCBEtFaFwFXBxAF0gdX2pLVhQEEVABWB5WXloXXk1aAlZNBUoDXwFbBkINSQtdBl4DXgpAA1UCXgVdClVAA1gcRRxYE1YtXgheH0wcHQ5YBgxQTQFDCAoCURxWDVc=
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1777053785; x=1779645785; bh=8cTGoIG5Y+5O2PKMucfn2HjFrCCY/5lL7OPhN39fMkc=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=Q8PxS9h43H3UTAE2DV7gPekkDtAECmCADT7LofolmCUSJDOF1PTKoADbf/buJhfQGXev77WwST48cJPtzx+GYcxPoAtu+MR1Gs9bUykKlE46CDZQRP4uvAsbfeT7L4OcS+X8Fm9eB5op/Q/dRky2Gr8GRp/gsYA18f1+2D1Ry3EbOkOD++Cr4VvR4Qhm2ulHs5ybS7PKTq8sQToKMXRc0csvK5a2LTu0NgDB3n4QkOjadOntK/16gRjeNC6XoC/FENR9G/F4g2/efn4gbDdsgLMnR/9DyonQKYlbWdp6M9WsIOgt/agtnzFft0/juZGlUd+T4r+jeNb0Jk7zO5uXwg==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-10 (Postfix) with ESMTPSA id 5B4A71800E90;
	Fri, 24 Apr 2026 18:02:59 +0000 (UTC)
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
Subject: [PATCH net v4 2/5] nfc: llcp: fix TLV parsing in parse_gb_tlv and parse_connection_tlv
Date: Fri, 24 Apr 2026 20:01:48 +0200
Message-ID: <20260424180151.3808557-3-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=H4TWAuYi c=1 sm=1 tr=0 ts=69ebb057
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=v3ZZPjhaAAAA:8
 a=xt1Mke5GkH6e2Q2BLK4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE3NiBTYWx0ZWRfX+oOZNkFYjhoz
 5k+PqNV2QRJK9YbrsuN+WSzRvkv5TVSJvw0w+wW52nsb4voKzIQkijNi7Ey0MppNTMn9cosy+aK
 vsI+ePxBfvoJqkJj381dGcvurzhHp8fc/Wx2BVa2MG/5hKZaACUuHa5BML4/aEVo89vWDW/UdJL
 kXD9yOK6+Q7+GYSiaAR8PvOSWyo8EpVAJzx0q2sJfR+pReH90Z78aiFOnLuEojScD+HddPUTmhW
 ZE5y6VEKrIpg72XKqNX53D2TnHk8di+wrmLgvkBunGdmFFWeBbDOfI33d4qoUC8ELJHL27pKHt9
 vY/h0lxYdAsrlxGgjJPxhgwzgtY3S5fC8qCEDal21qoLO0avkFULKHIV2/FPgI=
X-Proofpoint-GUID: W8ViIE_GHFq-ET-fGKftx6Run2wTPLgG
X-Proofpoint-ORIG-GUID: W8ViIE_GHFq-ET-fGKftx6Run2wTPLgG
X-Rspamd-Queue-Id: C3AF64623CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.57 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.59)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[icloud.com:+];
	TAGGED_FROM(0.00)[bounces-241018-lists,stable=lfdr.de];
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

Reported-by: Simon Horman <horms@kernel.org>
Closes: https://lore.kernel.org/netdev/20260417160438.GH31784@horms.kernel.org/
Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <snowwlake@icloud.com>
---
 net/nfc/llcp_commands.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 291f26facbf3..b6dcfb2d175c 100644
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


