Return-Path: <stable+bounces-253378-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wIhmFHkUDmoW6AUAu9opvQ
	(envelope-from <stable+bounces-253378-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:07:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 112F859928D
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 22:07:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5F610303B699
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20543546F0;
	Wed, 20 May 2026 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="csb0kwNc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ef4f6IWZ"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950653431E7;
	Wed, 20 May 2026 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779307614; cv=none; b=QeP8AirPBXR0JhlWTTiXEA640U6QwNjvMA93ZmgAXNI+xdYI1s2hzDQIuWQloeUbUL6Q06/2NvUwBMyFzOphB9ctC6SXabw2W1ImPKBjdON/OwU8Bze1Pw+slVcmnGjozCQ+9qGfjcU6JVKCr8PPkWBGGLNH0gSdLg1x+b25890=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779307614; c=relaxed/simple;
	bh=O4Jjq7rE46ujM30LCCcW7inBaD1wxdFzTW51uSix30s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=imtTisvDGi2pzRS0JixYvZI/nXWuuyEjxkIDgjpaahsplrrnDJmS9jfmYnybfZF4oNaXkZJBwVBN3YwNBktYEUsTPxOXuC5muEnLqlJ3TmW7+c2UO5iEGigUJfIZkGIiVcOwiaHjtSgajBn8/pYKVFrFwWn0deBiYA5Lqy06f9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=csb0kwNc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ef4f6IWZ; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D10F014000EC;
	Wed, 20 May 2026 16:06:51 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 20 May 2026 16:06:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1779307611; x=
	1779394011; bh=ijN2rj8ZgQQzJtzyED4muDGbQkKYbaM3+hZfiAWsyig=; b=c
	sb0kwNcgqKQN2GZf5eCZYKcjuH8I6HAiHVD64DW1fsxxSGJ+nm4gw8hXHxEnMn+7
	Up3OB8+UfAiu3FlRdhfPtz4DQHwpJ4f+Qt80jIY7q3tdwOIVEaFP5fvHiurHGy6l
	PWcpidaivl709QkZdC7UbFmdfmI7MC4wgcCDdjKf7QTlTruqZxvdaBLE95Hq3MwO
	NA5qWrsCF8fhInHphKFnYacMGEpRF38EE7zVLqITriyeITujb1iKZ6CU6dmkUpaP
	gE41LjpAKdfbw2JXA2rGyQ1CsOnv1GDI4Uwh5kjubgDWcQyOUaO8UaQwZHJ6nynI
	gBeDJBMl/Wc0B36SLl6pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm3; t=1779307611; x=1779394011; bh=i
	jN2rj8ZgQQzJtzyED4muDGbQkKYbaM3+hZfiAWsyig=; b=Ef4f6IWZhI0RnWXUl
	zhMAdspk7HDJyX9Oh3xh4N+eA0ORuxjbnYIUlnoIddosyKHQUsNtXQdBL5s+fJeU
	GsWsyWSscB/VBwf+tpYdQzKqAfShctpkipDQqNr9JGfiE88HEH4AOfY7jJhErb/v
	Ev9h5FdW++GGvLXy6W14lr//EXNSsE9G9ld3PtfHR09WCx7nz3SZXpAH+5PY0wim
	pIVtxk5kS0nt+qwAL91AaQS2CCSujUbDUc00Btm8nEKhDqGvR+GBmPsSi1BpiOEh
	tVDvnxbEppjCuDNbUUKyT8n4yPHdO5AMSD+BQ9y7wX1MuJgo9np/FkartwG7ny5B
	Xef9w==
X-ME-Sender: <xms:WxQOakoZdL9v59xalbOdyu2AN-EsoEGB0_v8XjyH4IQ81It8l36G9w>
    <xme:WxQOasJqANVKTBDohMYjqfOY366RRuY6o0aoNd3cOB9_h2nNnjh5ZPAeDArZ9UH3G
    SObs5h-3AczXPEnj29s_rt9wVXbWkasMcUlMsAnT6tvPQMnoKzg_nE>
X-ME-Received: <xmr:WxQOapR9Be2kNgUkQ17fD25lV_vwiSoF_gZdnP9m3gnrD2jk107UjkQQ4ZSiNtP6hRK-72E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpefhvfevuf
    ffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuihifvghiucgkhhgrnhhguceo
    ohhsshesfhhouhhrughimhdrgiihiieqnecuggftrfgrthhtvghrnhepkedtleeiteevue
    etudevjeefheejueevffejteffvdehlefftdffleegleduvdfhnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepohhsshesfhhouhhrughimhdrgi
    ihiidpnhgspghrtghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohep
    lhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehsrghf
    rgdrkhgrrhgrkhhushesshgvtghunhhnihigrdgtohhmpdhrtghpthhtohepshhtrggslh
    gvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhsshesfhhouhhrughi
    mhdrgiihii
X-ME-Proxy: <xmx:WxQOarvJlfoL2uXWBoX1TyT4MFyBIQRnx7H09gSpsbMOmiJ2RcVYNQ>
    <xmx:WxQOaqYuor2Vr4HMIZJsOhVcF2awUFKdLMNzBrGDxRdDcvDorja1CA>
    <xmx:WxQOahFCcGB48gcmyaonuL5v6v5bxCK_4KlTZmCwaSQ4vAO_nr96PA>
    <xmx:WxQOauzBltlzMnNDylZ-mN9UzH0ZGYAWezQrUZni1smRQf0Jq6Zg-Q>
    <xmx:WxQOaplpgU1OKUZWcGOXPfi9-BqPAdtGfpchyDdAGluOF4MF-85RhOe0>
Feedback-ID: if72e4b10:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 16:06:51 -0400 (EDT)
From: Siwei Zhang <oss@fourdim.xyz>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	safa.karakus@secunnix.com,
	stable@vger.kernel.org,
	Siwei Zhang <oss@fourdim.xyz>
Subject: [PATCH] Bluetooth: L2CAP: use chan timer to close channels in cleanup_listen()
Date: Wed, 20 May 2026 16:05:40 -0400
Message-ID: <20260520200611.3033410-1-oss@fourdim.xyz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260516181504.3076260-1-safa.karakus@secunnix.com>
References: <20260516181504.3076260-1-safa.karakus@secunnix.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fourdim.xyz,none];
	R_DKIM_ALLOW(-0.20)[fourdim.xyz:s=fm2,messagingengine.com:s=fm3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_CC(0.00)[gmail.com,secunnix.com,vger.kernel.org,fourdim.xyz];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-253378-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oss@fourdim.xyz,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fourdim.xyz:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 112F859928D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

l2cap_chan_close() removes the channel from conn->chan_l, which
must be done under conn->lock.  cleanup_listen() runs under the
parent sk_lock, so acquiring conn->lock would invert the
established conn->lock -> chan->lock -> sk_lock order.

Instead of calling l2cap_chan_close() directly, schedule
l2cap_chan_timeout with delay 0 to close the channel
asynchronously.  The timeout handler already acquires conn->lock
and chan->lock in the correct order.

The timer is only armed when chan->conn is still set: if it is
already NULL, l2cap_conn_del() has already processed this channel
(l2cap_chan_del + l2cap_sock_teardown_cb + l2cap_sock_close_cb),
so there is nothing left to do.  If l2cap_conn_del() races in
after the timer is armed, __clear_chan_timer() inside
l2cap_chan_del() cancels it; if the timer has already fired, the
handler returns harmlessly because chan->conn was cleared.

Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
Cc: stable@vger.kernel.org
Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
---
 net/bluetooth/l2cap_sock.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 4ed745a9c2cf..025329636353 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1512,6 +1512,10 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 	 * pin it (hold_unless_zero() additionally skips a chan already past
 	 * its last reference).  We then drop the sk lock before taking
 	 * chan->lock, so sk and chan locks are never held together.
+	 *
+	 * Since we cannot call l2cap_chan_close() without conn->lock,
+	 * schedule l2cap_chan_timeout to close the channel; it already
+	 * acquires conn->lock -> chan->lock in the correct order.
 	 */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		struct l2cap_chan *chan;
@@ -1529,14 +1533,12 @@ static void l2cap_sock_cleanup_listen(struct sock *parent)
 		       state_to_string(chan->state));
 
 		l2cap_chan_lock(chan);
-		__clear_chan_timer(chan);
-		l2cap_chan_close(chan, ECONNRESET);
-		/* l2cap_conn_del() may already have killed this socket
-		 * (it sets SOCK_DEAD); skip the duplicate to avoid a
-		 * double sock_put()/l2cap_chan_put().
+		/* Since we cannot call l2cap_chan_close() without
+		 * conn->lock, schedule its timer to trigger the close
+		 * and cleanup of this channel.
 		 */
-		if (!sock_flag(sk, SOCK_DEAD))
-			l2cap_sock_kill(sk);
+		if (chan->conn)
+			__set_chan_timer(chan, 0);
 		l2cap_chan_unlock(chan);
 
 		l2cap_chan_put(chan);
-- 
2.54.0


