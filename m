Return-Path: <stable+bounces-39205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF448A1A34
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 18:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 06711B296B6
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 16:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1652C12C486;
	Thu, 11 Apr 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="LH8sSnq3"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498D11C4C59
	for <stable@vger.kernel.org>; Thu, 11 Apr 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849900; cv=none; b=idXg5ldNM2zNObqXadjtHXHEkJxT+SotMPc8JFa1gq1mTsEir+LB7bxfQYDbMFLi/l24pSPIL+iahJ+HcHfKh+mAL+OwEamsc8OYhdqv/1lsU6CW4DotdjmmrLn2D4nvvmkNyb5BnIKdue3qE5l6FP+gMkP6+3je7h962HyEnN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849900; c=relaxed/simple;
	bh=c7ZbKM02ozoInY9TLL5WaNcYw6jZxIxWCpv/8aHKlWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dxODw2f88CYPksoNvf2P14IyWA3E7UkAmuxmC71DEi+K3tx9/YPB2hbgs2KqDpHN3I0cztmDOw2TjlVZ396OkhcKiUoHGFKUsN2ppU8ycWos7kscuSL7/yak5HSyvjbgHbIGO7MmlGyZPe5lVww4Iro6shQdBpnt83cx9s2Aaao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=LH8sSnq3; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6eb5310e9fbso293282a34.2
        for <stable@vger.kernel.org>; Thu, 11 Apr 2024 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1712849898; x=1713454698; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SQF8pW0Q5UZae20gtyOFCGbbxCzCiJFtoc6YhdkZSao=;
        b=LH8sSnq32JmoM8M0NdsnRbS6+jV8xpne0zaOegeuaxOPfUQAGVRXMPPapf/r8wTkJz
         5Rx0ZIODxRVh74zRTkQ++x8S/Nvpxz7wxRepLtOyl8I0gLB8nz43HsXB+YzCNOGO1rZr
         emS0O0IV/2v6OsVIw97rQkSyrk6HZ8pp4SaK8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849898; x=1713454698;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SQF8pW0Q5UZae20gtyOFCGbbxCzCiJFtoc6YhdkZSao=;
        b=UuaZgPKXWGmPdxpFMB2vEAM2dhLKVmKV/33BTcrT+BvNUYmz5fOTuPIK0bDbbIw7nz
         wmHagI8vZ7ShMVm20rMDQXyc4yIRcbOVBueIkryVJASyzRKusxSV8kS9CBsvjdgcx0DU
         3zgAwVy6rYXKcklOlXdGIIf2kUrWkOotZ7I3GZjgRDxaS35G6FQDOSRIYhvIazzz56zj
         pyHWLDzcfq0IUZj9ILtCeIaks7opqGqooynuPQlPH16T8hKA5XxqEZ+s/uSfMav1x5XY
         Ezm5WMFOjjFRlnolEAKppOfg3AE/xt0fmy/hXCQkhsBSYiI2cfzM7jQz5C5jQ9G8yPqJ
         W7AA==
X-Gm-Message-State: AOJu0YzCR0npCT0v+ojQaEU5hdY/eCij6QJ7VAaDYF/ZURzLaoEolNBg
	h+uEje2SbXuRiRbRWIagoBGXuFCoThNG3cm5mDj3RdSc7C2jVv/dFMxwrYcTlnAcssT3xSZvWEP
	ybw==
X-Google-Smtp-Source: AGHT+IHuutycOm+XsRHDl0LWcOxTy9NbRP7BpNLELnhVE5UZheCq3gAcUJShOSLCoSLKJdlEGR/O1A==
X-Received: by 2002:a05:6830:4d:b0:6ea:1189:de3c with SMTP id d13-20020a056830004d00b006ea1189de3cmr5851360otp.34.1712849898444;
        Thu, 11 Apr 2024 08:38:18 -0700 (PDT)
Received: from fedora64.linuxtx.org ([99.47.93.78])
        by smtp.gmail.com with ESMTPSA id q14-20020a05683033ce00b006eb507d4257sm238520ott.33.2024.04.11.08.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:38:18 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 11 Apr 2024 10:38:16 -0500
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.8 000/143] 6.8.6-rc1 review
Message-ID: <ZhgD6FVwprj26KBU@fedora64.linuxtx.org>
References: <20240411095420.903937140@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240411095420.903937140@linuxfoundation.org>

On Thu, Apr 11, 2024 at 11:54:28AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.8.6 release.
> There are 143 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 13 Apr 2024 09:53:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.8.6-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.8.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

