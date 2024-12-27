Return-Path: <stable+bounces-106218-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC409FD693
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 18:27:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EFAD163EBA
	for <lists+stable@lfdr.de>; Fri, 27 Dec 2024 17:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81751F8691;
	Fri, 27 Dec 2024 17:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4xDEfZ+"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3035E1F4E4B;
	Fri, 27 Dec 2024 17:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735320472; cv=none; b=d74Wr9s/aXSsPD7c/46AKuB7Frcs9fd1hdQ3JvOXtx5yiN0KdZ2tIBDJGTtLXwjXaE5JhJqyIV22ApHeAInt5lTjGQoZXRezYh2bpTV1a2D/02uR1XyuDOwncjsWROGZ3lMA3T8x132g/4AZt+a17dItfsZwLzqL7AkSM4aqjus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735320472; c=relaxed/simple;
	bh=OVS+8LwDX9Vlv5sgHzcrai/X7AZs0h5bC1ibqLSKIlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZIglXFSZexGnRGym1yU1OYukHfxtCTYAPGJcOksW01FdYZ1G0MTUwljCOZoc37F+xdL+1BVvXnjZ/Wybr6iXAz9YG9PkGxLk1+C6iZ6oBoOnfbsY9DEubX7zOJ4KMqJqxG0MrwHlelP6YiShKIsNGpHB5BRVbEswaVwbRfqe64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4xDEfZ+; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-2ef87d24c2dso7675061a91.1;
        Fri, 27 Dec 2024 09:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735320470; x=1735925270; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7+bHJo91EH/ascAZ6YxEM5ft3sinT845bIpMBqq57mQ=;
        b=M4xDEfZ+xplQ/Z+x9qTjhz7jQ5H6EOjO2K2OaWn96bpNukrBbI1qMQLT3PeMfww1Oc
         TlxY4NKi8g+zKVTOge7ncmZi24g1miD59F7Hb74m16spS6PoOc2ElNgD8uk/lZJix317
         vNBgnVtee1bhd3PCqClkmmBhWizLR6gIczyOxmqmFnUnt9vcFaUSO43DWSczc87niOI/
         pRhrv/xzB0zycSKATB4darYXdWMyJsRoJGceDZ9A5faUXSm4rPs4vFipF2ALDbX3oz0p
         jKhiklek6L4LtEQRxYUnGEUlJOXCLntlN/NyxDnL6Emc2fD8elGUpt7accXQEfOUOacR
         LqcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735320470; x=1735925270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7+bHJo91EH/ascAZ6YxEM5ft3sinT845bIpMBqq57mQ=;
        b=Z43GIYyyIjipQQl69IQMHBdkxU9SVQXFruYxxMcATKr9eeWj19d9i5ugZYssv1slxU
         l9P3MNXB44dt3cAxtkSVOlbb3xEBnO2MesGzkq+lCZlUSxH44Bzfvhk2/fGwYVcPasJZ
         lRCfGPTDA8ksI4h9L6yt+b0ZGmrOKjxv7cTANYlX8mnz/oi5kwfcBxU/6pS9ALYraI5J
         k8fkeqPzWgH2rIJdzzE7+p8e3gjxps0GNyKEv4Z7qFSYc7EsTUDJ956VdWrgpdptFx3q
         WcPImbOJfpkLpn21GCXAG8BLjusmxl23Yv6ypdK9zHUDj0jeWVIGtE9oU5ZMMggrHy3c
         EWkw==
X-Forwarded-Encrypted: i=1; AJvYcCUvc5V2Izmcf9PMh9qqoimlBxmhcN8cUq+xV7QBIGag21mdGRRDxYShzgXnPS4O19bfKkO5YlEQN80//5E=@vger.kernel.org, AJvYcCVGFS6RZiBO7RVBeEAkDNRyg4QxivuJbJT/ctNSZy/aJa6UubAwVvk55O26Gc1I/lHl8A4UUvNw@vger.kernel.org
X-Gm-Message-State: AOJu0YwPl/2OwiTFtUTvbd0eELk/wNm8680lElyr2EpI/Kwp4vfsLuOZ
	ARMIUNxFrNgXWWGXzXS/xGKmKQreahCvYpJLOm0xHhWnU2QtZ8O5
X-Gm-Gg: ASbGncuNNecInxwGMfO7Me2Oi/j67vY90qwyyEZzMITdHhOw+5TsneY4GwVhVGmptAq
	ZydLkDlmBgHVTSaQP+6mv0SJA+dWW+RZproJuD7gzisfau1kdI+U5aGgD5bmmdj7+OTZzsrDTT3
	ILkAeVGt2wpCoWlcQ81UMXJlYil/MS0jBToudUZA9Ixm5PRgMIF+wBhHkCBTg4olBwo2C7V30te
	ZQwNeA2YZPZYnWHJW53weKe6HBmo1tBHTfeq/6dMLJijpueR8Y2g/ks+RVh2xnGn7H72w==
X-Google-Smtp-Source: AGHT+IEcqaWWJIa7cYb3sKuIT0xLunW/WjjlJfvMw/GbWHpzmMh+tksDqSTOoXNet14yhuROqWzULg==
X-Received: by 2002:a17:90a:d64e:b0:2ee:a4f2:b311 with SMTP id 98e67ed59e1d1-2f452dfae72mr44824483a91.8.1735320468951;
        Fri, 27 Dec 2024 09:27:48 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f4478a92absm16142935a91.44.2024.12.27.09.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2024 09:27:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Fri, 27 Dec 2024 09:27:47 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Marc Zyngier <maz@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Naresh Kamboju <naresh.kamboju@linaro.org>, stable@vger.kernel.org,
	patches@lists.linux.dev, linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org, akpm@linux-foundation.org,
	shuah@kernel.org, patches@kernelci.org,
	lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
	f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Anders Roxell <anders.roxell@linaro.org>
Subject: Re: [PATCH 6.12 000/160] 6.12.7-rc1 review
Message-ID: <52873782-3b21-4e53-95fd-1288d5dbc024@roeck-us.net>
References: <20241223155408.598780301@linuxfoundation.org>
 <CA+G9fYt+k1m9oTuuZaGyTXqg+EKsSTnmfsc2HYijDWmEjx9xFg@mail.gmail.com>
 <87y102r27e.wl-maz@kernel.org>
 <2024122713-vacant-muppet-06eb@gregkh>
 <87ed1tp8df.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed1tp8df.wl-maz@kernel.org>

On Fri, Dec 27, 2024 at 01:23:40PM +0000, Marc Zyngier wrote:
...
> Additionally, these tests are mostly pointless anyway, specially this
> one, which really should be deleted.
> 

Would it by any chance be possible to remove such pointless tests, or at
least mark them as BROKEN ? Having them present suggests that people should
run them, and feedback such as this one isn't really helpful. If anything,
it is tremendously frustrating for anyone trying to run those tests and
getting that kind of feedback when noticing and reporting that they are
broken.

Thanks,
Guenter

