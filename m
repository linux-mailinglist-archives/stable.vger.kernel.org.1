Return-Path: <stable+bounces-52258-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03889909599
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 04:12:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29EC21C213DD
	for <lists+stable@lfdr.de>; Sat, 15 Jun 2024 02:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14FE579F5;
	Sat, 15 Jun 2024 02:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VOEDM66y"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB86553A7
	for <stable@vger.kernel.org>; Sat, 15 Jun 2024 02:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718417553; cv=none; b=FAuTiOK/4yKAJXSw25XvV50uobwiDHbHWNLjyrjWfuEbZlbVk39rvMxhQlbhJfu8GQOSilvdcudX3G0fKQ6A3w3LVP1YCWT09YmBsLpAQKj0H61zV8zmmKrvWHQ3TfzpmlpkXpShw+ByCnJVcIV/nPW+tpnPTWBoJU41zjGY+QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718417553; c=relaxed/simple;
	bh=ZTDzit9m2Jocp58+PuCzOgmogp5H9se3hT/QvozYCaE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHkR3FIcN+xfWiZLdkKQs/0JbZfQWanlDsUZA15dqBA8Mj+jLcrlJFsuqHwKMf5Mch8SUJGd7VnJtRQMaTRl7DImUYrBhpX6NTIuuppV68oeP10uXYrvj5GLP2YKoNZicD8zSxnqbO81F3Oa5XHnBNaIxqtZPlo3ookCw3TpZ3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VOEDM66y; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3734052ffd9so1187495ab.1
        for <stable@vger.kernel.org>; Fri, 14 Jun 2024 19:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1718417551; x=1719022351; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qzaIS2e21jTfUCx7lF1LxmffBmnXZpD+ytV59MGze3E=;
        b=VOEDM66yqmkxGD0v6SgeC58crP7KljYlsHcI7jabEZOqe3QB06coy+d9f7x7qCXlrk
         hQy56WBJHVv+fov80vj443dmO1MjMerubaDY+/dqp5nWjdTDQdD8qJlNy0oD48CQfxeG
         3gTnvBl6CJwEaSFj4I0QXKrXxuYoFntO+eHVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718417551; x=1719022351;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qzaIS2e21jTfUCx7lF1LxmffBmnXZpD+ytV59MGze3E=;
        b=k/UpWx4bwz4y1B/yRaa4jLOLyHz9u5Oeoibl879Yg7wZCxiB4G+H4ohv5zJ/SlFs2J
         uGVdYSumte4mxqehTbtfh2lKPkA0xw2ZsQNAgtU2+TWsK9IOD948ntQPktCzaRjsLx56
         Pexd3Z8xS8ewGQYFWZWHXDPBAao7YdJzyjYKLdxETClynSXDGyYUQwLQxJNXBmhkY2MF
         jW19ifKo62Xn8brCqVveeHqvcYbJm4Mes3kU8POoIkeSlKZR1NPQJkOCNzM81/BJLFiP
         D5EnrXyUS/Q0MpPa9/F61M+kWIokCQVUMc3/YLOu4xvyCOaG1v4BqYCe39tK9YSUCAW6
         P3rw==
X-Forwarded-Encrypted: i=1; AJvYcCXxeF6zbuxCS8oRCN/QxHIiJdVhM333olTCYe2DgwxGEAG0lDu5BODvjJ6Cwa+7vyb/5ia4ZH8y7YGan6Xl+TUXHxly1QlU
X-Gm-Message-State: AOJu0Yyv3QA2+NwmNz84bHAV9zNQ4i9shHBDxsUdtJjzXiIjMcMp9qxB
	zwldl0FdnvZitxcJJ6syQGbpI2UVz/2yINyjGzdcQJzsRbiZqGNZHXmnadQPfeM=
X-Google-Smtp-Source: AGHT+IFRrImpDWCJ30WC+mrE6R+ULQBANeb0E3WYgnZ3y3tWMl89V06RdOLiPBqmflX1FqRQGWXUYw==
X-Received: by 2002:a92:b703:0:b0:374:ac6b:19fc with SMTP id e9e14a558f8ab-375e0e0b4a3mr38441165ab.1.1718417550872;
        Fri, 14 Jun 2024 19:12:30 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-375d86be155sm8824275ab.39.2024.06.14.19.12.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 19:12:30 -0700 (PDT)
Message-ID: <9e3c4cb4-1110-4269-b44b-fc5985ef0d1c@linuxfoundation.org>
Date: Fri, 14 Jun 2024 20:12:29 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4.19 000/213] 4.19.316-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240613113227.969123070@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240613113227.969123070@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 05:30, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.19.316 release.
> There are 213 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 15 Jun 2024 11:31:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.316-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.19.y
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

