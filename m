Return-Path: <stable+bounces-214401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGZrHro+hGlU1wMAu9opvQ
	(envelope-from <stable+bounces-214401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 07:54:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B5ABEF2AC
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 07:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C21C30058C3
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 06:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF3D355038;
	Thu,  5 Feb 2026 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YnI6RNMr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F27E275844;
	Thu,  5 Feb 2026 06:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770274485; cv=none; b=sLOZbo/uWpLSaUHRsP6M9oXnS9a9XQ+IUrkfe6azc9+yreOth8W/P13jfOIqfFsHIZTHwXgsljmemMJNd682scH5lCkBPWweWGgY6FAAb6BCL3KUdi9BGiHzFz0NPui5ugYoSwU87A91W+X0id5OEm0mDWGo0a/rwSe7raoC9/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770274485; c=relaxed/simple;
	bh=EEyaIS7c/Np/w/ayZ/fwd6oYNont392luQLgCjnHcqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k4TfkQjIqN8ZJb4ySR6dlZSUnlzHix2FMiaytYhj6tLh6zDJh6IiNJRRx5lqHqkURm72890uwNF0HcyJ5uk5eL676Bq05lYtHkO0ZMTZ5vYgXnLETz/SnX6V+TOFC28Prn9T3tnmAXVaF9A9NdGsuwX4QDrsYJ/hg+rsY/4nDRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YnI6RNMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E82EBC4CEF7;
	Thu,  5 Feb 2026 06:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770274485;
	bh=EEyaIS7c/Np/w/ayZ/fwd6oYNont392luQLgCjnHcqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YnI6RNMrjB8P3QuDfeXZj4xszCtFy0YMF+8N8ZMfymdZ9gx4glVSoc6aRgF77Vk35
	 GiPTaWQItTOr2z6lOoLDGYAUjBjrPbgaDWXzlw0W95uqE9vFGCkxQS5qrtPD/46hW5
	 lTcRlZnhqDGHWw0Qh8GmOmADpM6NsRyEaOTZLcrli79mJ0YkVDip7IgU/J2yIegRsg
	 jy25oKzOzuDLytA6X0XcVplJ2qcU+RDYgJBZBGeVhxbAvHmnUWr/epxFrwQLqomGMv
	 nhXo0pvsdNRyyP+iVz1jw1cSNd1jN5v4rzs6EpgYzQBU/Qgs+SNAo3W6MLBHabzMRN
	 TqZfvChTSpuBg==
Message-ID: <54bf1026-7d71-466d-b6c0-8714c7230f9f@kernel.org>
Date: Thu, 5 Feb 2026 07:54:41 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: wan/fsl_ucc_hdlc: Fix dma_free_coherent() in
 uhdlc_memclean()
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Zhao Qiang <qiang.zhao@nxp.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
References: <20260204162548.94160-3-fourier.thomas@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260204162548.94160-3-fourier.thomas@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214401-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chleroy@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	REDIRECTOR_URL(0.00)[aka.ms];
	DBL_BLOCKED_OPENRESOLVER(0.00)[aka.ms:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B5ABEF2AC
X-Rspamd-Action: no action



Le 04/02/2026 à 17:25, Thomas Fourier a écrit :
> [Vous ne recevez pas souvent de courriers de fourier.thomas@gmail.com. Découvrez pourquoi ceci est important à https://aka.ms/LearnAboutSenderIdentification ]
> 
> The priv->rx_buffer and priv->dma_rx_addr are alloc'd together as

You mean priv->rx_buffer and priv->tx_buffer I guess.

> contiguous buffers in uhdlc_init() but freed as two buffers in
> uhdlc_memclean().
> 
> Change the cleanup to only call dma_free_coherent() once on the whole
> buffer.
> 
> Fixes: c19b6d246a35 ("drivers/net: support hdlc function for QE-UCC")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
> ---
>   drivers/net/wan/fsl_ucc_hdlc.c | 10 +---------
>   1 file changed, 1 insertion(+), 9 deletions(-)
> 
> diff --git a/drivers/net/wan/fsl_ucc_hdlc.c b/drivers/net/wan/fsl_ucc_hdlc.c
> index f999798a5612..59cd861d13d6 100644
> --- a/drivers/net/wan/fsl_ucc_hdlc.c
> +++ b/drivers/net/wan/fsl_ucc_hdlc.c
> @@ -790,19 +790,11 @@ static void uhdlc_memclean(struct ucc_hdlc_private *priv)
> 
>          if (priv->rx_buffer) {
>                  dma_free_coherent(priv->dev,
> -                                 RX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
> +                                 (RX_BD_RING_LEN + TX_BD_RING_LEN) * MAX_RX_BUF_LENGTH,
>                                    priv->rx_buffer, priv->dma_rx_addr);
>                  priv->rx_buffer = NULL;
>                  priv->dma_rx_addr = 0;

You also have to do:
		priv->tx_buffer = NULL;
		priv->dma_tx_addr = 0;


Which that and commit message fixed you can add Reviewed-by: Christophe 
Leroy (CS GROUP) <chleroy@kernel.org>




>          }
> -
> -       if (priv->tx_buffer) {
> -               dma_free_coherent(priv->dev,
> -                                 TX_BD_RING_LEN * MAX_RX_BUF_LENGTH,
> -                                 priv->tx_buffer, priv->dma_tx_addr);
> -               priv->tx_buffer = NULL;
> -               priv->dma_tx_addr = 0;
> -       }
>   }
> 
>   static int uhdlc_close(struct net_device *dev)
> --
> 2.43.0
> 
> 


