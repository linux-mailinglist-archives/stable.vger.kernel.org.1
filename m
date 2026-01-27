Return-Path: <stable+bounces-211730-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLImF5NmeGnTpgEAu9opvQ
	(envelope-from <stable+bounces-211730-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 08:17:39 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BC03590AA5
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 08:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D27D7304601D
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 07:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B933A2D1F7C;
	Tue, 27 Jan 2026 07:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uat+wywh"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1072475CF
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 07:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769498216; cv=none; b=oZOJvm7b8B1VUelxImg8K1SVRVjtCUSu+5bwjBPlmVczM5pycrftVA0YSoV6ec6cs3PPjSiZ/QpR+LFPVhRGDKdCAtNR59etPDKRgUKUcB09n8aD6sl8IPi/lPr/rVSfk5fsf2JDlcUGHdSemVP2Uz0F5tnlGPGFhl5Ps2cBdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769498216; c=relaxed/simple;
	bh=O4lpA3jRQGFJYxvQ864WpAw3jPoN7vazpgZMK6tCcgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fk0BEbumsHMW0EVhHzqM4Cuqq6nmnnlcf6mTp+OxGWGDMAVsdu6AA84hCz5oQL3sGDTeSaC3Klg1NF6rx7zMOvhxexPgtUsHGVKECxk2FnSt7+iP+fW9yzsIXk9bFHNovPJprFTKifC22euMb2k6BagNmtP+NOB9U8pCa6XMY/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uat+wywh; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-88888c41a13so67057816d6.3
        for <stable@vger.kernel.org>; Mon, 26 Jan 2026 23:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769498214; x=1770103014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSGbfDfuOQBUd78sdGxgNuQv31knXCkQLP9+PKDyscg=;
        b=Uat+wywh6aLRwm8ft90sDzzOzLf4S6Z8fc7BN0u/rjchl6joFaFsDg4fWkhWOzGRp2
         orgYgFo/oYpml7p/U5T2e6PVzFfDP8bmuEguEGA90bIshogjG9StvvAWhQTZAL9aA2nD
         LzJCgOVNEt1HerYKC5Rr+u4m6+DcRbyeFFRszk5+qMULGM3lB3DMDcVKOLIJeyXsqRDI
         TCl/Vvhc1p+Td2kw20RTYadDWeVhMVhcSxhpLjZOSchxBfJ4iZHAvxLTCVaZAwdtQ//r
         qZ8PnC2wtVcQpiMb7bQrrJnQkUNRip2Q1hih+7D4R1G8E/Kk3whCHJvQM7cz/Q2T3fa+
         p48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769498214; x=1770103014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sSGbfDfuOQBUd78sdGxgNuQv31knXCkQLP9+PKDyscg=;
        b=Cb5EOjZ1c1+J8JjqFiw2G4BUxsTgrJD9Z4gN6LoSFaKO6mJ9o8icOOfm/YARFEjuUz
         FQK1ipyQFqRPvrJN7pKvcv/XyellSzsd9rA1r/1mSFvFgMflurM9E4Yvo/3rl013ISNm
         n8pMilZ3mHOlYvqeJdVG6RO0WWUnrQcExLzL7qtCiK3EBjDZHIXx/wEhGk7twbGU+5dZ
         FxPzvUDpvF5zLPnX/fMjsWbgkPE3ZlQNtgJZ+uY5xF61BWGegYHhgdQV6/i6D/NKyotE
         PNfyXbjO4Trctnhu6KUNhRVkWU/8TH5gBIBRl8YWnwn1FHx8tt0NLGgEMP4Vo2EvLpy+
         qMZw==
X-Forwarded-Encrypted: i=1; AJvYcCWGApq0+8ncugiIvNok/2sGl3153gOLwEjv3v/ynQsxFeA50vViWFlHwwZ7f0NzOmhyChVxHug=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKQpjnqR7MvacBkmYhV13zkLZB+GgDNUTeTyJfFmMKZYBo+ryk
	NxsxRiUGD+7QMq6P6BtyHuYGOiFg5na2XDVN43n3zDHaVc0zw5310Ll6
X-Gm-Gg: AZuq6aIUDnOAnzYgGrIWCm0lG12njjljqbHe3p9p5EvTYmPvzkMWZEumv5nAfzIQ5rC
	kIT/msogwInIr2taEfTtnO++xZsZwZltZf4lP9vPTkNGie6BmHnFy/JB84bPUGAx6sTbvXYj2zd
	NOAUZLJndUxIKNCMH9o5cKl+oekxXfMz3Z38gb/UfeUhAggLChU0eAxb8ku4U0jb20pGEKOefTN
	I41nf9FHlqKGwlm5OVJ9ewizbd+AM6lHCsbfwRWOBzUJLrAB5iyOrClER146l6hFh3xzm45Rgd/
	1ydlv3IU/lWal15hZsDVDeRa4178Bw8pLC4beKsWYfAfL6k3fOcMtu8RoZamRahioR1tItyj/Eg
	N3Sa5Y7cMKeI74VUyo+ow7lppXEWeMeYNmprRC5YoehILOkeZELBhQ8uy74YUlgbQNsWCxrfUNG
	Qx5/eQEYg=
X-Received: by 2002:ad4:5b89:0:b0:894:6622:a6d4 with SMTP id 6a1803df08f44-894cc96202cmr9307226d6.61.1769498213952;
        Mon, 26 Jan 2026 23:16:53 -0800 (PST)
Received: from pek-khao-d3 ([128.224.253.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e37c823bsm1221262185a.2.2026.01.26.23.16.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 23:16:53 -0800 (PST)
Date: Tue, 27 Jan 2026 15:16:46 +0800
From: Kevin Hao <haokexin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: kuniyu@google.com, andrew+netdev@lunn.ch, vladimir.oltean@nxp.com,
	s-vadapalli@ti.com, linux-omap@vger.kernel.org, rogerq@kernel.org,
	stable@vger.kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	edumazet@google.com, davem@davemloft.net
Subject: Re: [net,v2] net: cpsw_new: Execute ndo_set_rx_mode callback in a
 work queue
Message-ID: <aXhmXkWqrMOTCgnH@pek-khao-d3>
References: <20260125-bbb-v2-1-1547ffabc9d3@gmail.com>
 <20260127030556.3839208-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="HTNmXs20Xq35qd8U"
Content-Disposition: inline
In-Reply-To: <20260127030556.3839208-1-kuba@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211730-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BC03590AA5
X-Rspamd-Action: no action


--HTNmXs20Xq35qd8U
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jan 26, 2026 at 07:05:56PM -0800, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.

Thank you, Jakub. This is indeed a valid point, and I apologize for overlooking
this issue.  I will send a v3 to address it.

Thanks,
Kevin

--HTNmXs20Xq35qd8U
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEHc6qFoLCZqgJD98Zk1jtMN6usXEFAml4Zl4ACgkQk1jtMN6u
sXGOLAgAqOgEQOMZa8O38ImuMB1qyHJitTRzmWCu6eNKkTEuHm525osQVFQF8YJr
9sjzpJkJwYkpASyr0O15t5VQtwhbO43vU8HTS1JldIzSaDnQK9yDWO9cuqDhn6VP
aOp5aLuActYM6GfK8jqWQdgEn0Pz+xpBkryqR5/4IRWfJu5t738w/E0RBU7wEuZe
OM7Z+DIjEkwHea4Kijt+8vTPUhawi+cKoqibQRX/VRz5Pre6ujAdKk5WgZ842rsn
Sn37YqLLr65A5VPS3sR6bv3VkY3oT9RMVkckVJXlwllQp7VkDDlt7hD17d4yd07p
k6HK2+y0OqCJiowbPJGs32qiY7ow2w==
=v8L2
-----END PGP SIGNATURE-----

--HTNmXs20Xq35qd8U--

