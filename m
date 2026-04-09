Return-Path: <stable+bounces-235410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IHbJDqal12lfQwgAu9opvQ
	(envelope-from <stable+bounces-235410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 15:12:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C88BF3CAD6C
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 15:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 42A0230107D8
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 13:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C8F13CF04D;
	Thu,  9 Apr 2026 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPfEAVd5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDAE38A72E;
	Thu,  9 Apr 2026 13:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775740290; cv=none; b=a4+bztqbDhsu8dY79lJz6yzyOWWLTeGZ8PLLNXuDNZf1cc8GQjv3qkAuENOrTIW6YFjVeCKshAS8F62drlnGAahNQluMTI8A+rMzaWIBVkN6w6VscZ2Aj89PUWO6+ZrXKQQTx3oBCwRvpzfhRIGQ6I1dWvDA3EtWjynlFHT2RM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775740290; c=relaxed/simple;
	bh=HP2xkBscO14zBS6BrtAtDceA8baIkk8pmdfWeP95kSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM/apyUQf9cHRKfTDwN3oS89N1AHj6TL3Nqghvtw03Z3KHrDzblvbFsF3fSVU8TNyeULAAjlUfr0FxaiIGJ+2SXn+OcoOUXhkUbuZldjDJUBh6PWEseMyTdjHRbPvTd0sjuFZStfCexPHyfS49DpAmTsD1cMWrmssj4k2FduFrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPfEAVd5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF896C4CEF7;
	Thu,  9 Apr 2026 13:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775740289;
	bh=HP2xkBscO14zBS6BrtAtDceA8baIkk8pmdfWeP95kSc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPfEAVd5vG4hK8tkqoGG8WVE7OfoXDDZnsv3XotpYJGTz8wqZbbZ833oxB4KNLKQn
	 Q288IuhndR9eaxit8+ZbFO4oTUOdO3t6OgvB0o7knnY4vR8A5QlCfYbjV8lM3LeAi0
	 FyEoJ5yKdIhwgiP0tfuduytnFf8TZaWVFFFGRqvPMEqO9BZq5Oy2kKkZJ+S43zJ2rq
	 stCmaPwFzvknctyegw76e/HfrG3+Op0MBrxeAVa9IDGkX6roxBghzxk1MvULTuWC0b
	 CplHrYguG5StDcRpI7D6FQB3YSin7nV3mCGQwq9YBA5PljwnH0J6dQhUJY4SRK6tbV
	 G8xKNvG6DrLpA==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1wApAN-00000001ggX-1mI2;
	Thu, 09 Apr 2026 15:11:27 +0200
Date: Thu, 9 Apr 2026 15:11:27 +0200
From: Johan Hovold <johan@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: Sunny Luo <sunny.luo@amlogic.com>,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Chin-Ting Kuo <chin-ting_kuo@aspeedtech.com>,
	=?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
	Radu Pirea <radu_nicolae.pirea@upb.ro>,
	William Zhang <william.zhang@broadcom.com>,
	Kursad Oney <kursad.oney@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>, linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Heiner Kallweit <hkallweit1@gmail.com>
Subject: Re: [PATCH 14/20] spi: fsl: fix controller deregistration
Message-ID: <adelf3U4Tqp0-2Jz@hovoldconsulting.com>
References: <20260409120419.388546-1-johan@kernel.org>
 <20260409120419.388546-15-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409120419.388546-15-johan@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[amlogic.com,aspeedtech.com,kaod.org,upb.ro,broadcom.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235410-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[13];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C88BF3CAD6C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 09, 2026 at 02:04:13PM +0200, Johan Hovold wrote:
> Make sure to deregister the controller before releasing underlying
> resources like DMA during driver unbind.
> 
> Fixes: 4178b6b1b595 ("spi: fsl-(e)spi: migrate to using devm_ functions to simplify cleanup")
> Cc: stable@vger.kernel.org	# 4.3
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>

> @@ -614,7 +614,7 @@ static struct spi_controller *fsl_spi_probe(struct device *dev,
>  
>  	mpc8xxx_spi_write_reg(&reg_base->mode, regval);
>  
> -	ret = devm_spi_register_controller(dev, host);
> +	ret = spi_register_controller(host);
>  	if (ret < 0)
>  		goto err_probe;
>  
> @@ -751,7 +751,13 @@ static void plat_mpc8xxx_spi_remove(struct platform_device *pdev)
>  	struct spi_controller *host = platform_get_drvdata(pdev);
>  	struct mpc8xxx_spi *mpc8xxx_spi = spi_controller_get_devdata(host);
>  
> +	spi_controller_get(host);
> +
> +	spi_unregister_controller(host);
> +
>  	fsl_spi_cpm_free(mpc8xxx_spi);
> +
> +	spi_controller_put(host);
>  }

I missed that this module registers two platform drivers so this patch
will need another spin (reported by Sashiko).

Johan

