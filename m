Return-Path: <stable+bounces-17617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92BB2845E37
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283A11F21F51
	for <lists+stable@lfdr.de>; Thu,  1 Feb 2024 17:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EA315CD5F;
	Thu,  1 Feb 2024 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FZTbgXXM"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E36160868
	for <stable@vger.kernel.org>; Thu,  1 Feb 2024 17:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706807503; cv=none; b=LKjMgnpuKQtF8USwS6jU7goVtXnrL72IWZJ/pVfwKYo8TX6EYA5K24DxO3YoUto2hRYvv+LQ7IU7k7XQkZB+JHZDQbjXbmLAJbpF/Wv3zG2qmLE6DPZNZGfFP14laN1GgR4Ek88W7QyrY7NcEz4npTjW9detitciPQquqUgZeS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706807503; c=relaxed/simple;
	bh=OWs9QmFO5qyz+TpOvq4pZ7EmYTHo69K7CcJ1pqFVbSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n0ZDQi73j+gzvp+e2DWsJL0dzZm/7BWLNzZlzdcYaq+UTCDAoSAGnhk6mRyEO/Wck0VzUOFN+ZCTuuT+Bl0SyVJKu21Y1u3CaLlEbpoD61z4QMoMY4eX0v2PRnTHZ69uFNdmaNu8JCkcR5zsPmrr1bWpT2UUolqRGBMMZsO/qpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FZTbgXXM; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc6d5267cceso1069267276.1
        for <stable@vger.kernel.org>; Thu, 01 Feb 2024 09:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706807494; x=1707412294; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+skmVmxETeWoHwOR3jnRXy25orR5hdls2yQ2xhvWBeY=;
        b=FZTbgXXMB46ASFMpXj6sbFQ3z7YY3oToH6kFVeVZTNXA0MbDp8zZcUQyRMSGOlwITA
         M4RT4ghoNue8Fqu4iB10fDB5VHs8CkrUkPOqVhn+J+Bp9fzsMs6QB6Ktptdhi3UkUP1d
         y3txpdfI/k/bq8QcBBO4Fc7Q+HREMHY7fiv+8dDz0lC2MZVRTW3281ghKx3vmTG7YtHo
         mGCxSpwyGJZYLu2wbeNnYBTTrYQqb02gvCnluuMMdq+ByeJfK/OHaQNni2ziHukiafzh
         TVlniFMTVfZVHZehZ/AFvKjjz5GwfdzIQtyABzeyO61t71GnisCmwODIz7KwoTnjAFJj
         gRlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706807494; x=1707412294;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+skmVmxETeWoHwOR3jnRXy25orR5hdls2yQ2xhvWBeY=;
        b=UOxbI5NesnwUwJDAIqae1q9ndBhQ5VZlhi/XH07IZWqU9zPI10W4JjRcqQlwQwoaWd
         +s1ThBTcwxTUZIpYphO1QWExBxlGVVNq8I9XxMGk/veDBAWCujp+kxBHF9wKWX2l5xyB
         6R6P2AaQHLMEw9Ey9JVFGuoUnKNmnf81S2HwcQIv2p28796/HOf8JY315AtqyYQP4kQl
         k0mA3uhp1jr2tFB3Fd2mJYPYOBJmhFn7gfxXEMnVX8Mf8lmiBAh3wH94ACt20Ws4kII/
         VAtCjSooKYBIQ7K8Mn5AZtf5Q78UARinNMdzgijNE9/Mhi+pzc6HC+AFFlqx9tMtFSUi
         /SWQ==
X-Gm-Message-State: AOJu0YzV1vXuuRHoEaK3XVljInp6atxFQ3/VFb84Pi3e+GX9dG8syHkf
	A1L2K5IcLuozTcwC/Py4aJCEwWpWNr72a7rJ0+jt+kLzsM7/TbVGET+sUegdcQwgMRQQVup1Li4
	+hSsNiYr9YGPtF0/0+CVEvTqzCYbYlZ+5MVkLXw3cF4zmKt7Z
X-Google-Smtp-Source: AGHT+IEm34gx8qF9peFFTe0vAmakKgDznH1AaABMoQpUZbeIVZn/SqOM5+ivdNJCi5vsOPP2K6kGYuEwMMY8Fgnv3Yw=
X-Received: by 2002:a25:2d1f:0:b0:db7:dcc1:d418 with SMTP id
 t31-20020a252d1f000000b00db7dcc1d418mr5608520ybt.15.1706807493873; Thu, 01
 Feb 2024 09:11:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201165810.64968-1-sashal@kernel.org>
In-Reply-To: <20240201165810.64968-1-sashal@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Feb 2024 18:11:22 +0100
Message-ID: <CACRpkdZg25-V4geYWyQuCbqnLmd-QKrZDRQhtN07sxf2UU80Og@mail.gmail.com>
Subject: Re: Patch "Hexagon: Make pfn accessors statics inlines" has been
 added to the 6.7-stable tree
To: Sasha Levin <sashal@kernel.org>, stable <stable@vger.kernel.org>
Cc: stable-commits@vger.kernel.org, Brian Cain <bcain@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sasha,

On Thu, Feb 1, 2024 at 5:58=E2=80=AFPM Sasha Levin <sashal@kernel.org> wrot=
e:

> This is a note to let you know that I've just added the patch titled
>
>     Hexagon: Make pfn accessors statics inlines
>
> to the 6.7-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      hexagon-make-pfn-accessors-statics-inlines.patch
> and it can be found in the queue-6.7 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

Please drop this patch from the stable queue, it is not a regression
and we found bugs in the patch as well.

Yours,
Linus Walleij

