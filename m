Return-Path: <stable+bounces-15605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC83A839DA2
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 01:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321D128A8D5
	for <lists+stable@lfdr.de>; Wed, 24 Jan 2024 00:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD31EA9;
	Wed, 24 Jan 2024 00:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="eIRRRyb7"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF528628
	for <stable@vger.kernel.org>; Wed, 24 Jan 2024 00:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706055760; cv=none; b=X6nDXG8Kh317kAnPtlEa9L+/Inzm1gXd4Fr1BvrHS0JfkGkDdJr8q6h+lw3ij57AQ++GnzhUgknww0uq+4ae7btWRNQCbYB3c3rHjhunfD2wbR48qYtNLUwTIZkhd1piLSQFbaFrl3z6I6XJTTcc/yaQyqQsw5MJqlTSR+EmfMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706055760; c=relaxed/simple;
	bh=DJlfZwy5oG+ddPT+BAfbUa5jvLqlfyghhFKps3SyvX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rkuVNi2zSP16TWPgvOt//tCZypWLPTGj3pH6l71PEXCaYKDEmHiv5YhrFljGH+Y9+UBENNxFsDv9U53xvS69xPn/8akXsx2KXAbsDMDxbCxZdCSJtwth+FM5mLmJkCdQxEJ09ERJGnhVMe1zVDg+wgxiSUxFkxHt7VO4AVOCUfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=eIRRRyb7; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-210a73a5932so3290016fac.3
        for <stable@vger.kernel.org>; Tue, 23 Jan 2024 16:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1706055758; x=1706660558; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AsC4IZkrsCzp48Uq4gQMFalS4lpCTPnckc984N/Nfdk=;
        b=eIRRRyb7IlnJ2+zNC/NwK+jXb3xB1yCc7ObBIXJrIU8XB2WpOqCgv4GjPSfoCKe932
         XYu8J0nrqYPpqha6fLq40LOwsO6Ib0cRaMaQZwIQRH6xo8IK6cG5QFo5yqdW1lmC+rvx
         Gd2CAQDJ8/rkFcpeDc0v1rRcSX7/t4CFEqtew=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706055758; x=1706660558;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AsC4IZkrsCzp48Uq4gQMFalS4lpCTPnckc984N/Nfdk=;
        b=Ra/roZz2irAzfHEJd4Y+kdGga6hk+Sci1wbNaj758E/kXQGFHW/T/EqLdrc4vQ+R+5
         uD2SSKX032IWBUEkuMStAgu5w9PfEhQIF1Iiie+uGG0ghHVT5sGtdJqidndU9JQMeTH6
         xd4mZTENzH7VtidMQyGQHd0VyNwdaSfvFpBu0zEZNCsU4tBFao35HYdL1QgHaGOVQ4bE
         +lWg447BHb2VB885eOLjElgCqoK3l/vhHawNSzZNLf0wTXC1Wt9KEnAaiFppuOXm3AzE
         glyEZwAq52D7CXd9Vhx3mQYylNPCxeRPCwIMRMP+elxl7fJAAFeNGcq7AjVByVQw47F3
         LG7g==
X-Gm-Message-State: AOJu0YxzNs+cOqVmGPyeNqdMUT2J0y4GHvkVZ09ccmI/KKkCl+Pw1wdb
	TqxYTUPjtWGL9UGCQS90XNPUBSLUV5U4hToKX9UshbsqBDj/m22Av2gED7wnCw==
X-Google-Smtp-Source: AGHT+IF5j2CrNJpmt4xbjt5uNDLoyO8MNIxaA3XcNYGjI8dCmk2XJBy094kJqAM2+8lwjkq4d0k3bQ==
X-Received: by 2002:a05:6870:9693:b0:210:8c13:dbff with SMTP id o19-20020a056870969300b002108c13dbffmr2722563oaq.84.1706055757837;
        Tue, 23 Jan 2024 16:22:37 -0800 (PST)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id cp8-20020a056808358800b003bbe0c5195csm2404902oib.26.2024.01.23.16.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 16:22:37 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 23 Jan 2024 18:22:35 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 6.7 000/638] 6.7.2-rc2 review
Message-ID: <ZbBYS-i0uR08aEcL@fedora64.linuxtx.org>
References: <20240123174544.648088948@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123174544.648088948@linuxfoundation.org>

On Tue, Jan 23, 2024 at 09:47:30AM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.7.2 release.
> There are 638 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 25 Jan 2024 17:44:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.2-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

