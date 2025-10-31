Return-Path: <stable+bounces-191973-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C27C27280
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 23:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D6EF4E2CD0
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 22:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B82E3161A1;
	Fri, 31 Oct 2025 22:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="hZjEPDaj"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF4313267
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 22:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761951503; cv=none; b=gpCeYzbx4fyyCS7mMzIqE+UZkrpF8PA9Omqq620HhrVv3g7Oitrci7QcBrHGNWg9qlbZHNWQI9w/sAjPft7DYYOR8vYXxr/COw/rY6o5Up0hkFrD9vU0wualUQAcO4Ltelz9wi8G2rddlj5uxD8JI41yuFbwynSldQijJsUbHy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761951503; c=relaxed/simple;
	bh=cFcjY5xhnj0bHFmoZpuKhefy18W+dkPGLsfStYZg96A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adtCge8SysYy5khPwh0LzSTnYED0PFFe5fmzGlqE5AdL3Atzz8Pop6Uhq/tVtrytesFnxc4tTu/V35WS3j2X4vsMfBlmgavQHA+vv/ie2zXGaO5BwN1BGyR7xMxuVXYpa8B4eeTbQEAwXz0GFPQhqLiRFvVh59P466jVpJqGyYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=hZjEPDaj; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7a26dab3a97so1927498b3a.0
        for <stable@vger.kernel.org>; Fri, 31 Oct 2025 15:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1761951499; x=1762556299; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rTbu2Y1n3nG2K1ZFxQ3ZdRVxmOMkuNF29G4mR+aamAE=;
        b=hZjEPDajpEUqbi1rIVdbnnZcrCdEV2al/Gki7dYAdWB20uc1D2g1D8p7SXMhceIeZ0
         Fe/1alz0L+KPLGPY7BtzRgrQM5aDNuVtBtrjEg/r4ndAD+QESg1HAfjbRm3ZGBzcYnw3
         VDgZHyso3db/42wKVM/ZQxxkt5fBwLIjQZmt0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761951499; x=1762556299;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rTbu2Y1n3nG2K1ZFxQ3ZdRVxmOMkuNF29G4mR+aamAE=;
        b=dCFHLlAzfUaXYDC3EmbdGM0CeIYbaCuyJkxrtDc+Sic8amzJwblDe6W7E11DOnCkkD
         G2etgWafmCseqeccY90jp+YJvfKwMh0RFZCUv6fAtsuyxOt7p+NqLb+xfpFLPwlsnoKB
         aKOQZe1luaF9S0FoFXA5ZGABmjTKPVu6ce9YU0gzrp4YCB35/+AhhyQ3qYpIfQk19YGZ
         ECsHyJLMYQKb++cgSI49TS/a79Im45RvkX9wyHw/DXAyHb0VTdZKwcQGwgpWbtjXvuoC
         Agw+CteJhktYBpLM1WMNur/QXnasJw410cqJJ2aYWUhXvAcW7dzrbYN35//rnmj2eFtr
         2O4g==
X-Gm-Message-State: AOJu0YylcliZfDcEaX3iBWBSvZw5q1TbFF0+fHjAHQ7AgE/U5TB8/e9Y
	UolTW29Rt7tU5N6kQ6CcZ8wXX1Gb8NyQ+G9j7i/wvNCZkEuw6a6xANDbePEaEKIt2A==
X-Gm-Gg: ASbGnct7ZQVr4lodywW0J6t/3i2ZB1w23eBi28UCsHRqJFRKIoWW+6xJMoGl6++cjg6
	IEedjBe3mEMlcYFTi6iBWISIjjPSf1p/+zjnj1SVkrbgZpQqATmREehvOU3wcWaBzyUFP6jVOPr
	xhyxlDQ8zu4k4aVMbYNjZ5RZfuoVGqtYUVne7X7qFODiWOuupXs7avd0RiZPazRl0i7Lkf4GZdG
	5KpfN+zCff/x8AQsZ3WwWBZyQzsGgAXueRxmv95g4YcRBvU+sc1C8KiZZ3Dj2Sm/mwTELcHphY+
	HxJRMNy/qnFESjlH683yOGq7+w4gbaLKxZkay4H+MyM8hp5Q/lSGqIDMRcYV8LsFifs3KkWp5M2
	cLPT9TEaGGe7RyLr+HZpJ/p8q7oxq29w7fR78lxVxPA3Dc3D/0zENtK4U6RB/JzNAlBEGvohyGq
	2zqgFNCs+VXRQzuv7P3xzS/w==
X-Google-Smtp-Source: AGHT+IEdltx1Q3f4Um5OVUeI5/5FIMfij3hj5c6VggtsG02XE+ivNwh5P2yHEG2MIlLPxJE7tbWO3A==
X-Received: by 2002:a05:6a21:e098:b0:334:97dd:c5b4 with SMTP id adf61e73a8af0-348ca969008mr7483131637.27.1761951499275;
        Fri, 31 Oct 2025 15:58:19 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.121.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b93b7e1afbesm3206235a12.8.2025.10.31.15.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Oct 2025 15:58:18 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 31 Oct 2025 16:58:16 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
	sr@sladewatkins.com
Subject: Re: [PATCH 6.17 00/35] 6.17.7-rc1 review
Message-ID: <aQU_CBmRIwx4ZMek@fedora64.linuxtx.org>
References: <20251031140043.564670400@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031140043.564670400@linuxfoundation.org>

On Fri, Oct 31, 2025 at 03:01:08PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.7 release.
> There are 35 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 02 Nov 2025 14:00:34 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

