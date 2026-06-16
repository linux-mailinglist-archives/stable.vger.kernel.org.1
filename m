Return-Path: <stable+bounces-263636-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZZMRNVgGMWoQagUAu9opvQ
	(envelope-from <stable+bounces-263636-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 10:16:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39BFA68D145
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 10:16:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RSMDCDw5;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263636-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263636-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67F6A303DACC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 08:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B73D539B943;
	Tue, 16 Jun 2026 08:16:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F8F30F94B;
	Tue, 16 Jun 2026 08:16:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781597773; cv=none; b=Qwc9iqQKorQxAEwCGxTVVh4LImvA7c3wBIUgToc2BQ4rd8sJ4l9iwR6OLY+dXL1niJSYn+LbEd1wUhRP6k9XfZt8hDr1V8/NDmzUMGb8gh+D6DMiygxJQ/aC61o9t+7CQKIHLGadOMYuEQ033880uIAG00WUgttn5jrxI1l6xck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781597773; c=relaxed/simple;
	bh=i3Ys6nMGrYoaAZKUHMu2371/Hhb+1MgT45qrMlOz1Ew=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=bQXJZG8MYLDzlY85inoeyX26SlktiG3tr1lhIOWFkRaWzWRD4N/+Wvm0VD5OkTMfQ7ukfHXZ0FXZqpguAn7vodr/07tTMcKzs1Tt6gapbj+RjEXfgUoNmi22AoxUUuEiBDLBUk41gtrEElfA63iNfUisP4g8/pSPqpAzZRC0sA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSMDCDw5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AE71F000E9;
	Tue, 16 Jun 2026 08:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781597772;
	bh=KYszhK6WxOVPWQUbaHbnDx1n+yjag9Hv6cthNWEQF+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RSMDCDw51+nLSofJBh02sdNbMVceO0cma1wN64jWmVAWTZULW2R3tYlmeQ1ZcxDY2
	 MoW+axlsz5dL16v8oeezk2XDRiwwWXDct+8HBDTVreYhP42LWXkEEO0ewVtpk8xhsz
	 5qj/tKR5hxlICXVGGooZZMeAB6/WfZ3JnkbzqycvfZqULcJreSon8ys8qGqSkyZU8C
	 wIMRSzvtqFXKi0E6bJfaQE9eu50vt8jN4YaQe7Rtn2lmaawRpqo7+/PXz8CUMLWEaH
	 ObVLa7PCJ123b5i6BN0sJxc+5xBNqJQkIcyya0Ox/8fOWxykP2+zrFACa38wlb4j3A
	 JINTWWSXxukTQ==
Date: Tue, 16 Jun 2026 17:16:09 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sangyun
 Kim <sangyun.kim@snu.ac.kr>, Kyungwook Boo <bookyungwook@gmail.com>,
 stable@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH v2] spi: uniphier: Fix completion initialization order
 before devm_request_irq()
Message-Id: <20260616171609.358d9d8c39ff7a59cd1559fc@kernel.org>
In-Reply-To: <20260616011223.201357-1-hayashi.kunihiko@socionext.com>
References: <20260616011223.201357-1-hayashi.kunihiko@socionext.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-263636-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:hayashi.kunihiko@socionext.com,m:broonie@kernel.org,m:linux-spi@vger.kernel.org,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:sangyun.kim@snu.ac.kr,m:bookyungwook@gmail.com,m:stable@vger.kernel.org,m:mhiramat@kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mhiramat@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.infradead.org,snu.ac.kr,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mhiramat@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,socionext.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,snu.ac.kr:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39BFA68D145

On Tue, 16 Jun 2026 10:12:23 +0900
Kunihiko Hayashi <hayashi.kunihiko@socionext.com> wrote:

> The driver calls devm_request_irq() before initializing the completion
> used by the interrupt handler. Because the interrupt may occur immediately
> after devm_request_irq(), the handler may execute before init_completion().
> 
> This may result in calling complete() on an uninitialized completion,
> causing undefined behavior. This has been observed with KASAN.
> 
> Fix this by initializing the completion before registering the IRQ.
> 
> Reported-by: Sangyun Kim <sangyun.kim@snu.ac.kr>
> Reported-by: Kyungwook Boo <bookyungwook@gmail.com>
> Fixes: 5ba155a4d4cc ("spi: add SPI controller driver for UniPhier SoC")
> Cc: stable@vger.kernel.org
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>


> ---
> Changes in v2:
> - Rebase onto latest, no functional changes

BTW, please clarify the actual branch name instead of "latest".

Thanks,

> 
> drivers/spi/spi-uniphier.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-uniphier.c b/drivers/spi/spi-uniphier.c
> index cc20fd11f03f..86fce9a571da 100644
> --- a/drivers/spi/spi-uniphier.c
> +++ b/drivers/spi/spi-uniphier.c
> @@ -656,6 +656,8 @@ static int uniphier_spi_probe(struct platform_device *pdev)
>  	priv->host = host;
>  	priv->is_save_param = false;
>  
> +	init_completion(&priv->xfer_done);
> +
>  	priv->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
>  	if (IS_ERR(priv->base))
>  		return PTR_ERR(priv->base);
> @@ -679,8 +681,6 @@ static int uniphier_spi_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	init_completion(&priv->xfer_done);
> -
>  	clk_rate = clk_get_rate(priv->clk);
>  
>  	host->max_speed_hz = DIV_ROUND_UP(clk_rate, SSI_MIN_CLK_DIVIDER);
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

