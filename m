Return-Path: <stable+bounces-223413-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMa/LhrLq2n7gwEAu9opvQ
	(envelope-from <stable+bounces-223413-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 07:52:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E74622A82F
	for <lists+stable@lfdr.de>; Sat, 07 Mar 2026 07:52:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAC033019BBA
	for <lists+stable@lfdr.de>; Sat,  7 Mar 2026 06:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2181437187B;
	Sat,  7 Mar 2026 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtH8j8tC"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF74BEAC7
	for <stable@vger.kernel.org>; Sat,  7 Mar 2026 06:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772866327; cv=none; b=FCGRLNz+gjgRiogXNCxND4/gTYk36izuXW/ULH+PMWCWHhGF+PlEffgamt7czyDmFWaJooYo/UThFKfGO7I+C8H01DYJwx/xtOCry7tvQfYig9ehtWQ/7LXCnwGKR95KNUC3Bog+iaNMqEmquWATXznhOUeoNwNNT5rNBwxLuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772866327; c=relaxed/simple;
	bh=OSlsQQWRjXkI+YDZisZnzLyIrzjF4TUkIjjQ32hcJjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mwEuKkq0MzX45E7DUP75QH6/s9eXEsSvsA6GSb3P15rf9QcVruQZ4y0R0z10bWqUnY7ZwYaSTRhrOFtTSKvPH9e+oNC7Phl02kLf7BceSniN6E7JbcbTBLuvRAkPAM9DaBM+vo9LczkMwni1rBWYzLklb8wmj7gOOs40w36gCsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtH8j8tC; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-12732e6a123so763273c88.1
        for <stable@vger.kernel.org>; Fri, 06 Mar 2026 22:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772866326; x=1773471126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OSlsQQWRjXkI+YDZisZnzLyIrzjF4TUkIjjQ32hcJjc=;
        b=YtH8j8tCo1phwnu4oupZthFV9Mr03pS0ECHMow+nbiHu6BQ1N1MZ8gDRWKJA+LqRPy
         NtJ/iugaaEJKLdZwPuUrRGhOqdegeXkzWrZqvesEP8ABDBpc8siWabtx/pwP6A2nn0L3
         C1R0azsyseTlSaaEE5+VvW21BjLLRAeLH4qgj3fIf+AuLwYLcjPQX7S5LF6vFUCDuS1z
         NmErZExCeqw68QxY+62gZeyqrDQUg4TGou04qy7P67HTmWD0masB950USJFsxfgFmM2n
         iLsRinnq+3iWGFd25Szaexd8nxLSbZ4ct1IC8oxpNJAEGbZJKxmLgWzLbLQAcvoWmbEM
         9vZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772866326; x=1773471126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OSlsQQWRjXkI+YDZisZnzLyIrzjF4TUkIjjQ32hcJjc=;
        b=eURUTbgHnbbMYjbYkY8ddo7Cw8SPrvawARw0Wf9ad7/en+MHyL7z4JIIeQVLXOnBiX
         FTHi0Ex6W4xcmjiNuweAcn+gH1aOeKQ6P7X1/ti8SOTW8rVNa5+ZeT4fO3GA4Uub4QhM
         fsSnStB17Cai9ngaghh8gaYjuVZI9DN/VIKzwIKUik+XzRujJyrcnNm6Lcje4AO52MX5
         2xsjD0C3hRgyRfVV9uF9r7BvbPNbuzoaTnFxzdm2UbFSyVd+znzjGZ33pjBQ7ga5jEtW
         GK05Omfwez0ytyNZpoZ36CZywgBOAX8W4wyomONIzVn/uXh78wOH3Wl35e0nnqjqEx9+
         ANog==
X-Forwarded-Encrypted: i=1; AJvYcCXpixyFtF9VejyYL3LDsKxwJ4mT1ySZ+VvccszyfjR9PUj9XyExthJ9xxEXp3kfbEwrpgdL1WI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt+jg92gDO0uhA3Z2o8pPGxEDA6qdQB+vPA2RYLlrx9V8NDkge
	5ca0C8iWeT8ONt5KqAJp3a84oKX142Vfg/kYzNh4k+8qv1hkY5KXtM5n
X-Gm-Gg: ATEYQzzLZ9j1U7NdEgJxa000V6E6+A1nIYTVVWLonKdU2nncFfg+jiT/NEWxMQML84m
	L9ieiydsLRtsmi/MjSStGK8NdFtWV3BQ3zQx00sBf1GR8qndOwVQvR1Rhe80elYIswxlVIBH5dk
	pGXijCpunyqVbLSkW8aAYTVtr8NPYEALwgvkuTsBrKW4COHmoBBQQ8iih55c6gjiuBqzZzEwDcy
	FMdpAQGyeoXsepRp3LGYJOUDwuX/Oy9hoWGebayJDOIPAwWLPW1hZUlcffN9L3Bxe9V6Q6DzSrb
	Gddv2xRv+43HxUmtihJJ80X+zH34QJmsOAvA/86IkQ2BrDMMV8c9W0DTwcXxXe4YNZo/FEmTbZT
	+N5uXt7nL3usaTnHKfZiYx3pQXuipM78bmCBOKQ9FKfWMVW32pXUt9rPsPRp9Nmf84cHL9gsBxH
	GjgeB2vNPjpnj4WkfLjNT4nyoANeua3g==
X-Received: by 2002:a05:7022:eacd:b0:11a:641f:ba11 with SMTP id a92af1059eb24-128c2e99683mr2189023c88.29.1772866325632;
        Fri, 06 Mar 2026 22:52:05 -0800 (PST)
Received: from pek-khao-d3 ([128.224.246.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128c3f58d24sm3227281c88.12.2026.03.06.22.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:52:04 -0800 (PST)
Date: Sat, 7 Mar 2026 14:51:57 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, claudiu.beznea@tuxon.dev, davem@davemloft.net,
	stable@vger.kernel.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com,
	nicolas.ferre@microchip.com, quanyang.wang@windriver.com
Subject: Re: [net] net: macb: Shuffle the tx ring before enabling tx
Message-ID: <aavLDcBS5F6qCydY@pek-khao-d3>
References: <20260305-zynqmp-v1-1-5de72254d56b@gmail.com>
 <20260307025638.1345906-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="VsGoh7P8rs3RZGT3"
Content-Disposition: inline
In-Reply-To: <20260307025638.1345906-1-kuba@kernel.org>
X-Rspamd-Queue-Id: 1E74622A82F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223413-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[haokexin@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	TAGGED_RCPT(0.00)[stable,netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


--VsGoh7P8rs3RZGT3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 06, 2026 at 06:56:38PM -0800, Jakub Kicinski wrote:
> Does this memcpy corrupt the descriptor fields on systems with 64-bit DMA?
> The macb_tx_desc() macro uses macb_adj_dma_desc_idx() to properly space t=
he
> descriptor pointers in the ring according to the descriptor size reported=
 by
> macb_dma_desc_get_size(bp), which can be 8 bytes (base), 16 bytes (with
> DMA64), or 24 bytes (with DMA64 + PTP). However, all three memcpy calls in
> this function use sizeof(struct macb_dma_desc), which is only 8 bytes and
> covers only the addr and ctrl fields.
>=20
> On systems where macb_dma64(bp) =3D=3D true, such as the AMD ZynqMp platf=
orm
> this patch targets, each descriptor has an additional macb_dma_desc_64
> struct containing the upper 32 bits of the DMA address (addrh field).
>=20
> When the shuffle copies descriptors using only 8 bytes, it moves the lower
> 32-bit address (desc->addr) and control word (desc->ctrl) to new positions
> but leaves the upper 32-bit address (addrh) unmoved in the old location.
> After the shuffle, hardware reads a composite 64-bit DMA address from
> mismatched descriptor slots: the old slot's addrh combined with the new
> slot's addr.

This is indeed an issue. Coincidentally, all the upper 32-bit addresses in =
the
tx ring were identical, which is why it went undetected during testing.
My apologies for this oversight; I will address it in the v2 version.

Thanks,
Kevin

--VsGoh7P8rs3RZGT3
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAmmryw0ACgkQk1jtMN6u
sXFV0wgAsfpO8R4Jx2xyazjRDjOh9ZH+gKN6Pc5SffFo6Oeg++2QZrs/D83ISecM
6z9OqYyrqiImNKWdQs2HUUwbYQCpZvVcl2EsXOxQW7tLjDgJQ63N2/yjTzwzKp+k
zTdfgLAi4daT8qclVg6HeRf9/JGUDDS6MczCPbelIg4o62diwfIdqDejInFadIfy
rewx4WDupImCf7iFwW3dUw+suwTAXTeE91WfOp+WVOj0BFiSdi4MRpQNaJX7jRks
dxQXV+fVm/hQlPh7tbT20+ZVoNyAy7bckL5QPVgOJAKxO1e80Vo9iuZCnQaQVa2k
6ovaRtd7BJ9s+0b6lM/ZntqB9p8UYA==
=7dPx
-----END PGP SIGNATURE-----

--VsGoh7P8rs3RZGT3--

