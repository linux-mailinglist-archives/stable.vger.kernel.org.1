Return-Path: <stable+bounces-116679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F6F5A39540
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 09:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45253B5035
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 08:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110D522CBE5;
	Tue, 18 Feb 2025 08:18:24 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6000822CBD8;
	Tue, 18 Feb 2025 08:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866703; cv=none; b=B3rrk27w4eyUJVMrvL8dkcqZlIQIu9PS/iOwDPnNIPgI09jRcZUIQOfKkJIvpSkzwdWFdlYneOxUP22q8bMvVkPPKJM0n1Pr/2hbyC1uNytoD0jkQrEH9z2SBgdKzFjoZDB4bFeOln6DN3unlvkFO0K4uuCQKyT4HEg3Tbkpsr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866703; c=relaxed/simple;
	bh=2VBYXOW5In6lit0F1gJahtZuGAfHYPipCEI5SAdDqvs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQqwTwUSIoBH/dBPpKWRgH4y2KpU5/y7/ur/kuAbv8qoAh+xVcgIGEP8dRYbX+xPWrKsslLyBma7+Q5b3TDLxn1SLDZMQWFTjp8iRbLN0gkqYdLx+EclT60NXuylmLjn6P5tC+Kt6TiDHbx5GOvWNv5oVIF68ZFL2Nca7a3E8rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-521b5bd2268so410444e0c.0;
        Tue, 18 Feb 2025 00:18:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739866700; x=1740471500;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VT68uUFOtiLM/j4EB1RwnCT+0lIJjD9PLyVD0uYr2cM=;
        b=pJYalHd/seZz6JgzSYgsmXApfk9VN20SFUDI0hGFVENQJs/R8Hwxq6WsZe8xyAAA9q
         +XVb/rppSptyshrtiEtBujNdzBuIyxFfNHmIXTMNaj5/slP5Mn6hQc0uRXk6V8Vy1jv2
         YmCbQthT/xmG2DCc0hnFxvg5foEwOFPrPWMWpRjNAIgtmvrWfU9GMs7vLc4CEtSWtC5c
         33w/PVPhK16BX06jkMTJxvzNb1dK6QaxYE74D9sK0JeO+ZHUo6sJDBut0X4ouiZwVQlw
         yEi2izSyMh6luD5OOi4sbT4OHqrcyDHzzqJNqEKgDyICI0WheRXv+vWmGCOiG3Ku+qIN
         0xiQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8f5MiYQUDKuR+A+gm4VNgBlCrU6syJEkZ80qkkCQ+DtILXyafAxiPla3VQ8ysFLYEQCH6cvxdyRF7n3U=@vger.kernel.org, AJvYcCWeqDrnXiKAZv4ifaO6EgfII4dMhyzlUukW755UdCDxAktB01j6+BnF1/6RbBLUR6/IgUJvVBYJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+uukBYrQeT9VdoAgVROyWwfBUB71/Hhjy4fbJmsf4nVr8pfM4
	DTL4oBubPKXedyS3XzjVDDl2nBdjL8AJGaK9eCBkvP9H6D+88yTDuElfpNcqFfo=
X-Gm-Gg: ASbGnctPpI7xK4qQRmjNayIWD9aXQcLMVErzfpCL4I1KxIDils6Q/PYccotqcNw9ZwO
	LSby5vHMvWpKYNHOo7LCt5Kjr8XJAqAF3Z98BtcBl5PXm0rQAuRYvpIzdu2W+YmrMI/TeY7WgIz
	arnfMIdb24Z+cbHiVw+nQHSOC8Sp5Kk5HuFF4P5vCrXFInKUabqQwM+Xe/oYHv1sHv7fbmcoico
	w9WiC6yU7X5SnYd7w2R4d4Z694+aFo5qtroQqgBSoPmLw35kyo1vsDhLTPy7y0GkLZap5MSF3rM
	8rZvyJnamnkNdPlY7thV84tDTL0+LseookPkFEyu0Ff+xCdsMyS0sg==
X-Google-Smtp-Source: AGHT+IGMgwpf+kYRAPr7XkyvWrb+UmLfkmdXvlkoGgf+GRltx16IBJkg0+LVFD+bPb17sWsfv10Dxg==
X-Received: by 2002:a05:6122:2a56:b0:520:59ee:8197 with SMTP id 71dfb90a1353d-5209dcccf61mr6069911e0c.8.1739866699899;
        Tue, 18 Feb 2025 00:18:19 -0800 (PST)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-868e8599598sm2092279241.15.2025.02.18.00.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 00:18:19 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-4bd3c887545so2357738137.1;
        Tue, 18 Feb 2025 00:18:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVxcUNr2MIRsG7425tbBNIiFKCpVgUDQTyET6myPSk1NpDDlyWE2ZCnqzxcyvgkNki3dCfKfjE6@vger.kernel.org, AJvYcCWudjV5gnNEsHldn8Z3/d9968nHXHJfaVYsdc0o4nUW35SpaTSpUcnypIwNNQjReWtTQcPKBvH17tMUSJg=@vger.kernel.org
X-Received: by 2002:a67:e7c3:0:b0:4b1:1eb5:8ee5 with SMTP id
 ada2fe7eead31-4bd40001d6amr6978606137.25.1739866699350; Tue, 18 Feb 2025
 00:18:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250217160017.2375536-1-haoxiang_li2024@163.com>
In-Reply-To: <20250217160017.2375536-1-haoxiang_li2024@163.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Feb 2025 09:18:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUs_2mB5RFga8Dv7xPp5VFMaXqykJShndTW-_Q8hgUYfw@mail.gmail.com>
X-Gm-Features: AWEUYZlXeXLAPjROcl_yxFn5h2lk18a3_Wom0kri1EP69xrAxJlcBNWCh-TcD_A
Message-ID: <CAMuHMdUs_2mB5RFga8Dv7xPp5VFMaXqykJShndTW-_Q8hgUYfw@mail.gmail.com>
Subject: Re: [PATCH] m68k: sun3: Add check for __pgd_alloc()
To: Haoxiang Li <haoxiang_li2024@163.com>
Cc: sammy@sammy.net, zhengqi.arch@bytedance.com, akpm@linux-foundation.org, 
	dave.hansen@linux.intel.com, kevin.brodsky@arm.com, 
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 17 Feb 2025 at 17:00, Haoxiang Li <haoxiang_li2024@163.com> wrote:
> Add check for the return value of __pgd_alloc() in
> pgd_alloc() to prevent null pointer dereference.
>
> Fixes: a9b3c355c2e6 ("asm-generic: pgalloc: provide generic __pgd_{alloc,free}")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>

As akpm has already taken this:
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

