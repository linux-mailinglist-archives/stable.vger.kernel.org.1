Return-Path: <stable+bounces-57931-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5595B9261FB
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 15:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 148FAB2594E
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E154D17A599;
	Wed,  3 Jul 2024 13:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="CS1o0RVS"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B86F177981
	for <stable@vger.kernel.org>; Wed,  3 Jul 2024 13:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720014035; cv=none; b=Wy4tfSdCCU/dN1788sF28cOPJiLbzagIB9Ylg2PdTriSCuAcLOPzcx7HiHRsPEI8GAA176KqXyLE66rkQSjKoUQcXQV+wAXePgosi+WHgU3L71mxlWEscTFFkT2LsWU6l9zSY3X3nWHiMGXNBpxmWMVhV+RcTLN5UOXBWVWrn6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720014035; c=relaxed/simple;
	bh=v7wwnRICdXXjAY6LgmjAdX6RgRmXLtgDcP5J/fl0+gI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HPeJ51i7APh32gNHOdusbHQuoRdDNrT1dQaFdMQKwcYlj8938xox6j9HqxJePJ/5jWAbmb1F64U142uhjF7WmnbK7UFq4nuKpgwY/wReii6H5MqQgs9E7g20aUc5viYsymGyh86S3G9ngEIH5zAaf6Dw23q9raZWDymC3cPcgB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=CS1o0RVS; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-36dd6110186so21989485ab.0
        for <stable@vger.kernel.org>; Wed, 03 Jul 2024 06:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1720014033; x=1720618833; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqM6xmAf2FrVXZ/POZdTnbDcUyqueEVyejWAoz1akso=;
        b=CS1o0RVSprk0VY9tkDAFeZp0hI0OJ43VCrlJ2F3Oq+1sVM01E8tYIXWlxRhXa67AcN
         a+/eZ9523MkeQJFbUohozgyQ5RAxjcvqBMUyc1pGd7ioLHxrE03bvzP5IaiG99ML3r0s
         JpO09CUK8SV+HflgRyZm8rHPcXH8ei5+4ZZ2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720014033; x=1720618833;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sqM6xmAf2FrVXZ/POZdTnbDcUyqueEVyejWAoz1akso=;
        b=HJAe47+G0MUwGcn36IlUn49YWG5r5DCAYGKOonN2wgMjMiBYUsUrPxeLUfhooLCVUq
         6sCRkpRZBt9rCJKxlnwaMBiDc+SOS25z3QFLYu/4//gyb2ZFualvIWR0FcA28Q/E2FCh
         QeoOHkvwh678wE5z8ETVVi3s0eZB1ghNbIAN6BlN4EdkAimOWmXcX7D6eMKqkaQtSUgn
         ehPi09+a5y78ajsTWXr3nPWi7M4Km6LvKM1v5jWd81DnoB5bg7z8DvsXpfw8TwIdp05w
         qhIMdxaGD+V9eiHzlFqDv7zWQ/Z+K4hjUce96yq+yDiLAuqeWuOOG++EmCfZJl5SSJ5I
         fe7Q==
X-Gm-Message-State: AOJu0YzSBZuAdYmxZvb6J1X/VkaX1OAbHPrlo8ywdCCnj+R92u6nwVaD
	8JKJgHxagaDC9wnU9YDSF1ZOyMQI1LbvRrleVSKv10hsRW/yQLSVR6Fk8BiR7A==
X-Google-Smtp-Source: AGHT+IGJTLo3uW4neYggrSnFI0GNTTvwL1bgoMUMB/opYf7ZK2wNJ8LlRk6COAdB+OwLjbazDn7txQ==
X-Received: by 2002:a05:6e02:b23:b0:382:3c83:6acb with SMTP id e9e14a558f8ab-3823c836c93mr16197865ab.8.1720014032970;
        Wed, 03 Jul 2024 06:40:32 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.171])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-37ad2f41391sm28762095ab.46.2024.07.03.06.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 06:40:32 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 3 Jul 2024 07:40:30 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 000/222] 6.9.8-rc1 review
Message-ID: <ZoVUzgPfv5miFnWS@fedora64.linuxtx.org>
References: <20240702170243.963426416@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702170243.963426416@linuxfoundation.org>

On Tue, Jul 02, 2024 at 07:00:38PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.8 release.
> There are 222 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 04 Jul 2024 17:01:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.8-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

