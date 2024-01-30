Return-Path: <stable+bounces-17415-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E84384267D
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 14:53:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5241F28217
	for <lists+stable@lfdr.de>; Tue, 30 Jan 2024 13:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E268E6D1BF;
	Tue, 30 Jan 2024 13:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IgqP/mJE"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4B6D1A6
	for <stable@vger.kernel.org>; Tue, 30 Jan 2024 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706622788; cv=none; b=kaQDc+SnmYJGzSwI7CV7WxLi8fe2ixKazPOdlWQHZTaJjRbow4CWgCkJGzz3l63lRZJ53+fLVg+LtPXERTmYQea7h3pLP1SOEDvkOTsp+PsQFdq//ac8/cW4LhmpzgSs9LCKoVVaEkGpzkB4ca0EJSrLD9UxzdQbB+BudnkTsGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706622788; c=relaxed/simple;
	bh=D9dIR0Cs9lPWvqOlOGFVUk7yU7P74sxwZRjAdxW64eA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sl5BWPwOwrFSy3k3sBIyiLTPQ9xxcDQMlC7jV4ZwuyTBe1F1JN0zh1kB32LJazTJOKZf4BktQH1jjcF1WVYiDOE6A8N2jigZf63V2fhbf7PrWlV5+YaFylkWh5mlTxkhfyMV6pDtEzoROZ/ToM2kNOO4a6BYCJKcOyIgfpVBd2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IgqP/mJE; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4bdb8de8f45so899973e0c.2
        for <stable@vger.kernel.org>; Tue, 30 Jan 2024 05:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706622785; x=1707227585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D9dIR0Cs9lPWvqOlOGFVUk7yU7P74sxwZRjAdxW64eA=;
        b=IgqP/mJEBzFSla5NshZt4PjQZDqbg1LLoe/xZTW11Re5+i7ehnycV8He+SvTuhqaRd
         XvA8a7hkJZyMqfw2jSt59kW22IET0iukf5JnH/BoKHac+Mbwp5dyxAarTNORgDQ+UCBU
         ReQrFsGVVHJ8ZuNHiNt+rFkvgqTw8Up8MLc264n547bRHQWUjJXQ9vNDxR53ohs2tzcC
         E4fDa5UEoA9fkNsUqAwR8YZL20bUOc7O0CMLyQIy0TkkIIBOMZWRhIeD1ekkALBsbU8d
         oJ0hL6bTD7sVgjnhe1c6J7C7hRD/UBiULZ6oJFaJ/aT1nOCocKYiIYp64nsY9AK6ZpJQ
         If0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706622785; x=1707227585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D9dIR0Cs9lPWvqOlOGFVUk7yU7P74sxwZRjAdxW64eA=;
        b=Lx071lpD8jB4qnTBGvozYcuW0d8MaDNOvTVqZGDGCt8Q8NW8ufg5DHdOyBQ+eBeALe
         5TZllHJQeyN1Y151mB/HeCRS4Mlp5C44wah2bnSP7cNHbkJuQQQ/ZkQa+UZTIlZ2O1oo
         zxGOcNyuRE+zkd6xni+LZBpsrgTuaTHFOnkbaYSMeDTk1cE+SYcreQsTEbzpZ3++wvHi
         x3fPZbv1j5BCCh4gMmasWm5Me5SiPm6OC9RSla2F0ToYSWcMQnGqGwWs/d/37pYrQhrH
         6QazzTEFwmdyfMrdjT31kKk6OpXIe9RCF7IETZtNesJp/ZOzSBSuH7P2QQ8+oelv/ZPm
         gsUQ==
X-Gm-Message-State: AOJu0YzXtf+KRXX8+mvSH0NZml/tMgBG+60AoPS4j4WehfxM0t0h0NYz
	HrKGx0L+0ILxjMmetr+aqe5pSnqj/FD9dNpqYW4zbV8AI4S6+EWZM2HqCo9mV+lLcnNraR0KJNS
	0EvWo+MX3kkVrSHUrkzdo7Plfd9RzYcaF7IVrFg==
X-Google-Smtp-Source: AGHT+IEtZo6GcqJWAG/6NzT0Y5pXocVHfFtQ7TejteSyqExxj0iMJhYcrRQktlFiTbYFhdEz8xGLIg3KYKQECdCbRpM=
X-Received: by 2002:a1f:ca42:0:b0:4bd:774d:d7ea with SMTP id
 a63-20020a1fca42000000b004bd774dd7eamr3375083vkg.7.1706622785411; Tue, 30 Jan
 2024 05:53:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129103902.3239531-1-amit.pundir@linaro.org>
 <2024012936-disabled-yesterday-91bb@gregkh> <CAMi1Hd19ox3b__mUk=VTxj_eRuzGYhzECTQ3sCrAzcpiQDJe5Q@mail.gmail.com>
In-Reply-To: <CAMi1Hd19ox3b__mUk=VTxj_eRuzGYhzECTQ3sCrAzcpiQDJe5Q@mail.gmail.com>
From: Amit Pundir <amit.pundir@linaro.org>
Date: Tue, 30 Jan 2024 19:22:28 +0530
Message-ID: <CAMi1Hd2jwt4G4f=3Jh5+uoSiVcw_PqKQXcHq1wipF15uwTdbdw@mail.gmail.com>
Subject: Re: [PATCH for-5.4.y 0/3] db845c(sdm845) PM runtime fixes
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 29 Jan 2024 at 22:59, Amit Pundir <amit.pundir@linaro.org> wrote:
>
> On Mon, 29 Jan 2024 at 21:51, Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Jan 29, 2024 at 04:08:59PM +0530, Amit Pundir wrote:
> > > Hi,
> > >
> > > v5.4.y commit 31b169a8bed7 ("drm/msm/dsi: Use pm_runtime_resume_and_get
> > > to prevent refcnt leaks"), which is commit 3d07a411b4fa upstream, broke
> > > display on Dragonboard 845c(sdm845). Cherry-picking commit 6ab502bc1cf3
> > > ("drm/msm/dsi: Enable runtime PM") from the original patch series
> > > https://patchwork.freedesktop.org/series/119583/
> > > and it's dependent runtime PM helper routines as suggested by Dmitry
> > > https://lore.kernel.org/stable/CAA8EJpo7q9qZbgXHWe7SuQFh0EWW0ZxGL5xYX4nckoFGoGAtPw@mail.gmail.com
> > > fixes that display regression on DB845c.
> >
> > We need fixes for all of the newer stable trees too, you can't fix an
> > issue in an old tree and then if you upgraded, you would run into that
> > issue again.
> >
> > So please, resend this series as a set of series for all active lts
> > kernels, and we will be glad to queue them up.
>
> Ack. I'll send the patch series for all the active LTS kernels
> tomorrow after build/boot testing them locally. Meanwhile please
> consider this patch series for v5.4.y anyway.

Smoke tested and sent relevant fixes for other active LTS kernel
versions as well.

v5.10.y https://lore.kernel.org/stable/20240130124630.3867218-1-amit.pundir@linaro.org/T/

v5.15.y https://lore.kernel.org/stable/20240130125847.3915432-1-amit.pundir@linaro.org/T/

and v6.1.y+ https://lore.kernel.org/stable/20240130134647.58630-1-amit.pundir@linaro.org/T/

>
> Regards,
> Amit Pundir
>
> >
> > thanks,
> >
> > greg k-h

