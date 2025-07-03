Return-Path: <stable+bounces-160128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8885EAF8331
	for <lists+stable@lfdr.de>; Fri,  4 Jul 2025 00:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176941C26AEC
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 22:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E1A298CA7;
	Thu,  3 Jul 2025 22:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fYhX5tbs"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F6023ABB6
	for <stable@vger.kernel.org>; Thu,  3 Jul 2025 22:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751580968; cv=none; b=AoE9cR5DYQTbpiiVnnXXt0fV27JD1nwf1eFw9DMNeTepxcCSVyP8iUT8pxGggSb5sH4bcvYe9Rbe40bfPfGl9DhCF5p8L8clox12BSrRcYhsLYu7GSr+WNsTTPIO+h0ge8MjX+qyWTLseTw8PIRaxSKyr8AWCMzh8dqv4XsW1+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751580968; c=relaxed/simple;
	bh=30eSpXy4De1lX70AW8XZs3ihzdfzo6XZ/C3uT7syH5c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrGQCfmYWpICanP06WkUdnHEy+Ed8F8OCOODg2gkOc6ESNomy1ButInKaItvJ5na2hejSssNXvQz1NnFfrzJrB398B10LKcYq2S7dboyHgdBZPznSieBw3nuICpyVIqZGOkcYESiq5ccEKLI+pDiQKL/QpS3aLyp2boCdxryjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fYhX5tbs; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-8762a0866a3so8759439f.2
        for <stable@vger.kernel.org>; Thu, 03 Jul 2025 15:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1751580965; x=1752185765; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6+8Lqju2v3JEpna1RtwZcpnJkSUldnP87c8e45HlgwE=;
        b=fYhX5tbs92CWzBQmSLFcJXeDUk0wDZ9Pkn43DBwPUwlNvNbDsRWitjCRMqg2Kuk/3K
         6PYf57yOluThqbuFPNfCizmJhLknZ3mdDujxWuBq03+QORyi05KJypAqkP8ksiPrl5iD
         fcf1Z6JcuY2vP9sJ81KCMc0zG/tOfGHSeSuB4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751580965; x=1752185765;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6+8Lqju2v3JEpna1RtwZcpnJkSUldnP87c8e45HlgwE=;
        b=XHMQBSjGq1hYQDnu/zlsFBawuybneoQ+82LGUr7TVoy+bY/KLuIpjOvn9QJVgzbuUF
         Lme1VeaF8Xescm+mA9+LwURNV13qNK+IfA+MPEfmBG1EqAkUai89bAfwPniwC2quofBN
         SlSD0HO7StOnDGD0ZfL4NoOkmU/EFgigtxy9zCe+0rhJb28mGYNqSotiKZRoEGFy97we
         JkdtdSlNpWAB8FD+Gt+wWXAK4oIsMvKkwb4yM/ZwcNm9JcGIPnovBYv69YZrepAG5Zh9
         KYCZpb45YdOVqRz9eLCmeNNQkWJ9G46nNVVeKAWgvz3ZGjqhQB5KEIXNIvNjB/uMlG6h
         21CQ==
X-Forwarded-Encrypted: i=1; AJvYcCX/CHpl7yN9tXgcxUGsDRDFwiWj+ZHBg/18fWorrr7aVvWKhCuUZQivR6D6E5QTwxZBIp4huTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxfs72JvrcGc9n8tTIGhVODnHMGNe8MWAAzxWEcMiGoiL1AdZNN
	ZodtxA7ptHicRuEwnu+BmsqRzE41NvyPgfeYjwfON2DdZdKBxOc+1AmlNkBoh+T4bn4=
X-Gm-Gg: ASbGnctVZdb/1zPg5OtRWifaSnQf0qNKzIGh1DCDdW4Yh2fx2meW4ImIF9tYmG/DaQj
	cM9WXVsuO3lxHkjy0TvNUmqy7/zExkCSs/0GW9AbOaTXjMyc8XK76DsjHdvA4Pa5TyIJ71Bv0Yb
	5nj0T005Nsy14ip32orYpk1snc9AA5boWAVdDzswlQlWVw3owHT0Yk3lstt0BZRZMEYSM9emtXS
	VauC3pOHK9Ia/fe/radJxrMGjLt/0XZQJ0DKEDAs2KyLW2ZxFgt/c72ax0cA7/H3bBZfEUfE999
	+3vvf7tro94aOBPgG7/ejt6vwEP56UfhhZyyeVF/hmeBs9DZP4l1kFANYJyUqPXaMZ9msTDsxw=
	=
X-Google-Smtp-Source: AGHT+IG4hKTQLow1Kg67H0QZK1tw9mJw0uWny6JBPFtWfdVzPOL4FEhBvhn/KJThkLj9LlPS0fuDrg==
X-Received: by 2002:a05:6e02:1c06:b0:3dc:7f3b:aca9 with SMTP id e9e14a558f8ab-3e135576383mr2032415ab.14.1751580965094;
        Thu, 03 Jul 2025 15:16:05 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3e0f9b8cdb0sm2167885ab.17.2025.07.03.15.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jul 2025 15:16:04 -0700 (PDT)
Message-ID: <1a3a5dba-b42d-4f4d-8441-ec34fb37d10d@linuxfoundation.org>
Date: Thu, 3 Jul 2025 16:16:04 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/139] 6.6.96-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/3/25 08:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.96 release.
> There are 139 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 05 Jul 2025 14:39:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.96-rc1.gz
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

