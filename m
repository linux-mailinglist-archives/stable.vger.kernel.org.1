Return-Path: <stable+bounces-238720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EfDOFLf5Wk1owEAu9opvQ
	(envelope-from <stable+bounces-238720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 10:09:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54FAC42805D
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 10:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 436E1300BC90
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 08:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC1B386436;
	Mon, 20 Apr 2026 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gRWduUQg"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13BF3845CF
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 08:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776672588; cv=pass; b=iy9eCyrPD5FuL/3ESdVw87Hme80VNxyzCuR5meW/Mv1vLPB2+AjyyvZqoXrsZaP2BurNQas4lgP4D+ibLyCvYuFRu0KSeAZoGRbml8jScK3al6VYDFu5WQ1+9o9Jyi+cegimw0SZz7BUthEXA6eRLkiW1qEjQgp6ieguWB5Ixdo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776672588; c=relaxed/simple;
	bh=LVEP0scsmITC0MJJGvwyPcEMuMmnB92hZivB/DSnqko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfJLIO/NHeSYrjFPGcUjIepF42OX0jSBnatNCyl+KmLl+uAM/hBfutFFZLU/RYPrv7N0spXPww/AJ2RCbpqpaVFzYUChk5OEGenBDM9E1Wa0lZ5MzYsrl44pJ5hYGRyTbSqOI7uEegkgK0GzaQZBZEMNltlPmcscDWnL70OHVZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gRWduUQg; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38eab6cf7d8so27105431fa.1
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 01:09:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776672585; cv=none;
        d=google.com; s=arc-20240605;
        b=eMnOUgaDcn3RmiRLJZqwy9UlZSUeTN22zIU0LXuFIkrmhtF/AkUyQGYmdUQ4yBhOSP
         1sCEZTjUTq2Fti0twTxGvsa1CGwcE+Eaw8wEpr+7Xkbzq9NGbA9IDpTG/MVsfIbvQq6r
         90LoMzxliT4h1gFtZ5Gj79OwVpqhkPEj9w35FEntsNDVHBm2DT7s4GSm+Z9na1l4fv99
         rqsxaHKjjoslIeiGtp0zuJyh/PY2+S1kF+GuARIZf82mcw8x8AUfQZvA1zobmTNqj/v4
         5UNaEzCecOf/F+xcNAlg7OAjhJI1nxN5+MT3L/pqrUNgi7CJKIIOE7eyIrCF4/WKup5z
         uULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Oby7Bx0gK5ynnasEbalEDWMKwfDNOligTGO8x/b0ik=;
        fh=zO/BCxG0B7C3wh1xPFQd6SeVZ6Il7s++RZRzpv/XLnM=;
        b=gxmt5n8BJqodf/u/a8feSqcWOqSDJMQuG7Op9g55UCVaQSFSBpmUefFxNoBKoP0zxO
         Fxq64rdxZ38JxNJDcbutazGR/b3mERUhjR4o1v8RyHFOo6Jd1QeOKLEnIy4oy22ce1XE
         cyZXuBDY/u95RLI7l0nlspYt0nAbJc2D9K6WADwrA+aJUxet6wYpHnX8ZZnVdsaBuKEW
         0HTsNIAdhlszHdeYcEdCb4xHA9D3yQEYW2W8auRcwu10o73QziyGdOg9C1vg9ijkAsFQ
         AF0q7paCTKLRQaBames87pasiTp91Wqonwh9DdlBAUPCKRdKvkyAMJATMhwjGOx9yMxD
         Ujrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776672585; x=1777277385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Oby7Bx0gK5ynnasEbalEDWMKwfDNOligTGO8x/b0ik=;
        b=gRWduUQg96VobcTkwI/x7t/xd8INJ1k+DNN7vHnMPaLiJUOx6WQw3eJlFsTY1ni9v/
         n6WXNkxCTwBbJ/N0UOvq4MffNbjA++YviC3WpIbLrvAzCFn6TmrNY3D1dgWbG11WjYg0
         tKCPsgZsA5GC3wdohvsPg02Y2gn951CFFWH62XPTONZItpA4U7W753AFKZgYbch7cxD3
         m3XJ38o63PkSgE+5O2ieNbvnfsO8FoWL6O/GAPolDLSgds53AYGtjzEDB24h8y86MuIv
         TpQTGZA+AQU7n2bRaZ1nZyb+UiV4M6VCzGvtPpLveol/APRcjjSxxbQGeiLt4hae8Z/L
         B3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776672585; x=1777277385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Oby7Bx0gK5ynnasEbalEDWMKwfDNOligTGO8x/b0ik=;
        b=VhvkPYUFXQuO0amXVsuTecZz+pSsoxcwYsoaO7jizyGM8qcY5zclBUYK1W/xZR5KFI
         E8UQiLMbMjpxqEN5XLbHhy3pcF7GLIhF3U2veiQziLvvf71+bAydPsbN3oy3BenMX/9R
         BfmBv2pg5aK4uL8gXwR5u7pU9hF0Pj1OCpy7xOJ8HQFl4Hf0h8MbP+T02zVWtoHX/6ns
         FI8MB7onE5i4tx3XyJKt/2fG/WFyL9t6IQ5EpWaBmhIoaddxJlLyGGfycWgRC4edxJYU
         iNccRmyIjJnieGL6PlHIzg4zzfIm/Bz/2YZIDcDpzl5S2RWdiDnEMdJwMK+4Hl4fii61
         rLUg==
X-Forwarded-Encrypted: i=1; AFNElJ/Nk9HwmihNqZEOV1vLaJ5l7Zse105WVlOReKBDTJF7bAUo7CbzcBXBUe2vgstQ3QcAfFGB/sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfPrrnn2GApLEiM33yO8cbMb0r451RWlzJYply1aoDKI6eC0aX
	QR0mvW7+mNSeRLlUBInofkeK3pgOiRQAyibaLmq0EE1Lg49Co5G2QAu522BXsDot0yu+uzC40Sn
	hcJg20M4IdtOa9NbamcAJK3XrthiHtXDG4Q==
X-Gm-Gg: AeBDies8v7et4O/YmS+X/Xvo5UrfFXbed1pKvPvIG0M3gJzu0EPxl4ylqKyLPMQuq7v
	iBePEB43KXX1jmuetsBUboDBhW3eDS0MC8Jx6R3zFnrkftJzG968JZ4MWVWxS9A6xnu27Cs1i8E
	yH/c0mbneJe+p0sHqJma93Evi2AkmBuYZEG9sZ6gHCA1EuDTYNA8/0RubamRdl+Y/3TCoJsMu/G
	bhUo3ak3TIMdbznXHAAsfyIifAqFro2Y4OzVyu8UuD1s0EI/JspwXTctdNtL4rY5cwwGEzZuGQR
	Irw4MzewxjxR2b1s
X-Received: by 2002:a05:651c:1b97:b0:38e:9eb1:6949 with SMTP id
 38308e7fff4ca-38ec7a4340cmr38995391fa.14.1776672584503; Mon, 20 Apr 2026
 01:09:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0f9e9d4e-8083-4297-91d3-10d0f614c87c@redhat.com>
 <20260408125333.38489-1-xiaoguai0992@gmail.com> <20260412135743.GK469338@kernel.org>
 <255224dc-0a55-4a0c-95f3-b84d4c6b3897@redhat.com> <20260414112951.GD469338@kernel.org>
In-Reply-To: <20260414112951.GD469338@kernel.org>
From: Kangzheng Gu <xiaoguai0992@gmail.com>
Date: Mon, 20 Apr 2026 16:09:31 +0800
X-Gm-Features: AQROBzCGapSVEfgxkUaxukutheG4b1zMtlvabc9F8b6CSvfsjnb81jK3l8njad4
Message-ID: <CAKvcANPEa91paujTQjpW2hZhpXEhwfOjjy6CsN=OJ32iXYXdTA@mail.gmail.com>
Subject: Re: [PATCH v5] net: caif: fix stack out-of-bounds write in cfctrl_link_setup()
To: Simon Horman <horms@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, kees@kernel.org, thorsten.blum@linux.dev, arnd@arndb.de, 
	sjur.brandeland@stericsson.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-238720-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiaoguai0992@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54FAC42805D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thanks for all of your advice, I am preparing a new version of patch now.

Simon Horman <horms@kernel.org> =E4=BA=8E2026=E5=B9=B44=E6=9C=8814=E6=97=A5=
=E5=91=A8=E4=BA=8C 19:29=E5=86=99=E9=81=93=EF=BC=9A
>
> On Mon, Apr 13, 2026 at 11:30:53AM +0200, Paolo Abeni wrote:
> > On 4/12/26 3:57 PM, Simon Horman wrote:
> > > I am wondering if it would be best to follow the pattern for
> > > writing linkparam.u.utility.name elsewhere in this function.
> > > That:
> > > 1. Uses a somewhat more succinct loop control structure
> > > 2. Silently truncates input without updating cmdrsp if overrun would =
occur
> > >
> > > Something like this (compile tested only!):
> > >
> > > diff --git a/net/caif/cfctrl.c b/net/caif/cfctrl.c
> > > index c6cc2bfed65d..ba184c11386e 100644
> > > --- a/net/caif/cfctrl.c
> > > +++ b/net/caif/cfctrl.c
> > > @@ -15,6 +15,7 @@
> > >  #include <net/caif/cfctrl.h>
> > >
> > >  #define container_obj(layr) container_of(layr, struct cfctrl, serv.l=
ayer)
> > > +#define RFM_VOLUME_LEN 20
> > >  #define UTILITY_NAME_LENGTH 16
> > >  #define CFPKT_CTRL_PKT_LEN 20
> > >
> > > @@ -414,10 +415,11 @@ static int cfctrl_link_setup(struct cfctrl *cfc=
trl, struct cfpkt *pkt, u8 cmdrsp
> > >              */
> > >             linkparam.u.rfm.connid =3D cfpkt_extr_head_u32(pkt);
> > >             cp =3D (u8 *) linkparam.u.rfm.volume;
> > > -           for (tmp =3D cfpkt_extr_head_u8(pkt);
> > > -                cfpkt_more(pkt) && tmp !=3D '\0';
> > > -                tmp =3D cfpkt_extr_head_u8(pkt))
> > > +           caif_assert(sizeof(linkparam.u.rfm.volume) >=3D RFM_VOLUM=
E_LEN);
> > > +           for(i =3D 0; i < RFM_VOLUME_LEN - 1 && cfpkt_more(pkt); i=
++) {
> > > +                   tmp =3D cfpkt_extr_head_u8(pkt);
> > >                     *cp++ =3D tmp;
> > > +           }
> > >             *cp =3D '\0';
> > >
> > >             if (CFCTRL_ERR_BIT & cmdrsp)
> >
> > I agree that the code suggested by Simon is clearer. Note that AFAICS i=
t
> > lacks an additional `tmp!=3D '\0'` check to break the loop, but even wi=
th
> > that added it should be preferable.
>
> Sorry, I left out the `tmp!=3D '\0' check.
> That was unintentional and I agree it should be there.

