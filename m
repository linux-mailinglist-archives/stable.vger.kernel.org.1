Return-Path: <stable+bounces-58157-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F3F928FC7
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 02:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0779228454F
	for <lists+stable@lfdr.de>; Sat,  6 Jul 2024 00:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85E75221;
	Sat,  6 Jul 2024 00:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="et3Qls7j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F7F4C6D;
	Sat,  6 Jul 2024 00:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720226373; cv=none; b=HDUExufpANwmMuD9M1yjQlidgc9go5jvCETjcenEoc+hrnB9n49CY+7MlhUKUO4Dg2IKo94iiLj3CXWbc8fOvX0eke2EpdFCa+743uH/w2sDrKImu3CQ4MOpk0own/lA6/T0efgFYFTeBdcomsPu9KIRAbdK7TtJyjD3LRleyKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720226373; c=relaxed/simple;
	bh=CpHBOeXV3xmjPz2+jOCXA/1+Ba175UmTM9J9t7F7AJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=avwzh02QaGwDVT5DFJ8nVel38nAPQS7OWH3lvapiI4JWCwRC12ouygdtjZ7yuGvmmlfdH4unX3MUpFAfI/O3wniTtSzKNHQuFlNZTsNMPT8EqR0CEBB1OhfxirnUqPMW9F7g5JHztvkQEjuVQbdObiAhzkzs6f+ta3e38LEZa3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=et3Qls7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA85BC116B1;
	Sat,  6 Jul 2024 00:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720226373;
	bh=CpHBOeXV3xmjPz2+jOCXA/1+Ba175UmTM9J9t7F7AJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=et3Qls7jz+778nihi/Hi5XUJVv26OZS4i50ioy+4ymVDvpwVj5DM2G3VbssDGusbO
	 oI4tkCqjBskJUXTqDf/o90ks20S+om51GKISLlMeGay6jFGHxzI+tbBim+FemKOK4H
	 5iVq57kQ++JHQdcIZkylS255aLcwLEnzqlFdbFSvETYmmknhnpdJqmGQ9t0XG1lraj
	 21ZTJ2lT5Z6/GjTLI6TvgrBzCRRbRt7xN31YUyKFvmXq2XabgCFrGm4avMs9IRcUb4
	 5lA/j/KWw+Jg8+0uqmKbRBKYJDY6EoPKyqW3UgbwKGCvu3YujEQNhK+k6pEMy9SB1h
	 EPgoeIlpj0iaQ==
Date: Fri, 5 Jul 2024 17:39:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ronald Wahl <rwahl@gmx.de>
Cc: Ronald Wahl <ronald.wahl@raritan.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] net: ks8851: Fix deadlock with the SPI chip variant
Message-ID: <20240705173931.28e8b858@kernel.org>
In-Reply-To: <20240704174756.1225995-1-rwahl@gmx.de>
References: <20240704174756.1225995-1-rwahl@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jul 2024 19:47:56 +0200 Ronald Wahl wrote:
> --- a/drivers/net/ethernet/micrel/ks8851_spi.c
> +++ b/drivers/net/ethernet/micrel/ks8851_spi.c
> @@ -385,7 +385,7 @@ static netdev_tx_t ks8851_start_xmit_spi(struct sk_buff *skb,
>  	netif_dbg(ks, tx_queued, ks->netdev,
>  		  "%s: skb %p, %d@%p\n", __func__, skb, skb->len, skb->data);
> 
> -	spin_lock(&ks->statelock);
> +	spin_lock_bh(&ks->statelock);
> 
>  	if (ks->queued_len + needed > ks->tx_space) {
>  		netif_stop_queue(dev);
> @@ -395,7 +395,7 @@ static netdev_tx_t ks8851_start_xmit_spi(struct sk_buff *skb,
>  		skb_queue_tail(&ks->txq, skb);
>  	}
> 
> -	spin_unlock(&ks->statelock);
> +	spin_unlock_bh(&ks->statelock);

this one probably can stay as spin_lock() since networking stack only
calls xmit in BH context. But I see 2 other spin_lock(statelock) in the
driver which I'm not as sure about. Any taking of this lock has to be
_bh() unless you're sure the caller is already in BH.

