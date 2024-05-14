Return-Path: <stable+bounces-45076-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0B58C5668
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 14:56:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A968DB2221A
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 12:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B55E7F48C;
	Tue, 14 May 2024 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PjUeDkdb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2D16CDBD
	for <stable@vger.kernel.org>; Tue, 14 May 2024 12:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691288; cv=none; b=n2Ii58JVEnDYjzyGaEfsQlcGzclxM3LxZM/U0CjC30zu0IKq+vG8NNbSRZSQvLKbs4OgLIbWO+48jMlbT2ssA4lT7Sf2tGOXH3J1WEa4sNQ1Kb2tcIPPllijprKATpNmjEgPquKcEsAez8cDFciBGc2a4Vwkg1plRR5wTToKXUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691288; c=relaxed/simple;
	bh=gyRPJJ0Bqup/vojSEgiOY1KSmt5AEBtY2pPjuk1pS0s=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=NeD7BYykmXKqcCesxil5GZCLgDiKI7v0ER1XmeWxNPkkFQtzFPANaNtoIof+LJYUP5OSNGE+vDP6aKdUBohP3oyycuD/VnZvhJx6p1A6vOkcEn+E1d+jEWZWHIxlu+S30O64N3vph6MKr9q9JlfG1E776LLHenvPvg4nsB4I/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PjUeDkdb; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41ff5e3d86aso29045655e9.1
        for <stable@vger.kernel.org>; Tue, 14 May 2024 05:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715691285; x=1716296085; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=0+cTGSpitrxo6tJr/u92LI+13bM0ViiSMLK2haL1u6M=;
        b=PjUeDkdbJYNKHFsbxlFWSh9ejHujyXOGpstjtempZjD4xiZIAwhTlslyy16RwF4adh
         0hjNLvArfWwxlA2eTilS51UYI+E121mvRTlk+qEyqKGe8UiL+txYRaVTw6s4mGGKxPnU
         LmzKtS9qk4X+aGSZiTRnbQ6y3hf7bpMxAEMBOGbuijChqo8S9v5Q2uDgFvBdVT1zVphf
         5mwfEsxORTMjFqH0j46vW+iIu3e+Lr2ZWqH253sZFUTMMrwqsyGTGexkqYBZrazAsNKM
         7o7IJRaU9NG4+i8v2S/k0DIhlbIaCLjMjtH6C8oTZR7R8NzRjo9XDMewvj7tBsrc/G34
         w0NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715691285; x=1716296085;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+cTGSpitrxo6tJr/u92LI+13bM0ViiSMLK2haL1u6M=;
        b=ljkhtM79K/U78xvGC7+E2EKEE/qPk89F5zkFv5ydASt+qKq8W3AwELPxS7XVFq9Lg1
         fSiLTAyUa/KtU0QAZ+mqi31eJ29Ilg4ptNoEmNkm3iVZkUfhI88QpftCFMVkNC1sm4S+
         lIFUvGZb1pKS6WjFduw1OcNTb+xHzT/Q4egKJ7MiJ4RsSeqeLTrlm1v6314szTBTUY2N
         UZ0iXDaf2yWI4Srttn9XA7YhzKJj54H8sDPXyj+7Gmwu5uZA4NEO5Lub8KHB6PEf/iIj
         6e+VwRZApDQCfWp1ELs96/Xh8gHoPShwV/vFEkS6I0rsmexVRW8Xu/wq1t1ve65B6G3L
         kiNQ==
X-Gm-Message-State: AOJu0YzxoMJR4xljMxVI6vU40JwreHP5tiixbCwjzvSh7T+FV5YpNjFr
	14uLuHoE3xqmHlzQ8s3SW3XDA41Vz27PVf1lUL3f9wqs7SDStlTp9ufZ/s09rds=
X-Google-Smtp-Source: AGHT+IEpKZ7BdUxo7eFvi5dr4pREANLXDzvgae6ztSZBfYbsmUCMqR86IPgDWtDdgcEzvbYQJ1xhiw==
X-Received: by 2002:a05:600c:4ba2:b0:41a:9fc2:a6b1 with SMTP id 5b1f17b1804b1-41feaa4352amr94789015e9.22.1715691284859;
        Tue, 14 May 2024 05:54:44 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:3f47:f219:de13:38a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f88111033sm229322815e9.34.2024.05.14.05.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 05:54:44 -0700 (PDT)
References: <20240514101006.678521560@linuxfoundation.org>
 <20240514101010.464612719@linuxfoundation.org>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, Dmitry Shmidt
 <dimitrysh@google.com>, Neil Armstrong <narmstrong@baylibre.com>, Jerome
 Brunet <jbrunet@baylibre.com>, Mark Brown <broonie@kernel.org>, Sasha
 Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 100/168] ASoC: meson: axg-card: Fix nonatomic links
Date: Tue, 14 May 2024 14:26:02 +0200
In-reply-to: <20240514101010.464612719@linuxfoundation.org>
Message-ID: <1j34qkzh7w.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 14 May 2024 at 12:19, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> 5.15-stable review patch.  If anyone has any objections, please let me know.
>

Patch #100 and #101 should not be applied on v5.15.

A bit of history:
* 3y ago patches #44 and #45 have been applied to fix a problem in AML
  audio, but it caused a regression.
* No solution was found at the time, so the patches were reverted by
  change #100 and #101
* Recently I came up with change #43 which fixes the regression from 3y
  ago, so the fixes for original problem could be applied again (with a
  different sha1 of course)

The situation was detailed in the cover letter of the related series:
https://lore.kernel.org/linux-amlogic/20240426152946.3078805-1-jbrunet@baylibre.com

From what I can see the backport is fine on 6.8, 6.6 and 6.1.
Things starts to be problematic on 5.15.

In general, if upstream commit b11d26660dff is backported, it is fine to
apply upstream commits:
 * dcba52ace7d4 ("ASoC: meson: axg-card: make links nonatomic")
 * f949ed458ad1 ("ASoC: meson: axg-tdm-interface: manage formatters in trigger")
And the following commits (which are reverts for the 2 above) should not be applied:
 * 0c9b152c72e5 ("ASoC: meson: axg-card: Fix nonatomic links")
 * c26830b6c5c5 ("ASoC: meson: axg-tdm-interface: Fix formatters in trigger"")

If b11d26660dff is not backported, the 2 first change should be
backported, or reverted if they have already been.

* v5.15: just dropping change #100 and #101 should be fine
* v5.10: I suppose this is where the backport starts to be problematic
         Best would be to drop #31, #32, #73 and #74 for now
* v5.4: Same drop #26, #27, #60 and #61
* v4.19: drop #17 and #44

Regards
Jerome

> ------------------
>
> From: Neil Armstrong <narmstrong@baylibre.com>
>
> [ Upstream commit 0c9b152c72e53016e96593bdbb8cffe2176694b9 ]
>
> This commit e138233e56e9829e65b6293887063a1a3ccb2d68 causes the
> following system crash when using audio on G12A/G12B & SM1 systems:
>
>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:282
>   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/0
>  preempt_count: 10001, expected: 0
>  RCU nest depth: 0, expected: 0
>  Preemption disabled at:
>  schedule_preempt_disabled+0x20/0x2c
>
>  mutex_lock+0x24/0x60
>  _snd_pcm_stream_lock_irqsave+0x20/0x3c
>  snd_pcm_period_elapsed+0x24/0xa4
>  axg_fifo_pcm_irq_block+0x64/0xdc
>  __handle_irq_event_percpu+0x104/0x264
>  handle_irq_event+0x48/0xb4
>  ...
>  start_kernel+0x3f0/0x484
>  __primary_switched+0xc0/0xc8
>
> Revert this commit until the crash is fixed.
>
> Fixes: e138233e56e9829e65b6 ("ASoC: meson: axg-card: make links nonatomic")
> Reported-by: Dmitry Shmidt <dimitrysh@google.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
> Link: https://lore.kernel.org/r/20220421155725.2589089-2-narmstrong@baylibre.com
> Signed-off-by: Mark Brown <broonie@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  sound/soc/meson/axg-card.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
> index cbbaa55d92a66..2b77010c2c5ce 100644
> --- a/sound/soc/meson/axg-card.c
> +++ b/sound/soc/meson/axg-card.c
> @@ -320,7 +320,6 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
>  
>  	dai_link->cpus = cpu;
>  	dai_link->num_cpus = 1;
> -	dai_link->nonatomic = true;
>  
>  	ret = meson_card_parse_dai(card, np, &dai_link->cpus->of_node,
>  				   &dai_link->cpus->dai_name);


-- 
Jerome

