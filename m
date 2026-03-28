Return-Path: <stable+bounces-230794-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGlTOpv1x2lMfQUAu9opvQ
	(envelope-from <stable+bounces-230794-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 16:36:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4713D34EEF5
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 16:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F133F3050A0D
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 15:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 211F13314A1;
	Sat, 28 Mar 2026 15:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZJjk/XBN"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702D62F744F
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 15:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774712062; cv=pass; b=UzJ7tCaPrV5SgLBDow8OkhgzD5vH8Ve/1Qz9qSMVDBNocIDDyr++kEIHVzKUiuuWJHdeq/Nq+S7uVch1gGCxHv3hTxZAhwSCXYe00XGoaruG6cBgQfTU8ekBMLuLHfh2RiDjQ4FfwJyjsIUf9bF5UjKLC78+3ObU/P6AtaSohJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774712062; c=relaxed/simple;
	bh=y6n/CqLfd38hQW6svuKj6rGCU5+wiH4QrowOutXhZbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HAxt0St/OLjy6+uiE/cXTgxMhFeFVA3+YHzVe6fbVyoNkHU/K28wa0b7ONZiLhtuPud+zfKTD80ZV2TPCZpAEGVAT82cZq3ZxuQuSLrudlh6qkouwbhfzNGGzZ09HhcyjRta2FazbdSl+WReFVN38mCWSYwZqnU7eIiQdSO3vwc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZJjk/XBN; arc=pass smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-38a32d36396so27662281fa.0
        for <stable@vger.kernel.org>; Sat, 28 Mar 2026 08:34:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774712060; cv=none;
        d=google.com; s=arc-20240605;
        b=WKZCrODWnuP3x8WK5/ca38oJ1U/DqcmvfuUE4kxT2UC0/yDyCI2nYFRA5/1qu76K6L
         boiH7HnAo7+bx0lsBL1Ddr7xyrb5yvaA6ZrSJc4IXCr5a/vtFyg+F+4UPZRT2GaXxSVF
         dEZuKGVBw7SgEdQRVEesM+lYdtB7yyNVA2EzUea3jCngpEzux3gKJVoYHIYPA9R/B7ku
         cjQOWXGm0Zw3kvNV7/wvm+nHxXZWwZJCZ4HP5rkO+KPEMkb9P8DWTc0Pj+rPhvDuGn9B
         qSIVH1YlPtgBAp5nJ8hTeYRYRZUjQBro6arMimAszN4Nn/1/hH+DNK/VeQlWoyJetquT
         kSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=haMXa5Y39fYyaZPwYN+n8TJLxpZQGLuvRxS6HRz+Zto=;
        fh=q739Rq4LExd3hzE24sK/DHUxJ2rH6tr0n46ftYZxu+k=;
        b=kLHbVbAbjjaMQQKHk1NJMtBglxW70108kCXcuiEN9obSADvfHbEim6OzK9pUkaqhN1
         Oc/CQ2LD9QJGyd0rj/D9TskSIbQewRiCgzCsInpvNXvEme5kPiZwTY3iuu30R9ZjsxUq
         ut+iZWfg0u25YiZ01X74rbTuCRWPX6g1fiTgXflXS8dJItXdWxP71q17LJ9G6oiQRAAL
         l3U+RasBvZwENz1k7+3WMnGF14i3TX3Anf1uJ/9j3PkdKvdUopcSKxYvTuJvRNuJIygG
         6vfulU7LqwYt7k62GqC9mQf1tIOopSRU9cpAI3FYVRwU65WBqnrULZKNtK8W6g7YSz0J
         D/7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774712060; x=1775316860; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haMXa5Y39fYyaZPwYN+n8TJLxpZQGLuvRxS6HRz+Zto=;
        b=ZJjk/XBNT/8g9gFIMntauIAXfCRVHH+oIVNsTk70KD9Ro8Ndy390NoSxa9Nx+jCJGN
         pJtJcK/CPwFQyXi7bMuv5xjPWo8v1sr0eb+TovCsrLSQdmaNXvCR3N00/urY5QITeLzV
         HK/T0QIAghau2qgQH2FcTp0JdTFny8C3w6HcJrY5B5gbZm2O6iCinae7YjLjLxTsxQ41
         954ct/3dJzYUd8Q4DJ/nFrzl4rFCHpX3DnXqr6jGtOT3sPSdhCOiDmF6zuW+rOyBqxQl
         8Gj2xWLPJMcyGSKQw+j19rESVIKG10V3koZ3fEH4o6MK7qAqXi56o9OMPloxoZqo/37c
         2/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774712060; x=1775316860;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=haMXa5Y39fYyaZPwYN+n8TJLxpZQGLuvRxS6HRz+Zto=;
        b=U2fsgd1BvjSlwJTRvIzXUA9uBUjPXE+hssS0zzknCNaNFvSOhLHvj2RJGh5JxOk51S
         EDPbxH4elbVEBOurMB03zbYht4Ux6mkUrNTjy++0yBTJoHtd0UsthWRjweCbFmQlTs4B
         W/JN1eTHxY1Bj761OhVk58wuU+Fgy7SjdbVlxYZ/dw4uWoMD0XnDYEiFLy7RzA3LYk12
         tFz7vridawyk7f6xXUvmeTBgquqWpObDdJTwCc0tuohMUgUxQcxpWme/O6R1R4gkdv6P
         6hoG5ST5nTG4+7/aF2aHPpnbnMU/P7FlTEl0ypuRa+cgFfZqWF9l7I0tuxDp3jytV8Os
         iiCg==
X-Forwarded-Encrypted: i=1; AJvYcCUEpBAgem5AGcKc6krEofJjRmGs6la8PlMJfS2qP1PEhtmYep0KwjNA1Hk5WqhQloOP53QD8fk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzveRbDtPQa9HkoGX3VLKOMObFZcDVvD5vHD3ZS8nH1YP9gAiaF
	LcT90DmP/CS+wNkuFC25qSAMCxGuqOxS1ATtWtDyVOjTKDPmNizYurDuWXJoXjYHZvBk6S1ha6d
	LDYl2V7DE/XHtQHpOw89zpzQmMvSolKzZoJ1qJY0=
X-Gm-Gg: ATEYQzwE2Am4kQE2tAlQDZiFAibrjJsCEEb3eR73yPzZRovFMyhOWAsKGsJqWcaydPp
	J+mc+ktfXaHBBeO+zXygHISAbE2oMUTDMEFoQkfzcCWK8smDC0anIXBjgCOyQQQX27Ubc65YQJd
	izXSSVGLDl4plua2uJev48Yi4IPhpJ4XmZ+7D9krsuVVnnm6Yud4B7FOHP/YvAjQ55+exyKAPvG
	06BU4zD8aJnuwdvPNGVlp5HBFIPo4EnCJ0t365N1xcin9Esj9lIuRH7kv2YQd+3nX78Q4Sxd2cE
	wXCqYjNtwDVp3Y/FIm7aDDLatKZAL+LQdIE1wIzmYuaZ4IBn/ptHA1yRqwBMX6KPkm8NhQ==
X-Received: by 2002:a5d:5f84:0:b0:43c:edaa:f5e7 with SMTP id
 ffacd0b85a97d-43cedaaf6b1mr4522070f8f.14.1774702587577; Sat, 28 Mar 2026
 05:56:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260327-b4-cru-rework-v1-0-3b7d0430f538@ideasonboard.com>
 <CA+V-a8tGfAzMdFgY7U+pLitDXbnj3xD8-RzXjbkOQ-iH4mtkug@mail.gmail.com> <acfBaMdKDThNhfcX@zed>
In-Reply-To: <acfBaMdKDThNhfcX@zed>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Sat, 28 Mar 2026 12:56:01 +0000
X-Gm-Features: AQROBzDQxXJq9DcMQqTPEu_ZQIpk00QlISExPIMUG9fDeLEmqKbhf2mBTMgDkrQ
Message-ID: <CA+V-a8s67j2kFO6moUjKdEBL9uC0s+dm_GxBJetMHPCPDSPppw@mail.gmail.com>
Subject: Re: [PATCH 00/14] media: rzg2l-cru: Rework slot programming for V2H/G3E
To: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
	Biju Das <biju.das.jz@bp.renesas.com>, Hans Verkuil <hverkuil+cisco@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, 
	Daniel Scally <dan.scally@ideasonboard.com>, =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Jacopo Mondi <jacopo.mondi+renesas@ideasonboard.com>, 
	Daniel Scally <dan.scally+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230794-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,ideasonboard.com,bp.renesas.com,linux.intel.com,protonmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[prabhakarcsengg@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,renesas,cisco];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ideasonboard.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4713D34EEF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jacopo,

On Sat, Mar 28, 2026 at 11:55=E2=80=AFAM Jacopo Mondi
<jacopo.mondi@ideasonboard.com> wrote:
>
> Hi Prabhakar
>
> On Fri, Mar 27, 2026 at 05:25:30PM +0000, Lad, Prabhakar wrote:
> > Hi Jacopo,
> >
> > Thank you for the patches.
> >
> > On Fri, Mar 27, 2026 at 5:19=E2=80=AFPM Jacopo Mondi
> > <jacopo.mondi@ideasonboard.com> wrote:
> > >
> > > This patch series starts by collecting a patch sent from Dan in the p=
ast
> > > which improves the HW slot programming on V2H(P) to avoid losing fram=
es
> > > under heavy system load conditions.
> > >
> > > Tommaso also sent a series a few months ago for the CRU from which I
> > > collected the first two patches.
> > >
> > > Around it, I've reworked a bit the locking in the driver which is a b=
it
> > > coarse and causes lost of frames under heavy system load conditions.
> > >
> > > Along with these, bit of drive-by cometic changes here and there to
> > > modernize the driver code.
> > >
> > > I've tested on V2H(P) but I've also modified the G2L IRQ handler, so =
if
> > > anyone could test on G2L and G3E it would be great!
> > >
> > > Signed-off-by: Jacopo Mondi <jacopo.mondi@ideasonboard.com>
> > > ---
> > > Daniel Scally (1):
> > >       media: rzg2l-cru: Rework rzg2l_cru_fill_hw_slot()
> > >
> > > Jacopo Mondi (11):
> > >       media: rzg2l-cru: Modernize spin_lock usage with cleanup.h
> > >       media: rzg2l-cru: Use proper guard() in irq handler
> > >       media: rzg2l-cru: Remove locking from start/stop routines
> > >       media: rzg2l-cru: Do not use irqsave when not needed
> > >       media: rzg2l-cru: Remove wrong locking comment
> > >       media: rz2gl-cru: Introduce a spinlock for hw operations
> > >       media: rzg2l-cru: Split hw locking from buffers
> > >       media: rzg2l-cru: Manually track active slot number
> > You beat me to it, I had a similar patch internally.
>
> Oh that's great, I wasn't sure how this was going to be received!
>
> >
> > >       media: rz2gl-cru: Return pending buffers in order
> > >       media: rzg2l-cru: Remove the 'state' variable
> > >       media: rzg2l-cru: Simplify irq return value handling
> > >
> > > Tommaso Merciai (2):
> > >       media: rzg2l-cru: Skip ICnMC configuration when ICnSVC is used
> > >       media: rzg2l-cru: Use only frame end interrupts
> > >
> > >  .../platform/renesas/rzg2l-cru/rzg2l-cru-regs.h    |   2 +
> > >  .../media/platform/renesas/rzg2l-cru/rzg2l-cru.h   |  28 +-
> > >  .../media/platform/renesas/rzg2l-cru/rzg2l-video.c | 328 ++++++++---=
----------
> > >  3 files changed, 140 insertions(+), 218 deletions(-)
> >
> > I'll test these patches with ISP enabled next week.
>
> My testing platform is v2h with the ISP, if you have a G2L could you
> maybe give it a spin there as I don't have any board with that SoC ?
>
Sure I will.

Cheers,
Prabhakar

