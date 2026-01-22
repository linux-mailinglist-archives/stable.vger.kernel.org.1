Return-Path: <stable+bounces-211286-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oM2wDo9qcmnckQAAu9opvQ
	(envelope-from <stable+bounces-211286-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:21:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C98706C431
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 19:21:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04DD531D8564
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC11431355E;
	Thu, 22 Jan 2026 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R6M4j1h3"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1912367F56
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 17:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769103230; cv=pass; b=gHiwORa6worJ7cG3jz4YkZmY2unC4gqE413BplTBHfTxopqzuNIM/hjKetNJZud86IbbWRNhwe42Zzu5+zJJzK9973S+wiiqzlDF99MU/JbtFGiXQTiXirJprRQ95aSkSR/Paj29UnA1i1Yt13DS8BFDOXUqPLDbjz7M3GVxGMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769103230; c=relaxed/simple;
	bh=rBgLROGkyGYznxqWSuRkU5F4AzgyzuGopbrdq+I0uRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IGyhoKFcPOZU0ZVqMKwP5H4WrXHnoxnBr+AsXYT5dPTJzzjBiCZwQSaPhJIUaDh3RNXzSvKe9GYUuTwaE9yjUeSKR+b430GZz0p+2JUvnsFYPd/CP93159cOg2hModm2kR0t/SHAZsAM2CkiYPnlZYQbpb/FvFcHCAD9XvKzCvQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R6M4j1h3; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59dd34f8120so1439880e87.3
        for <stable@vger.kernel.org>; Thu, 22 Jan 2026 09:33:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769103211; cv=none;
        d=google.com; s=arc-20240605;
        b=dgBR//AbkLHmxGyw4wVoQRuVOe8whXAbwSSnsDSgjvYF/79tGjwh4VZhGDCBi29frV
         YlIbet39ZYfcMzy7Vtd98qAa66RvxIYwPlSVOvAgt9UaH8kOM7IgVe6R+dHNzp8nVoR9
         CgIq+/XNuGljMjVTR1a4RQAlUd7mKLhP6BHp+A0aZE1pmVmkZcuUjxuTgSWp8xgzBIi4
         S3RAtfkKyogM9cqov+0RYUZH7AATVFi3H6Afprfr+m1v6Gik6FbVDLRfbSlwFQ/NsDPA
         rPEm1KPrEb0fZfYRViSy8/Yg+X514TdIVoVqPUdWwewAzrEfMc2OtsWF8dgHRzIvZ8qz
         QQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8XKCF2Q88XMJ/IC11XgoXGRKrYQjYW3piHpYIxDwdd4=;
        fh=x96fmTdrXgvbSnzG22VnZIhwcPz3VixYUloy4f/8jHg=;
        b=RK8JV62UWnG2BTga01gXSoOzpuVQZ7lzOe02gIvYEaG9Yy3zpqhN0MXOfr/eoHNr98
         biT6QKMRv+X7NKJxTJVm+/M/R/tPDwkmdNlYagBc1L7ChfXrYXteELYTLrLxPo4/cbVa
         a83NTt7IsuA9z6DGx711WeIU11Eo3zOWd9lhsujYje+HFixHJYDm33JSy6firKudq5Yj
         PRQ6M4JweMvW3A0E1JJVwoldL56+yJwTdHO/ny2f2ZqkQjc976NDldv1C9xMV5WYMY7b
         sqb0wgfoqZi1RbWKl08WGyoYHWHHGEMGl7Nlmk9m/vjS+CLEx97GYJRBiqLJKvXhA+sN
         B2ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1769103211; x=1769708011; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8XKCF2Q88XMJ/IC11XgoXGRKrYQjYW3piHpYIxDwdd4=;
        b=R6M4j1h3KfxZWWsckpE/6oWW4PCRkxR8EU4RfYw6AJimplHHJZ9zkt8kXc09dBNNhr
         bo6oHb7EzBj7Xk8IaJgszrHG/VrBte6OEVxHi/vMDhdQgvTSudF1/2hmIj0axdx66670
         dZw9Nvu7OYg8R0JOcfA1gqYt+pse7ZgNIBEWGCBtbR4LB6Ly6kJ0sRRuGProlN1acYiN
         lyfAeHQHEnq3hJfA+Q9FtQ7dXhkb/Dr/dFOXL7CvMY4Z91oy/PH+IZXR46KTMU0cNSyT
         bN5MjICeMG7ZemnSWgD0e6teHH3pp7gbnzdupxfUPBeL5hx3m+hvUczAiXBSBPQ3Wxrc
         /OIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769103211; x=1769708011;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XKCF2Q88XMJ/IC11XgoXGRKrYQjYW3piHpYIxDwdd4=;
        b=i2mi8mWaSecgLFId0L4EuOnTxswPXS3D6eJokhSf/mf1dMuRdgl3bB1l/VYIau6BcT
         ur2qfhjRaQ68t2d+pJl6Gm3QBinxMTMd48zs0EBuhwDAjjBi3gkGe9pouCKwatejvxDX
         KReKcAG7mkNcsQSri99+3wNrob3lTQ2uF7ZBosc656adlovO7MskFvnLxD2gjSev0p+L
         w0QEAmVXWbDhy7LgWv3K+AxsaGhd9inYONOOKpTSjlVfdzCF//1oqzc59Y11x/tGbxPn
         MNXaaGWeclVg8V600+e3HuOUS41FujIV/MJrrS1lxXMxzQS5EH44xOT0lxybnb75hQAl
         U1gA==
X-Forwarded-Encrypted: i=1; AJvYcCV6ImMXUyYhsmXgtnOSnCl2/6x2sImNJGPLwM/h+Pa+mohZxnG2ql4YwcNtS8ZIiiUUwiCVW9g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8woWpHlApVkqk9tZBIFGiXOT+7GCWJmpTwfKZNIzWpco4mHox
	sh71p44V85NWNGptwg6NBHWn9OgQegZAFAezFGG8wz25CYkuPDCS3ym82UUcEvz0h6wDTwP0WiD
	4lrjK+dU2e/pn6DSqZw4urGuQXL/ddpyH67VOC9LBaw==
X-Gm-Gg: AZuq6aLa6TRyzSKB+KSiUZ2XnuVj1u+FE+67+wthJkRmKOmRvU2I6kgNWzlqS71aBL1
	cBdnKmko/FeF7zym99Szc2lhowmoCdnR1MHJtIlT2M2Lc6sRvDYwbhlGjhd5pNFMeDqZij0NEk9
	00Ozya3JMuqzB3k2B2AsvLJ1O3HynfWzqmrRVLCxr6BqjgpsTUjh3bxXHCYwSBJHQeYAjuEuwX/
	mpS0t3cXGsXooxtM2s6pPl0nTJxcbPaKWyG/L21+27dA1EXLX6IojPa4QFvaJalVaRps5ta
X-Received: by 2002:a05:6512:3504:b0:59d:d679:2a6d with SMTP id
 2adb3069b0e04-59de4916eeemr34747e87.23.1769103211187; Thu, 22 Jan 2026
 09:33:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260115214648.168365-1-pgeng@nvidia.com>
In-Reply-To: <20260115214648.168365-1-pgeng@nvidia.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 22 Jan 2026 18:32:55 +0100
X-Gm-Features: AZwV_Qgym-tguzdbKVLzMRHcvH4LFPmeb3zCUxWdfkYYh9QZZgSZ7Dgv9E0urcE
Message-ID: <CAPDyKFqYgOOJdT-0oxCyrfCjW8SuORX3+tXq1D09Qj1jYDOKpw@mail.gmail.com>
Subject: Re: [PATCH mmc v1] mmc: core: Fix bitfield race between retune and
 host claiming
To: Penghe Geng <pgeng@nvidia.com>, Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211286-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ulf.hansson@linaro.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-0.996];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nvidia.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: C98706C431
X-Rspamd-Action: no action

+ Adrian

On Thu, 15 Jan 2026 at 22:46, Penghe Geng <pgeng@nvidia.com> wrote:
>
> The host->claimed flag shares a bitfield storage word with several
> retune flags (retune_now, retune_paused, can_retune, doing_retune,
> doing_init_tune). Updating those flags without host->lock can RMW the
> shared word and clear claimed, triggering spurious
> WARN_ON(!host->claimed).
>
> Serialize all retune bitfield updates with host->lock. Provide lockless
> __mmc_retune_* helpers so callers that already hold host->lock can
> avoid deadlocks while public wrappers serialize updates. Also protect
> doing_init_tune and the CQE retune_now assignment with host->lock.
>
> Fixes: dfa13ebbe334 ("mmc: host: Add facility to support re-tuning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Penghe Geng <pgeng@nvidia.com>

Thanks for the patch! I have looped in Adrian to get his opinion on this.

Kind regards
Uffe

> ---
>  drivers/mmc/core/host.c  | 60 +++++++++++++++++++++++++++++++---------
>  drivers/mmc/core/host.h  | 35 ++++++++++++++++++++++-
>  drivers/mmc/core/mmc.c   |  6 ++++
>  drivers/mmc/core/queue.c |  3 ++
>  include/linux/mmc/host.h |  4 +++
>  5 files changed, 94 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 88c95dbfd9cf..0b6b4a31f629 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -109,7 +109,11 @@ void mmc_unregister_host_class(void)
>   */
>  void mmc_retune_enable(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
>         host->can_retune = 1;
> +       spin_unlock_irqrestore(&host->lock, flags);
>         if (host->retune_period)
>                 mod_timer(&host->retune_timer,
>                           jiffies + host->retune_period * HZ);
> @@ -121,18 +125,31 @@ void mmc_retune_enable(struct mmc_host *host)
>   */
>  void mmc_retune_pause(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
>         if (!host->retune_paused) {
>                 host->retune_paused = 1;
> -               mmc_retune_hold(host);
> +               __mmc_retune_hold(host);
>         }
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>  EXPORT_SYMBOL(mmc_retune_pause);
>
>  void mmc_retune_unpause(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +       bool released;
> +
> +       spin_lock_irqsave(&host->lock, flags);
>         if (host->retune_paused) {
>                 host->retune_paused = 0;
> -               mmc_retune_release(host);
> +               released = __mmc_retune_release(host);
> +               spin_unlock_irqrestore(&host->lock, flags);
> +               if (!released)
> +                       WARN_ON(1);
> +       } else {
> +               spin_unlock_irqrestore(&host->lock, flags);
>         }
>  }
>  EXPORT_SYMBOL(mmc_retune_unpause);
> @@ -145,8 +162,12 @@ EXPORT_SYMBOL(mmc_retune_unpause);
>   */
>  void mmc_retune_disable(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +
>         mmc_retune_unpause(host);
> +       spin_lock_irqsave(&host->lock, flags);
>         host->can_retune = 0;
> +       spin_unlock_irqrestore(&host->lock, flags);
>         timer_delete_sync(&host->retune_timer);
>         mmc_retune_clear(host);
>  }
> @@ -159,16 +180,22 @@ EXPORT_SYMBOL(mmc_retune_timer_stop);
>
>  void mmc_retune_hold(struct mmc_host *host)
>  {
> -       if (!host->hold_retune)
> -               host->retune_now = 1;
> -       host->hold_retune += 1;
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       __mmc_retune_hold(host);
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  void mmc_retune_release(struct mmc_host *host)
>  {
> -       if (host->hold_retune)
> -               host->hold_retune -= 1;
> -       else
> +       unsigned long flags;
> +       bool released;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       released = __mmc_retune_release(host);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +       if (!released)
>                 WARN_ON(1);
>  }
>  EXPORT_SYMBOL(mmc_retune_release);
> @@ -177,18 +204,23 @@ int mmc_retune(struct mmc_host *host)
>  {
>         bool return_to_hs400 = false;
>         int err;
> +       unsigned long flags;
>
> -       if (host->retune_now)
> -               host->retune_now = 0;
> -       else
> +       spin_lock_irqsave(&host->lock, flags);
> +       if (!host->retune_now) {
> +               spin_unlock_irqrestore(&host->lock, flags);
>                 return 0;
> +       }
> +       host->retune_now = 0;
>
> -       if (!host->need_retune || host->doing_retune || !host->card)
> +       if (!host->need_retune || host->doing_retune || !host->card) {
> +               spin_unlock_irqrestore(&host->lock, flags);
>                 return 0;
> +       }
>
>         host->need_retune = 0;
> -
>         host->doing_retune = 1;
> +       spin_unlock_irqrestore(&host->lock, flags);
>
>         if (host->ios.timing == MMC_TIMING_MMC_HS400) {
>                 err = mmc_hs400_to_hs200(host->card);
> @@ -205,7 +237,9 @@ int mmc_retune(struct mmc_host *host)
>         if (return_to_hs400)
>                 err = mmc_hs200_to_hs400(host->card);
>  out:
> +       spin_lock_irqsave(&host->lock, flags);
>         host->doing_retune = 0;
> +       spin_unlock_irqrestore(&host->lock, flags);
>
>         return err;
>  }
> diff --git a/drivers/mmc/core/host.h b/drivers/mmc/core/host.h
> index 5941d68ff989..07e4f427fe15 100644
> --- a/drivers/mmc/core/host.h
> +++ b/drivers/mmc/core/host.h
> @@ -21,22 +21,55 @@ int mmc_retune(struct mmc_host *host);
>  void mmc_retune_pause(struct mmc_host *host);
>  void mmc_retune_unpause(struct mmc_host *host);
>
> -static inline void mmc_retune_clear(struct mmc_host *host)
> +static inline void __mmc_retune_clear(struct mmc_host *host)
>  {
>         host->retune_now = 0;
>         host->need_retune = 0;
>  }
>
> +static inline void mmc_retune_clear(struct mmc_host *host)
> +{
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
> +       __mmc_retune_clear(host);
> +       spin_unlock_irqrestore(&host->lock, flags);
> +}
> +
> +static inline void __mmc_retune_hold(struct mmc_host *host)
> +{
> +       if (!host->hold_retune)
> +               host->retune_now = 1;
> +       host->hold_retune += 1;
> +}
> +
> +static inline bool __mmc_retune_release(struct mmc_host *host)
> +{
> +       if (host->hold_retune) {
> +               host->hold_retune -= 1;
> +               return true;
> +       }
> +       return false;
> +}
> +
>  static inline void mmc_retune_hold_now(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
>         host->retune_now = 0;
>         host->hold_retune += 1;
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  static inline void mmc_retune_recheck(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
>         if (host->hold_retune <= 1)
>                 host->retune_now = 1;
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  static inline int mmc_host_can_cmd23(struct mmc_host *host)
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 7c86efb1044a..114febd15f08 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1820,13 +1820,19 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 goto free_card;
>
>         if (mmc_card_hs200(card)) {
> +               unsigned long flags;
> +
> +               spin_lock_irqsave(&host->lock, flags);
>                 host->doing_init_tune = 1;
> +               spin_unlock_irqrestore(&host->lock, flags);
>
>                 err = mmc_hs200_tuning(card);
>                 if (!err)
>                         err = mmc_select_hs400(card);
>
> +               spin_lock_irqsave(&host->lock, flags);
>                 host->doing_init_tune = 0;
> +               spin_unlock_irqrestore(&host->lock, flags);
>
>                 if (err)
>                         goto free_card;
> diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
> index 284856c8f655..5e38759c87f5 100644
> --- a/drivers/mmc/core/queue.c
> +++ b/drivers/mmc/core/queue.c
> @@ -237,6 +237,7 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>         enum mmc_issue_type issue_type;
>         enum mmc_issued issued;
>         bool get_card, cqe_retune_ok;
> +       unsigned long flags;
>         blk_status_t ret;
>
>         if (mmc_card_removed(mq->card)) {
> @@ -297,8 +298,10 @@ static blk_status_t mmc_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
>                 mmc_get_card(card, &mq->ctx);
>
>         if (host->cqe_enabled) {
> +               spin_lock_irqsave(&host->lock, flags);
>                 host->retune_now = host->need_retune && cqe_retune_ok &&
>                                    !host->hold_retune;
> +               spin_unlock_irqrestore(&host->lock, flags);
>         }
>
>         blk_mq_start_request(req);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index e0e2c265e5d1..e7bddbafd1da 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -713,8 +713,12 @@ void mmc_retune_timer_stop(struct mmc_host *host);
>
>  static inline void mmc_retune_needed(struct mmc_host *host)
>  {
> +       unsigned long flags;
> +
> +       spin_lock_irqsave(&host->lock, flags);
>         if (host->can_retune)
>                 host->need_retune = 1;
> +       spin_unlock_irqrestore(&host->lock, flags);
>  }
>
>  static inline bool mmc_can_retune(struct mmc_host *host)
> --
> 2.43.0
>

