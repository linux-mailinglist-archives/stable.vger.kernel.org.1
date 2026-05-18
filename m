Return-Path: <stable+bounces-249281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALAACTMSC2o5/wQAu9opvQ
	(envelope-from <stable+bounces-249281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:20:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 023E856D85B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6C6C5301B1F8
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C046E480DDD;
	Mon, 18 May 2026 13:07:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39290480DC5
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109679; cv=none; b=SjNdNTm8uyYub+PEp6ZYUbQ+vVQ1G+0TKHPu7PItVXwEgQ1MuTwaJHArnc/qDEubHOfVgftNRXjnvh0XJrYR78mAAyltlWy3DwB8fl9pQYDx7ycj1UBgjmi2y9M8RaocVKxkLY4roHxlTNwRoEpHq2JUsSh3wSHt/0XoAL7a/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109679; c=relaxed/simple;
	bh=bLoHqx7iz89YsOH9/yJgX2I07MLCqfljXasqV1HWAJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2m/JAua2oyRcu4KxMn07GD2+z5l0LnukP/ZWVVT1S7Q165b7OpH1aP/il3R1oZOq8u3z/QLQ9I6H67iFWYQBx6cJpM0fM797dCYPb2Kh12blmiP4FKcWMZcjqPHrLI+0F8y8dcPlAjdmUHJvfnGtAL0SU+i4lgN6+L5qaTklhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5751b7d147aso719841e0c.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 06:07:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109677; x=1779714477;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o8A4vYkByGT4hltTC530nDELFOVxe5LtgHJp6bYwWpg=;
        b=kGHPZQt26Xx0/3ZCSMGMt1nwXcecd3ysFBC6x2o2oSP6ws/kXKWKMtHZ5pBoZcMw2H
         Q38C2L87L3f8NZH5sbBK1uKIDIFHf4NA0gQY6gUKAwW0U6cfvWzQ4fo7X2wHVic/qmOP
         iheXx4Hy3i+Q40fhz/hBjDupvAiSup9RssgZ+7AY66+q6JJ8WPl+cboGvHrjLmnMLqEB
         nhU+2LIpmXnzZQ+NZqVeV+auM5uubdxitgoGjVs7dgwMD0WBF2RRKtShaTFa9Vw/DePF
         fstE7W85wvk2OF/E1ND81tiBnUFuZ9ZCocATgbEkDrGDjjjFhsbb9R5A0W43n6RHSsvW
         zF8Q==
X-Forwarded-Encrypted: i=1; AFNElJ/alogB0rjyKXeZuUxHLonL5r7HbGS4kTDPZRVQ728LJz/u6PMCvfuT1mq5Tqd26AnX8n6/ZyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPRqOMSsIzRccfrg9TaOs5uC1b1Zq7NadWwE/oeBsFmwVIcBBF
	5KeY9a2pA2/nNdTvnxJXajQqxZ86xV4InbZrfr1PVwTXrZcj+3BNdsdhqgUaLsgk
X-Gm-Gg: Acq92OHSQP10Bw8Ivx5sURj2YITGI8igVmA9BDnNzfHasO8A/npFm6qyODDeQyZGvPJ
	rlMHgXkMqvnD5ldNH2XmNmUpwdJGlnbRMZk6o9iWwU5eEIDfeft2lFQM8vwns3451P0XuAKSYnM
	ILKqHJExILTXepsriC/sEOp2Jq4MfELSDJ4KsplEaqZwHBLzVO5NkYwUzZyl0qBLY0qlvHyiCPx
	+3wLN08wGn//pzhQIgD043vQjjiDC50kZLW2znUN7idzQsgKO4w1r6EwGS/xeKPY6r4BdUUwnBP
	KnXN1lLUmc3gJWEeXlw9Lgpc9WMShNrIoWAn3Zv989PLgV9PBBB2qLvPRsfIAfZLJMb8POaYqoo
	j1xOC1zReSasa3NdRvy8qQKYcf+BikubMkgOm+gAWP5qv23wScRscQ3Q4mn9CVz5NrtjrSanxmG
	l8o1QXrFBo+kuqsUUKdx9wxSg9/SKDYpRCEMEutaMz3vnutkAEn29x9SIp7l3zOYC65+k1MVJE/
	Co=
X-Received: by 2002:a05:6123:128:b0:56b:8e1c:582d with SMTP id 71dfb90a1353d-5760c09b0f8mr6573431e0c.14.1779109677033;
        Mon, 18 May 2026 06:07:57 -0700 (PDT)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com. [209.85.221.182])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95fc2d278a8sm4536083241.6.2026.05.18.06.07.56
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:07:56 -0700 (PDT)
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5774680983dso613609e0c.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 06:07:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+UGu3EO8FFGMaXHHble7wutIQ9rm6tHbYI/psSBxKGKlh33oeh4+wFFpllnqUQo2MFJjDplzk=@vger.kernel.org
X-Received: by 2002:a05:6122:da3:b0:56d:9e98:4676 with SMTP id
 71dfb90a1353d-5760c09d17bmr7729115e0c.13.1779109676420; Mon, 18 May 2026
 06:07:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260514212024.1624517-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260514212024.1624517-2-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2026 15:07:45 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXDAJjWGRLQb6jfvzUPAWymmTC3yE89UPyiydykHN4u6w@mail.gmail.com>
X-Gm-Features: AVHnY4IiZkti6BwVvlbvdUVkcYDNCX04P78NcYM0PkLVTLe5ljlG3OOT8x4qAls
Message-ID: <CAMuHMdXDAJjWGRLQb6jfvzUPAWymmTC3yE89UPyiydykHN4u6w@mail.gmail.com>
Subject: Re: [PATCH 1/3] mmc: renesas_sdhi: Apply bad taps quirk to RZ/G2H
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 023E856D85B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249281-lists,stable=lfdr.de];
	DMARC_NA(0.00)[linux-m68k.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-m68k.org:email,mail.gmail.com:mid,renesas.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Prabhakar,

On Thu, 14 May 2026 at 23:20, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> Apply the sdhi_quirks_bad_taps2367 quirk to the RZ/G2H (R8A774E1)
> SoC.
>
> RZ/G2H is identical to the R-Car H3-N (R8A77951), which already uses
> this quirk to avoid unreliable tuning tap positions. Use the same
> quirk entry for RZ/G2H to ensure consistent SDHI tuning behaviour.
>
> Fixes: 31941342888d ("arm64: dts: renesas: r8a774e1: Add SDHI nodes")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -224,6 +224,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
>   */
>  static const struct soc_device_attribute sdhi_quirks_match[]  = {

This array is meant for quirks, i.e. to address issues on specific
SoC variants that cannot just be identified by the compatible value.

>         { .soc_id = "r8a774a1", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
> +       { .soc_id = "r8a774e1", .data = &sdhi_quirks_bad_taps2367 },

Hence I think this should be RZ/G2H should be added to
renesas_sdhi_internal_dmac_of_match[] instead, referring to
of_r8a7795_compatible.

>         { .soc_id = "r8a7795", .revision = "ES2.0", .data = &sdhi_quirks_4tap },
>         { .soc_id = "r8a7796", .revision = "ES1.0", .data = &sdhi_quirks_4tap_nohs400_one_rx },
>         { .soc_id = "r8a7796", .revision = "ES1.[12]", .data = &sdhi_quirks_4tap_nohs400 },

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

