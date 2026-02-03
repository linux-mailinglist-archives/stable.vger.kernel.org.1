Return-Path: <stable+bounces-213273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOaPMK0ggmlIPgMAu9opvQ
	(envelope-from <stable+bounces-213273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 17:22:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 220E8DBD82
	for <lists+stable@lfdr.de>; Tue, 03 Feb 2026 17:22:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 141123087DC9
	for <lists+stable@lfdr.de>; Tue,  3 Feb 2026 16:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB203C197B;
	Tue,  3 Feb 2026 16:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="co8Dpl8z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6373C1976
	for <stable@vger.kernel.org>; Tue,  3 Feb 2026 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770135232; cv=none; b=XhX8ca7GVsLs43ht4XkoUJKV4JH+V80bPzcVldEPOhWYn/BtG5+7bQAs18nANEKHkdsK1BB/9aNkDv7uwreoZ/y4I+BIks5eH685/Jz+FxhG/+wYGQC3hkpHyqlWo2nrw8D/5xWvbr9aU4k2OXvM3sMO4mmHjrhL+nQRcTwQFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770135232; c=relaxed/simple;
	bh=6A5e3lFs3X+JQLUJxcY6H7jKng/P1jsXmzCo2YYsOVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCQwfGAglcZF4HxJo9FkL1vSN0RYt/+Tsp4e8EZwTtAuEcgpvWkRhig2YSJhIqEMTk4UP/3CcFanaMbpOw45A9a0hYik2qHii0YMLrQW6B/qxs6YdbVsYHK17C6039lKjmEzjBjc5qPB7TNPhtgHs+XLv5t20VzA4OFF0fL3fJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=co8Dpl8z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DA8C116D0;
	Tue,  3 Feb 2026 16:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770135231;
	bh=6A5e3lFs3X+JQLUJxcY6H7jKng/P1jsXmzCo2YYsOVc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=co8Dpl8zHjvO01MW7JPgIs+h162lyBfM6ecup9BxuoomAxV+5SedOFti5MlwR23Q2
	 UXH+mtaZt4rxcjV3ALreTQthzp5onpcHtm7y+00bLtXo1NrnLpklMk6D3Cdd/3691V
	 bRi5nJ+Moun6oT1WgYKaWzQgI7oxw1+3iDpMvehY=
Date: Tue, 3 Feb 2026 17:13:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5.15.y 1/4] ASoC: codecs: wsa881x: Simplify &pdev->dev in
 probe
Message-ID: <2026020344-marine-paprika-a0e0@gregkh>
References: <2026012029-possibly-cornhusk-03c3@gregkh>
 <20260121024740.1145743-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121024740.1145743-1-sashal@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-213273-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linaro.org:email]
X-Rspamd-Queue-Id: 220E8DBD82
X-Rspamd-Action: no action

On Tue, Jan 20, 2026 at 09:47:37PM -0500, Sasha Levin wrote:
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> [ Upstream commit c617c9e7024d152426acf9f1aaf01070b6852f13 ]
> 
> The probe already stores pointer to &pdev->dev, so use it to make the
> code a bit easier to read.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Link: https://lore.kernel.org/r/20230102114152.297305-2-krzysztof.kozlowski@linaro.org
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Stable-dep-of: 29d71b8a5a40 ("ASoC: codecs: wsa881x: fix unnecessary initialisation")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  sound/soc/codecs/wsa881x.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
> index c8d3dc6341037..f4fef94bdf989 100644
> --- a/sound/soc/codecs/wsa881x.c
> +++ b/sound/soc/codecs/wsa881x.c
> @@ -1101,20 +1101,20 @@ static int wsa881x_probe(struct sdw_slave *pdev,
>  {
>  	struct wsa881x_priv *wsa881x;
>  
> -	wsa881x = devm_kzalloc(&pdev->dev, sizeof(*wsa881x), GFP_KERNEL);
> +	wsa881x = devm_kzalloc(dev, sizeof(*wsa881x), GFP_KERNEL);
>  	if (!wsa881x)
>  		return -ENOMEM;
>  
> -	wsa881x->sd_n = devm_gpiod_get_optional(&pdev->dev, "powerdown",
> +	wsa881x->sd_n = devm_gpiod_get_optional(dev, "powerdown",
>  						GPIOD_FLAGS_BIT_NONEXCLUSIVE);
>  	if (IS_ERR(wsa881x->sd_n)) {
>  		dev_err(&pdev->dev, "Shutdown Control GPIO not found\n");
>  		return PTR_ERR(wsa881x->sd_n);
>  	}
>  
> -	dev_set_drvdata(&pdev->dev, wsa881x);
> +	dev_set_drvdata(dev, wsa881x);
>  	wsa881x->slave = pdev;
> -	wsa881x->dev = &pdev->dev;
> +	wsa881x->dev = dev;
>  	wsa881x->sconfig.ch_count = 1;
>  	wsa881x->sconfig.bps = 1;
>  	wsa881x->sconfig.frame_rate = 48000;
> @@ -1131,7 +1131,7 @@ static int wsa881x_probe(struct sdw_slave *pdev,
>  		return PTR_ERR(wsa881x->regmap);
>  	}
>  
> -	return devm_snd_soc_register_component(&pdev->dev,
> +	return devm_snd_soc_register_component(dev,
>  					       &wsa881x_component_drv,
>  					       wsa881x_dais,
>  					       ARRAY_SIZE(wsa881x_dais));
> -- 
> 2.51.0
> 
> 

Breaks the build :(

