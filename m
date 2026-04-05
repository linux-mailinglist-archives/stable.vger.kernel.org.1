Return-Path: <stable+bounces-233334-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GHILf2Q0mnEYwcAu9opvQ
	(envelope-from <stable+bounces-233334-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 18:42:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2FB39F019
	for <lists+stable@lfdr.de>; Sun, 05 Apr 2026 18:42:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CA3E3009B2E
	for <lists+stable@lfdr.de>; Sun,  5 Apr 2026 16:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CE830F533;
	Sun,  5 Apr 2026 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="XrZMsvlF"
X-Original-To: stable@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster5-host11-snip4-10.eps.apple.com [57.103.72.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C029C325
	for <stable@vger.kernel.org>; Sun,  5 Apr 2026 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.72.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775407343; cv=none; b=obDdVaXhwx5VdCKC2E8iywrN6N6HVTi5cH1ghNIvWBknB2vV3viJW1JORD72YSeskRbKHO7sQLlaLfTGR7rdiBYRBormKrWR3nNHpmRl2fWQDdUgs3HFSY/mRUj3TfpXGobQAY60rIyAG5OTLpqOl1Ty2UljlZfMXnXfUi91czs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775407343; c=relaxed/simple;
	bh=Y0UQaiHmPnncAF/zZh73pPUIUWDh5M4/Wvgn6QhVFwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bt+CZbb3vf+AwXdMUuzqQwfkunb4sgS1KpN/6RgFKdLQqcMZea69eGZEbKbyQHUhz8Zu+MAAuUQYHM7c5PO8ZQZ8lFWGKIg4j/gX1vRFeLI7XoKcsgKoBxorwVuOUbOEvDFPG9/3aouxS1tY+ku/0hoBfY8CdtiSdkH0kXJTt0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com; spf=pass smtp.mailfrom=icloud.com; dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b=XrZMsvlF; arc=none smtp.client-ip=57.103.72.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=icloud.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-2 (Postfix) with ESMTPS id E77BF1800210;
	Sun, 05 Apr 2026 16:42:18 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com; s=1a1hai; t=1775407340; x=1777999340; bh=Zh9QbdXIogGNv1FXpgmqUGlv02EpGeQeAagJ0ahOZdc=; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:x-icloud-hme; b=XrZMsvlFkCZgbouqeNcqOU0tYuzgiN1cK+EVuW80QihcHbWrMI6BYhqjN96G6kv1jxlV61ZOUXoxiq/60mep7ELeZLSRUT9GnaL1dkd0lxRvlOdRlV+t478BstGoui8JxDfEzLvwrveRHZTvRRVxHz2efoLyxWUrRP59QGvUS2kaDrvjwUdSh4qZ6+grKK4kOKkhD4UrEV/aOC308uTQyDl1IkmHIjK6XtqAF+juh7kRDTG1aLNMwuDqlqLlZ7hVWxekfEJ5MwlrNHeyOCQOs7Jx7HmfnhfFyL7CBhfOhOsiyAAHhZTs2qRGNALCFJScP6TBFApLlQWYvgxjq8p0HQ==
Received: from mainframe.tailfb0f7b.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-2 (Postfix) with ESMTPSA id 14C1618000B4;
	Sun, 05 Apr 2026 16:42:16 +0000 (UTC)
From: =?UTF-8?q?Lek=C3=AB=20Hap=C3=A7iu?= <snowwlake@icloud.com>
To: netdev@vger.kernel.org
Cc: linux-nfc@lists.01.org,
	davem@davemloft.net,
	kuba@kernel.org,
	krzysztof.kozlowski@linaro.org,
	stable@vger.kernel.org
Subject: [PATCH] nfc: llcp: fix missing return after LLCP_CLOSED check in recv_hdlc and recv_disc
Date: Sun,  5 Apr 2026 18:41:58 +0200
Message-ID: <20260405164158.1344049-1-snowwlake@icloud.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDE3NCBTYWx0ZWRfXwaJMLvmjHcyM
 iteWLSB+zPYt1yn2ijBwWygUkQry8C4NmplEgDOVY/6FMSe98v8sslioWSv80zqZhUb54BejvOd
 3Vx4sniSAmJc8DOCetJCPBe3/tDxiLM4Xvw7i6sAlWjhHyxoxlFD4G9G9SXcYGTdy/pScRQNAfE
 SI32/Nj0dUyEBsicw+FuPcX4Ns8F3ySav5GMxtBdXLFsGu/m5NZxxeMn6FsVDEVdnzQsTyn9CuK
 U0zxTLDjqhbJX407w8a7n4u5l40dMTTghpEKGTOpx5tF41AbYVn+ZndWr7Zsavt46lTtf67d6GM
 RjHQBaM880CH5taldXh+SIi7A3mUJF4IT0wUsAJn2YlvPqRB6JrweyqkQ9l/Fs=
X-Proofpoint-ORIG-GUID: 5kUpoHUTrgNbkz3uJq1YuumaqrWNyYtO
X-Proofpoint-GUID: 5kUpoHUTrgNbkz3uJq1YuumaqrWNyYtO
X-Authority-Info-Out: v=2.4 cv=Z5nh3XRA c=1 sm=1 tr=0 ts=69d290eb
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=IkcTkHD0fZMA:10
 a=A5OVakUREuEA:10 a=M51BFTxLslgA:10 a=x7bEGLp0ZPQA:10 a=LbuW6tbUWPcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=UqCG9HQmAAAA:8 a=aHyeSshMfSEOfJyjs9cA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_05,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 malwarescore=0 clxscore=1011 phishscore=0 mlxlogscore=999
 suspectscore=0 spamscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2604050174
X-Spamd-Result: default: False [-0.53 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.63)[subject];
	DMARC_POLICY_ALLOW(-0.50)[icloud.com,quarantine];
	R_DKIM_ALLOW(-0.20)[icloud.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233334-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[icloud.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[icloud.com];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[snowwlake@icloud.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Queue-Id: DD2FB39F019
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Lekë Hapçiu <framemain@outlook.com>

nfc_llcp_recv_hdlc() and nfc_llcp_recv_disc() both call
nfc_llcp_sock_get() (which increments the socket reference count) and
lock_sock() before processing incoming PDUs.  When the socket is found
to be in state LLCP_CLOSED both functions correctly call release_sock()
and nfc_llcp_sock_put() to undo those operations, but are missing a
return statement:

    lock_sock(sk);
    if (sk->sk_state == LLCP_CLOSED) {
        release_sock(sk);
        nfc_llcp_sock_put(llcp_sock);
        /* ← return missing */
    }
    /* Falls through with lock released and reference dropped */
    ...
    release_sock(sk);            /* double unlock */
    nfc_llcp_sock_put(llcp_sock); /* double put → refcount underflow */

The fall-through causes three independent bugs:

  1. Use-after-free: all llcp_sock field accesses after the LLCP_CLOSED
     block occur with the socket lock released and the reference dropped;
     another CPU may free the socket concurrently.

  2. Double release_sock: sk_lock.owned is already 0 — LOCKDEP reports
     "WARNING: suspicious unlock balance detected".

  3. Double nfc_llcp_sock_put: the refcount is decremented a second time
     at the end of the function, potentially driving it below zero
     (refcount_t underflow), corrupting the SLUB freelist and causing a
     subsequent use-after-free or double-free.

Both functions are reachable from any NFC P2P peer within physical
proximity (~4 cm) without hostile NFCC firmware:
  - nfc_llcp_recv_hdlc: triggered by sending an LLCP I, RR, or RNR PDU
    to a SAP pair whose connection has been torn down.
  - nfc_llcp_recv_disc: triggered by sending an LLCP DISC PDU to a SAP
    pair that is already in LLCP_CLOSED state.

Fix: add the missing return statement in both functions so that the
LLCP_CLOSED branch exits after cleanup.

Fixes: Introduced with nfc_llcp_recv_hdlc / nfc_llcp_recv_disc
Signed-off-by: Lekë Hapçiu <framemain@outlook.com>
---
 net/nfc/llcp_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 366d75663..db5bc6a87 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1091,6 +1091,7 @@ static void nfc_llcp_recv_hdlc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	/* Pass the payload upstream */
@@ -1182,6 +1183,7 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 	if (sk->sk_state == LLCP_CLOSED) {
 		release_sock(sk);
 		nfc_llcp_sock_put(llcp_sock);
+		return;
 	}
 
 	if (sk->sk_state == LLCP_CONNECTED) {
-- 
2.51.0


