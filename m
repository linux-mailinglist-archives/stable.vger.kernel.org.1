Return-Path: <stable+bounces-61790-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 247C193C92F
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 21:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7C61F2342C
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 19:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 193736F2F3;
	Thu, 25 Jul 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b="esos7bFL"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464152F9E
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 19:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721937204; cv=none; b=sDXEjGNg880ChpEg2nx2tVmKLSNZIvxN87B7DHCKa+eSneRWWfU0/3sFCyCIU4sfnxbHXH6bdSVxJNYhLLlQ8WBsr+olX29zxD30VNGvNTYL+MBnrdyXBsFSWvqiDtYk+dRHhiP+QudOmVi6PgApW89x2YzOCm9c/oCt2qXeS2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721937204; c=relaxed/simple;
	bh=Utp0ONC638uinIa4DYXOLnH6T4EHZPkcFf8PZrONAMI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K13qooZufOhdbDlRUqgfcx/fYHXA8i0fVQ3vEoMIF275Qeu0OX4PTY/dvCZntwoPC7UE1JHMS1Oe2q0mG2xcwVR0UpJMmKWACvK506ERQC1P3gv3CWUx6NkgJ/xjwINDCWjpv8VBwUa5iaI2TAdNnbr6v4i1f1giW35EQcXV85g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org; spf=pass smtp.mailfrom=linuxtx.org; dkim=pass (1024-bit key) header.d=linuxtx.org header.i=@linuxtx.org header.b=esos7bFL; arc=none smtp.client-ip=209.85.166.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=fedoraproject.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxtx.org
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-39834949e42so4260795ab.1
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxtx.org; s=google; t=1721937202; x=1722542002; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aJ/GUQ2tjYnP+2H7FqWVb31mphUxYtPXsZYEwwVMfiw=;
        b=esos7bFLlgwzIgrAUYzxSSd1EZnXlE+A3OIJs2OVGlA0ppHtoIuDjmSrbrSVsYgm4S
         n9F85Sc57PIVWyh4l/Cge42OtztZ8qfFGCGF9JOKELig1MLg/kVXnbzIOrYAbvIZ2w2B
         jetnfr5EumFnHO0JnfMU5dMsf70dxV8Bnz+gM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721937202; x=1722542002;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aJ/GUQ2tjYnP+2H7FqWVb31mphUxYtPXsZYEwwVMfiw=;
        b=kkDTNTFXEHIKTSbf1JcKqD1yxpyytp5AsnJ14jkFn0LTJP6+FF91oevPMl0S/eq3QD
         3hwCarYqR/AzZIzHozRXNQNvojA8EaLzw+vnPtD8KAMOZZwy7MK5MDyQQP0apQ2W2Fg1
         BHuZNXkn+fPNvFyI4Rip8Kjm3QrMiWZyaezrZIMqWfo92KKXVeAm8uhdbzsYMtutpjME
         LeZghKHjy673ER23R0grAwBe6MCP/WJ8c7WfKlq4ode99KnMsEdSFKj1sBMnP0t1VUHt
         wQsWoJcPlLNr+0xDqavFY30f3egYalYfSg8iW2Ib4rgDr4ZseqADB6iW5p1Trl+QVRSJ
         fiGg==
X-Gm-Message-State: AOJu0YxZU9ez3uctydi5odicikGyAxONz8XxdaT/S7kurC+ABB3Zod0r
	pd0q+/dmTsKmZkNwpZ+emgTO6ZpTs0drLrrE+OnMk771Gl5JJv0AUUcJcFygoQ==
X-Google-Smtp-Source: AGHT+IHSPsHUVKUyMsr2WhHJqJNS/jVhb2RgoQIDsE+JBJeCVQ0e+zP5yJW596VfihSYJuRw7xeHmg==
X-Received: by 2002:a05:6e02:152e:b0:398:acbe:d798 with SMTP id e9e14a558f8ab-39a23fa0d57mr41072375ab.4.1721937202047;
        Thu, 25 Jul 2024 12:53:22 -0700 (PDT)
Received: from fedora64.linuxtx.org ([72.42.103.171])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-39a22e976besm8679135ab.31.2024.07.25.12.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 12:53:21 -0700 (PDT)
Sender: Justin Forbes <jmforbes@linuxtx.org>
Date: Thu, 25 Jul 2024 13:53:19 -0600
From: Justin Forbes <jforbes@fedoraproject.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
Subject: Re: [PATCH 6.9 00/29] 6.9.12-rc1 review
Message-ID: <ZqKtL7_yP8lMqAX0@fedora64.linuxtx.org>
References: <20240725142731.678993846@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725142731.678993846@linuxfoundation.org>

On Thu, Jul 25, 2024 at 04:37:10PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.9.12 release.
> There are 29 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 27 Jul 2024 14:27:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.12-rc1.gz
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

