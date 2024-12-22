Return-Path: <stable+bounces-105545-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 406399FA484
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 08:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 673B81885DBE
	for <lists+stable@lfdr.de>; Sun, 22 Dec 2024 07:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0408F1632CA;
	Sun, 22 Dec 2024 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YM5dhuRU"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF27158D80;
	Sun, 22 Dec 2024 07:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734852385; cv=none; b=oGAuTeAR4Ft3hoTCFlAd7aqUouQ762DazIfcETXALcdZmbb6ExwzQ+LBg/boVa/wUmvFoANsJl0FeEYCGn2ncOugu8tH9meWRwY7geRslMpmmky3ndHBc2AMQvEPFi54u2QvNu/58sK9LFGlzYkaNy4am+8RZ4ljvwhFpLFwH3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734852385; c=relaxed/simple;
	bh=pWy3kdeXldtGu26IRD8vfzEq3yKKT5gvwB+rRFZtji4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TsTTtLss6txnFsQzygs1mei1pSU17VkPRdaSnjhgEYCiMDdM3oAbEHFpcFI4b+oeIUAW7oUxGWp+oTynVB+7ds/V9AnlplW6AvL1SfqJMleHMDLLn8XidM1V8Du9BAAoCoVgs4naZcTmkbmoUnUfWk7SPVPZfhaeGm8i5ZJV27A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YM5dhuRU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-436249df846so21835425e9.3;
        Sat, 21 Dec 2024 23:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734852382; x=1735457182; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Arrz5Exy1wRkGEREWcrB7cZbEldgJTKm7kgF6NXkEjg=;
        b=YM5dhuRU5jEFhXvvnQ7qmaZsWmzLItHhArLm0eOJW4YP2UmErszt1g922ELC7xCv7n
         mMRSZXchiGLUaqGkjj5ne7qkG+ySc5ysGj1san1Wu4DupEWTfi/9BrTwTjc71yL5gKKd
         vW2eCwFt2atROnZudrSZdKlGqWWRYyX2CqFKDPmFlEsuXCrFcFiCts8BDOr7/YyxDLbP
         dCUK5tktZINVrSngOGS/AUpw3rXcaGtA/f4eXIfjR0/bfWxlcPNeLSCA87L4g+5EXl+y
         /szQZixJZDMb6IXeVcbFQDbuiHQ3hy7Y3yP30cmEpcDu55pvdfk5a6qfL7pF6NKs8jU8
         NAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734852382; x=1735457182;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Arrz5Exy1wRkGEREWcrB7cZbEldgJTKm7kgF6NXkEjg=;
        b=AFPBFvjuORJSWy/Pu9pyH/2PizfaItq1D3bC6ZhFHJr9OMJF9IKnYYj55HVPuvevy2
         NLtcxwIG8eP1YByqD1lGBpK9RY5t8oGt2Xe14AGFv6AygdLWXZwSk4Il9gL8z1re64ja
         z/0u9r0l5+i0haQXQZIW9jYAIyVIcgVTUExPsepNuKtE7vrhlJxgDIES9JjAnW7OQB71
         kUuNCi+SwOO1CLrZ4/NICG5Fh3GcHysq4eSoE2dGamF4W+Z7O936M2g/SrZ/S/+Rbkx/
         T9bK6T/FoikFEKxjtdXI/x9jFvk9f6moxIVRqprt0AWQIZkgYTcvcz2+w8SBdimFTXQy
         +EKw==
X-Forwarded-Encrypted: i=1; AJvYcCVURh7xRIA0+Zkll1KW6DxkhrQY9MRJOsz85zEZyJ8Win8nxC1PhpXssezJm2RK3xRccqHADVm7@vger.kernel.org, AJvYcCWavoS6sQgigmqHYIyEp2bgnv/JIi60diWFRAU1nuk6Zn2NfFs4ZPjK4n9FHRqHxJjcLN4nJGqQ+0QSj8E=@vger.kernel.org, AJvYcCXmlUpvx39lU/yIdwVglXJOR3ZTkg6r/hzhV7CVR44cvpZB1yC0wHXQv+0iYWlHEcLKDue+9T0F6kAfdwg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7UI8OlW0g6hWpzimRm0a/8/aDmhwF1qp/m65W2xCxnOZaGyyb
	cXgU7G0JIX9FBStMaYomSE8YjEj1ZpJ2nNHt3OaW/JFaZzL1GsCJ
X-Gm-Gg: ASbGnctVVaV+Pbp0KA4MkG9UBobDsko3WwXQrEEYek++t4F8A9GnC5I28ZVb5dWOvaW
	TYc69rNawe37nvNyyywaP0aM1zz6EC7Y9Wvha2R2inZsUWHhHvMG6iPITPHqxVLVPIQFnQhzDBP
	SCF9Su/Hzyu2IFxF7PYtjweas9JDCHxGkB92gCs51qHWszI+nVAe3nkpKoee19gw1OFRQNdIc0U
	XaCr7OrWZzoWdGU6aCiumUx/45pGrhVNcfHptb5njRKlk9JUaqVLTgFqn202GmERdM6VnoGO3Az
	VcuEhtPArgXuOlt/qVl7j0LZRe1tIElC8q+kEw==
X-Google-Smtp-Source: AGHT+IGXRsiI3dpki18d/giNKINZ0eDQrO8MV2boHkATHk8Hsg2zha8flfwfsiyW3NkgTMnCjM/zuw==
X-Received: by 2002:a05:600c:468f:b0:434:f335:855 with SMTP id 5b1f17b1804b1-43668b78324mr57816825e9.28.1734852382178;
        Sat, 21 Dec 2024 23:26:22 -0800 (PST)
Received: from ?IPV6:2a0d:6fc2:56d6:3b00:20f3:5417:1c06:8272? ([2a0d:6fc2:56d6:3b00:20f3:5417:1c06:8272])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828ba0sm8086400f8f.14.2024.12.21.23.26.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Dec 2024 23:26:21 -0800 (PST)
Message-ID: <a1c2d1e1-4180-48a9-a5c4-7a04feef97c8@gmail.com>
Date: Sun, 22 Dec 2024 09:26:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] Distorted sound on Acer Aspire A115-31 laptop
To: Kailang <kailang@realtek.com>,
 Linux Sound Mailing List <linux-sound@vger.kernel.org>
Cc: Takashi Iwai <tiwai@suse.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Regressions Mailing List <regressions@lists.linux.dev>,
 Linux Stable Mailing List <stable@vger.kernel.org>
References: <e142749b-7714-4733-9452-918fbe328c8f@gmail.com>
 <b4763f69b4004b19ab5c5e0a8f675282@realtek.com>
 <0625722b-5404-406a-b571-ff79693fe980@gmail.com>
 <ff166dfd38db410d8a82489ff487b437@realtek.com>
Content-Language: en-US
From: Evgeny Kapun <abacabadabacaba@gmail.com>
In-Reply-To: <ff166dfd38db410d8a82489ff487b437@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 > Headphone or Headset. Which did you use?
 > I don't know your platform has headset mic support or not.

I use headphones (no mic). I suppose my laptop should support a mic, 
because there is an icon next to the headset socket which shows a 
headset with a mic.

 > Could you record sound via headphone?
 >
 > I want to know how the voice distortion.

I've run some experiments to determine the nature of the distortions, 
and I found that on affected kernels, what I'm hearing is the difference 
between the left and the right channel of what is playing. So, if I play 
a mono sound, I hear nothing at all (or rather, almost nothing). If I 
manually mute one of the channels, I hear the sound normally (through 
both ears, while on older kernels muting individual channels actually 
works). If I invert one of the channels, I hear the sound normally as 
well. If I play a stereo sound (for example, a music track), I hear 
distortions.


