Return-Path: <stable+bounces-256588-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Hw1GjhpGWpMwQgAu9opvQ
	(envelope-from <stable+bounces-256588-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:23:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04503600BF5
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A858A3061019
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 10:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F4133987F;
	Fri, 29 May 2026 10:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYVRzuet"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFDD81732
	for <stable@vger.kernel.org>; Fri, 29 May 2026 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049832; cv=pass; b=WSrq7FKKbudAg9sLaV8L6aYRQmuZDTdH9lh5fxwjXTByH18W1aot+YPLkfqVxvpaqzlYZejrpHiHpy8DtsagKI7/hL9ntZS9htu6MJwDMtQr6Rcf9qSQUPl9yaPiSYKtChBewxc5Jl0DNalPQ7+d1d5t/9kDDgE7SwOtU50GOSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049832; c=relaxed/simple;
	bh=oN19ZOQuE7WVi9huNyO9ICvw7+sfGs4Qu+L+afX5JN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tu9E6jpHYwGkFPNi56cfnfyNOfnL/fun/eSTJL9EWjXsprYRPkF8GZ2q0fmpY3ElWT0E1VnIs+a+afLZI27LJg3WTDCWMmsWps0pQEQY3KLD2k7iWNZe+CVroFs4aMGpPdn+/RSrsUCtjUasqfGS/S6L4mWAF79hPOxVQCP1GHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYVRzuet; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bd2e8931915so2722417966b.1
        for <stable@vger.kernel.org>; Fri, 29 May 2026 03:17:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780049829; cv=none;
        d=google.com; s=arc-20240605;
        b=JSSVKoNaI/EZyma0rbXVDSdmqa/MG8Ts2B5m9/J5wxCUtdPJ6I2UGCMAFu5oMGLC2W
         fvmt4JOWwUiMsqCTiObNN93Phn9MFmwqeJSLrBbSakjQoI31XuRMT0XvkjTftpAshjMN
         mvp0yyB36+/CcK+eQgNwkEZRUhEM7+dWHcB4yEGecn6Z/ez2hcg2+HhEaAtUYW1sd5dX
         D1NDQiqMm/aqciqqwJs6ViiloAdm/JLIH0u1GUrDkB0ybLpLoaBuxREiaBRLaiawbEAj
         LUN5VBfNQCpbmAPW+rB/aD27LGycsPg85RgqyNul2F+/RkvEWPI0+P9XC8wJpt8CLJSM
         x3XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1iJ9dA03FdMF2EGmhu6kHfMDm4N03M3/64bl9s5U4dc=;
        fh=MWFWtlRxEaBjIqdXZ+n5mKXui+agkn2wy40L6tiKGWE=;
        b=lTKYQL/4ocNmK7LzCKC96AWrW/xn4KpZ/fp/+4m2hASAoMWnj2QKDc+6QHnU54W2Pc
         bAm3cImG0I4BBUSNQ8qnWYcqzIxJo39icn4wgTGSs1NSV6ww0dQ4ir93Fueng57648W1
         HDN0Fsc5e9KY8QYd3NLpIhtgvhkMJMANpgP6KN5zZWcj8Z6pvsT6EoX4lrvckljmVcHg
         0WzzHLkhGNCeEowL3L0fzLNp1q2gGndmaAUxhveFhH1Gkpn0//WWsxpka9ctPX9Yt8ow
         vnlOmY6v6dIeiQ+2p/HHYUBK1knVD13xTkrENyFMDQaazh5EEeREoRpDoKicYlbcjlws
         Nq4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780049829; x=1780654629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1iJ9dA03FdMF2EGmhu6kHfMDm4N03M3/64bl9s5U4dc=;
        b=gYVRzuetgJTRBTT4BIY4OuvwCg7HU0TiWWqQ+6NyxMk/YN5fn40BPkzrd8d0Jrign4
         9suKRT6RSbawQ3kR0xPBQJ0Fo9fYA09EkQNGbR4gtg4NrD69WJzYJRuKHrbcdN3KCa8r
         +55IxtYvx2a3j56UPnMzhThh36fczX4xZJ9cGvGrRcU9E7yyTCrKopr67s+nhC9/88X6
         gf2PWk+9wSOEcCq/88H/CV0eI6FAcY4tMsc6GNgpEeaOCWqaNclJTUUtpWHaqhQwh+7o
         pnDURzrkJArquxDZ9w+EoAzOm08pXx8Xk8OHX1vBohY4bgCij9CENlHatI0IA1c2EKbn
         K7AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049829; x=1780654629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1iJ9dA03FdMF2EGmhu6kHfMDm4N03M3/64bl9s5U4dc=;
        b=r7K14m+b34r84GUYs7+cxqafiwH8cF+g059FGxyToSQfi+wIQoVMwhehcmj8qxem/V
         8i1qQ40Hby5WTUzwuDicDsq0GxfEL7RysxPYXcQPT1Ocx3cf48AEhSibO/6bKdBQwkbo
         d+GKNwnDa7nleX12Z904Eny54oOoQgyRqPpVpI6tEm+58rtXOtorAgrAV4h1l31pLgI5
         1rC+rNubQuIWgIHqlP81uQrTGqKcpVxfa5hmxA6768sznfIqUaRFjkvZBhGwd9rG+QYt
         P4sWLePmK704E6AE8ZR+jfGMz4hDBqgvAEw5oqDlJ6p7LIDxY1/JgyPZ7i877TJSK/jI
         p90Q==
X-Forwarded-Encrypted: i=1; AFNElJ+qtuW33mrkuDRhgHPjDKuFwFwzMw/9MuP4Nb2K7pK5lrHMlEw2KEEOI8rYCIfAlZk8ucIO2NY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU8lf10MyV092XR79tGiDihKKMX0rz1kGpsaDIKDbPm646D1wM
	te49xlLQzKSJaGaowD2ZAZWD+UIoOLKAG2eVqQvYjw4s24fqGm3fw6CZptzjDQaJi6r2ubf0NFP
	srjxdkHjacXZ0gKdHtXG/K+8lwR+xyakE82HDiAk=
X-Gm-Gg: Acq92OEBD1qCsl8sNetexWXESPys9ClO7+sGwiYhNrlpYdt0ZY5tAbtveeyjFyxB2wB
	U+uf8O6DAfHaHWDjtHSZX6i7FrR3kSSTpU7Mw/cGXkVb6/Yt/QfU/vPpFrVCPY6o0vRClAv4cLI
	ZhAwEiiBVjmIxc8GKlNpAREkFhgNzCXYWvhCr9LokOxJER2rZ3wBL+ChQa70TOz36Dt1PQgTSCU
	DvLzjoQDeeMllD2pM53WdbApcUFQ40R94tEGB1mvex7jlQmygP+pC16omAA+C+GkhqMWfqcNv7d
	TwQ5kdE8dnIoud7TS9KJZ3wxJHmJJ23w/2DZrWGJxDTksyk+3Pyj6pB+C+mt7A==
X-Received: by 2002:a17:906:fe07:b0:bdb:5c26:d499 with SMTP id
 a640c23a62f3a-be9a7fa80a6mr127001566b.22.1780049829213; Fri, 29 May 2026
 03:17:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260528230516.1839694-1-mattst88@gmail.com> <20260528230516.1839694-2-mattst88@gmail.com>
In-Reply-To: <20260528230516.1839694-2-mattst88@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Fri, 29 May 2026 12:16:56 +0200
X-Gm-Features: AVHnY4ImbLCMtDpPYGgCG8ujxIMUAyT9qcsj2ridFJBYG__Iuv1d0L9ULK_fPaY
Message-ID: <CA+=Fv5SisLyZRfemTxeTnXoh6-uRvVOsv5r3A=mcCjuvGzWfcQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] alpha: marvel: Fix lock ordering in init_io7_irqs()
To: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Richard Henderson <richard.henderson@linaro.org>, Thomas Gleixner <tglx@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256588-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 04503600BF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 1:05=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> Move irq_set_chip_and_handler() and irq_set_status_flags() calls
> outside the io7->irq_lock raw spinlock.  These functions take
> sparse_irq_lock, which is a mutex, and taking a sleeping lock while
> holding a raw spinlock is invalid.  The raw spinlock only needs to
> protect the hardware CSR accesses.
>
> This fixes the following lockdep splat during boot:
>
>   [ BUG: Invalid wait context ]
>   swapper/0/0 is trying to lock:
>   sparse_irq_lock{....}-{4:4}, at: irq_mark_irq
>   other info that might help us debug this:
>   context-{5:5}
>   1 lock held by swapper/0/0:
>    #0: &io7->irq_lock{....}-{2:2}, at: init_io7_irqs.constprop.0
>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  arch/alpha/kernel/sys_marvel.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git ./arch/alpha/kernel/sys_marvel.c ./arch/alpha/kernel/sys_marve=
l.c
> index bebeea3c286d..a37707e05e34 100644
> --- ./arch/alpha/kernel/sys_marvel.c
> +++ ./arch/alpha/kernel/sys_marvel.c
> @@ -263,6 +263,18 @@ init_io7_irqs(struct io7 *io7,
>          */
>         printk("  Interrupts reported to CPU at PE %u\n", boot_cpuid);
>
> +       /* Set up the lsi irqs.  */
> +       for (i =3D 0; i < 128; ++i) {
> +               irq_set_chip_and_handler(base + i, lsi_ops, handle_level_=
irq);
> +               irq_set_status_flags(base + i, IRQ_LEVEL);
> +       }
> +
> +       /* Set up the msi irqs.  */
> +       for (i =3D 128; i < (128 + 512); ++i) {
> +               irq_set_chip_and_handler(base + i, msi_ops, handle_level_=
irq);
> +               irq_set_status_flags(base + i, IRQ_LEVEL);
> +       }
> +
>         raw_spin_lock(&io7->irq_lock);
>
>         /* set up the error irqs */
> @@ -272,12 +284,6 @@ init_io7_irqs(struct io7 *io7,
>         io7_redirect_irq(io7, &io7->csrs->STV_CTL.csr, boot_cpuid);
>         io7_redirect_irq(io7, &io7->csrs->HEI_CTL.csr, boot_cpuid);
>
> -       /* Set up the lsi irqs.  */
> -       for (i =3D 0; i < 128; ++i) {
> -               irq_set_chip_and_handler(base + i, lsi_ops, handle_level_=
irq);
> -               irq_set_status_flags(base + i, IRQ_LEVEL);
> -       }
> -
>         /* Disable the implemented irqs in hardware.  */
>         for (i =3D 0; i < 0x60; ++i)
>                 init_one_io7_lsi(io7, i, boot_cpuid);
> @@ -285,13 +291,6 @@ init_io7_irqs(struct io7 *io7,
>         init_one_io7_lsi(io7, 0x74, boot_cpuid);
>         init_one_io7_lsi(io7, 0x75, boot_cpuid);
>
> -
> -       /* Set up the msi irqs.  */
> -       for (i =3D 128; i < (128 + 512); ++i) {
> -               irq_set_chip_and_handler(base + i, msi_ops, handle_level_=
irq);
> -               irq_set_status_flags(base + i, IRQ_LEVEL);
> -       }
> -
>         for (i =3D 0; i < 16; ++i)
>                 init_one_io7_msi(io7, i, boot_cpuid);
>
> --
> 2.53.0
>

With the preceding irq_set_status_flags(base + i, ...) fix applied, this
looks correct to me. The generic IRQ descriptor setup is moved outside
io7->irq_lock, while the raw spinlock still protects the IO7 hardware CSR
accesses. That matches the lockdep report and avoids taking sparse_irq_lock
from raw-spinlock context.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>

