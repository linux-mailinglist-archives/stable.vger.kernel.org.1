Return-Path: <stable+bounces-238510-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJXqMEt+4mnk6gAAu9opvQ
	(envelope-from <stable+bounces-238510-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 20:39:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6A941E027
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 20:39:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE72630398A0
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 18:36:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22A4D35BDCA;
	Fri, 17 Apr 2026 18:36:50 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com [209.85.221.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB5D26E142
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776451010; cv=none; b=usWT8PhHBUnOydAEj/d8mBjJMkdmc4ernPeUX7OgUG7RJcvJv2Hcdizb9zhc33ktjrcygL5GJjdD/eAcvPij3RCefXqFLjJ60IuUX1nkMstaLoOEz41VwsFvMbxx5EsBX5PPtv5nSN83mBai3668tPRscHeyfw5xfNOMM2TH0nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776451010; c=relaxed/simple;
	bh=mtmF63GSsxC8ucGrWu4xmNcFiMRqT2xKfGyBPlFaKgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qsi4csMCuU1KN6uFduKhA84hp2dBilWgjjsUWXNfXOxfKiXvjUzoLtR0DL6nJsWDTbMdhwxHmuXrwQem5hMCrVGWs6JLtgOif2fBabeohw0Fh2gVvOwdDcMIw76BEMbiT9Yl9Au8nfr+BEWlr39LHIElZS4mzRqTR04qeXocEHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f169.google.com with SMTP id 71dfb90a1353d-56e91f17a99so673087e0c.3
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 11:36:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776451007; x=1777055807;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neHg95D5WYSHShReC6Umh9yusfLHSyJyieBJVR+9t1E=;
        b=DRIvQRteFxHhQ/hjynBEaL5bW0UcYmt9nvB4OtaL3wh/vWTKSb/aynxbnP0Md7rG7b
         smZuvM5b6gMEDHBoFiueB3v+GZ5H9TXzH7W34+vDvuHCF5gQzFQYARIpNcAlvFv8x6GA
         5M6xVAIOsCvqBqRE79RLd1BZAxUSSv5fNVfxkr/fM0dy/lB27WXvC5kfiw8E/PJ9KDYE
         lcZrIYtvTRQB+IH9D2YhyWXHl3bBa9NJpHI19xkkEnBt94qdCzfloj45jnBhsvTWxM3D
         AId0tQXiPMvKcafRyMUvja3hBh5FslL5GQk8bKL+q644olflIls4QAcicV6F3bzlNWrM
         uGgA==
X-Forwarded-Encrypted: i=1; AFNElJ9aCBCONBkNyJfvr3RXuFZdBbJMrPMlvEFbhuV5qe/xOqg6XQ3NQVBXL1mBDR/DNYDtc3oYIPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOWUhjw9ZtZDMnVnl7LGZXPeMVFO6McBeFcC5BZ8BJH5R55iYG
	/hLMbCoB0MXBBh/wxTDRGjFrAceojRNW0eI/3MrTNpSQbXMCOObz4uwivbuOOFx+
X-Gm-Gg: AeBDietg69eSpLRRdShjyaCBGf0VXw7S+NWgUxsTNFO0LrOofOwsge0ETBB/0pzOGSc
	+dzX4n95myp1dOFv0bpk6YK8kVAtP5OECb7QDZPZPG77HgPLyfskjPYuD3XsMGr0756Z0FiU/q9
	Cot5+bczCrWy2TeVaNL3DGarevIE1ooBhoNAr8LeV8Lwh6YlhkQfpbuiUCsEpdFFc0y4m9NGFdt
	j82oFb2VTe5Yq6paMrqEiiNEvN73V99t5NLWHZosdvKTc2KyKgjHkBjxHi5Z2vQeex90QqU7KZK
	1HiCDkyEUM60t4J96C7ck3fvwPuSplVVgtNMW7/M0W6Wh7GsQZENGqWAiOxSTfeNO7yo+ZbdnGS
	kanzdd4nijvZ11FVHI4jKLOcZeam+GuXKIDm7ohSPGEfJ1PGaeitvMWsziIY0GbDT06T+Jr7TiQ
	Vl9mxhafGVCktyyLtB+RW4IjAkLRWbjLJuRn37o5gU4aalaBP0GU0fI80/K/MoIh8qrXisxApDJ
	KvIGZUsxg==
X-Received: by 2002:a05:6122:4f8c:b0:56d:9f2a:d6b1 with SMTP id 71dfb90a1353d-56fa5a3a9e3mr2553606e0c.12.1776451006668;
        Fri, 17 Apr 2026 11:36:46 -0700 (PDT)
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com. [209.85.217.47])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-95890bca3fdsm1115869241.10.2026.04.17.11.36.46
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2026 11:36:46 -0700 (PDT)
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-6057723d553so589441137.2
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 11:36:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ8uKZ/uG0JvEQXFcJ9H+TKEzdmsnH7HVzNfQ9xcsRhIp9pbUuSmegpQKqcUxhaQ/dUuACXeVOw=@vger.kernel.org
X-Received: by 2002:a05:6102:604b:b0:605:1070:231d with SMTP id
 ada2fe7eead31-616f69cf882mr1968470137.17.1776451006317; Fri, 17 Apr 2026
 11:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417111331.158190-1-ulf.hansson@linaro.org>
In-Reply-To: <20260417111331.158190-1-ulf.hansson@linaro.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Apr 2026 20:36:34 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVr-dzRUruue0XEky_6fCt+v3AHp3G+Zv_N7S2_TpC7yg@mail.gmail.com>
X-Gm-Features: AQROBzCoxCQjJeAx5n3-CfOUikJfBlFM72Zl3QgzR1bVf-vpU4L_nBvmJuvLGng
Message-ID: <CAMuHMdVr-dzRUruue0XEky_6fCt+v3AHp3G+Zv_N7S2_TpC7yg@mail.gmail.com>
Subject: Re: [PATCH] pmdomain: core: Fix detach procedure for virtual devices
 in genpd
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Ulf Hansson <ulfh@kernel.org>, linux-pm@vger.kernel.org, 
	Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>, 
	Marek Vasut <marek.vasut@mailbox.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238510-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[linux-m68k.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@linux-m68k.org,stable@vger.kernel.org];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,linux-m68k.org:email,mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,glider.be:email]
X-Rspamd-Queue-Id: 2D6A941E027
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Ulf,

On Fri, 17 Apr 2026 at 13:13, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> If a device is attached to a PM domain through genpd_dev_pm_attach_by_id(),
> genpd calls pm_runtime_enable() for the corresponding virtual device that
> it registers. While this avoids boilerplate code in drivers, there is no
> corresponding call to pm_runtime_disable() in genpd_dev_pm_detach().
>
> This means these virtual devices are typically detached from its genpd,
> while runtime PM remains enabled for them, which is not how things are
> designed to work. In worst cases it may lead to critical errors, like a
> NULL pointer dereference bug in genpd_runtime_suspend(), which was recently
> reported. For another case, we may end up keeping an unnecessary vote for a
> performance state for the device.
>
> To fix these problems, let's add this missing call to pm_runtime_disable()
> in genpd_dev_pm_detach().
>
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Fixes: 3c095f32a92b ("PM / Domains: Add support for multi PM domains per device to genpd")
> Cc: stable@vger.kernel.org
> Closes: https://lore.kernel.org/all/CAMuHMdWapT40hV3c+CSBqFOW05aWcV1a6v_NiJYgoYi0i9_PDQ@mail.gmail.com/
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Thanks for your patch!

This survived more than 160000 bind/unbind attempts[1] on R-Car M3-W
and M3-N, so
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> --- a/drivers/pmdomain/core.c
> +++ b/drivers/pmdomain/core.c
> @@ -3089,6 +3089,7 @@ static const struct bus_type genpd_bus_type = {
>  static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>  {
>         struct generic_pm_domain *pd;
> +       bool is_virt_dev;
>         unsigned int i;
>         int ret = 0;
>
> @@ -3098,6 +3099,13 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)
>
>         dev_dbg(dev, "removing from PM domain %s\n", pd->name);
>
> +       /* Check if the device was created by genpd at attach. */
> +       is_virt_dev = dev->bus == &genpd_bus_type;
> +
> +       /* Disable runtime PM if we enabled it at attach. */
> +       if (is_virt_dev)
> +               pm_runtime_disable(dev);
> +
>         /* Drop the default performance state */
>         if (dev_gpd_data(dev)->default_pstate) {
>                 dev_pm_genpd_set_performance_state(dev, 0);
> @@ -3123,7 +3131,7 @@ static void genpd_dev_pm_detach(struct device *dev, bool power_off)

Above, out of context, there is an error return.
Should we call pm_runtime_enable() again, to keep the reference count
balanced? Or can we just ignore this? It's probably futile anyway.

>         genpd_queue_power_off_work(pd);
>
>         /* Unregister the device if it was created by genpd. */
> -       if (dev->bus == &genpd_bus_type)
> +       if (is_virt_dev)
>                 device_unregister(dev);
>  }
>
> --
> 2.43.0
>

[1] https://lore.kernel.org/15510cee649959281d9554965cacd0c06531c1f3.1773308898.git.geert+renesas@glider.be/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

