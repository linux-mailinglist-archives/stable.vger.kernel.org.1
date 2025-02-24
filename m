Return-Path: <stable+bounces-118724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9279A419D9
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 10:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3502D188931B
	for <lists+stable@lfdr.de>; Mon, 24 Feb 2025 09:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641FD24C689;
	Mon, 24 Feb 2025 09:57:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC72224C66B;
	Mon, 24 Feb 2025 09:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740391033; cv=none; b=pjBm7CZ+wd6xQOZUpBZZRb96ENCWos/BbIfi0ybc0Z2R8hT/vG94BhcMp7nV9ECGygcA7OMnt50x+kfXAfk26ZcGFSmbG59/4Gz50guk9C2fFw7+b5MV1FkWLUtRPpFGz6xqRJUXx7O8ly5weaRS0t9JtUFVaOf0D9pZXvUwQE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740391033; c=relaxed/simple;
	bh=MSl6c5eG4xbpBVfyZR8dcHuYjVQmZCg26ue/c3GLq0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uMZOSEdrEVwm2rdoF5sKiZlkMlevdPyaUlLVjVXYXFbgmTn3xn1ottpdr6bNFzLpAYbvjlW+YLwu38qxzaX7dWXBVR/+ElzRwOL0exhw5hsQ2Jaj00WuEuRxtlP2GQC3YsQOVRk13A+QjXCz483A729Xpgaq6UZeAKV1REpFUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-521b84aa5d5so836738e0c.1;
        Mon, 24 Feb 2025 01:57:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740391029; x=1740995829;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YZbn+v0xyuTX45sY6qG0ln35ZltgvYtyEb5LTmw+eFM=;
        b=NhzwFrASfMEghcu4aVL0Kwv30RXSb7Igts4aCRoQSZFqw+hclOeSGa3ToDe4fxul+n
         JtDqRSvuCev2ToKb9OyChf9zPHXsrRtdmUpxpWU991Z5528tCClF66QM9Mlul5Yl93YW
         Ld6WIyDftBp0NzdT/mJBFggt6Fzw6mkZ4Je1CmDo2YNpk/0rz0PhoFwaDtcz38QsJu82
         JcUlvakNHIufDfz8dLQ7ykxeT7HTwyngWR8BSmCdDdCCYXYAvFvsLZVf58Ux9vfg3TV4
         mzom3149OkWNqaPBtpUhMS+MxQG2dH5GyB4mUjrXZNG1Wuj6B9irTZqRWi5qzOzh+JdT
         eXQA==
X-Forwarded-Encrypted: i=1; AJvYcCV3TN+IM11kMV2YIr9pLt4DsMs2n0VSXsmmP6Hu04dvMGLMVGCDHxDJf3R9txyakp9jINw23BB8@vger.kernel.org, AJvYcCXLQWHDmcWbzUaguNCSMT1CG7r1hlFmKkgMlpD17UmGqwDIn0FA3C2LcwdPqVmEZvKrC7oYG+7xLOcceZk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuMJrtNBhLbZfsLwXlYAI05DyPgAXxRAed7fFH8y6KHx+5d/3M
	/rG/9gpbfQZpXpKmdORvPwBexg4fnR+Cs6EOz0SNMtjXHLSHI3E6cr6H2l2cjZA=
X-Gm-Gg: ASbGnctZXm9nQHR7EItm2VV60Z8d+zO2e2wv6jlvDyAXn5TC+tNhnUAaTaxYpERQMG3
	SL8/OsFtMVPhul7SAOOFpe/CDQ/BIKUfIHvs/qGG6IjPKyIzqZU1KiXDyjsK8p4ikdfXfk8jlFE
	EU8WHOO6hTdsN7P2dVUfKg0rVVZ1PTzmPIXgH1H1TZarhOtkpfWoF1o0KLy0m5+40RFWfZ8gkOR
	V5Eu3mhPDLM7FihAd6csa04hLaVN9UMmy12UZ18LKDconvEIn2UWWl4mLAQ2xlgrdUyylFUV3Ko
	SflKspyEYnBQ4wQFyLx9lb/yo6cfn2OX2+sAxrPgoJ7HkrvLhYDRbuCRLjv5Z4lr
X-Google-Smtp-Source: AGHT+IEw9LxbFjzj4bELO/xURG1hu87zIbfTFfPGvOoKxWFtpTFf5ICvakyGFZ94QKjPq5U6ABHSng==
X-Received: by 2002:a05:6122:3295:b0:520:3914:e6bb with SMTP id 71dfb90a1353d-521ee424763mr4701769e0c.7.1740391029579;
        Mon, 24 Feb 2025 01:57:09 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com. [209.85.222.44])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-520b0ff2c9fsm3278637e0c.35.2025.02.24.01.57.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Feb 2025 01:57:09 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-86715793b1fso1240502241.0;
        Mon, 24 Feb 2025 01:57:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU9Bvvh/5bJsXXA9tLa/+hQ2+XXo04cseIQcw9qMa9+zA6vpubhaWYWy8UAO7LqUOe6bMVT5g/HvDzks38=@vger.kernel.org, AJvYcCXyIn3/KSZuecRo1/KV4cO+oXghfOrz+mMlV/Gu5Nrl5x/w+khLAI7rXXZtVSf98WWfmg+CyeU5@vger.kernel.org
X-Received: by 2002:a05:6102:3711:b0:4bb:e14a:944b with SMTP id
 ada2fe7eead31-4bfc023cc30mr4782066137.20.1740391028952; Mon, 24 Feb 2025
 01:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224093810.2965667-1-haoxiang_li2024@163.com>
In-Reply-To: <20250224093810.2965667-1-haoxiang_li2024@163.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 24 Feb 2025 10:56:57 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVufJ3CopGfCXzqfsX14AKWoAn_eUMY4GP1o+mznugKUQ@mail.gmail.com>
X-Gm-Features: AWEUYZlkdpt8bJJMHFN4pXPfA2mxx7JvlLlSHhLsEyTe_NpsJQ9SXsLfs1W2bic
Message-ID: <CAMuHMdVufJ3CopGfCXzqfsX14AKWoAn_eUMY4GP1o+mznugKUQ@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: hd44780: Fix an API misuse in hd44780_probe()
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: andy@kernel.org, u.kleine-koenig@pengutronix.de, erick.archer@outlook.com, 
	ojeda@kernel.org, w@1wt.eu, poeschel@lemonage.de, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Haoxiang,

On Mon, 24 Feb 2025 at 10:39, Haoxiang Li <haoxiang_li2024@163.com> wrote:
> Variable "lcd" allocated by charlcd_alloc() should be
> released by charlcd_free(). The following patch changed
> kfree(lcd) to charlcd_free(lcd) to fix an API misuse.
>
> Fixes: 718e05ed92ec ("auxdisplay: Introduce hd44780_common.[ch]")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

Thanks for your patch!

> --- a/drivers/auxdisplay/hd44780.c
> +++ b/drivers/auxdisplay/hd44780.c
> @@ -313,7 +313,7 @@ static int hd44780_probe(struct platform_device *pdev)
>  fail3:
>         kfree(hd);
>  fail2:
> -       kfree(lcd);
> +       charlcd_free(lcd);
>  fail1:
>         kfree(hdc);
>         return ret;

LGTM, but please make a similar change to hd44780_remove().

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

