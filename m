Return-Path: <stable+bounces-23195-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19B3385E16B
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 16:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88C2286F45
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744788063D;
	Wed, 21 Feb 2024 15:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EnMRUP10"
X-Original-To: stable@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF6A7FBC8
	for <stable@vger.kernel.org>; Wed, 21 Feb 2024 15:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529886; cv=none; b=J3nPER30JVXSsZ3+2ECHzYhkCsi87KyRqBruXZs4HlhvZTLUmWCUr99FBXuJZYUJimhmaT2EYv/hR9OkR7UD7QAE2tZp+eE8RvJVE2YQPpviUTyhP3oXL+hIiNqqH4bFnAlrclhGRK8T3s6yPLlRdIYGcoPEXmuCTL+VZNw1NM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529886; c=relaxed/simple;
	bh=grCOSi8XLFLNaMwkvCBLU81kgrXCuEK7+6nsE0tIJwM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mLZl/hFbQDvbsDHkapyZFrMt5hTmWrXLgGDJWHVhbyEh2vauBQx1Gh7eZiDh7hvADukJASipyGCSw1UhOaBMDyAh/KmIYxNzQeSptvX/3EeCDNBgmiLeLWsMBXSomkqgpt1kod8tFWZ5PhbUysXMuzL/7NVrUvF6BwkLb45D9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EnMRUP10; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-59f7d59d3f1so355582eaf.1
        for <stable@vger.kernel.org>; Wed, 21 Feb 2024 07:38:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708529884; x=1709134684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NEHN5AeQw8GvEzpiKivhi/yJeQapwymDAxDl0UXRrHY=;
        b=EnMRUP10tj4gX39sl5/sdn49FmzXvoX2UP0BbEP0GMvc9LCGsBlilOaTp0aoKcujqZ
         FqLNxXj/GmXhlUh13/wNZpsFCXCyp8aNCuUE6GBE2In26ltDatXBYJ7AVOa5F9ZOA1SU
         jCVYztHu6ij7bLLNEsylbmk1BgEwtSpr7J9UE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529884; x=1709134684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NEHN5AeQw8GvEzpiKivhi/yJeQapwymDAxDl0UXRrHY=;
        b=Ne3jqAQOfeJq5dWnTpXAZiwvUVwkjwMQEi2aEGm/fM3YGfwR3CpID50yYT9hQCmU5E
         QA2Qi9sQSMDxU+14PtcqmtG3Y9CV0rXRsXGYtnfKxN7XbjVv/Va5bjluQrjwXS7NpOk3
         iUBSOrf4GUmqwNuMnuoU0uiVeWVqbQnAmYdIYnLym7uqRpQTT0CqS5W5qEuiGTjMdIHb
         cECcI+fw1tjdgATaDZ26Tbc7C93n3AayD8RANOe5hjCWbc+R4GpzVeLVtjvxG4Ybr3zc
         6uzCq5E0GXBwbSYAGIMWFWK1Dd5Xbva7nckeKnUws84BmnG8C4EHSqWNfOzdBqGgCalH
         aOvA==
X-Forwarded-Encrypted: i=1; AJvYcCUIzMyXaSPnk8F+j/SCE7KXin36y2bqcUoT39zqCcJi3smfAfOrLm0Ee8tAh9Q8/OU/naLeO86N2oVYT1f8oL+s6CteozLn
X-Gm-Message-State: AOJu0YxTKK3lRMQjI4e8eEQRiNxIv7J/A5xHET79dRr93n4kZ/xUkbiC
	acXK8SjqtoNwuWh+GAqPscO5E6AngLGB//jjFxn4d2z94mR2cCx/37EDOgVQkIHBETZ5uwal+E0
	yx6K8AJq20/FO20ERw3qIrw3ujne5t8DY0kq/
X-Google-Smtp-Source: AGHT+IEChvW8BSTbCSiTLMx41zznTkN+GvBMzZXbANOmOD7tZt6WMkfBtn5etm2aIN7Reqjdjh6UJ1h4VL7WfSOjNEc=
X-Received: by 2002:a4a:b78b:0:b0:59f:8466:5748 with SMTP id
 a11-20020a4ab78b000000b0059f84665748mr16124819oop.0.1708529883981; Wed, 21
 Feb 2024 07:38:03 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
 <87jzn0ofdb.wl-tiwai@suse.de> <235ab5aa-90a4-4dd7-b2c6-70469605bcfb@suse.cz>
 <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com> <87le7e6um3.wl-tiwai@suse.de>
In-Reply-To: <87le7e6um3.wl-tiwai@suse.de>
From: Sven van Ashbrook <svenva@chromium.org>
Date: Wed, 21 Feb 2024 10:37:53 -0500
Message-ID: <CAG-rBigASZpsxEpjUnCWYpfmjuyJTQ44AXBr90fYbQWvit_YXA@mail.gmail.com>
Subject: Re: Stall at page allocations with __GFP_RETRY_MAYFAIL (Re: [PATCH
 v1] ALSA: memalloc: Fix indefinite hang in non-iommu case)
To: Takashi Iwai <tiwai@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>, Karthikeyan Ramasubramanian <kramasub@chromium.org>, 
	LKML <linux-kernel@vger.kernel.org>, Brian Geffon <bgeffon@google.com>, 
	stable@vger.kernel.org, Curtis Malainey <cujomalainey@chromium.org>, 
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Takashi,

On Wed, Feb 21, 2024 at 4:21=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> Both look like the code path via async PM resume.
> Were both from the runtime PM resume? Or the system resume?

The large firmware allocation that triggers the stall happens in
runtime resume.

This means runtime resume and system resume are affected.

Due to the way runtime PM works, the system suspend path is also affected.
Because system suspend first wakes up any runtime suspended devices,
before executing their system suspend callback.

So we get:
system active, SOF runtime suspended (audio not active)
  -> system suspend request
    -> calls SOF runtime resume callback (stall happens here)
    -> calls SOF system suspend callback

