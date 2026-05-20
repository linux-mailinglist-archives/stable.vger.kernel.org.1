Return-Path: <stable+bounces-249777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIXmI9RqDWqHxAUAu9opvQ
	(envelope-from <stable+bounces-249777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:03:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E72E4589564
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A0FEF300D69B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 749AB376483;
	Wed, 20 May 2026 07:56:34 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A29329C54
	for <stable@vger.kernel.org>; Wed, 20 May 2026 07:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779263794; cv=none; b=HNy09ooR7Gk+MQbrea3KoHCE5EfFO8TjZPIs2fFPOzJoj9+qfw4cTTGB84Wt74FiM9K0DBNeSVwY67p2GvZZeXc6WkJF9iB2eB78+mIpZC7IeYojUgy0gPBt7CGKQrVj6N/HAhbovHmYpED3g1TRfeN7IC+rjj+4Adl5Fk2eD94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779263794; c=relaxed/simple;
	bh=QqPxeM13+Xx0aqfPwJhCfwrd69Mly4RhTLXMjEcRwuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V/ujwZi35X5gJC+jJcXZSII3dTOR3H5gr2TW7j1EomuqaMLeDJ3HW3QbAlhwcLUstoj0wIPFJop3/9Zm9aRmVKXcIz0SKm0Txl2ItCJmr8wkv5T9q5dJhRLzMlTU9Td8s07PAMKcromHZzbzmMsgyD4sxO+mMy2ft93OvX9wuyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-95f2b0bd920so3767559241.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 00:56:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779263792; x=1779868592;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f7bxrGxQ1iTs6SaX4Z9onRYwjShKtP0zGwIDYAHZcO8=;
        b=pviQYjqjPW5pF5kW1VltD2foHVnAHkJkNRHW92fve7OtN/5kUECLriLHBWxgFcCrQp
         oW+Q8vZBITqvocJluys/caHRhbePqgK6g+gjtGB7gn+cAV5nX1teX6y7HSmLY+R5oE6S
         MAYXkYUiyVZ/uPLszWiJm/p7pGdCK80LUPe/L8yT0U5CordcBYLA6xuR+NKSAyrvKA2A
         5BAGLssnr912E2btVc9yNVfvdCqkBYtI4jR22u8ejWt+GXQPM9hr1orGe7faVxQ83/aF
         4L3GcBhZZR8rkkMZOwk+V+lVX5noO5iR5RAr5lbj0S9so6ZlvH4EOO1LIMSdhZ+sdUhL
         0ePQ==
X-Forwarded-Encrypted: i=1; AFNElJ+C9VbFNTTPzhy10Vdv/KFBWsEwwFIHGjPnkPiSytEFT/QbTE7rvjr3SK2rdW5eNXTKTi3Hr+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFyRjeuZxhmB8NlEdPEPYUyOGmb7eiV8McNGqclW+q0dq66yuh
	a0Ag9NsHs+TW5o7f8GLUw2v2DZVj9ABzjudf3BL9pqeUoFw/jnhLN5v9qzrrshbrlYU=
X-Gm-Gg: Acq92OEdRAUfQfr5tSkH7cXKpL/Nmp8Rh0zELkNwPd7No/PV+cmnbq4FCLIrYu84I1K
	JH+YKI0Mlu/J6IiXE2pLBAs5WtmhX2mwqshzYan3l/5pwbHMD1UYJxHOj8H7frMswBy7aqPmowe
	jm6ZI7o3RHHCUm0voaFEl2IhKRmSJIoxljLpY3KMkvy51261ZiOzrzrk6pVP67wZBaa5dN0BRbF
	ZoUrKw241Mzq8su+Hd6sd/hF63HGkI475j1szwFdC2XZv/x2CsoZXmqkVH1D+n2Nf+aQj0EK9FO
	uzRo9kdZ5PP9A1CWqO9PsyncPuIyjQXoZj6EZFlZknqqWB07VUm8+XnUb83Gs2B8V9uI6Rwae+M
	hOkXrZiRCsv+gWeu4Sg7BMsxOFC3X7mSQXir4Ft+BCgALZOdAysxknO0pyx/mwoWNagmFXXZs4T
	rWqwcgEOKY+8xW7l9HbXgJSgCpNU6wOSm1qApWJktYl/3TEbZ1ukLCEYRhK8GbsgsUGfz6Zs0=
X-Received: by 2002:a05:6102:54aa:b0:631:6403:b12c with SMTP id ada2fe7eead31-63a228bc23fmr7849388137.5.1779263791638;
        Wed, 20 May 2026 00:56:31 -0700 (PDT)
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com. [209.85.217.50])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-63cb23b0d19sm8259261137.0.2026.05.20.00.56.30
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 May 2026 00:56:30 -0700 (PDT)
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-631ca15d35aso4264475137.1
        for <stable@vger.kernel.org>; Wed, 20 May 2026 00:56:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8HrRq0fP0/qRh7DNYIDz62033Mj3noz4Wl7uiN11LO8Ka7rp3kKuGkEc6oy8KLJPK8JSUkE5A=@vger.kernel.org
X-Received: by 2002:a05:6102:c4b:b0:634:10bd:95c6 with SMTP id
 ada2fe7eead31-638b8411d03mr10827623137.22.1779263790023; Wed, 20 May 2026
 00:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260519135342.623943-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260519135342.623943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260519135342.623943-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 20 May 2026 09:56:18 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVsSdar1OdGtU4wK+d0+UDxGJwtXBRa+LgRVwK5BE425g@mail.gmail.com>
X-Gm-Features: AVHnY4KNCbwcbPYoOaAbA20ajOpz0ciN8hyEvIG4fBBRoaXuGIeSrdlARt57b4Y
Message-ID: <CAMuHMdVsSdar1OdGtU4wK+d0+UDxGJwtXBRa+LgRVwK5BE425g@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] mmc: renesas_sdhi: Add OF entry for RZ/G2H SoC
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[sang-engineering.com,kernel.org,gmail.com,vger.kernel.org,bp.renesas.com,renesas.com];
	TAGGED_FROM(0.00)[bounces-249777-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux-m68k.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,mail.gmail.com:mid,linux-m68k.org:email]
X-Rspamd-Queue-Id: E72E4589564
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 19 May 2026 at 15:53, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/G2H (R8A774E1) SoC was previously handled via the generic
> "renesas,rcar-gen3-sdhi" fallback compatible string. However, because
> the SDHI IP on RZ/G2H is identical with the R-Car H3-N (R8A77951), it
> requires the specific quirks and configuration defined in
> `of_r8a7795_compatible` rather than the generic Gen3 data.
>
> Add the explicit "renesas,sdhi-r8a774e1" match entry to map it correctly.
> Note that the DT binding file renesas,sdhi.yaml does not need an update
> as the entry for this SoC is already present.
>
> Fixes: 31941342888d ("arm64: dts: renesas: r8a774e1: Add SDHI nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
> v1->v2:
> - Dropped adding entry in the quirk list instead added entry
>   in the OF match table to map the SoCs to the existing quirks.
> - Updated commit messages to reflect the above change.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

