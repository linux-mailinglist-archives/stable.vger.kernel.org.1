Return-Path: <stable+bounces-2801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77AD07FAA56
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 20:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31B1B281975
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 19:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C11F3EA9A;
	Mon, 27 Nov 2023 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="TWOnMD37"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-x44.google.com (mail-oa1-x44.google.com [IPv6:2001:4860:4864:20::44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C770D59
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 11:36:16 -0800 (PST)
Received: by mail-oa1-x44.google.com with SMTP id 586e51a60fabf-1f9decb7446so2288882fac.2
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 11:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1701113775; x=1701718575; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1IRooEsUin5INdOJVJKOU/vU4IncgxmhANWRJafAQM=;
        b=TWOnMD37y9p2+P/sqIyWKQWiYJkIJukzkomNRD1fBSCyE3jlpMbjyNsc1oEi6K5MxC
         dZOac7PIDBRwM0KyF5qS6hJie+NZpZ3nGA10ys7UsIE2RavXVLtfuLeqZFV22B3KHCyG
         NBl9b/9KFMo4jaWufNovXL1LNPbO1Yo9ObzQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701113775; x=1701718575;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1IRooEsUin5INdOJVJKOU/vU4IncgxmhANWRJafAQM=;
        b=DQKMsp6FVEE7I/7ZSHtxDIyqU+7F4Pcpkf9soLl6eHh8lFeNzwP9QpmHR3n6RIRKSg
         /7ku2ODcZ96C6wFONjmPdhf8XHcLU2ltWf9N+mDBH7FyZ6vIY3rNU3luhwwG4HHpunG1
         F8tZhpwJ6/jZW+qXrstMUTnjd9pMJvV9ZF7emEs4CWGVfvhs5oYEqlL7REPBuJSyaTKL
         P4MVHl8HMTHdGGXXmWVfyqfvnhrGSRzqJn0x6V91IRY3tUPCo+jM+7OS0XlgNawnBGlF
         UpHeXHs0NOznJFxgzqI4LUCb9CRpoYwRrsuo4x8ccYSHQLwvTujAd8uR/jivETbaMXsf
         5tBg==
X-Gm-Message-State: AOJu0YwmoEcuEKfLprsMKxf42JaQk7njmMjurebk/DZYmhzJ+vAtOcIz
	AqYW6NMkh7KpLOE1Jba+TIFx5w==
X-Google-Smtp-Source: AGHT+IEJ3WupWcdW8AN5qBBpFtWvb9iXJuzI4F91nYX9vpETnliJBN68Mz4orAkz85eSDwTlP02vkQ==
X-Received: by 2002:a05:6870:6c0b:b0:1f9:571e:f80f with SMTP id na11-20020a0568706c0b00b001f9571ef80fmr19132032oab.13.1701113775612;
        Mon, 27 Nov 2023 11:36:15 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id m2-20020a9d6ac2000000b006d81feaab3dsm521897otq.69.2023.11.27.11.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 11:36:14 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 27 Nov 2023 13:36:13 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.6 000/525] 6.6.3-rc4 review
Message-ID: <ZWTvrVH5kSM-o5zE@fedora64.linuxtx.org>
References: <20231126154418.032283745@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231126154418.032283745@linuxfoundation.org>

On Sun, Nov 26, 2023 at 03:46:18PM +0000, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.3 release.
> There are 525 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 28 Nov 2023 15:43:06 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.3-rc4.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc4 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

