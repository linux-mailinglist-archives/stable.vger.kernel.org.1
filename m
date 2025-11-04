Return-Path: <stable+bounces-192371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF69C30D4C
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 12:53:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7E0F18841A5
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 11:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2D2EB87C;
	Tue,  4 Nov 2025 11:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="MlmPrg96"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533DE2D5955
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 11:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762257230; cv=none; b=cAaQHJvxZUnFJJGGnS4D5ACjqn7y7T6l0M6Ribi1li8mZoUWL8ZdBTT50v/mZghOtnYGdlyNoXSYtQ9CXkOEKGwxNsIx40yQnbjiX7x6aF1g99ETECiJI/qhcpNWcJh2HPj+oP9JNZFzWq3tEmDVCinWXBTrTm56bgnhIWUVqT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762257230; c=relaxed/simple;
	bh=I36LzGSl9wytAsBf1yTXZ1w2SrwG6l/dCnsmOh1gGrc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LoA5vQW96xX6tkSv6zdoE4JuzMDY9NUw5Qcq5yW1kZ+rAhgdExj4N0HsMoCweC6YA5QcGYCM8/mfGcqEgkIfpPZ3GyW+8fyolDRFGxp3IhAX5JPqdD/BnVtd2umUXdN4ebJubMT3RzIl5hZNumDENR4iejUT7NbZs5hoWVzCo0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=MlmPrg96; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47114a40161so6927685e9.3
        for <stable@vger.kernel.org>; Tue, 04 Nov 2025 03:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1762257228; x=1762862028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I36LzGSl9wytAsBf1yTXZ1w2SrwG6l/dCnsmOh1gGrc=;
        b=MlmPrg96LFRqxvhrbK0I99Y3mY8Rrq0VCaGf5E8xXGxVFFGMtvcCyrKanpVtWafb+f
         qFl6CvABdtYGYlYZZ0sE+g7Kh28FAW7IP/WCDWSKiHPRc2UCzKFftKPBVoH3/pMw/YIR
         Eo+9/OWQXIQMIagvNfsUlSWwz+PjtK8pjQbAMy0glqhcb6vPexE1S1Al2tZxWInnrvDp
         gluSziYScLerys1iQW6Ya0fxIaPwDLIb92G0hdur+SEirXERwgAA06yRJIAYhFUQZsof
         2pPMHD8UJ65YmgCbL6+Z+HofKBx4J2iuI/VCRYKxPhEMUw17bGHN6IGGraOd9upsvab9
         xLFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762257228; x=1762862028;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I36LzGSl9wytAsBf1yTXZ1w2SrwG6l/dCnsmOh1gGrc=;
        b=qq7EvtiCqOxJqO7mxltu5VeSFOVKOOkfFdYALJ5Ftt9Wx+GkbkcF40u7yRA78BFe4Q
         FNxSsJcZsx/5iNKe4lV4aVTc5e/uRCMGONVdfWfOd46Y0kY+HiW7/47vLwH3uKtHmMwg
         H9tCMs2MetHNrbFgcRQGW49eBgv2HEzsicD54PosCC5jFpknqyFO7UYxhNlzHbXvdE8g
         kpKPM+M8AV+GBUJHuiBbeF1Skw0bpAOP8rkYUaysdIZI+FN6pLclhjagQNqFC2dplJtm
         bbp6H/d7f4xJjUFPESKFLhT6YNB8KMzJp8AyKabXDYnGHAHmX/dfu1V4/z2VePHl5Uob
         qLUw==
X-Forwarded-Encrypted: i=1; AJvYcCX5f5eIVurCWWwbqymum6jKkD5VBsaX3dZ3ebYDzmcfphcncc/tvCrVjG4ZoBeY1uY1an6EffM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym3BT9tXOjxm6CS7YNLTYD3kJFHSayczIF/Na1Bmgo2Kg7Yxfv
	SoL/PxnqLfanY+V5WQJcviue+0is0kqqh5e9FEo2uuNKxBKYv/yuniAAKW31DRYaAqs=
X-Gm-Gg: ASbGncu9TMZwyP86NoYghLZpbcHRCpB3/jUl/aLwGdP6IGQLR9xiuCFiXNBdXIw6spb
	wemqNZQJv9czetJG7Pd+u6tbLBxY3mAToN50sHiWl0f0pfeT+BgV/2HsnNgMRspsASPwAN0sE8O
	8tqI7sSSAgnWBAUSWvHeDDYOfKRHNiF4aoaOolHkdmuXF7yAsnvOriiJIY7btzs551S5GvMJcMX
	aOZkZ/Nwmxn/qE1O177aHN/u04C/MZPPEypUaaAfXPXL8C8h/Dct8TIr0fFFMS/3C41LmHEHRzR
	9YHtfkmA5W/ACVQAcTF9MpCC8bM6uez1lYDVybCPyoIOv245NOpZFdnugcerGVgJJ45H0Rvrywa
	WsSJKPkTQNQKCDqpRGA84uaY6LQtAaIddbEMXnUb1zGAvFQU2D+eT8tihsXM1LURph6A1u5knar
	x5DkPBs9SK
X-Google-Smtp-Source: AGHT+IEvDHwONng4aJ6PO9esJ0vd+TzU9M+bzqzfCyIK9M1CiPuaL9xKsM8JexApKzS2Btn21bVVEQ==
X-Received: by 2002:a05:600c:1553:b0:46e:436c:2191 with SMTP id 5b1f17b1804b1-4773089c34dmr151966595e9.25.1762257227721;
        Tue, 04 Nov 2025 03:53:47 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47755938f45sm16302215e9.4.2025.11.04.03.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Nov 2025 03:53:47 -0800 (PST)
Message-ID: <6296a8fd-bc2b-470a-a367-61c2d80fe8e1@tuxon.dev>
Date: Tue, 4 Nov 2025 13:53:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: codecs: Use component driver suspend/resume
To: Mark Brown <broonie@kernel.org>
Cc: support.opensource@diasemi.com, lgirdwood@gmail.com, perex@perex.cz,
 tiwai@suse.com, biju.das.jz@bp.renesas.com,
 prabhakar.mahadev-lad.rj@bp.renesas.com, linux-sound@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org
References: <20251029141134.2556926-1-claudiu.beznea.uj@bp.renesas.com>
 <20251029141134.2556926-2-claudiu.beznea.uj@bp.renesas.com>
 <bdb14543-e611-42d0-a603-300c0ea17335@sirena.org.uk>
 <70362ac1-244b-43c5-97cb-ebe8f5b90c3f@tuxon.dev>
 <56911e0e-0f25-4134-92fd-f89cb47fd9b6@sirena.org.uk>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <56911e0e-0f25-4134-92fd-f89cb47fd9b6@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, Mark,

On 10/29/25 18:14, Mark Brown wrote:
>> Would keeping the regcache_cache_only() + regcache_sync() here along with
>> populating the struct snd_soc_component_driver::{suspend, resume} be an
>> acceptable solution for you? I think that will work as well.
> I'm not sure what you're intending to populate the component with there.

Sorry for the late reply, I took the chance and prepared a new version
showing what I intended to say here. v2 posted here:

https://lore.kernel.org/all/20251104114914.2060603-1-claudiu.beznea.uj@bp.renesas.com/

Thank you,
Claudiu

