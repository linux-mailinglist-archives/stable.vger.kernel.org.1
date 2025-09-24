Return-Path: <stable+bounces-181628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77694B9BBBF
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 21:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999E119C1386
	for <lists+stable@lfdr.de>; Wed, 24 Sep 2025 19:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E1BC275844;
	Wed, 24 Sep 2025 19:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="B7N4uhhC"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E8118B0A
	for <stable@vger.kernel.org>; Wed, 24 Sep 2025 19:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742851; cv=none; b=ap0H9zuqnABoQ8sm9NYSI2zzpaCpZ7M3rnMMrYdqyK9EXeQidncvZBhfnJtMv8xdaX3k3qeHgsggEIpPvv3FbQQ2rMe06UFyNlg9C5XfjHqK/erhh8icas6Lgdqu6ujVqRkKAhYKpTJPOvCtFRU5AmVS72Arro1a5USZnIESWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742851; c=relaxed/simple;
	bh=AFOZkj2TG0Be/KXXpalR/RLNcoDJKbSXopPQd3sWv2k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a54mmRRS2WvtXNl155icwGodDH4o1Bi3uN0HsohMFdpquuJFNkRYYoj8HJ5mKMPzoIs4cmj0A3hB8qT2+le435pXhn33SgWxNcTXSjUEiDVp+iugr8VxOhu9hITSCrrQwqeya6Lm+3W7s4ChNRwXZlMSguqjQ4jRvKfTkpkuwMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=B7N4uhhC; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b2e0513433bso34348266b.1
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 12:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1758742847; x=1759347647; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=1+Zm+Mmot6AwL4K5F9sieXv45xvE31gzhvdEZdWA+A0=;
        b=B7N4uhhCKpBnCLRHG9spBnclZnPd7D0HfHGPD0BHG5KRUrKBBPzEZp+mTd8JzqVIrq
         wr+M4IJYI7R+BBV8VQxrk8DaB5PIQMDSJ3z98rtKq/xvThM5lvblodbd/dcQWofTejP5
         6Msue4aCL72Azjobh+xbGHJdWPHKqwMNlIpmk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758742847; x=1759347647;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1+Zm+Mmot6AwL4K5F9sieXv45xvE31gzhvdEZdWA+A0=;
        b=eKFO0Ti8GlIVvLChuYaKtE7PdespFeb/k6SjGYekgaGOsA950Cf7aDYmpwSBUZrR2J
         yDRA+IjZGMR+rPxPRWAeuIfBzcCImiFZKSyrlcvRngJ6Zw7iC+IzyhZGabDhxdXLxX3Z
         oNMmHl1M3fPX9oppx2Lux49pVN/8aayINN0599M5QkHJ091WdJevbIXfntnAiHM8G6N1
         umolIesnYPq6q6PAwhP4fkG3KZb2yBIBNIOO6+g4KiRY/5DAYRVOWbvnrANj/XvbzshF
         1JUn8vI6ukEE71Fl1QOflM0/0CIpj2iBuv4gfcGMDPKKMBwbnFZqJXXqg0xjUmb0iCTG
         Mt/w==
X-Forwarded-Encrypted: i=1; AJvYcCVIrrPmWFY8mg43n+JgVZMBrnT3PxYFLD86ocUutiBO1oRgxYk7HA701eE24LGU2NwzRYB6k2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIuAhkij/Tu6WsFe+1xLqaiQ68taPhHj6y0oS4isd+Pa+QKQe3
	4TqYhRcemwGltZvNJZWerQQPbFapSZkiQskoXceaSP+8JN2pgCmV5qw0t0baU11rOh5Ym8afYrL
	8SzRF
X-Gm-Gg: ASbGnctmTTBLG0mjly5iohXnu4IDjtAjcx8M6XY/b3qs3TnVIPAK0yQv0bUws9b/frt
	Uk46b6z6snhKToBRtP5EYPGnvFJemOAHOoPrqrtYHZoF7FGXW3x7f4w4HF47JIMMWDO9joJLXx5
	DD4ec7aigKOL+W7JorJ1rS8Dmh60ihuKQzRgXRXap31MW85re9PTZ70BEOBAqO9pn//sOwZ6eZ4
	oKpTaOCuVH61RLYDkw7ehTDkNsbW1qmz16eKl3jq2A03J+k5q+scOcisJlK5oAxUXPXQFY9THgY
	j14VlOAY5B5Ufk2W9vdVG/rNuOLWjQcPN83LsVfZc2Jc/VFBMmsDWBZIUQDJBZs9GysufkIFcWN
	kt6LSavpNuswZqtd1U2bWa9Npr/k9Zh3fUFszWtE+sQCdEreefJAp8TIzknI1B7tfcKHJ87vJ
X-Google-Smtp-Source: AGHT+IFI8tQ8hzrzUZWyTTab+ZnELgAwrxuRDwug88jc5YRM2ijINqx0rSt78G/lIc9FQx9bSIbJcw==
X-Received: by 2002:a17:907:7206:b0:b32:3a90:fd50 with SMTP id a640c23a62f3a-b34b9d657d0mr88147566b.15.1758742847083;
        Wed, 24 Sep 2025 12:40:47 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353e5d155asm4858266b.6.2025.09.24.12.40.46
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Sep 2025 12:40:46 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-61a8c134533so251178a12.3
        for <stable@vger.kernel.org>; Wed, 24 Sep 2025 12:40:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUCieHwb2weQuGcF3+ywIP52vwh+UFe8zBUYEqkYfG994L/YZr4AEaE1LWoQCe6ZyWpfWw+MbY=@vger.kernel.org
X-Received: by 2002:a17:907:3e0d:b0:b28:b057:3958 with SMTP id
 a640c23a62f3a-b34be100c78mr100247466b.48.1758742845971; Wed, 24 Sep 2025
 12:40:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924192641.850903-1-ebiggers@kernel.org>
In-Reply-To: <20250924192641.850903-1-ebiggers@kernel.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Sep 2025 12:40:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wieFY6__aPLEz_2mv-GG6-Utw9NQOLDzi4TF93xFAnCoQ@mail.gmail.com>
X-Gm-Features: AS18NWD9qiI7hge6j2kywiKpkeIcPfny81AeITA2ton2nw7pONLugyyBMzBP1WY
Message-ID: <CAHk-=wieFY6__aPLEz_2mv-GG6-Utw9NQOLDzi4TF93xFAnCoQ@mail.gmail.com>
Subject: Re: [PATCH] crypto: af_alg - Fix incorrect boolean values in af_alg_ctx
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Sept 2025 at 12:27, Eric Biggers <ebiggers@kernel.org> wrote:
>
> -       u32             more:1,
> -                       merge:1,
> -                       enc:1,
> -                       write:1,
> -                       init:1;
> +       bool more;
> +       bool merge;
> +       bool enc;
> +       bool write;
> +       bool init;

This actually packs horribly, since a 'bool' will take up a byte for
each, so now those five bits take up 8 bytes of storage (because the
five bytes will then cause the next field to have to be aligned too).

You could just keep the bitfield format, but change the 'u32' to
'bool' and get the best of both worlds, ie just do something like

-       u32             more:1,
+       bool             more:1,

and now you get the bit packing _and_ the automatic bool behavior.

           Linus

