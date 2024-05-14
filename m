Return-Path: <stable+bounces-45077-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F7D8C5675
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 15:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41CBA1C2207B
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B1813FD99;
	Tue, 14 May 2024 13:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="FdW054Tr"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28113FD8D
	for <stable@vger.kernel.org>; Tue, 14 May 2024 13:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691656; cv=none; b=fo6J/z5hucJ7Q2znjonV5vS5CfdrjxrEyD6r7KYSA9eVdiK22Ern8AelxS/1A5mW2bnurRdi/rO8jlHk0+YNHPLqdg/0KclT1/7MGZ575Yco0rhSv9yguC7QG0vzMTvnfyfbEPx3H93FjeJh4+QdQmCXpNHiCSJhSih58ZKkWcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691656; c=relaxed/simple;
	bh=d8ShiMrXR3emIyflcfbffRIzJLRaSStiK2f67HCN7WU=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=rICAfAwfj+KJ4rIF6FSsWmpwwcSa5R5NrQ5a93/+5MDr+T6aNjYQJBxG4tAVC8WODYHbgRdIMQOmvESoNjM0cQsYt8gZgm67Edj4HB649a9XGadaOVsp74w4Hfz/dxASeIooj82bqg2DrsxlLdBs/4T4ZNYjkWj5J4uTjYWRujo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=FdW054Tr; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-41fd5dc0439so37638345e9.0
        for <stable@vger.kernel.org>; Tue, 14 May 2024 06:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1715691652; x=1716296452; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=DsS116Yyx1MUvHVpDg7nSKFadAoyOcppPeidrMbDBz0=;
        b=FdW054TrVXCaIBy+mrLnL8PgxsFKAWEz4aW7/E9PwhRkPG+IT4NWwCFkyFKh38EN3X
         csZDNZr+gU3EVs5PtPI/ohJMvjKpbvyOL/3PlucMm8kQa86eDCB+20W0GGoTxlCrb8/x
         1ojht4O9foyNEfp7x+M1jPKqfR8qt6kJPK/Oo9xsv9iul//2ucg9aFUUV4mHSVDeU/mB
         lkzmV5Pvfn8vGuMTutxdB9tVxqGfLx/VFZvZ4v8+dxLtTurGvJhs27M60/ed8Mzkgp3V
         W4q98yier7ryteg4E/K3LoxGTSwqeXRo/ZLiaMXdFK7lmI9T6UuV8azSsVWvRCih/9K3
         OKjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715691652; x=1716296452;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DsS116Yyx1MUvHVpDg7nSKFadAoyOcppPeidrMbDBz0=;
        b=YtFSoCZK9Cj9PTQk5UaYefOw2VlYRalWhX0FsPQb99GOZAbCj+boKizXm8em1kg5rS
         3zOulrFaV8tvo0yDcsy3yKK4dL9EF52hT2ff1JU2nw6A5DOB49Lg4ZOgu4TOXHZhgqgg
         +PRdv1Hx3/OEbgRUiFkOTOqI6bt42V7BoxO9pwu4+GZDHj1hQoQrTrVSSp4qX4EtL8/9
         cTNx+7jowFYY/MI8JAe69RkDkQCG4Ipx8AYuFFaifRq73lpsYASUGblDR1GtsJpFCRXx
         Nl2fx/Rt3T1Jhd5n284Av5zPVyLsfXhQ89k1LR7omNdl+kM44BnQlRR82a0vZns211zs
         VYMQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoU5/lE7XjvbifJZEKMVpXXICGVvnustnZGXU0b4+YpdWsiQ1U6lx2mNO7EMv46Tu19DmpfNmpiaADdtvlAjd/dEHM/z2m
X-Gm-Message-State: AOJu0YzZ79vOG0mCepEnT7Wq9/wvBsrBKe1AB0wz0Fj7AmxCHRf274xe
	+0UyF+KdNN0NOhQZK+6sOdqitzz0YPTsAAlqaqbgm3PrpQYydq16Q3XbeKBob7A=
X-Google-Smtp-Source: AGHT+IF/kooVLPziGy/T8RjYW2nok5uQj3lsw4aJLqNMyq5n94FloOztr3X9LnFp6kooH/E3rnpuGg==
X-Received: by 2002:a05:600c:1f83:b0:41a:b961:9495 with SMTP id 5b1f17b1804b1-41feac49164mr93979525e9.25.1715691652011;
        Tue, 14 May 2024 06:00:52 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:3f47:f219:de13:38a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42016b88f99sm67585325e9.10.2024.05.14.06.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 06:00:51 -0700 (PDT)
References: <20240514101006.678521560@linuxfoundation.org>
 <20240514101010.464612719@linuxfoundation.org>
 <1j34qkzh7w.fsf@starbuckisacylon.baylibre.com>
User-agent: mu4e 1.10.8; emacs 29.2
From: Jerome Brunet <jbrunet@baylibre.com>
To: Jerome Brunet <jbrunet@baylibre.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 patches@lists.linux.dev, Dmitry Shmidt <dimitrysh@google.com>, Neil
 Armstrong <narmstrong@baylibre.com>, Mark Brown <broonie@kernel.org>,
 Sasha  Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15 100/168] ASoC: meson: axg-card: Fix nonatomic links
Date: Tue, 14 May 2024 14:59:52 +0200
In-reply-to: <1j34qkzh7w.fsf@starbuckisacylon.baylibre.com>
Message-ID: <1jy18cy2d9.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On Tue 14 May 2024 at 14:26, Jerome Brunet <jbrunet@baylibre.com> wrote:

> On Tue 14 May 2024 at 12:19, Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
>
>> 5.15-stable review patch.  If anyone has any objections, please let me know.
>>
>
> Patch #100 and #101 should not be applied on v5.15.
>
> A bit of history:
> * 3y ago patches #44 and #45 have been applied to fix a problem in AML
>   audio, but it caused a regression.
> * No solution was found at the time, so the patches were reverted by
>   change #100 and #101
> * Recently I came up with change #43 which fixes the regression from 3y
>   ago, so the fixes for original problem could be applied again (with a
>   different sha1 of course)
>
> The situation was detailed in the cover letter of the related series:
> https://lore.kernel.org/linux-amlogic/20240426152946.3078805-1-jbrunet@baylibre.com
>
> From what I can see the backport is fine on 6.8, 6.6 and 6.1.
> Things starts to be problematic on 5.15.
>
> In general, if upstream commit b11d26660dff is backported, it is fine to
> apply upstream commits:
>  * dcba52ace7d4 ("ASoC: meson: axg-card: make links nonatomic")
>  * f949ed458ad1 ("ASoC: meson: axg-tdm-interface: manage formatters in trigger")
> And the following commits (which are reverts for the 2 above) should not be applied:
>  * 0c9b152c72e5 ("ASoC: meson: axg-card: Fix nonatomic links")
>  * c26830b6c5c5 ("ASoC: meson: axg-tdm-interface: Fix formatters in trigger"")
>
> If b11d26660dff is not backported, the 2 first change should be
> backported, or reverted if they have already been.

If b11d26660dff is not backported, the 2 first change should *NOT* be
backported, or reverted if they have already been.

Sorry for the confusing typo

>
> * v5.15: just dropping change #100 and #101 should be fine
> * v5.10: I suppose this is where the backport starts to be problematic
>          Best would be to drop #31, #32, #73 and #74 for now
> * v5.4: Same drop #26, #27, #60 and #61
> * v4.19: drop #17 and #44
>
> Regards
> Jerome
>
>> ------------------
>>
>> From: Neil Armstrong <narmstrong@baylibre.com>
>>
>> [ Upstream commit 0c9b152c72e53016e96593bdbb8cffe2176694b9 ]
>>
>> This commit e138233e56e9829e65b6293887063a1a3ccb2d68 causes the
>> following system crash when using audio on G12A/G12B & SM1 systems:
>>
>>  BUG: sleeping function called from invalid context at kernel/locking/mutex.c:282
>>   in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 0, name: swapper/0
>>  preempt_count: 10001, expected: 0
>>  RCU nest depth: 0, expected: 0
>>  Preemption disabled at:
>>  schedule_preempt_disabled+0x20/0x2c
>>
>>  mutex_lock+0x24/0x60
>>  _snd_pcm_stream_lock_irqsave+0x20/0x3c
>>  snd_pcm_period_elapsed+0x24/0xa4
>>  axg_fifo_pcm_irq_block+0x64/0xdc
>>  __handle_irq_event_percpu+0x104/0x264
>>  handle_irq_event+0x48/0xb4
>>  ...
>>  start_kernel+0x3f0/0x484
>>  __primary_switched+0xc0/0xc8
>>
>> Revert this commit until the crash is fixed.
>>
>> Fixes: e138233e56e9829e65b6 ("ASoC: meson: axg-card: make links nonatomic")
>> Reported-by: Dmitry Shmidt <dimitrysh@google.com>
>> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> Acked-by: Jerome Brunet <jbrunet@baylibre.com>
>> Link: https://lore.kernel.org/r/20220421155725.2589089-2-narmstrong@baylibre.com
>> Signed-off-by: Mark Brown <broonie@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>  sound/soc/meson/axg-card.c | 1 -
>>  1 file changed, 1 deletion(-)
>>
>> diff --git a/sound/soc/meson/axg-card.c b/sound/soc/meson/axg-card.c
>> index cbbaa55d92a66..2b77010c2c5ce 100644
>> --- a/sound/soc/meson/axg-card.c
>> +++ b/sound/soc/meson/axg-card.c
>> @@ -320,7 +320,6 @@ static int axg_card_add_link(struct snd_soc_card *card, struct device_node *np,
>>  
>>  	dai_link->cpus = cpu;
>>  	dai_link->num_cpus = 1;
>> -	dai_link->nonatomic = true;
>>  
>>  	ret = meson_card_parse_dai(card, np, &dai_link->cpus->of_node,
>>  				   &dai_link->cpus->dai_name);


-- 
Jerome

