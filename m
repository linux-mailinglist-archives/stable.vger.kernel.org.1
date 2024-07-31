Return-Path: <stable+bounces-64801-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8A6B9436B1
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 21:47:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F0D9B2185E
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 19:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB1A148FF3;
	Wed, 31 Jul 2024 19:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="I0oT3N+i"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF3445BE3
	for <stable@vger.kernel.org>; Wed, 31 Jul 2024 19:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722455231; cv=none; b=ZHMLPkCRLHVd6CDFNEmTheJgoS2jg887gGcE9DklJzYDbAcZ8Cf2ADbHGIr5BjYaUTJz5KW9ManHHYfFL7+6K7DlFe28lT+gR87KLM3FyFqK1l521Eft1vNwSFPsSGxoDRsysO3RD4+nyMsH1JbjvmeSjnLdqV+hgiUxUcOT+g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722455231; c=relaxed/simple;
	bh=68IEEl4T4i3Q+A1hsoS06kb7yEO9aKYPzH5dciEL+IA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z7SHg8zS7lyj/y2lwc+Mu53w/6KB8tOsm3J/lAAcCOHVKjfl+TNEiWa9yv0rPdMN0px64TYTjl7G9I3lcpxtB7RXgbA+qlcsrXvARsg868gBPPUTx66+Qzq5WwKt5W9IDeGYNvLay11uwFmjIs4PPIseQR1nQcFw2Ij2myusVz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=I0oT3N+i; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-81f8f01981aso230714439f.2
        for <stable@vger.kernel.org>; Wed, 31 Jul 2024 12:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1722455227; x=1723060027; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=L9qmnQ6BfkDIeZVz78CLRQGm70nI1Qgca6NQE0QO5TU=;
        b=I0oT3N+iq2jKhfXcyLxLWYU6emSLTcmhzD9A7Q2etAiAakqcHItos3VXIRpUVELytx
         euG3Eku8y5vZACsiTkdqwBaoe8Yhc4Tw7jVPuMYJIhMTLqPeGi6M1IeJ2fvFsfE3xarp
         OFYEmk/Ng37ZrMlAAqjU9QbUk5juiU82NxzuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722455227; x=1723060027;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L9qmnQ6BfkDIeZVz78CLRQGm70nI1Qgca6NQE0QO5TU=;
        b=B715ovKqgPffkTW+x9ZNJtQMlMjmFUWsX1GlFWq2bdVgZWL2JLTKKe25nl2NZ9OcTg
         1GizkZVhQnPMGE8xtJ53J+MauGSH9v3E+XuZRpyTKo/w6JNVV6LZ5t2hMpitENAq0p48
         zcMeIE48q8R/wbg79tgZqiwPwtc7U21zRP4NMnyqlT0rJSSfUWJ9J7OTXf3e+vENGroQ
         lzeQ560KXsRO1pG+Pf6r8Veq+OgD+zCG0DXrPgzMp1jLYQmJ8Pt3UMmjyocp4aiY6U9n
         DdCbfuTdsjd8jtx98AwtclM7F+W7vatLAtM19cNpofpKircsr1B7NFo6vcsrhtDiPhPy
         Zn2A==
X-Gm-Message-State: AOJu0YzOcsXAUX/EF97dP6FdNeM3v5sJ7y9t7SH7VaiXa2MoJJAm9Yvx
	M/qsi+c6GJmAs9sx2ZUfkbbpdaGdjU5KQZ+NFu1L5mD7D0bzqrQlib9T50CzENpamt7n3LT07bU
	kRQ==
X-Google-Smtp-Source: AGHT+IG408dxXKgXzbPbvVUq8CBwbTdlcfEckKAmt5cAomdh6fvurEijpX0Uy9o21Yku/co4S8HQqw==
X-Received: by 2002:a05:6602:6406:b0:803:cc64:e0bf with SMTP id ca18e2360f4ac-81fcc0e8c62mr40513839f.2.1722455227582;
        Wed, 31 Jul 2024 12:47:07 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.171])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c29faa83a0sm3348439173.55.2024.07.31.12.47.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 12:47:07 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 31 Jul 2024 13:47:05 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
Message-ID: <ZqqUuZqqq7O3nLbs@fedora64.linuxtx.org>
References: <20240731095022.970699670@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731095022.970699670@linuxfoundation.org>

On Wed, Jul 31, 2024 at 12:03:16PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.3 release.
> There are 809 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 02 Aug 2024 09:47:47 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.3-rc3.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc3 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

