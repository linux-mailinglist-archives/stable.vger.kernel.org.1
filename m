Return-Path: <stable+bounces-152853-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF112ADCDFC
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 15:48:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366F13B9A71
	for <lists+stable@lfdr.de>; Tue, 17 Jun 2025 13:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B2C2E2EF4;
	Tue, 17 Jun 2025 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AH27B0LQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2662E2671
	for <stable@vger.kernel.org>; Tue, 17 Jun 2025 13:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750167843; cv=none; b=efHPBVK+vjeBjj/G/gud2X4l8bNlA1qOw4ffQuYEzhR/eiA0tsjI4pR6EqCJjod/Jl5EFF3BFpBASYnilNaY2oRKgD4JwRdHM5USls8h8daGoewM8xRTkkCusB+8nukSKzPOcLBlgSJEoAQyK++JBZmp44FPozx4PTQwy6liOG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750167843; c=relaxed/simple;
	bh=BFQ9SO2t1J71+CICyMv1OPoOaaKRRkwWmkwVe0QJxP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HP2jOUxVeMHgeNc2ey9T4GlrhSiLC6lWmgSbhUkHdepjgwym47TS/wsxP0Sz5s6BItdxt0HAT+bgOONxK/3cA1lNymFg0dBy4JXHiMd8muc+hySqUMsSTp5sC24J/6S5N0S8zBydRwJGVPSE3jiC7u1wDjr4dsPumJF3zqaZYZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AH27B0LQ; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6077d0b9bbeso10550576a12.3
        for <stable@vger.kernel.org>; Tue, 17 Jun 2025 06:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750167840; x=1750772640; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zecGBL4EFfqvJ1+S5Ps/tbhcKJ3SUOGOERPfVCGUV9U=;
        b=AH27B0LQQC2ayBySy8ZR8I75kphnB298dWIqrZg8uUoRaOOzZQ5r3LXWIBPMHW/ODA
         6NlmaWDD5TBcPLDf5+vsLc7ukUBJQ3issHE1I37kdzA0KGm/Jr7Ct0bUmHgW3z+Bmn2q
         fWm2MqXOLqkkhxl+YtcUJXOdMgh/6vuYQ+XLQOgT4h3+0l70Q9mSx/KVyVqAroWEm3qw
         4gR8Hi4ARJ4K+fj2WgMtN4VTvgDumeoDUkGPiyR+IwYVXByRdUbwMcHtVWoZG+44oP7Y
         4OWxGztcjvcEjwXo5PpTPreOOIVlUC6JEY7mI7ptLZpmIg6BzNnGsFEnBfNFhmAyKZ1n
         KQQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750167840; x=1750772640;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zecGBL4EFfqvJ1+S5Ps/tbhcKJ3SUOGOERPfVCGUV9U=;
        b=CUFv2PObNavRzptPOtDK8DfRo2p64cQwRIkGNZFhx0OGfrqzKCrkNc5OkKdItx7PZx
         EVyu+miZgW0hqcbf+ECRJProRwkDT4/ncCOZMC774gvQoY5qnsTb4itPzKUKOgTUxGOC
         umOmXVkD0b0U1nKzXeh+3MvQP1XH/wj8W37Y93tiDcnkqfxNKmRWlbWifyBvrymjX02Z
         WC4QN/hiyP9vqoMX6DWYJgjLGv8CqQqQ1FbYQK1gPVGgOVOQaZVQEFgojhVQVi6yQSoY
         B+a+vMZyW0cTOC2CyDIer8aejefyhjYAZpB2IxGQRMfspjPRtLkHInf9+0BBKr3Wddoc
         ErMA==
X-Forwarded-Encrypted: i=1; AJvYcCUMRbQsLQCyCJlTL0eXoE5rdSBdswAtx4T3H0zUWEjFsLtC6znGZ1rAZP0vBeM8+bjG1NBQXuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YztR1wxGEbTlFVnRQFnaHOhbL59Pju/vXqONuzpCkfkgXFGcZC2
	FoPzhJdbDl5RO66aMRn0jFs84B5oNCDsSsAaOegHNlzEpKtKaWHp5Yca
X-Gm-Gg: ASbGncucotqCAtHnHZi7lH89VjD3fTklKcfZ3ceshXWnu3rddy/g2qlwchBc4QNTRhe
	2SgBuskI4tLVKrt5/o6DFnVwaDfd0gxWfqe7Mkr2r9U7cxSoY1xxODh6JJ0p0GcsRfPMWo/ZJSh
	O99pnHf0u6xsVZBsrabQmhmvx94RpoGFU3jUPt5PWtHutIR5EfPXkEsGlG4Lzne+sKqBFaZF9fV
	RJMxdpMI8trlIQtZZ/0DJ6gsAID4ozuvh/w8Q2UXYP6+K9wdp+HilMuEPmm8P+mWIEK2ve5E/dJ
	WyCh96UGdU2zU1aHIPASfOnGVyQmv7AQiNiun+BqSldK+2Yttdm5eyvVvnQbKHKlOAh4wn6778C
	Bcmdza6S/l9hXrzZW4JrODZg6+Z62EgZyz6QELi0Rl1pq
X-Google-Smtp-Source: AGHT+IGgIlcS/PryJ7lnGbffSNLneJYZk5+uA1B/WOdMk8Ma6F8q8Mlo7t8zz4EebhjQz/a0cLH/aA==
X-Received: by 2002:a17:906:478d:b0:ad8:9b5d:2c1b with SMTP id a640c23a62f3a-adfad29dd5bmr1181198766b.9.1750167840364;
        Tue, 17 Jun 2025 06:44:00 -0700 (PDT)
Received: from [192.168.75.93] (217-122-252-220.cable.dynamic.v4.ziggo.nl. [217.122.252.220])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-adec81bb9cesm864213666b.49.2025.06.17.06.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jun 2025 06:44:00 -0700 (PDT)
Message-ID: <33046593-17e3-4bdc-9d4a-94dc94ef5e81@gmail.com>
Date: Tue, 17 Jun 2025 15:43:59 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION][BISECTED] intel iGPU with HDMI PLL stopped working
 at 1080p@120Hz 1efd5384
To: Jani Nikula <jani.nikula@intel.com>, stable@vger.kernel.org
Cc: regressions@lists.linux.dev, Ankit Nautiyal <ankit.k.nautiyal@intel.com>,
 Suraj Kandpal <suraj.kandpal@intel.com>,
 Khaled Almahallawy <khaled.almahallawy@intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, intel-gfx@lists.freedesktop.org,
 Christian Heusel <christian@heusel.eu>
References: <8d7c7958-9558-4c8a-a81a-e9310f2d8852@gmail.com>
 <afa8a7b2ced71e77655fb54f49b702c71506017d@intel.com>
Content-Language: nl-NL, en-US
From: Vas Novikov <vasya.novikov@gmail.com>
Autocrypt: addr=vasya.novikov@gmail.com; keydata=
 xjMEYrX2ChYJKwYBBAHaRw8BAQdAf/bzdTDerOW5j+qrayMzPOCKthCx8KYKZo20cty68aPN
 KFZhc2lsaSBOb3Zpa292IDx2YXN5YS5ub3Zpa292QGdtYWlsLmNvbT7CjwQTFggANxYhBLKE
 QxE9sGxECbI4ubmfrsbg1d9tBQJitfYKBQkJZgGAAhsDBAsJCAcFFQgJCgsFFgIDAQAACgkQ
 uZ+uxuDV321klwEAm5+HyBecp+ofMZ6Ors+OvrETLFQU2B9wCd/d/i2NjJABAIssTvgdxlqF
 I6GjehRMPURi6W1uFMPzzp9gM1yeYXEGzjgEYrX2ChIKKwYBBAGXVQEFAQEHQODm5qV0UQrP
 hcJkaZVbhtVmb90gN6rIuN0Q/xTmhqJ4AwEIB8J+BBgWCAAmFiEEsoRDET2wbEQJsji5uZ+u
 xuDV320FAmK19goFCQlmAYACGwwACgkQuZ+uxuDV322trQEA1Yj4GvOlEPfyuhMfX8P0Ah/8
 QXCqgdMQH7PaNgIFFokA/1DgWcc1XGFNRHpOGrJNnF4Ese1hWjYoqo2iBlURPQwP
In-Reply-To: <afa8a7b2ced71e77655fb54f49b702c71506017d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jani and everyone,

On 17/06/2025 12.33, Jani Nikula wrote:
> Does [1] help?

The patch works. (Applied on top of 6.16.0-rc2-1.1-mainline, built by 
Christian @gromit who helped again.)

The patch (or the new kernel) also have a side effect of xrandr allowing 
a completely new refresh rate, ~144Hz. This new refresh also seems to 
work (I cannot easily disambiguate 144 versus 120, but I can tell it's 
not 60Hz). So as far as my hardware is concerned, this patch leaves the 
whole system working in all scenarios that I've tested.

Thanks!


Kind regards,
Vas

