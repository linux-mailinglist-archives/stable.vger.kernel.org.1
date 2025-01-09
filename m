Return-Path: <stable+bounces-108064-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7F0CA06F82
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 08:55:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17AE16785B
	for <lists+stable@lfdr.de>; Thu,  9 Jan 2025 07:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268A921518E;
	Thu,  9 Jan 2025 07:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="AW6NGAGu"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FAF1215062;
	Thu,  9 Jan 2025 07:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409272; cv=none; b=nbBd6d/koGlNijioC37CvkukhVD9sMAeYMnpO8zxPVROGC25yfYkP/SqqOmPPUJq2cIhFXsmNnVShhhEdV2VNAWnm27e8J4lo3iLIwmOWNxFx11mbgt+N2JKPAxbi7rBTr6jSdVoeJWO0eHerOele7ENFMczKJ8/2Vb3W/l2+dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409272; c=relaxed/simple;
	bh=mmJmJ6JAz9YIssksstd+v3lMHGHxtGiOwH0/0URMdf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHkjTbcGTw97yo9gkLLo0OjQ3T0fJrYgBkVenI02dkRvooknKPau47Esru2+WV7QBxDh/pThvXbkPT+JIPfF7fZNi3Cpf9Iwwe+1CiYifrt8U4xMCQH8ADUxAWEvxcDY6haSTFl9mV8QBdsOJ/AjVeKS4KUMKtXMKIwFCEyB8kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=AW6NGAGu; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fpc (unknown [10.10.165.9])
	by mail.ispras.ru (Postfix) with ESMTPSA id C5404518E771;
	Thu,  9 Jan 2025 07:47:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C5404518E771
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1736408837;
	bh=Az+6jP8MDfErUyWOlmvn0SscA94IxS3v4GF6Z/31+20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AW6NGAGu9rjGITuPyvR1LZvYTnvSU1nCyWseMYP4MeQUu2OigXCT/Bno6C3A15YdL
	 Lj6LYwL8QK8claIPQMxIC81IRP8coEbswFzDw4z3KACbsQCd1yDn9iPIRQ0pO92Hnd
	 SaaYFDBcTcG5k+ZyV8j9CJD9LtozMakLlP7TrnTg=
Date: Thu, 9 Jan 2025 10:47:12 +0300
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Eric Dumazet <edumazet@google.com>, linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP: handle NULL sock pointer in
 l2cap_sock_alloc
Message-ID: <20250109-fbd0cb9fa9036bc76ea9b003-pchelkin@ispras.ru>
References: <20241217211959.279881-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241217211959.279881-1-pchelkin@ispras.ru>

On Wed, 18. Dec 00:19, Fedor Pchelkin wrote:
> A NULL sock pointer is passed into l2cap_sock_alloc() when it is called
> from l2cap_sock_new_connection_cb() and the error handling paths should
> also be aware of it.
> 
> Seemingly a more elegant solution would be to swap bt_sock_alloc() and
> l2cap_chan_create() calls since they are not interdependent to that moment
> but then l2cap_chan_create() adds the soon to be deallocated and still
> dummy-initialized channel to the global list accessible by many L2CAP
> paths. The channel would be removed from the list in short period of time
> but be a bit more straight-forward here and just check for NULL instead of
> changing the order of function calls.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE static
> analysis tool.
> 
> Fixes: 7c4f78cdb8e7 ("Bluetooth: L2CAP: do not leave dangling sk pointer on error in l2cap_sock_create()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---

Urgh.. a bit confused about which tree the patch should go to - net or
bluetooth.

I've now noticed the Fixes commit went directly via net-next as part of a
series (despite "Bluetooth: L2CAP:" patches usually go through bluetooth
tree first). So what about this patch?

>  net/bluetooth/l2cap_sock.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
> index 3d2553dcdb1b..49f97d4138ea 100644
> --- a/net/bluetooth/l2cap_sock.c
> +++ b/net/bluetooth/l2cap_sock.c
> @@ -1888,7 +1888,8 @@ static struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
>  	chan = l2cap_chan_create();
>  	if (!chan) {
>  		sk_free(sk);
> -		sock->sk = NULL;
> +		if (sock)
> +			sock->sk = NULL;
>  		return NULL;
>  	}
>  
> -- 
> 2.39.5
>

