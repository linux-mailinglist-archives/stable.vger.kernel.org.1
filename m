Return-Path: <stable+bounces-256586-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGrcMpdnGWpHwQgAu9opvQ
	(envelope-from <stable+bounces-256586-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:16:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 713B4600A98
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:16:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 111F3307F4B2
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:14:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6BC43403E3;
	Fri, 29 May 2026 10:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbrbNQlI"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 906A220D4FF
	for <stable@vger.kernel.org>; Fri, 29 May 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049646; cv=pass; b=lcV3YvFblazmrOjzMLvBQVicJK1PhnOebTHTHeNkOQYZ3IkZjbdN7gHAJ+TeQF56XQhTO42qRZ60/EM4h7awbeD/tPhilH1qkCDY/e4uE0gQwVxSCsI4pveUYVXTMZhmAgUDA9ZLpKV7mm2bTWtqPQ1aUFI8dq4dAi3C3BV6xDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049646; c=relaxed/simple;
	bh=0dD/nw52uv7ETKPy7YO7Bra4Ckt+WV0LXq7SjVdjcxw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hRP6ZSMtGukcWs/6C7fsctVaq9fd7J/lrWdDi1b4d9Vr1dRHQMchTEJ7AfEjkWG0R93d16D9NUrf7V+DqzW1NOC+019I6qY1xkIUU4oxl6qZ4d2qX7q60UUVZD7Q2u7H3JsRyHkFqEAr+ehW+/vC0tgTlxCGwisQWub45ue7mMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbrbNQlI; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-68852b58d87so6635675a12.3
        for <stable@vger.kernel.org>; Fri, 29 May 2026 03:14:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780049643; cv=none;
        d=google.com; s=arc-20240605;
        b=G9cCMKxm87g4Na+50a0CPJwQ650h3Lx/blKaRTPI5nNeaOe4Dj7dDdXv4Y6SLy3RHV
         nZUgEZG2PTQMujMRYTGZC1wiPYa4urxw2WOIXFf8bpw/MLNq6yzIKD94Ky21eu4Ei/Vf
         Os+HR3by1Y/NvXjjK1DAYgJwD0cGce6/Tvna3z3NBRDFmSD4f3kS4KYauI00GqNwaoEL
         CPsGab49EMgXfGUA5knuMiCEWDtEl9fKgF9vrvT7VRT2OSjEbbrAgbPn1Or+RjUZ2wNT
         8JtiL7hG2j8iBR/VaSk600WVXM3r3ivT1h5LdVnG0+nDFSKHm5ZAdSVR6ms0UgXEKybH
         gLeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=69BdqBLDmhIiDSYfJNXDEk8EXbdstEZyFojS0b7qFu4=;
        fh=/6YJXk+qL/Q3r9NsSQccpC3XjWDhZ6tEx7OlONcQKKI=;
        b=XYFGTwbPij/W5dEF+pfW8zNkdGud9Szo8LY4QcgPzvNAioV8NSYaLE3zSGM3d4FhZz
         6OcU+I3d3IVFvr49ar5zYf1zC1kFhGsyni432TiQoxqE0qQ50ScYAQHofoe7s8lVHxT7
         GcpdCU48Ktx3Mz1xN6LYsm94T08w9VAo5x8Yeh8VPUGmLe6Cei1PdcLtNLU8u8advfVQ
         ux/Z3EjEOUNpc+BozbkgQyJDALFsIjFU04fOfx5CdyJbZI+Y/d7bcMAThLuuVs6QHRxD
         Qwzcpc61wRvYU+bVXvQ0YiTQZ8UulxsrJ3XHvAmMgkh8x0k+J1cDprjfednoUIiN48z+
         82xw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780049643; x=1780654443; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=69BdqBLDmhIiDSYfJNXDEk8EXbdstEZyFojS0b7qFu4=;
        b=kbrbNQlIgcR53VvFy8iH5uFik2UweDXFnhVCAijeXOAGF/pAd/9v6a830lkdzgclhr
         TIySLKEfJgI5aOjjFojTidFV8TzO5J4pJqXJMLzUazMk8CSeaCk+G91jfIYD+lCtIK0h
         leu2jF2acCij0uPddP5DQoynXCrJ+uPlk8rckqXJSQxC24NMfeXkEFuanoiyJMb3G1Fz
         PFQAUCEjXtP6OJ63ASAK9TInR6ASkrgW2NeGym/aspvRESbcn/Fuih//W3nx4yG6fE5u
         twWxYphTaLcdgg3QimEtdil1Vck/pWW++6WDT7MYOIkI6/P9w5KAe2WZeYTSrzWy7WxL
         tVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049643; x=1780654443;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=69BdqBLDmhIiDSYfJNXDEk8EXbdstEZyFojS0b7qFu4=;
        b=smSFlbX270tRlnG29pituLv0a8aahXfzwpdCiDuwHNMf/nUh8jPoLI7t3LmXVEp2bm
         vYt3FKfOrJhmykxqjTPcJKOTBWlYFL94qZxGGkj7y8IGQzJrtAZUMWQ+nn4oKwNh3IBB
         SUoGdrTQYUyKYxiXnNDPcDoQs4Rp/RuAqIR5/rG8giIDZ0O6kMBxaTyGltabaQdOjDJZ
         yewh9hGLPXGuU9oZl22HK1THmnzVj6/Tcy1bJGNKCfD0pr6mKV3q/RIS1I+HXvGZ5H8y
         uyu5Kvbqh8ADUPdLMKjl56yufdilKxPpmCmwDTN7mQCGF7yg44cz/Aw2LhoHqtSxQc8k
         FJuA==
X-Forwarded-Encrypted: i=1; AFNElJ/EwGweoik5FztG3/skkDZv5U1Y73bBO8Bo8TOD+LC5gRVmumowYZMYnOnXyoDdaZ1eO+L/Lj8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6c2M5MNCVM6tr8aEDdfozr7KopQ+hWE+g9XkScaegLNPDFtq/
	P+77UzJbT4R/BlJ44xlTt2/JeBH1MgOaXS5PL+tVhLjsoiyeI/vv8Uq5IEpTMKWR37C1KXdtVAI
	zcEUQqZy/agJbxplZ4Xs5jtZrZBT0XJs=
X-Gm-Gg: Acq92OFyg/HS0SgzPpzAS6vflvITHMaU66QdE7Bmp08Ps6Nl/1t51X6zXuWeO2e08ob
	2OB6/a2KVyVyj6KX3AC8w2XQP0j32FYVeOx3lWPO6LR4Y9XPuJDMjAdlqb6Zz4jUQMUF8hgL8rN
	VZNiSCPgyWIBmy5sbYytI+s+WQU9zLtVuEfQAOQc/Hz2jOeEr+AT51bioZzYbOP5/41rPHyyErh
	HFl7+YrWKbD1nvYuq8qIzQ9WqNt7tbRIK8yR25YBY65Vp8Jq1VqeXYc/ds+FC0XNLqQ/wy0CTdy
	6Qtmy4JxSJHAsQlheXtydoDB8Vba9Eg67UVyYd8OcE+b6NWKSjc=
X-Received: by 2002:a05:6402:35c9:b0:68c:3424:af6c with SMTP id
 4fb4d7f45d1cf-68c3424d067mr577735a12.20.1780049642708; Fri, 29 May 2026
 03:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528230516.1839694-1-mattst88@gmail.com>
In-Reply-To: <20260528230516.1839694-1-mattst88@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 29 May 2026 12:13:51 +0200
X-Gm-Features: AVHnY4LJos2DFZs2mjihnMFxNiH4VI34ou3aJZYmyVpQIKCcpB_0uPqxUmIm0Eo
Message-ID: <CA+=Fv5TcVgZQZtYfSq=QPp3GkMkq7RhNWnJurSSWCogRU2q9TA@mail.gmail.com>
Subject: Re: [PATCH 1/2] alpha: marvel: Fix irq_set_status_flags to use
 correct IRQ number
To: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256586-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linmag7@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 713B4600A98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 1:05=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> Pass base + i to irq_set_status_flags() to match the IRQ number
> used in irq_set_chip_and_handler(). Previously, IRQ_LEVEL was set
> on the wrong (low-numbered) IRQ descriptors rather than the IO7
> IRQs at base + i.
>
> Cc: stable@vger.kernel.org
> Fixes: 08876fe8519c ("alpha: marvel: Convert irq_chip functions")
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/sys_marvel.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git ./arch/alpha/kernel/sys_marvel.c ./arch/alpha/kernel/sys_marve=
l.c
> index 1f99b03effc2..bebeea3c286d 100644
> --- ./arch/alpha/kernel/sys_marvel.c
> +++ ./arch/alpha/kernel/sys_marvel.c
> @@ -275,7 +275,7 @@ init_io7_irqs(struct io7 *io7,
>         /* Set up the lsi irqs.  */
>         for (i =3D 0; i < 128; ++i) {
>                 irq_set_chip_and_handler(base + i, lsi_ops, handle_level_=
irq);
> -               irq_set_status_flags(i, IRQ_LEVEL);
> +               irq_set_status_flags(base + i, IRQ_LEVEL);
>         }
>
>         /* Disable the implemented irqs in hardware.  */
> @@ -289,7 +289,7 @@ init_io7_irqs(struct io7 *io7,
>         /* Set up the msi irqs.  */
>         for (i =3D 128; i < (128 + 512); ++i) {
>                 irq_set_chip_and_handler(base + i, msi_ops, handle_level_=
irq);
> -               irq_set_status_flags(i, IRQ_LEVEL);
> +               irq_set_status_flags(base + i, IRQ_LEVEL);
>         }
>
>         for (i =3D 0; i < 16; ++i)
> --
> 2.53.0
>

This looks correct to me. irq_set_status_flags() should use the same Linux
IRQ number as irq_set_chip_and_handler(), i.e. base + i, otherwise IRQ_LEVE=
L
is applied to the wrong low-numbered descriptors rather than the IO7 IRQs.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>

