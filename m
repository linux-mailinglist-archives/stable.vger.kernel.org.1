Return-Path: <stable+bounces-256992-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2PZrENgRG2qC+wgAu9opvQ
	(envelope-from <stable+bounces-256992-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:35:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC3660E471
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 18:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F197430B79BA
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 16:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDFD34BA53;
	Sat, 30 May 2026 16:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JjaA4Lgb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332C633F8A4;
	Sat, 30 May 2026 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780158492; cv=none; b=I65SBp4s7znq5pFU50A7agLcodAoLcbRyF+U3jM/9sXZZkUW063BfUXD2t7Tm5N6Ek7keC5XlS7wzIPsSqEuzvC2fDEconD3CqRPK6UpcTPjIiVz5v1DmJ+KE4Inm9Z5ZK3wXArNUf9fqY8+b/PioZdtFUTmu0QOgzeT69EXm28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780158492; c=relaxed/simple;
	bh=DpSGZyHFkynVNasfI/XyN5XTNY9HAWb2cWxRpaCM37M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/FoMHnPdG9iQzzE8xZfilRwLLNjP0fNX9zKyVV6IiWKdrD1fOlgdAuKwUH0JJbPIzAK16+QoEA9Poql5RtgkFU9RvLuKLPlV9CvIYPaybAdPy+WLT0xz2faLVRtTkWKdNIP1ddzgX4fdF/empm+/yXrE+N6UOafYNK92MOknmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JjaA4Lgb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 244971F00893;
	Sat, 30 May 2026 16:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780158491;
	bh=FHY8KN2DM+Pk+D3QZeRwuTgIyPB03xx8naHE2V6GkDE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JjaA4Lgb27C97IYa/HVuq7h/Zf7vdnA0nx3ltBUtdNXMRGAfNpRsHMMnPwUzJBS0C
	 zXig61grHl9AiDQqFptMGgO/BmF5GBW3tt933O6kdWeGNLzxosY8zLjDpdbLcLXEPr
	 PjihnN7x9HhmK+wNJ8tt+JgQkO1WVz88TAhboIDc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Samuel Page <sam@bynar.io>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH 6.1 057/969] can: raw: fix ro->uniq use-after-free in raw_rcv()
Date: Sat, 30 May 2026 17:53:01 +0200
Message-ID: <20260530160301.963862424@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256992-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hartkopp.net:email,msgid.link:url,bynar.io:email]
X-Rspamd-Queue-Id: 9AC3660E471
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Samuel Page <sam@bynar.io>

commit a535a9217ca3f2fccedaafb2fddb4c48f27d36dc upstream.

raw_release() unregisters raw CAN receive filters via can_rx_unregister(),
but receiver deletion is deferred with call_rcu(). This leaves a window
where raw_rcv() may still be running in an RCU read-side critical section
after raw_release() frees ro->uniq, leading to a use-after-free of the
percpu uniq storage.

Move free_percpu(ro->uniq) out of raw_release() and into a raw-specific
socket destructor. can_rx_unregister() takes an extra reference to the
socket and only drops it from the RCU callback, so freeing uniq from
sk_destruct ensures the percpu area is not released until the relevant
callbacks have drained.

Fixes: 514ac99c64b2 ("can: fix multiple delivery of a single CAN frame for overlapping CAN filters")
Cc: stable@vger.kernel.org # v4.1+
Assisted-by: Bynario AI
Signed-off-by: Samuel Page <sam@bynar.io>
Link: https://patch.msgid.link/26ec626d-cae7-4418-9782-7198864d070c@bynar.io
Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
[mkl: applied manually]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/can/raw.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -336,6 +336,14 @@ static int raw_notifier(struct notifier_
 	return NOTIFY_DONE;
 }
 
+static void raw_sock_destruct(struct sock *sk)
+{
+	struct raw_sock *ro = raw_sk(sk);
+
+	free_percpu(ro->uniq);
+	can_sock_destruct(sk);
+}
+
 static int raw_init(struct sock *sk)
 {
 	struct raw_sock *ro = raw_sk(sk);
@@ -362,6 +370,8 @@ static int raw_init(struct sock *sk)
 	if (unlikely(!ro->uniq))
 		return -ENOMEM;
 
+	sk->sk_destruct = raw_sock_destruct;
+
 	/* set notifier */
 	spin_lock(&raw_notifier_lock);
 	list_add_tail(&ro->notifier, &raw_notifier_list);
@@ -409,7 +419,6 @@ static int raw_release(struct socket *so
 	ro->bound = 0;
 	ro->dev = NULL;
 	ro->count = 0;
-	free_percpu(ro->uniq);
 
 	sock_orphan(sk);
 	sock->sk = NULL;



