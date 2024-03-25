Return-Path: <stable+bounces-32194-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A01388A79C
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 16:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B5E1F66A84
	for <lists+stable@lfdr.de>; Mon, 25 Mar 2024 15:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5534641C64;
	Mon, 25 Mar 2024 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ktSRhk1D"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F34512E71
	for <stable@vger.kernel.org>; Mon, 25 Mar 2024 13:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711372726; cv=none; b=egkYnW1bqDwsTOWVRb8JoulUuyQV0XDwgMD5DWzk3RnnYeUd+F859yY6AqpUxF08sEpTHOR3L6zpxjgCSMGvgzG6JypYDoGmseMQLDe7jDCaFpLxVlJRVwR+sW3A0stPcBRITkE95mexQ5vAf+7/MgXPylxDWGNGz44mrFdkdYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711372726; c=relaxed/simple;
	bh=jUHFT7GHBABnNWhUUsb9TaH8zDV3pnOGgOcdjdlYdbA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cR0K+zXA4I+oYVdq+Mw7z+iIZPCdvfVD0Gc9X7+coWtxOVhvT++3KxcBIlFY5UlP6nhNSbT+sjUHR4nJ4YRXguSsQvxHacdYu/kdizqjcza29v3LHbQIQlXeX89I+KBM0AxWSGNZHmX9F2IIuzwoSqcS2mVaiRmsIp9fZpZ4aMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ktSRhk1D; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dc23bf7e5aaso4221643276.0
        for <stable@vger.kernel.org>; Mon, 25 Mar 2024 06:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711372721; x=1711977521; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ceL10kuUzc1VTmaQNsfHwRb5WEw70QYvCvwFrHJHCrg=;
        b=ktSRhk1DyPESD79xLJ+UcPqL6I7+rnbBOSDUkhSa+NMBab4kt1sALOp+3BD+MB1YZJ
         yUbEudMW/Thf0F4e44sKdHj6aubuDJhK4LQKrTx4SMERFg1mHzm1UD3cwuejvn9pWmv0
         t220Y07NLgyYTRKS/NCe4iX9UQdry/SNhdpOLXe3f/hJemO9MM5ceOecBlUz333g+x1J
         qb+Scu+SSOech5A5AFGE70zjL59hTCnLBl2Ca9LSpqTsha49ugm7s7ljZgbN23zDBkPO
         hu00o/POG1PjJ3quMT2TK+BUpTsn1LXasKs8wEfhuI6R+eAq7cKfN//Ljl7j2zwbkUDx
         m9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711372721; x=1711977521;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceL10kuUzc1VTmaQNsfHwRb5WEw70QYvCvwFrHJHCrg=;
        b=CY9APKDzJ8uAMywWYLDNecm77+FN6WzIqeCoRHt0sdvv3A7ELA3pWYao6RDuw6wSEm
         BJwMGtHArPxcyMo5HhDpF77zbvvTD+6yBV+DRmxFroMO/wE038zUrt92OIL00Bmzo+B1
         AYWTiOf6XuQeHse9wH54jyeC03A378u/VIpOZTDwIL524wJFxryjep0rohNq395wSrMP
         Sds1sU4iebq5So/yt2lE+lNps4wCsTZdcKNUxV34xY+IBoaz63Jg6UA2aENJOr4HixWo
         ROnt8+/9VEsCfdOJSm9gLNTtDKLQ+bD77WmGoLcS5Xb/q/412MFKNdxgxj1Eo4SwW1Z/
         lzpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMkq2MOoZzrwoWSn1vzoie7r/MAhabT9D1Z/LYmrtfWN+Z+clYkCXumvBRAqYc7pMWWmefnPO89gxdTL7Z170peZqnLRJS
X-Gm-Message-State: AOJu0Yw5E3ISFk365POKuNu1Yr5v6qnbRVgrmEwdil/Ig33s+DjMM6RZ
	GUz8/QBUfe0vEFI6S2NbLLqS+srAnvZZNVDarFB//hlESK7/lnpgAPcVhYhFwXFeFsWYBKer0fE
	vncOSChtiUkYdKNr8C0/ZdV4CcHcPTNNU1P1DyQ==
X-Google-Smtp-Source: AGHT+IHBAtsETDpFdGmDQMqeFq/C1HWpnkyJwmkgZqhewbdaKt4PCmaqUyLetMdO7RYqpCQvGSwJSK7+UJmmFu9aNpM=
X-Received: by 2002:a25:aea0:0:b0:dda:c5ca:c21b with SMTP id
 b32-20020a25aea0000000b00ddac5cac21bmr3873894ybj.37.1711372721646; Mon, 25
 Mar 2024 06:18:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
In-Reply-To: <20240313133744.2405325-1-mikko.rapeli@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 25 Mar 2024 14:18:05 +0100
Message-ID: <CAPDyKFpkz=LeVR_8z0-jh9QGwdXp1GUZ+VFPdDwKChBNFHyEGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc core block.c: initialize mmc_blk_ioc_data
To: mikko.rapeli@linaro.org
Cc: linux-mmc@vger.kernel.org, Avri Altman <avri.altman@wdc.com>, 
	Adrian Hunter <adrian.hunter@intel.com>, stable@vger.kernel.org, 
	Francesco Dolcini <francesco@dolcini.it>
Content-Type: text/plain; charset="UTF-8"

+ Francesco Dolcini

On Wed, 13 Mar 2024 at 14:57, <mikko.rapeli@linaro.org> wrote:
>
> From: Mikko Rapeli <mikko.rapeli@linaro.org>
>
> Commit "mmc: core: Use mrq.sbc in close-ended ffu" adds flags uint to
> struct mmc_blk_ioc_data but it does not get initialized for RPMB ioctls
> which now fail.
>
> Fix this by always initializing the struct and flags to zero.
>
> Fixes access to RPMB storage.
>
> Fixes: 4d0c8d0aef63 ("mmc: core: Use mrq.sbc in close-ended ffu")
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218587
>
> Link: https://lore.kernel.org/all/20231129092535.3278-1-avri.altman@wdc.com/
>
> Cc: Avri Altman <avri.altman@wdc.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Adrian Hunter <adrian.hunter@intel.com>
> Cc: linux-mmc@vger.kernel.org
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>

Both patch1 and patch2 applied fixes, thanks!

I took the liberty of updating the commit messages a bit and dropped
some of the unessarry newlines.

Kind regards
Uffe



> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index 32d49100dff5..0df627de9cee 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -413,7 +413,7 @@ static struct mmc_blk_ioc_data *mmc_blk_ioctl_copy_from_user(
>         struct mmc_blk_ioc_data *idata;
>         int err;
>
> -       idata = kmalloc(sizeof(*idata), GFP_KERNEL);
> +       idata = kzalloc(sizeof(*idata), GFP_KERNEL);
>         if (!idata) {
>                 err = -ENOMEM;
>                 goto out;
> --
> 2.34.1
>

