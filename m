Return-Path: <stable+bounces-60348-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 752119331A2
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 21:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B598AB225A9
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 19:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8DF1A00FF;
	Tue, 16 Jul 2024 19:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="piSMjnJl"
X-Original-To: stable@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688E1A01C6;
	Tue, 16 Jul 2024 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721156412; cv=pass; b=C/qNwQJTElkhg0p5ZDdTZQYXLpr3fudALQCVx8ihjGVb46Uvs6fQYkR05WIu8/Ns1q7hSK+6+ffSdHBXjrMer39nlf2Sq0BFL68j5DaIhAO5f8mKSC4hX/koxeMdkQu2yOxY7dZ+Fj1mEGDqP5bIDeQim62B40soegyVNYJkcx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721156412; c=relaxed/simple;
	bh=/71gqA1ez3HMmSv3NBhfFDajpC8x32XIB8KTYzgA0Mk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iw0pDvooneVPHls1uqy/v15xqeUSeK6vz+bhSTJNvM2tiPnYxFoe4KHZu3haXGEoDzocbB2wHCW3cy2gQMV8qpLgjrtIIB9Wr01cheLdFfgeCTjvcroCwUwTAPCwtAOBGkoZx9jo831tU3JHreabRHYlqoJNwoyj4u2SiraNXUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=piSMjnJl; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WNpKY3BHhz49PsT;
	Tue, 16 Jul 2024 22:00:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1721156402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x0uaStvGP7aRuGHvuQ/trIdZNovO7pQhTrTx+VbNAxc=;
	b=piSMjnJlAOSYLP9Ck0QAUCGtqyCnWpEnXskzKtW0TTcgjExy9QoddgaJpTWM+LGZtYVRnq
	6defQ4508bjHw111gHPq2w269hFOax0vaeylnbXc9DzGdPwDKzyN9prsrrgODmtJ6aBnL8
	wobgGDK1Yc4WVy1gaj5vtJo+bJQ6sCnHnnNOBJCKRygW6aGKXRmnVE4yB9aKa8zh7if3cz
	WL6/iyObNTtrDhvbNmwAvreLoWMno9Qbv/J2eSUJPx0KygDEEwnPNmk7JxPMhgBxtsBSRE
	kAPFFidQl/C/RiHlYyJeq3fAGK5gjncxBU4H3C4VNMavFZIc8UYwgabL8bVbuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1721156402;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=x0uaStvGP7aRuGHvuQ/trIdZNovO7pQhTrTx+VbNAxc=;
	b=lNRvPrM0QQXXeUhFv1FrXkHxIOD9lIh5I/pi8FuOf/CfO09W7kMoQhGZrEOjd5Dy5fVJaq
	ZFVgOXyHJIcwSYJnTUUR9tqyGfEPGycAQ1tLM+J5xgrDs5jfXM3qbYFkVN1a52EMpF40RD
	2ZWhp2u//faNg/7f57DI87owNZ3A9sndVvYxi1fcYXRx4OSkiSTT5YRGAfezkfGM+uj/5g
	3iVVNNdl3pfvxh2d1yIT76GSTn2goAl6mcBR69+RVZi9DPkW5B4rKUHLkNwH0/Dtsi+HQe
	5dm4XD7Rzm1zn5lsaz4wJ841e6I5BtzsJ4n3YwxFLoHSGHtFlFXGq0OXmEs0XA==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1721156402; a=rsa-sha256;
	cv=none;
	b=Kmx1KzvsJwcppEjYx9ycb0s4v4Kuw8AHil1lhDnU/eG2drzUrW/6RCxRfrsoz0GayodWC8
	wfkafvs6gm6X192Huoki+yywIO0W/8VvY3oUBLdQC+qYUr43WnS66bT2Aa5VgxFtq6IYx2
	/lkEAgOt6Vy2uUmSlyyRlEnHTq2sWYTwT3mTcJHQ4qtDY9NWbv/qJcUPpPcIuAgB+UjLjh
	ruwU/FNJiNQAHSUgv2uPncw14PxomkQhpJo2k8UAgIO7CTfRKXdrqvYkmmrAG6Bb69CZR7
	JpbxtNvSwUb/MkMG936r7IBMHgkGeSc/2hLCzZ30GZc238aiMgGDAzZtGq0m3g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <0d437a3825d2f714b24c032066b43d7b9e73b0e9.camel@iki.fi>
Subject: Re: [PATCH AUTOSEL 6.9 09/22] bluetooth/l2cap: sync sock recv cb
 and release
From: Pauli Virtanen <pav@iki.fi>
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Cc: Edward Adam Davis <eadavis@qq.com>, 
 syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail.com, Luiz Augusto von
 Dentz <luiz.von.dentz@intel.com>, marcel@holtmann.org,
 johan.hedberg@gmail.com,  luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org
Date: Tue, 16 Jul 2024 21:59:59 +0300
In-Reply-To: <20240716142519.2712487-9-sashal@kernel.org>
References: <20240716142519.2712487-1-sashal@kernel.org>
	 <20240716142519.2712487-9-sashal@kernel.org>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ti, 2024-07-16 kello 10:24 -0400, Sasha Levin kirjoitti:
> From: Edward Adam Davis <eadavis@qq.com>
>=20
> [ Upstream commit 89e856e124f9ae548572c56b1b70c2255705f8fe ]

This one needed an additional fixup that I don't see AUTOSEL picked up,
otherwise it results to a worse regression:

https://lore.kernel.org/linux-bluetooth/20240624134637.3790278-1-luiz.dentz=
@gmail.com/

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Df1a8f402f13f94263cf349216c257b2985100927


Looks like f1a8f402f13f94263cf349216c257b2985100927 also contains other
changes not related to this patch, seems like=20
https://lore.kernel.org/linux-bluetooth/20240624144911.3817479-1-luiz.dentz=
@gmail.com/
was squashed.

> The problem occurs between the system call to close the sock and hci_rx_w=
ork,
> where the former releases the sock and the latter accesses it without loc=
k protection.
>=20
>            CPU0                       CPU1
>            ----                       ----
>            sock_close                 hci_rx_work
> 	   l2cap_sock_release         hci_acldata_packet
> 	   l2cap_sock_kill            l2cap_recv_frame
> 	   sk_free                    l2cap_conless_channel
> 	                              l2cap_sock_recv_cb
>=20
> If hci_rx_work processes the data that needs to be received before the so=
ck is
> closed, then everything is normal; Otherwise, the work thread may access =
the
> released sock when receiving data.
>=20
> Add a chan mutex in the rx callback of the sock to achieve synchronizatio=
n between
> the sock release and recv cb.
>=20
> Sock is dead, so set chan data to NULL, avoid others use invalid sock poi=
nter.
>=20
> Reported-and-tested-by: syzbot+b7f6f8c9303466e16c8a@syzkaller.appspotmail=
.com
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>
> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  net/bluetooth/l2cap_sock.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 8645461d45e81..64827e553d638 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1239,6 +1239,10 @@ static void l2cap_sock_kill(struct sock *sk)
> =20
>  	BT_DBG("sk %p state %s", sk, state_to_string(sk->sk_state));
> =20
> +	/* Sock is dead, so set chan data to NULL, avoid other task use invalid
> +	 * sock pointer.
> +	 */
> +	l2cap_pi(sk)->chan->data =3D NULL;
>  	/* Kill poor orphan */
> =20
>  	l2cap_chan_put(l2cap_pi(sk)->chan);
> @@ -1481,12 +1485,25 @@ static struct l2cap_chan *l2cap_sock_new_connecti=
on_cb(struct l2cap_chan *chan)
> =20
>  static int l2cap_sock_recv_cb(struct l2cap_chan *chan, struct sk_buff *s=
kb)
>  {
> -	struct sock *sk =3D chan->data;
> -	struct l2cap_pinfo *pi =3D l2cap_pi(sk);
> +	struct sock *sk;
> +	struct l2cap_pinfo *pi;
>  	int err;
> =20
> -	lock_sock(sk);
> +	/* To avoid race with sock_release, a chan lock needs to be added here
> +	 * to synchronize the sock.
> +	 */
> +	l2cap_chan_hold(chan);
> +	l2cap_chan_lock(chan);
> +	sk =3D chan->data;
> =20
> +	if (!sk) {
> +		l2cap_chan_unlock(chan);
> +		l2cap_chan_put(chan);
> +		return -ENXIO;
> +	}
> +
> +	pi =3D l2cap_pi(sk);
> +	lock_sock(sk);
>  	if (chan->mode =3D=3D L2CAP_MODE_ERTM && !list_empty(&pi->rx_busy)) {
>  		err =3D -ENOMEM;
>  		goto done;
> @@ -1535,6 +1552,8 @@ static int l2cap_sock_recv_cb(struct l2cap_chan *ch=
an, struct sk_buff *skb)
> =20
>  done:
>  	release_sock(sk);
> +	l2cap_chan_unlock(chan);
> +	l2cap_chan_put(chan);
> =20
>  	return err;
>  }

--=20
Pauli Virtanen

