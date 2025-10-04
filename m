Return-Path: <stable+bounces-183355-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BDDBB8876
	for <lists+stable@lfdr.de>; Sat, 04 Oct 2025 04:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 366563AB253
	for <lists+stable@lfdr.de>; Sat,  4 Oct 2025 02:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D2E91FECD4;
	Sat,  4 Oct 2025 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="EJwug4n7"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B7F1C2334
	for <stable@vger.kernel.org>; Sat,  4 Oct 2025 02:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759545626; cv=none; b=fZx5nlaNOifHXsHKy8osmUvSwe2NLs8/aFbsEXoBP4W4uUTesKOmUQeuQ1Sr985tHNFs9Cv9u8mnW2vHTCMt/xk83GtlSw4/bgtTSV1WtCFeohwUSxqkWUG+hqMtJwXwRXEQqvkKhYxIhvNCL2Nql0JYUY9ol1l7A8FE8bFW8sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759545626; c=relaxed/simple;
	bh=WZHBqjpgenWM6lUWOGdfdtHCtjWENrrZy4ZRfETPkw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V12HSvQ0fq5GexqPh7cbitXmbGnS9vQ9GYg1IZtGiHTIclVrwnQ1Is9/od9zcrgGRn48gl3I8wbnRLMXC2BXXvEM71aCwRsssZYvfp02rlIlH+XRk19BTZl8bmfS/WdxPphStiUNu/HWWMGsUdw45MHnqzIxBYzOixzjQ/1jSCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=EJwug4n7; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-4259247208aso18434755ab.3
        for <stable@vger.kernel.org>; Fri, 03 Oct 2025 19:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1759545623; x=1760150423; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfGV84g55Fp70doV+YS/Migev0C/SPjmIXXRQJSXnGs=;
        b=EJwug4n74NhquNF9ckM1rGT08zH8v3vbJJ+jKghOm97IMOT3J1QWf/L/ROLg8sck/j
         x3XI9RzHf4mjtjn+tDqi09F9S8b86maEe9drgLtYi5CN1sAqu1UhN1F4jShmyCbedgd9
         4dnHAOs5CCbqPQQlQ/R8xm52pnFLrh+2ho+Kc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759545623; x=1760150423;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfGV84g55Fp70doV+YS/Migev0C/SPjmIXXRQJSXnGs=;
        b=bulCaFVew1E6zgrzKPBJmYaZKzclolaHvFlS9FjZK7tlogAhqg1xgW8QjP71tuXk2U
         +QHF9p9G6IspXHf7vsDvbbsUEwIK7hMls4jG5w2q348OjgSlZcIFw3p3hpgrU91HU95A
         3gum95Lj4A1TC/vJMN5J2ma3rhDwk5d5A8tgS4/C4XaoGqR7ms6IzTrbzy4wqlmxvhfM
         naGrG9EDLhJoF5nDhK342H2YUm/MtBF9zzDAgDcDHu9lUsgO9jSxGPEfQ156cmK8MPfB
         k6Dlez7UgC9FEroDb8eJl7Z4xdakPaZwCGXExIXZG1IlzLkaz9/U9Q+SDwyVb8oskULw
         89aQ==
X-Gm-Message-State: AOJu0YzJ5FiOqokfmSBrXwYbveYJIR3toeAGabVBLi5nciqm9UOs+I9J
	PWke9nyoc7tt8q7gcYWX9BKmQA3yPtZ5ajbr43dZeeDNrI8z2XlCrRHsH2JjJc+hUw==
X-Gm-Gg: ASbGncsEZUBU5fA4Ieerkn9ozv9cYayuTLC4hbeJk8sxfNjHHpEeGhuUx/EXb+5K1uq
	LLf9IVVcnghqYQ5PhZ7eT1c7RJivp7gUhW3UcFnld+DFgMJSNJ0b5SiMz893Nxt/4TZlLBL3Yl1
	3UGPp5afs+vjfQUPacgYbCgac6pgf7rsAA1yBs5ILgRC318C7MtErDvj+x+fB+cgiCPS5SmNGCU
	uXvbNF06H302KQndX7hplDDNFVy4ZiVbbN6XuaMZk9xaCSAtT2COdQCuCOhL005qqFI3qgExK0t
	JGyf9ZZ8jVUjlncIx8T/dllOaixRkegEEFrLRaPf6kDsrpagwBvXMxDYcga7PEXL2rjUlHt2Rz2
	PpjxOfs9aG1PhALx5pXpvZx8XRkU1D3KwGkj6dm8fDAx4FBJhWWyQYuqO7xOXdQHLpcRzscx4u3
	WhYgs=
X-Google-Smtp-Source: AGHT+IEioTJIMNzacqCo/UZFC5W1RrKFxPYXMBDo5m8Vs8tnZCDhSKd87QqfaWpv2/P8gUHneV9Gkw==
X-Received: by 2002:a05:6e02:3e91:b0:428:973:797d with SMTP id e9e14a558f8ab-42e7ad258f4mr72119735ab.9.1759545623294;
        Fri, 03 Oct 2025 19:40:23 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.126.122])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-57b5ec10511sm2458733173.63.2025.10.03.19.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Oct 2025 19:40:22 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Fri, 3 Oct 2025 20:40:20 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.16 00/14] 6.16.11-rc1 review
Message-ID: <aOCJFN5CttsqZJ31@fedora64.linuxtx.org>
References: <20251003160352.713189598@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003160352.713189598@linuxfoundation.org>

On Fri, Oct 03, 2025 at 06:05:34PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.11 release.
> There are 14 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 05 Oct 2025 16:02:25 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.16.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

