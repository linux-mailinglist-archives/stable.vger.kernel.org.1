Return-Path: <stable+bounces-35606-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12603895575
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 15:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA6A628376F
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 13:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790F285C5E;
	Tue,  2 Apr 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="LqgcBNSk"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E5285298
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 13:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712064759; cv=none; b=qzSDuh2/AwQZ1ZtTOyV0ZlzGF+eerr45kuH60C7Y/RyaIll3A1DwYYgbpYPj2eHj/zi6xhZ0jH6YJJO6b9sRokPcOHvO1HKN8fs41uQmMVr5Y5FokqSc1Z/9wLxrRTknCjyRnrgo/N3f6VdvetiQR1EWZKY7FWFelPDKx8/quaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712064759; c=relaxed/simple;
	bh=bYMjyk4hxADDHJfM0n08rS8SVAMEDwCn1gh7K6kIzjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LEPrX4B8eSmiDXq2hEgDX+xW89XqNy3mrBF/6E1lHpvfASB4Cjg//J0/Xe/yb8DejLibUX0M306ONXKBNTA+qfGH0iHFjlzr/cko9h/lPz3/udLxt3SHnmFeJTFH7Y1QeIiq6E+o/kdmOEFcCJr+A61S8PfWvLu8YKTNqrII37g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=LqgcBNSk; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3c38396c965so3638466b6e.1
        for <stable@vger.kernel.org>; Tue, 02 Apr 2024 06:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1712064756; x=1712669556; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rFk53LgoUmRncPhQOHRWVLYTVzn8/nw+iy7GK4q/aeM=;
        b=LqgcBNSk2KlI84Jp5FEm4vKHcRnskk0zBMemeVtZ3PnMLpLva0+1OLKvix/f0ARmcd
         c8w5b9Zu9p5wegRL5zFKKsh7pB+qrgTlbEUkh+1MMtqltJZlN0CbnjVdy0WhxVqdPf4Z
         MA+0vDsbZcNZ6tWhwHrHLmgproUddPFT8QR+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712064756; x=1712669556;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFk53LgoUmRncPhQOHRWVLYTVzn8/nw+iy7GK4q/aeM=;
        b=vtRB7JoBDKudG32XGLfFnFI170a/3vgw1WO523yG4iEfXcaihpY5XsryccXW6dqFks
         g3efno/TT89OPqoR01f92wDsLSkK5uWbquEnlD2R5uvWBcW1NQ/ol7HUrw/G+Er0WI0X
         lxCY8AzxKd4shjWIyxxyK3Mtdal7HVSDPWx9ME9SsW5YXICthlASvqzPcco3KA1iA438
         49qtM+MBYIWrRFWwNabasLcqd3JQmIY+ILeLNXsKAHNJym1eiBY7VonodS3LCXnIyG9q
         jLzDUzLutm7lwlwCTWznRXZFmXYWIgRghXtv54LCfunlU2I7nGCUO2EaHdokoAVCl5cu
         cu+g==
X-Gm-Message-State: AOJu0YxQJnn2hJttQpItMqj7IzX0ugSikLvDplbDtwqgYD15GdqcjXDQ
	yZbrm3/ZEW0D0ZUvcmmvdv/oTLx5baE3pXd6gebuUW435xPJ/xEjOE4lah09lg==
X-Google-Smtp-Source: AGHT+IGwAyzVLBJg6cCeBEnPPvIFGhOsxaFmkiLKmxkHHNwNG6Xh7kFK8xRSsAXbk5e0fkCkA1YUzw==
X-Received: by 2002:a54:4788:0:b0:3c3:d203:2081 with SMTP id o8-20020a544788000000b003c3d2032081mr2609629oic.8.1712064755686;
        Tue, 02 Apr 2024 06:32:35 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id eu8-20020a056808288800b003c4f4873bf7sm224576oib.29.2024.04.02.06.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 06:32:35 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 2 Apr 2024 08:32:33 -0500
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.7 000/432] 6.7.12-rc1 review
Message-ID: <ZgwI8ZzV7OgNezw6@fedora64.linuxtx.org>
References: <20240401152553.125349965@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>

On Mon, Apr 01, 2024 at 05:39:47PM +0200, Greg Kroah-Hartman wrote:
> Note, this will be the LAST 6.7.y kernel release.  After this one it
> will be end-of-life.  Please move to 6.8.y now.
> 
> ------------------------------------------
> 
> This is the start of the stable review cycle for the 6.7.12 release.
> There are 432 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.7.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

