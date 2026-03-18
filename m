Return-Path: <stable+bounces-227123-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDNKBfzVummfcAIAu9opvQ
	(envelope-from <stable+bounces-227123-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:42:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2002BF7AA
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 17:42:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4C4930BAB6D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1845536B07B;
	Wed, 18 Mar 2026 16:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="M136BDHh";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="zMu5KRYC"
X-Original-To: stable@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D173A451C
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 16:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773850800; cv=pass; b=T7BmR3+kssLHoY4JhiB0lwVbJM0whhkzZmCO9pghX5oD5eVu24bCc61mtPsN4/dSyqubbGQ5ldwuuwnv7GdemfwE/n4K8qBhjVsH1Fel8eLsNJPpX2CBqKpkLfqn5zB+ZAL6BbDQ4pxflCdc75oIRgn3iTAhnCS2A0An1Ktkkrs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773850800; c=relaxed/simple;
	bh=/k9DjZs9HuznrEsEgEnWrtTj3Q7mI6JrR369Z+5naec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d1vylTT6Gbbj/aSq6tH3hG0GknNU9CEWeVC1vZ+A16TJ76307SEcx/QSxXZIE5yiaHtv8C4SqAKoWJj0IhBnuTnKJ6YaPkdSbFiKzruW5cfTp0X37YyPFaPALb8Cg8IU2WO9h4R/1oNwJ9oug+4WuHUHMxMZiqyhjI6hjWJ6YgU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=M136BDHh; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=zMu5KRYC; arc=pass smtp.client-ip=85.215.255.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1773850790; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=NxVolBYHvAkVkP4twy//v++jClURKD6muZyw9PSMpLAOBQi370uo5jzflPF8r3l/v9
    UnVjbCL9qrcHNPFD+JKlKjZV2G1yS1IkhfluhWORyatYSKXpel40Ep/tSf2QHGZqzrgz
    wpIJ9WqzLbKT6djv8siPzy4VXhPkYfK2dGFOn/+TgMUUoV4aXDN3aX75i23c7i9B278r
    pzSJILzfwCfg3E8ScehSueKxB9pqWyR/BOE5CjTjILfTc2qtAaDyW1Ma7FnUc+YHHDd1
    IB0F6iniaH6mMsLRYTphxUuqZJUlZejxEh9l9jp/dfV3dNUffQbK//X3X8Ob/ScV4vk7
    W54g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1773850790;
    s=strato-dkim-0002; d=strato.com;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OqP7gq/LowT7pcNzuhoIrzO3GvrxyRnB6oXUy5+oLp0=;
    b=CNQW5DJE0yTU0tUxVUUSmyB8y2eazyrQGP0BYENIsOgsyVzeoTEHTE5yRl3HsQirk0
    P6zyu9GtvrD5VDTwyJHgkfDwMBYXrthR8u68EbQ9mLPApm4IWXsIzykpw6NhuNN2oIpc
    KhGqQSQhjC3qvhs0yADE95r69XjnQLhIBiA3oyQjSs6qTG4jgRT3i13JAvCnKoGUnAkm
    4aegLa7TD0/F5oNorU5ibvnpdHxBhB1hKTXPGJZG9M207zZgURsubHINPaV1ofe/jF0G
    J7ncMI0c7nzE3I6P7eEQ6GJD3kUR8SRtBvp8Y862z2HpzPnBAa84u15Kvr8jkipNK5JL
    iv+A==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1773850790;
    s=strato-dkim-0002; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OqP7gq/LowT7pcNzuhoIrzO3GvrxyRnB6oXUy5+oLp0=;
    b=M136BDHh+nRp+MLl9hmn+s0j/pWneUpdT1Mw1kC2Rnmt01dWf/9gQLxHGnMSfeu6aX
    1FLgFElgBEjn8ZHk5QtOVBDnlqdqu4FS6r2sfEgyDyAHk7CdH1yAvSUqqML62AbF6c72
    11b4SRheXUuHdBCLpC+CTT6Q9iIGSYi+OnsBsLODXJ/ZP0c37cZ8r/+wsKgHeoDV4Ann
    y39S8aYVUwwlr3iFc/+6x1a6BizPatQiluI9z6eeloZc1+8qOkPNwvgm2lSA92Y1WIyA
    b1qaaiXNo66CU+HN3VrVaf2zf3BjtouP9S56Zo7RtLindAIktSace0XAayaHmK96WM64
    fZag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1773850790;
    s=strato-dkim-0003; d=hartkopp.net;
    h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
    From:Subject:Sender;
    bh=OqP7gq/LowT7pcNzuhoIrzO3GvrxyRnB6oXUy5+oLp0=;
    b=zMu5KRYCp5m/6YMYz7I1z9K/L1TkfcCWAsaj6aqzCwM1WW2ykVpYzmlBMu9ZdZFVDN
    bVXgF5apln/6jvEPreBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d22IGJoouZ
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Wed, 18 Mar 2026 17:19:50 +0100 (CET)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: ali.norouzi@keysight.com,
	security@kernel.org,
	torvalds@linuxfoundation.org
Cc: mkl@pengutronix.de,
	socketcan@hartkopp.net,
	stable@vger.kernel.org
Subject: [PATCH 2/2] can: isotp: fix tx.buf use-after-free in isotp_sendmsg()
Date: Wed, 18 Mar 2026 17:19:14 +0100
Message-ID: <20260318161914.15140-3-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260318161914.15140-1-socketcan@hartkopp.net>
References: <20260318161914.15140-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227123-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,hartkopp.net:dkim,hartkopp.net:email,hartkopp.net:mid]
X-Rspamd-Queue-Id: 8D2002BF7AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

isotp_sendmsg() uses only cmpxchg() on so->tx.state to serialize access
to so->tx.buf. isotp_release() waits for ISOTP_IDLE via
wait_event_interruptible() and then calls kfree(so->tx.buf).

If a signal interrupts the wait_event_interruptible() inside close()
while tx.state is ISOTP_SENDING, the loop exits early and release
proceeds to force ISOTP_SHUTDOWN and continues to kfree(so->tx.buf)
while sendmsg may still be reading so->tx.buf for the final CAN frame
in isotp_fill_dataframe().

The so->tx.buf can be allocated once when the standard tx.buf length needs
to be extended. Move the kfree() of this potentially extended tx.buf to
sk_destruct time when either isotp_sendmsg() and isotp_release() are done.

Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")
Cc: stable@vger.kernel.org
Reported-by: Ali Norouzi <ali.norouzi@keysight.com>
Co-developed-by: Ali Norouzi <ali.norouzi@keysight.com>
Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
---
 net/can/isotp.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/can/isotp.c b/net/can/isotp.c
index da3b72e7afcc..2770f43f4951 100644
--- a/net/can/isotp.c
+++ b/net/can/isotp.c
@@ -1246,16 +1246,10 @@ static int isotp_release(struct socket *sock)
 	hrtimer_cancel(&so->rxtimer);
 
 	so->ifindex = 0;
 	so->bound = 0;
 
-	if (so->rx.buf != so->rx.sbuf)
-		kfree(so->rx.buf);
-
-	if (so->tx.buf != so->tx.sbuf)
-		kfree(so->tx.buf);
-
 	sock_orphan(sk);
 	sock->sk = NULL;
 
 	release_sock(sk);
 	sock_prot_inuse_add(net, sk->sk_prot, -1);
@@ -1620,10 +1614,25 @@ static int isotp_notifier(struct notifier_block *nb, unsigned long msg,
 	isotp_busy_notifier = NULL;
 	spin_unlock(&isotp_notifier_lock);
 	return NOTIFY_DONE;
 }
 
+static void isotp_sock_destruct(struct sock *sk)
+{
+	struct isotp_sock *so = isotp_sk(sk);
+
+	/* do the standard CAN sock destruct work */
+	can_sock_destruct(sk);
+
+	/* free potential extended PDU buffers */
+	if (so->rx.buf != so->rx.sbuf)
+		kfree(so->rx.buf);
+
+	if (so->tx.buf != so->tx.sbuf)
+		kfree(so->tx.buf);
+}
+
 static int isotp_init(struct sock *sk)
 {
 	struct isotp_sock *so = isotp_sk(sk);
 
 	so->ifindex = 0;
@@ -1664,10 +1673,13 @@ static int isotp_init(struct sock *sk)
 
 	spin_lock(&isotp_notifier_lock);
 	list_add_tail(&so->notifier, &isotp_notifier_list);
 	spin_unlock(&isotp_notifier_lock);
 
+	/* re-assign default can_sock_destruct() reference */
+	sk->sk_destruct = isotp_sock_destruct;
+
 	return 0;
 }
 
 static __poll_t isotp_poll(struct file *file, struct socket *sock, poll_table *wait)
 {
-- 
2.51.0


