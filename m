Return-Path: <stable+bounces-253424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOf0IIhmDmqp+QUAu9opvQ
	(envelope-from <stable+bounces-253424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 03:57:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E320559DD4D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 03:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F199301F490
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 01:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36DE2D8385;
	Thu, 21 May 2026 01:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b="jQO+F7Wi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IR3w3euu"
X-Original-To: stable@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718828466F;
	Thu, 21 May 2026 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779328609; cv=none; b=uN0fPN3jv/bpzzNxEjQJpS01KjaN3xDS7+DPLU6ffRXz4iXBzHXdztL3P9EFqJ6UrC2drYVXVr9GlrowQC1P44FLHoMrQA/7kTy19oPq9Jp7e63WxNgMZmI0f6Yd5xrnLIeda9hxGAn23JKn90yXuu4+V/mOO2FPCMxrP/O6ED8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779328609; c=relaxed/simple;
	bh=AAvEu2XNtqL1MOnrvxoj8L1O9ls/nJgt5AtZ4HWdVcs=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=o9LveXDmAiYpz0T6ar/a5qb56m0mVK49jqg1pX2gJwM+0/6JBmVsJrdqJjmMCWooZoRdpIc1E5mzXPV7AKtj1bEVBtERgaoUh3jwsv9iT3jgrEpa9aeafAViESDPJJENs2lvMeZIFQ/2JKSXoYHWpWsvl51m6OOJT6Y4dRvKqBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz; spf=pass smtp.mailfrom=fourdim.xyz; dkim=pass (2048-bit key) header.d=fourdim.xyz header.i=@fourdim.xyz header.b=jQO+F7Wi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IR3w3euu; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fourdim.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fourdim.xyz
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id B471BEC01EF;
	Wed, 20 May 2026 21:56:46 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-03.internal (MEProxy); Wed, 20 May 2026 21:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fourdim.xyz; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779328606;
	 x=1779415006; bh=Gn5hw+guZ8UBD1xGIQ4e8FEov65ahJfR4ari0ZL5suQ=; b=
	jQO+F7Wia19fFBAay4lTDoW7VGIm4IAZcTVI9J5+4w0FJm29/2xjpAtjn6NixbZi
	l9omsBk7GvP+lzyyLok1GBBvS3jePRoUS//zSVgWwA78/pclV4xVEQs93Ofe+WVv
	7CW/rWsXoJm7RP2+Wgf29EFEjOUIsLMyI+R/67cSg9EM29J9vM/i9lswSdzWa+FC
	FvBg4wr7pXmYNz+Zn7fzSFX2XrvG8Ph2opy/WLxZqwHbY5ang97hB4m/8b/Xeyto
	ltcdBpWeTp6BxVHXnqoTDFXjO+xQNCUv0ouZfDoddBz+w0lCdXe0mbI2pcRUlDj8
	MJm6Lw4IxgYo34B/K5MsTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779328606; x=
	1779415006; bh=Gn5hw+guZ8UBD1xGIQ4e8FEov65ahJfR4ari0ZL5suQ=; b=I
	R3w3euuluQTsqStBd0lwqWdwXRpFELBhnxDQI6EnlMXWlNEd0ak0nNLtU7IFwIKm
	eshfpUCE6H7aJceS+Or0KTyEQiavcu9s8/9cG7KvG6yEdyd7HNEHAnUgq+qXJfBD
	/3BisiW+GoiVOJ5CzC2ixBqd0In/UZ7cQ0ERvuN0tJikD6khiAkHL2z0zGRNk5i6
	zELrIIroxizRL2CUHeTxljXgOYkBVfT0OM83oSyyNWmzkOFuKbxNnCIzwmRzC7YV
	rks/kmaPF2GlaNZ1WEMO7U8skkJ852aNJzuSEbUJBVGSudaW+51G480FPs4LEYRx
	M+WGFRgD33xqpQ0xxAW+Q==
X-ME-Sender: <xms:XmYOahqBLqd0U_7rKGpLYQnl4SctZK63MUUzOmxFTA0bupf1I1RHxg>
    <xme:XmYOaucnUWKd8-Bp78G4Vm-bO0_WaGbuOiM01GFNhzegLz7gNsy7E4HfnDnL1u3-G
    Q1vcu7g3OqWrsYAi1p0F8x0m-72fpUrHy2M0LIQTLk8lCy21A2hHN4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeeivdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlfeehmdenucfjughrpefoggffhffvvefkjghfufgtgfesthhqredtredt
    jeenucfhrhhomhepfdfuihifvghiucgkhhgrnhhgfdcuoehoshhssehfohhurhguihhmrd
    ighiiiqeenucggtffrrghtthgvrhhnpeeuveeuleefheetgfevkeegteetffejgfeigfdt
    uedtveetieehleefjeehteekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehoshhssehfohhurhguihhmrdighiiipdhnsggprhgtphhtthho
    peegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehluhhiiidruggvnhhtiiesgh
    hmrghilhdrtghomhdprhgtphhtthhopehsrghfrgdrkhgrrhgrkhhushesshgvtghunhhn
    ihigrdgtohhmpdhrtghpthhtoheplhhinhhugidqsghluhgvthhoohhthhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:XmYOaqRw5mG7eiSip3v0k8GaDOqQ206OO_-1p98LGZOS5w4_Fdmqsw>
    <xmx:XmYOarObFxYIlEE3UatHMt8aoZ9DpZn4ASdMwOMhVWq-xq4ieq6_ww>
    <xmx:XmYOarUw3-gLcvftbHOyHZOJltYYH-J6EajmNUZd1ou5lGGf_fDtZQ>
    <xmx:XmYOaqdB06RsvLwFPI6FlnE2cST4TO9swMJhgvlbOg_daa5DVnSX4Q>
    <xmx:XmYOauXsuPzJEnK95SrslKzgE-wXa2pbyTRzBKnw0e3HK85TIXyWMqpQ>
Feedback-ID: if72e4b10:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 79072216008A; Wed, 20 May 2026 21:56:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A4i_tNf7zNzg
Date: Wed, 20 May 2026 21:56:26 -0400
From: "Siwei Zhang" <oss@fourdim.xyz>
To: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
 =?UTF-8?Q?Safa_Karaku=C5=9F?= <safa.karakus@secunnix.com>,
 stable@vger.kernel.org
Message-Id: <10592e60-b93f-4288-8a96-c1c39340de72@app.fastmail.com>
In-Reply-To: 
 <CABBYNZJiCTJrde9rYT=NQAk_RUv=ugeAUPnRg6vsjvU5hW4NqQ@mail.gmail.com>
References: <20260516181504.3076260-1-safa.karakus@secunnix.com>
 <20260520200611.3033410-1-oss@fourdim.xyz>
 <CABBYNZJiCTJrde9rYT=NQAk_RUv=ugeAUPnRg6vsjvU5hW4NqQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: L2CAP: use chan timer to close channels in
 cleanup_listen()
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fourdim.xyz,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[fourdim.xyz:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-253424-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[fourdim.xyz:+,messagingengine.com:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[oss@fourdim.xyz,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,app.fastmail.com:mid,fourdim.xyz:email,fourdim.xyz:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E320559DD4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Luiz,

On Wed, May 20, 2026, at 4:29 PM, Luiz Augusto von Dentz wrote:
> Hi Siwei,
>
> On Wed, May 20, 2026 at 4:06=E2=80=AFPM Siwei Zhang <oss@fourdim.xyz> =
wrote:
>>
>> l2cap_chan_close() removes the channel from conn->chan_l, which
>> must be done under conn->lock.  cleanup_listen() runs under the
>> parent sk_lock, so acquiring conn->lock would invert the
>> established conn->lock -> chan->lock -> sk_lock order.
>>
>> Instead of calling l2cap_chan_close() directly, schedule
>> l2cap_chan_timeout with delay 0 to close the channel
>> asynchronously.  The timeout handler already acquires conn->lock
>> and chan->lock in the correct order.
>>
>> The timer is only armed when chan->conn is still set: if it is
>> already NULL, l2cap_conn_del() has already processed this channel
>> (l2cap_chan_del + l2cap_sock_teardown_cb + l2cap_sock_close_cb),
>> so there is nothing left to do.  If l2cap_conn_del() races in
>> after the timer is armed, __clear_chan_timer() inside
>> l2cap_chan_del() cancels it; if the timer has already fired, the
>> handler returns harmlessly because chan->conn was cleared.
>>
>> Fixes: 3df91ea20e74 ("Bluetooth: Revert to mutexes from RCU list")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Siwei Zhang <oss@fourdim.xyz>
>> ---
>>  net/bluetooth/l2cap_sock.c | 16 +++++++++-------
>>  1 file changed, 9 insertions(+), 7 deletions(-)
>>
>> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
>> index 4ed745a9c2cf..025329636353 100644
>> --- a/net/bluetooth/l2cap_sock.c
>> +++ b/net/bluetooth/l2cap_sock.c
>> @@ -1512,6 +1512,10 @@ static void l2cap_sock_cleanup_listen(struct s=
ock *parent)
>>          * pin it (hold_unless_zero() additionally skips a chan alrea=
dy past
>>          * its last reference).  We then drop the sk lock before taki=
ng
>>          * chan->lock, so sk and chan locks are never held together.
>> +        *
>> +        * Since we cannot call l2cap_chan_close() without conn->lock,
>> +        * schedule l2cap_chan_timeout to close the channel; it alrea=
dy
>> +        * acquires conn->lock -> chan->lock in the correct order.
>>          */
>>         while ((sk =3D bt_accept_dequeue(parent, NULL))) {
>>                 struct l2cap_chan *chan;
>> @@ -1529,14 +1533,12 @@ static void l2cap_sock_cleanup_listen(struct =
sock *parent)
>>                        state_to_string(chan->state));
>>
>>                 l2cap_chan_lock(chan);
>> -               __clear_chan_timer(chan);
>> -               l2cap_chan_close(chan, ECONNRESET);
>> -               /* l2cap_conn_del() may already have killed this sock=
et
>> -                * (it sets SOCK_DEAD); skip the duplicate to avoid a
>> -                * double sock_put()/l2cap_chan_put().
>> +               /* Since we cannot call l2cap_chan_close() without
>> +                * conn->lock, schedule its timer to trigger the close
>> +                * and cleanup of this channel.
>>                  */
>> -               if (!sock_flag(sk, SOCK_DEAD))
>> -                       l2cap_sock_kill(sk);
>> +               if (chan->conn)
>> +                       __set_chan_timer(chan, 0);
>
> Great that seems a lot easier to understand than the previous changes.
> I just don't quite follow why you are removing SOCK_DEAD handling with
> this?
>

l2cap_sock_cleanup_listen()                     [holds: parent sk_lock]
    bt_accept_dequeue()                           =E2=86=92 returns chil=
d sk + ref
    lock_sock(child sk)
    l2cap_chan_hold_unless_zero(chan)
    release_sock(child sk)
    l2cap_chan_lock(chan)
    __set_chan_timer(chan, 0)                      =E2=86=92 schedules d=
elayed work
    l2cap_chan_unlock(chan)
    l2cap_chan_put(chan)
    sock_put(sk)
        =E2=86=93 (deferred, on workqueue)
    l2cap_chan_timeout()                          =20
      mutex_lock(conn->lock)                      =E2=86=90 proper lock =
order
      l2cap_chan_lock(chan)
      l2cap_chan_close(chan, reason)
        l2cap_chan_del(chan, reason)
          chan->ops->teardown(chan, err)           =E2=86=92 l2cap_sock_=
teardown_cb()
            lock_sock(child sk)
            sk->sk_state =3D BT_CLOSED
            sock_set_flag(sk, SOCK_ZAPPED)
            release_sock(sk)
      chan->ops->close(chan)                       =E2=86=92 l2cap_sock_=
close_cb()
        l2cap_sock_kill(sk)
          chan->data =3D NULL
          l2cap_chan_put(chan)
          sock_set_flag(sk, SOCK_DEAD)
          sock_put(sk)


l2cap_chan_timeout() will do the l2cap_sock_kill() job for us.
Previously in Safa's patch, because that does not have conn-lock
protection, which might result in double kill so there is a defensive
check. In our version, this is totally not required.

>>                 l2cap_chan_unlock(chan);
>>
>>                 l2cap_chan_put(chan);
>> --
>> 2.54.0
>>
>
>
> --=20
> Luiz Augusto von Dentz

Best,
Siwei

