Return-Path: <stable+bounces-40571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA8C8AE3B4
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 13:20:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A947F1F24DE4
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 11:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900937C6DF;
	Tue, 23 Apr 2024 11:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HYgE1nzT"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4FF60279
	for <stable@vger.kernel.org>; Tue, 23 Apr 2024 11:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713871203; cv=none; b=FnrcgM9MCt3tFOPwwZMxQIumDKM10gBqzRi05gHjaIUcStLGvqOPs2mAAck9vs5h12w4QH/UfyxJv/PJ6aeoCm37yYc+LN8IE6YTszi7HJdTIQORqA0kXpNcOjhnCv84g+sU1fFftw2eOojC97PH6Iern92yJERO4WYui+K3N7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713871203; c=relaxed/simple;
	bh=YGgyJXKoN5L1hoziE8Pwb/hAAK4jMi3T8Y7cDVkU8b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCUFMvvV2oyzwKXK3w1vp+8GP1ulLQFEes/X8QtEd6WOkHCoEBis+iECTuARTo1VFvNJ/Ij1ppDYc+q+yVKmeOlGKPuloBKCVkfXneri8fiIqgIOz/5cLa4xFa39woVN23CihJ3CSs9/38DrvdxX3ut/95sTuCYtMgVfUtHXSuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HYgE1nzT; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41a4f291f80so16888975e9.1
        for <stable@vger.kernel.org>; Tue, 23 Apr 2024 04:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713871200; x=1714476000; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YGgyJXKoN5L1hoziE8Pwb/hAAK4jMi3T8Y7cDVkU8b8=;
        b=HYgE1nzTDaNVlINjIWYMXBYK0SkbgrnmRsi4LXFGaecyAi10dBQP0UH33Esq2AAa3A
         jeuUL2eUE6ez1Oi+TdoIuu8GsbItuE057Agsp1i9elY0PwiF4gq51hzpc6O8VwkkCA1h
         4fnKviH33zDAoYKkhAS2PIXX2I2y9JEHCN+GW2VqbNwhz8d6RvYVT+JfmMjNmYqmebpK
         Mm2VPwRkM7vPpmHQLCZTujUC4fBaAHO1j9EApfYbiWXBZZb8QJkQwCGKodcc518cB+U8
         A+dapl4D5TvQnqQS5tLGsQTBwGOQGyW00FE1f4uvSPl+225ScismG7cDDGIAnTDxGVWi
         pzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713871200; x=1714476000;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YGgyJXKoN5L1hoziE8Pwb/hAAK4jMi3T8Y7cDVkU8b8=;
        b=sMMiIc7q9Iq/m9hQxR/y39z9WRT5xUV0jvgAqfrqp6SIb6nUq+goLI/KDzod6h+uyU
         91jb5Ivk7CbfVtWcrgoRudSKLrjKU8X21N1piv0GN0DWKz1NzLK0GjqfvwVbyb6IUgqs
         7MqCl7KlfdBj/k56iBYg2+OBwUlNueehllh3s0W2qULwfBAlMe6lt0k7WEZaZ45eZw0l
         9xonu5hCOj+M7uHFeZN9m/pVJTuUsVqjhZgVR6M2nwKlpoLA11XV2C9ngXyD0M60YrqQ
         A7QAmjSyPo7CCJdUwO3VsynHypyELtLaelV35CdJnbFCKO81mg0odI3hVq/ITSTX1a88
         nBow==
X-Forwarded-Encrypted: i=1; AJvYcCUoqWSOAS4VLkjGOthhmDGs1LN9bB/pwBDIp1vu91LFxl6I6VNJk2vDJjBDHt9GRC3giT2zu1hgGIw68+Vq1oowpUaVF2oE
X-Gm-Message-State: AOJu0YyXM8zd8otYusvBeCGj2I7bJDLhp1aM6U+yL5QXKJAIfOZFQUQ5
	3WVg+uI3iD5KU5Bil65/Y7b1Mw3WsJayHMzEMNDSOdhP/989dzM61chCDEbRsLc=
X-Google-Smtp-Source: AGHT+IHMKxMg+gfHErSx5FW+vINajDp9UAb8VLTHQPc43/6ff53K4UznbcECiMb2/I3QUr5myH9RuQ==
X-Received: by 2002:a05:600c:470d:b0:41a:c592:64ff with SMTP id v13-20020a05600c470d00b0041ac59264ffmr983585wmo.35.1713871199993;
        Tue, 23 Apr 2024 04:19:59 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id g4-20020adff3c4000000b00343c1cd5aedsm14309973wrp.52.2024.04.23.04.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 04:19:59 -0700 (PDT)
Date: Tue, 23 Apr 2024 12:19:57 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Jason Wessel <jason.wessel@windriver.com>,
	Douglas Anderson <dianders@chromium.org>,
	kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 0/7] kdb: Refactor and fix bugs in kdb_read()
Message-ID: <20240423111957.GD1567803@aspen.lan>
References: <20240422-kgdb_read_refactor-v2-0-ed51f7d145fe@linaro.org>
 <kvmf4hcnoeuogggx5jmcqjch32shyswjv5cqvg4hwdg4g27rup@t4ddszao3354>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kvmf4hcnoeuogggx5jmcqjch32shyswjv5cqvg4hwdg4g27rup@t4ddszao3354>

On Mon, Apr 22, 2024 at 10:49:29PM +0000, Justin Stitt wrote:
> Hi,
>
> On Mon, Apr 22, 2024 at 05:35:53PM +0100, Daniel Thompson wrote:
> > Inspired by a patch from [Justin][1] I took a closer look at kdb_read().
> >
> > Despite Justin's patch being a (correct) one-line manipulation it was a
> > tough patch to review because the surrounding code was hard to read and
> > it looked like there were unfixed problems.
> >
> > This series isn't enough to make kdb_read() beautiful but it does make
> > it shorter, easier to reason about and fixes two buffer overflows and a
> > screen redraw problem!
> >
> > [1]: https://lore.kernel.org/all/20240403-strncpy-kernel-debug-kdb-kdb_io-c-v1-1-7f78a08e9ff4@google.com/
> >
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
>
> Seems to work nicely.
>
> There is some weird behavior which was present before your patch and is
> still present with it (let >< represent cursor position):
>
> [0]kdb> test_ap>< (now press TAB)
>
> [0]kdb> test_aperfmperf>< (so far so good, we got our autocomplete)
>
> [0]kdb> test_ap><erfmperf (now, let's move the cursor back and press TAB again)
>
> [0]kdb> test_aperfmperf><erfmperf
>
> This is because the autocomplete engine is not considering the
> characters after the cursor position. To be clear, this isn't really a
> bug but rather a decision to be made about which functionality is
> desired.
>
> For example, my shell (zsh) will just simply move the cursor back to
> the end of the complete match instead of re-writing stuff.

Interesting observation. I hadn't realized zsh does that. FWIW default
settings for both bash and gdb complete the same way as kdb. Overall
that makes me OK with the current kdb behaviour.

However I was curious about this and found "skip-completed-text" in
the GNU Readline documentation. I think that would give you zsh-like
completion in gdb if you ever want it!


> At any rate,
> Tested-by: Justin Stitt <justinstitt@google.com>

Thanks.


Daniel.

