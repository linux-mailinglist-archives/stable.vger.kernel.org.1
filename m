Return-Path: <stable+bounces-237987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NubKJ/P3ml0IgAAu9opvQ
	(envelope-from <stable+bounces-237987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:37:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 519F63FF11F
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:37:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E6313030BBD
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED3D3CB2F0;
	Tue, 14 Apr 2026 23:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="IspQtOly"
X-Original-To: stable@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster5-host10-snip4-10.eps.apple.com [57.103.72.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943783CAE90
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776209778; cv=none; b=X4pRDRINFxSuFvX1T8T605M5RYW3250kacm4VHsGYQsHrxYMBZjxcDuDVaS47elVK3z120f70RyUwgIXO1s33oA0V05QI0ZhUTWO9HKPpUL7n+7muOAgwpKCd1pM6SQQokAcIo27XiUtgdohmQQRGa6Z3OxxzPgbpCso25RyF68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776209778; c=relaxed/simple;
	bh=/is+ISiFTsGRxrCqkX2ae/QgdazHgSMWgrCeT+K+ACs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s5v+2oV04OlHhVvVR7Z1OW4fNKgIALFy4/l6fqaxWOZiFgPbzTVijJW+U2f/hvgMeAv45v3ZqHulPmOiIVhTIeSI46XEw9GvRFrXGw/yYcZRJ5RLl7fgXHCyk+HwLG9G6M9j1cWYfPipba8747x/O4cqdg3n4U3LdlvjU5sFC/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=IspQtOly; arc=none smtp.client-ip=57.103.72.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPS id 9B77018000B6;
	Tue, 14 Apr 2026 23:36:15 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1776209777; x=1778801777; bh=sMfRl873E8ikWe9vuUyT4zRihNQqfNfGBczSTfHe588=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=IspQtOlyKTFTFmwTgQKcra6JTEnqlJj3jilwRwmxlofMI4ePBdITfLV07CLoDd/Vgb0v9Y1KONUy0DIdwFIlx1tWEYii/pbw6yGJShEJi4dvOjxTWZqbpmYIIYSRHZkR2AvypHNKjQyx/fS6UBRSxrYlOht7GrmYkki+IB3VjztfHRi46Xzld4zdB7K+OxW88PFNVBcfTAYfOPt0uNRtujf1fCIVi6WqtNstjvTX5asbQCLCg/Lp//hqqEXHUz085foSNKneNMkVbh4aBL0jrta+vRrD6jUZBy++swNixyi/2eKQQBN+bCtPY6xEe1eNM201Pp38kFif8TA4DMcU2g==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-100-percent-8 (Postfix) with ESMTPSA id 41B0E18000CF;
	Tue, 14 Apr 2026 23:36:13 +0000 (UTC)
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
Subject: [PATCH net v3 4/4] nfc: llcp: fix OOB read of DM reason byte in nfc_llcp_recv_dm
Date: Wed, 15 Apr 2026 01:35:33 +0200
Message-ID: <20260414233534.55973-5-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: HP_WtEuZwVDPRcYWtqQSVaFmedxO7wr5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE0MDIyMCBTYWx0ZWRfXwnS9KvTpitHk
 jFlo7Pa+Y7ZuBNaz91LkLE1+cE/rt0psETdVF4gTP90dYGqmZ9XB2eDSNNRO6h7J8W2prxiMs+1
 EusPC4PmxotKI0HIaQTO7QEQodju/Rz6ZeYKMMUfJQq7GmFlkp6g/QsM3SE0cplyGcIu1EtBU4H
 9pSwKddB895K+IQvCsqqf5MpBbR9zu44i1Wp9xgiLnP4G3YnOWnd8ADUtPn6Cu7clEkyt3fP+Qq
 /EoyFx6K7z/HOybtKUaEbDrWQwMEbUWipTnK/HYQyFSbSCqgw7BgVxh+XDO8KC+FtFnLGfrWDpa
 16rqccG79W9Nlrn21649V//2uzRRHYfTm+ka4F3ZYTgunqEIEaj9WPgWaXOVyQ=
X-Authority-Info-Out: v=2.4 cv=Xqr3+FF9 c=1 sm=1 tr=0 ts=69decf70
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=VwQbUJbxAAAA:8
 a=DIMQZ1PCNJLnr07J7f4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HP_WtEuZwVDPRcYWtqQSVaFmedxO7wr5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-14_04,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 phishscore=0 mlxscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2604140220
X-Spamd-Result: default: False [-0.63 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MIXED_CHARSET(0.53)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,outlook.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237987-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[icloud.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[icloud.com:dkim,icloud.com:mid,outlook.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 519F63FF11F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lekë Hapçiu <framemain@outlook.com>

nfc_llcp_recv_dm() reads skb->data[2] (the DM reason byte) without
first verifying that skb->len is at least LLCP_HEADER_SIZE + 1.  A DM
PDU carrying only the 2-byte LLCP header from a rogue peer therefore
triggers a 1-byte OOB read.

Add the minimum-length guard at function entry, matching the pattern
used by nfc_llcp_recv_snl() and nfc_llcp_recv_agf().

Reachable from any NFC peer within ~4 cm once an LLCP link is up.

Fixes: d646960f7986 ("NFC: Add LLCP sockets")
Cc: stable@vger.kernel.org
Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
---
 net/nfc/llcp_core.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index efe228f96..6baf2fc6b 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1237,6 +1237,11 @@ static void nfc_llcp_recv_dm(struct nfc_llcp_local *local,
 	struct sock *sk;
 	u8 dsap, ssap, reason;
 
+	if (skb->len < LLCP_HEADER_SIZE + 1) {
+		pr_err("Malformed DM PDU\n");
+		return;
+	}
+
 	dsap = nfc_llcp_dsap(skb);
 	ssap = nfc_llcp_ssap(skb);
 	reason = skb->data[2];
-- 
2.51.0


