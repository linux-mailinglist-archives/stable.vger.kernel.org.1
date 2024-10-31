Return-Path: <stable+bounces-89418-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 704B19B7F01
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 16:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E701281A48
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 15:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF151A705B;
	Thu, 31 Oct 2024 15:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WjCQfAot"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EA9136664
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 15:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389712; cv=none; b=O3uEfZBbfryL+cVEFCCnql3orwVwbJiT7Azm6neKt1sIwYARr7mhCZ4L9WMF5CND6u2jNitE1vf/KyY0TsDHiFBCSCu1L46oa2ATx+27jL3UIoNqVgyk+DGSJkjqWtbTzEits6d1/YvKgikp+zs1i19XXE2HpQOeNtbdXyZLY/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389712; c=relaxed/simple;
	bh=/3ietdAT2zfd/2RT4o3MkbHwYwQJuHSE9kSdiqLPMoA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iGAO4aKY9Fafo4tJmaH89k2Jp3hQMET3WRWgjyl020uDv5p3zGKmGd1xzhF6hdCJoLOnTCpg8hXwiyEsw/qAIpo9SlbkiYXWRvKVcDD2XxzZJYpT0gVlS2Rbb35Bw3kBM/+B6K3n3y4+K2Epfgz5e92gVM8inKvMeeAJp6XABy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WjCQfAot; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-7cd8803fe0aso880034a12.0
        for <stable@vger.kernel.org>; Thu, 31 Oct 2024 08:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730389710; x=1730994510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NjC3nMAIlVM1q3lt2DpIHub8eL6Pw0tLQHd/8IGv3WE=;
        b=WjCQfAot0Ux63PisQ9DgwVRm9Epcx54STDoVM5QgcULpb+cGpIX0X4o8lFzV9yTS2B
         RJ3pdhDUfpp16UsEul7q9Nx03E9SrxQkZx1rArHJnHhUo3bc87i0mBlJcIecAZyrUqgh
         6Kr63n5O6K0v5PYCpLqd9i1mw4gV+N+59oyCtnGSc76/BRihuCl1q0oSMVKr091D+24D
         EwdtvqYDHbk0voQGL3zwXjN8iUb5hLFy7qmSTt6w7X6jJnINB9NKcuHUnDIsgjKLK/Tj
         ohx1gSdzMlQmLgsqtIDhim9TMKD3wrusNkm3q7ETieZ/wos+kQaZPmb9NhrxJ7d2CkgV
         FDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730389710; x=1730994510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NjC3nMAIlVM1q3lt2DpIHub8eL6Pw0tLQHd/8IGv3WE=;
        b=QbsaF3CEH/qqmaeiU+CC9+D0sfEpgeH2j9GYozUKo1kYX+5XFCdKu0WgLo5krQ52yP
         bRGgsfnua/yqfpAoLlmhbWtxxQom9Egu/Q5AnnFxvXRng3P8yllOaabxlbjh6X7cRn8I
         /nKgZSps7H2gu/cqJfGbvLFU4x/IxuKSr5etaj1eqfuu93GY3nomLddf9i3yevWQQKEU
         Wk1r5WfsPUEgun17NAB2vS31hgpJLm3eR9H1zx0U/3z/LxB0bpx/WRgIN3e1UXzqvR2y
         PPFzmlMCq49evaU2qqT82fQsSTR9iZnkQ5UuTPlFkIGu3IaJowPQ4qwH0LdYBYYpfjOF
         m/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTNQROxpuVlBU+VhLeNHmY1e65gdjon181z2ZdLbNuWUlAVkF2hCWhHCAl7nyKXwufmmdMxpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFXV8zrLojv3eqafGo5+gYy/NmzDrus5qLryTHvDWWTR6AISre
	/xzyjSPN1SZJvYDIuQiYxpPcPEIilVptUTM6G3roAuXCiH7AdGEar5DFm/YBgsI7cJTQbUkhmG4
	oDeoet50hz3EqzBppkhw3IEA9Nl4nfkGFkUHb8GcFdZHb4sj7b0c=
X-Google-Smtp-Source: AGHT+IHSfDKRii2NwhyNl5yN1Hcn8F5/2hI6zBGdTVZhAkhVitVIhKYO47+S571JKu4USELXFc3aJNzy7hxcwlEDOmc=
X-Received: by 2002:a17:902:e54b:b0:20c:8b02:f9f7 with SMTP id
 d9443c01a7336-210f7711e6amr85424115ad.60.1730389709967; Thu, 31 Oct 2024
 08:48:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241018-drm-aux-bridge-mark-of-node-reused-v2-1-aeed1b445c7d@linaro.org>
 <ZxYBa11Ig_HHQngV@hovoldconsulting.com>
In-Reply-To: <ZxYBa11Ig_HHQngV@hovoldconsulting.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 31 Oct 2024 17:48:24 +0200
Message-ID: <CAA8EJpopyzeVXMzZAiakEmJ9S=29FKt43AHypSYyOuo_NbSJbw@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: Fix assignment of the of_node of the
 parent to aux bridge
To: Johan Hovold <johan@kernel.org>
Cc: Abel Vesa <abel.vesa@linaro.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 21 Oct 2024 at 10:23, Johan Hovold <johan@kernel.org> wrote:
>
> On Fri, Oct 18, 2024 at 03:49:34PM +0300, Abel Vesa wrote:
> > The assignment of the of_node to the aux bridge needs to mark the
> > of_node as reused as well, otherwise resource providers like pinctrl will
> > report a gpio as already requested by a different device when both pinconf
> > and gpios property are present.
>
> I don't think you need a gpio property for that to happen, right? And
> this causes probe to fail IIRC?

No, just having a pinctrl property in the bridge device is enough.
Without this fix when the aux subdevice is being bound to the driver,
the pinctrl_bind_pins() will attempt to bind pins, which are already
in use by the actual bridge device.

>
> > Fix that by using the device_set_of_node_from_dev() helper instead.
> >
> > Fixes: 6914968a0b52 ("drm/bridge: properly refcount DT nodes in aux bridge drivers")
>
> This is not the commit that introduced the issue.
>
> > Cc: stable@vger.kernel.org      # 6.8
>
> I assume there are no existing devicetrees that need this since then we
> would have heard about it sooner. Do we still need to backport it?
>
> When exactly are you hitting this?
>
> > Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> > Changes in v2:
> > - Re-worded commit to be more explicit of what it fixes, as Johan suggested
> > - Used device_set_of_node_from_dev() helper, as per Johan's suggestion
> > - Added Fixes tag and cc'ed stable
> > - Link to v1: https://lore.kernel.org/r/20241017-drm-aux-bridge-mark-of-node-reused-v1-1-7cd5702bb4f2@linaro.org
>
> Patch itself looks good now.
>
> Johan



-- 
With best wishes
Dmitry

