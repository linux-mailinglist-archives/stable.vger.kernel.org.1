Return-Path: <stable+bounces-191338-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1982C120D3
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 00:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B03233B0381
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 23:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6350C331A47;
	Mon, 27 Oct 2025 23:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="PaUcYDUO"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A712932E129
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 23:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761607419; cv=none; b=aoI377YrYIF6E8xKzJXgfuf/ut7cDlwHhkL4bgcToIeRRMKTeZzVlmaDHyBCW2Xp0pn3tDndUPerMxappci7gbjIoO/Jo/YEu3hhnoXVyD+POdKk4QBe77ozBDSCeGdag4gXC3ycBlhFxq3JuEi1M+lGSY1vU4wPHUkYAioAh+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761607419; c=relaxed/simple;
	bh=bMX9jzNeBFXkZ6Y7HMFTaT/xWB1zBcledpc/9DsCuaw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m2cG9kgE1nv21qppJgdpfGzj6HQT0jRUoflDsWBd53QubhRTBljW3G5qMauoOZUN0x3R61EbKTKnCqsgjoh+47r4gHTeneydqrlBoW0NA4cV2vWIe5/9SjDfEohHRWSsUnZnY74uKnUD+6RR2tE7+o+Eqp9NxVR1roohIcMr/KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=PaUcYDUO; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sladewatkins.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-430c17e29d9so22243175ab.1
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 16:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.com; s=google; t=1761607417; x=1762212217; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oEYdNd7+OFAMq+81QLmV1d41glwOS9opiHm4I2f9DlQ=;
        b=PaUcYDUO8mit871vxTIYy8ao6zrBtGY403mAIvEJwsa0YnS4emB8CGITiYGocpaxJv
         IhmpmEeLjGy9YQ9peNkfiSLOxt3fU7Ez4amI2jh4dNjH1aggKXLB4mx3caSbwoM+MHSX
         jNHvQYtLEyH/vvFJyQZZYHOZjYXOEBmeB2IPivdtsdZwFI9/7wObOgY15cX/Pk987syY
         AX1EhxlExTKocFM3frmJag5892FtmLIbTzbxhDGB7yb+94VM45zhDeIAKU7D8lFa9BAH
         3GIcGAX0n5+ZqfS7SfGJGxes2y7QPNYzrjuQsfK7QcYSLwCw5bX1/8nrz8tn49auNQwi
         Je1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761607417; x=1762212217;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oEYdNd7+OFAMq+81QLmV1d41glwOS9opiHm4I2f9DlQ=;
        b=X8Diu88et0qwM5y7Mup7KLX8FdA4S2zf5z/lRbiqVChhyCGNfKuyktPVCQF4AAR3gO
         H58WungHa6tcaEcbnOVpIay54BpTGxs6rnSZy0GbkFU+MVYhymbcVH3R+bVkeI+w9eU4
         FtFFNTJycNNDyG71rxWwx6gBbYir+Yb7kv8I+4Bn69OKTZK9mJz7qRCyAwURJuup/E9D
         dxS4Rx2dAkrZzIeBeSy+6AJjdwWrYIofZskxkLeqJgcnIm1cCMn24FuRKuUqdnaLqDQD
         br36D8FmbmOTamT8XnUsASdCX7/ljjlUj90JLO4JYGDBoOC6YEe3LTpfszcWdx8vyy2f
         80UA==
X-Gm-Message-State: AOJu0YxMOo4Oti8hOQ6K5ZWYlMMiy0plfQLK4hx8r2OOprZI8GApm7ya
	FaR7RPJj4feLvIewU3oAWbt+eZSgVp6vWti90i86Iv5ejeZNBXmDkzYiRSROm5JlNA4LGQl1ric
	l3BVfR2NG5aew
X-Gm-Gg: ASbGnctudgkzCeudh4ChNtTBV/6sYMqOTegYdFl55UDSNV4eABFXxT5Z/HjsxaHsCty
	uAfSRmNfNKVM0h4ZZ6j52UR/EAjODX5+SozIlEzHsT3WkiZwLC6cgH/gCHYMPPsMDgQHvfbaNPJ
	pN8P+2/2A6Zv920pzg46L8KHAv6pZZZ8cuo8ZCSi+OSsnV9qWOeLSAMTT8usCRKlmYHqp55ZEHL
	KifksBxfPmYLH11jenZ5Sq3eRK7J+T3hEBIWablPv1h2dQeSVPMarHQyOXNxn+XAiFF+3Qb166y
	3R7WBt1lGCDCqSdQJUmZpv3JVsGhhRaPHDvpYs+hEAt/jxZ8eKoiXO/TwtQ5drufCxWXNeGJURt
	YYlYe8bebM9H9JAyDJvn7fGo9wA7pWcnrYTp84zxAZrs1ZBBNZaMP86w/hYGuV0cv3Mj2VtY+HA
	jQENWKvtvJJMpyEU4=
X-Google-Smtp-Source: AGHT+IH0ZPGnVVgtPdbyncjoeDuRW4QsW14xPxt5y+rrOlXlui4rOMIhJm1pDebe0CYZXcs2RVpexg==
X-Received: by 2002:a05:6e02:2586:b0:42e:7273:a370 with SMTP id e9e14a558f8ab-4320f6a770cmr23370685ab.5.1761607416707;
        Mon, 27 Oct 2025 16:23:36 -0700 (PDT)
Received: from [192.168.5.72] ([174.97.1.113])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5aea7ce584bsm3684302173.27.2025.10.27.16.23.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 16:23:36 -0700 (PDT)
Message-ID: <007900a3-bd49-4532-87bc-3fb7a83d6a1a@sladewatkins.com>
Date: Mon, 27 Oct 2025 19:23:34 -0400
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/332] 5.10.246-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org
References: <20251027183524.611456697@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <sr@sladewatkins.com>
In-Reply-To: <20251027183524.611456697@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/27/2025 2:30 PM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.246 release.
> There are 332 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 29 Oct 2025 18:34:15 +0000.
> Anything received after that time might be too late.

5.10.246-rc1 built and run on x86_64 test system with no errors or 
regressions:
Tested-by: Slade Watkins <sr@sladewatkins.com>

Slade

