Return-Path: <stable+bounces-67449-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F44995025C
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 12:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1571C284F00
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 10:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E34A118CBE1;
	Tue, 13 Aug 2024 10:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dBBK4K5g"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB03618A95E
	for <stable@vger.kernel.org>; Tue, 13 Aug 2024 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723544618; cv=none; b=YcGotXWaLqPDn2eNH2o03r9hWNCVAc/Ee02YOdK3yBGEyX7mq7SPLB+RmZBdqeM6TA/tCrfFI8fX3fuu74R/YCFz24YCq5ql7CMKHzIHdWEHHpCmcC69Jf9bneUT6SxPnZyUfG+6xNsNYk8aJftIvQTUnKofFO6nU/NWZ0Q1OTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723544618; c=relaxed/simple;
	bh=SXR+0wrp3jkLlL1M88GGnn0JcEZQsqknpxVcuv87DLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eCzY+JjZwForLL84NUfrJal+N+TbtKx30/zAe2LGUYF4ZtCYHj4PLlZNBm1gNdVYLglOgKAfUBPA3DBUivzxDq0LNRCbXK0y0SRkoTwki5S3weNU/eG8hD5ENmLfrx1kIS1XoM0ZAeqI9rGkOybjOcPzA4eh2E8nVrn/iFH3hLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dBBK4K5g; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2f189a2a841so50875601fa.3
        for <stable@vger.kernel.org>; Tue, 13 Aug 2024 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723544615; x=1724149415; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SXR+0wrp3jkLlL1M88GGnn0JcEZQsqknpxVcuv87DLY=;
        b=dBBK4K5g8k1eR7DQ4hb/bw7LRTFX8j58dnWblOgS2wakpblKBoLLQe5j6AffYfQVxK
         8uIQJERXlfQKERWoig1l1qUqEsHdrA2Us2qKmX55XN16W+Pe2D5aQe58jVQDo9NhQ118
         fpsQl3/kFvV9PbhRag1srK+9lBxjtklkm6jCSbGkU/XPRF6sHERyt0lWgh2aEwXcvfEf
         hK2+QB/FXdnSn3G6tOfV/Zgqcn5CF7aYJx1GTdpz3YE2EibR9aWHsBecezHwLrAQ3xq7
         Qtcy7R5Ycf79Z3irqtCYBxQXGBBeqkXGgvCmxvVd2BaVRBm1f5md0sGv4SfQg+1pt0PY
         iXOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723544615; x=1724149415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SXR+0wrp3jkLlL1M88GGnn0JcEZQsqknpxVcuv87DLY=;
        b=D1KIITVs5mg03jT1C1AMBzf53VEU4n2DagQ8GK+XfSgSm3zWKAPYKRBNlPVb9+Epob
         vcVEMZvQS8coaqVrbc9svQUARIXTwXytEaOYwCDpn6q4bHA1BaGhpyim0z9dl2P+5gMr
         T2lXgEKBSb9Q9yFtWeWvTz8s8G4Tsg6m3U3UxZ/H8/xxBw/sSaKrh021rtB8aNC4dclJ
         nzEJQFPm6mVLYcCW7p0/mf8HvXbNFl5zvohn62XnesUSZqUn637J2Uw82ChoH5NZ5S9K
         nYMwGVFTzRIS1ffNZTUKXn+LsUnU8Hh3uLAZcO6JT3Wz9+Y6vyDIJXomSTrdJy4gUJDa
         7Clg==
X-Forwarded-Encrypted: i=1; AJvYcCUjnKCaAH5VxEqvMycQpLkyUiY3YptxneDOMKiVK600J1iImClUZtLui4m+EosiRQt4SheNdyxxITkM6lnwdEHgAEXv5Z/a
X-Gm-Message-State: AOJu0Yzx//GDFDC2hcA42wC93cYD8EBL02CLvv3TpUWxIEpJqAv/Ca1p
	Z+2WBH/ZG4dOD7iTNw/ukRhOXvXlwsSI9v0n48ZbI0mJoNOvAStVUtpBaJNhxM+tRMP/YXsvrKd
	mfTFwk61i3oyFCqf/aDQ2ifFIbbjPXO98S2DQfg==
X-Google-Smtp-Source: AGHT+IFjVOVWHVikFrMFJYrrlEXM/z4v/cbwHsDAT/9KwTekVhh0t3MU/2ExmVGbr2SJOIV0DRPOCvvj2rrJGQZeorA=
X-Received: by 2002:a2e:711:0:b0:2ef:c281:54f7 with SMTP id
 38308e7fff4ca-2f2b717ca70mr18026791fa.37.1723544614576; Tue, 13 Aug 2024
 03:23:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240808042858.2768309-1-make24@iscas.ac.cn> <20240808061245.szz5lq6hx2qwi2ja@pengutronix.de>
 <1b04b8b3-44ca-427f-a5c9-d765ec30ec33@app.fastmail.com>
In-Reply-To: <1b04b8b3-44ca-427f-a5c9-d765ec30ec33@app.fastmail.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 13 Aug 2024 12:22:57 +0200
Message-ID: <CAPDyKFqd=haDWB3tATZ_E1BMpCReNh=hLa5qPGATc3h1NUx09A@mail.gmail.com>
Subject: Re: [PATCH] soc: imx: imx8m-blk-ctrl: Fix NULL pointer dereference
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ma Ke <make24@iscas.ac.cn>, Marco Felsch <m.felsch@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, Peng Fan <peng.fan@nxp.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, 
	Marek Vasut <marex@denx.de>, Benjamin Gaignard <benjamin.gaignard@collabora.com>, imx@lists.linux.dev, 
	stable@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 8 Aug 2024 at 08:53, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Aug 8, 2024, at 08:12, Marco Felsch wrote:
> >
> > On 24-08-08, Ma Ke wrote:
> >> Check bc->bus_power_dev = dev_pm_domain_attach_by_name() return value using
> >> IS_ERR_OR_NULL() instead of plain IS_ERR(), and fail if bc->bus_power_dev
> >> is either error or NULL.
> >>
> >> In case a power domain attached by dev_pm_domain_attach_by_name() is not
> >> described in DT, dev_pm_domain_attach_by_name() returns NULL, which is
> >> then used, which leads to NULL pointer dereference.
> >
> > Argh.. there are other users of this API getting this wrong too. This
> > make me wonder why dev_pm_domain_attach_by_name() return NULL instead of
> > the error code returned by of_property_match_string().
> >
> > IMHO to fix once and for all users we should fix the return code of
> > dev_pm_domain_attach_by_name().
>
> Agreed, in general any use of IS_ERR_OR_NULL() indicates that there
> is a bad API that should be fixed instead, and this is probably the
> case for genpd_dev_pm_attach_by_id().
>
> One common use that is widely accepted is returning NULL when
> a subsystem is completely disabled. In this case an IS_ERR()
> check returns false on a NULL pointer and the returned structure
> should be opaque so callers are unable to dereference that
> NULL pointer.
>
> genpd_dev_pm_attach_by_{id,name}() is documented to also return
> a NULL pointer when no PM domain is needed, but they return
> a normal 'struct device' that can easily be used in an unsafe
> way after checking for IS_ERR().
>
> Fortunately it seems that there are only a few callers at the
> moment, so coming up with a safer interface is still possible.

I am not sure it's worth the effort, but I may be wrong.

It's been a bit tricky to keep the interfaces above consistent with
the legacy interface (dev_pm_domain_attach()). Moreover, we need a way
to allow a PM domain to be optional. By returning NULL (or 0), we are
telling the consumer that there is no PM domain described that we can
attach the device to.

Kind regards
Uffe

