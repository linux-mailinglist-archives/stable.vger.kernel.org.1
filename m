Return-Path: <stable+bounces-113995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDAE6A29C35
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 22:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 139A51884ABA
	for <lists+stable@lfdr.de>; Wed,  5 Feb 2025 21:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B40215F48;
	Wed,  5 Feb 2025 21:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="Me7r6H5x"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666221FFC4B
	for <stable@vger.kernel.org>; Wed,  5 Feb 2025 21:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738792620; cv=none; b=jtizywLQt2nkPmZcXTWur3xN+OgTZT8VIO8m3r3VczKUdikhWmYJsblu2KktTXPysNWbGgLYt3zFB5qBh8BQxTxL+/uwhzsjNkcSG70EtnzguI0oJaTIKb7jn/BW1SReOEeAzzroPOdL5CwRdg+CBItd378osh4/KfPsXqPVwjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738792620; c=relaxed/simple;
	bh=+ozLHxhArw7MVnLnODmfn31z73WbsqHrsJgwqe4g1D8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MJD/2vH5MczSkO/9EsD20YpbcpvtXehJ6O4k34AZtxTs9GGodgvN2MI0lRoO+tKgdMzS8ykKNuRUUxbVediPGyL/V/Zc+eyawqeXkXzmOyuAVgRPtRxP5rJGHwe/9ZV8pT52CrEdtWImDwgDW4exJ6hPR+jDYWT8GeLm+rHfgIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=Me7r6H5x; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-844df397754so9329439f.2
        for <stable@vger.kernel.org>; Wed, 05 Feb 2025 13:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1738792618; x=1739397418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+RqOTSnSPXG1MBUyv0qD+rReSmeSDZ6Q4z10LKFiFE=;
        b=Me7r6H5xKo6A9lk2prsnDneiin0O04ZKQoU5d1kmhwNVvsCXZ2vCihdrMLtoJJd3A8
         xwzrYRgxdeWnnwVN78gnD8CTy5+tZCjdHzKCJsQlS7BjQt8KUlDHMXOcCeAHA6+kB2W0
         V2P9j+z5zeSqAGuECxCFEXpbedT8aGyBr4K38=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738792618; x=1739397418;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p+RqOTSnSPXG1MBUyv0qD+rReSmeSDZ6Q4z10LKFiFE=;
        b=crQhhIj26Q/uL09VohWQN2EpKMvtz9pRB9xMu/zrqfiPdvtK4TzhS8evKrmu8I6C/F
         avWeoWyQmChohT8gIVVORoXa2mUDmocGXYUZNMqB0sDBfWpxA3q5yWxkO86VMF0/GDd1
         bWCqA+MV8VEffXUQCYJ2OJB1+Hrd4Uy56fz3hP9i6IV84toC8GnTC/ngRu7ENukjbmA8
         mTRoLS/1XGwB2glt+UEkLZYuhSC/UmNJ57JvvBUnjAFT9iPNkn6QoFAKTX9/qv9mJGyE
         l0z1ho0ZoMIWrZRrOG8klZ5JRqRNwPKI89/14G8gzKgRGvqT5RDpmvmPz7XC9lBznUkr
         UkSQ==
X-Gm-Message-State: AOJu0Yy/yV7n4bf4ldkUP3N0zNJ2DbHmnq9bebxD1DhULRtEONvo2ydq
	hFbpB7sAiFEZt+p0mAhfFqwyzOSh2pkTn7LBWuc3XlJ0yM7sPg7ZQdI73seEnA==
X-Gm-Gg: ASbGncuR3DcdDae7fKVgB0qdGfh6O9LF2ZvvcLzgBLKHcsi/+GQ61OTHCpu+u8b2Ztq
	1K73q7ht6EC8RE4anQyYtsrGQJA7aOENuEg0FSolz4mhiqRPSckERFkwyZpAFymSe4o1BGqAguN
	gSnSwPMyiui49ScyaGHl0/uZNaG0DqSF0/OYWkqH1/Ri7F+Gxo+VXPFdPnO8gAh7Y695mfGJ2Ks
	2Y282T+Gmg5VFoIaJVaXYWs5+uPRD4Akgeqp+/UEqJ4ZBVCVCCIsm+JfpdVd4058yw5KlSG3bre
	dkCTYiD97L3IigFz4ZVgsZ0Ev8v1kHPR
X-Google-Smtp-Source: AGHT+IEWlXmXQnDihwBVnSYlw2n6wPB+KmNglO3Os1wffGg3OKOkA12y/hS3Nmj7qmF2gTqtJ9Wcjw==
X-Received: by 2002:a05:6602:388f:b0:84f:54df:dde4 with SMTP id ca18e2360f4ac-854ea43465dmr545587639f.6.1738792618515;
        Wed, 05 Feb 2025 13:56:58 -0800 (PST)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ec7458ecf8sm3421542173.6.2025.02.05.13.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 13:56:57 -0800 (PST)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 5 Feb 2025 14:56:55 -0700
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/623] 6.13.2-rc1 review
Message-ID: <Z6Pep0H4X7Nty9tu@fedora64.linuxtx.org>
References: <20250205134456.221272033@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250205134456.221272033@linuxfoundation.org>

On Wed, Feb 05, 2025 at 02:35:42PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.2 release.
> There are 623 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 07 Feb 2025 13:42:57 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.2-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

