Return-Path: <stable+bounces-124156-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB7BA5DCDE
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 13:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEB767AB5D0
	for <lists+stable@lfdr.de>; Wed, 12 Mar 2025 12:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5CC243378;
	Wed, 12 Mar 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="M5Shd+Wz"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5A244EA0
	for <stable@vger.kernel.org>; Wed, 12 Mar 2025 12:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783267; cv=none; b=E1S1qIGegbxASyQDVgYo1SDBCZVDaL1PxOPg0DiA65iJLecWjNZZSHCmh8RTKUn44ObtNS5RAfrnPjTtdj3HyCwKuxGTpO2Ml5Itwuvurgd8zCK2J7wW2BY5P7IPY/qY3GaK6mZv6rv9jdDDQE07c9eTSxUP8xJTBaZGfgTacQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783267; c=relaxed/simple;
	bh=bUaSlUg3RSFBTsJCJQtMWIt/F/YS6Geb3jIJDsgvVi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y4JWk/ZB8e6GQFING3hcA9RfR8u9uGgTO5v3aq7/BtZw6P9OzaREJfgCqdedl9FugQ1W1Mt40dmY7Sai9VQGG6Tl7pZp0K1zeDZ9he8aYW80qUx5SP8IadNrDs0Fg5ewSK0yLkQNIaaZmr6RmUdZRrz4YnORh4S1njyZ/IV0ncE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=M5Shd+Wz; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-855184b6473so447256239f.2
        for <stable@vger.kernel.org>; Wed, 12 Mar 2025 05:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1741783264; x=1742388064; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dP4A1PaPKl7EUlUOAH0m0yidu5CcqdMAHhNJvQYeKs=;
        b=M5Shd+WzC7GB6bjfp/h+Z0i3ZsVVuaO6Q2Lc9jxjclwprMYa4SWAUOzO9bYYvbLuVb
         KsD0wvtMLDSqBoSonFnjrWLczXateIFvbARFkqGpbYwlDz+XowASRJj71wUIlhQlFMYK
         iB3UYYWASs3XOJbPscVqBzgJiriwFQevWIlVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741783264; x=1742388064;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dP4A1PaPKl7EUlUOAH0m0yidu5CcqdMAHhNJvQYeKs=;
        b=w1NjaLevB33u7hm/I1P/4wxC9B2mbFC9eCLQ3SbiSjwjeETv7Rxk/EyCJEMSOwOabB
         FyyH7uwZmSkf85rcbqscZ8R1gaMK62w22augMMlRq3V1+mmMOLZkNNgsDf4xmwCeQbxa
         gsUE7KlUWl+yFqt2nxDT0izw86yvs4XsrhAx43UrImL7zSpQuzGOmtvVdC2wivbuIw1d
         IUz/YJ8tD/ldT7UN37/S4HOBjMcrX3L3wojrrYEyZZ3PFNlE5/RZ4UIVV1Ko6lukVLUJ
         JboLvUQelwVvMnNy4f1vw61V4gymXd/g1y0aSfyKzTJ+TrZdGjIXLcxdwuftfwuseRnl
         B7/g==
X-Gm-Message-State: AOJu0Yy7qujG3OGdWUe73e3jAyBPPCqfsxN9bP8b6ks6q3bEjTJROTGj
	MnbiLMBDk3xqSafwpyqIhwa1t1P7AQOmgGLRrwuF6/9sYOmDPBr+KLMRZFhQTasSxlPGdkcTwPm
	dLA==
X-Gm-Gg: ASbGncuzQ7idrAWYOCj6Hs+//0XUwNeuQpF9iF7x708ig5harfv1ezy6WhmZphcGgnW
	gdvPLkBqtepiGoDrUkvJZtSJRnEU3Vb+CnfhQ4pwXGa7bS5fkXaQtStxEKHHVPAB7EnFf9RXy/H
	hTxDju9QvjNTy4nReYMBJshCiuMaZ7fj2QB6f6IEAYMDmZH8J+YhH+q5kNbBDQ//GHhb+UHph/C
	5O5xUHlxPY4G6fxm+TtPtUV+qRM1Wd9jQ33chphlFX4r49GEy8PZBSxRDilZpRWhWFh5wncL+eu
	bsSGrK0VIooCUBS+q8hXj+1U0qWYm7cDcD76difHDloP6oO5svX9AgBPM3KLog==
X-Google-Smtp-Source: AGHT+IFLQqpuypHSRNnz0zBPbGSRwBTTy9nuZ3EEUDWO1+xrScavLssIudJZMqoxc71JqTU36mYhUw==
X-Received: by 2002:a05:6602:4008:b0:85b:577a:e419 with SMTP id ca18e2360f4ac-85d8e1ac1cfmr810913739f.1.1741783264692;
        Wed, 12 Mar 2025 05:41:04 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.70])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f209e15822sm3165046173.37.2025.03.12.05.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 05:41:04 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Wed, 12 Mar 2025 06:41:02 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
Subject: Re: [PATCH 6.13 000/197] 6.13.7-rc2 review
Message-ID: <Z9GA3nNRacBJxmiX@fedora64.linuxtx.org>
References: <20250311144241.070217339@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311144241.070217339@linuxfoundation.org>

On Tue, Mar 11, 2025 at 03:48:06PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 13 Mar 2025 14:41:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.7-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.13.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested rc2 against the Fedora build system (aarch64, ppc64le, s390x,
x86_64), and boot tested x86_64. No regressions noted.

Tested-by: Justin M. Forbes <jforbes@fedoraproject.org>

