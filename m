Return-Path: <stable+bounces-111824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE0DA23F43
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 15:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28A6616903B
	for <lists+stable@lfdr.de>; Fri, 31 Jan 2025 14:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD761DE88E;
	Fri, 31 Jan 2025 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Bpwtm482"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB74219FC
	for <stable@vger.kernel.org>; Fri, 31 Jan 2025 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738334854; cv=none; b=ka9XN+PBIi8ySgBlM++mo+ehJtjlOnGIUs6372Kl6Ze9/X3UIUGlOpvZ3kIMvYrkHFeUvc4sQtXG0H4MXH6r85aZYlvynBGLDCiAdKAvjDXuuitUEui3R8KrjWg9QWVyUlkgfyS4oasA+NDOv2ov5fPeyP8opS3pCVngdmfUWf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738334854; c=relaxed/simple;
	bh=3OkWV1e6WZQ/dF5Yn5YAx99NLIo/IUO/RUBaemGuqFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hVyt69C6sJGbd4QLdajrsdxdlILU2ngcMPR1LstTf7/kSx/C1GbK6tf97ltIpentV3UfUsfgGpjUfeBkdLmgvpz0M28qX6h2zN9rpU8lMh6n/P7Glq5kCk8S5VMQ6j9aci08Jq0+4pNMZ1muWrnt0/bY8Mqo4Cbxhvfc05T2Ct0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Bpwtm482; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844e61f3902so142480939f.0
        for <stable@vger.kernel.org>; Fri, 31 Jan 2025 06:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1738334850; x=1738939650; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J0i8jARHM9o2vH9POVudqrpVADfjg+0Wl6rXBt3YUB4=;
        b=Bpwtm482IQoMIrZQpnRwieu+SnUVL9t5aQjahUcr1cXz+dDUGtr8CwvZAlQ7O4wixC
         rB53EVCnz/QSrT3Do3I3qXXKKFLmAv3583lN9EC6c+kA5JGM3Ksbj+tuireEVaue9/yk
         uPx2UI5CpRv1lK0GWysV3N61UE/wly+9X/stI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738334850; x=1738939650;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J0i8jARHM9o2vH9POVudqrpVADfjg+0Wl6rXBt3YUB4=;
        b=J1N/yv+XNCL/yOAFZyTWH1FrUcAx4Dd011da7VYvRJ67513Ihe9uuluy7lAW6jTQGU
         8W3rnjZACAm8z2gd0In2+83YnEbHaxSGtZ9+hlvX9hPdPepYwDhwOCZVKPAjTsWYEEp3
         3FYRrsztlR0AfPgWwLdtzAKbTcDuUwWHbqF2BFwPnLH9IlNWRKWxoXrJdbMUNrdma3L1
         Qa45oMay8qjiMPaODUN9mziFIDLcnNVKF2J45T9gx86X8U2zdgZZExKU57nmEqeNnAV1
         ciYG63NULfV2DrSPUF5XAx+3lmYe4jFtDaoDQFzLQSdNKtUSwxWoMT+L1wZrizoMZulS
         Ir/w==
X-Gm-Message-State: AOJu0YzpHevfWcoqUVKjTg55OLZ4Rpd4GNDPcuCPdlERO5lbCBXUL714
	ELY69UQ1DQN85yrKHKCkDWFE40hMKe5paed6MpLdX6qf2Ehhki/skNduTWwCPQ==
X-Gm-Gg: ASbGncvX/5cUQEPBHcJpg2DalUGQzGhsfSb5gqaNNeFqvJlUF9GZuTkIvKUKgGdLzSS
	IjcOnOzU2dA1b335v0YRyckcur6InTv9O8Blkq1OOFdGmEx9O7i+uSgTBN2x8+vvpbMZg2KNoZp
	54Rrj01fCj9kGUdaT9IVH5iDG9q2WVjqfYtj0Y2XBIAqAL7vHUj6EAj/t/kGxfVqoYje58VTSYr
	tJizS00/puPxalugP4ZBjLqgkWkSppcwlKjsb2Mb97bAcPPjcWycmuggFWXzbWa5aFDB1GeMaH0
	+rS0+uEeLzn11H6cByp496U/M71FqOpY
X-Google-Smtp-Source: AGHT+IH6BGQGzWRpGFP2/mx32I7TRFgh3qostrn98Keogfw3HieRqTGh4nJPUiH2IEzE1d6C0ug7kQ==
X-Received: by 2002:a05:6602:36cc:b0:83e:418c:8a28 with SMTP id ca18e2360f4ac-85427d799cfmr1096773139f.7.1738334850633;
        Fri, 31 Jan 2025 06:47:30 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec7458ee70sm841402173.18.2025.01.31.06.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2025 06:47:30 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 31 Jan 2025 07:47:28 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.12 00/41] 6.12.12-rc2 review
Message-ID: <Z5zigMpU7NyKYGyh@fedora64.linuxtx.org>
References: <20250130144136.126780286@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130144136.126780286@linuxfoundation.org>

On Thu, Jan 30, 2025 at 03:41:57PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.12 release.
> There are 41 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 01 Feb 2025 14:41:19 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.12-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

