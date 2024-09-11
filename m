Return-Path: <stable+bounces-75904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBB6975ADB
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 21:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3501D283CC6
	for <lists+stable@lfdr.de>; Wed, 11 Sep 2024 19:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365B31BA276;
	Wed, 11 Sep 2024 19:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="KDJgk4Ny"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D21B5808
	for <stable@vger.kernel.org>; Wed, 11 Sep 2024 19:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726083124; cv=none; b=H0kOYuiMpOWdIO55SSUcBMn7INlHxQ7bmcnvGe2KNNq4maCRA2iKtZNf5CoNHMEL2EP0YPKV5Whk0QVOFvrqANw6Xn/AmTAD+oXzl0kLXqhu9v3d2IBco/QIVWSUHIPJuNxOHr+UYW50QQbyIlPpNQ2kKmZkr0oqFrclmN2mgvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726083124; c=relaxed/simple;
	bh=07yVX+a5HKymQT/kEVbwRWOHz7xK4lZuHdWBrjAUKc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nq27w9ju53ymVSv2An9V1cwfkDDnuiVkwENX0HuTDsAz05gDvJeVFebiDMTTzfR/B8785iVHZH4Qw0p2vQeJlDOgX9bT3NA2KSQ1eX7biN3En0e7IPnt11nbJ/zlgSkt8YrYe7LSq0VPmmlWtWdQiZkxTKqQgKlJynFNpGGxcnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=KDJgk4Ny; arc=none smtp.client-ip=209.85.166.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f48.google.com with SMTP id ca18e2360f4ac-82a238e0a9cso7749039f.3
        for <stable@vger.kernel.org>; Wed, 11 Sep 2024 12:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1726083121; x=1726687921; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gtmb2W0kiaRq3w+FhsyuW0F/eW+GNWteDIgqlZPPh+o=;
        b=KDJgk4NymABHJOwXLAXqZzFOgL03V3mwrRZ3+KfC8lU7+MNXGzvsJD0IVfvkEVf5/o
         5PehWh+xnakWAk0cftdNY5DPDgXM7x64mSKaucHKDwY+Yc/kcwzMkbCZ+1Lo2L9OEdiq
         FQqWYM69BaK/Byi0FcAwzrrv1R/k6EUCYekWA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726083121; x=1726687921;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gtmb2W0kiaRq3w+FhsyuW0F/eW+GNWteDIgqlZPPh+o=;
        b=CWcIvU4eejqgQdY5Kr8f9fzzhWNbtVPpgm24NEdeaeKqh3l2joZS91w+neXLWXi5fL
         v1Wx7HvPXmn6S1Z/CudHoJFoYTBFfW8Q48M62omu9Krr9BphP5KQuOQDTFkDUK9lt2hf
         9QYX+U74RclQYl47XSDTpVgxnUMN93T3UfiES150pQ4l2Pr1csRPDCR2YJW8LzvqCqFs
         iOxHeS51MrVudFtWUGzN5dNO+LGqVcnVxQl87+8cZ1oJVkB25okxvLot3BfNpnkntPEF
         74sYHO55pH3TZ4wofGsY8tpOZXrCouGnhO//R139EXad7pucRtOvekHVG0u4YhUgSKrk
         oxUQ==
X-Gm-Message-State: AOJu0YwMja5JkfuU8TPgW+5dnZlCgjFtgBY321Y63fkL5vDDnbhzR76k
	7DtdVCaajcCaLjvxHVzkUvaBMGLCwWxwjFOTwL5k7DKDJosfK08YpjsLHFE5EQ==
X-Google-Smtp-Source: AGHT+IH61wJeAaDsZVI0UulLG1dxqR8dVtT/hu5F4TWg8gxDaOsHx00AEczVpQO1l7iNb6Sv8R042Q==
X-Received: by 2002:a05:6602:6c14:b0:82a:34da:72f7 with SMTP id ca18e2360f4ac-82d1fa93764mr101635039f.16.1726083120696;
        Wed, 11 Sep 2024 12:32:00 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4d35f433dc4sm159871173.25.2024.09.11.12.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 12:32:00 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 11 Sep 2024 13:31:58 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 000/375] 6.10.10-rc1 review
Message-ID: <ZuHwLtRJkij6oz15@fedora64.linuxtx.org>
References: <20240910092622.245959861@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240910092622.245959861@linuxfoundation.org>

On Tue, Sep 10, 2024 at 11:26:37AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.10 release.
> There are 375 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 12 Sep 2024 09:25:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.10-rc1.gz
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

