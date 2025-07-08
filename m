Return-Path: <stable+bounces-161322-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 508ABAFD551
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 19:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BCB91894BCC
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 17:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CFB2E11D7;
	Tue,  8 Jul 2025 17:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W75C1DG/"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B15A2E03E0;
	Tue,  8 Jul 2025 17:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995621; cv=none; b=gRJGrunQU430taPI5KZ8SbM+f7B08+qzVe1zrM0LmrKXlm+kNOy9ePB9yAae7jx0G3wykyPaiEP9dJkgQBEW0AeLN+orhjXIv4IDyEAJF2neQGviFgC2xL1HWKu6LR1nBeVxtp0Yo0NmyQJ6mxmoteQ/cY+lIU8lV/lwQOe+riQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995621; c=relaxed/simple;
	bh=aP/mRBWjQBJMx96i5jdeiSPcs1Fo3UqoRHciORi0Ir4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1ZFTNY9P8kv7hY87FqwcjmZxpmkfyM1hVqkuVKwoozCB3E1ZzpnwcKWS/nAw/3KgIWpPVn5p//G+l3O8Wq7l5SDVQ+WozFzslyQ8Yjzl3tkyJzPRDi9GDoogyXV60Ns0frarSpakubWHA0XpeWpBi5mFNg59zd3W8O2+x1LQu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W75C1DG/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-31329098ae8so104400a91.1;
        Tue, 08 Jul 2025 10:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751995619; x=1752600419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8qqe29PKJbbQlxAbGgIvXL1kKmgnDPtfcexo6IK8E3Y=;
        b=W75C1DG/OW5ooz5n1s0asmr4cnIzicqTMxbxiAYLYvGbiURsmptDf+IkWXL+cJWBKX
         5bfRwefoWfNUrQVqK7U+ZeOvSbXJLTs8uN6hLeQPbDvPWnvBTd5M97dkLeoxLdzMsY1p
         legQlP926OqMNSX2DlEKzHMpCSFFawKuoIsDEq0S6BdBGRRQoHzXsGcPxa6aTPS54Vv1
         J2n5dCvPQPu8U6Zkjtm+oWGWvlvfAU8YQFuIckM6TCRfKWTI+hRfEe9kR9CBgZgFcMII
         DcoYv0gVobcKef0/7mufVfGVWHD5fAqef+LB7II+OL9o4c43WAaaqDMLM7GWIqFGKUIV
         mU4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751995619; x=1752600419;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8qqe29PKJbbQlxAbGgIvXL1kKmgnDPtfcexo6IK8E3Y=;
        b=WWmlve2eJ7llpor2nh4KYmxRKWiLPLaWH7ZEcAlGM5CSkbUkM0gqSCHrENp8QFINcO
         O+EwmLBzlpdtVbj9jcmgsA7QCAtavOsPc+u8v05a/+bHmI1W4LrcxOPhlqCIbkeCD+7I
         MARWy0qcJpPXotT0jrO1DdvL5g5g/Q7N1YvXJsw5yof/7riohUXUsFWOgd4BmajCm8Sg
         vHvKnHLbM96W6ws6tluZQpdP33XGLT5NR5FgRygiX0UhCtPVJ8LJlyPKA091oOC+zW9Y
         CRtnHb5xDX4p3C2Xa4Df/wwB81YDSKc73XbmTWZrtdXYuL2TsSQffUp3o3d0C4QtXJoV
         xDiw==
X-Forwarded-Encrypted: i=1; AJvYcCURkhMk/L3j7Af6SRfU6cOKd519Gzl9k0DZ1Go9vj02z1zASFFWufqEeShAR5UQPsqHDwm1nCjfOcCkB3M=@vger.kernel.org, AJvYcCVw+WQFEcvkbI54tQCStvlC4F2GXOd8SkumH1YbmUxo3bbW1iSh7hkUxcWJnYUpQOi3tPIhyqW2@vger.kernel.org
X-Gm-Message-State: AOJu0Yww7wvXE/jwifv8c/HsS6WCpmPX4E000vkIdnseJ1RW7aRhcBGO
	uUr4NfFyMiaXe0GYeX5en7dhKFpxOxLP6ASCCvH6WqdwzJHo+t7Y7baJ
X-Gm-Gg: ASbGncsfSIxzcwxC2b8v1GyV2qvxw+/U5sK/KZog2GUN6CxMNI6jNXr5sFvv05B/QeJ
	e9M2e276Zd2W0jDS/fIzeYvJwBkh76P3GPgBF98ZjGSRWWIStH/FLn2p072WE8oP0icGVsevSd0
	NNSWy3U2qulGs2lWHWZwwwJKJvT2fRozKn3EC+UMD0HBivhJ3McgGLCotXV1wLgP4k3Zb1pKlyL
	pThhywXeU/G9AFOHzVd7xr6FKe/LnP4F/pDu0o09P4cm7ylsFLQUojBxJEC17TdkOEivqDpp46k
	H97WjqC+xwqe7WwlGKBGQgCXaK54BwNsu7DC+WKpTosEIqCF3dn4jBwKJQjB2FIEM5d94TPxlcU
	WbBNPdQAD3xDv9A==
X-Google-Smtp-Source: AGHT+IESQOThNvXIcC4DqFuwvAJfFP1OvmMh5FzVhkz0Sq39a8tV4J0QFYU6IUd5C/6X/J5JnBTERg==
X-Received: by 2002:a17:90b:5443:b0:315:f6d6:d29c with SMTP id 98e67ed59e1d1-31c2276a4efmr4557263a91.15.1751995619406;
        Tue, 08 Jul 2025 10:26:59 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23c8431a0eesm121138555ad.8.2025.07.08.10.26.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Jul 2025 10:26:58 -0700 (PDT)
Message-ID: <12b05333-69c2-42b7-89ea-d414ea14eca0@gmail.com>
Date: Tue, 8 Jul 2025 10:26:56 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/160] 5.15.187-rc1 review
To: Borislav Petkov <bp@alien8.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org,
 Kim Phillips <kim.phillips@amd.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, patches@lists.linux.dev,
 linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
 akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
 patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
 jonathanh@nvidia.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250708162231.503362020@linuxfoundation.org>
 <2438aa80-091d-4668-90e0-fb75f3e0b699@gmail.com>
 <20250708172319.GEaG1UB5x3BffeL9VW@fat_crate.local>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <20250708172319.GEaG1UB5x3BffeL9VW@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 10:23, Borislav Petkov wrote:
> On Tue, Jul 08, 2025 at 10:20:01AM -0700, Florian Fainelli wrote:
>> The ARM 32-bit kernel fails to build with:
> 
> Can you give .config pls?
> 

Sure, here it is:

https://gist.github.com/ffainelli/2319e6857247796f0a9bd99c5fe6e211

FWIW, I also have the same build failure on 6.1.
-- 
Florian

