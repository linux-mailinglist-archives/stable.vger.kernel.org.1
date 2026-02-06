Return-Path: <stable+bounces-214633-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCMKKHS+hWnEFwQAu9opvQ
	(envelope-from <stable+bounces-214633-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:12:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 195A8FC87F
	for <lists+stable@lfdr.de>; Fri, 06 Feb 2026 11:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8021A301F141
	for <lists+stable@lfdr.de>; Fri,  6 Feb 2026 10:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BC5B36214B;
	Fri,  6 Feb 2026 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GPtAMtyP"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131E63559D0
	for <stable@vger.kernel.org>; Fri,  6 Feb 2026 10:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770372720; cv=none; b=upAsctk+9eiIt+VH/FAAJLvVUGRekcLSk3Y1Eh/ErUD8Y8/eaiBOmg889T9x7cqalm+LUaC+1rqh/XcKeE1IP9Y8FBO7xq3roWT3wI4iLj+8O3iWlMPVPwb/Gk056xEvj/QHg8lvTXSYKoAg3+Rsk7I5ZTxHK1af5Ym9z7WwFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770372720; c=relaxed/simple;
	bh=bvwHvjSQ/hfj02XF6jjSZ9zQcgR86MaVlH04g39YvWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sUhoNY8iQuxuSeYVJSBmijRUbYXrnlgYJzDS/NhFMqPIWD3REDmUrRR4JIpvVt56hrSKZljN2EeAi6J4rOIgCu6Hq19YaAfGZWszsLK1jPtrc8u5+wwhVnR1zuSK2sNgXZzMcjB9yizN8p/Spel55p61sfjxAapLpnZPIRaMSMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GPtAMtyP; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4b77adso2240445c88.1
        for <stable@vger.kernel.org>; Fri, 06 Feb 2026 02:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770372719; x=1770977519; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YL7l6FUhwLXLtOpb1fFU6EEOhi9oZHPk+5rk25coNs0=;
        b=GPtAMtyP0e5ayQyAe1cvkxmwTluk1oGFW3YcBMrn93RXTjnQpnz5InzdNR4eC6iLZH
         8TUqe8tgNJnKSFCjmWDh/ruODOj8cnuqKj0aHMCCwtXLKeQG4ZAsX6glG5AbToNQGafP
         uyvBy35RfavjwSZvZLJXA+qBYlFvHt70kfv9EyZexRKnQjAc6fG9UE2y27/9YAuDlvOh
         n6dBgjXx0y9XY2WpkflFUZ1T9Qt3WtXwhxudgZOualGe1Y8AdNxuIlfq60zlnQ1hat6Z
         OwKlrYunMMz8YLHdHruzfiQEFVvW54mwtzuDqel+lchTMtqKbD+V4Uq9qB0oQrE+Hw06
         II9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770372719; x=1770977519;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YL7l6FUhwLXLtOpb1fFU6EEOhi9oZHPk+5rk25coNs0=;
        b=aBVYBxrBHh9wHzhaPRB34QftFec/46A3/4/UiBgho3MJBlKCmBtzGEybtruQ7Yjwbp
         41lVQW++M/RK4nUmDaG6pBONSDbIdG9nrTG6v2lYjuHUxKXSqMPbQ5oAuBLZ0kHALhmr
         VUUwecQtFPWVM8wA0MXJ1aPhCHeIbpxayZ1LJ9EBrT7Pn1lfeO6SeDS0caTSNX0FKJqh
         pis7Z0elM+9ytCV3UjCoosnnqc8P+qmNtVwTbQP8c4UNCMD2ScFX5qirH3CwUwNIoZkd
         7L2B3ukvVKLFe8bjQ1SWeq/sm+QtbhTz3FWqsSWeANEY8vugdiUtE+vjVM4flC4Fe7QT
         9CMQ==
X-Gm-Message-State: AOJu0YzFTX5Riped0ioQ+KucYyEQUgfFGD3yEvmk2uBAoShg6K//So03
	/vwSnCM3zkhMkFD8W3hMLVAjTmROVeZwCWDaNkSXJUcfE+5d1CpOtrfF
X-Gm-Gg: AZuq6aJKIWRiiemmB3tfqWOKyUQ2+oQODdnU2y2eC6bT7FRYXqE9ucEmmd8oI6FUxPz
	PXmifbzlY4/1c6vr0YBSlEjMdlfEd8oZdu0ocxUVYa6TyGbRxeK5wpalYDgFFMmZGTJF+toDMzE
	UkDMB94C4Y/5OkO3f3gUN5QsBQ82QnMn9vuw9VuxUCbxxIIQpMTgj7Drpg/w1lOkIMyVsmZX5vw
	Hhe9CZvCJQLd2y+AdJcFyQ7JgAXvknvCRV5Gd0N6M1wHzeZRjfAVvYcPkQ6QtCsTGcfYTGiZMO1
	R2bI5TJDpGNaOWXn26smQDHHbfTS4D2KcEmf0dQJTK8CDznjq1NCK3/QacPv9xKjzYhBqUvSdNC
	uNnXu1uJlUaYbzeJES3yUif5CtE/odm2A3ySDiTWiJdiSkTmFJ9CjVY5+SHsdS5P93zMYs4GS90
	zw3DdKQUDKF9MBWRN8Zg==
X-Received: by 2002:a05:7022:e20:b0:122:1d4:28ff with SMTP id a92af1059eb24-12703ff9ea2mr1099124c88.26.1770372718963;
        Fri, 06 Feb 2026 02:11:58 -0800 (PST)
Received: from pek-khao-d3 ([128.224.246.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1270434760fsm1650255c88.16.2026.02.06.02.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 02:11:58 -0800 (PST)
Date: Fri, 6 Feb 2026 18:11:52 +0800
From: Kevin Hao <haokexin@gmail.com>
To: netdev@vger.kernel.org
Cc: stable@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Roger Quadros <rogerq@ti.com>,
	Mohan Reddy Putluru <pmohan@couthit.com>,
	MD Danish Anwar <danishanwar@ti.com>, Arnd Bergmann <arnd@arndb.de>,
	Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH net v2] net: ti: icssg-prueth: Add optional dependency on
 HSR
Message-ID: <aYW-aC0GS0GehD7u@pek-khao-d3>
References: <20260206-icssg-dep-v2-1-9dae19b19e6d@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YMX5WzSd9G/YDFPi"
Content-Disposition: inline
In-Reply-To: <20260206-icssg-dep-v2-1-9dae19b19e6d@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214633-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 195A8FC87F
X-Rspamd-Action: no action


--YMX5WzSd9G/YDFPi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 06, 2026 at 11:20:56AM +0800, Kevin Hao wrote:
> diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
> index fe5b2926d8ab060d83f5a58d91e749a45c6cea18..ade43c921c71daca930df5e890ca00b3ccf600c4 100644
> --- a/drivers/net/ethernet/ti/Kconfig
> +++ b/drivers/net/ethernet/ti/Kconfig
> @@ -192,6 +192,7 @@ config TI_ICSSG_PRUETH
>  	depends on NET_SWITCHDEV
>  	depends on ARCH_K3 && OF && TI_K3_UDMA_GLUE_LAYER
>  	depends on PTP_1588_CLOCK_OPTIONAL
> +	depends on HSR if HSR

It appears that support for this syntax [1] has not yet been merged into the
net tree. I will change it to `depends on HSR || !HSR` and retest on the pure
net tree. Apologies for the noise.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=76df6815dab76d7890936dc5f6d91cf7e7f88358

Thanks,
Kevin

--YMX5WzSd9G/YDFPi
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmmFvmgACgkQk1jtMN6u
sXHmpwgAleChG1UY0fiZmLP+SqgtFAroY5ly8gKf/lHcD3RWLyLBj94OmwbYxO5J
JuxxXGjEynbsNvO2/xURy4mhNGAOkpH/38LERxrQQ9/DxfKRyBagL0ns/BMoWfTd
NFjOY0QiiqpSwx2ElKUV6Kb40OBXxmJ5GIYntLNmN251eaepohdrUtI7mmrMqiar
K4mJ/azQ1akAgtupvhXvraYIabJ2Ww16bannP+Gg2hXZRHzFeO7nxy7LnaNW/zCE
vbrJxF7gHqoPB9D7/Hg8rid/i2/+NxdKLXmQ4yfSo+UfHQ8jURP+gp02yrswSkC3
mY3BAmDat8aiFLFOdpv8L4eq64be4w==
=G5Oj
-----END PGP SIGNATURE-----

--YMX5WzSd9G/YDFPi--

