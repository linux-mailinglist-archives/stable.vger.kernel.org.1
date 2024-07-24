Return-Path: <stable+bounces-61307-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFED793B536
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 18:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 728E21F2234A
	for <lists+stable@lfdr.de>; Wed, 24 Jul 2024 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2507915ECDA;
	Wed, 24 Jul 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="aVvCsBJ1"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3143B15D5C5
	for <stable@vger.kernel.org>; Wed, 24 Jul 2024 16:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721839386; cv=none; b=XCZ6dmPfpnq7Q5PCgwNVArc93E5MyH3iwih5hbhYfQI6fbaGUZbEzHz9G4eChpYTfEB7Rjf5tZ9VwkRG+BNadis+LDx5WzsLbsxj7yAI/BGWqmuPCkCzy0+cO1Op/Nci4G7nHnYWxoDRvd/1sln9Wh2yYOdiWPuKfACsQmncmlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721839386; c=relaxed/simple;
	bh=XnBSi4lJYwqPS7JvayepIZdhilljl7iydbSuuQDgHeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEbK00Qo26ExZQIth0ai5qpdpOz9LB1rWV+NHP9kmuQprs9IGW8OjkgXhM/b0fE9EexwNeclj+mN+ZFmbycOoL6u6BzJqha9j0lSvexVb5CHiem19f1JA0OI8ocjXcksKqOV9TlTdPLlVX9ic+zO7bC0mESaQbyXK93JIAFXhrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=aVvCsBJ1; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-7fb93b2e2a3so159939f.1
        for <stable@vger.kernel.org>; Wed, 24 Jul 2024 09:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1721839383; x=1722444183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sEJs/m1LfDi05lj71qThBLJVfg82KFHAF0JSUzDWDf0=;
        b=aVvCsBJ1nn4Je1cCQAi3Q2bYum94d7ga0tFJF7/xUH6l5cbmgeM5oUNki5nO2FdBqs
         FowoKQEuNX9P9c/1IOUoHRdJPwmDBm15VHUDry8E0t/qDZTBrRcohToNd6Zpfp4Kb/Tu
         ya8CXIcMbjEu9dbY7WxSA5GHXxj+ltjc0+XrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721839383; x=1722444183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sEJs/m1LfDi05lj71qThBLJVfg82KFHAF0JSUzDWDf0=;
        b=NE91d3sgt9UBqv8fixIw/PTiBKPpZvTrdo1hvdN0lE4qJ9TmeSwyPqJ1ZoU2n7EAsz
         rqxornJyJmYLsjoPmD6Q9VVuGzM1bPrj8YtyyXfS/z+r5TlaGAo7rJt3QchuyzXMrPSj
         xTFMNj93Jp/l/zqRGk3dV6JxdwPltE1/dc0zyMxWG3E7P1GNnWUI1NYk0v1+fXHnQVIP
         S1pkvdB+Xdp5E5O7VtSCbRkUE9Nicyj2airFkd0VoAmsBNa4mDao0kx8g2WNfKw0PqeD
         78oLYQ20rHqUklgQ1zA+OtRd/VhPxQYpC3eTn/vVgWgYr1HNVJllJ4fEsQwsDp71XTpN
         2iJA==
X-Gm-Message-State: AOJu0Yxx9z3txLIk5rkeQFktdIAgrTIO6ZeC1FIisYvW4MltlJ9clo1I
	eXLpf/OkNddQwm5lazQi6STzLAKq5KHgsrL7hRWp1xR3BdHH/jQE/bc9gQdQqx74goITNmem6CO
	4GA==
X-Google-Smtp-Source: AGHT+IEOh68yrb3+/ES/BDsvfk4lSOZpn9NTCMqLMBdmSacZPA1m1SxGq6eHvO1XgEDls8X7NMrdrA==
X-Received: by 2002:a05:6602:6417:b0:816:ec51:f415 with SMTP id ca18e2360f4ac-81f7ba78fb7mr63172139f.0.1721839383230;
        Wed, 24 Jul 2024 09:43:03 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.171])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-81f7158d719sm56744939f.8.2024.07.24.09.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jul 2024 09:43:02 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 24 Jul 2024 10:43:00 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/163] 6.9.11-rc1 review
Message-ID: <ZqEvFNTOyOEgyAl4@fedora64.linuxtx.org>
References: <20240723180143.461739294@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723180143.461739294@linuxfoundation.org>

On Tue, Jul 23, 2024 at 08:22:09PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.11 release.
> There are 163 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jul 2024 18:01:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

