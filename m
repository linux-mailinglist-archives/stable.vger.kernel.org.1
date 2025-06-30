Return-Path: <stable+bounces-158864-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B22AED3DF
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 07:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075BC3B453B
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 05:34:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83AD1A23A5;
	Mon, 30 Jun 2025 05:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k2lx3WCW"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851D71E502;
	Mon, 30 Jun 2025 05:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751261696; cv=none; b=iPjNLHrXGSuPCG0394ARU8Kzxsxuj1qRQ7K1JTMQD88zNwdOvX+bVOO1OcyiA7uaRle1nzyBIjJCE+L8Vl8bGm2jZ77TmphZG2/CWpJ6Yaw3KadP2ZwQrVv28WaubMq2Xpnf53BkCNLrndtkFj8/LCHiKG31qwa/qhkhmQxBqKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751261696; c=relaxed/simple;
	bh=mGwnZ8e10+fTtNbPu+r6IW70w9vhm3FYsEZO/MSYQsc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R34ci+gs2jje5hGyE5wg0KHfynZB0v+yaJ6Sa8rrqJDb61cfUTOp7yND4B2odQ15R0dx+TfCPwDBPvACcJSIDl1LfATj0+DsjON+o+0JuebJEimiL3H0m1EAmM2UinwzOtVH1fBpcz41FYveLQ+E/2CnxlqmPGmKzP0lU3Kal6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k2lx3WCW; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3d948ce7d9dso9801035ab.2;
        Sun, 29 Jun 2025 22:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751261693; x=1751866493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mGWiywgRxXZ4TpCKa9WNBlA/Whc9Wp3uQ8q4wg+3L+M=;
        b=k2lx3WCWIt6VJpj/+qCMhdtVtqefi9zpZCsiYAZglaRuQZviPdJcl1nnXv6Yv2nrmt
         MRiwGHH+x0SUaeX1mwnUL5LQ109JEnSToEwK9uUjdH/2YOLCSvN3VQSifr2h1WEUm1zD
         wzqzTDBruevBDEbGrqSEz5GTYaudSyLvClghkwNuz/Q+HHAeaH/qcAskX7fFtKUUurza
         AnyxzsRwTw7aEdjnhMYVtYW/bfu9t39cZehFFQfUtGMo3kvMiYHDpFvGF3F+s9B2/Kkl
         DdnVlJBIfzWY5Wl9M+gFse4entDb8yxdI6js/bMCX763ZaD5hR9eH+TKpTBeeCpHfVxB
         70fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751261693; x=1751866493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mGWiywgRxXZ4TpCKa9WNBlA/Whc9Wp3uQ8q4wg+3L+M=;
        b=DmF5rdcjjqry5uH7h8knAdU36h9OFn+J9S1who+BWCtQXeZ7sRQQMTpk4R4txgASTM
         ZcffP64Ba9tU2/z0NfIrWLh92ppNhLUa8jNWbNuE1bv2Ms4PtwBFqXd9+tp5MvGcL251
         9yfvaPK5/D9dIVyjXmaPqS874tQNYB2AZ0v5DGXmio8sh0en9K8GpzjzMGb1TP1p1w9I
         Psj0/nKfTZaSLtv3xfARcA5wpujqEY9VpZOwBFAsVQJpuiFNqWW3lT3rmt6ZpPXTMLDx
         ZDtogZBvDUq/bXN4c6dUTjLYVufJO441oyi7G6mRptS5y8kVOwsDVfdixW/9KiCQGCxq
         e28g==
X-Forwarded-Encrypted: i=1; AJvYcCVOpXzyEC/Er/kK0wcoWarS+VJ25GVpZwbaaKO54JawLxeIC6/PXOe0KApw1FX0CFqxtYtvfgnHnH9sbZE=@vger.kernel.org, AJvYcCVVWHRL+K9q7TUAVWzr4x4trqiFRVHy3TdJzUR1ef6krgSNDRhIYx//lt1hsTyOxZ4ZVAsf2NUn@vger.kernel.org, AJvYcCX9KnGUl2peI+aN/swvDHEdzIL1ih2lAi/vkc+EzCfwDVlkFR1hXfzlzYvsDl1yleRgN/l+ZbESnZWQQlQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpalOo5dzTmDoX1E2pytsEEzaHwFEoRcpj7SYBhn+/YV4BIS14
	WDel026R65iCGv0TOJJeIhBhM2Kg7/x22XczH12OaajVawmUvmrPdXC7dyMn/Az6oT2OKWwmMo4
	8dV88ysTKsW3GZ17FX26nXOle1zXCzFc=
X-Gm-Gg: ASbGnctsZ+MTqp/FVcNR1fTuAw2zypvRM+wcHjvUQg3ie/uSpqHUfKb+qL52Qixgg6d
	vScDvK8XFUvMakTMwx54Q3txM+HFv/GtOWux8YmFwgKzKXliC30pkdqi2GPm3c6mMppziHPaDYQ
	UC1XD+LVKEELuRNYStmUD1JBJOXDNUV+PHUYnS4ixEH5w=
X-Google-Smtp-Source: AGHT+IGJf8zxb+wvtJ9W2Up4OO/G3M37ER/D2K1w3AMwNSKqh2NBW2TNl09JoLmmOhY3hctTOb+G9b9HY1YmMW6aBSg=
X-Received: by 2002:a05:6e02:5e09:b0:3df:52fc:42ea with SMTP id
 e9e14a558f8ab-3df52fc43ebmr64519965ab.13.1751261693432; Sun, 29 Jun 2025
 22:34:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626130858.163825-1-arun@arunraghavan.net>
In-Reply-To: <20250626130858.163825-1-arun@arunraghavan.net>
From: Shengjiu Wang <shengjiu.wang@gmail.com>
Date: Mon, 30 Jun 2025 13:34:35 +0800
X-Gm-Features: Ac12FXyRcEw2c8QCNueRD8i-vzu3N_uIrpDLEDkz208eeIELpAidj2GdbDKk77M
Message-ID: <CAA+D8ANDnPaadSwgvxGuKE1w=pwh+fRgG2J-_NQDDN82wx7K9Q@mail.gmail.com>
Subject: Re: [PATCH v4] ASoC: fsl_sai: Force a software reset when starting in
 consumer mode
To: Arun Raghavan <arun@arunraghavan.net>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Fabio Estevam <festevam@gmail.com>, 
	Nicolin Chen <nicoleotsuka@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
	Pieterjan Camerlynck <p.camerlynck@televic.com>, linux-sound@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, 
	Arun Raghavan <arun@asymptotic.io>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 9:09=E2=80=AFPM Arun Raghavan <arun@arunraghavan.ne=
t> wrote:
>
> From: Arun Raghavan <arun@asymptotic.io>
>
> On an imx8mm platform with an external clock provider, when running the
> receiver (arecord) and triggering an xrun with xrun_injection, we see a
> channel swap/offset. This happens sometimes when running only the
> receiver, but occurs reliably if a transmitter (aplay) is also
> concurrently running.
>
> It seems that the SAI loses track of frame sync during the trigger stop
> -> trigger start cycle that occurs during an xrun. Doing just a FIFO
> reset in this case does not suffice, and only a software reset seems to
> get it back on track.
>
> This looks like the same h/w bug that is already handled for the
> producer case, so we now do the reset unconditionally on config disable.
>
> Signed-off-by: Arun Raghavan <arun@asymptotic.io>
> Reported-by: Pieterjan Camerlynck <p.camerlynck@televic.com>
> Fixes: 3e3f8bd56955 ("ASoC: fsl_sai: fix no frame clk in master mode")
> Cc: stable@vger.kernel.org

Acked-by: Shengjiu Wang <shengjiu.wang@gmail.com>

Best regards
Shengjiu Wang
> ---
>
> v4
> - Add Fixes and cc stable
>
> v3
> - Incorporate feedback from Shengjiu Wang to consolidate with the
>   existing handling of this issue in producer mode
>
> v2 (no longer relevant)
> - Address build warning from kernel test robot
>
>  sound/soc/fsl/fsl_sai.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
>
> diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
> index af1a168d35e3..50af6b725670 100644
> --- a/sound/soc/fsl/fsl_sai.c
> +++ b/sound/soc/fsl/fsl_sai.c
> @@ -803,13 +803,15 @@ static void fsl_sai_config_disable(struct fsl_sai *=
sai, int dir)
>          * anymore. Add software reset to fix this issue.
>          * This is a hardware bug, and will be fix in the
>          * next sai version.
> +        *
> +        * In consumer mode, this can happen even after a
> +        * single open/close, especially if both tx and rx
> +        * are running concurrently.
>          */
> -       if (!sai->is_consumer_mode[tx]) {
> -               /* Software Reset */
> -               regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_=
CSR_SR);
> -               /* Clear SR bit to finish the reset */
> -               regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), 0);
> -       }
> +       /* Software Reset */
> +       regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), FSL_SAI_CSR_SR);
> +       /* Clear SR bit to finish the reset */
> +       regmap_write(sai->regmap, FSL_SAI_xCSR(tx, ofs), 0);
>  }
>
>  static int fsl_sai_trigger(struct snd_pcm_substream *substream, int cmd,
> --
> 2.49.0
>

