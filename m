Return-Path: <stable+bounces-232611-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEk+AD9czGlmSgYAu9opvQ
	(envelope-from <stable+bounces-232611-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 01:43:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B85372E55
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 01:43:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BFA893027953
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 23:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414CA3AE6FA;
	Tue, 31 Mar 2026 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="jcbAOBzp"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82C3A3821
	for <stable@vger.kernel.org>; Tue, 31 Mar 2026 23:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000606; cv=none; b=h74cewM9iIHznxyqjRu2L5094yc/FPUOMUlt7CMGwoZua+86OOr7T2AEDxO7nku2N8eHM7grD5l9XfDm6DvKw++DVnVpsda/c0s3mboUb0LzW7cD0RGyCd5D9CtJOeNanAQtOp4czaCCUINsPEdP9Rud/LlepfwyzO1HED2Ah3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000606; c=relaxed/simple;
	bh=3g2a38R67MBCRSp7Vsl58EBejHN/y3woO8+/KWmyCxo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=erhMyxXB6ufHIQddQYSl7dy9oFijZETpWu9XLaejURdAMU7K4F+mm1CMvRYi6QifO0hHMNsAj3vmrz2F+rRbhUeFOCK0hkGBzCCZ0r08b+w+dQ+s75uIu2LGYyQjP8PCW98DJfvvwBsA+Uiz2qMMBatgvUtvg67fDELtVaQDbLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=jcbAOBzp; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2ad9516a653so27455685ad.0
        for <stable@vger.kernel.org>; Tue, 31 Mar 2026 16:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1775000604; x=1775605404; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ns9AQ9mj0Un6sqyHivwFXkOMubqhHvzCLjhPKqBz+Qw=;
        b=jcbAOBzpHQkn8jO4EqpiCOi3GvhB2qTNJxULrgJ/oW9VFUi8WDx/gSSagvwL27sSvD
         ddBdPnBsZ00g/BDxa/JhDqsxO39EhLxRznxrCwC0O7nowVGhjtDtIRlDy4GK0jgyaL/m
         J/+73ETFhy4NPVQvPL1yK2DBVFlhk9f2nGKq+qSfTfYPGJX+7+5/+Naz20r4AbNNACPW
         yNhYfG8Grk18cYA0kBKcDUbxkz60TvQiVfQaggTwAVa7xOLZr4/r4CXJsBAz9XzEWUNj
         1W+fxQ+Kh3MGaKpw2mEZSwvkiTaV30KbYTzabwmNSUTyJQsJRyGsd7H6AQVLx9GAcylc
         B5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775000604; x=1775605404;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ns9AQ9mj0Un6sqyHivwFXkOMubqhHvzCLjhPKqBz+Qw=;
        b=GnL5gvjJ6XTi/hT0oey9uuVKm3vlT044zYMMNt4Gh3JudAFM6ADPyQncrJEe0fUoYN
         y4mU5uh7ou4X7ieOoMUcUlt02qJFvWi+5hM3bZcZW1G/bFD1guegGuJAWpGkN1nsun6q
         ESNOb1PoPf1BsAN2ZHS2R9IYye1nP/u1/YaMod9E0DYESSdGD5ypkUwDQfHDDR/w9ANB
         NDJ3qfeZTPr9SjlnnRg4QomNAvhzj/Hkkhz8UXUCd0AOiIw9eaySAA0vRFR/acaPpwnM
         bh0dQd6oYEvhZOLONfjNKfvRJ2WDvYZOKyC/lj0KrtBiY4X6sHylPfIh99dIaV1ocd7E
         AQBg==
X-Forwarded-Encrypted: i=1; AJvYcCVlbrICynU8jM8FagZWezpDxOKSWD/zwbcXHY2q4u+6eLgW8GSb0BNdithmuLjZGZusUexXuWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjDyW6gjZEaHHbeQyLwkJo8Fx1akKKiPZROH4V8cNbln7P29sx
	XtNsSh+YXhsCVChd10Z0J0b3W+3c6n58XLxRTNG27OIlHbzBdGr7Nn9dfY46HJN8CPs=
X-Gm-Gg: ATEYQzxaEOXRrSzZSBiTQoOuu79dD17eO8/9qvkcmrc9uYQCggv5Vm3kXSw7F3VtxU8
	fPdDJEm2fVjn34PdTpOaCe/YB66PMuAqEgYoMNWJY79kNNq1+07s7XpxgbhftcRHc611AjL2y1K
	FEnmq6VCgoTYAtys9z/MsWOC1togwMzErG3dcaCP+xWItXvOIzBtCGmnF0kJfg6WdI/75qdzMn1
	qEpjdX32nBhihxq7cLH4f/jnWo+NbsSsfmauSuim0FuWRdTD5sFygQpS6LG9ZGk5h01KKhOo/+C
	JsKwSwA0ThOTOJMzk12OKh+S2qZ5ckAtDsezt8G5/uJCowJ9f1nRqfFFlJhLC4iowWhNQqg92NP
	6eGQe5E2WdDmD2Jxet1FuIft4Rca5NFIk6o4Afj3H2rXNVpfUbNmedpPmOtRNKF/oZ/xAdmZVdb
	6gBMoY
X-Received: by 2002:a17:903:2d2:b0:2b0:beb4:3bb with SMTP id d9443c01a7336-2b269a805cdmr9425095ad.10.1775000603562;
        Tue, 31 Mar 2026 16:43:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:51::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24266e487sm123072225ad.24.2026.03.31.16.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:43:23 -0700 (PDT)
Date: Tue, 31 Mar 2026 16:43:22 -0700
From: Joe Damato <joe@dama.to>
To: Wang Jun <1742789905@qq.com>
Cc: Jes Sorensen <jes@trained-monkey.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-acenic@sunsite.dk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: alteon: Add missing DMA mapping error checks in
 ace_start_xmit
Message-ID: <acxcGhzbNsHdK49W@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>, Wang Jun <1742789905@qq.com>,
	Jes Sorensen <jes@trained-monkey.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-acenic@sunsite.dk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, gszhai@bjtu.edu.cn,
	25125332@bjtu.edu.cn, 25125283@bjtu.edu.cn, 23120469@bjtu.edu.cn,
	stable@vger.kernel.org
References: <tencent_FAB2A00E105488F503DCC787B8060F881E06@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_FAB2A00E105488F503DCC787B8060F881E06@qq.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[dama-to.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[dama.to];
	TAGGED_FROM(0.00)[bounces-232611-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[qq.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joe@dama.to,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[dama-to.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qq.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dama-to.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 59B85372E55
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 09:48:41AM +0800, Wang Jun wrote:
> The ace_start_xmit function does not check the return value of
> dma_map_page (via ace_map_tx_skb) and skb_frag_dma_map when building
> transmit descriptors. If mapping fails, an invalid DMA address is
> written to the descriptor, which may cause hardware to access
> illegal memory, leading to system instability or crashes.
> 
> Add proper dma_mapping_error() checks for all mapping calls. When
> mapping fails, free the skb, increment the dropped packet counter,
> and return NETDEV_TX_OK.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Is this fixing a bug you've seen in the wild? If not, I'd probably drop the
fixes tag and send this to net-next instead.

> Cc: stable@vger.kernel.org
> Signed-off-by: Wang Jun <1742789905@qq.com>
> ---
>  drivers/net/ethernet/alteon/acenic.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/ethernet/alteon/acenic.c b/drivers/net/ethernet/alteon/acenic.c
> index 455ee8930824..acabede53663 100644
> --- a/drivers/net/ethernet/alteon/acenic.c
> +++ b/drivers/net/ethernet/alteon/acenic.c
> @@ -2417,6 +2417,11 @@ static netdev_tx_t ace_start_xmit(struct sk_buff *skb,
>  		u32 vlan_tag = 0;
>  
>  		mapping = ace_map_tx_skb(ap, skb, skb, idx);
> +		if (dma_mapping_error(&ap->pdev->dev, mapping)) {
> +			dev_kfree_skb(skb);
> +			dev->stats.tx_dropped++;
> +			return NETDEV_TX_OK;
> +		}
>  		flagsize = (skb->len << 16) | (BD_FLG_END);
>  		if (skb->ip_summed == CHECKSUM_PARTIAL)
>  			flagsize |= BD_FLG_TCP_UDP_SUM;
> @@ -2438,6 +2443,11 @@ static netdev_tx_t ace_start_xmit(struct sk_buff *skb,
>  		int i;
>  
>  		mapping = ace_map_tx_skb(ap, skb, NULL, idx);
> +		if (dma_mapping_error(&ap->pdev->dev, mapping)) {
> +			dev_kfree_skb(skb);
> +			dev->stats.tx_dropped++;
> +			return NETDEV_TX_OK;
> +		}


I am not sure about this. The function ace_map_tx_skb seems to modify a
tx_ring_info entry, possibly writing invalid state to it if the dma_map_page
fails?

Maybe a better fix would be to refactor ace_map_tx_skb and do the
dma_mapping_error check there and change the return type of the function and
the code flow?

Then you wouldn't need to duplicate the error path handling code.

