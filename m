Return-Path: <stable+bounces-178949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8743FB49828
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 20:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41A3A208156
	for <lists+stable@lfdr.de>; Mon,  8 Sep 2025 18:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4455310628;
	Mon,  8 Sep 2025 18:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="g/0VIyvK"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77F1303A1C
	for <stable@vger.kernel.org>; Mon,  8 Sep 2025 18:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757355657; cv=none; b=Mlhj08EtODjmDdpAKbPZqVygzjO0jwRfg16n7CE/yob0TBuescyXpRpI92l80puGW5SDnuCwjjAjYxqC0mGvwSqUD1NdQjdZjFQfiMNcKQkKIJEC5gAdMQkxc++/J17Px8yDbwZPn3IWZqGBpx/HEg+IwQecK959V0vaA9ArslM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757355657; c=relaxed/simple;
	bh=Nh5FCkUds8fUdhe4ZcLrZzck+rIGv90oXfld6eJMTBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EWVVfwb3ut97O9eqthd0oOjEvEnBqqjMotd+O7/8TP2OPAtIjU0K4SQotTE8Jggr5kHWmzmc023flxg8/RnJcvOrM0fD58EYwMKfX3oDPG+oRzSCaXtIypHPCXjrV2zsUk0pr3X9HzcWIaqjgvdFVGse5chhxdsPgyxT8iavbUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=g/0VIyvK; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-40c8ed6a07aso5568695ab.1
        for <stable@vger.kernel.org>; Mon, 08 Sep 2025 11:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1757355655; x=1757960455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KBV+iImOReBPqWH0+/ePZkAazHev8dST5Y3pJ+QrJxA=;
        b=g/0VIyvK3h74HSBnSvv8Ng/zFHZUw+Dt7dGIFQk3+Th1KJII+X8+/M848gHUjZEBBy
         YPH9cdpP1Z2npmGLTg982fLyZu21+Gwo/6xg8HvkzRIKfW9QGd5MtFsq3CFD3tioqIwD
         K5gfy/CAOphldPWg1yGYdVEr82XhDo3p/4cLk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757355655; x=1757960455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KBV+iImOReBPqWH0+/ePZkAazHev8dST5Y3pJ+QrJxA=;
        b=Mhw2869/gWGt+CyP+ID0Dd8METFrkvpb7f3zQ82ONIw4wEbYwBFFp4jcRZmkb969mt
         h/MP5AXqlerWghvA5Kprsm8ylI2VYqKOcKOQQbPrVin3ZmX2fxSdB19y+TKCbLR0vv4c
         vn58br5F74bstCLwbjAq8lCU+mYCekNIhh83pwFa/cyIMc3b2ptlXT++dZM/FhGnZQm9
         AFasfWTOIheb6mBguSHF8UV1rwJgLJsjhYQzguHylPy9bpDnjET36uehS0c4WHjZdV4A
         XOoJX/fnjyR/4P4r/Z1svSv/bs/aDYyBXypQHs8tWVStk6Vi+4PZMtcI0KeJXqwvQdG9
         MeXw==
X-Gm-Message-State: AOJu0Yy/8s9305v/SE/ERkOSOLelZLPcZ9x9FnmOZPSaCD/Yj9vVzYmB
	sEbyxCTPvHKPzLzQd+ZPsdiShgMLWwFTbHkjmN4mC/zJ53BxeLWoZj12VArX+DKj6g==
X-Gm-Gg: ASbGncs1ObTVad1miVF7/lJCfT3aoKFk8w8CTcuoPtARFRAbH+Nm6krc1z3lr6dmBWZ
	cG4zJGg+wvEgySem32PenU9/Sa//YMSwhxrvTMqs1Jql+gOw6DVTlYVRrjAC6B7MQ9OdOf1wbIo
	9q6WwBmroMqqs+ahAcUKZ0aCJY5BbjdGVNs6rwyrE5ZzbQnZp2LwzoLjT1Dg69xl2A8UJcP8nWx
	Jlf3RsXg9EbvlTxPWSF4yxBTSfQfWltdWUdasgFIYx0RnwDonDYtmyrzfGMWqcOdhKgMwA8NV9E
	COlebTiXx/jlNPH/XMwfJ98tD267BwHGE2ZFJ73x2c9ERDyWyMgAnVy/6TVZgd6pVK9haCxMoEZ
	zRvj5orq8Cw1FALLggcNLlPzvMW3JDvD0c8qKy/nbsT20mrZu47I=
X-Google-Smtp-Source: AGHT+IE/BUasf1MdEX0bTcfzQ1t5u2MGL0J2BuN4ERdg8XHl+2w+6N/iuG7UlaLA0C1871kNgg5oOg==
X-Received: by 2002:a05:6e02:1aaa:b0:40f:be7d:bb23 with SMTP id e9e14a558f8ab-40fbe7dbdb4mr1707655ab.17.1757355654594;
        Mon, 08 Sep 2025 11:20:54 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50d8f31d0b6sm8858916173.42.2025.09.08.11.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 11:20:54 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Mon, 8 Sep 2025 12:20:52 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
	achill@achill.org
Subject: Re: [PATCH 6.16 000/183] 6.16.6-rc1 review
Message-ID: <aL8ehNxQ_725HF9S@fedora64.linuxtx.org>
References: <20250907195615.802693401@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907195615.802693401@linuxfoundation.org>

On Sun, Sep 07, 2025 at 09:57:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.6 release.
> There are 183 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue, 09 Sep 2025 19:55:53 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.6-rc1.gz
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

