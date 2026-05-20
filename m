Return-Path: <stable+bounces-253370-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGUbB7EIDmrY5gUAu9opvQ
	(envelope-from <stable+bounces-253370-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:17:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3ECA59812B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 21:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D39B23030E97
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB9B33B97D;
	Wed, 20 May 2026 19:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="ouCKiG4D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uYyCDnbU"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A9B529ACC5;
	Wed, 20 May 2026 19:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779304614; cv=none; b=rsfIPAkJsDrP9fC/iP3YCbD/SWQTaOP7tYTURuJXBvpV5vRB2iu8VG7ce9qY3I9ga05wTi34sZih/cWT033zLJ4IsLjzuq26WKC1bncDWZ6PXvEQ8tquTpcfTbuJXHjfoBIH6b3xVpNQbghMVmktBI6K+Ywnjsi/hGXoEXZnHp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779304614; c=relaxed/simple;
	bh=J+fhfwuzULqDjpqD0EwrHEsTvka07DrfvB1P9lCmZpc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ccBxOqxthKkL6zgMPFXJXFYWNDfqkmjsiRwiMEQV2U+0c2vUAV5IXbs4DFz3N6yQVCLneW0o03smlhkpVBDL3XEpGqTQey/qwxZKuFs/1XJDGhfqdLC6JGe/+iNv9E3whGjeCQdeU0IKNrgsEf2FeF0CVtXTXTN0iU4NdgqdyBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=ouCKiG4D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uYyCDnbU; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4EFD91400056;
	Wed, 20 May 2026 15:16:51 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 20 May 2026 15:16:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779304611;
	 x=1779391011; bh=ORMjBnAZGbabIO9BZAFFuCmcpnin9rKnEJOiDrcvyoM=; b=
	ouCKiG4DTrmnXoaMiehjiCR6x/Fpj/3IZ1CDXR5aildih6FFJRA2HeA7t2IQvjuR
	NfzoCZooLXrBGLhCeAIr/dnNh3lyyXHcQYPvGp3icEYI5e1jnCU+e12fCcVTclp6
	h3WxuClLfO3NeVpFw6M6dT1rZXHj+4hTna/tUg6gIK//Ys4kXPYnVG+5NyCWMgkD
	nTw9vmdHET8aKNuxCERtCXBKcPdh/U3NiVbhSkW6yioygib2tXITub5y1pRMzfQW
	kyS/yWRQUAg/LiWspOMXNHOUAfR5DWUtpYeT76lbENjmm6gngPt5ZGjSbjz7c3n4
	DXUbyBAEQaplagDn4D8L2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779304611; x=
	1779391011; bh=ORMjBnAZGbabIO9BZAFFuCmcpnin9rKnEJOiDrcvyoM=; b=u
	YyCDnbUcQcJNLL3w7IMGHuZSf3YdLNU23O3El/Tn44BzxD53gEggbm21B5MMKc5Y
	MKPdBX3OiORN6o45XS9e4elQ7bfI383hh2Ge73fIM8jOmV0EbFSV/ZoxdtH75Fhc
	qlVARPnFw4RVruOPAIXHryVfQTKNJcbF4DYSmmFFRLeZ69HMFaSGxdktpFZoU0K8
	QlFpnT7Ct2c97SuKhmm+XAuX66jDS2B8OOL86o806Y4olmLJrI/CnTmKTAZfSuRq
	cVtxitCieOYoQczTBPpKGxAeofASY47Izh+Gj81Zgnk8GytsFGk0+BdLCq5UKm/w
	Ad0fz6rdvTe6GougdfUcA==
X-ME-Sender: <xms:owgOaoW321Ua8eyavHXoW4LCUoTvba5vrmw3bWswFOW4qywYZjNuog>
    <xme:owgOanZ1mVXjyFVREnDcPQ2Q2LnwQzfnoWj-V0fpO-u6LtymhvujN4cFe_wYNOnT9
    gDPuWHtWr_VNhg4G4Fg8qtOOtQiu8uc5N2dh7GHyPAOm0YTPLpHwXJH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfhhouhhrughimhcuoehhihesfhhouhhrughimhdrgiihiieqnecugg
    ftrfgrthhtvghrnhepgffgtedvfeetuefhheeflefgudeltdehfffhgeejhefhjefgveef
    teetfeefgfejnecuffhomhgrihhnpehsihhgnhgvugdqohhffhdqsgihrdhnvghtnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhephhhisehfohhu
    rhguihhmrdighiiipdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehluhhiiidruggvnhhtiiesghhmrghilhdrtghomhdprhgtphhtthhopehm
    rghrtggvlheshhholhhtmhgrnhhnrdhorhhgpdhrtghpthhtohepshgrfhgrrdhkrghrrg
    hkuhhssehsvggtuhhnnhhigidrtghomhdprhgtphhtthhopehlihhnuhigqdgslhhuvght
    ohhothhhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkh
    gvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhtrggslhgv
    sehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:owgOan5ft7kcQ29DTcX1h8XN89mCgkmOt6E_lldHCrdUDtOg8p2m8g>
    <xmx:owgOavLg1B1keEYtN9bDiSKQvRTI9fEJIwYP_mr-YLCP1vTbXs1EpA>
    <xmx:owgOagsPGRw_WrX5RkL9mIhCEUsKBy3p203liXro6Hh5nnc74OPXYw>
    <xmx:owgOauK3AnHPTR1OQzEk4cUz7BgIF_USXgzexXRKmbh5lZD9RGw2vw>
    <xmx:owgOar9zYyA1SMkdmQUdmMTOY-dhGbtZ3kV8GqPaiKz1R7dkdzntLjEe>
Feedback-ID: if79149f8:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 1199A2160098; Wed, 20 May 2026 15:16:51 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Ar1W1-tN7BkN
Date: Wed, 20 May 2026 15:14:23 -0400
From: fourdim <hi@fourdim.xyz>
To: =?UTF-8?Q?Safa_Karaku=C5=9F?= <safa.karakus@secunnix.com>,
 linux-bluetooth@vger.kernel.org
Cc: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>,
 "Marcel Holtmann" <marcel@holtmann.org>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Message-Id: <37401bf7-6a15-4295-b77e-dfd0e3e41efd@app.fastmail.com>
In-Reply-To: <20260516181504.3076260-1-safa.karakus@secunnix.com>
References: <20260516092139.2618159-1-safa.karakus@secunnix.com>
 <20260516181504.3076260-1-safa.karakus@secunnix.com>
Subject: Re: [PATCH v4] Bluetooth: fix UAF in l2cap_sock_cleanup_listen() vs
 l2cap_conn_del()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fourdim.xyz,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[fourdim.xyz:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-253370-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[fourdim.xyz:+,messagingengine.com:+];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hi@fourdim.xyz,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,holtmann.org,vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,app.fastmail.com:mid]
X-Rspamd-Queue-Id: B3ECA59812B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Sat, May 16, 2026, at 2:15 PM, Safa Karaku=C5=9F wrote:
> bt_accept_dequeue() unlinks a not-yet-accepted child from the parent
> accept queue and release_sock()s it before returning, so the returned
> sk has no caller reference and is unlocked.
>
> l2cap_sock_cleanup_listen() walks these children on listening-socket
> close.  A concurrent HCI disconnect drives hci_rx_work ->
> l2cap_conn_del() which runs l2cap_chan_del() + l2cap_sock_kill() and
> frees the child sk and its l2cap_chan; cleanup_listen() then uses both:
>
>   BUG: KASAN: slab-use-after-free in l2cap_sock_kill
>     l2cap_sock_kill / l2cap_sock_cleanup_listen / __x64_sys_close
>   Freed by: l2cap_conn_del -> l2cap_sock_close_cb -> l2cap_sock_kill
>
> This is distinct from the two fixes already in this area: commit
> e83f5e24da741 ("Bluetooth: serialize accept_q access") serialises the
> accept_q list/poll and takes temporary refs inside bt_accept_dequeue(),
> and CVE-2025-39860 serialises the userspace close()/accept() race by
> calling cleanup_listen() under lock_sock() in l2cap_sock_release().
> Neither covers l2cap_conn_del() running from hci_rx_work, so this UAF
> still reproduces on current bluetooth/master.
>
> Take the reference at the source: bt_accept_dequeue() does sock_hold()
> while sk is still locked, before release_sock(); callers sock_put().
> cleanup_listen() pins the chan with l2cap_chan_hold_unless_zero() under
> a brief child sk lock (serialising vs l2cap_sock_teardown_cb()), drops
> it before l2cap_chan_lock(), and skips a duplicate l2cap_sock_kill() on
> SOCK_DEAD.  conn->lock is not taken here: cleanup_listen() runs under
> the parent sk lock and that would invert
> conn->lock -> chan->lock -> sk_lock (lockdep).
>
> KASAN/SMP: an unprivileged listen/close vs HCI-disconnect race produced
> 12 use-after-free reports per run before this change; 0, and no lockdep
> report, over 1600+ raced iterations after it on bluetooth/master.
>
> Fixes: 15f02b910562 ("Bluetooth: L2CAP: Add initial code for Enhanced=20
> Credit Based Mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Safa Karaku=C5=9F <safa.karakus@secunnix.com>
> ---
> Hi Luiz,
>
> v4 - rebased on current bluetooth/master (after e83f5e24d "serialize
> accept_q access"); the af_bluetooth.c hunk now sits in the reworked
> bt_accept_dequeue().  This residual (cleanup_listen vs l2cap_conn_del,
> not covered by e83f5e24d nor CVE-2025-39860) is unchanged from v3 and
> re-verified with KASAN on bluetooth/master: 12 UAF/run -> 0, no
> lockdep, over 1600+ raced iterations.
>
> Changes since v3: rebased onto e83f5e24d; commit message notes why
> e83f5e24d/CVE-2025-39860 do not cover this path.
> Changes since v2: fix at the source in bt_accept_dequeue() + chan
> lifetime via l2cap_chan_hold_unless_zero(); no conn->lock (lockdep).
> Changes since v1: consistent From/Signed-off-by.
>
>  net/bluetooth/af_bluetooth.c | 10 +++++++
>  net/bluetooth/iso.c          |  9 ++++++-
>  net/bluetooth/l2cap_sock.c   | 51 +++++++++++++++++++++++++++++++-----
>  net/bluetooth/rfcomm/sock.c  |  9 ++++++-
>  net/bluetooth/sco.c          |  9 ++++++-
>  5 files changed, 78 insertions(+), 10 deletions(-)
>
> diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth=
.c
> index 9d68dd860..1a6aa3f8d 100644
> --- a/net/bluetooth/af_bluetooth.c
> +++ b/net/bluetooth/af_bluetooth.c
> @@ -340,6 +340,16 @@ struct sock *bt_accept_dequeue(struct sock=20
> *parent, struct socket *newsock)
>  			if (newsock)
>  				sock_graft(sk, newsock);
>=20
> +			/* Hand the caller a reference taken while sk is
> +			 * still locked.  bt_accept_unlink() just dropped
> +			 * the accept-queue reference; without this hold a
> +			 * concurrent teardown (e.g. l2cap_conn_del() ->
> +			 * l2cap_sock_kill()) could free sk between
> +			 * release_sock() and the caller using it.  Every
> +			 * caller drops this with sock_put() when done.
> +			 */
> +			sock_hold(sk);
> +
>  			release_sock(sk);
>  			if (next)
>  				sock_put(next);
> diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
> index 7cb2864fe..812f9002d 100644
> --- a/net/bluetooth/iso.c
> +++ b/net/bluetooth/iso.c
> @@ -751,6 +751,8 @@ static void iso_sock_cleanup_listen(struct sock *p=
arent)
>  	while ((sk =3D bt_accept_dequeue(parent, NULL))) {
>  		iso_sock_close(sk);
>  		iso_sock_kill(sk);
> +		/* Drop the reference handed back by bt_accept_dequeue(). */
> +		sock_put(sk);
>  	}
>=20
>  	/* If listening socket has a hcon, properly disconnect it */
> @@ -1356,8 +1358,13 @@ static int iso_sock_accept(struct socket *sock,=20
> struct socket *newsock,
>  		}
>=20
>  		ch =3D bt_accept_dequeue(sk, newsock);
> -		if (ch)
> +		if (ch) {
> +			/* Drop the bridging ref from bt_accept_dequeue();
> +			 * the grafted socket keeps ch alive from here.
> +			 */
> +			sock_put(ch);
>  			break;
> +		}
>=20
>  		if (!timeo) {
>  			err =3D -EAGAIN;
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index cf590a67d..b34e7da8d 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -349,8 +349,13 @@ static int l2cap_sock_accept(struct socket *sock,=20
> struct socket *newsock,
>  		}
>=20
>  		nsk =3D bt_accept_dequeue(sk, newsock);
> -		if (nsk)
> +		if (nsk) {
> +			/* Drop the bridging ref from bt_accept_dequeue();
> +			 * the grafted socket keeps nsk alive from here.
> +			 */
> +			sock_put(nsk);
>  			break;
> +		}
>=20
>  		if (!timeo) {
>  			err =3D -EAGAIN;
> @@ -1475,22 +1480,54 @@ static void l2cap_sock_cleanup_listen(struct=20
> sock *parent)
>  	BT_DBG("parent %p state %s", parent,
>  	       state_to_string(parent->sk_state));
>=20
> -	/* Close not yet accepted channels */
> +	/* Close not yet accepted channels.
> +	 *
> +	 * bt_accept_dequeue() now returns sk with an extra reference held
> +	 * (taken while sk was still locked) so a concurrent l2cap_conn_del()
> +	 * -> l2cap_sock_kill() cannot free sk under us.
> +	 *
> +	 * cleanup_listen() runs under the parent sk lock, so unlike
> +	 * l2cap_sock_shutdown() we must NOT take conn->lock here: that would
> +	 * establish sk_lock -> conn->lock and invert the established
> +	 * conn->lock -> chan->lock -> sk_lock order (lockdep deadlock).
> +	 *
> +	 * Instead, briefly take the child sk lock to fetch and pin its chan.
> +	 * l2cap_conn_del() reaches the chan free only via
> +	 * l2cap_chan_del() -> l2cap_sock_teardown_cb(), which itself takes
> +	 * the child sk lock; holding it across l2cap_chan_hold_unless_zero()
> +	 * therefore guarantees the chan cannot be freed while we read and
> +	 * pin it (hold_unless_zero() additionally skips a chan already past
> +	 * its last reference).  We then drop the sk lock before taking
> +	 * chan->lock, so sk and chan locks are never held together.
> +	 */
>  	while ((sk =3D bt_accept_dequeue(parent, NULL))) {
> -		struct l2cap_chan *chan =3D l2cap_pi(sk)->chan;
> +		struct l2cap_chan *chan;
> +
> +		lock_sock_nested(sk, L2CAP_NESTING_NORMAL);
> +		chan =3D l2cap_chan_hold_unless_zero(l2cap_pi(sk)->chan);
> +		release_sock(sk);
> +		if (!chan) {
> +			/* l2cap_conn_del() already tearing this child down */
> +			sock_put(sk);
> +			continue;
> +		}
>=20
>  		BT_DBG("child chan %p state %s", chan,
>  		       state_to_string(chan->state));
>=20
> -		l2cap_chan_hold(chan);
>  		l2cap_chan_lock(chan);
> -
>  		__clear_chan_timer(chan);
>  		l2cap_chan_close(chan, ECONNRESET);
> -		l2cap_sock_kill(sk);
> -
> +		/* l2cap_conn_del() may already have killed this socket
> +		 * (it sets SOCK_DEAD); skip the duplicate to avoid a
> +		 * double sock_put()/l2cap_chan_put().
> +		 */
> +		if (!sock_flag(sk, SOCK_DEAD))
> +			l2cap_sock_kill(sk);
>  		l2cap_chan_unlock(chan);
> +
>  		l2cap_chan_put(chan);
> +		sock_put(sk);
>  	}
>  }
>=20
> diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
> index be6639cd6..bd7d959c6 100644
> --- a/net/bluetooth/rfcomm/sock.c
> +++ b/net/bluetooth/rfcomm/sock.c
> @@ -180,6 +180,8 @@ static void rfcomm_sock_cleanup_listen(struct sock=
 *parent)
>  	while ((sk =3D bt_accept_dequeue(parent, NULL))) {
>  		rfcomm_sock_close(sk);
>  		rfcomm_sock_kill(sk);
> +		/* Drop the reference handed back by bt_accept_dequeue(). */
> +		sock_put(sk);
>  	}
>=20
>  	parent->sk_state  =3D BT_CLOSED;
> @@ -497,8 +499,13 @@ static int rfcomm_sock_accept(struct socket *sock=
,=20
> struct socket *newsock,
>  		}
>=20
>  		nsk =3D bt_accept_dequeue(sk, newsock);
> -		if (nsk)
> +		if (nsk) {
> +			/* Drop the bridging ref from bt_accept_dequeue();
> +			 * the grafted socket keeps nsk alive from here.
> +			 */
> +			sock_put(nsk);
>  			break;
> +		}
>=20
>  		if (!timeo) {
>  			err =3D -EAGAIN;
> diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
> index eba44525d..f1799c6a6 100644
> --- a/net/bluetooth/sco.c
> +++ b/net/bluetooth/sco.c
> @@ -502,6 +502,8 @@ static void sco_sock_cleanup_listen(struct sock *p=
arent)
>  	while ((sk =3D bt_accept_dequeue(parent, NULL))) {
>  		sco_sock_close(sk);
>  		sco_sock_kill(sk);
> +		/* Drop the reference handed back by bt_accept_dequeue(). */
> +		sock_put(sk);
>  	}
>=20
>  	parent->sk_state  =3D BT_CLOSED;
> @@ -765,8 +767,13 @@ static int sco_sock_accept(struct socket *sock,=20
> struct socket *newsock,
>  		}
>=20
>  		ch =3D bt_accept_dequeue(sk, newsock);
> -		if (ch)
> +		if (ch) {
> +			/* Drop the bridging ref from bt_accept_dequeue();
> +			 * the grafted socket keeps ch alive from here.
> +			 */
> +			sock_put(ch);
>  			break;
> +		}
>=20
>  		if (!timeo) {
>  			err =3D -EAGAIN;
> --=20
> 2.34.1

I reported the same issue privately to the maintainers on April 11th.
The fix looks correct for the sk-lifetime UAF.

Reported-by: Siwei Zhang <oss@fourdim.xyz>
Reviewed-by: Siwei Zhang <oss@fourdim.xyz>

This patch leaves the conn->chan_l list-corruption race open
(l2cap_chan_close without conn->lock). I'll send a follow-up patch
on top that addresses it.

Best,
Siwei

