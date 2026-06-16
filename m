Return-Path: <stable+bounces-265195-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id bM3HA6WFMWpAlgUAu9opvQ
	(envelope-from <stable+bounces-265195-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:19:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A6692FF4
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 19:19:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=vnYrhEOR;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-265195-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-265195-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9D08C3090F86
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 17:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA654418D7;
	Tue, 16 Jun 2026 17:12:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E3B43E490;
	Tue, 16 Jun 2026 17:12:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781629952; cv=none; b=GArD4FovLP2L3Sn6g2kohk+hPPkoMPPjyei6PpBdkBW8K5SfUluvxnC4wUk+TCaXHb60wY23HYkJiYLKa3zOt8r/N8Pxm65ayW6XX/Z6iHhdvLduwo3EP5sLKTtGFi9zkqYXUgTNIFxtxTGJ/pJR0C3AOQMPTa6iLVvy6K8MHvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781629952; c=relaxed/simple;
	bh=dIlr+GdAKWB/khMSNEUjwmXfVopBJuHAIjeY+8qz5aA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QaUdj8ex1igYDxauxp6z7cpVoahscKoboKqwfgWxVO+S0cwc355Dwylm6IENL9d3qzhunvdLoheh/9McW8fkq41Yi5iGU2JbIkeRl5w70xPzq9WLW7+wbJnUsonSBLgEExVG2fT6XQnKHinGDUdwAmzNe0Zy2gYe1QXqDXYhTnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vnYrhEOR; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 551711F000E9;
	Tue, 16 Jun 2026 17:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781629951;
	bh=WjTq52tIrOKgXkqIp5pofP/lduXIovK61OPR7ewMFGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=vnYrhEORU/YlMutQULYrHzaS2Obr+ObjnqKKU2gtvMvbJQD3Ds2cjrWoSQc/d73d1
	 n0da6GVWTAgLKE+o6zdc6KJXPGhiPS6OSbaptVXgv2CMK4zwBDXU90c8m6VQ80prZr
	 QEIXWRgGMjziqgjCahf4WiWozBqjAJij8aY5qOyY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Geliang Tang <geliang@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 384/452] mptcp: cleanup fallback dummy mapping generation
Date: Tue, 16 Jun 2026 20:30:11 +0530
Message-ID: <20260616145137.097239506@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145117.796205997@linuxfoundation.org>
References: <20260616145117.796205997@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-265195-lists,stable=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:pabeni@redhat.com,m:geliang@kernel.org,m:martineau@kernel.org,m:matttbe@kernel.org,m:kuba@kernel.org,m:sashal@kernel.org,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 992A6692FF4

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paolo Abeni <pabeni@redhat.com>

[ Upstream commit 2834f8edd74d5dda368087a654c0e52b141e9893 ]

MPTCP currently access ack_seq outside the msk socket log scope to
generate the dummy mapping for fallback socket. Soon we are going
to introduce backlog usage and even for fallback socket the ack_seq
value will be significantly off outside of the msk socket lock scope.

Avoid relying on ack_seq for dummy mapping generation, using instead
the subflow sequence number. Note that in case of disconnect() and
(re)connect() we must ensure that any previous state is re-set.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Geliang Tang <geliang@kernel.org>
Tested-by: Geliang Tang <geliang@kernel.org>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Link: https://patch.msgid.link/20251121-net-next-mptcp-memcg-backlog-imp-v1-6-1f34b6c1e0b1@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 0981f90e1a05 ("mptcp: reset rcv wnd on disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mptcp/protocol.c |    3 +++
 net/mptcp/subflow.c  |    8 +++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -3331,6 +3331,9 @@ static int mptcp_disconnect(struct sock
 	msk->rcvspace_init = 0;
 	msk->fastclosing = 0;
 
+	/* for fallback's sake */
+	WRITE_ONCE(msk->ack_seq, 0);
+
 	WRITE_ONCE(sk->sk_shutdown, 0);
 	sk_error_report(sk);
 	return 0;
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -471,6 +471,9 @@ static void subflow_set_remote_key(struc
 	mptcp_crypto_key_sha(subflow->remote_key, NULL, &subflow->iasn);
 	subflow->iasn++;
 
+	/* for fallback's sake */
+	subflow->map_seq = subflow->iasn;
+
 	WRITE_ONCE(msk->remote_key, subflow->remote_key);
 	WRITE_ONCE(msk->ack_seq, subflow->iasn);
 	WRITE_ONCE(msk->can_ack, true);
@@ -1382,9 +1385,12 @@ reset:
 
 	skb = skb_peek(&ssk->sk_receive_queue);
 	subflow->map_valid = 1;
-	subflow->map_seq = READ_ONCE(msk->ack_seq);
 	subflow->map_data_len = skb->len;
 	subflow->map_subflow_seq = tcp_sk(ssk)->copied_seq - subflow->ssn_offset;
+	subflow->map_seq = __mptcp_expand_seq(subflow->map_seq,
+					      subflow->iasn +
+					      TCP_SKB_CB(skb)->seq -
+					      subflow->ssn_offset - 1);
 	WRITE_ONCE(subflow->data_avail, true);
 	return true;
 }



