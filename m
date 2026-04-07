Return-Path: <stable+bounces-233695-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMSwFEY81WlY3AcAu9opvQ
	(envelope-from <stable+bounces-233695-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:17:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C1E3B2455
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:17:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF8473056D3A
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320F534252B;
	Tue,  7 Apr 2026 17:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Wxd84ybw";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="SNLzR2Pj"
X-Original-To: stable@vger.kernel.org
Received: from mout-y-209.mailbox.org (mout-y-209.mailbox.org [91.198.250.237])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CE12BE035;
	Tue,  7 Apr 2026 17:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.237
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582204; cv=none; b=DrG5bCAdgQXpjPUBFpWfr5pR1pVE3o83tXd1hX3+LmmMsMQdeg60wXOVf07DwXt1XzI+h5O0E0D5FY8lrVCxUy0QW9guUKoRcvgOyN+34E1ghDdbIepjIDTmVhWqfRNpIyRxcNgdvJEWq63Le5Bdlh6yWkJITkosOckDDEBlrws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582204; c=relaxed/simple;
	bh=S1s7t0qxPLR+Wu6IrpCWOCzO0KI6aMMAIzbPhQze8dE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nuN6Ihv0tmaQ95r2QcSCv34KDvHu7cVQk0pRXO6AA7K4aKool/eEBUNE08WYnUckglFhUwLbOAstB+HaY6aoiLI0S7W0WUIj1aZqAp4jRyakPHVOtWrGWmwegzttYu4A1wulGrnujm1zkbuUeiyLAQn1gYQJSMIWEHPEfMiFUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Wxd84ybw; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=SNLzR2Pj; arc=none smtp.client-ip=91.198.250.237
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-209.mailbox.org (Postfix) with ESMTPS id 4fqtCW33JzzB13t;
	Tue,  7 Apr 2026 19:16:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775582199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1v6l6ggIcHGJfAXaqraM+g7rypwRkEBNny4DxxaeFHE=;
	b=Wxd84ybwa0vwd7wfgOrNz99RYXoeEJL/QYt2ZYsHw69O+gGDBkRWi2anUFQs46BYhcPYYK
	RdrqlTbV3GFlRA9uK2E1esohFjf8OjHCjitEZkqGZ8skx41C+7bmqYmAp9ouS7arzBJECw
	jJ6ge+Pnvkw8GGSHds/gYLB0gRy3OUdWRWPWOEL6zsnwTbNBs+m1qmpbWcxyoTIAXNaGRn
	8xVDALU1fjbiTdEoVS3Uy8Hg+nvitEvbiu6PFqgmNWwS3FSndKloRrWrnP013gMHh7V/Zr
	1vIMiqwFtiqRfEVwKvOY05KjW1ke1eHhZ8Ir4kGfGr19RXNenDvwH9+p9n+hPA==
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775582197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1v6l6ggIcHGJfAXaqraM+g7rypwRkEBNny4DxxaeFHE=;
	b=SNLzR2Pjkvz6NOy/qSjz8Ljq6rlDMATii2ek2l0d9W4XJ04KYlD99ujK3evcZGouXDJTCf
	W/w8BfJMW3JErSel8vcVxKWcYZUnsZ79I4ItuIgzF87f5MJfOq+uV7ynNPYGY2hU8NzA0n
	yHpEStwcjVWb32R8/JXyl+3RM8/opucVqdw8qUk62eHJGPS+ffe5ihKR9qoSVSta3Oi+aw
	jWmIBovhp77EvuTH5C0e/FgGjp4P/pire+BirvLvYBFf0qqAgu7YeySltWyeU9JTO78jbk
	/+9NHZQQp4YEghvcnc8jX2dVPjwkFSCCS/wlIABNtDXgJuFzcvFNRXbww8vn1A==
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	gregkh@linuxfoundation.org,
	ben@decadent.org.uk,
	linux-hams@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>
Subject: [PATCH 1/3] net: netrom: fix integer overflow in nr_queue_rx_frame()
Date: Wed,  8 Apr 2026 01:15:58 +0800
Message-ID: <20260407171600.102988-2-mashiro.chen@mailbox.org>
In-Reply-To: <20260407171600.102988-1-mashiro.chen@mailbox.org>
References: <20260407171600.102988-1-mashiro.chen@mailbox.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 9eca7da4d5761a80a81
X-MBO-RS-META: jrbyq1cbex73jz6jbqfz1d1wpz88kr4g
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233695-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mashiro.chen@mailbox.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mailbox.org:dkim,mailbox.org:email,mailbox.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E3C1E3B2455
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nr_sock.fraglen is declared as unsigned short, so accumulating
received fragment lengths via

    nr->fraglen += skb->len;

can silently wrap around to a small value once the total exceeds
65535 bytes. When the final fragment arrives (NR_MORE_FLAG clear),
the wrapped fraglen is passed to alloc_skb(), which allocates an
undersized buffer. The subsequent skb_put() and skb_copy_from_linear_data()
loop then writes the actual full data into it, resulting in a heap
buffer overflow.

An attacker with NR_STATE_3 access (i.e. after completing a NET/ROM
connection handshake, which open BBS/node services allow to any
callsign) can trigger this by sending a stream of NR_INFO frames
with the MORE flag set until fraglen wraps, followed by a final
NR_INFO frame.

Fix by checking whether adding the incoming skb's length to the
accumulated fraglen would exceed USHRT_MAX before each accumulation.
If so, purge the fragment queue, reset fraglen, and return an error
to signal receive-busy to the caller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 net/netrom/nr_in.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/netrom/nr_in.c b/net/netrom/nr_in.c
index 97944db6b5ac6..0b7cdb99ae501 100644
--- a/net/netrom/nr_in.c
+++ b/net/netrom/nr_in.c
@@ -36,12 +36,22 @@ static int nr_queue_rx_frame(struct sock *sk, struct sk_buff *skb, int more)
 	nr_start_idletimer(sk);
 
 	if (more) {
+		if ((unsigned int)nr->fraglen + skb->len > USHRT_MAX) {
+			skb_queue_purge(&nr->frag_queue);
+			nr->fraglen = 0;
+			return 1;
+		}
 		nr->fraglen += skb->len;
 		skb_queue_tail(&nr->frag_queue, skb);
 		return 0;
 	}
 
 	if (!more && nr->fraglen > 0) {	/* End of fragment */
+		if ((unsigned int)nr->fraglen + skb->len > USHRT_MAX) {
+			skb_queue_purge(&nr->frag_queue);
+			nr->fraglen = 0;
+			return 1;
+		}
 		nr->fraglen += skb->len;
 		skb_queue_tail(&nr->frag_queue, skb);
 
-- 
2.53.0


