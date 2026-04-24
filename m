Return-Path: <stable+bounces-240640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGT3Gx9X62nkKwAAu9opvQ
	(envelope-from <stable+bounces-240640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:42:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A08F845DEB4
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 653CB3003722
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E11033BE644;
	Fri, 24 Apr 2026 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WpFXVTpw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A239A3ACA4B;
	Fri, 24 Apr 2026 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030935; cv=none; b=L1m1wcBd6i3afJqthFprMxOHKj/zLchVZPLQ4I/ZKlVPja9d0WKcC3FT2QIW0NLXRW9OIAfJf/EbCI8qrw9j2Hj+XgD1WnZeVzX0Jlzooo4vxEltNt4uJvhvJxa5PyoCOlSJZwLS0qEhFrlHoFg7gnDLxk/JoT/CnMHR1u9KOaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030935; c=relaxed/simple;
	bh=4W6W28oQ9tYxBvQu92r59YpXTkIqDtFU5bKJl2RfmB4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=OjcF+12HLxJ4//s//7h0OhBNmD4taRtEi2bpIqLCB0d/NyR4K0uTbpk24TJK+cUHW3tpxFOSLkfJKIVIQCS9p8uYWWsBb5ZW0KbNLjaa+tisuMYlzp7AMnz1abZHaLU/XOywZ6NK0rHj1YBjdjikS7pduQh/ybd8PF8G0ZO2cOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WpFXVTpw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 283B9C19425;
	Fri, 24 Apr 2026 11:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777030935;
	bh=4W6W28oQ9tYxBvQu92r59YpXTkIqDtFU5bKJl2RfmB4=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=WpFXVTpwYsAilpyRKcB2OkVSf3DerhzvCj9yDZIgXGtVye6lKjhyDQy3FdRT23OJw
	 lxatoqec78Y0gYvbmaOHS7D7sBep9TnJvQkMQQ2Mkt70+UpWrUtEOD1EM1WcjY6TjB
	 XS281/sZ63iVaVKiGPJKc7njUBqtueH5rf/FG3Cl7UEZVfqiB1xwlG7GglRPzyW4ru
	 vYSN0vyaidYANRP7FzWSiHMkaebS7tIzpo2LFToWlRlYnKqwbQ1F4dtx+GxoBDunHP
	 em1qYoELYpKOkCmuGbEnmglfg47fanVaxBpgE34rFnRVWZD3xCHNvgParchSYThJAh
	 INwIaDkvOxdyg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 24 Apr 2026 13:42:12 +0200
Message-Id: <DI1CW4GWGUD6.2K7VZG165WJP8@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH] driver core: faux: fix root device registration
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, <driver-core@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
To: "Johan Hovold" <johan@kernel.org>
References: <20260424102231.2615557-1-johan@kernel.org>
In-Reply-To: <20260424102231.2615557-1-johan@kernel.org>
X-Rspamd-Queue-Id: A08F845DEB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240640-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Fri Apr 24, 2026 at 12:22 PM CEST, Johan Hovold wrote:
> diff --git a/drivers/base/faux.c b/drivers/base/faux.c
> index fb3e42f21362..402ed119dfdf 100644
> --- a/drivers/base/faux.c
> +++ b/drivers/base/faux.c
> @@ -133,6 +133,9 @@ struct faux_device *faux_device_create_with_groups(co=
nst char *name,
>  	struct device *dev;
>  	int ret;
> =20
> +	if (IS_ERR_OR_NULL(faux_bus_root))
> +		return NULL;

As Greg mentioned, if this happens we already have a much bigger fundamenta=
l
problem earlier in the boot process.

Anyway, I think this check only catches when root_device_register() fails, =
but
everything that comes after root_device_register() in faux_bus_init() still
leaves us with a dangling pointer.

> +
>  	faux_obj =3D kzalloc_obj(*faux_obj);
>  	if (!faux_obj)
>  		return NULL;
> @@ -234,17 +237,9 @@ int __init faux_bus_init(void)
>  {
>  	int ret;
> =20
> -	faux_bus_root =3D kzalloc_obj(*faux_bus_root);
> -	if (!faux_bus_root)
> -		return -ENOMEM;
> -
> -	dev_set_name(faux_bus_root, "faux");
> -
> -	ret =3D device_register(faux_bus_root);
> -	if (ret) {
> -		put_device(faux_bus_root);
> -		return ret;
> -	}
> +	faux_bus_root =3D root_device_register("faux");
> +	if (IS_ERR(faux_bus_root))
> +		return PTR_ERR(faux_bus_root);
> =20
>  	ret =3D bus_register(&faux_bus_type);
>  	if (ret)
> @@ -260,6 +255,6 @@ int __init faux_bus_init(void)
>  	bus_unregister(&faux_bus_type);
> =20
>  error_bus:
> -	device_unregister(faux_bus_root);
> +	root_device_unregister(faux_bus_root);
>  	return ret;
>  }
> --=20
> 2.53.0


