Return-Path: <stable+bounces-260364-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SC45HBtNIWpZCwEAu9opvQ
	(envelope-from <stable+bounces-260364-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:02:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D2A63EC3D
	for <lists+stable@lfdr.de>; Thu, 04 Jun 2026 12:02:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260364-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260364-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66BE33006B4D
	for <lists+stable@lfdr.de>; Thu,  4 Jun 2026 09:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E8813DDDAF;
	Thu,  4 Jun 2026 09:55:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B28C3D7D63
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 09:54:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780566900; cv=none; b=EHiZn6YqnpO+2G7dvBqhcOm1RJWQrPk/nTtNREdH3i5kfVjqfyZ7QJznBjq206sMjALkp3U6EjvZKeffnGYupleS4WrPQl8BbQ8lI7zwl3cezem8v5+lGQ3ma6JdWjnvyb6EFSbR24UqJbxHFXX+5cjb0N3MBJN9MLi2OH4QDYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780566900; c=relaxed/simple;
	bh=9ccdKlMLp3ktq3NWcjK3eTgouh7Xi9aiQybPD3Ap1o8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cmpb9Fzo1nn0OsPotKuKOq1EJYpcKgqXS4uGg0dfyZBvEOpf1PmjKHxjcxFmJAyoBuuN/oN4MFT7xDu75/19Y/7wt8C9J1VRUvPEZFJRvbWuHECWYftEUP3Dy/JYQkfeA/BMkMcvy+q4c1HYCIbgCEHt58DCuaDWDS7h8B7ICXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.173
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-9159f631656so48599485a.1
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 02:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780566897; x=1781171697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPyZKtpWg5qnni2e5fD9GWWB7qem8w+cCv5HCayF8qI=;
        b=LSU1mwxvQdTepNASGu4WEBV1Kz3K6/E9X4Le/OsyE69PIId8RHuGSUmrzODXkaXs1q
         KXAFr+18RwWZoXTnjeX2pYOUE4na0X7+GtZzWBcynfvWPKXHiQaxgyJUlJYFlVA/4zCo
         oA9ch4T4ajvrCdoB0x0+ONkgi6PwRRao38T0XCuHjMk1mAvQKTsw8vwCZsrFYR/SvLw8
         vWmuG9sLBIGDoDqgU8gdPENonTphrqKseBkSC3GxhfqMIuMKK17/ply8rhhe0+XGJONE
         u1hzxpCU3ZMLvt5hiwoR49xVxrr8ZQ2u+iLJVrVATR0W4uea6HTl3+DbH+FHLNwojyW5
         3YfQ==
X-Forwarded-Encrypted: i=1; AFNElJ/5lmnLcnGzMc2vXrMrLPh6YuAYleiXm97BMyo4BNx49jQ50vA3dVQhQqFY5iXl8H9vNNrqLjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR4ASWANuPK4oClweTq2/ncBO7r3BNnSusqFd7zokFzlLSFFeH
	4h6kAd/HeQOuoku7Vg4OBMBRSGND2P2uAGAmV5F5gOLGKTgb0wsny8fPKcCYvwOUnPg=
X-Gm-Gg: Acq92OHWcYiN+1jF8UJDE6FaYtVctsOW9pIUQwM07WzOJOikHVM8FnYk/O2vafwOcrw
	AxPEZtkOSLl9cKpfeT/0oevhjQtXCCnQT1JR/HKInUK+elVhsF+U95FxSsfyG6nrUsxyENigkGB
	yTcPPmIsvqHW57xw1c3PUgVj/eRtg2L5OjmfGmqekog9fRTzvKlH/idfjYtw/Ck7i50IGBkiXhe
	6CpsBm33/KTbHE89Gd2Pt4CAgnZ94XhOcveL5Y2gLLDh/fdq+s6Y1fmw04wdWe0Dvv0UIzT5kYv
	K9iGa6O+NqAT7EPSTV8B6KIDr3Nuhrii+H1vWkJ2oGBKKsJ9n2KG7/kZrtxlTujUZN3gQypBMEb
	5IgWGxou/KsQ6Mhaq5cjFo/xnDrCSVBQp7KLT2Ul8TdCv/utcVAZhmIpQJmwOX/6r1PzLouNNE5
	3JFMgfzdEOiEeX8OizY+fK5Uf8XrAp4Mo5SJ/qmFu5dUHwkeTvE5g86p/inZiOPOBkFXzwNH83w
	9CVgZn5l0mJeA==
X-Received: by 2002:a05:620a:40d6:b0:915:9931:3a39 with SMTP id af79cd13be357-9159afa478cmr435114985a.34.1780566896959;
        Thu, 04 Jun 2026 02:54:56 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ceccd9fa53sm47635936d6.8.2026.06.04.02.54.56
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 02:54:56 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-517907feed0so54571cf.1
        for <stable@vger.kernel.org>; Thu, 04 Jun 2026 02:54:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/66/pTJ+Sm0iYt1P9NJeMnbAfjKVbjoG6kTHcaJkY5XHSrQzxjq6tL3CqHXIpXi5TFron7zu4=@vger.kernel.org
X-Received: by 2002:a67:f889:0:b0:6cb:b3db:c31c with SMTP id
 ada2fe7eead31-6f52c84f821mr959856137.0.1780566537239; Thu, 04 Jun 2026
 02:48:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260603151642.4075678-1-claudiu.beznea@kernel.org> <20260603151642.4075678-2-claudiu.beznea@kernel.org>
In-Reply-To: <20260603151642.4075678-2-claudiu.beznea@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 4 Jun 2026 11:48:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU_T=G7os6KBG6xTnphnhQ9pQtd88BUkg61S7286bZmFw@mail.gmail.com>
X-Gm-Features: AVVi8CdhQoz1FuQPTz5BSOMe5fOJfBS7YW1L8CNma8uYS8HEHOx4e8eahLsemts
Message-ID: <CAMuHMdU_T=G7os6KBG6xTnphnhQ9pQtd88BUkg61S7286bZmFw@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] pinctrl: renesas: rzg2l: Use raw_spinlock_irqsave()
 on power source update
To: Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: geert+renesas@glider.be, linusw@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, magnus.damm@gmail.com, 
	prabhakar.mahadev-lad.rj@bp.renesas.com, biju.das.jz@bp.renesas.com, 
	claudiu.beznea@tuxon.dev, linux-renesas-soc@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260364-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:claudiu.beznea@kernel.org,m:geert+renesas@glider.be,m:linusw@kernel.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:magnus.damm@gmail.com,m:prabhakar.mahadev-lad.rj@bp.renesas.com,m:biju.das.jz@bp.renesas.com,m:claudiu.beznea@tuxon.dev,m:linux-renesas-soc@vger.kernel.org,m:linux-gpio@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:claudiu.beznea.uj@bp.renesas.com,m:stable@vger.kernel.org,m:geert@glider.be,m:krzk@kernel.org,m:conor@kernel.org,m:magnusdamm@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[glider.be,kernel.org,gmail.com,bp.renesas.com,tuxon.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas,dt];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[glider.be:email,mail.gmail.com:mid,vger.kernel.org:from_smtp,linux-m68k.org:from_mime,linux-m68k.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,renesas.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B8D2A63EC3D

On Wed, 3 Jun 2026 at 17:17, Claudiu Beznea <claudiu.beznea@kernel.org> wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>
> The rest of the driver uses
> raw_spin_lock_irqsave()/raw_spin_unlock_irqrestore() for locking. To
> avoid concurrency issues or deadlocks, use raw_spinlock_irqsave() via
> the scoped_guard() helper for power source updates as well.
>
> Fixes: bbe2277dedbe ("pinctrl: renesas: rzg2l: Add support for selecting power source for {WDT,AWO,ISO}")
> Cc: stable@vger.kernel.org

No need to CC stable, as the bad commit is not yet upstream.

> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-pinctrl for v7.2.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

