Return-Path: <stable+bounces-241704-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kIvKABba8GkLaQEAu9opvQ
	(envelope-from <stable+bounces-241704-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:02:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E094D48869F
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 18:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92EEF306E653
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 15:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3833C6600;
	Tue, 28 Apr 2026 15:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wd+ef47q"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A7F3C13FC
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 15:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391813; cv=none; b=jKu5t/2+StibM7erviWai5aqixvYxRm6secLlpuDET01K1oFDzMRGD06rr3m4LeeSzrGqUhM/qnqG+QZ+T3xKe3mYhZhWxRRiZQ1e0n4YkVyQBQJ6wP39el56VN46R/aPyi8vpsOsdsugYa5oeL5P+GycQL5/615JMPhTDdwS/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391813; c=relaxed/simple;
	bh=WLFz0+fL7Igaq1YF4c4WzQUXnbnHd0d5tSqwHAt7wNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/unkv4iVp2KgDT8eUucsCWBXq3T0r8qJNjYYDIOxQmxzxjI1+wGsmyoFRLBHhEmHHwZteq1+LcGMN55mEoG1zjx5boYNngHUzoyxNVBOSxnh+5Zi57TUV2BTp8CiEFmfhLXMunDMc2dZtuLLdgDchY41HK+tISUhThZlAumwj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wd+ef47q; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-678adefbd26so7040690a12.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1777391808; x=1777996608; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLFz0+fL7Igaq1YF4c4WzQUXnbnHd0d5tSqwHAt7wNQ=;
        b=Wd+ef47qy7GG+k934RGkoAoCY/z5Fl1y2SgGy1zEJKdfY9QcaksPit0LbPVtBB0Bcz
         mP++hgVc2z78jHPbOvRz6pZWr2VZZV9HUZ5kGKzM6AN6w2zCqmuxI9O4QomaK8o6uebA
         s1Rykf8KwIehZ7/9YTBdTjyHElIAK6GBVnE3E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777391808; x=1777996608;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WLFz0+fL7Igaq1YF4c4WzQUXnbnHd0d5tSqwHAt7wNQ=;
        b=DzT4oJ4w2ZjN/9GzoNHGw99nsYdo3ONlak+HZzGsPiHB4o4fmgaxIWyLQ8lhn5LM5x
         Ej1hj3Ir4uq5WDWKgDkdYhfqqBih21KLOM3jDeDLu9Hw/0zwVyS/mDDHWZliczcxKqMC
         9S10EAhOyhm9AbYfPBf+6TFSUvvlirl7euwoyO4EYcRBIZvXh5EFtzq8wdOU/iCC9jb0
         pysvUkWM8Vgl7rTVMKasSt4SCbJj0Hg79BpomnaekMt0BvEPYplsJfswNiDRaMp6e1UH
         /7z/yJBuXg2oC1qEaxLO6jxkA82xKmc3SWpeFH0T5YcM6rBe5MyCSni4a1epp7YSb23W
         D4lQ==
X-Forwarded-Encrypted: i=1; AFNElJ9UgBVVCcKf0F2Kdmb7411Df/4l7Y+aDm1B8i6t7rasr6nJDqN+ov/1EolQMynr0088G9gYnwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpF0w77KpmfvVE5POdvP6uBLWasSQumtq+l2imyKIb4Gfzhumi
	kESPe7UioRcsJ4ZZdBZ687ifP4/rW7oXGty0MW0EYuydM3Rd7jqKNkyYKAQXyE0p1BYv/jwU9iv
	rpYsPogtm
X-Gm-Gg: AeBDies6geatfMxwdrUfYToI2ncHWdWoJ/LcvHfcDtc6a3p/EuFj0AbrgrmXngZmYe2
	KieULEYrlL63mLDZc0KYMPFk7DUzGMHIXigsKsG+cD/HOLPecN1yz0O1f2aTBg4MaKsVBDFg/xm
	WUh3yx4VvamoZLn9ZgRFCdJ4ODfPv76nea4956hmax/pjscpUokqjy04EibbW05VhaLzXvP7Ucb
	MW3N8WF9olXWTLi5Hy73A0nOyE4IO+y8wcofV9zDWXLTOazhBf7toEOwo5f233WHSr3mZAJmpfx
	OXj5pW1vYdFityMiTz/rdsGNsflf+76vaCCX6JSjQFF76ik4XiXfx2oRmEfgF8BpDtgqESnd3a1
	wFDjS7Gf9iI27UtKr/kV4X4KscPX8Wc9S4J8wk7WHFRXFVLNpf/6Z7YILSKnsCk79GvKDgw+V/f
	8zkTo6SGmp9aRu60PDpaOZnpi5FmuyVRQzk/rZRD7bHT192YnuymXi9vPNdshg12B9dOSliZKq
X-Received: by 2002:a17:907:c007:b0:baf:3fa:5b4d with SMTP id a640c23a62f3a-bb8020c955cmr245878166b.9.1777391808298;
        Tue, 28 Apr 2026 08:56:48 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bb80853e641sm123420866b.10.2026.04.28.08.56.47
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2026 08:56:47 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4891c0620bcso80116645e9.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:56:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/7dPdVme6ecZu27X6Nzwj1vsJWqbHArXIwSBYktXYX7Lh7C4ixEKPivoVvCJSE1LbvCEHHk1Y=@vger.kernel.org
X-Received: by 2002:a05:600c:3b13:b0:48a:525b:e148 with SMTP id
 5b1f17b1804b1-48a77ae03e7mr53600045e9.4.1777391806260; Tue, 28 Apr 2026
 08:56:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260425165751.1716569-1-zhengxingda@iscas.ac.cn>
 <CAD=FV=VXD34ZZTH4MJUtZ6xifbbjp1cLRBd_xvz=3T12G4tKYw@mail.gmail.com>
 <d9faab05aab120fee367394edcb35bd131c97646.camel@iscas.ac.cn>
 <CAD=FV=X-FUw_MqE2ufv=ngBS3ho4vg-QKokav+MeP7XAAjXUbg@mail.gmail.com> <151c1c1d52fce8c3b1dac3a919be3086ce3426df.camel@iscas.ac.cn>
In-Reply-To: <151c1c1d52fce8c3b1dac3a919be3086ce3426df.camel@iscas.ac.cn>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 28 Apr 2026 08:56:34 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XPAWEiN4EFvY0sA7uEBqxpc0iiD28Y9BmpguoerG1hpg@mail.gmail.com>
X-Gm-Features: AVHnY4IA2Dm1yshlPxhQkFms2fky9sEgdM6Do7-4YmOKn1Ubv2moq16Bw_HaZvg
Message-ID: <CAD=FV=XPAWEiN4EFvY0sA7uEBqxpc0iiD28Y9BmpguoerG1hpg@mail.gmail.com>
Subject: Re: [PATCH] drm/panel: himax-hx83102: restore MODE_LPM after sending
 disable cmds
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <jesszhan0024@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Cong Yang <yangcong5@huaqin.corp-partner.google.com>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E094D48869F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241704-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linaro.org,gmail.com,linux.intel.com,kernel.org,suse.de,huaqin.corp-partner.google.com,ffwll.ch,lists.freedesktop.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[chromium.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:dkim,mail.gmail.com:mid,iscas.ac.cn:email]

Hi,

On Tue, Apr 28, 2026 at 8:53=E2=80=AFAM Icenowy Zheng <zhengxingda@iscas.ac=
.cn> wrote:
>
> =E5=9C=A8 2026-04-28=E4=BA=8C=E7=9A=84 08:48 -0700=EF=BC=8CDoug Anderson=
=E5=86=99=E9=81=93=EF=BC=9A
> > Hi,
> >
> > On Mon, Apr 27, 2026 at 10:49=E2=80=AFPM Icenowy Zheng
> > <zhengxingda@iscas.ac.cn> wrote:
> > >
> > > =E5=9C=A8 2026-04-27=E4=B8=80=E7=9A=84 11:24 -0700=EF=BC=8CDoug Ander=
son=E5=86=99=E9=81=93=EF=BC=9A
> > > > Hi,
> > > >
> > > > On Sat, Apr 25, 2026 at 9:58=E2=80=AFAM Icenowy Zheng
> > > > <zhengxingda@iscas.ac.cn> wrote:
> > > > >
> > > > > When preparing the panel, it seems that it always expects
> > > > > commands
> > > > > to be
> > > > > transferred in LP mode. However, the disable function removes
> > > > > the
> > > > > MIPI_DSI_MODE_LPM flag, and no other function re-adds it.
> > > > >
> > > > > As the unprepare function contains no DSI commands, re-adding
> > > > > the
> > > > > flag
> > > > > just after disabling the panel should be safe. Add the code re-
> > > > > adding
> > > > > the flag after the two commands for disabling the panel are
> > > > > sent.
> > > > >
> > > > > This fixes screen unblanking (after blanking once) on
> > > > > mt8188-geralt-ciri-sku1 device.
> > > > >
> > > > > Cc: stable@vger.kernel.org # 6.11+
> > > > > Fixes: 0ef94554dc40 ("drm/panel: himax-hx83102: Break out as
> > > > > separate driver")
> > > >
> > > > This "Fixes" looks wrong. The bug was still there even before the
> > > > driver was broken out. ...and it looks like the driver that this
> > > > was
> > > > broken out of (panel-boe-tv101wum-nl6.c) still has the same bug?
> > >
> > > Yes, but I think the fix shouldn't be propagated to the other
> > > driver
> > > because of the same reason with breaking out the original driver.
> >
> > ...but doesn't all the same logic apply to the other driver? Nothing
> > ever adds MIPI_DSI_MODE_LPM back in.
> >
> > Even if you don't fix the other driver yourself right now, the proper
> > "Fixes" tag is when the problem was introduced, not when the driver
> > forked out.
>
> I think the Fixes tag should point to where the driver is forked out,
> and if I'm going to send a patch for panel-boe-tv101wum-nl6, it will
> has a Fixes tag pointing to the further commit affecting that driver.

You're free to have your own opinion, but that doesn't match my
understanding of the Fixes tag. If you can convince Neil or some other
drm-misc committer to land your changes with the Fixes tag as you have
it, then I won't object, but I won't land it. Best of luck!

-Doug

