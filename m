Return-Path: <stable+bounces-145839-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B779ABF689
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 15:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54C8B1BC428E
	for <lists+stable@lfdr.de>; Wed, 21 May 2025 13:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E86B72606;
	Wed, 21 May 2025 13:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FKhc759O"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7D113D8A0
	for <stable@vger.kernel.org>; Wed, 21 May 2025 13:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835331; cv=none; b=Le4jWIo8Ps5JC5T36w9cayyJYEeVWbbBmxid7VoZM4mfljwBkq8kxYSGtm/pqDfNGRHK/z/KzWbRvJM37YuFmiJRtmtEaZN75KfwQx2DGKh85OLkYPXoJREV2fAebwSE2EUx4M4XED+DleMChkrNWrPc11gyEvnV30Y54hKOI7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835331; c=relaxed/simple;
	bh=W9g3nmkPBK3uDHq9xWBMwPYvqOEjSeo/SIuQ8/Oc/Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XrkbLGtSBSoPmWpLwt6r4753A78zBpTnk5X2lt2YMT+tqt0lLYzof1sEbIqEWZbFPHj6T/1one4OVEgyezb39Q0Sshk25WuFTfpIUa4IK7BYbxxoVDMTLc6U3LGySrzTsIngWPV6LpEXzTDBbHsmyvYPvg+tUgo9Egh/HTl7WJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FKhc759O; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e75668006b9so7070347276.3
        for <stable@vger.kernel.org>; Wed, 21 May 2025 06:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1747835328; x=1748440128; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TfFZLIOuKnQvxfDeDOQOQ02mpTZZuOoeWl2CRrGL9p0=;
        b=FKhc759O6dRyruhCmkMOkba7TndIuese6y4rndHjskc35WtGOjgcLNcL06wbnw46Xd
         ZIWZz5M/pXQJmvvQ3j/8DOsGK941+QyaYsPD3PD2Q/761Nf5RgarQiWIDGfBmt2EC5TW
         oVYWWovsjid5ZDoFAFx/JJCb58VM0A2fSHX27CrAVHAZ/mSwe1kNvujVEGaUizNSvKDY
         olX+uOarwnL8eNhfGrtmkRj7MC2fHBmNoY/uSub3crMnjBoaQc0dc/RQk/IL0lXcfDLB
         Grj90PrkFUefUd02a6x6RHImNEiDgYxzJyKs0PmUJ2JTRzr7e9yi4Q/586BASD6/UQuh
         AtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747835328; x=1748440128;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TfFZLIOuKnQvxfDeDOQOQ02mpTZZuOoeWl2CRrGL9p0=;
        b=E37+yDHe+gDtGLISLhlDhf1VTMXaFmGhvlfoJKA9fRLv+CEFxW57RqfgtmAMIxiLwc
         +ry1pik061TxzQKDmgy6Y3onhj8Q1ZRh+FpaKZx3TAVo+D0bBUHEfSJzAw2N54qhj1t9
         cENlkrrcxm7NGkdjbdXHvbVtN6gwAlE7/yU0tZiIbgLtebv7fiobryj0JS2x6HWuS4rz
         QFUze+AT1EhdIWvfOOgKdGBUIbjha8yB3Rz9sUM6kO06U3HZ1ZxzwZy664YsSZuVY0hI
         +SQRUzOLUMCOBbapgBSuXh/GSpQcv6FS6kEo1B8Gku4twmx7d00hjAL6W8BTsnumuLqk
         Sn4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVPQ6TA5tu7/e60pT0eBh3zQ+18W9jVSv4CdopWZ7m7vIclVZ25FANCGV3PDtCjdsWBt0XG/6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAsdIrxVI9twpnzeKh7LadzMv4HWhoqQaejjhmirNJU5S5bpw1
	5f9UwU8mxIspQgU096qbu78BoDROq2FkIUy8SQ7Rc0kzCcUOYoy9LTR1yRSVh8EhMC53OGt+EuT
	jaFGIQMCv4lNMkD90OsJiZzhUJ9ZsWP7NZOU9wtZ4c1BIzSxSStXj3zI=
X-Gm-Gg: ASbGncutznuULy18rRWwZSN0OYsMXowbj2hkRwhk8hsGheCppRMRLGx9+HCfavWC0dZ
	bw46Z46QoGxbm5rXzWRwkrjCmHrbHFPDlmZeP7sRxLaKyR6CEKxUR76NiwT+5x0OZ8SYxilMqaG
	hnbyBNxIkDjUZ/USobb3/7rPMFrf2skJpvxRPBdbQr3z7p
X-Google-Smtp-Source: AGHT+IHoCa5bmEKkj5D1n2jB7xPQ0ApHj7TGgYcEf8a9QreUaAZha2N0oJ8kgZa5fslYVkBS5lz9YlhGy+frYg4gtXE=
X-Received: by 2002:a05:6902:270a:b0:e7b:4e69:7008 with SMTP id
 3f1490d57ef6-e7b6a08d6d3mr28537450276.20.1747835328402; Wed, 21 May 2025
 06:48:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250521124820.554493-1-avri.altman@sandisk.com>
In-Reply-To: <20250521124820.554493-1-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 21 May 2025 15:48:11 +0200
X-Gm-Features: AX0GCFsuVjwBfQvsJsNYRqPy3P3C1hlUAeaBdMvFOiJU1ViczUlz2unjHfKhW_8
Message-ID: <CAPDyKFr31jm8+DKLkmoQ_jfJ5q30x53t+SOmggjWtNsFLZdzQg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 May 2025 at 14:53, Avri Altman <avri.altman@sandisk.com> wrote:
>
> Move the BROKEN_SD_DISCARD quirk for certain SanDisk SD cards from the
> `mmc_blk_fixups[]` to `mmc_sd_fixups[]`. This ensures the quirk is
> applied earlier in the device initialization process, aligning with the
> reasoning in [1]. Applying the quirk sooner prevents the kernel from
> incorrectly enabling discard support on affected cards during initial
> setup.
>
> [1] https://lore.kernel.org/all/20240820230631.GA436523@sony.com
>
> Fixes: 07d2872bf4c8 ("mmc: core: Add SD card quirk for broken discard")
> Signed-off-by: Avri Altman <avri.altman@sandisk.com>
> Cc: stable@vger.kernel.org

This didn't apply to my fixes/next branch, can you please double check
and send a new version? I didn't have the time to resolve the
conflict, sorry.

Kind regards
Uffe

> ---
>  drivers/mmc/core/quirks.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 7f893bafaa60..c417ed34c057 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -44,6 +44,12 @@ static const struct mmc_fixup __maybe_unused mmc_sd_fixups[] = {
>                    0, -1ull, SDIO_ANY_ID, SDIO_ANY_ID, add_quirk_sd,
>                    MMC_QUIRK_NO_UHS_DDR50_TUNING, EXT_CSD_REV_ANY),
>
> +       /*
> +        * Some SD cards reports discard support while they don't
> +        */
> +       MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
> +                 MMC_QUIRK_BROKEN_SD_DISCARD),
> +
>         END_FIXUP
>  };
>
> @@ -147,12 +153,6 @@ static const struct mmc_fixup __maybe_unused mmc_blk_fixups[] = {
>         MMC_FIXUP("M62704", CID_MANFID_KINGSTON, 0x0100, add_quirk_mmc,
>                   MMC_QUIRK_TRIM_BROKEN),
>
> -       /*
> -        * Some SD cards reports discard support while they don't
> -        */
> -       MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,
> -                 MMC_QUIRK_BROKEN_SD_DISCARD),
> -
>         END_FIXUP
>  };
>
> --
> 2.25.1
>

