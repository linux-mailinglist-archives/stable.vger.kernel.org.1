Return-Path: <stable+bounces-180658-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA111B8985A
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 14:45:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 827825A423C
	for <lists+stable@lfdr.de>; Fri, 19 Sep 2025 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EA023C8C5;
	Fri, 19 Sep 2025 12:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="YTPCtv5S"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDD723C505
	for <stable@vger.kernel.org>; Fri, 19 Sep 2025 12:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758285932; cv=none; b=A6fnmA7/Ud5JDFaJs8BIh0uVyxldJnZ7UW49FT+IA4ZgcZSGDvuundKwM0dB2v4hIEv5sXAM9RGKkt/kBHIcixIPPdqv3SnbQb+h6oPr3OSvhTnYOHbwlbLtx/kp/nuM8/+G0sd6nYWxk2huC8uCAq+RTNWVE7DZmywwRXnkqsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758285932; c=relaxed/simple;
	bh=nEO9A5estcrBaZZ3rYeaMOsotbmu+x5d3sSjpotKCRI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wl8JfJ6V9dOnVbyFRqyRRCnC/CdL/UeiThg/PvOuP6Eo5UvPB4hVSFhgh9tntX02cVHYdtsY+RhRc8czMidMEHs2x46IENHGEF9q4OE6df7ItrjOuxf7qosxl4QbN03wMpVz5q8K8GdXoNX9/1LTOBQwfhOcaniM0lQ3o1s41mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=YTPCtv5S; arc=none smtp.client-ip=209.85.166.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-il1-f180.google.com with SMTP id e9e14a558f8ab-42408762dc3so10674815ab.2
        for <stable@vger.kernel.org>; Fri, 19 Sep 2025 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1758285929; x=1758890729; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BzyDqMhfge6O0mUrp6h5HzhJD8esfaSJIML1z8ifdic=;
        b=YTPCtv5S4+tdo+WA8wVJ8f8Q9eCVj+ULcITnY2ZYVwM203ESg0J3ExtiuDQKE44p9P
         RhqAil7+bwrWT9WtEIVjaO/Ls7wCmNrZMHC174V75zvzhLGhu8wB4KPLU8FcONJgfXnz
         PNPJ6ykaJb8D9r7OjUJ6p9FVVyp1SBFFipVfnEZeQv+uAVllh3McnpH2syhMBPlHrKgM
         ph6Z50kBCk2Ks3+PnK6zcFerv0AA3O+UBCptktrjgLQsJAXVppgMcvvn2lPDWbFYg7IV
         umZ3pY0A2hKJIazBXwH2pZu5QfxLfQ2RHz7KoanhpAZLOZOkl7CkbrEpiqEt/fIp94mN
         gKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758285929; x=1758890729;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BzyDqMhfge6O0mUrp6h5HzhJD8esfaSJIML1z8ifdic=;
        b=kIktEFkJ/XwgNwnbBu8eccxC2P+3emZeBbrKA87TgzQtyV1XlbS8WmJIkmQCBrJevY
         izRE18Vog7/P5xWER2uFt+/fpRpeNKQ4g0tEDTBXFrD1ZoSPoLfFnuXV1yMQGlCpo871
         ea9JR+LZ+4tzwxvyml1tFW/BqEUtVpZKstJLA/akqhypyDNLecP1asBhN3SeIuaYesKB
         jcOJ+qhoBU/WuScg1LUD+aCL2ypT/OctDCa7ysB3q2DlBSMEZwAbT4712Dzry/PNsox5
         65Zu7u/miffcWWzyxRQoP6LAjk+YxRMjWNgHZB6v2BZTYvP46ztIIvscgZjxJ1L8UWv4
         03rQ==
X-Forwarded-Encrypted: i=1; AJvYcCVsUMflkq8+IUssUio3aoc0toqt0eziWW4ACuQqX/4oKQdC0VeKUUqYoZxYUIMTZaoaTDQ6xqM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ndThw0RYL8DO200Po/zKG2HeGtZlByhEPS49wBhfuhwYiKjH
	EnjpCfnvteOvcPgVMPGuPqubKgh7Q+LxF6sNN5u9ktrfuSttQu9s9hms0URlhFGKdwE=
X-Gm-Gg: ASbGncv3jj8OttfWJwsbJSUdnX+ZSds+WjGxHgUKnXdkm3Y/48xt9G1o+JgJ6iQBJBZ
	p6maEVrnBDrLfpOTrBLlUNwrliTfQmOcyqip/eqaafaPGd5WMR08y6UhTW9/k0QYPbteXw/22VC
	mMOw+H3sSmDSEGaZFh0lWYnh3vcCG9sjPAJuqP+nfZBTD24vXIf7bbvc2DpngTBNcmKoD22AWH7
	BRo0N29pYko4AqhXciOoREcp4OucANHPHwoRxXfVorAgmX2nD1U5Fbxw+QTjOAGOgm3n4GILgIR
	2pgdRMZTKlwJGIKSXz+4GurECX61COHOTq5v+1uH6fgysBsFJGGe5NxSZ8mnjasFOW1rMKnwuoR
	JmivRlsltWwKsCBGy5zCMT8jzmcdDNLH+lzO4mua7vetsxqRYYU7kmZ9uz7IA6Q==
X-Google-Smtp-Source: AGHT+IGaYKcNyrN3h+Obk0fXfCRoaZRWy8GiOsFpfO6FVenXyvQXLeYAMxkGNu2xkv3b70xUOjmYLA==
X-Received: by 2002:a05:6e02:1fe1:b0:420:f97:745a with SMTP id e9e14a558f8ab-42481999bd3mr42354935ab.20.1758285929601;
        Fri, 19 Sep 2025 05:45:29 -0700 (PDT)
Received: from [172.22.22.28] (c-75-72-117-212.hsd1.mn.comcast.net. [75.72.117.212])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-53d53c6e38asm2113770173.60.2025.09.19.05.45.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Sep 2025 05:45:29 -0700 (PDT)
Message-ID: <db9a797d-a0dc-492b-a38f-cd91caac0397@riscstar.com>
Date: Fri, 19 Sep 2025 07:45:28 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.16.y 3/3] dt-bindings: serial: 8250: move a constraint
To: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Cc: stable <stable@kernel.org>, Conor Dooley <conor@kernel.org>,
 Conor Dooley <conor.dooley@microchip.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <2025091759-buddy-verdict-96be@gregkh>
 <20250917115746.482046-1-sashal@kernel.org>
 <20250917115746.482046-3-sashal@kernel.org>
Content-Language: en-US
From: Alex Elder <elder@riscstar.com>
In-Reply-To: <20250917115746.482046-3-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/17/25 6:57 AM, Sasha Levin wrote:
> From: Alex Elder <elder@riscstar.com>
> 
> [ Upstream commit 387d00028cccee7575f6416953bef62f849d83e3 ]
> 
> A block that required a "spacemit,k1-uart" compatible node to
> specify two clocks was placed in the wrong spot in the binding.
> Conor Dooley pointed out it belongs earlier in the file, as part
> of the initial "allOf".
> 
> Fixes: 2c0594f9f0629 ("dt-bindings: serial: 8250: support an optional second clock")
> Cc: stable <stable@kernel.org>
> Reported-by: Conor Dooley <conor@kernel.org>
> Closes: https://lore.kernel.org/lkml/20250729-reshuffle-contented-e6def76b540b@spud/
> Signed-off-by: Alex Elder <elder@riscstar.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://lore.kernel.org/r/20250813032151.2330616-1-elder@riscstar.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Thank you Sasha, this fix looks good.

Acked-by: Alex Elder <elder@riscstar.com>

> ---
>   .../devicetree/bindings/serial/8250.yaml      | 46 +++++++++----------
>   1 file changed, 22 insertions(+), 24 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.yaml b/Documentation/devicetree/bindings/serial/8250.yaml
> index e46bee8d25bf0..f59c0b37e8ebb 100644
> --- a/Documentation/devicetree/bindings/serial/8250.yaml
> +++ b/Documentation/devicetree/bindings/serial/8250.yaml
> @@ -48,7 +48,6 @@ allOf:
>         oneOf:
>           - required: [ clock-frequency ]
>           - required: [ clocks ]
> -
>     - if:
>         properties:
>           compatible:
> @@ -66,6 +65,28 @@ allOf:
>             items:
>               - const: core
>               - const: bus
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - spacemit,k1-uart
> +              - nxp,lpc1850-uart
> +    then:
> +      required:
> +        - clocks
> +        - clock-names
> +      properties:
> +        clocks:
> +          minItems: 2
> +        clock-names:
> +          minItems: 2
> +    else:
> +      properties:
> +        clocks:
> +          maxItems: 1
> +        clock-names:
> +          maxItems: 1
>   
>   properties:
>     compatible:
> @@ -264,29 +285,6 @@ required:
>     - reg
>     - interrupts
>   
> -if:
> -  properties:
> -    compatible:
> -      contains:
> -        enum:
> -          - spacemit,k1-uart
> -          - nxp,lpc1850-uart
> -then:
> -  required:
> -    - clocks
> -    - clock-names
> -  properties:
> -    clocks:
> -      minItems: 2
> -    clock-names:
> -      minItems: 2
> -else:
> -  properties:
> -    clocks:
> -      maxItems: 1
> -    clock-names:
> -      maxItems: 1
> -
>   unevaluatedProperties: false
>   
>   examples:


