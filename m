Return-Path: <stable+bounces-100268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB5949EA266
	for <lists+stable@lfdr.de>; Tue, 10 Dec 2024 00:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BC89284511
	for <lists+stable@lfdr.de>; Mon,  9 Dec 2024 23:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9672219E975;
	Mon,  9 Dec 2024 23:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XsUHZkPk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF60919D092
	for <stable@vger.kernel.org>; Mon,  9 Dec 2024 23:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733785520; cv=none; b=NeuaTyVXiEN0bqwa7U9VGHbHazhKzTFaWpsL+XXLh27RmP2/TAdHCPgwJYilhdFkBmMc9zfilKVZkQDxiasv6kW+rMaxlwUh4Gq9sugIf4I4NHwoF9OJ7r2SLjqhAFmhG5Q7JOYzikhvl+ZKLUdnLSro3TZhXk+VocUteSRVbpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733785520; c=relaxed/simple;
	bh=E2wMVt4XnzSAoCFwFJpocVejZtumHBk9+rnpvzMGxW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qBk61do544NhhWxizpKPK8SXozeRTrnYHtcD/ghN0R9BG2aeaNgnuvWOUGYQH/iZNslorFEBewds0pmusw2rISPqcnJIhZ0FXNnPY9/NhETuxITwfar/0ydxTjoBV6T0twop7S9BfDjR2bwX7j+2ebIrRQ+pIssYyopHS0CFOOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XsUHZkPk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733785517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rtXPjJ/UW99vVDZpFTpb2RZPeH7PKMqMj5zaKL4gx1k=;
	b=XsUHZkPkjVLnVvLDz6Y1u2pq9PuQF2sAqPtt40rAuYyNtZ61oMwb2Y3olADWjcpOIx2LEp
	7SwpgUgO7l5mIDdniI2eFpYqFvF2nFIzRAkjtcuNq8ZAHjdnM1SDjHy6/RpAKqaT2KeD27
	C0ec3rHUmBBRjhHSWrZu1eTNNpGLvSI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-HO-npva1PUW9TGin5Obj2w-1; Mon, 09 Dec 2024 18:05:16 -0500
X-MC-Unique: HO-npva1PUW9TGin5Obj2w-1
X-Mimecast-MFC-AGG-ID: HO-npva1PUW9TGin5Obj2w
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-434e8beee61so12529305e9.0
        for <stable@vger.kernel.org>; Mon, 09 Dec 2024 15:05:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733785515; x=1734390315;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtXPjJ/UW99vVDZpFTpb2RZPeH7PKMqMj5zaKL4gx1k=;
        b=eWlz0FC3GM5Jn6XAHiivfNvcGmTywAbUI2NQar3WYEQ4j3cwBUCmm2Nom8srt53OHv
         ht3W4GMkA54mEKbXzkdKF/85KKSc1G2U3JViCZlh7FUIx6PhcY2XBpwhNdHmz30fQmET
         yx3l7/XE07thSgI/S4N+zanTrtI8mD89/e1mfw6Zz3twohqgZvp6fMkznI0tkWnchVKA
         WMktY1oHw5J6pd96jUeXZe55by4Arx9J0zOZHEqf87W38eSylodcwr9IYp64Ii/Ybl3Q
         dd0YGiZobLXZvBJVt9hI0OHu3/XnGEwfJREEwVmii/qHA/ATHjav/EjjcibO9pi6T2tl
         RVNw==
X-Forwarded-Encrypted: i=1; AJvYcCWfgzDmRK27+3MJaiUPRKcUju/wcREhsYk6PJeOBvTZKe6j8fKNgWyZ2AmRL5U2w4V5TRcUEYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDojRaY5HkZCdmBE2WpQ4hXwNoV8uMbAYdT61zlE2CMObCFD/p
	20EnNOBdYYDbIBctMF0XyxAR9u03XqXchwPOU8LXAIwQA4HbSrB8RN93J1SRQ11yYr6ltMLmW2A
	V9hzMy5w8kYCpaeJR6e1Dzlv4ZWMVj//S87MOq3xx8OkryPuD1RGp+A==
X-Gm-Gg: ASbGncu1vE24GT8Zqw3wx4N3XXHh9SLnkr1n8J7TgkWxt1d6NytThebhOaDt7NM/Ql9
	r5MKTD6Ff86OgpVlYQlooxeg0riuBJ3/SVgBcbPp2yKh2VhGS4vE5nLfFOozF8Lzx5B7LM1AW3j
	iKogZqFi5QHir6ZsB0lyQxNr8UEWrbupwS8dSe31A4+ZWuk4HynxqLpQnHDeWjjSaMtqPmWN7Cp
	RyXZQZVG53mr3sHUz20g2qob7NVvNfBML48+5BLTL7vrIjUmZo6GXkdO/06tvVSh4K19pjv8SIO
	0R+EM+FvAJpxz3mjVA==
X-Received: by 2002:a05:600c:18a6:b0:434:ea1a:e30c with SMTP id 5b1f17b1804b1-435021d9c95mr8234815e9.13.1733785515311;
        Mon, 09 Dec 2024 15:05:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErGKM+mO4OjrHPaFMSgaVoG1GHOIII5oaFReyZQhrk1MzggllJFKQWOp6TcUYxwWwXNWck1A==
X-Received: by 2002:a05:600c:18a6:b0:434:ea1a:e30c with SMTP id 5b1f17b1804b1-435021d9c95mr8234565e9.13.1733785514969;
        Mon, 09 Dec 2024 15:05:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:c:37e0:ced3:55bd:f454:e722? ([2a01:e0a:c:37e0:ced3:55bd:f454:e722])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38636e05568sm8337911f8f.39.2024.12.09.15.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2024 15:05:13 -0800 (PST)
Message-ID: <e544c1c7-8b00-46d4-8d13-1303fd88dca3@redhat.com>
Date: Tue, 10 Dec 2024 00:05:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panic: remove spurious empty line to clean warning
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 patches@lists.linux.dev, stable@vger.kernel.org
References: <20241125233332.697497-1-ojeda@kernel.org>
 <fe2a253c-4b2f-4cb3-b58d-66192044555f@redhat.com>
 <CANiq72=PB=r5UV_ekNGV+yewa7tHic8Gs9RTQo=YcB-Lu_nzNQ@mail.gmail.com>
Content-Language: en-US, fr
From: Jocelyn Falempe <jfalempe@redhat.com>
In-Reply-To: <CANiq72=PB=r5UV_ekNGV+yewa7tHic8Gs9RTQo=YcB-Lu_nzNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 09/12/2024 22:05, Miguel Ojeda wrote:
> On Tue, Nov 26, 2024 at 10:04 AM Jocelyn Falempe <jfalempe@redhat.com> wrote:
>>
>> Thanks for this patch, it looks good to me.
>>
>> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
> 
> Thanks Jocelyn. I thought DRM would pick this one -- should I pick it
> through rust-fixes?

You can merge it through rust-fixes. I have another patch [1] under 
review that touches this file, but it shouldn't conflict, as the changes 
are far from this line.

How do you test clippy, so I can check I won't introduce another warning 
with this series?

[1]: https://patchwork.freedesktop.org/series/142175/

Best regards,

> 
> Cheers,
> Miguel
> 


