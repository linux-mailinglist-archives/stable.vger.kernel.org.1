Return-Path: <stable+bounces-265752-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n1hPMjGPMWrWmgUAu9opvQ
	(envelope-from <stable+bounces-265752-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:00:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F354693B75
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 20:00:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=SbzMSQnb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265752-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-265752-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8591E307599D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31D0C47CC82;
	Tue, 16 Jun 2026 18:00:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A0030B535;
	Tue, 16 Jun 2026 18:00:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781632803; cv=none; b=k6RcVd9QeRPPOOkMrLQUB+Vkm+70+ClwrWqRRNiR/L/7LNZO5bVWExzUQpfsw/3OJ4JxOFhI2ZcRbar7JZzyJFFV881GL6PmVOhiFs/m5Pi1kQ8JdB9rXgNXxB00jgn1xQgJwB7cXwyTlhb0RAT549WNQGboL0mymEbmLkyuLrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781632803; c=relaxed/simple;
	bh=I8tVX8mc0EOzEz+BxKt1cfA3U4w/LrzrQetDRLve8Us=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5a0/TZ+AN75zElsfenNcdF03Us/KHBGSWTW55dWd4Kv2jabTNe6DtW9HjHut5fYDPMrT4wZKi/WSkdFuJJlFiYMMsvwhOpsUyFQ/5UQSC2ZG1jaiufUKdBrn7JkmRdzVsTkHO17YlFlXff1FoJCPV3XtiMkYs0d7AIK0WzP7aY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SbzMSQnb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E783F1F00A3A;
	Tue, 16 Jun 2026 18:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781632801;
	bh=Ct/vAThfaB6pPO12Ku5UxeFkRtvYVnEEh/p4nWr2qtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SbzMSQnbqxiRFT+WaoOUL7FiZq9ovjc3z0iyrrIovlTY7Uay4dc6mcw8tT6OmuPLh
	 1IE+O07+lxxqDc5hXpiek0bu87I2pmI3xrXEzwqe678yiM4vF+wzvYOysSCNvrrjLP
	 ljFG93MRX3oXjTP7JgyC5e07mIKG5L6xWhjFt7CI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 446/522] mptcp: do not drop partial packets
Date: Tue, 16 Jun 2026 20:29:53 +0530
Message-ID: <20260616145146.794560883@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145125.307082728@linuxfoundation.org>
References: <20260616145125.307082728@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-265752-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:shardul.b@mpiricsoftware.com,m:pabeni@redhat.com,m:matttbe@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F354693B75

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shardul Bankar <shardul.b@mpiricsoftware.com>

[ Upstream commit 50c2d91c5dfa0e465826ec1f8dbad9cdc254bd85 ]

When a packet arrives with map_seq < ack_seq < end_seq, the beginning
of the packet has already been acknowledged but the end contains new
data. Currently the entire packet is dropped as "old data," forcing
the sender to retransmit.

Instead, skip the already-acked bytes by adjusting the skb offset and
enqueue only the new portion. Update bytes_received and ack_seq to
reflect the new data consumed.

A previous attempt at this fix has been sent by Paolo Abeni [1], but had
issues [2]: it also added a zero-window check and changed rcv_wnd_sent
initialization, which caused test regressions. This version addresses
only the partial packet handling without modifying receive window
accounting.

Fixes: ab174ad8ef76 ("mptcp: move ooo skbs into msk out of order queue.")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/c9b426a4e163aa3c4fe8b80c79f1a610f47ae7d8.1763075056.git.pabeni@redhat.com [1]
Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/600 [2]
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
[pabeni@redhat.com: update map]
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20260515-net-mptcp-misc-fixes-7-1-rc4-v2-1-701e96419f2f@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ changed `skb_set_owner_r()` to `mptcp_set_owner_r()` and dropped the absent `msk->bytes_received` ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -400,10 +400,25 @@ static bool __mptcp_move_skb(struct mptc
 		return false;
 	}
 
-	/* old data, keep it simple and drop the whole pkt, sender
-	 * will retransmit as needed, if needed.
+	/* Completely old data? */
+	if (!after64(MPTCP_SKB_CB(skb)->end_seq, msk->ack_seq)) {
+		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+		mptcp_drop(sk, skb);
+		return false;
+	}
+
+	/* Partial packet: map_seq < ack_seq < end_seq.
+	 * Skip the already-acked bytes and enqueue the new data.
 	 */
-	MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
+	copy_len = MPTCP_SKB_CB(skb)->end_seq - msk->ack_seq;
+	MPTCP_SKB_CB(skb)->offset += msk->ack_seq - MPTCP_SKB_CB(skb)->map_seq;
+	MPTCP_SKB_CB(skb)->map_seq += msk->ack_seq -
+				      MPTCP_SKB_CB(skb)->map_seq;
+	WRITE_ONCE(msk->ack_seq, msk->ack_seq + copy_len);
+
+	mptcp_set_owner_r(skb, sk);
+	__skb_queue_tail(&sk->sk_receive_queue, skb);
+	return true;
 drop:
 	mptcp_drop(sk, skb);
 	return false;



