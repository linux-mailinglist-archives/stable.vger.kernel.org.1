Return-Path: <stable+bounces-189047-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4709BFED36
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 03:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD74619A5CA0
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 01:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7CB1448D5;
	Thu, 23 Oct 2025 01:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="YLkqZIlO"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400E82B2D7
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182433; cv=none; b=OvRDzT+wWwu+WcNnj/633cYSs0SVL2q4kIiVtzGPqH0SGb+lvD/ScnJQq53Ldu8wyHoMZRqwC8w4MS+sXJU2MW5stjnrwAei3iuRzw/F2DlQCjspsCGaa9JWzG+s460Q4dYoOhmm+J6prP+1bdNJCUGSogvIeLEgIMOsY/H6+Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182433; c=relaxed/simple;
	bh=HWeVzs4HkP0W/Y6HvJDuWMbx8SneTc7qsQZMtj9yvMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QB0wlR5gUxQ3JjQP49cL7T+MusNsKJ0YhAsL90SsBI+ukJu4LFxyKXtYMA0WNGoqtnOqZQpcViV+DTb4W6htR2wuF+0OQQBsOO0QCJc03X9Qjh5USuxPDPIc5dfUj7+A2XRxjGFS4J4jlgTc9HuyUgTDCnCaXfPLYS4nKK+wNGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=YLkqZIlO; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-290c2b6a6c2so2517215ad.1
        for <stable@vger.kernel.org>; Wed, 22 Oct 2025 18:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1761182429; x=1761787229; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ijG+3nszibgNynLBA4c1V0LvvFa9+rH6/8ywIqIspo=;
        b=YLkqZIlOPSWH7uqLb98KRUHOr/4QzLA9u7R8GqPdeeqnRo5u+LuHPZwmz8mSFHkJ/y
         c1SHk+zrIFBGyohbmg04vRx3/d2+TKY3Gm1wzkzfLVThqHF97X7EjTNM6q/DApEWG0di
         ll0mA8YQPMJV4xoKXNDZynABNIxMPTYIgk5OI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761182429; x=1761787229;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8ijG+3nszibgNynLBA4c1V0LvvFa9+rH6/8ywIqIspo=;
        b=Q6jSHiPdmBglIHGEwtOGnpMH1u1OgeMmMBvVpD9uZpmECeNWKjdrx2rnwy7LM/AnbF
         2Y0UVJE9k/hU7N4ytjB3wF8Xi4MPeJOSTJTB0L0lTz5Gbo+D2RLcViK/6raYjyQHcuDB
         ARIDvGxsMMQZJf29p1tWCmkHaFlCZadPNAOEd3Mk+MeU3XIvmSK7emsT9Wo/Q8oMHqf1
         E7fveecQiVcmAU7R8zHnzzEwMJMPdCJR1BY6PM/7NlZkSMGf2QzWTWSQw9a7LRgemJLM
         femtILd5RssS8uhgoNUBaAYTWiG672DMeSb8+OGG2zlL91Ymk+oy1+qDO0h6bFny3wLa
         TJ1A==
X-Gm-Message-State: AOJu0Yzh7zhZlYtOqOy/YPbcBT6l6RxJoCh0kpOO76quuQKlP8AgIIN3
	2wRoLWO+AkTaKmlP+5tWeMwf4WLdmAja6B2EnWCd2E9rQLcTS0SS1Fc0+5zmetCRuw==
X-Gm-Gg: ASbGncscQ/AbmCDC/LoEJqkF0DNZQ1asLw8LaSbBnv1E45wQ3kjL8/OWjb0trCB5Geq
	rjm8OW82sdUjHSF0cjJpXfMQl3kJo5TPc/EDa4vP6dYCcbqZzj6P47rGqNJL8+U7GtDGb8yqsBL
	2tcnRonJJEPuBoEx73mw+3RWhjPf+uV4HnyvsNhdTsvLhm1sieaC0/1wYrFKubqUJvjTUnAGe8e
	hQkhOFhoCVkf+zK6bxLDiqFqwBKUGwptAW5GM/W394TnAMzWQeKSfQCQCB1auVYyYRctB/1qFYn
	INHV5Mesb1LFVfVWDB3tp9lbPgteqVt/bz/VBOHk68b+OS4td0yZx80mcyydHOYLuO4TvmwLSmF
	xumJnTjIon2mVjrsENYPuEYVt3ypa6EXI8x4SsOF4NjftqYYZoA/9Jrr15VQ/xiRCK9DToQtdi6
	4bxOiyX+tIoxaI+R7FfCJDwVs1jNqMPpA=
X-Google-Smtp-Source: AGHT+IGqlsv2gN808APRt6SB8St16ScWc42axG4K0bEhdfrp2ymJT8G4ZPKTSW9b6iTHmmaAgcxKNA==
X-Received: by 2002:a17:902:d2c6:b0:290:c0d7:237e with SMTP id d9443c01a7336-290caf831cdmr329156695ad.39.1761182429389;
        Wed, 22 Oct 2025 18:20:29 -0700 (PDT)
Received: from fedora64.linuxtx.org ([216.147.124.76])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6cf4e4303dsm378640a12.37.2025.10.22.18.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Oct 2025 18:20:28 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 22 Oct 2025 19:20:25 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org,
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org
Subject: Re: [PATCH 6.17 000/160] 6.17.5-rc2 review
Message-ID: <aPmC2fnwdvffkc_B@fedora64.linuxtx.org>
References: <20251022053328.623411246@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251022053328.623411246@linuxfoundation.org>

On Wed, Oct 22, 2025 at 07:34:14AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.17.5 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 24 Oct 2025 05:33:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.17.5-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.17.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

