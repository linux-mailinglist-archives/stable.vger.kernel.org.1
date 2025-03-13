Return-Path: <stable+bounces-124257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B22A5EF7D
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 10:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738ED16ECED
	for <lists+stable@lfdr.de>; Thu, 13 Mar 2025 09:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 855902620EA;
	Thu, 13 Mar 2025 09:25:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07542C80;
	Thu, 13 Mar 2025 09:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741857901; cv=none; b=tuJRvfhiFuaNN8tvzY7rCChaPAcUKGu8G+n1JoRrCSyLCC+raFzLOWDdcbYG37zXdIWsIxNm+Zjxb+pvslXueXADGZPNam8DUO7VSb7xEuZevnTMfGNdLI44UKljfVrJPoOdGhuE4bzwdpMIAMs/7+EDkpDIiqY1FgrXQp2i5xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741857901; c=relaxed/simple;
	bh=pqAgI5Ds9EZBhvzdtWvnK+kgH1uDcwphe5LWdH3KVU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZ+ijJbgiS2nyr03vX4IATUjFgDCdfn4XtflKAqiNuM4Ozz7HLXd86jMlRJEJ1s8TT3Zco65y1jPAMcxc0fw7T0Gm++InfjI2buk0QRe6lb+KQxpKoWw1YXIwJWZz+RHLx7JeqvUmief8PQR7Ey7wvKnFn8WjghiyUU024resgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-523efb24fb9so303263e0c.3;
        Thu, 13 Mar 2025 02:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741857897; x=1742462697;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pilag2znkjIk4UPDdmSrDSzG1dL350jsjUFlH6gACu8=;
        b=E+KwivdLMLC+zNnBFqeB8su09jX9PeL52a6aNHHHDYgUMnzvaafYilA6SUL4NbW7jW
         sVdJB/vmUhnDBf2PsFOP+PkhqaOO+ChzU2wLasNXXDe0q6a1Q2QgxM7IHjO4k9liRusK
         UahiJbYoWi9Uhm+rtmS1X9sEw3oYQRUTZU4EAiOvrVZnph9x9awrjmk5ng//cLpYCbMA
         q25r4jErUmb+zP1l9HoM+QduPusJfJq43Tet4SmpbSblB3idQb/dwFksv4BZqT+6CXLI
         LsAAur243YwWrL8Bhug0+UakmN2vPna/q2CutE4i+Y9fMXuXgcA2rjVCnXIauxPiAIbA
         qfGA==
X-Forwarded-Encrypted: i=1; AJvYcCUi7cNy8EaH1StXILu+rtJjE4FOn0wzjEFdMGK38DlK4yV8Gnz/GIhCM0JrfJOJfmeNsfvhI77s@vger.kernel.org, AJvYcCWCO7DryHO6XGHatkZc93s+SXaNzoDze646Q3dATS3MpSmf6t4RBbqKZni5dMkTOXDdUvttigomWzb+xj0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRtHjxw8aUHsSgDdiHjBk/mL6ZmPjX+kbMlHeCCekGbWsYPU6t
	mKEfoM3JfR5i127XMJ0LD6RHke4BQ6fioaZkkL5/dWK2pnpl5yx0H1RQg0o9UHY=
X-Gm-Gg: ASbGncteqata49xB3s/fFIBXPE8mPkMMczswRZ5QW84IR5+wOopmso7VjtjL1g1pBQd
	ZY5L7+wz4jvmGqWAdJiNqZEx2FroAGI22ZB3erLbYUJ7dQYzGhOVnutZsYuCORBd0+ZJF0N3evS
	QI0/aeF/nHmOcCnBLwE0El0gyOfviNevUPvIDzps2qgRWUGtUaqk2B3cmhZODLh5VIr44X9P0Lr
	v4uW8Xb2/gy6mGXPjG6RVOgcfI/m982Swr6yeNnkRAeqlgRa3mNfpkFBlcGBIBv2dl5XkpIwXAf
	5te72ubH3SRvp0yDCcWgTTtainMlSW7D9ryHIl3NNThuXLvI+4RXvM4VboPbQAkVB6RPnwyy1oD
	DwDUeB4HD/bz5YDdZ5XTvAA==
X-Google-Smtp-Source: AGHT+IEU2oq8XnnTBqFl4ehWfSZe+W5vqT6ofuzDPzyAof+bp0cfFH5hpNPTiNO9UVvcScxHat/Lyw==
X-Received: by 2002:a05:6122:45a2:b0:520:5a87:66ed with SMTP id 71dfb90a1353d-523e4191f4emr18248046e0c.5.1741857896858;
        Thu, 13 Mar 2025 02:24:56 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5243a7184c5sm147572e0c.41.2025.03.13.02.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Mar 2025 02:24:55 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-523efb24fb9so303246e0c.3;
        Thu, 13 Mar 2025 02:24:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUKEM688X/vojsE7wzqYnC/q6/F+iVwfWVzzP7/VLa9lbcTkxzc30BNMJT3iD5vClMlsxSKRh7+k4rP3V0=@vger.kernel.org, AJvYcCV8JpOctNyni5HYTeuqibHrCyCkV1s3uvXLSSteBF5iVVuPQiiflwmZhlBg5CtvUd2xtyIfuVrx@vger.kernel.org
X-Received: by 2002:a05:6102:50a0:b0:4bb:c9bd:8dc5 with SMTP id
 ada2fe7eead31-4c30a52a041mr20328667137.3.1741857895543; Thu, 13 Mar 2025
 02:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250313080219.306311-1-make24@iscas.ac.cn>
In-Reply-To: <20250313080219.306311-1-make24@iscas.ac.cn>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 13 Mar 2025 10:24:43 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWC90pwMqbVzgjXiCdQhHPNCn7H63qpLR_gnkd_KnmX6w@mail.gmail.com>
X-Gm-Features: AQ5f1JqQ_oaKDsBDau4ePq88smh-AvPy8WWYdFpV0xoJTZrekkZ3xtkqYb-jFaQ
Message-ID: <CAMuHMdWC90pwMqbVzgjXiCdQhHPNCn7H63qpLR_gnkd_KnmX6w@mail.gmail.com>
Subject: Re: [PATCH] [POWERPC] ps3: fix error handling in ps3_system_bus_device_register()
To: Ma Ke <make24@iscas.ac.cn>
Cc: geoff@infradead.org, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	npiggin@gmail.com, christophe.leroy@csgroup.eu, naveen@kernel.org, 
	arnd.bergmann@de.ibm.com, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Ma,

On Thu, 13 Mar 2025 at 09:03, Ma Ke <make24@iscas.ac.cn> wrote:
> Once device_register() failed, we should call put_device() to
> decrement reference count for cleanup. Or it could cause memory leak.
>
> As comment of device_register() says, 'NOTE: _Never_ directly free
> @dev after calling this function, even if it returned an error! Always
> use put_device() to give up the reference initialized in this function
> instead.'
>
> Found by code review.
>
> Cc: stable@vger.kernel.org
> Fixes: a3d4d6435b56 ("[POWERPC] ps3: add ps3 platform system bus support")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>

Thanks for your patch!

> --- a/arch/powerpc/platforms/ps3/system-bus.c
> +++ b/arch/powerpc/platforms/ps3/system-bus.c
> @@ -769,6 +769,9 @@ int ps3_system_bus_device_register(struct ps3_system_bus_device *dev)
>         pr_debug("%s:%d add %s\n", __func__, __LINE__, dev_name(&dev->core));
>
>         result = device_register(&dev->core);
> +       if (result)
> +               put_device(&dev->core);

Good catch!

> +
>         return result;
>  }

However, there is an issue with that:
ps3_system_bus_device_register() sets

    dev->core.release = ps3_system_bus_release_device;

and:

    static void ps3_system_bus_release_device(struct device *_dev)
    {
            struct ps3_system_bus_device *dev = ps3_dev_to_system_bus_dev(_dev);
            kfree(dev);
    }

As the ps3_system_bus_device is typically embedded in another struct,
which is allocated/freed separately, releasing the device will cause
a double free?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

