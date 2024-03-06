Return-Path: <stable+bounces-27024-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C398742DE
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 23:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537E01C22F52
	for <lists+stable@lfdr.de>; Wed,  6 Mar 2024 22:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496FB1B968;
	Wed,  6 Mar 2024 22:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pThmoOQf"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6061C2A8
	for <stable@vger.kernel.org>; Wed,  6 Mar 2024 22:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764773; cv=none; b=cRd3Zr6HqX8KLyuSd0hBW49yKssGyDbYZ8Zbk852/x1alCG9smpuRWsk7zG5b0pPZYW5O++39yyNlEyWcUuyCvWfnhzqzwmuxWr8eM6xcrc23rqHwDIIYepeA+2DDUZOZoBbUm1/xef6AlYcOVLNNv4Wyio383TMut13LAydeUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764773; c=relaxed/simple;
	bh=JxK17bHEwL0YPMpQY4ljZfLKRGGd9JkkHlt2xcABl+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Dle3xWld9PkBhCsxpJhfHxcAR8WcGbvw5sv3NrGy3lbo2OdA0cV09G07avbFpWrTShtItqd+wzwxpOfElPbsGx2PX6qvo9flqh3rtblEqU9VRu8uHkyS5ZwyaDcvDtXBqRzL8BXIaV0m0InjYSLZlCVn9Ms/BLmp7hsihWqIrws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pThmoOQf; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc6fc978ddso308242276.0
        for <stable@vger.kernel.org>; Wed, 06 Mar 2024 14:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709764770; x=1710369570; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JxK17bHEwL0YPMpQY4ljZfLKRGGd9JkkHlt2xcABl+s=;
        b=pThmoOQfMz+w/vR7mFY0J5Qc+bczUVAC1A81/prY6W3YPurWE4Bb88z60JRKwMNONn
         EgZ/korQnPoPIGuD5J2Y0TIbwdEJc8y59X4l+4RSfPnX0V7pamJcztyDgURUpOM44Ihe
         bUM9fb6wghwFVAQ2/0FHyrMUakYeNWeOsqjpYHfogZhpZVFddKtrfRZU+Eu+JyC4oJn9
         Vt95RkVzgU+AK2Lyxu4I9GPV9vSZjj6lp4UCqL9b+StJHYDUI22sWdyPKOwCvCYmBprP
         ZsECEwZWw+UpvwX19PUAFPRAFc1gwwoqRmNoSIWwDY8eWng/+/+44RnGEkGwIeKvEuMo
         dI/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709764770; x=1710369570;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxK17bHEwL0YPMpQY4ljZfLKRGGd9JkkHlt2xcABl+s=;
        b=HAh6hlOwaL303Cwu8y/y2iNh0kQwAfeB41M4XvoTRdHGojF6CZccWhwN0QBCBuLAo0
         GcP+f7yJOG9CX3ODoz8rDLCmfKRCGyVXS1E4wMq+9ErB3iQupG+jJBFzJtJdAI8cTrU7
         tVQj0myTZL9TQ01VxcTesdlNVxexnIO6/Zwkcm9vghkaiwmUUMuPmUI/kTdJA2TWDnCc
         YfSLA014qTmNbj1IqMlU7UWPqrVHH59kH+jhWs11Naxc8rR39VHzoXxxKUMH0V4jELf/
         fdKesxEVMJAK5HwNGaziCnEL7TkN0uJ0z8LqlXiqjqeHVWphWsKmB76a1P803AeBWeis
         Jc8Q==
X-Forwarded-Encrypted: i=1; AJvYcCX87aCKNSc+b0cdP0YvPSbv3MI8z/zi1wsH1MLic8ARd3wgn0YDDaZddiiPmTqXje/WSqepkrGaUEch9fKCfwJYhapruwM2
X-Gm-Message-State: AOJu0YzmYREFpwd7hgaLalxeSxjdG+LSqNmBrx3lUoGjDyzF6YBNwruY
	ICrkovUlOWRxZFZxxRX/+V7PItBLlhqXaZ54BVDi4htNlhFpUaO0RuV+Vir9PS4Z+p+OdFHI5Tt
	9iWAo5MZoYFBYkWQgVRwSybJQLCVrEeYAK/rWVpbwHKVfb/Bj
X-Google-Smtp-Source: AGHT+IF61VY2gTAQCgd0GZml0xM8R/GEGUIKU510VpCSAhmbFuO44X6XOlsxI9rQaspybfokha3bpCBK5RV4BUdg46A=
X-Received: by 2002:a25:d652:0:b0:dcf:eb30:c580 with SMTP id
 n79-20020a25d652000000b00dcfeb30c580mr1222007ybg.3.1709764770305; Wed, 06 Mar
 2024 14:39:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306-mmc-partswitch-v1-1-bf116985d950@codewreck.org>
 <Zegx5PCtg6hs8zyp@trax> <CACRpkdYZrDgVVCp2bqJqY1BpeHSXDWbRSqk6d=N_QhC4OVv=Ew@mail.gmail.com>
 <Zeh8HGDToMoHglD2@trax> <CACRpkdZ1ervTXj6++oBPDNJT3TpVgPeYsyhaEMRYavJQ5iZPqg@mail.gmail.com>
 <CAPDyKFqYDPgNjSkpH=XATkUY2XtjsaDstChcAnGxoas4jgDVfw@mail.gmail.com> <CACRpkdaUUD8UMp9GxNVQfdAM8QV_LASp-k5hh1cvQrGVHKySKA@mail.gmail.com>
In-Reply-To: <CACRpkdaUUD8UMp9GxNVQfdAM8QV_LASp-k5hh1cvQrGVHKySKA@mail.gmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 6 Mar 2024 23:38:53 +0100
Message-ID: <CAPDyKFrdki=OyQWHghF6R3ukv9R6FRQfxRbUrSKfVJ+CNCjXTQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: part_switch: fixes switch on gp3 partition
To: Linus Walleij <linus.walleij@linaro.org>, Dominique Martinet <asmadeus@codewreck.org>
Cc: "Jorge Ramirez-Ortiz, Foundries" <jorge@foundries.io>, Jens Wiklander <jens.wiklander@linaro.org>, 
	Tomas Winkler <tomas.winkler@intel.com>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Dominique Martinet <dominique.martinet@atmark-techno.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 at 20:49, Linus Walleij <linus.walleij@linaro.org> wrote=
:
>
> On Wed, Mar 6, 2024 at 4:57=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.or=
g> wrote:
> > On Wed, 6 Mar 2024 at 15:38, Linus Walleij <linus.walleij@linaro.org> w=
rote:
>
> > > We should probably rename it part_cfg because that is what we
> > > store in it, it's assigned from card->part[idx].part_cfg.
> > >
> > > Then the id field in mmc_rpmb_data should be deleted along
> > > with all the IDA counter code etc and the partition name hardcoded
> > > to be "0" as there will never be anything else.
> >
> > Seems reasonable to me. Are you thinking of sending a cleanup patch on
> > top of $subject patch?
>?
> Yes I can do that once this patch is finalized and merged.

Great!

I don't think the $subject patch is perfect, but it's slim and
suitable for stable - and of course it seems to do the job well. I am
therefore queuing it for fixes, thanks everyone for helping out!

Kind regards
Uffe

