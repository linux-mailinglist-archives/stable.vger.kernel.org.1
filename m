Return-Path: <stable+bounces-165601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26491B168EF
	for <lists+stable@lfdr.de>; Thu, 31 Jul 2025 00:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD2541AA3562
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 22:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F4821770D;
	Wed, 30 Jul 2025 22:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EeKT/8L2"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0F11DED57
	for <stable@vger.kernel.org>; Wed, 30 Jul 2025 22:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753913577; cv=none; b=eZwzZ95wdzCx14jBeGVmlQSvX8Ok1RWfj5JplJuhgfc1LRjnDZ8Olf9RDLzKlTvsIwkI8YafsRiTwa1Ut9GY5ZsYWUuRD3GdzO9AFiIHPoHe0RwDTDhYpaZ2r5kv8rUEZrgnrPencfGs9Br1GKjVoqGUoFm/++WG1916KbpUmGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753913577; c=relaxed/simple;
	bh=qYO9XYMd9Ess2LLFsyadSHoQze0pFR9pSR+4q7JxSB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g5grBsFtDYZ4w3cc6JROOeb/SoeCzy5hzadEQsxSxiva07MMpvJ7KDzEEkYuXD2FZbJKKNKgHxclkVacR8SFoxsBCVS9pLl8XzFv4sFQmAzgInyq5qGgg4enJgggd6h5cNUdqmlkfnedGP4I+8XvshAH3OEWeHSSK9NxC5R16Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EeKT/8L2; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3e2ab85e0b4so6595615ab.1
        for <stable@vger.kernel.org>; Wed, 30 Jul 2025 15:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1753913575; x=1754518375; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6nTYoBlbWe2hufH9UN/C4sSrgwEPP02z/hVZuVmtCWI=;
        b=EeKT/8L2QvLoSTkFkusA2NX7TlsacAVjXRbKhiiRhgzBc6hR31zhdg1gcVlgMfjwiE
         WgJtpCanBf7vj0bFjiPfqPiOPSHbsoFcgww4mSV5uXlbdVnr94Z3SyI07lS5nyvpIacD
         RCpCss6K27Mhw0JDmH9PLyJTvrw6Xa+O4M4fU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753913575; x=1754518375;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6nTYoBlbWe2hufH9UN/C4sSrgwEPP02z/hVZuVmtCWI=;
        b=bVXpdHrwxl0IUNxHSYteO3BjPhM5PSRRxEpxEse6P1+BTf3TgciCLHookQdXq2AJiy
         EDlj9k6WwrXhWdoLHC6aHbzCogfjV4odRFwBWTyzqIhcMNInTCd79CGMA0bUeBT/nMFO
         e3p3baHW9EdbFNhpPKj3wLa8uY4Xnb/zNH4zS0TxAFkBajXhlHAbzJcf5lHuXVfAIZwL
         ArlB8HepryhP+ApPvxjgK3/6Okd5/gTHSELsi0ANkJJ3WB6LSg2z2JhMwZEgI8KOp2oq
         aOkN2lChoo2aVxEJTdKFGtNHCL6on38i5d7fnaJ7gTZJAl6UengP3rkiB4p0ja1/n4AQ
         eQXA==
X-Forwarded-Encrypted: i=1; AJvYcCW8pWuOTN0wfSlxXGMWy4hNYyIRVJXs5QSq6u+L0G2NOlCIxS1CJEsElhKFDeoKb+dvKjNbhRk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq2E8lNtk3nN+hrwKyrssMX+VNBd9rz+zYW9wnq7L+R/xCEHqi
	kEcbMSIJO3eSLyMeuSCs8E1H9/wfR34+att77c5OPMxvpRzFoVh4zxXKR4R6XuXrWfo=
X-Gm-Gg: ASbGncubqzO+0vOHyAhEtuVHYtVNhJL9YwzHOAqsz5j52LZn7PwCH6MyOfANdMKBT/O
	bPZDTazds2V6fuA1eUb3eMcQGFa4FCnnRGti2Gnyd5RZRo1jjANwb+hEx1JIcQDuPP48AF2mpgS
	zYcrwwT/VYhiek5UoGx5jmCSTki1zNmBeMF6Ayj4sCx3ZaMmpXJkrlGNF67MK+Kte6N+ciRa+C3
	GZ4MElr3sRo0JbFtU0gyd3AlcmCvN9TXVLX1eCP39DDsp1lkOaUPaS5Ld/XsueMddfpCQafucLs
	yoZIYhYwPOQBUqOzF3Ew9Tosp8GDZzgObxKmQptjLglSYL5g9ZOeACM7uhK2Nc8p9tuvZAxByWZ
	p5EtA9BaP4uE1HzN5bAU0QUzLA02H/FIv6A==
X-Google-Smtp-Source: AGHT+IENXvtA8hkhU/P6BXgu/6rZ6F/aOk7oAL7Z3QHmfwQrFaEE1/aG4rLPZfTApHUL7oAUHR3i0w==
X-Received: by 2002:a05:6e02:ca2:b0:3d9:2992:671b with SMTP id e9e14a558f8ab-3e3e92ceab4mr94834675ab.4.1753913572713;
        Wed, 30 Jul 2025 15:12:52 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-50a55da3360sm91133173.83.2025.07.30.15.12.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Jul 2025 15:12:52 -0700 (PDT)
Message-ID: <b718868b-d805-4ff3-bcae-3ee8b540707f@linuxfoundation.org>
Date: Wed, 30 Jul 2025 16:12:51 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 00/76] 6.6.101-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250730093226.854413920@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250730093226.854413920@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/30/25 03:34, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.101 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.101-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

