Return-Path: <stable+bounces-72717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2737696871F
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 14:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2F7F1F22F10
	for <lists+stable@lfdr.de>; Mon,  2 Sep 2024 12:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227AA200108;
	Mon,  2 Sep 2024 12:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DCy79wFz"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760441DAC5C
	for <stable@vger.kernel.org>; Mon,  2 Sep 2024 12:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278924; cv=none; b=dv1g76JzGpC6+YsPFMws18Jc/BxdJ3lMIhrZbt0gOzI+F+C7fDMcrPBSIMpmYfvJdTdtHC8az2e9D5Gdfl7gPJ7khTn0B9DmUj63SfQ3AWwG6GP0/i+eaTJBDc++ZTUvUWPSoXRbr89NM+F29LlRqOq0rmfIcmIVEfuKaBUFhLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278924; c=relaxed/simple;
	bh=/fmn1tpBsaiU5ZR2h6nBaQpwU2eBecY+EFs72kIYxMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iYmFUUhhhUw3gd1Pks8cK1uagyk9JF8lALNQ27fVRyU4n5dtYjvx5xm8nGDcvbt3bCjE1LNAD0HXVJwzukzPGHMLMXL96ZRzVXh92fi/7YHiyOf31P2M/pXOXrP5PuYv1y7DiLk+exj2/Uv3T9zNFfeZRhlCEq7g2paDxEHVKwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DCy79wFz; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f40a1a2c1aso38825011fa.3
        for <stable@vger.kernel.org>; Mon, 02 Sep 2024 05:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1725278921; x=1725883721; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/fmn1tpBsaiU5ZR2h6nBaQpwU2eBecY+EFs72kIYxMo=;
        b=DCy79wFzidVjE1v72eMEDUy/33AlVZ/XbuhwgGoJZHQD3BobOZxG6KHIEFp+/sPhCm
         +IdB0SF6GtRgaNOZpmUxllF6/Sc8LMKPAK+n/g6/wH1/+pe1fnQl/10U0Zh0eXs3y5Mz
         MmUJKgx8JJAqb/wfHD0PVAPbU0XFoSDNDYC7/JW2KufaRYV7+S0TSKmh2Ug8oMh/bXv8
         L9vj32WqY/s0dpFaYHPPWWqFDA1jVXksc4Ize8o9M+vxk7flvUKW986ujiEUN07YWe9m
         MtomqR5/RTGc3njQ+B+Qt1scgfKwjvFyisjtdWW4gCHo3+XFS+AEBjXOVH7S3BJCwEat
         Z5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725278922; x=1725883722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/fmn1tpBsaiU5ZR2h6nBaQpwU2eBecY+EFs72kIYxMo=;
        b=ba5b2SYsO3JT5+8neE0BjqEmjVjaqD8n8W1+hIL7R0TgOTJe6inJQo7eMTuA9BmJZ8
         +FC863YtNltKD5T19LlYiMNBSa253rhbPfF3mzdkIyMCRt6TranPC9sxX/A3rVhLO6cq
         j9VlRC2Yzmr3cNtCkf8J0XoyozdEScdqu1RokbdNroX63rAG27gzEu/O8N+DPGgbsNra
         S1dt9cqT9GTqE3wVO7qJvkdVUgKOkgq3AbqXko8pigt94R/qG9EoqC2DpKn/6HlBN54X
         K6nC8jYUWHlFR/WoQKxBJriO5HFI8MMAPFayVCVzim+3jH4HFKRbBUVzuuCPNyEeFVA+
         hBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWBZa5sXxRbGkd8UYPU++pNZqei/eIoc3oB64MgzwHx0wHKTMu3tWhPPwDS9bmQ+uUPMtCoztc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7pcAxVS1FWzbqNEsKdtwiPUuFamvflm82z1jRHzwy1fxoVpp+
	CDxivdP1lXj/nkIkBzHCrrKRTDvcfXAPvvrk8GoAXWQutMFIiORIE8BlLwb5NCF7itLhd9XBzOr
	k49RgclqGLNgxUEdrJNNgQkXMD8VVl5g2mx8sdA==
X-Google-Smtp-Source: AGHT+IEwniVjpUcHNV2PgckQjJz6SBHI6ttgJLYd0oBUrlEr8cM8Ja57SNENZ/8PhY5yQ9vuQ+p9+Vh5WTkPLL6qeN4=
X-Received: by 2002:a2e:5149:0:b0:2ef:23ec:9353 with SMTP id
 38308e7fff4ca-2f6104f27a6mr75282841fa.38.1725278920963; Mon, 02 Sep 2024
 05:08:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828133207.493961-1-parth105105@gmail.com>
In-Reply-To: <20240828133207.493961-1-parth105105@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 2 Sep 2024 14:08:30 +0200
Message-ID: <CAMRc=MdyNFzNy_GndBDOUL23Rv0WxGG8mRd5DRD28pE=XuhfmQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: davinci: fix lazy disable
To: Parth Pancholi <parth105105@gmail.com>
Cc: Keerthy <j-keerthy@ti.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Parth Pancholi <parth.pancholi@toradex.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:32=E2=80=AFPM Parth Pancholi <parth105105@gmail.c=
om> wrote:
>
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
>
> On a few platforms such as TI's AM69 device, disable_irq()
> fails to keep track of the interrupts that happen between
> disable_irq() and enable_irq() and those interrupts are missed.
> Use the ->irq_unmask() and ->irq_mask() methods instead
> of ->irq_enable() and ->irq_disable() to correctly keep track of
> edges when disable_irq is called.
> This solves the issue of disable_irq() not working as expected
> on such platforms.
>
> Fixes: 23265442b02b ("ARM: davinci: irq_data conversion.")
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> Signed-off-by: Parth Pancholi <parth.pancholi@toradex.com>
> Cc: stable@vger.kernel.org
> ---

It looks good to me but I'd like to have an Ack from Keerthy on this.

Bart

