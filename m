Return-Path: <stable+bounces-159266-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4279DAF638A
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 22:50:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4C54E7F99
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 20:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C642D63E5;
	Wed,  2 Jul 2025 20:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KM/xdv8a"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845A52DE6F5
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 20:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751489405; cv=none; b=MaBfs05XE/NgWD19Pb2bdm9p3Nsa8M/bVOPaeS+nGm6dTgb2y90xBMHcpGxkDL7fJDnUo2NEn0HWa2AVoGzLpn4WncMZ/q1CqzhutokzndAkX16dvyGK6VCmFGEVsdZAkJ7ah8G8XEm1Pv9xc28lngqU8Rqg//TqqAVAkOW5Tmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751489405; c=relaxed/simple;
	bh=ZxXcEEypmlbiWCpLuMvBiV4odr+sahMyq0GcQqQ02FU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5QV7j7NfVZSEtmjYjbn4qYZ8PU2uYQhhj3fVTuIp4FSzZrfEB/95xMwzMRfb+6UQMyIJgyVHufXEdbLM4hiFKkqPln+8+M0kfH65QN/YrTuIeruc+YbbdzMUGbGHgZKRlR+1GNociyxYO3c0tbCDr9oTj9rWJ3qEr6zDshM1oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KM/xdv8a; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4535fbe0299so29263825e9.3
        for <stable@vger.kernel.org>; Wed, 02 Jul 2025 13:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751489402; x=1752094202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ovWNjewh+7G4vqBhCcWzN9kHPNhreE512hCTFisoLNM=;
        b=KM/xdv8aaFs3pimb/sTEz2irY3fnRhC85Xa1mm+1fIIpUFeLV/HoVs/IFDfx9YRj55
         JUu/OXP0TTgEmHxIiypNeB/NkRZE5Iq3pjn3M6NvWlMuWh/F64Lmqg0wfKHBR9+NHaL5
         ZPETiJPtbdkcIcopQ7BgILbmX6POMxRn8k4ql5BDW+Eb6xzGNHsu2UjVrJU93sFJ1g3U
         LaiFSUA7T3/Qs0mMI988JOnpYLDGOBw9en/kTskuQVIoGXlYGSQP3xdG0AbLrDigqM0r
         YKa6DXlARauc/llq2sNZaYbUr4UTGihaIlIRQkjyt6OWoQmDDdbHuWZk3EufnPPs/2KD
         aCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751489402; x=1752094202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ovWNjewh+7G4vqBhCcWzN9kHPNhreE512hCTFisoLNM=;
        b=IkIeVK4/vT6SgFl986oQ19iPiLLluaClnB9m06JzLxH0O9Tp+Vm+lemwM8Hc8VYHpr
         xtEWPs2uhSLdRccMf9tjRJvzwi3l4XrMjdv8gqxZcK5JFvcz7OMjJur8HK5AFFWW0xUa
         qGU3C7Ez8kuvPNsZjPugFVumM7+aujJtJy+dnIJJ/Hc4G8SWD7lKu2QwP2lyc0qKLHsj
         kqywjjl6QlWrfvPIyrHduKPjAxYvn2TF6IVfCf7DqD5iaFvaBmaJ6KAoV9FaQMDXf/PY
         OGbPBT2d9sEhgUBdmtEsq/h5Mq2Wmq1+SLP39OZDfPeV5mpU8ohBLtP1HpG+A2UR4YcX
         Sz7A==
X-Forwarded-Encrypted: i=1; AJvYcCXrSc0NekKosPvjEXQB6DPXjwi9/r1lFQyIpTg0frjtX2coqhQ3P/IFV5gF7J4X6l0WYfceED4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCfPXHDHaO6Bxv4AYyJDIxi1Y1e3eX/0sW/cMUrhwoPZxp9b7A
	2yAgBF1ZUpKupUhTeQrERd1Y/dPYgCjuTIOZzzOSPJ46C8lFg2obR+2XKJEYxw==
X-Gm-Gg: ASbGnct0o6BvsGUwwt6pWchSTWADvxbyQKHgemD1u/w7mUOAGYD9aDXk+5/sl9Gfo7C
	UyJMvvhq+q4F08qSq8OQ0/bY7R8mRTv9mkrNOS9D68YLdOg37xu5ZdNhdLGxLCPtRpADzBGrof3
	i7HaZu/ka18qOLd7meF97ERvgJLvMow1M4nPW0MrJ/XCbpAEk0yb1wDMGuBmX6Cj4iF7g4pdvG5
	peAHMeFdgOf6WuSH/6bZhlvXZ6DRXsOB/8G6ega/DnfNxZFdXYLr2TZ+usWCcJSaCAgAbn+6mKt
	ybSOPQEzYbrbsxT6fLTMbzBXvTGeShRGQ+j3FUOcvdxlqUkai6i2VuVZRtAdUCGfj/KrILZBS6q
	DKvdCaEHZyXaJBiNxWw==
X-Google-Smtp-Source: AGHT+IH//iy8I+aud0/r2/FPAXBQ9C8mARiRXAdF3u5iP6vmeqYCp62gFI6NGqzCahKTzfltDrC9eg==
X-Received: by 2002:a05:600c:1554:b0:450:d4a6:79ad with SMTP id 5b1f17b1804b1-454a9ca8543mr10382485e9.23.1751489401407;
        Wed, 02 Jul 2025 13:50:01 -0700 (PDT)
Received: from pumpkin (host-92-21-58-28.as13285.net. [92.21.58.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9beb22asm7531565e9.36.2025.07.02.13.50.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 13:50:01 -0700 (PDT)
Date: Wed, 2 Jul 2025 21:49:59 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Nathan Chancellor <nathan@kernel.org>
Cc: gregkh@linuxfoundation.org, sashal@kernel.org, stable@vger.kernel.org,
 dan.carpenter@linaro.org
Subject: Re: [PATCH 5.10 and 5.4] staging: rtl8723bs: Avoid memset() in
 aes_cipher() and aes_decipher()
Message-ID: <20250702214959.72281fe5@pumpkin>
In-Reply-To: <20250701152324.3571007-1-nathan@kernel.org>
References: <2025063055-overfed-dispute-71ba@gregkh>
	<20250701152324.3571007-1-nathan@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  1 Jul 2025 08:23:24 -0700
Nathan Chancellor <nathan@kernel.org> wrote:

> commit a55bc4ffc06d8c965a7d6f0a01ed0ed41380df28 upstream.
> 
> After commit 6f110a5e4f99 ("Disable SLUB_TINY for build testing"), which
> causes CONFIG_KASAN to be enabled in allmodconfig again, arm64
> allmodconfig builds with older versions of clang (15 through 17) show an
> instance of -Wframe-larger-than (which breaks the build with
> CONFIG_WERROR=y):
> 
>   drivers/staging/rtl8723bs/core/rtw_security.c:1287:5: error: stack frame size (2208) exceeds limit (2048) in 'rtw_aes_decrypt' [-Werror,-Wframe-larger-than]
>    1287 | u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
>         |     ^
> 
> This comes from aes_decipher() being inlined in rtw_aes_decrypt().
> Running the same build with CONFIG_FRAME_WARN=128 shows aes_cipher()
> also uses a decent amount of stack, just under the limit of 2048:
> 
>   drivers/staging/rtl8723bs/core/rtw_security.c:864:19: warning: stack frame size (1952) exceeds limit (128) in 'aes_cipher' [-Wframe-larger-than]
>     864 | static signed int aes_cipher(u8 *key, uint      hdrlen,
>         |                   ^
> 
...
> 
> The memset() calls are just initializing these buffers to zero, so use
> '= {}' instead, which is used all over the kernel and does the exact
> same thing as memset() without the fortify checks, which drops the stack
> usage of these functions by a few hundred kilobytes.

I suspect you mean bytes....

	David

> 
>   drivers/staging/rtl8723bs/core/rtw_security.c:864:19: warning: stack frame size (1584) exceeds limit (128) in 'aes_cipher' [-Wframe-larger-than]
>     864 | static signed int aes_cipher(u8 *key, uint      hdrlen,
>         |                   ^
>   drivers/staging/rtl8723bs/core/rtw_security.c:1271:5: warning: stack frame size (1456) exceeds limit (128) in 'rtw_aes_decrypt' [-Wframe-larger-than]
>    1271 | u32 rtw_aes_decrypt(struct adapter *padapter, u8 *precvframe)
>         |     ^
> 

