Return-Path: <stable+bounces-233250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEE5Gs9K0Glo5wYAu9opvQ
	(envelope-from <stable+bounces-233250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 01:18:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EC1399062
	for <lists+stable@lfdr.de>; Sat, 04 Apr 2026 01:18:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1AEB4302D5D7
	for <lists+stable@lfdr.de>; Fri,  3 Apr 2026 23:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F162738D686;
	Fri,  3 Apr 2026 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPB+POND"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B389F279DAD;
	Fri,  3 Apr 2026 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775258300; cv=none; b=VbxKpq/em3eAixTN9SImpPC4iOQDlaAd7DZIHbT4+fsxS3PJ0aivC7F7QhoqBbR1p+PnKvhC+umh/rtNktg4mvB5yUWahiwvTIKWOL5tOEw4RPHxoLV+dmbKyMfvAHfowtnuVqFyYGzqhsUAWWgPy3y7Qbe+SKo2k2TdJE9dTWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775258300; c=relaxed/simple;
	bh=p22xzdd5WFdNJOSce82DqA7KMujph7DW2LReoAWow08=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CTK5SHyTnG/bRFe60slmvNn6AtgdldVcxlUMJTEQm5Z2HbRNFyYxiQfogOBRiN2oC59QacjkeR+5EvlX9sQVB8WvkC5BKv/ZmOsrMiU0duicKg4PnJC7Efw6kPem0ivb/rwt0waMQSy1Uu6xqUDgShmEJgBq313FJ2luw1svGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPB+POND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFBFC4CEF7;
	Fri,  3 Apr 2026 23:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775258300;
	bh=p22xzdd5WFdNJOSce82DqA7KMujph7DW2LReoAWow08=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hPB+PONDbndSqT9kqdks0T7s1wsbaFa7LBxOhfyFoYkltYqdnIrwQsoKNwUB7tU0n
	 QvTgmrv428N2Bd/WU3Ls9YN0MAsSq9LwMbo3oD2Rhr/dsotYXxGkyEuI72w8QRIgfK
	 GNPFjySvKnk92f0jG0zAweqzgtu9L4y9ktm3kUUEf4OPlqmwdwCU9Ij2rvEglUwuMh
	 y1FhkaiCcXDt9NwApsuTkpdS+ZyiUFLkzD5c6E7JKVKmwy8c/Fa0KroOc6Me6BVRqN
	 ey29VbuyswjHO9TeoXLxxhA0yLfUpyT0wfC/GwTjjAg/U4/pTy2PmRbT2ZYMBeUe1n
	 I97RydV6H+gmA==
Date: Fri, 3 Apr 2026 16:18:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2 2/3] net: lan966x: fix page pool and resources leak
 in error paths
Message-ID: <20260403161809.4908a79c@kernel.org>
In-Reply-To: <20260403230714.10667-2-devnexen@gmail.com>
References: <20260403230714.10667-1-devnexen@gmail.com>
	<20260403230714.10667-2-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-233250-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7EC1399062
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat,  4 Apr 2026 00:07:13 +0100 David Carlier wrote:
> lan966x_fdma_rx_alloc() creates a page pool but does not destroy it if
> the subsequent fdma_alloc_coherent() call fails, leaking the pool and
> leaving a dangling pointer in rx->page_pool.
> 
> Similarly, lan966x_fdma_init() frees the coherent DMA memory when
> lan966x_fdma_tx_alloc() fails but does not destroy the page pool that
> was successfully created by lan966x_fdma_rx_alloc(), leaking it.
> 
> Add the missing page_pool_destroy() calls in both error paths and
> NULL-out rx->page_pool after destruction to avoid a dangling pointer.

Okay...

> Fixes: 11871aba1974 ("net: lan96x: Use page_pool API")
> Cc: stable@vger.kernel.org
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>  drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> index 34bbcae2f068..b985ce64bb50 100644
> --- a/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> +++ b/drivers/net/ethernet/microchip/lan966x/lan966x_fdma.c
> @@ -120,8 +120,11 @@ static int lan966x_fdma_rx_alloc(struct lan966x_rx *rx)
>  		return PTR_ERR(rx->page_pool);
>  
>  	err = fdma_alloc_coherent(lan966x->dev, fdma);
> -	if (err)
> +	if (err) {
> +		page_pool_destroy(rx->page_pool);
> +		rx->page_pool = NULL;
>  		return err;
> +	}
>  
>  	fdma_dcbs_init(fdma, FDMA_DCB_INFO_DATAL(fdma->db_size),
>  		       FDMA_DCB_STATUS_INTR);
> @@ -958,6 +961,7 @@ int lan966x_fdma_init(struct lan966x *lan966x)
>  	err = lan966x_fdma_tx_alloc(&lan966x->tx);
>  	if (err) {
>  		fdma_free_coherent(lan966x->dev, &lan966x->rx.fdma);
> +		page_pool_destroy(lan966x->rx.page_pool);

but here the "dangling pointer" is fine?
I don't care either way but be consistent.

>  		return err;
>  	}
>  


