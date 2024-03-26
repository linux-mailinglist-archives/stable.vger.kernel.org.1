Return-Path: <stable+bounces-32351-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 660B688CA60
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 18:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174A81F82B51
	for <lists+stable@lfdr.de>; Tue, 26 Mar 2024 17:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373048528D;
	Tue, 26 Mar 2024 17:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eB2ezHa0"
X-Original-To: stable@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE9D8526B
	for <stable@vger.kernel.org>; Tue, 26 Mar 2024 17:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711472915; cv=none; b=WSntn3aKPf6cbh/3l/lSqveKAZ2pckAVn+tQRU7iX4uywHHu2bUsQRkcL1WqdWycOq2DosVAbsOaMUVFXBJ6klcsfbbIc+W/kQSjgEQCz6gRP3fRwl0WcI7SDXdLf1GzO2WvbVH+Yt12SWr2o6tPF5KSStxnrCh04lhImOW+f4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711472915; c=relaxed/simple;
	bh=a3GRJTyVtPaora8i9TFnln9ovQ9cDRnFSNqM2n3wIXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5AbFiyL7EjU6cR3wwd5G90XUusnCaQD54ol/LsNFdntR+pFCnsZJI1yAJ0qqCrNIQ38nINho5viHScejZQz/5WdMwFHMFbZec5hT9L/aPkcWwS5sMyje/7hnXScVexn8xfcbTBQDy2e5qD/a+YNYVPnoiMyE9DYGRjZDR6zPZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eB2ezHa0; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3688f1b7848so375305ab.0
        for <stable@vger.kernel.org>; Tue, 26 Mar 2024 10:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1711472912; x=1712077712; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BBqHB53pAWBp1T0qlQ8wQNsdw4RtYHLdu3JSmQ0g88I=;
        b=eB2ezHa0Iq+uYyMotaEYa2xl/u1774kPDiSHX+QeiZ/K1/gCeDgakI2H254mDMlXg5
         DUlqlb93ETgI0diPo1fT10k2Jv5I9XvrgSSZTN+Z/0ddpMbx1fKovNSHdACxbucyMLFW
         QmGclUhNI/5NsKfj47KeWoJUM88BpvIrt7n9Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711472912; x=1712077712;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BBqHB53pAWBp1T0qlQ8wQNsdw4RtYHLdu3JSmQ0g88I=;
        b=j+ZlRTVvIHsJ9w7P0YysVcdRAndzu4Yr5eOfcTwW16i5nuh2CCiQpWD67v1vxCDrWV
         VYjdNSOEsCuWFyA83IjBAL/C/eKmRzaJ+NeEJGhQ3SN187Vppc7vkx4mqPXeQ5xO4/sN
         +e/qVprFRqNTZJxGaC3XN5cMp5scz3I2XrGbTk1rk2WHETRGfwd5y2xNZkOBcOA6ZwJ4
         OPWwDp/8Bln94fkD6Xg+enKZEd68t92fftraxV02WBK+7oGfPBUEsYVf+QVTAVYw4PbG
         To91YhkBfT7ELarVoQOsvLiIeS6fJEdzUEU58jwpi0j2pukuzSpyRPEwUIulFRfuXmWl
         bWqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjsdZyDTRwjhbuu/oOkdsQVG3rL9jXTDd6han/EBTZPLFRhcOWhKKWy0aDq4LqSa2zDesLnGcp95WygzXEHE3vdtKzeG/h
X-Gm-Message-State: AOJu0YzgMFte/mRjvBAXpVI1/8wU+5HwdngvFUzRDBtsu5V8Zq9UW+uX
	QzQp1gyHtYEXqmSYKYf9Ochr+oMSYixYrxEaiDnSOLVH9vKkWKKyP+kSwRyGQOk=
X-Google-Smtp-Source: AGHT+IFpDE/DM7o8b/z0YlYs+qLFUH3WJqjCOqigf2riKsDgjAvrpcxhI8f09vf2rXtDTdZAi/le4g==
X-Received: by 2002:a05:6602:88:b0:7d0:2e1b:3135 with SMTP id h8-20020a056602008800b007d02e1b3135mr10601604iob.2.1711472912498;
        Tue, 26 Mar 2024 10:08:32 -0700 (PDT)
Received: from [192.168.1.128] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id a22-20020a027356000000b0047d6ece7413sm450480jae.102.2024.03.26.10.08.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 10:08:32 -0700 (PDT)
Message-ID: <330ade13-2810-46f6-bb94-2718547a9597@linuxfoundation.org>
Date: Tue, 26 Mar 2024 11:08:31 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/444] 6.1.83-rc2 review
Content-Language: en-US
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, florian.fainelli@broadcom.com, pavel@denx.de,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20240325115939.1766258-1-sashal@kernel.org>
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20240325115939.1766258-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/24 05:59, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 6.1.83 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 27 11:59:37 AM UTC 2024.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.1.y&id2=v6.1.82
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha
> 

Compiled and booted on my test system. No dmesg regressions.

Tested-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah


