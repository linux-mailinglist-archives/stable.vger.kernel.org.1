Return-Path: <stable+bounces-217774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKeOABFhnGntFQQAu9opvQ
	(envelope-from <stable+bounces-217774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 15:15:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA51177E2F
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 15:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26C6D30AE09C
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 14:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BC8281358;
	Mon, 23 Feb 2026 14:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ay9uNtRW"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50D4281503
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 14:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771856026; cv=pass; b=g3+x+4U2HtQ/8m1unC1ygMI+5ppK2wIqeo1BgJeVDwNmyh7McfEQYHmXkp8B5JdtHNBe19j81+pdM7CtRGEAltB+hpLmJvslPpkuXktTFO+fY2DJ7/O/7Nct5BNm0oLD7V1E2WE2Ihhjw7s0DI+f1fylaTyfRCTTAh3u9y4IjNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771856026; c=relaxed/simple;
	bh=4KkXfb0hX48GWnAgt+Gf2q0dnfvPe2syfroDOciYpG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNOhq+20NFw0KMR9PzwAR9E2MMJ015+m1IFEf2AfUELbz9cbuOX8gj9G8y8ekla0PvBOALy7mRXP2np10A1/rvnXxYTlnzCy/SSL1OVqSLzyJtqM1AHdnb+V7k1o43Awq72Rn6lDfywDsbsKQ938brm1IM/46INkNwTiyAxSmME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ay9uNtRW; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59e4a04f059so5622338e87.2
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 06:13:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771856023; cv=none;
        d=google.com; s=arc-20240605;
        b=iQIbyy5n/MmuRVFa6ixwythsO+MwL+FCyol0JghYwbiFv4mK6BeMRSi+Ge+nfncSEq
         IWHNIzFpys6wzv1rwX7C97dJuX8XfvPpknW740fG7daWtLu4djXLEV0E8Mxq9iCUJfEH
         fgTYIjoo4TtCBjt7yiIurBXaY8D4tEwwizHF+yKi18QpmRcJ8ALaAoDuiTNPDB9gmcgH
         eHD6f/vF+wUTlexuzPU8Nrx7hw9sj1K8VNFILtEWVpKNTV661tARCLb6xP5K6JBOceGv
         l/6R3HeSUgkhEC1BUI5udCKXZiseCs2rn9uADlw/tixR9OSnJklr+mdlC46JpvzQ0KEx
         o8zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ZSkS4xSTQDd/nSKVQ38rSQfj2WvDl93Pr4Jl1qJpA/E=;
        fh=xckTzEE5/pf47A2MZaKTrtlKQcUFSE4DF7wddvAamKw=;
        b=PBWKCASVxMJzZPAB5vh+I5QU1gHEl3J5TkxWRdjEt3uMacsrXQJe2MtXKV11AR25Ta
         OmAcOTLIfjJSvFrFxwS4ieWDahAssc+d8hvmmfz7P0r19HlJ5jglKgpDtXyNWOjwYKQ3
         OWXJnL9lQWKGx/+QlGRbHtHxhAqC/hcH1g1j+sjiaQzJcWN7zPq59HRU3T3ZDniXvZrt
         LXWRMBXK4iwazvrUgsju0osMbBc+QaGjAqWYvUJxTVyILuvpBvEujoGBDtDO3hbf9QwL
         ULF667qqbjKGzXxIXdi8Nat90a2AlWgddSM1YAbSo1Jv3bPdMvsYb94ofab3X+UUuypt
         YNgw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1771856023; x=1772460823; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZSkS4xSTQDd/nSKVQ38rSQfj2WvDl93Pr4Jl1qJpA/E=;
        b=ay9uNtRWfsroWDhWra3P/fVC3FaHx730i8NDjSneTGNlcz0AmiYYki7kSPVRA+iSMS
         q7VYS9GwzcTsMe22o2kjSsQgtD1DgVGyyINLNbDs7HHJWOEKWqwvukKa3lv8e+H0wk3T
         b53y5tsQzrHeW0yrTp01uztImjyOC7wKbJLWeAj6fAD27c784Nw0D0AtrNBhDjTy6+Fa
         EQgz8eTiHIRR1y23rpTpwc8Jl+OHyPHFv7a7V3Q+Mv9Gaw9kfon+3pLbFpYIHh7ljCE8
         cMEKg5eRt1B3dYX8KOttPYkGV9pVNvw1/zLaPNhwjT60IMq5M1Uy71vucP1d1/jB4eWb
         cfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771856023; x=1772460823;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZSkS4xSTQDd/nSKVQ38rSQfj2WvDl93Pr4Jl1qJpA/E=;
        b=MpuOuyN9Z63kprKvJExP71odhqbR79QY5Om/uIwJHeNwhON1j8R3qKLxpc7XTnCP+1
         1UUf1nSnxXmuCRwT6nEb8w9SE+kHDP9O0kVbIlFK5JevZoAEoxJcilfTybqctD7LjYve
         kfCP89ia5HDXgJEVLTUUbBxpyBXcWHmqvHO/BsBuT+aBJrfYF5fdd4lWEEHzOblRSxaR
         HcE5XtNCI/pdwZdGz0cWTGmAWfJRFmBLTPCEyQmWCKdYNVpKjosqY/85KQdKqGBBUO1W
         0d7Q0h9THgpm6CvdGsXDeix0a+vMiu76wJRhBsiqcLqJnXjKQxxFqitQhD8dYNJ1VR54
         Bv6g==
X-Forwarded-Encrypted: i=1; AJvYcCUh+NPtuI96lXKwPwO4T66crRfHBuwH/sOgZTE0tdY8r2pcTudNirNhzc2ZxUSxfy44CDLxfXQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL4p0fceEeIbm1YPGUOrBmE0gsJy7t1QgXTKxy8+jp1aGyK/FK
	7KXhyFQj/n7pLZIvbX+pRxxRnS9YZi5wCv8j7abQqvUFI4JWebt1dgHq75V1Pztmz3ZYC9W8mmb
	LUzr/Mjw1bkq4yF2T1ZmS7ykRA4RC22etZQbMPRJIlQ==
X-Gm-Gg: AZuq6aLhxhI7zwKPKtvJLbFxwGwzxmYq1K9Rxpd4d3S2BY/FAbpRjD7LzoNggicsk5V
	YyhHBIuWjXaznhRads2C1lS34fVrq12koSDtmS8+R7S8wrB+S6LKsOVlaoLFzlVKSyOX/x1T/nZ
	02ThIX4NsuiPo2Yz2xspMaFkhDVrHnphXqYB6FNkZ0xbtvqcyPQV4w3BmtIxgHkJFMogboEV2+i
	RomjruFWpXiw6pfVmJ0yUzAeZ7sIlKOzZRMnfBWwsnHrxWqIoez4b/pDJ5C3nLxlD4QH8q4hBnt
	L+JB9N6w
X-Received: by 2002:a05:6512:63ce:20b0:5a0:ee55:3dbd with SMTP id
 2adb3069b0e04-5a0ee553e23mr1810374e87.9.1771856022895; Mon, 23 Feb 2026
 06:13:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115214648.168365-1-pgeng@nvidia.com> <20260219202954.937508-1-pgeng@nvidia.com>
In-Reply-To: <20260219202954.937508-1-pgeng@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 23 Feb 2026 15:13:05 +0100
X-Gm-Features: AaiRm52TCuoishBZCXeYAUbucX7Og7doxnsYuSPgLiLI9z3JRm4io_MyXU9Dlak
Message-ID: <CAPDyKFpw0Qe0doJ_H0E++4+OtGR0xBCqMDxZ_FHvTLPk1-AK-w@mail.gmail.com>
Subject: Re: [PATCH mmc v2] mmc: core: Avoid bitfield RMW for claim/retune flags
To: Penghe Geng <pgeng@nvidia.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217774-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,nvidia.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linaro.org:dkim]
X-Rspamd-Queue-Id: 4CA51177E2F
X-Rspamd-Action: no action

On Thu, 19 Feb 2026 at 21:31, Penghe Geng <pgeng@nvidia.com> wrote:
>
> Move claimed and retune control flags out of the bitfield word to
> avoid unrelated RMW side effects in asynchronous contexts.
>
> The host->claimed bit shared a word with retune flags. Writes to claimed
> in __mmc_claim_host() or retune_now in mmc_mq_queue_rq() can overwrite
> other bits when concurrent updates happen in other contexts, triggering
> spurious WARN_ON(!host->claimed). Convert claimed, can_retune,
> retune_now and retune_paused to bool to remove shared-word coupling.
>
> Fixes: 6c0cedd1ef952 ("mmc: core: Introduce host claiming by context")
> Fixes: 1e8e55b67030c ("mmc: block: Add CQE support")
> Cc: stable@vger.kernel.org
> Suggested-by: Adrian Hunter <adrian.hunter@intel.com>
> Signed-off-by: Penghe Geng <pgeng@nvidia.com>

Applied for fixes, thanks!

Kind regards
Uffe


> ---
>  include/linux/mmc/host.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index e0e2c265e5d1..ba84f02c2a10 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -486,14 +486,12 @@ struct mmc_host {
>
>         struct mmc_ios          ios;            /* current io bus settings */
>
> +       bool                    claimed;        /* host exclusively claimed */
> +
>         /* group bitfields together to minimize padding */
>         unsigned int            use_spi_crc:1;
> -       unsigned int            claimed:1;      /* host exclusively claimed */
>         unsigned int            doing_init_tune:1; /* initial tuning in progress */
> -       unsigned int            can_retune:1;   /* re-tuning can be used */
>         unsigned int            doing_retune:1; /* re-tuning in progress */
> -       unsigned int            retune_now:1;   /* do re-tuning at next req */
> -       unsigned int            retune_paused:1; /* re-tuning is temporarily disabled */
>         unsigned int            retune_crc_disable:1; /* don't trigger retune upon crc */
>         unsigned int            can_dma_map_merge:1; /* merging can be used */
>         unsigned int            vqmmc_enabled:1; /* vqmmc regulator is enabled */
> @@ -508,6 +506,9 @@ struct mmc_host {
>         int                     rescan_disable; /* disable card detection */
>         int                     rescan_entered; /* used with nonremovable devices */
>
> +       bool                    can_retune;     /* re-tuning can be used */
> +       bool                    retune_now;     /* do re-tuning at next req */
> +       bool                    retune_paused;  /* re-tuning is temporarily disabled */
>         int                     need_retune;    /* re-tuning is needed */
>         int                     hold_retune;    /* hold off re-tuning */
>         unsigned int            retune_period;  /* re-tuning period in secs */
> --
> 2.43.0
>
>

