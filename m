Return-Path: <stable+bounces-229662-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IJKhBklswWlMTAQAu9opvQ
	(envelope-from <stable+bounces-229662-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:37:29 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2BB2F874B
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E039311FA7F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90A03BE654;
	Mon, 23 Mar 2026 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h6/FFJdX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B7D3BC660;
	Mon, 23 Mar 2026 16:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774282528; cv=none; b=VfBSFAUWdI64em2meGzlDcxHVDfk5VDuu/fMlHxAviYchV/Lbtz4BjDj2etMHxSO2aKXIaMCbcBkZsnLAmoClYP29S16OiisPmsD3Iohmz7CO+6UwnNRaC+nqL0xNyQL2i5YZV7xfzgbor50rAcQemBLC8V6yPFrvnm47lhOEkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774282528; c=relaxed/simple;
	bh=RuzuViJVscIhFb/3/SseORJKZrhPNd1rBDtJBjG//bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ECfTG0x396yC63nRnwe0cSHGmko0dMvyKme3QhtOnPYLi9IFMMjksNWnCnUlB1x1BgFqZCTN3tLXIcL4Su9NzLqIjHH9y71P/CqoXeNd+5875fc+i0ruo3YExgWQgSrI5p0PrMm/6+IzA67tmDZaUmwgWI15F9HQX0owb3/jLuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h6/FFJdX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27EB0C2BCB0;
	Mon, 23 Mar 2026 16:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774282528;
	bh=RuzuViJVscIhFb/3/SseORJKZrhPNd1rBDtJBjG//bA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h6/FFJdXM2ibmM87SXys7VWO3L4nRXqrSHuW11OHR+3s73kPkrgBe/YzeN6KMFZdz
	 mzJ3odGcvD0ZvwbORwhhp5Mg6WrlCsTrwpxy76XKv+iLXFVjUeJUpD245xIsp8IvdX
	 wIcrVIYoJol1AxXoG9HHk+A8ObkvxhIeoWgYh52Q=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Menglong Dong <menglong8.dong@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 145/481] net: tcp: accept old ack during closing
Date: Mon, 23 Mar 2026 14:42:07 +0100
Message-ID: <20260323134528.789809217@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229662-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 5D2BB2F874B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Menglong Dong <menglong8.dong@gmail.com>

commit 795a7dfbc3d95e4c7c09569f319f026f8c7f5a9c upstream.

For now, the packet with an old ack is not accepted if we are in
FIN_WAIT1 state, which can cause retransmission. Taking the following
case as an example:

    Client                               Server
      |                                    |
  FIN_WAIT1(Send FIN, seq=10)          FIN_WAIT1(Send FIN, seq=20, ack=10)
      |                                    |
      |                                Send ACK(seq=21, ack=11)
   Recv ACK(seq=21, ack=11)
      |
   Recv FIN(seq=20, ack=10)

In the case above, simultaneous close is happening, and the FIN and ACK
packet that send from the server is out of order. Then, the FIN will be
dropped by the client, as it has an old ack. Then, the server has to
retransmit the FIN, which can cause delay if the server has set the
SO_LINGER on the socket.

Old ack is accepted in the ESTABLISHED and TIME_WAIT state, and I think
it should be better to keep the same logic.

In this commit, we accept old ack in FIN_WAIT1/FIN_WAIT2/CLOSING/LAST_ACK
states. Maybe we should limit it to FIN_WAIT1 for now?

Signed-off-by: Menglong Dong <menglong8.dong@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://lore.kernel.org/r/20240126040519.1846345-1-menglong8.dong@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/tcp_input.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6630,17 +6630,21 @@ int tcp_rcv_state_process(struct sock *s
 		return 0;
 
 	/* step 5: check the ACK field */
-	acceptable = tcp_ack(sk, skb, FLAG_SLOWPATH |
-				      FLAG_UPDATE_TS_RECENT |
-				      FLAG_NO_CHALLENGE_ACK) > 0;
+	reason = tcp_ack(sk, skb, FLAG_SLOWPATH |
+				  FLAG_UPDATE_TS_RECENT |
+				  FLAG_NO_CHALLENGE_ACK);
 
-	if (!acceptable) {
+	if ((int)reason <= 0) {
 		if (sk->sk_state == TCP_SYN_RECV)
 			return 1;	/* send one RST */
-		tcp_send_challenge_ack(sk);
-		SKB_DR_SET(reason, TCP_OLD_ACK);
-		goto discard;
+		/* accept old ack during closing */
+		if ((int)reason < 0) {
+			tcp_send_challenge_ack(sk);
+			reason = -reason;
+			goto discard;
+		}
 	}
+	SKB_DR_SET(reason, NOT_SPECIFIED);
 	switch (sk->sk_state) {
 	case TCP_SYN_RECV:
 		tp->delivered++; /* SYN-ACK delivery isn't tracked in tcp_ack */



