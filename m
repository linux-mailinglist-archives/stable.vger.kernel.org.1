Return-Path: <stable+bounces-83094-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A37E995801
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 22:00:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C20BB231A2
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 20:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D95D2139B1;
	Tue,  8 Oct 2024 20:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="fAAxKwsv"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874E27DA76
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728417638; cv=none; b=KOiKxzq70IDRbCPTrmyJwW1k95Xig6fcwu3a7ppuzae1eqw2fRr8dmvf95hYQjKpoGEVAB3cpcqpglnUlp5akWUtSGuNM5vmCM7KyPkYdLONPwSaNfUB5VzFzmHJ/gUraIcFWDbmcO+sBwO1YRdUdHHFeiWjhLX0wO2i9Br8ESg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728417638; c=relaxed/simple;
	bh=L4TMzRNQpVPOWbZCOE7cE5N/YZQtaIt1D0aQ1CVJWFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqYBztnFaoiHgBQSjsB5qsbJQEc6teeegeiiyYmWVPdTuhatGnDkaDr7D032UafxJmPQ9FgxbMJR70Yz1PyFoRaqdXb+KAcuPyiF4ggl2hMtD4OrnxoN6Apoau5u30rtODYg2VoTwOnifUwAQ86dmTWpmsT4mf5R+EL6cfb/sp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=fAAxKwsv; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3a3938e73d3so2514245ab.1
        for <stable@vger.kernel.org>; Tue, 08 Oct 2024 13:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1728417635; x=1729022435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4O2hLyv8Z5OXOMWkMIh4iHKBtJhUPpKJ2CwbLJFGltQ=;
        b=fAAxKwsv6b5Haz/pDuV4mxK/vMCCdPvCvuOm0ageSCr7bOVv7OK9d0lwVejbRzx2/S
         dosu4JdpZ6A9ppHSaAx/6Tp6qhlaOmmLls+P/yA+mLwZxlM51lZaXhrXqojLkLBjhHU1
         THrKrNeMalLHOxBRK5TIJqdrbgdNgwqocRRtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728417635; x=1729022435;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4O2hLyv8Z5OXOMWkMIh4iHKBtJhUPpKJ2CwbLJFGltQ=;
        b=FMYo7JzLsLSEDA4XXoUjAcWMZW27Tvr+NBcz5VkCo19kZsT+Elk57CExFevsJNiP48
         3C06serDjmuL8A6tYNptMSLN5M0bh/FNCav6AvnVJXf3D8IIakwQBzSVgkr6Q0TYcnzN
         UDIgpk7Cfs7Gslu8Z2EMtIL6I74ZrjvTF9YPfI40N/lF6fm51DZDk5wi+qqEBzMYxf4p
         EOSUFD60mrquQhLlNbo8b2sD92RFmFGflwOnhNMty5g2tQJq57w7ASCEL+fwigTcnY6z
         rcHUe9owftUjrezd2qLKRip4EfRQ0JRoNAdsqvAtAnenmrYXVgp/p8JBSWgsfblNzgbE
         IPkA==
X-Gm-Message-State: AOJu0YwmHm4JVqv09OqLbX9ToXGmt3pqM1zV5FCPke1tU2RVmQHJFf/k
	s7Io7vqZ65sxqTRCUIKYS2QbJb2Hne6QwGotjpjpSau0qjK/tMdQcuRaIWTQfA==
X-Google-Smtp-Source: AGHT+IFXaXVZPUVw+PPNy6YxHhk8v1B842a1sIITVbdjK1U0Q3vtvjyULqujLR8b8ghr7BdgMAXAFw==
X-Received: by 2002:a05:6e02:1749:b0:3a2:aed1:1285 with SMTP id e9e14a558f8ab-3a397b9104amr950425ab.0.1728417635219;
        Tue, 08 Oct 2024 13:00:35 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3a37a7e790bsm20079775ab.10.2024.10.08.13.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 13:00:34 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Tue, 8 Oct 2024 14:00:33 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.11 000/558] 6.11.3-rc1 review
Message-ID: <ZwWPYdVuMOQj5iw5@fedora64.linuxtx.org>
References: <20241008115702.214071228@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>

On Tue, Oct 08, 2024 at 02:00:30PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.11.3 release.
> There are 558 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 10 Oct 2024 11:55:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.11.3-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.11.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc1 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

