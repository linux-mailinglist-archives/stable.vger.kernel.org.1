Return-Path: <stable+bounces-33-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FB77F5D11
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 11:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A0FBB2105D
	for <lists+stable@lfdr.de>; Thu, 23 Nov 2023 10:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF736224FB;
	Thu, 23 Nov 2023 10:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M1f+F4tC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4B01BF
	for <stable@vger.kernel.org>; Thu, 23 Nov 2023 02:57:42 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32fdc5be26dso400762f8f.2
        for <stable@vger.kernel.org>; Thu, 23 Nov 2023 02:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700737061; x=1701341861; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+y8GqhplESEfvOMr6yusQxqrSvhQKePmum3wvwP/q1E=;
        b=M1f+F4tC+fWJAryB96uDHg2geNecTmnMExPz8MIrPmuLMFCylEwamwjqunb0yvNRhp
         Ak93byBgqLYn6TVylsJ87M1IgQ0Ip6xx/GNoZRRodfu+ztpJEG5nSZaJ3MCm96IPVvBE
         lQauoS0xY3+Lukg2WczKv/9g3QJYjPlUV6SUSJ7LgAgpY6muiXX63ScZXruPffua9iBa
         IpnbL+yKl4+n64qKrg+6SuMyaaKgocEcCbvJc71EJV1xpbb3Mj/OnsqFDO6Cqilmpi5D
         QFqbXOiOMrq5FWsRc2ev3Z1WschIrkO54Idb4wFs8CE6a1OSU1Q5oedrt8AVRyezRyay
         lWrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700737061; x=1701341861;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+y8GqhplESEfvOMr6yusQxqrSvhQKePmum3wvwP/q1E=;
        b=d0sMjUR+4tog0L9TcR+Sbs1T02ez/qW0lXj6SOex3uxr/zKL4fSW1NAs9Qad3tNO9p
         qRIDR+SYdbAIAYqeSU2szlZdOXlg4Sk5MyjqMaQQ0k6lOfEHnCNWDICwSq7Sy4b7T265
         mo43Bo+P3fn3yis/Qrqjv+kggZEKjlymWFcTar4WQLsbf2og+UutGMtmdMiRIuJI4JGp
         T8HVxcsoDuqZwi0XV66T3oeJAbdt3uF3TwuryshZG18gb5Z3iN1cSUQrmNS9TAr4Uyv1
         G2W+4i8JrTED+uEHginG57bOs3BaI1JGIJolvIvqASI96Cb0ym1p3X28FSZW9A855NaC
         ReRw==
X-Gm-Message-State: AOJu0Yyh+23AUKqlPQs72rY/hXKwK2129u2Ma9fD+XhadlbFZfz1CW+k
	nieDXfovaKKR+7zljj/kABIn2CYqpOjIngNtHmM=
X-Google-Smtp-Source: AGHT+IFobX8x5JuXdPLKT7AZWEuvVw5rHD4gknMa/X0TH24W9CCMFaJ5M0eNMQY2ARLhbwdrcBTKQA==
X-Received: by 2002:adf:db02:0:b0:332:cc85:70ce with SMTP id s2-20020adfdb02000000b00332cc8570cemr2239543wri.33.1700737061193;
        Thu, 23 Nov 2023 02:57:41 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id c11-20020a5d4f0b000000b00332e67d6564sm185067wru.67.2023.11.23.02.57.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Nov 2023 02:57:40 -0800 (PST)
Message-ID: <2bf64582-b7c6-469a-858a-f83b2d50f12a@linaro.org>
Date: Thu, 23 Nov 2023 11:57:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/2] soundwire: bus: introduce controller_id
Content-Language: en-US
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
 alsa-devel@alsa-project.org, srinivas.kandagatla@linaro.org
Cc: tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
 gregkh@linuxfoundation.org, Bard liao <yung-chuan.liao@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Philippe Ombredanne
 <pombredanne@nexb.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Vijendar Mukunda <Vijendar.Mukunda@amd.com>
References: <20231017160933.12624-1-pierre-louis.bossart@linux.intel.com>
 <20231017160933.12624-2-pierre-louis.bossart@linux.intel.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231017160933.12624-2-pierre-louis.bossart@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/10/2023 18:09, Pierre-Louis Bossart wrote:
> The existing SoundWire support misses a clear Controller/Manager
> hiearchical definition to deal with all variants across SOC vendors.
> 
> a) Intel platforms have one controller with 4 or more Managers.
> b) AMD platforms have two controllers with one Manager each, but due
> to BIOS issues use two different link_id values within the scope of a
> single controller.
> c) QCOM platforms have one or more controller with one Manager each.
> 
> This patch adds a 'controller_id' which can be set by higher
> levels. If assigned to -1, the controller_id will be set to the
> system-unique IDA-assigned bus->id.
> 
> The main change is that the bus->id is no longer used for any device
> name, which makes the definition completely predictable and not
> dependent on any enumeration order. The bus->id is only used to insert
> the Managers in the stream rt context.
> 
> Reviewed-by: Bard Liao <yung-chuan.liao@linux.intel.com>
> Reviewed-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Tested-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


