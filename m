Return-Path: <stable+bounces-92774-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E87029C57CA
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 13:32:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8583DB280C9
	for <lists+stable@lfdr.de>; Tue, 12 Nov 2024 11:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4128B219C9E;
	Tue, 12 Nov 2024 11:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X+XgE4BB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4310A21949B
	for <stable@vger.kernel.org>; Tue, 12 Nov 2024 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731410271; cv=none; b=JTKERIfM8NMW5sAyFXn2Wyb+mVsCN8MgXjLOnxAcm4F6mwtAgroshvn2IdslazuzBGSrIzmDS+2i/t48jdY/KPUvvKqJmxn3b/Rg4UWz1wgMxjUUo9GqiTwIpUCRqxU8ejHgZeb8LbiNLKPTBr+Wnj31iGC8pSSl5LzkgoyCEaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731410271; c=relaxed/simple;
	bh=pX3ZsBEZbDSOWWHgNQFnA+7zErsVd56w2urC4gYof0k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kIyNF3Nz5WBwEeYdK5aNx7oCqblanLp8htOB5tuxO/BSEimFo7wiaKh1Ck2t2tARPlaojlsa+a6tpduAzAIXwBi9oxjKZVorbrK1AJHzB5PPP+e+nK0mgbOv7ExHEvD85mR68Kf6qi4RPu8vHDDpZ8qHib2WLc3UyGzKggKehIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X+XgE4BB; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43155abaf0bso48924645e9.0
        for <stable@vger.kernel.org>; Tue, 12 Nov 2024 03:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731410267; x=1732015067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dWJ4Wcr1DDF3OrOWnRqKL1IZGwMD1FboXeJ/D4aEFDY=;
        b=X+XgE4BBdIkeP6q12SpSAfL6MbJnpQPSh4EuqoJ2vQvOywfLYISd0SoCTYr3V9XwIQ
         7DvlWWt7txbdZGfMS8nu6eVQmLXrVTaoBeH/qvwizvcLNE/fswmBCXoggaqDwjRdZmON
         Hg42O2SxeDm66YNO1rpO72PqxVIUahMk1oMoc8QN423sblreUEzasMuWyJOvo/9gQUij
         +hGaKPuoNBBUOfDjcfLmyonOyPkqwhdYr3LgmgPBjZfHH1/W5eXgU6GN9htb1OyuCI/O
         W0iRjgHbNvRyi7ua6zT0uL3s6BkT/j9S1/TI7GrGvYcVjgd5eR75oMYyEsKnbbpNTls/
         Z8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731410267; x=1732015067;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWJ4Wcr1DDF3OrOWnRqKL1IZGwMD1FboXeJ/D4aEFDY=;
        b=b5R86+vx93Hso9KBsXYHJ2BBu7Hdf0IaDdCqLpmuEwL2RPiMbKpymjxsPZZSfMx+UN
         OVukT3cj4uAg6ScpoaeW9o68VhzK0bupek1uoLyOpIAL7H8UTAM2ofC3DChhKtAC21d/
         ThuJzxY78bFiFKhRHWpfp9xMfm0x5MJkVC+gFV/Qb80CH1DTLYwbA5VHy7q8flIf1vCH
         OXoL+1Xahf7OLgyTk0okMDklXsf6q5aBU1HsP8mX7BWQJIuglI1S4ARF9MwTasGnI6SU
         w4C3VvbMZmbdXSe4Vc3cB1e5z+0a6sOsAtrURCJSS2w4Gg9BdufeIVDZrLYT47wSX1Rk
         E5cg==
X-Forwarded-Encrypted: i=1; AJvYcCU8wn8hV1AiHFwZ6o2UNSh320koDnHHBNgW0IieONmoRkmsxiV5xVNjndfWW13m2as0yVAbkHc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7PEUrS54d3UpFIIcwyFAUxBJHxr06tiflfOQd6c5cHG72Xey6
	fE5lVeIq0oDjHlQqKaEtxoY/4H8Ir5dR3amxNlI7cYLE7ornUEcM6OdriD8hZZ0=
X-Google-Smtp-Source: AGHT+IHdyVKh8yiDtEYPmTAcLgcs8M/v+k6vo/2n4BcU3ilUc3c9bFTnx7DhiZaKwNyqsYQKeh+Q7A==
X-Received: by 2002:a05:600c:35d5:b0:431:5f8c:ccbd with SMTP id 5b1f17b1804b1-432b74fda62mr141755165e9.4.1731410267558;
        Tue, 12 Nov 2024 03:17:47 -0800 (PST)
Received: from [192.168.0.40] ([176.61.106.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b053ff08sm209961455e9.10.2024.11.12.03.17.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Nov 2024 03:17:47 -0800 (PST)
Message-ID: <f6e661da-6a8f-4555-881e-264e8518f50c@linaro.org>
Date: Tue, 12 Nov 2024 11:17:46 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] media: venus: hfi_parser: avoid OOB access beyond
 payload word count
To: Vikash Garodia <quic_vgarodia@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20241105-venus_oob-v1-0-8d4feedfe2bb@quicinc.com>
 <20241105-venus_oob-v1-2-8d4feedfe2bb@quicinc.com>
 <474d3c62-5747-45b9-b5c3-253607b0c17a@linaro.org>
 <9098b8ef-76e0-f976-2f4e-1c6370caf59e@quicinc.com>
 <f53a359a-cffe-4c3a-9f83-9114d666bf04@linaro.org>
 <c9783a99-724a-cdf0-7e76-7cbf2c77d63f@quicinc.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <c9783a99-724a-cdf0-7e76-7cbf2c77d63f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/2024 08:05, Vikash Garodia wrote:
> You did not printed the last iteration without the proposed fix. In the last
> iteration (Myword 1), it would access the data beyond allocated size of somebuf.
> So we can see how the fix protects from OOB situation.

Right but the loop _can't_ be correct. What's the point in fixing an OOB 
in a loop that doesn't work ?

This is the loop:

#define BUF_SIZE 0x20  // BUF_SIZE doesn't really matter

char somebuf[BUF_SIZE];
u32 *word = somebuf[0];
u32 words = ARRAY_SIZE(somebuf);

while (words > 1) {
     data = word + 1;  // this
     word++;           // and this
     words--;
}

On the first loop
word = somebuf[0];
data = somebuf[3];

On the second loop
word = somebuf[3]; // the same value as *data in the previous loop

and that's just broken because on the second loop *word == *data in the 
first loop !

That's what my program showed you

word 4 == 0x03020100 data=0x07060504

// word == data from previous loop
word 3 == 0x07060504 data=0x0b0a0908

// word == data from previous loop
word 2 == 0x0b0a0908 data=0x0f0e0d0c

The step size, the number of bytes this loop increments is fundamentally 
wrong because

a) Its a fixed size [1]
b) *word in loop(n+1) == *data in loop(n)

Which cannot ever parse more than one data item - in effect never loop - 
in one go.

> For the functionality part, packet from firmware would come as <prop type>
> followed by <payload for that prop> i.e
> *word = HFI_PROPERTY_PARAM_CODEC_SUPPORTED
> *data = payload --> hence here data is pointed to next u32 to point and parse
> payload for HFI_PROPERTY_PARAM_CODEC_SUPPORTED.
> likewise for other properties in the same packet

[1]

But we've established that word increments by one word.
We wouldn't fix this loop by just making it into

while (words > 1) {
     data = word + 1;
     word = data + 1;
     words -= 2;
}

Because the consumers of the data have different step sizes, different 
number of bytes they consume for the structs they cast.

=>

case HFI_PROPERTY_PARAM_CODEC_SUPPORTED:
	parse_codecs(core, data);
	// consumes sizeof(struct hfi_codec_supported)
	struct hfi_codec_supported {
		u32 dec_codecs;
		u32 enc_codecs;
	};


case HFI_PROPERTY_PARAM_MAX_SESSIONS_SUPPORTED:
	parse_max_sessions(core, data);
	// consumes sizeof(struct hfi_max_sessions_supported)
	struct hfi_max_sessions_supported {
		u32 max_sessions;
	};

case HFI_PROPERTY_PARAM_CODEC_MASK_SUPPORTED:
	parse_codecs_mask(&codecs, &domain, data);
	// consumes sizeof(struct hfi_codec_mask_supported)
	struct hfi_codec_mask_supported {
         	u32 codecs;
	        u32 video_domains;
	};

case HFI_PROPERTY_PARAM_UNCOMPRESSED_FORMAT_SUPPORTED:
	parse_raw_formats(core, codecs, domain, data);
	// consumes sizeof(struct hfi_uncompressed_format_supported)
	struct hfi_uncompressed_format_supported {
		u32 buffer_type;
		u32 format_entries;
		struct hfi_uncompressed_plane_info plane_info;
	};

case HFI_PROPERTY_PARAM_CAPABILITY_SUPPORTED:
	parse_caps(core, codecs, domain, data);
	
	struct hfi_capabilities {
		u32 num_capabilities;
		struct hfi_capability data[];
	};

	where
	hfi_platform.h:#define MAX_CAP_ENTRIES		32

I'll stop there.

This routine needs a rewrite.

---
bod

