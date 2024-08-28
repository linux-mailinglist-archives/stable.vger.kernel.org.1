Return-Path: <stable+bounces-71435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B20F7962F4C
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 20:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32C64B227AD
	for <lists+stable@lfdr.de>; Wed, 28 Aug 2024 18:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400641A7ADE;
	Wed, 28 Aug 2024 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="g9iA02w+"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FCB1A7AD8
	for <stable@vger.kernel.org>; Wed, 28 Aug 2024 18:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724868288; cv=none; b=cHEMJ6LpnHopTUDeh16DbBUbzW49uckeHUBWNQU3Ap/RerFNGVmDHksOSXQk/8chBX2OAjYC0fm9yOTC3AFUoZXJQ25y5h0vxJkIixUy5c/EiqwKoKgob/KpBRRcmiNALxalIJGRlQIzL45MxpnLgJsErkAfWI1qGIZA32PaxAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724868288; c=relaxed/simple;
	bh=7LklAEbtnglm2QqbJRXoOdk5le0yekVD8FpktvgUQ0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tP+ntgfaXVfKckEEuDN2n05ZrjEPE8lrfLlGtRG8BWH2c+Qt7TXS2fg3zLBgvrGBWtMsHPgUDFXC4aN4M81jo9fSGFQiB+K1NkhLOIuKAwtzPZg7iYif0PItTkTFqIq7wRi5kC4KSUSKQOikoSd8781ZD9d2HVV1BbEUOw4a4MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=g9iA02w+; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81fd925287eso258801939f.3
        for <stable@vger.kernel.org>; Wed, 28 Aug 2024 11:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1724868285; x=1725473085; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D88RxHw+gLXI+BUbdOUTeiFUlCwvolVuRzDJ5llIRd8=;
        b=g9iA02w+gnkq/9Gcd8YoLDYbuK8UasKWfDeh8xwi/77mBkO0jPCwrXyOAjUMWa9uek
         P6dYKRUJem/9WmdDH1MQoH0He7jWpCmKEPXQGq78kN+aRydcNjxY86bl/Id4QxO4urCr
         6DwpIEIsUBCEMc0og1bYjjjEKDQtGTRwsa6kk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724868285; x=1725473085;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D88RxHw+gLXI+BUbdOUTeiFUlCwvolVuRzDJ5llIRd8=;
        b=OuCGKZAx7kOQ3VsCEFdhcGCjRLQrBfJOZCdGHccJsU3txbz6wPbboJs7tu1h8qPScU
         zG2p/xFhRZC4wbs4DAGs4Oah57I0ttmbd5MLE1bNqv5VlfVrSZSbL+FWsAPsIFvFHgLe
         HW6pjQN6HsDUPWj/0AInKdToRa6fw+k00P401jS+aZpEI8cW7/yR/pXDPiejg54XnwHT
         lTFBUAF2UI6P2spn0BtphRZ4l1/1mgd9C0rJpAD1ytXt6mRJ7BdmEa4ptLDqL3DwEftR
         +GX+3fP9Q3W2U4gKCznYZ6BRZaEsNLUGlqyNLKnbAeQtkvM4nb7E4Lf1VJVz7ewt0370
         gmdg==
X-Gm-Message-State: AOJu0Yy0F+d1925Te3LICAYHrvPCQOXshord3dr0TCjzGnGebAUwPfcm
	Leoy6EppruIKsoVOCLN6RN71MgUEye9DAP+ft2LMCJa8hoc1lYrUNzqewzNpBQ==
X-Google-Smtp-Source: AGHT+IFD5bWw8dwybfSsYbERZ4OkMGlI4FfFSwejbt9P+LhXubeZLqrOlKHFBCJir/bc35aQBU9JSA==
X-Received: by 2002:a05:6602:1487:b0:809:83e3:a35c with SMTP id ca18e2360f4ac-82a11036779mr46952939f.7.1724868284479;
        Wed, 28 Aug 2024 11:04:44 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f1fa89sm3123229173.16.2024.08.28.11.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 11:04:44 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 28 Aug 2024 12:04:42 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 000/273] 6.10.7-rc1 review
Message-ID: <Zs9mus6WLnij725m@fedora64.linuxtx.org>
References: <20240827143833.371588371@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>

On Tue, Aug 27, 2024 at 04:35:24PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.7 release.
> There are 273 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 29 Aug 2024 14:37:36 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

