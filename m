Return-Path: <stable+bounces-169915-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8E0B297A1
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 06:03:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46098168B1F
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 04:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCAA215798;
	Mon, 18 Aug 2025 04:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="kmFfgp1T"
X-Original-To: stable@vger.kernel.org
Received: from out.smtpout.orange.fr (out-74.smtpout.orange.fr [193.252.22.74])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314FA1581EE;
	Mon, 18 Aug 2025 04:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755489824; cv=none; b=O1ICo3sLG5/854HTQdKCtrvfA0Kiy7/YjbvHYb4l6ABoVvff/t5vzoBS6+bqSXtcXvprXWRmw0Aos77LL5NJYwpx8jl0htspsJ7n+2mKlOkSCDSbdrXbzrb0DDjoaUHXUbmFT+L6BERoWYLKNmCg0VVcREWFyddkYmV1OT1aEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755489824; c=relaxed/simple;
	bh=Y1gGnQORqmvXbgKRKxTHkiaFMB+fsoNDmG0x0pHOsRQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UdhCMu9h0H5Bs2Hkg6kQrPkJfdq232cGUd2M8VdJh7xMCpm4xyhBQHxFoDqh0b56/gDJmMAMizNTHdjW1Pfk5avdYdINu9KDBzdrEeNlnnFmeLrawg5Hcp64aHzM5K+as55oiZlzw7arYvS/0Y2n0phmgsCae+TY3W3mn9veZJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=kmFfgp1T; arc=none smtp.client-ip=193.252.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from mail-ej1-f44.google.com ([209.85.218.44])
	by smtp.orange.fr with ESMTPA
	id nqxAuAcKdbbh0nqxAuhdUI; Mon, 18 Aug 2025 05:54:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1755489276;
	bh=o+QzOdmBL0axfC9aNcrcNjUYXD8jt/EaKqTt5UNvrqw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To;
	b=kmFfgp1THH35h5Dzit26D53oYcjriIf0Nwnj9U1+sbfLzaSO0t3vYm28/UX7eGlO5
	 zC96a0wrhOOVzDEeTb7+Z0x+hn01vNHSb+mouy5qB1tP9bjrm59dZARJAMuF4xjAvi
	 kDu0iCGlFdks7cOI17Jy/Xni2b2P3T/Us5Cq2yOp3cj1IOzt+apA5pM0nJpW8aIi8C
	 2RVFb02+h2YJZ+WPu3fRtqIUUGZuKXAXzyUqlEsDfw9p4jhrohXJT++zck2WHlxXkx
	 6y7hXUv0c/L3zRqZbQeBnaRPou77R/EJEjJdZRxJekDaj1JaSiQQtsjAp/p0QF134d
	 ZqykObijt39yw==
X-ME-Helo: mail-ej1-f44.google.com
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Mon, 18 Aug 2025 05:54:36 +0200
X-ME-IP: 209.85.218.44
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb73394b4so559326866b.0;
        Sun, 17 Aug 2025 20:54:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YwzOikpnLfJTQj3mWdwti2sIPr0J+z23OAHvRqvdOB04P2/2EKu
	9w3JTU7e1VRolmwRj4zcabfokMIgkEWop5HhkAENy1v4gpfBsx8jPj0cknvep14O48KlhXW6emy
	Tp3gBx9dUYnWtCm/5h9SmxPIn7KYMZwc=
X-Google-Smtp-Source: AGHT+IGTGgx2xs0bT2Kbk+4BMNZCJcj78d5d9P3cIF/ky/B9M01/8WExkNd1UP9MP5KN63UOuYpbSObQ3HIgNdbrW0E=
X-Received: by 2002:a17:907:934c:b0:af5:a834:c327 with SMTP id
 a640c23a62f3a-afcdc085d1dmr952071866b.21.1755489276509; Sun, 17 Aug 2025
 20:54:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250817134901.2350637-1-sashal@kernel.org>
In-Reply-To: <20250817134901.2350637-1-sashal@kernel.org>
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Date: Mon, 18 Aug 2025 12:54:26 +0900
X-Gmail-Original-Message-ID: <CAMZ6RqKtpR3vikvm80h0Tv-SUCP4AU2gmMvn=F=SZMSB1UJTgA@mail.gmail.com>
X-Gm-Features: Ac12FXzqAcQwYki_kHhbiDY2AwAgX77eADux-vZk2X1hH-aaBzL8DQWQMprN370
Message-ID: <CAMZ6RqKtpR3vikvm80h0Tv-SUCP4AU2gmMvn=F=SZMSB1UJTgA@mail.gmail.com>
Subject: Re: Patch "can: ti_hecc: fix -Woverflow compiler warning" has been
 added to the 6.15-stable tree
To: stable@vger.kernel.org
Cc: stable-commits@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"

Hi Sasha,

On Sun. 17 Aug. 2025 at 22:49, Sasha Levin <sashal@kernel.org> wrote:
>
> This is a note to let you know that I've just added the patch titled
>
>     can: ti_hecc: fix -Woverflow compiler warning
>
> to the 6.15-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
>
> The filename of the patch is:
>      can-ti_hecc-fix-woverflow-compiler-warning.patch
> and it can be found in the queue-6.15 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This only silences a compiler warning. There are no actual bugs in the
original code. This is why I did not put the Fixes tag.

I am not against this being backported to stable but please note that
this depends on the new BIT_U32() macro which where recently added in
commit 5b572e8a9f3d ("bits: introduce fixed-type BIT_U*()")
Link: https://git.kernel.org/torvalds/c/5b572e8a9f3d

So, unless you also backport the above patch, this will not compile.

The options are:

  1. drop this patch (i.e. keep that benin -Woverflow in stable)
  2. backport the new BIT_U*() macros and keep the patch as-is
  3. modify the patch as below:

       mbx_mask = ~(u32)BIT(HECC_RX_LAST_MBOX);

I'll let you decide what you prefer. That comment also applies to the
other backports of that patch except for the 6.16.x branch which
already has the BIT_U*() macros.


Yours sincerely,
Vincent Mailhol

> commit f37dbcbbea3844900081b44f372f2f4d4be1b5c6
> Author: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
> Date:   Tue Jul 15 20:28:11 2025 +0900
>
>     can: ti_hecc: fix -Woverflow compiler warning
>
>     [ Upstream commit 7cae4d04717b002cffe41169da3f239c845a0723 ]
>
>     Fix below default (W=0) warning:
>
>       drivers/net/can/ti_hecc.c: In function 'ti_hecc_start':
>       drivers/net/can/ti_hecc.c:386:20: warning: conversion from 'long unsigned int' to 'u32' {aka 'unsigned int'} changes value from '18446744073709551599' to '4294967279' [-Woverflow]
>         386 |         mbx_mask = ~BIT(HECC_RX_LAST_MBOX);
>             |                    ^
>
>     Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
>     Link: https://patch.msgid.link/20250715-can-compile-test-v2-1-f7fd566db86f@wanadoo.fr
>     Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>     Signed-off-by: Sasha Levin <sashal@kernel.org>
>
> diff --git a/drivers/net/can/ti_hecc.c b/drivers/net/can/ti_hecc.c
> index 644e8b8eb91e..e6d6661a908a 100644
> --- a/drivers/net/can/ti_hecc.c
> +++ b/drivers/net/can/ti_hecc.c
> @@ -383,7 +383,7 @@ static void ti_hecc_start(struct net_device *ndev)
>          * overflows instead of the hardware silently dropping the
>          * messages.
>          */
> -       mbx_mask = ~BIT(HECC_RX_LAST_MBOX);
> +       mbx_mask = ~BIT_U32(HECC_RX_LAST_MBOX);
>         hecc_write(priv, HECC_CANOPC, mbx_mask);
>
>         /* Enable interrupts */

