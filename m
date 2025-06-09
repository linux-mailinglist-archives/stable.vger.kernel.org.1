Return-Path: <stable+bounces-152175-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0781AD20D5
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 16:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1D9188C120
	for <lists+stable@lfdr.de>; Mon,  9 Jun 2025 14:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B5025D549;
	Mon,  9 Jun 2025 14:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EnSvZPhF"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E1025CC54
	for <stable@vger.kernel.org>; Mon,  9 Jun 2025 14:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749479145; cv=none; b=qYy9RAyyyWuVy9UGGbc6IC8NqYk0gL88gVe3bXbN/8AizS4V6VPyET422MK1P0yDQvbCkiv+umYsHzK3u9MH7meJuBGdZ+hz7Wmhc0ABZJujtD+Jo6nFdyWSrmvu8SNOF0PfoAcLwEpnuuegWIpZhEV794FMK3GWMK0s/kEXEz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749479145; c=relaxed/simple;
	bh=JembqEDnPfh2VIA0GR9xZmb2kn3DMblLdpcQQYVBcIw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/V3PIEoSYtjQldpwmVd6s5DhJ2d8Rx1LODWwu5UzpdSEdCsYi8clxYA9iLjmhDn99R9qgLPK6466DkqxBJACuyDzLkhazYcV74pvDNzqFifVPVSXyAufmjuke6yP5K7mg/xOihFq9HWP6NmSLJEoP23SRCtDmm8FW5HTUZOu8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EnSvZPhF; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e733cd55f9eso3985259276.1
        for <stable@vger.kernel.org>; Mon, 09 Jun 2025 07:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749479143; x=1750083943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kzdfsvEKoVL0JlUZYzUNHs+G1k04M6kNna6qKIJw/N4=;
        b=EnSvZPhFWf3yLKSOojCeqZrs2eU49KNiKtKahw7FbA4HP51vqJrojYKVAIexxPa+fF
         BXCmcrlHq+QWlLCmc4YZ0NgDEKJFd+aYdhSziKjd9ZP5JBbNG6pWVIgl6nW2j/HnlYkN
         q5odvyeGLxZ4r+CS0t8JQ2xX0mTH4Vk0SLBLLT3vN+bgvXeejQ3W6ER+TnBbKGqnv95o
         fUnmyHPbyIklAwljECYvN3H6faTKT3w2hGvhoROqRR4uzGgscSszcdAUYEjoenLbrtTJ
         4pMvSJlARbwQ272aPfJS95A9MMYz44ba4Sbap9v8UTuKlckJxRdGEG1IPmlsjQuIOVJM
         2oVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749479143; x=1750083943;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzdfsvEKoVL0JlUZYzUNHs+G1k04M6kNna6qKIJw/N4=;
        b=PQ71i1X63EN+7bnD2FcVtTTT6IpI5wbkw/TC684rCLO3QLNKzZ71JFfkhA3LvGMfxT
         qAsu20vtoueT5X5OAPnujGK+fOLKNKKxNztbeMuB8P5bQeiMMhenOnMwcU9ZTCaiTlJ1
         rbHsShDFQQKL0zVNhdd+jp8yt5vkhNn21JWgQoqEdtK0Z+783ErhfqojjvwDglIoxkkC
         v5yhIpKXis3AKOE1VkaHNpCtOpgUevbCRMaEGyUxXpXDNl9eJD0/nZ9VKgIgKCy/EQEN
         845LzMjhMNx2+FB5FCz82/R/uLVMXPa8nzaaJj1Y+DR64FrrwTpEyHz2qFfsNf1mW7uK
         TEhw==
X-Forwarded-Encrypted: i=1; AJvYcCUaLtJpwFVUZoPKBNGqAF3oi+O5hw8vTFXkFJNFWCyL0+clEeYKa8V3vhZU5i57HoLItxrhIPQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxArRexRY2SJvUMGfobU01AzqS8GKE7PxABBLloQEVPAeHF010
	Srm/t11TnbG+QLr5ZCIsdeFavSF+0VLrplZzDf687TMXzXXAZMLlE8fTEiFmoSIEBz6BlTYxwdV
	x2jeqWep0BWQ1FkzVmjZBVAS5r4nemo4zsjUtpcpDA/lWh5Ixrg2i4bU=
X-Gm-Gg: ASbGnctnxT8B3SSnmz07wZ6C54/p8hTkCVG7+LMwQVGU7Htz51ODiG3w1wNHOGLCvSE
	NDGJR7RNkWLRZQjauRhBIEUfWZOuBH/Su0rVmzJy+hIprRDgLMs7E8RYQ4FTHezcUdmbqunv7JA
	HWBP4ey+D9bC6gJAuxOBFRN7xUKA0O2t+BLQ==
X-Google-Smtp-Source: AGHT+IG2HLdvbnxpZe5SlTc13La28qz/TTvT3V0gP1+rVEn7gv/MG3ut8oNriSko0ei9/cjAWdSH5AWw1B+pvvtkfTs=
X-Received: by 2002:a05:6902:1884:b0:e81:891e:9628 with SMTP id
 3f1490d57ef6-e81a227ca7amr17811028276.10.1749479142932; Mon, 09 Jun 2025
 07:25:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526114445.675548-1-avri.altman@sandisk.com>
In-Reply-To: <20250526114445.675548-1-avri.altman@sandisk.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 9 Jun 2025 16:25:07 +0200
X-Gm-Features: AX0GCFvgU7bcLOda429ePjzI3MwknDGYJdfbakJENxHfVdHS1d_GKrzXTjkaoks
Message-ID: <CAPDyKFrDNqkFAOx8yF+jW3NOA+J5M7e77MT91aRxsG8Mozq7bg@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: sd: Apply BROKEN_SD_DISCARD quirk earlier
To: Avri Altman <avri.altman@sandisk.com>
Cc: linux-mmc@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 May 2025 at 13:50, Avri Altman <avri.altman@sandisk.com> wrote:
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

Applied for fixes, thanks!

Kind regards
Uffe


> ---
> Changes in v2:
>  - rebase on latest next
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

