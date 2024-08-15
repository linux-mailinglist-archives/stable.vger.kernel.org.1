Return-Path: <stable+bounces-69226-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534AF953994
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 20:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04B21F244B2
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 18:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CAE548E1;
	Thu, 15 Aug 2024 18:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="ESBuG04Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA3D1388
	for <stable@vger.kernel.org>; Thu, 15 Aug 2024 18:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723744888; cv=none; b=q3hXZWBkG8kTHvhp1F0e6D9uat1CUxl0/cOqWTNhJ1Ma5SJOyEW5UFHfkXZTIBET2gpUSslBcThu9/zZEfp4RGWwt+84tamP+G7wdxemxYN3x2/PhlhPmOyAHvczTcNrwhRW2TkVdsk+hwvIACaI0MIeadTOrD/tPFalmVCAZ2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723744888; c=relaxed/simple;
	bh=p5CFD/hz48mXaQtx+PagRNm416H5ts4dtuVJW5kR9Fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cR6zzRgiPUl3Ucp0SykSPQoGdzzrRWcLAxn5dMIYndmmkFvzYIrutOcqMivAO05hsRNrcHxhePH1YPKntPH+wCcoTV1wT/8jAQ+AdSGlFSapy7q+FjZaQstrBrKF8XHv5szzFibzpbFawyfiuxWhaHoxqfb4TGcYOoCGsX6RLKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=ESBuG04Y; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-81fd520fee5so52448439f.2
        for <stable@vger.kernel.org>; Thu, 15 Aug 2024 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1723744884; x=1724349684; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7p/I1Ifd1C+sbOJNrkMm3G9GQ4/rpO39owsvu2wqEY0=;
        b=ESBuG04Yv/RjP1+tqlo773SRFJKaO84YTn8YhvwFWwj3NvW67mIHkh0QHbSC+aCpxi
         1fvqwFFT2oUgo+cIDhUudTdaFy+KO10TwncBJakRN2e3+csnydvRZ/9vmbulSdEo3THQ
         R7//90wMH9a87dNAyfvOhyapz1zkeNRM4AWMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723744884; x=1724349684;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7p/I1Ifd1C+sbOJNrkMm3G9GQ4/rpO39owsvu2wqEY0=;
        b=YAbIeQUIKRwHu0qyiRVZEN7IwONSEfF7iXPtKjkZ88P2Si+zReanDwe6gy6yWX08x+
         osd19PkNVL5pWOuKeXKgo34xpfEXMHABHLA1mk7JOQJlrEkbImbQ0Xt4yJYffNMCIZyX
         fcEDx796ZriW3nRXuZVXJbt0N8+hkJu9HxEHJe/dFS3j8uBKEb25QGg6ShZ/WFSoLX/T
         FmfNa3yg73Hy+1NrMiJ/nznWovwR4hz1m3odANe41caHp/zKyfJIJ8D5coznmyMT/xMJ
         XRFImvvS8LTdcpUijTUQwmZuLTrZ04i6gnaq+Vo6zuWAFjvsRfXulRaF9UsmyHMxFWwB
         wGaQ==
X-Gm-Message-State: AOJu0YzzqjaLKzzEbXGxivlxKLdNnJxXsmqYuzSpenL/V6efIhOl62fn
	NsIetzXavoO/d2tdg/3wn7IzB6snODcQJXKcjch6ofbH7Jh8pwonygpnd6Djlw==
X-Google-Smtp-Source: AGHT+IG1BCFoeSQYyuZLRltaAhHPgxyHK54Z6wNBqWVndWOortWFbIRyHExDA0GIirWvVECf9j2goQ==
X-Received: by 2002:a05:6e02:12c7:b0:39d:1cef:2f49 with SMTP id e9e14a558f8ab-39d26d7c847mr7678215ab.27.1723744884267;
        Thu, 15 Aug 2024 11:01:24 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39d1ed76533sm7152115ab.83.2024.08.15.11.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 11:01:23 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 15 Aug 2024 12:01:20 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.10 00/22] 6.10.6-rc1 review
Message-ID: <Zr5CcFhTtIHgtj_Z@fedora64.linuxtx.org>
References: <20240815131831.265729493@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815131831.265729493@linuxfoundation.org>

On Thu, Aug 15, 2024 at 03:25:08PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.10.6 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Aug 2024 13:18:17 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.10.6-rc1.gz
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

