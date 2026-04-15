Return-Path: <stable+bounces-238176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAvWFKLQ32m4ZAAAu9opvQ
	(envelope-from <stable+bounces-238176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:53:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E75C406EDF
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 19:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07BC53022AB5
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 17:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8C43ED12C;
	Wed, 15 Apr 2026 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="keLEtq8c"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A405D3264C0
	for <stable@vger.kernel.org>; Wed, 15 Apr 2026 17:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776275611; cv=pass; b=WZjtoaBOwiSKRfJAlZ4ZPel+UlRdRXFVXYUKADzTSEjN5CR+61tenv1JuGu00Dyb20B0fdN70+rpHZleXDk44CP1+K/Zkp4ifzwcrC3fp8klye/HYqNRaqrUBff1lXC0oPl20tZ2C+9uhTieGaRWthds/3Ye7Iqesx/L22GBSEc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776275611; c=relaxed/simple;
	bh=F3dLbPszutyYqEbfKeX1nNL7G18PjJB7QbuhqCEdFpM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OLMwGx6Pdq81zAXC7QA4EBV84Bc8N9CVBYOSQODmfe8mOoCqoSzMQGlxpE4dvIVrXhdrG5YQ9WAQ9ne1dz/zoej7lUZBO4xSup9QiqfaUb5p/jdsOs8NBwXxjLDO4smd/OmJ/cjb3Ki/vGNQdfIQRnpwrmMoHKrjp/PiHqwM1Yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=keLEtq8c; arc=pass smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so63850405e9.2
        for <stable@vger.kernel.org>; Wed, 15 Apr 2026 10:53:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776275607; cv=none;
        d=google.com; s=arc-20240605;
        b=A70/P+UuAD4x6bRAPdqjG9N/iEE7tZ8OIJpmjiMlFlqHB0nlDy5sgdt5tuEE9fDpI6
         /WqL781Aexxn3G5lAw8qysrt5posCr9RH6BZREKxxUUux/mFuH/lJiaM07f0QmPPYdoS
         dqrJMkHeCk4aHzmagAr3XgQpc97btzvXYAaPJppc6UdxDsdcrDJ7casE26bTVJHKLtGe
         qWDIttzSARra6WgToSlSQepBP6Hc7e/zp4zu3sMVajS6XlF5dROGtE5QfB+gj+nXH2nq
         kSCX654q79B5EvErh5xhaGKRU57Pz64WYc8mlNozgIRYNhDrUxJ2lzvDkgnoXmgdSuuV
         F6XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vXTyVOg75691/SqrnwQ0Y7XVqOHRVyrJmHlOD7bYftw=;
        fh=eVaeK2OCRbKnfo0WqlT7BXFR4SpJYhOXGh9zOVtX02k=;
        b=QHR5O8fboXp9eN/6ZODgmJAMgFUdoPQMd4M1vUa19RVtlNC+XAw6++PgYWpqU+yvto
         Uhye1mIEX20ueDDtDM5mWZ1+euBQxHzVeP9Tabqxi5neWhJs0Nju5bB2x/2tuxPeaDNr
         Dt1lB3F8KuOiBu8G4heHo3pzf/AyFSlLcbzxDf4QqtMiBWzutbXajbCV2cGbBGhABsY0
         DobyDpDTIOwjLAiKcKKirptOFU1YROJ3nvHBqUcnZGiuJNTJ/uYME1dAf5+B9V+h93xk
         /2dBs4eXz7Ju94ad+drM4ll2RZZ49j7DQQYDrswj8sXZU1brTKeXscF3wI4wzy+Q8+CG
         KWHA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776275607; x=1776880407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXTyVOg75691/SqrnwQ0Y7XVqOHRVyrJmHlOD7bYftw=;
        b=keLEtq8cKNDrI1OenQnTJxsVjrhNmZrzEBbGQg/MiNExeOqyxKL3EAw4hSufEn6mBg
         2T/1dMYRe0JOmIKTour08V2/lljI51Q3pkGNkw6OLrXVjdEQnZ2+20jldu7bl5+OKJeo
         c1f0segxZ48fBi4Y7p9bZFHY4IdWqcoS9LT7Ax3r1LsrFIjxik/8rPwbamfwiWEuhLUp
         wBTOopxE4joUfMbaSww+nNhqf2JL8jXnAY5gJE3HXp0y3oQtOiWGUBIjJo/DoJ38TZ4Q
         wNF2WRvcVlV0yTpqfc3YLgTDs14iEtIQlMwY+w45O2wjKU0eGneh/b9QXmXT9havLsqf
         eLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776275607; x=1776880407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vXTyVOg75691/SqrnwQ0Y7XVqOHRVyrJmHlOD7bYftw=;
        b=k6PzrDwfeaQcwYrTQqwm2/2tjgZB+UDrJcw8mxcGOBDaUVNekngGPF+mCbmsvZ+SiI
         xKmT3dBB2zk33mYgaLLzPC8fei6qCDYXz3lem7w/XG70EX2jVJ7eC1sTpyrcxJa/HfsX
         Ut24EgfIgMn8ZJYez2VFv/bZmstGSdUvl5kUjYQHu21GBkYIdGNP15wH+DbUTPC6tUmu
         gSN62u75vcaakIXKRpDtLZb6UrjxUXR0J0Bnc8JbgYVcKNqy8gvBP4ejQ1DAqXpmXjXE
         IBmUcfqB9QEr6e0k44Si8AIrLa1SXkWSIRb83sA0bJ3wH2Woi2twQR2kTqYIf/Wc/YqU
         u1tg==
X-Forwarded-Encrypted: i=1; AFNElJ8mkIc6FfN4RD/4IwL3+t9wobCX1d6nLDiqIqdsMK1tok8K9vLmOXoMQpC2nwzb/V7nXTrlqcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YziLGwRwtt835OC5IPgXXfiuKs5XNAh9+n+/dksUt5csX9rBmNE
	9N0Xv660+9RQvnNFzkW2hlynezI0JoozrYvxKzbF3jiJHeI03t+TZjdEBPXVijbQSImVbcay6ut
	ygjxPBldd8DIA3Ch/NsUzrovCgQu8NsU=
X-Gm-Gg: AeBDieuBdcUpNeCh494jcy08GJD3yVT+4IA3vfPlMKAhUr7Ka5RLhLeQD8Wd60WU3ab
	vL9Tx33dy3vyxyxKcS4GI/VDKRce6nVM4L4gEH5ZLx4iFxcPi8rZ5TThWFfltSapFmgDo03ytnJ
	5PCDRZiZalDHk0oEsbbtw9CLJrNZ4OHoRYl2Dflicbcn6SZVSguM/mqtDgrjjEwIEwgk+CVrbRz
	ngGcPJJKQzbzMzksOSacvwJiCsy6but+FwXUXR3akcH46EmSE8mj7v+qrlU0XRKJgXYtYoim9UF
	9POQJoKuvao1Rxcv5gZHDOMuZamw8/bcul46tAey/WU/Av+6lpwd8HmjpbZtmw==
X-Received: by 2002:a05:600c:5d4:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-488d6ebe787mr187773555e9.15.1776275606586; Wed, 15 Apr 2026
 10:53:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415023947.7627-1-CFSworks@gmail.com> <ad-LAB08-_rpmMzK@shell.armlinux.org.uk>
 <ad-8q4OrOm-VtGrO@shell.armlinux.org.uk>
In-Reply-To: <ad-8q4OrOm-VtGrO@shell.armlinux.org.uk>
From: Sam Edwards <cfsworks@gmail.com>
Date: Wed, 15 Apr 2026 10:53:15 -0700
X-Gm-Features: AQROBzDx1d-IgIRVj7cWC6Z49XonSYVLruilzmwd4JOrF6rh0MceXKBVK6meuRA
Message-ID: <CAH5Ym4gy6g8d88-vGhe1zxoV7jNH_fXHsDSdDWC4x00H7s-3=w@mail.gmail.com>
Subject: Re: [PATCH net v5] net: stmmac: Prevent NULL deref when RX memory exhausted
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Baruch Siach <baruch@tkos.co.il>, Serge Semin <fancer.lancer@gmail.com>, 
	Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238176-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,bootlin.com,renesas.com,nxp.com,tkos.co.il,st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cfsworks@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,armlinux.org.uk:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E75C406EDF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 9:28=E2=80=AFAM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Apr 15, 2026 at 01:56:32PM +0100, Russell King (Oracle) wrote:
> > Locally, while debugging my issues, I used this to prevent cur_rx
> > catching up with dirty_rx:
> >
> >                 status =3D stmmac_rx_status(priv, &priv->xstats, p);
> >                 /* check if managed by the DMA otherwise go ahead */
> >                 if (unlikely(status & dma_own))
> >                         break;
> >
> >                 next_entry =3D STMMAC_NEXT_ENTRY(rx_q->cur_rx,
> >                                                priv->dma_conf.dma_rx_si=
ze);
> >                 if (unlikely(next_entry =3D=3D rx_q->dirty_rx))
> >                         break;
> >
> >                 rx_q->cur_rx =3D next_entry;
> >
> > If we care about the cost of reloading rx_q->dirty_rx on every
> > iteration, then I'd suggest that the cost we already incur reading and
> > writing rx_q->cur_rx is something that should be addressed, and
> > eliminating that would counter the cost of reading rx_q->dirty_rx. I
> > suspect, however, that the cost is minimal, as cur_tx and dirty_rx are
> > likely in the same cache line.

No, no, I like your approach better. :) It also removes the need for
the `limit` clamp at the top of the function, so later code can assume
limit=3D=3Dbudget.

> > It looks like any fix to stmmac_rx() will also need a corresponding
> > fix for stmmac_rx_zc().

I agree that stmmac_rx_zc() is likely also broken (in a similar way,
but not similar enough to permit a "corresponding" fix), but I don't
agree that there's a dependency relationship here. This patch is
addressing #221010, which affects the generic/non-ZC codepath; I'm
afraid the ZC codepath warrants its own investigation.

> I have some further information, but a new curveball has just been
> chucked... and I've no idea what this will mean at this stage. Just
> take it that I won't be responding for a while.

I think I follow your meaning. Good luck getting it straightened out!

