Return-Path: <stable+bounces-249283-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GI7BRkTC2o5/wQAu9opvQ
	(envelope-from <stable+bounces-249283-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:24:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F2556D91B
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 15:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AF24304297C
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 13:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E952248122B;
	Mon, 18 May 2026 13:10:17 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AF5E421EE7
	for <stable@vger.kernel.org>; Mon, 18 May 2026 13:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109817; cv=none; b=d/dhZCRF/W9tB+GGiwqUPhYGz+wIFMv7B8LnfoUxpJ0YQqe/Z6sfu3pCk5++0OadQB0qVarSCXvOM0qoJhEegNRJzPBgTTES98aYhC6ZcOTeCpi2Vozc+RwzYGGGjxGt02+pyVw8n/vY6H5JNyV3Cf1nu593JpgDFlV4Ij0Uj5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109817; c=relaxed/simple;
	bh=G7+udxGdMzW311PV93iVyWCQ/w9rFtkOUgJWnF/y29o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pkYBByMy343Of7IIzI6B8Ja2qygSvgyHiL2f5vs7H2jJaAUVLvTMtVlxfhf9gfssVjwz99lwnz+3UTJ9loR1zAqSAQGF8vjXUaJA5408X/VmNKbUdJkQAkAxo0seZS21Whv2FEE2RfeJGPx3sUYJYjyGScddQrwsaHGXo2v0MNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-6314a0eefb1so547628137.2
        for <stable@vger.kernel.org>; Mon, 18 May 2026 06:10:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779109815; x=1779714615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uHrpzbVHUORDOZVtpFM2vQlzLjhthGfdMakUGRCP+CQ=;
        b=AleDXUue3VXZACmBvxsuo5cfr5BJeoCeK8jZdgPxMbnN84CKimTi4wWy08tuc4XTtd
         bTjw9uqWb2MGm5YpTAins+JlZMo/atlLuXVxlOEzjPkWR1kRnOYuuRqJrXvTuWvZUw0/
         Xblnrygrcz6Btcn6Q/Q2oQuuTfiFOXV6/9wi8KMn1Yj7RtvTr/oo+7vrU4nH3TsQcP48
         bnZI8PHcurhJb1nGf8yzQ6ET367KkK86Ob2wX+iiV9wPajd8dn9zUUbDsk9YY+NrnCGz
         j11Lo2W3dH3QYM/LOzXiVaKsjyt4jdNFXLul13HZ4OtK/ABs8MywEwcFvi4t/JVPLsLt
         +vxg==
X-Forwarded-Encrypted: i=1; AFNElJ+QegL/8H+SKfvYmfz52vy8ohxX9v8lwHmSpp6vCtt4nJ/C2YEPcMG3mw9mew5m7vAQvFrK8QU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyABDKuSHyiuPCyc0t0bS02v1xvydUKgTUM5bR7ATG2nOmZP7jv
	r2PWmoD9Vs91NqyC3c3KUW2D9zw6mj09judm8mBRovekPwfDDGeUacXC4frL4/eN
X-Gm-Gg: Acq92OEK+yUAufeI2g06IJFPv+8ufU26RxvN2TNiQDYCdS9J0hg/LC4FUchz3k5OBOv
	VQNqVtuRtPqAtldhCwBt2Lm5950SwVNeJM6yaN+8owAXzSFFDU5ZZMLzjC4vautwUWfmrgdhBmQ
	mNYf428wtV6n5avGVxkJ9l/+oZ/+UaMMqQD78gPl2lmyj7Ud/VpZh2yUPn3dzm4lI69I/I3I+rE
	TKTngsl+5jc2oUGzginf/9BMJOIkXihOjR5t1YhiD1+m7jbM3UqNLQ0LsebJestN58Kpec9LRdF
	joGLjVr/nKzLb5oEdRITNF0B7GEzklMSyMzEEzgySTaxoN5/jHLtV0TcOwYcYk34cdy6LBWtagv
	NRSP/5MZm8fqJSwzhEmJuIKziWqmcu4pqwwiPbUp5bCQIBHSyuB2UcxTIlQSIIXb8uiqApkIffP
	VTEoH9qxjUBpvozIDqVYVRY5fmdk+9sXVojX5Zshb2gJ6nCnWWl2zk8tJN/gO7XnbJ5YYxIm8KG
	h0=
X-Received: by 2002:a05:6102:1492:b0:631:d3e4:efc4 with SMTP id ada2fe7eead31-63a3d951d5dmr6425591137.11.1779109815256;
        Mon, 18 May 2026 06:10:15 -0700 (PDT)
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com. [209.85.221.177])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-63cea473caasm4706410137.12.2026.05.18.06.10.13
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:10:14 -0700 (PDT)
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-575602688deso701130e0c.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 06:10:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+RbucLThbmw6wZVw5ceGnX1xwr5Ua+LUyU6EiA27ydCTGuoIkJaeXnx1s6keRRa771MJ+5H3Y=@vger.kernel.org
X-Received: by 2002:a05:6123:2e2:b0:570:f670:587d with SMTP id
 71dfb90a1353d-5760c1db187mr6653637e0c.12.1779109813267; Mon, 18 May 2026
 06:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514212024.1624517-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <20260514212024.1624517-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20260514212024.1624517-4-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 18 May 2026 15:10:02 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWGiJ_SQag2ZdYsz-rgiUp1X7OuA=9BwzdCp2MvKt4NGQ@mail.gmail.com>
X-Gm-Features: AVHnY4L_CmKmFv6NTtb7Ex2zBx473PgByWg0FHBUS3H5Q5GXZk_wFPvmtDeeWDM
Message-ID: <CAMuHMdWGiJ_SQag2ZdYsz-rgiUp1X7OuA=9BwzdCp2MvKt4NGQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] mmc: renesas_sdhi: Add SDHI quirk for RZ/G2E
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulfh@kernel.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Biju Das <biju.das.jz@bp.renesas.com>, 
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 26F2556D91B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249283-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	DBL_BLOCKED_OPENRESOLVER(0.00)[renesas.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,linux-m68k.org:email]
X-Rspamd-Action: no action

Hi Prabhakar,

On Thu, 14 May 2026 at 23:20, Prabhakar <prabhakar.csengg@gmail.com> wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>
> The RZ/G2E (R8A774C0) is identical to R-Car E3 (R8A77990), so apply
> the same sdhi_quirks_r8a77965 quirk across all revisions, as is already
> done for R-Car E3.
>
> Fixes: ca804a5615a7 ("mmc: renesas_sdhi_internal_dmac: Whitelist r8a774c0")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Thanks for your patch!

> --- a/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> +++ b/drivers/mmc/host/renesas_sdhi_internal_dmac.c
> @@ -225,6 +225,7 @@ static const struct renesas_sdhi_quirks sdhi_quirks_rzg2l = {
>  static const struct soc_device_attribute sdhi_quirks_match[]  = {

This array is meant for quirks, i.e. to address issues on specific
SoC variants that cannot just be identified by the compatible value.

>         { .soc_id = "r8a774a1", .revision = "ES1.[012]", .data = &sdhi_quirks_4tap_nohs400 },
>         { .soc_id = "r8a774b1", .data = &sdhi_quirks_r8a77965 },
> +       { .soc_id = "r8a774c0", .data = &sdhi_quirks_r8a77990 },

Hence I think the RZ/G2E entry should be added to
renesas_sdhi_internal_dmac_of_match[] instead, referring to
of_r8a77990_compatible.

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

