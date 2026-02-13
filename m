Return-Path: <stable+bounces-216046-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHLGGh4Cj2kmHQEAu9opvQ
	(envelope-from <stable+bounces-216046-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 11:51:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAC4E135415
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 11:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A5F230547E9
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 10:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF5225A34;
	Fri, 13 Feb 2026 10:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4h4rVJK5"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831573B1BD
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770979867; cv=pass; b=DYH2YhGjKQQjlBQDKkYju0V/LbV6vMiRqHr5KcZ7NcyuY/8VrNKJWHyVmMoHAZqbl0b3+Guv2wB4jsa7yNGMzjLgO5YFs6DQvUUj0erITizy69mgoHq9AscwxkMmVg7hVyEHDfyUml2wnEy0WTY6WrDndPI7MhUrQIjztEEFx3Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770979867; c=relaxed/simple;
	bh=Et5jRAvnWujdT4NJpgwhGo8qHa9vdaYx/uBOpVvBCH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B8Hnpqb/isjujaB1rzm5wJSNkcv9MVMbS9zRbSwj3yZR2p+3pulBgFlQsNn2Pt/b2WJM+HrwxjB/tJenaKo+mJ47zqY1g1Egq3X5CYw+/rAbfOdyjdbVKcpVSTnGKErZEZOLzvm7zunXy4deXbm2JG1IniReWJ0XxR7seeYho5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4h4rVJK5; arc=pass smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-124a95e592fso538069c88.0
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 02:51:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770979865; cv=none;
        d=google.com; s=arc-20240605;
        b=OKO1Binc2LWAkp05Q0iwVkpJ9UTLkQWh0BizpZhB0K/fk6kXDrIg2VeYFKqVvKUe6P
         eLRWn44lIRKLbkSDDvfc7/b72D168XcUwzlkajPX+8OBk/W5x+L5Tj4/7885S8CfgLJ+
         sm7PsxIGYDEtx6ElJwM4Nloq7bidcSYdUA7a3+T0a8Ar7ydkvTzFzF9ao93t+7Yjtk6b
         4maA8qZRW4ujkVcRdAHOZugm51gVMBwjbpTc5ppA3yQlUqLqRj+3hNimYnqizY5X1hIK
         RnfClB5Dm/nOh4Q1JGo4tdyeAW2t33LI07cJ3awCuiUcXZ+867F75lp3mwBlKcuUoDQH
         nD9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=H2yjc4HwnZnDfH81aOY9V+Nb7nZlWZ+t7zlqHmmWMvI=;
        fh=nxsmo+TaG0OmWWApLzL9TFB6KH0raDCGBOqJ3SfCXFg=;
        b=fpcgp7LRlh5NU4Lzaa8e1gzxuS1ySBJqY4Eb+keLA/jJ2THEZPFFkyRTk+EIg8FRcp
         E4TuGVyW4Ww4mHCYy1WIUN4WQl1thUJ4U9LHj2XVjJy1eg2TPNNia0954nVqPnh08lWq
         xtMPypolhNs+n2UVjdA/usYQq6oSnfHtE/W1xc//OFmsFnpe5Ph9Rv8rfT97R5suY8Bb
         K5EyCBYaEaHf5efq01LEPVwlLElZ0o9DPyLc7XhHGn3/hZEyK6KpNAx+kA2T09F2xOeg
         DFO/FiTRtF52l4I2PKqClzxYBoKbKyEYpMOdW3q0kYoKWyCvSM562i69lnTL6bVckHth
         LIGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770979865; x=1771584665; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H2yjc4HwnZnDfH81aOY9V+Nb7nZlWZ+t7zlqHmmWMvI=;
        b=4h4rVJK5fzqZkHjyWYSIbhJYZBpaBEFJ0GumZGMXwgLTHljHFH+JswVfN1SWYevrxe
         Ao4GiZdPwjfjCWWul9+q+gYy74PcMm2oZZwclKwlTPV4tpY1aJqNvBKqGA5Au/DcTuUK
         vxlbfiag0KvTEe6a8N3/bR4OhSsSZBJn7hcd5j8l+ON33LGBpNTYYxszX0TdIUaz/q+w
         JEkXiI5IxLHSDOfNQ5F4f//v5JGYM3hXZGy/BwxuPJaYSgPQKMiW1BXUs/lomsoVnPbm
         VHTF3gDGNfPO5FlihwDp726vjpp5COch2R9pRvG9GSIv5yEXhO21ZaPulgDxv1g+CCVE
         tlXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770979865; x=1771584665;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H2yjc4HwnZnDfH81aOY9V+Nb7nZlWZ+t7zlqHmmWMvI=;
        b=Vhr/0b30HV+iafh06xWXD2qAu5psJFA9v7F4iPTdZExe+EtyUzm8luzMEhpNNKbkLo
         DxG1s+NrPfStrjkekG0VcT5NtHz2z2PqzpIxxXEaA2SA5ukTroHzWYLk9Atj9MCl99jm
         b0jvNLcuTvTulE1XEM30iu2lMW0PRiQ2wyJvViobbVZWRhkUt/SQNchIu5Gjl9k5/Owv
         0O6p7vY7PpD3OPh2M0WnHxatXuTYFuz/AreMLMuDZkQV9nm8vP4b9LKN7mev56OCSZp2
         5DbTd95zs/Bag50PbQ/YKiWKe3wdLEAF6l+fudyGveAonYWW4vJpPk/jbXbjmtR5Poi8
         kkUg==
X-Forwarded-Encrypted: i=1; AJvYcCUUVQ4TcoejO3G0b2Hg1qX1/cTgyXUZ2klPXbhhItZ64QFFA6FyPF4xwqcU5LjNqs4MOozhyR8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwmH+JRwd9ciQ/RgS/H/UAM14Mdrw+lHECVxSIWyBMBB5a6iynd
	z9AD58hMq9+fUnswuTEkgJtba5eNbomqrvoktRNMJsDR/4HmZhW/WQjX8nE1b7k4hOeCMNRP8Yv
	Un9xYVDIeDMVvHjPMSA9xy1gikBydZxwh+qSx+VJC
X-Gm-Gg: AZuq6aLqxvGCO9Lzm1oSgde0SK0qnxc7MwYFg7rp0YYR84aMYQGlTAkzO3xXrcW/Air
	KF+9XCwdjoxmX8Q41dW4j176HPk+AgF32mQ/WT2vZOhGYTkg/IbWe5sPlFie0yjkVMMw4p4sk9+
	er/aU+C+Ky183Bmo6kcbcF9taqWJ8cl6ByDZP7lTiKBniHUWlMxoE1HeX36aObFprguwb89eqPN
	NGDLgSLdzrjXad5ifo1OTFu/vO6uYIl47D0Ye5vTK6EqELzJvvn+nY/HmDco4gG3HwkwgS6k6RI
	VjAccG2HD/8Vjz8b2ZkwH2lkAvHTiDT2EHn7ckGw/DuEA2vqwg==
X-Received: by 2002:a05:7022:403:b0:119:e569:fbb2 with SMTP id
 a92af1059eb24-1273ae47f17mr592920c88.33.1770979865034; Fri, 13 Feb 2026
 02:51:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260213095410.1862978-1-glider@google.com>
In-Reply-To: <20260213095410.1862978-1-glider@google.com>
From: Marco Elver <elver@google.com>
Date: Fri, 13 Feb 2026 11:50:28 +0100
X-Gm-Features: AZwV_Qj3kSyotLTHtMF94eaTev9fGUyX13rb1GtRDWyCVZcl4zIsPhmkTtg7Z6o
Message-ID: <CANpmjNPJV-aQKnQ7Mtr6e8_12UR3C2S3abJx_ePFWmS1WV_UVg@mail.gmail.com>
Subject: Re: [PATCH v1] mm/kfence: disable KFENCE upon KASAN HW tags enablement
To: Alexander Potapenko <glider@google.com>
Cc: akpm@linux-foundation.org, mark.rutland@arm.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, pimyn@google.com, 
	Andrey Konovalov <andreyknvl@gmail.com>, Andrey Ryabinin <ryabinin.a.a@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, 
	Ernesto Martinez Garcia <ernesto.martinezgarcia@tugraz.at>, Greg KH <gregkh@linuxfoundation.org>, 
	Kees Cook <kees@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216046-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,arm.com,kvack.org,vger.kernel.org,googlegroups.com,google.com,gmail.com,tugraz.at,linuxfoundation.org,kernel.org];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Queue-Id: BAC4E135415
X-Rspamd-Action: no action

On Fri, 13 Feb 2026 at 10:54, Alexander Potapenko <glider@google.com> wrote:
>
> KFENCE does not currently support KASAN hardware tags. As a result, the
> two features are incompatible when enabled simultaneously.
>
> Given that MTE provides deterministic protection and KFENCE is a
> sampling-based debugging tool, prioritize the stronger hardware
> protections. Disable KFENCE initialization and free the pre-allocated
> pool if KASAN hardware tags are detected to ensure the system maintains
> the security guarantees provided by MTE.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Cc: Ernesto Martinez Garcia <ernesto.martinezgarcia@tugraz.at>
> Cc: Greg KH <gregkh@linuxfoundation.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: <stable@vger.kernel.org>
> Fixes: 0ce20dd84089 ("mm: add Kernel Electric-Fence infrastructure")
> Suggested-by: Marco Elver <elver@google.com>
> Signed-off-by: Alexander Potapenko <glider@google.com>

Reviewed-by: Marco Elver <elver@google.com>

Just double-checking this is explicitly ok: If this is being skipped
enablement at boot, a user is still free to do 'echo 123 >
/sys/module/kfence/parameters/sample_interval' to re-enable KFENCE? In
my opinion, this should be allowed.

Thanks!

> ---
>  mm/kfence/core.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/mm/kfence/core.c b/mm/kfence/core.c
> index 4f79ec7207525..71f87072baf9b 100644
> --- a/mm/kfence/core.c
> +++ b/mm/kfence/core.c
> @@ -13,6 +13,7 @@
>  #include <linux/hash.h>
>  #include <linux/irq_work.h>
>  #include <linux/jhash.h>
> +#include <linux/kasan-enabled.h>
>  #include <linux/kcsan-checks.h>
>  #include <linux/kfence.h>
>  #include <linux/kmemleak.h>
> @@ -911,6 +912,20 @@ void __init kfence_alloc_pool_and_metadata(void)
>         if (!kfence_sample_interval)
>                 return;
>
> +       /*
> +        * If KASAN hardware tags are enabled, disable KFENCE, because it
> +        * does not support MTE yet.
> +        */
> +       if (kasan_hw_tags_enabled()) {
> +               pr_info("disabled as KASAN HW tags are enabled\n");
> +               if (__kfence_pool) {
> +                       memblock_free(__kfence_pool, KFENCE_POOL_SIZE);
> +                       __kfence_pool = NULL;
> +               }
> +               kfence_sample_interval = 0;
> +               return;
> +       }
> +
>         /*
>          * If the pool has already been initialized by arch, there is no need to
>          * re-allocate the memory pool.
> --
> 2.53.0.273.g2a3d683680-goog
>

