Return-Path: <stable+bounces-64679-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8818C94230C
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 00:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 396F22877C0
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 22:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DEE41917D2;
	Tue, 30 Jul 2024 22:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mtqvYCWU"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD718FC70;
	Tue, 30 Jul 2024 22:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379250; cv=none; b=p5dv181W8fMpxTiUzM51knpI+F75NkyCW79U0SCUy65n7f5a0IOMKY/rg/9tgDtPXJn5qjsagj4OR2vyjHZ8UlTyFwdB9ToHU9V+BHOxM+0E9d2Zc+YRU2+6iS2AeDxmJ39lZmpgfVXaS6nu+g70jZYZ9Le+IvZiob+5qkffZdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379250; c=relaxed/simple;
	bh=n1oety/HXkXrrdiFjXUbok72gHTpJBT9M6nVGr3yB0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sIvJ72ZHuFhiPn3a3JRddKix6ZFrjlV6mr+zcf4ELgz4XvDbNlIM6/okY2EIaelmcodQrgd9wHrKldxeNMKgKXHPFod65zteEO/H1I6tlW8rxRLhi/8eVC9ygeS9GRRqv9Y3XGRLytAWO3R7w8m1xwEr1AMrHC+Loct1fKuhKVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mtqvYCWU; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4503ccbc218so3113471cf.1;
        Tue, 30 Jul 2024 15:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722379247; x=1722984047; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Lh9GVDD6OoCtr0k7pBMipRKv14eFzV2Gv2WBzW2ndOs=;
        b=mtqvYCWUCYRF7unwYUoEErbloamJeOeN3vI4uqo3ZVZIyEGqDCz3+9zzZTVJcR3hph
         k+xXm7WQTZ2qD9WvGunU+bpI1pXGzlePBc2zzz359DRYWQtWoeKcQ0o/rJaYQtm+LgYz
         5A6Pu6Ut7Olh32PRmmhR/Sl9s2Dcz3rFm80KyT/yvp20Vx0W7bZChuVRfCE8ASdsZekq
         k6KhRygJqm2ri1by6JmQS6zJAxPr889B3TokfHa2Q5JJbVW91vaS9noMuUmZhBi0vR1/
         DHD1RDF1HHeLN0Hab/75LFkmvSWP5Mxn2pa/GhjFhePjJJxDsMFIdFal0ENporkl34Cg
         Qx4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722379247; x=1722984047;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lh9GVDD6OoCtr0k7pBMipRKv14eFzV2Gv2WBzW2ndOs=;
        b=bz5zLxIVhgS6B6s28nCxq8BDRzyUQfV+D6GXORARx7LPAijoCwkAn6dKig5IAh5RaN
         c8nb0Rv45sD5CBw/RsB/i1J4XLaLv7DbT+i3kjJNwlBqfeJc1o30wgp3x2FqQuv5FyIQ
         SHt1h6BfoOhJazXbLXxj6Q1W4NIY3arYeOJUt0cC8Zk3IfpgwuurhWj2pVW/2EfXyaun
         s1oABrVAFkGkiV9ROP3K7yyTzcc+tAffnkJBWTzV8CozFpoJACJ9ByglbNy7izk5vXVy
         9lU2riKgAtndRDC4+q/VCME9b5cjwdV0VlEv3JPflnzedujoFpI1ypHXo0pqroRxwi2F
         fOYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQwxdj8SOzwzTJdFClxryYKhWLNNXHaqOXikEnnTISZC/qLvsK7sAnURMZJ9JWXwVEBubfYQHLIV0GGQjKIg02HincwAO/JbDddWHwO6t/nfvNnZIETbRKQk3yOPH5j+OxmJbZ
X-Gm-Message-State: AOJu0Yz0kQGDST0MbabRvTeb2E3VfmzdA8Ih100V+0wvRBSGRi9nmsjQ
	a88kLtq8Ht/ZS9r+x8jGolmozTljAGLPrJidcwp5W2j88cUy38V8
X-Google-Smtp-Source: AGHT+IEz03OTW0OWshfpq6CgIxXtN2wnx4Ll1uuIScwi+8LcsE+ExMs/fDgCHXc4cOpe+gu1u/GQ+A==
X-Received: by 2002:a0c:c48f:0:b0:6b5:2de3:32b0 with SMTP id 6a1803df08f44-6bb77fb12b6mr57670756d6.7.1722379247499;
        Tue, 30 Jul 2024 15:40:47 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 6a1803df08f44-6bb3f9122c0sm68194166d6.56.2024.07.30.15.40.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 15:40:46 -0700 (PDT)
Message-ID: <5f22c1fe-40ac-4a08-9645-a14c348195dc@gmail.com>
Date: Tue, 30 Jul 2024 15:40:41 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/440] 6.1.103-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
 conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240730151615.753688326@linuxfoundation.org>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240730151615.753688326@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/24 08:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.103 release.
> There are 440 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 01 Aug 2024 15:14:54 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.103-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

On ARCH_BRCMSTB using 32-bit and 64-bit ARM kernels, build tested on 
BMIPS_GENERIC:

Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


