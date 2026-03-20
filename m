Return-Path: <stable+bounces-227407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLy6DuuevGke1gIAu9opvQ
	(envelope-from <stable+bounces-227407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 02:12:11 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9805D2D4988
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 02:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BF8330B4792
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 01:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C58D27FD49;
	Fri, 20 Mar 2026 01:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mZbvpb7m"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46061A6809
	for <stable@vger.kernel.org>; Fri, 20 Mar 2026 01:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773969123; cv=pass; b=kbeDwBiL6Tgf23ik4NmHyoVX+3c79J8rrtitBWULFmuTPt0ar950W5Lbk5XEykokuozf2UWNubqScJfpfe6EerUiij29TND8nWwLaMVer6NLL1nP849Voy9BDLuQfZB2+j0sr/aCr1YPik8AueldmvXs9VR/CLvhc/HqBeHi6t0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773969123; c=relaxed/simple;
	bh=nzszZFUGC5eoe6b65OiyPCgDvur5T6niG6Xz4kQ9bFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YGB7RKXnGTbS4ijeglqgHYyMXq1czudrtpIpjJKJ5QdncaCiIox8/vxMqkUmzjyJGlivsEn4i0xPJpYr1PiCRX9u47dS7Ier0SuMyhePoCPOTtmvAcebBXf1h9uIwVES40j8s6fFyD2ScBKvO0GZ69A94rPOMAYqsp2Yl/v1OsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mZbvpb7m; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-485410a0a8aso622725e9.2
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 18:12:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773969120; cv=none;
        d=google.com; s=arc-20240605;
        b=XAfn+97ta/z20QljDZzo5Bbki/7Q7+40Kh/SObiRImjc81yFg4bvs9f1d4IlSnydb5
         OM69dVpZKRSxKoS+19dx3pu13MpVgRxoxjpPb1n5pQF9sl7yWw9Pu5kisUGWqQFgoQOA
         E9fai9qaGmwSA+ZQNFwUEub0+iZpCphY50iFY3IFsL1bfsXTMEQf53/HTD+45b0SgE2o
         2ehhqRZp2eEInt94jVkIFnBFSwEV5cV5CC2N4uVNsfOHtDtEnzDaV1cvZF6axcF8BqNc
         84GVM2pej0oRxid2Vb4xR1IR7Cw16mLNaAgTf6qa+XIejAtZa30E2pYl57f+Z6nFhUlo
         UrvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ayGFwySZHs4z9NIt8eLhyZLQX64EBLltnUs8BhPc48Y=;
        fh=j71COMKEhVKPccshRMlqWO/x5nlyC//noY/T41PLjlg=;
        b=WC3F1dtoVbBJmuNLsun/uEX3/gGuZA2XX8n7hAKoTTyj4+zzTpLDsBSfXpb4KPmWOz
         g40mxJnCwuaWGWhb2HSkSQxcQnR4UDmYp8jV39UPqGfC2aAF3DWJ2q7DIyDTYZLqXlcG
         fQAJyO4mnkCaRC3cHrCdAR1hQv7nLeqNpnQdssQbgZYuOdUq5iaaaEYpIHlNfLMHdD2Y
         wMtAlO21aMdxrvTc6TZ9nSMPM/LFRCHwMxm4jMsk6V1xrNNJxWKD3xWD9q+ILTya21KA
         Xw5F71zKKi63SW1QaAldoC/M7DeDrRrdTPG/N5soZyfw4hw30NNGmHH7NG7J0E74geDz
         PlHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773969120; x=1774573920; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ayGFwySZHs4z9NIt8eLhyZLQX64EBLltnUs8BhPc48Y=;
        b=mZbvpb7mnU8Ar3hRC87vmrktAG7veVIkyG3LmP5JfPA3mxwIjBOnxWg1+XpXYQ9qlM
         MPWPFggPlOx1B09BFOttnQK6DwWqFfoPKAxIbRoB4LTj7oGemszAZRww/YR5p1+exDOo
         O5c99FDkTAPmpwBEoX8qkC/LDoZ4LNX6OhDQSMAYzgPkPJuaJjT30r4GuEvXdRK5b58C
         Gs9d/iFvxBcT5IziQ8O6xrc8UAwRPS2lC7UPqraDBudNVUpN31aVJ3K0u9WQBvboNRga
         DxlenQFSunqef8zo/TAFzgSbE34zgOaMvn9wXKmebtTP8mh7v0/kFnjQwOwKWOJKCeWO
         bU/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773969120; x=1774573920;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ayGFwySZHs4z9NIt8eLhyZLQX64EBLltnUs8BhPc48Y=;
        b=j6S596L6iqUsP2sdTZBuG9762F6ySOplqxWkpWMYHOj8XAv1vV9o0/4+1W6ystI83t
         B+MuvPeWwAZP8+ncH6v9iElrZBJgNoc5TpqcvQ6bBscZpPA4vsv4nXSprlLU8A5k/+WY
         H5meJtGnr50y7cAjXBVuzBTixg5fkCnqGVU65rhNqnVmohJg9G/cGNp4eO2ZHFW/JiDJ
         kf6hwySviW3HzKTLr75oXtjYI4/bvr7sMjTUkmCyq1IjmZJ6B6zucgkzzHvtrYNhJGPG
         AhtAnIJYaFYTAbJwD6PPCLyVk2L2HY9ValeklN8R1jKJCJ9/18VEJicaXqhB3rJReNj9
         PHdg==
X-Forwarded-Encrypted: i=1; AJvYcCVnXPmCyXA5IlGc5369h4TBIwFp1ygenCp0grzGZuem9d31HD05YBL29ROhFQ6WuejRgbwM8wc=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywb37mjhsGWjI2ospCTDUY6/1VKJr0MnFQkhDwTqevAY+fzcqF6
	/2iwnrtTh7QoTOn7uaS+zAyUDjwnmsrVFjzlzTPn1YUDgc71ErgG2hpDqmB0Ds28LLKyGpnnsYo
	c68jai4PAehQCP25Si5reLaVZsLQG9ig=
X-Gm-Gg: ATEYQzzKB7r8cctm50a6YKgsLB9Rck2wvBXiAzQuY9n5Dk0n2GlX3MAYtf+PhxpT3sD
	J4EQm4o3l1bryP4W8Q/WvttECF8P3r6k5MY01eyqPZFdCdDc2Rjw34qD+uTunq9J3bhKpttnmOs
	YgVYIIC5e0QwrYcE/ZBTIWlCU7cDmlXZYPeRcTNfBhH9QRhhwCIb4ZUZjoX59bQmQgLwocmp3yO
	ufA0JC0pCPNEwIiBdUuBqkUpUJOw4RGc/EVS55NEysEQHhex2A43XqMgk5TLDg+pVmRN1vkgvRb
	AIu3WJTR9L/QTcFzKusqjoO7VknCkbNyrc3UAmvr
X-Received: by 2002:a05:600c:c167:b0:486:fc94:d8f2 with SMTP id
 5b1f17b1804b1-486fedbc066mr17394635e9.14.1773969119695; Thu, 19 Mar 2026
 18:11:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319184031.8596-1-CFSworks@gmail.com> <20260319184031.8596-2-CFSworks@gmail.com>
 <abxxyHVXp6QpPue5@shell.armlinux.org.uk>
In-Reply-To: <abxxyHVXp6QpPue5@shell.armlinux.org.uk>
From: Sam Edwards <cfsworks@gmail.com>
Date: Thu, 19 Mar 2026 18:11:47 -0700
X-Gm-Features: AaiRm50mRwjPccV1Lpd9XuZSBHTAzYDUmTRqARu72YFqm9lh9utWbuv6pvfVHYE
Message-ID: <CAH5Ym4htit49autJb8E=eatof23YK3qomVBCsXZi2cFR6CyViQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: stmmac: Prevent NULL deref when RX memory exhausted
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Baruch Siach <baruch@tkos.co.il>, Serge Semin <fancer.lancer@gmail.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227407-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.456];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,armlinux.org.uk:email]
X-Rspamd-Queue-Id: 9805D2D4988
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 19, 2026 at 2:59=E2=80=AFPM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:

Hi Russell,

> Isn't the limit equivalent to:
>
>         space =3D CIRC_SPACE(rx_q->cur_rx, rx_q->dirty_rx,
>                            priv->dma_conf.dma_rx_size);
>         limit =3D min_t(unsigned int, space, limit);
>

I had to think about the edge cases for a few minutes -- yes, you're
right. However...

> (Think of the "full" and "empty" cases as "space" which can be
> consumed to provide entries for the refiller to action.)

...this seems like a double negative: We're looking at the ring from
the refiller's perspective (i.e. considering "dirty" the meaningful
state), and *then* looking at the "unused space" (i.e. "not dirty").
If I used it, I'd at least add a comment explaining that CIRC_SPACE
is, counterintuitively, not measuring "space."

After the bugs are fixed, I'll follow up with a net-next patch [1]
that removes the `min` altogether and makes the loop check for 'dirty'
directly, so my focus here is "minimal, obviously correct" and not
necessarily "tidiest." Would it be acceptable if I simplify
stmmac_rx_dirty() to use CIRC_CNT() then, instead of using
CIRC_SPACE() now?

> I think the same applies for patch 2 - when the above returns zero
> it means we have no entries in the ring that aren't due for refill.

I'm not completely satisfied with the `stmmac_rx_dirty() =3D=3D
dma_rx_size - 1` expression either. One might argue we should keep
trying until dirty=3D=3D0, because tolerating *any* dirtiness risks not
having enough buffers for the next traffic burst, causing avoidable rx
drops. But that's a discussion for patch 2. :)

> Have you checked whether stmmac_rx_zc() also buggy in this respect?

I skimmed it. I saw that it checks the return status of
stmmac_rx_refill_zc() and on failure, returns the NAPI budget to keep
polling -- which told me that the ZC author(s) at least considered
these problems.

Looking at it more thoroughly now, there are a few code smells around
the unconditional `dirty =3D 0;`, and `dirty` being used as the "budget"
for stmmac_rx_refill_zc() (why have a budget at all then?) so it looks
like something's there, but it's a separate bug if so.

Best,
Sam

[1] https://lore.kernel.org/netdev/20260316021009.262358-4-CFSworks@gmail.c=
om/

