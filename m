Return-Path: <stable+bounces-25594-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1A0C86D088
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 18:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8FFD1F236EF
	for <lists+stable@lfdr.de>; Thu, 29 Feb 2024 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D51970AEA;
	Thu, 29 Feb 2024 17:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cou7Vty8"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97CE6CBE3
	for <stable@vger.kernel.org>; Thu, 29 Feb 2024 17:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227560; cv=none; b=gnXOpgaw9UWWkVeA90IIcLL6f+CZQB14S4sTVgGm3E2RQvYnUUEw6AIxXf1osTgzo1ToSwnupFC4YXgcujy1dzROic1aRwkEJksuDHu2BXoslKfPxHpLVK46777LPhdh3pMukxfG+0jztpjglDbiNIfVnVqYHShBkfK6A7n+eR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227560; c=relaxed/simple;
	bh=x023CuxQEDUhqmIMeqnfqJUbjUEG0Bp8dWnHTJB3rdI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c9JcnZHtWePBZugGvgCm7Hcy7mpZMiBm1OeER77HiyF6baK2UigCMQD8BQTpzWOSmtTNWSx3nSiIP+b1AKzLYRgUGF1XJDxLCISo5Sl+zvM3lSurisNGW26kujdl3vcyNYi2Kg/41nRACf7Bt+44PRP8NXqrHmD9RJRLLKE70WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cou7Vty8; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a3f829cde6dso196688266b.0
        for <stable@vger.kernel.org>; Thu, 29 Feb 2024 09:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709227555; x=1709832355; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x023CuxQEDUhqmIMeqnfqJUbjUEG0Bp8dWnHTJB3rdI=;
        b=cou7Vty8VLoEFq4M6Yv86Ms99c7KUcdIfpRyFMLAeAznWgxF68ZxfCozRKV3mWOo8T
         GEHS2DXF20JjjV4frDcXWoUIQq4+m+Ll0G7b2IwOGHqCdCc9RvIolbiyejpJKygZBwLy
         dtUr0nq86E3jtQe83tMlNpOm+EZ8uZ6puVlTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227555; x=1709832355;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x023CuxQEDUhqmIMeqnfqJUbjUEG0Bp8dWnHTJB3rdI=;
        b=j5weJK/3JehYUvC9+22CCOW8paL441BJXIKSO4Y7oXzgSg8Bm7kcc+GyqTdUT/I/8K
         fYMh2xzx2c+sTo9eBRe+TtklZ4AFBVwyhX2wJnDyyarisAOq2pGYZiKFmTWWtKeM80vY
         RuV0qC11WLnvQyWA0dirMTJXikTaGzFimplR0xiVgRfhgwNlgreIKdnZKNFkYzvVkeN1
         AB84hubxO3I/O4II5yeHlZlWxNMbXXVxq78rWn2vkOkexeg1AqGD1N2En08trPafdKHz
         0TVcoGMK6X/llkGWtnwaxFlT2CATRLaI2gbT8uvZZVJmzMgc/Qw/ztTKiQsHhN6CxSUO
         FHjw==
X-Forwarded-Encrypted: i=1; AJvYcCX0EHmL5bXCDwCRdBH/va0C0ypaIdBq5dcHOdixfEKi8qUV7XrBrfdtlGVDYdRXGa01SnXW5xwmD9vmz2cAtrMgIDtKtQBD
X-Gm-Message-State: AOJu0Ywa5Wq/2B9Y9QFRH5qFtc9QBAdU8f9Wr4dnDOZT0kXDp6BVpf7T
	NcinBSCwU6tdzXj+H426TcNv12xUu2XBcz8Cwatt9/yQJmRVTVlJ5SQ4s/DKtmjH5/0TxXoa7Hs
	jhniK
X-Google-Smtp-Source: AGHT+IHsFrdtYrg0c2EnX/GYZPit2d4FjnhJmQq/05NOav9coDFRi/9alAqgoDJvGQFJOw7+R1C9pA==
X-Received: by 2002:a17:906:5a8e:b0:a44:74f6:a005 with SMTP id l14-20020a1709065a8e00b00a4474f6a005mr114395ejq.43.1709227554831;
        Thu, 29 Feb 2024 09:25:54 -0800 (PST)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id ts3-20020a170907c5c300b00a3d4dc76454sm880977ejc.159.2024.02.29.09.25.53
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:25:53 -0800 (PST)
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4129a748420so103745e9.0
        for <stable@vger.kernel.org>; Thu, 29 Feb 2024 09:25:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVKljZsalXfll6E8S0m9egFv3fpm9xZoQMmRQ4nugECiWb9VUCof92ZkczeW+mqQZhR9ps4mb5oC1NxZXfysBr0orwZah3j
X-Received: by 2002:a05:600c:3d90:b0:412:ba6c:8067 with SMTP id
 bi16-20020a05600c3d9000b00412ba6c8067mr151782wmb.5.1709227553392; Thu, 29 Feb
 2024 09:25:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229154946.2850012-1-sashal@kernel.org> <20240229154946.2850012-21-sashal@kernel.org>
 <CAD=FV=Wb4meRvghR00LTzXRAobgioGo5g2oYqMLuO8nYWDa7Rg@mail.gmail.com> <05cbeae5-cd40-45a9-9b4f-68b9b20a6839@sirena.org.uk>
In-Reply-To: <05cbeae5-cd40-45a9-9b4f-68b9b20a6839@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 29 Feb 2024 09:25:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VG1DpW3YukX691P59eN=oAnDxfWvm6CjpWFg5SxUmCRA@mail.gmail.com>
Message-ID: <CAD=FV=VG1DpW3YukX691P59eN=oAnDxfWvm6CjpWFg5SxUmCRA@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 6.6 21/21] arm64/sve: Lower the maximum allocation
 for the SVE ptrace regset
To: Mark Brown <broonie@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Will Deacon <will@kernel.org>, catalin.marinas@arm.com, oleg@redhat.com, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Feb 29, 2024 at 9:13=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Thu, Feb 29, 2024 at 08:51:09AM -0800, Doug Anderson wrote:
>
> > As I mentioned [1], there's a hidden dependency here and without it
> > the patch doesn't actually do anything useful in kernel 6.6 nor kernel
> > 6.1. Maybe the right answer is to backport this with the hardcoded
> > value of "16" for those older kernels? Maybe Mark has a better
> > suggestion?
>
> Your suggestion should be fine.

Crud. Ignore me. The patch is fine as-is for 6.1, 6.6, and 6.7. :(

git tag --contains f171f9e4097d
...shows that the needed patch is actually in 5.19+

Instead of using the above "git tag --contains", I was naively just running=
:

git grep ZCR_ELx_LEN_SIZE

...and I saw that it still came back 9 on v6.6. ...but that's because
it was still set as 9 in the tools directory and I didn't notice.

Sorry for the noise. We could still do the hardcoded solution of
defining it as 16 for 5.15 and older if folks want.

-Doug

