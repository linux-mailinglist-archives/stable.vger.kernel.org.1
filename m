Return-Path: <stable+bounces-240572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOrhAnIl62muJAAAu9opvQ
	(envelope-from <stable+bounces-240572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:10:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F98645B3AB
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 10:10:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E98DC300F9D7
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 08:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB89E37A488;
	Fri, 24 Apr 2026 08:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BfX1Ocin"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC0236F428
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 08:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777018164; cv=pass; b=iuGYzhj8xCWok0rtxMJVsmqZDja3W/qDjaPElqk8n2dsLQi8fElAZUlB0Ol8XU8qXeXRwtUB4s9XDv98Z6Bel1o3uyG4+ku0HblxI/LxGP6EoxsYd72lJs33ppgEBWDJRmdbhYMFqreX8ofgRTnvUOHMM+dTZbpWTkN2OVoUDe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777018164; c=relaxed/simple;
	bh=3usI+Q5AtxazijEKMNHYqXEzc1ozu2x9IcSk29s9eus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YA4IrQ5Yv2Lqe3Z73HisO8GIlk7cQyznLN3Zbp6YmG0qFn00mnmbZLRLBIgjj9zYvCS20faCKyFOsemRkdpZgvhJJsUEzUvl/NaexgkN5DgU8e7nYbiWtqw4DwhNY3g/huomsqghT7h4dxAsbwi4yF6oXJXNSjF+uorceFIf4mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BfX1Ocin; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6501d242e2fso6917769d50.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 01:09:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777018162; cv=none;
        d=google.com; s=arc-20240605;
        b=QLu3jsRa4eGJLWQfCQQM+CIhphMFsZ1bztz2qjdRA+UWntNQz0wU6VYmV9i4saySNs
         G/mPgvbmqfLYf61R0WaQ8cHHl/r7fjXAFoUpP7zg0vFR+mfBr4Fx6fWhM5Qa0nxCiIc7
         ViCM078MszvQsbYG7PBP0PpdmytFHoF9CrC4AzeoDB8apqLtbzlNGvnP2oRwXyu82kDp
         fTZPhlA5f7XOXGsHxiLQ3CpK1z+E5e1GQ5FXaw3aDIUoejB6heF5YlrdG4WmmSY6i3ja
         ObCAk7dmU994IzoPzNKPU7iSEl9GROzadmhAbnIsU9BloNyGFznY1ZDoRAhXp7glVo0D
         Q14Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=gs6kw1rrmkhQeMDCmknebcC01WJk3kSBNjHvbwNJWho=;
        fh=4FFWrqhx5FST04PYrzJ+xnlcY2S8I4jnBYvV/Nsj2C0=;
        b=NCyf4VuT/TPE1Q+vanHGN/VBoV7gUhSd3ypoZtfAZcEh3IaWD5n0vXRaTKTuYDKo99
         nCTe+ci4DZwPD/kH86ZG9IMGx0qSNq+Sjv6EBEdbPDDOBo9oRiCdTF952gQl6g5Cmg+Z
         kyM+br/xK0NYEptOfFeM7PgATSSg7ZY7OFpQPUayqIM+e/knevd1y95WGSMp9F+As2L6
         fuYlrxzPOtIAB3PAtVZ89vmC2SJALXV4L+xaPysAazQUF9sh9zPi8rdM/r1BYmWCsHQy
         NzlXvHy2ty4Gks9Bi612+2khWLJl08kW8JgPBUWvm96gbqMlwVqJJeHFkpAoEo/UUIuL
         VAgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777018162; x=1777622962; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gs6kw1rrmkhQeMDCmknebcC01WJk3kSBNjHvbwNJWho=;
        b=BfX1Ocin5Bjjh1ywueLepLjqR3ri1rAaa30YR/4YdpiqLyg8M/4GKZ4W6+f0bXQWsy
         I7pcnaW+Sa0PW7nJedAj2n32o9ohLHEtvGbGB0QCKfm5bmNTo9yRtg/KWhCUggLLqHSE
         GYC70A/jZdsCN9YTtDE9S2d+NDVd82/G+ZYDba8TR3kYdg3l1P90N3Nc4E1PmdKxJwoX
         KWZMazJCKx0+5NX4HbgsmZJzcKgWGB99TMDI46vm5WqhkogqgTKIEZ632V3S8GX/Xlis
         VSZhQgHnQwTwC1ERYOJrbSf3iocMWN/lJ6MJfeO+AwFVzLjzxjqkD9KrB6Ojjyafvqgq
         yTDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777018162; x=1777622962;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gs6kw1rrmkhQeMDCmknebcC01WJk3kSBNjHvbwNJWho=;
        b=AjBrp5pR7VXw4KG4jFNWiNUojb/cZ+mbF60pucdSROLO1boEO5GqASaKXT/rFktvpR
         EUwubY52gOc21l5U2hc0nxaGngS2Qzq1jTjP5nTL04okTgq4TLjfIW3eYOwCQfB2dAiG
         OUBLDAGgeNEsfitn7LZkifEgAHbkXdz4j2cCmLAgBzEDtEhp/SbHW6+sTUSQg+5zELyq
         zJd3vkzOKRUKpFw+O3MVRLJzgFVUAZpLptStMQwZEz/cQbZieeailohV4zFBlle1gyQz
         rJlF6iKtfAZda1XXZyWY7Ton4hkK7HxDN3DGPBir0WDTb/bjbIQNoX4MIWOPZ2Q591Yf
         GHVA==
X-Gm-Message-State: AOJu0YyCpvcK9Mj1D9mXoVxRblcDjjSCrUpfWh8i1hTKhYoayDE7jpcU
	s5nzlnxKKJUZzBNbu2T5sR/On+Yqdio/xutmggb1WS74PbvHSdJr8O4TQzNAk3Nd75qAVYmZlUz
	6SVIF+cdBeDaLDvbkfzzjVV67swopxJo=
X-Gm-Gg: AeBDiev59J8vUpb3Af80uaE39LhfnF7gN1GdAXvoC0GwOBd3zwLRY/18+N7V1/cK1Pj
	BP7Zhnk4JEvt7udRmZxX1zNKB33xItfWBWlANvSRuehtmGHjbAgsfiu+hCWttpcUz9ZrnKrspdc
	2Ajdb0ugjglijlSm/hvmP87SKNRSuque5IY5Tg1WhZmwa7fdMl23TZ/smahGt1fbBl882/nH8Fb
	aAFxcQfx5Jo8PPl7NZPACHoiUpPf5Yz8IhdUQYjtcCPmYP8KlLfGJZ8N0BbH9YV43mTTAI8qdbO
	IIvikwC4yN6ystu8Pjo6
X-Received: by 2002:a53:d00a:0:b0:650:30be:e186 with SMTP id
 956f58d0204a3-65310afe342mr22497616d50.64.1777018162252; Fri, 24 Apr 2026
 01:09:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260413160829.3072589-1-lgs201920130244@gmail.com>
In-Reply-To: <20260413160829.3072589-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 24 Apr 2026 16:09:07 +0800
X-Gm-Features: AQROBzAnZT5yBA6RuVkTgQARgTe-E9k6EKsFEntXkb5LJTquT1ykVXxDWMJcPGo
Message-ID: <CANUHTR_rUR3n_-doE=1UV3UagYMUAuJc4FwBRhA3=CiFQOgFeg@mail.gmail.com>
Subject: Re: [PATCH] gpio: omap: fix reference leak on platform_device_register()
 failure
To: Guangshuo Li <lgs201920130244@gmail.com>, linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 6F98645B3AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240572-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hi,

Please disregard this patch.

On Tue, 14 Apr 2026 at 00:08, Guangshuo Li <lgs201920130244@gmail.com> wrote:
>
> omap_mpuio_init() ignores the return value of
> platform_device_register(&omap_mpuio_device).
>
> The call flow is:
>
>   omap_mpuio_init()
>     -> platform_device_register(&omap_mpuio_device)
>          -> device_initialize(&omap_mpuio_device.dev)
>          -> platform_device_add(&omap_mpuio_device)
>
> If platform_device_add() fails, omap_mpuio_init() continues without
> dropping the device reference acquired by device_initialize(), leading
> to a reference leak.
>
> The issue was identified by a static analysis tool I developed and
> confirmed by manual review. Fix this by calling platform_device_put()
> when platform_device_register() fails.
>
> Fixes: 730e5ebff40c8 ("gpio: omap: do not register driver in probe()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/gpio/gpio-omap.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpio/gpio-omap.c b/drivers/gpio/gpio-omap.c
> index e39723b5901b..841bef431c22 100644
> --- a/drivers/gpio/gpio-omap.c
> +++ b/drivers/gpio/gpio-omap.c
> @@ -800,11 +800,15 @@ static struct platform_device omap_mpuio_device = {
>  static inline void omap_mpuio_init(struct gpio_bank *bank)
>  {
>         static bool registered;
> +       int ret;
>
>         platform_set_drvdata(&omap_mpuio_device, bank);
>         if (!registered) {
> -               (void)platform_device_register(&omap_mpuio_device);
> -               registered = true;
> +               ret = platform_device_register(&omap_mpuio_device);
> +               if (ret)
> +                       platform_device_put(&omap_mpuio_device);
> +               else
> +                       registered = true;
>         }
>  }
>
> --
> 2.43.0
>

After re-checking it, omap_mpuio_device is a static platform_device and
it does not provide a dev.release callback. Therefore calling
platform_device_put() on the platform_device_register() failure path is
not appropriate here and can trigger the missing release callback warning.

This falls into the same static platform_device pattern pointed out in
the other reviews, so I will drop this patch.

Sorry for the noise.

Best regards,
Guangshuo Li

