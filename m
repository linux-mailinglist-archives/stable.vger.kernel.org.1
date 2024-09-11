Return-Path: <stable+bounces-75902-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5515975A1A
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 20:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35EA9B238C9
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 18:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7CD51B6543;
	Wed, 11 Sep 2024 18:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QLQDzddJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75C11A3055
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 18:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726078307; cv=none; b=ekLtXRwH/d5Innl0C4X7oKuKpbzerbvwBGcZ0bAxfnT4c0nlKV0JvOfnIao76TdR2S29MCGC4dPSi7jMjodIjngqJmIPOQ6tq1/4Dcp59VkcpZHLmRRY892WneR/GI65YXV+6zKR/4xMsu275nBTsyOpCjL4v4sF3XD5/0EBjjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726078307; c=relaxed/simple;
	bh=z857oVhOO9Ge5wn4k4nabsLRCg+zyT2pPs33TkWJQgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IS4pgGQXXKBSu9ntj1Dh7f8RCC3JWNqw3P1uQQGkwPJfFAH2GAYExxhR60pFReHjfrWUmF5aAmDRzK/y0eCvZLsRVcgMMjEInXM8fAd6aKQIkOJvPCiCVP9OYfBcznnI5A39GXZ4kLYD4IloEX/xeaa9+hxSHoRjxxT8mjv1Ik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QLQDzddJ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d60e23b33so19085766b.0
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 11:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1726078304; x=1726683104; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QXiJI/L0vchgadKCOX7xJsbzxv2AfJtb8fmGhILgPNI=;
        b=QLQDzddJHGLjsGGeAU/V/QerDX+8YYLHUswbATuFFhKBdQrsC7CBrFaJjwOqlQn02p
         tpVFrUtM/Ca7GRyEfJ/ivHZXoEfElvTDcJrjfmEP9SY4Slse7JgyL3T6WWkSbsp9gRaI
         dpI61X7heQ6V9ISr1aKwEzIe4OZog/cF962IU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726078304; x=1726683104;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QXiJI/L0vchgadKCOX7xJsbzxv2AfJtb8fmGhILgPNI=;
        b=UoRunW0JqnFkUiWavXKKD7vjMIf12sG3HSrWAe4yf7XEJzE2ANtPP3pSfGWt0mF06Y
         zTEwxVUuTmn4FhHRU79z1PAKcn1QfrL0tzEet77MxVlET0Sk0Q214mtwKR3bJK2CWuWv
         xrGW8s6S51F8eBAs0FoA+LOTjzp9eY06/S6ATtlRbm04J/EwmeZLOwxGXSepWXekfZD6
         39kzBDmHKCNFXqEgHtKUv/HWZiXH8G5/08LBqToUm02p7ngIDeIQe2n1UDtDunF9iRjl
         ra/+N1eOpPSpjEapJsvFmwEsMNkRxij3fS0DzFHguzocJeYAlFNFlmfkI/EFPvnANRw9
         yQGA==
X-Forwarded-Encrypted: i=1; AJvYcCUuTb5CbfMSQl7j4358LyquWbN/AWrz1QKkzd4w4ZHcpsfhGKwdJf++EwHwJ73qUhF9Q6a5o58=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9ZlUqDdAUpoQwjWf0poB3/hGeKrxXASQoaCkTj8tzPW0306VK
	wSxonb5UZMTmzyvRjDWN+37trTS85v1cApivlumj9VjoDpjw3SqWBor/5qAgHPdW1ZU5f3X1Z0C
	bsKp+8w==
X-Google-Smtp-Source: AGHT+IHhr6ukrLP5s/5O341oteDuBSI0QIS8e9IBI9PcMsFuqsBSJjHpnqmPknmKGnzmINPM7VJZxg==
X-Received: by 2002:a17:907:f75b:b0:a8d:4d76:a75e with SMTP id a640c23a62f3a-a90294d0958mr27732266b.30.1726078303384;
        Wed, 11 Sep 2024 11:11:43 -0700 (PDT)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d66ba1sm641528066b.223.2024.09.11.11.11.42
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Sep 2024 11:11:43 -0700 (PDT)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c3c3b63135so60933a12.3
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 11:11:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW6gVhLEMh+5Tz6ZrBDEyG8uJRGZQROcpNvGq3bnGUm/Xh3Ef9E5KZRjMhcgpCbtDoqsU5v2oA=@vger.kernel.org
X-Received: by 2002:a05:6402:33d5:b0:5c2:5620:f70 with SMTP id
 4fb4d7f45d1cf-5c413e4fbd6mr215370a12.28.1726078302536; Wed, 11 Sep 2024
 11:11:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1726074904.git.lorenzo.stoakes@oracle.com> <b38d8936eaddd524d19823f7429138e2ef24e0d1.1726074904.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <b38d8936eaddd524d19823f7429138e2ef24e0d1.1726074904.git.lorenzo.stoakes@oracle.com>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Wed, 11 Sep 2024 11:11:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgWJmQJSWz_5S8ZqEpDs1t3Abym9DPZfUzWu+OCNM3igw@mail.gmail.com>
Message-ID: <CAHk-=wgWJmQJSWz_5S8ZqEpDs1t3Abym9DPZfUzWu+OCNM3igw@mail.gmail.com>
Subject: Re: [PATCH hotfix 6.11 v2 3/3] minmax: reduce min/max macro expansion
 in atomisp driver
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Richard Narron <richard@aaazen.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Hans de Goede <hdegoede@redhat.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Marcin Wojtas <marcin.s.wojtas@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>, 
	Arnd Bergmann <arnd@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-staging@lists.linux.dev, 
	linux-mm@kvack.org, Andrew Lunn <andrew@lunn.ch>, 
	Dan Carpenter <dan.carpenter@linaro.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 11 Sept 2024 at 10:51, Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Avoid unnecessary nested min()/max() which results in egregious macro
> expansion. Use clamp_t() as this introduces the least possible expansion.

I took this (single) patch directly, since that's the one that
actually causes build problems in limited environments (admittedly not
in current git with the more invasive min/max cleanups, but in order
to be back-ported).

Plus it cleans up the code with more legible inline functions, rather
than just doing some minimal syntactic changes. I expanded on the
commit message to say that.

The two others I'll leave for now and see what maintainers of their
respective areas think.

            Linus

