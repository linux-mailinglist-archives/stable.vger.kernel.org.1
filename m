Return-Path: <stable+bounces-249282-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4PQ+BeoQC2pN/gQAu9opvQ
	(envelope-from <stable+bounces-249282-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:15:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5B9756D70B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6823B303131E
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BA640C5C5;
	Mon, 18 May 2026 13:09:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB4E17A2FB
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109763; cv=none; b=JhFD4+AOu0phVvu2iukEF9lUX08QI4Baw3KbSHVoiGeUaSKFaNafyHcKjzV63gBFYIEDfkVSPSUO0e6vVahH+ASJjgmOHsdiejWT1yBQ2cc1Wm40LoAYHEp1DRIwDgfKg/xhclNvCdxWXaCuafAhzQq+Urr85VL2ZN1gFs8os6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109763; c=relaxed/simple;
	bh=V0P9WDALJ1I2iIIoWPjcR0w4g1HygrqhqYPjuNek90k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CfLXkc/45ndaOzDIa7XV8aftFHM9DkGrqRpjjO8BbF/Wd5dOfmQ/gF1LTme3GzaSIqJGqqnb1UlcvO5hB0G9OQKKS6Ka2cTN6v7G7zP3fAQLr1QKovLmYRPKj0fM2O/nkO0SGab0nRi0+7KWDP99ycqYEvms8YDFlirWSDU1aEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-6312b8f8e47so613451137.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 06:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109761; x=1779714561;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4P5QLcEzhZH+iMBp8Kosg+9RMRtsU7zMDBAroJzlJGY=;
        b=P5YPcZoQPDxBhmo2/sjWo6v2HR7NB3C0Bi8G+Zwx/ofAjKMAxVwJmg3A75+vB/9ln5
         YGd8sU/9Q4lpqfTo6J2n9Z5FTZcIHheBZrkBmx/xBTpRoF6wbxLUfZr+QsNggtOW6i3D
         IaLcYZgz3T6O6HFPsjS8l2fHDTKzjZGCbP82gA6R1PDkYQeV4pzu9BbaJHuZvLv6LYJw
         fa3dfYbSQc9QWxFGfRlMdlu+pehGlprZ2epPtkr9c8HpL3mgcVnt4fyiT07L4a5TC6pb
         plwHSTnPbyno5aMuPD8E2vj2+l/0tvfTrK3vtT9k1PHIq9HUcASx93qJWqo85pxQpADl
         nW0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/prQHq5LLmmwdILjnoCOSHBbsmLZinjmmMpo33rYDgfOIFE7Gxz4/VVEVYCo79tPrybYX4YiA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNezrzZTJFeugIMCHP5pOWKlh/AQyGlKDToy7nygkrbMXHAZGW
	ZQzA+mdn3cNqddmBiELxzA5Cxm/FceDtY/jO2FDaV2OABmoNS856HSRMmJRAzLzo
X-Gm-Gg: Acq92OEN9PxluXVgQSa2iCL4EpQJvRQUTtNehFvzAgZVcBmIiK0s8foKIMsvfC7Kv3j
	w9DkezFym6NTZlKT0yrmIsJO6Vt5wPWvR9twqlBWOqV5yRCCPbjfQZn4c7XSIh2kOWEjFgTVKy4
	mj1PzAq1GC9Wr1+lDC3AXjWipYf5+uszh5VsekCFKPTDVMp5v6GuRE6cG1gj5dhu1ojvM7SP3pS
	R7tlin2sihEgNhqwycwGb5P6tsM4MlghOE9GRAYwgdJ/ZhWAuxoEHpPqxFL714QRKp/MUbLpVMV
	+VCU3DoytXFawr18WYpeD8Zx1Mi8v6tm0fl6IleUqTUGxwR7d7VY4B3h8YGqiIY5TWU3zJG8qV3
	XJqf7yFEzhsnWaz94p1vOrCKHLlJqykPoEUr9dzVmrFfxJc63P0YdCUFDcmKpkPteuPzpmq6hKB
	Umk1421EKPka54fTlxF3EwgjS9uC90S1LVHQBUi6D8vh2Q3p6uZHPKUspDXGacRv3K
X-Received: by 2002:a05:6102:3ec7:b0:660:ca32:2d80 with SMTP id ada2fe7eead31-660ca3232cemr321129137.0.1779109761296;
        Mon, 18 May 2026 06:09:21 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com. [209.85.221.180])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-63cea473caasm4705237137.12.2026.05.18.06.09.20
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:09:20 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-57602a2d80aso590343e0c.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 06:09:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8CU/PGmoFZcz6GinjxD6IK1nBZLHZDD0mAaX2k3lK5MmV0cucdCAetrBjzhbeu8Yr3/EgzWwY=@vger.kernel.org
X-Received: by 2002:a05:6122:4d06:b0:56e:f262:9113 with SMTP id
 71dfb90a1353d-5760c0943cfmr6808832e0c.14.1779109760741; Mon, 18 May 2026
 06:09:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260514212024.1624517-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260514212024.1624517-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2026 15:09:09 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXdSuiJ77bjoP7UQD2FK=rdprh06=13kDfVt4otPmwLCw@mail.gmail.com>
X-Gm-Features: AVHnY4K0v1qwmuRJJHyFwdOzfeyYUi3b4ZKmDJqEEb1F8PYs48qlTeg31JaGAKU
Message-ID: <CAMuHMdXdSuiJ77bjoP7UQD2FK=rdprh06=13kDfVt4otPmwLCw@mail.gmail.com>
Subject: Re: [PATCH 2/3] mmc: renesas_sdhi: Add SDHI quirk for RZ/G2N
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A5B9756D70B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249282-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.995];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Action: no action

Hi Prabhakar,

On Thu, 14 May 2026 at 23:20, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/G2N (r8a774b1) is identical to R-Car M3-N (r8a77965), so apply
> the same sdhi_quirks_r8a77965 quirk across all revisions, as is already
> done for R-Car M3-N.
>
> Fixes: c9af138c42f0 ("mmc: renesas_sdhi_internal_dmac: Add r8a774b1 support")
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
> +       { .soc_id = "r8a774b1", .data = &sdhi_quirks_r8a77965 },

Hence I think the RZ/G2N entry should be added to
renesas_sdhi_internal_dmac_of_match[] instead, referring to
of_r8a77965_compatible.

>         { .soc_id = "r8a774e1", .data = &sdhi_quirks_bad_taps2367 },
>         { .soc_id = "r8a7795", .revision = "ES2.0", .data = &sdhi_quirks_4tap },
>         { .soc_id = "r8a7796", .revision = "ES1.0", .data = &sdhi_quirks_4tap_nohs400_one_rx },

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

