Return-Path: <stable+bounces-150734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76527ACCBCE
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 19:13:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0607E3A9250
	for <lists+stable@lfdr.de>; Tue,  3 Jun 2025 17:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13BD1DA60D;
	Tue,  3 Jun 2025 17:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RG7edKiO"
X-Original-To: stable@vger.kernel.org
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08EC81CD215
	for <stable@vger.kernel.org>; Tue,  3 Jun 2025 17:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970711; cv=none; b=igLaHZWzD0cwPGbYkUvKNqMusQn5tHhatiWIMTt0J1CTzxXBSZaJzQLGIo+ZgD7YbhRWOMPvvpP7YSTi79ExNHN0+1u/849pUUzf4bUANGbOMgtg+f8VQc+wSZvCGjZHbniwP5K8EPNrEHiwTEv35SRb3POCWr9cMtTTmawLzTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970711; c=relaxed/simple;
	bh=XYzDGnf3mKCdGs9+tHTXd4bAWYwkXt+9ly1lKcLWNGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AWT/oY6ps8M+AAlcJCNyvtYCOdIGHB9GeipJvlyfRqYrNNZSB3PsEK6BT47hp0ly0ing7OFqTUK8XtaZv3aKTfKcxsy8mlSO3tz7tP+gIGte7oA6xTfna3hkwisP0qqYXECcKF49zF+bUVVn1TKKl1ByyB1xkvv1aJUK4tXcdlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RG7edKiO; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-86cdb34a56cso128481339f.3
        for <stable@vger.kernel.org>; Tue, 03 Jun 2025 10:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1748970709; x=1749575509; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ddho11kBYwcIVoWA2nW5ayFJCxEdDqgwiaQXUL60Pv8=;
        b=RG7edKiOtSpt7X8mi9g3lN9yQfTLjfScGgc6reJ6adPHGd7Dz9AkNIpZELApkFqtDc
         QCDQOfWLu4T/hTxbpWZ6EKNhF4GFF3TUN0nJNVvLBWFpRsky5DNly5momn0mw7UHMyLm
         b5v6mCuAdKaENZSxJi89PJFpDqZSFqmYpy+Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748970709; x=1749575509;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ddho11kBYwcIVoWA2nW5ayFJCxEdDqgwiaQXUL60Pv8=;
        b=PHtZIR8MeTZXzNZyLWGU0CR6nt5PSEYdCDD28eiaVQJIzpDLJB42cxCB0VSGU7vqcJ
         Bglq1XKXtddWAgJL+KQebXxNovvY+Y7LoeBwGcjrWGhx94j4sj79H9rsHuSnjJSow8ms
         Ru1UiJrtANRt5P0C6FTRzceRwvUcp26i85xdXCF6/v8xQiGLC2shNTNyXmKhwoMxiE81
         mQvKZxDxGMB13QeS6OMC6hWl+TlwY376n6zLHtFrGk1J61fnMqJmAxJiKXexYG0mnNX1
         yheHNN0JKyQMb7MZByc0fkgHoCN1UR2x3hiln8oKfH5Ulnl50UsgOpw8TWEAPw+E4ThR
         Hc2w==
X-Forwarded-Encrypted: i=1; AJvYcCW1nbh+EuprYZL7tgkGGQGPw9Tj7j2qEIUs6uR+25dpvWtAEantOOZVdg2yAUjVTvHrE2K2hHA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwA138HaYTZaRILjTYIZdeRaRiZn66UOwIluLfFXkh8r3J9kxC2
	aNJzIaFIECn+SPs+OCOPLE+tgEJqkHx2+abk/SeANmoG42oR9RblVuRKw7XpJG20JP0=
X-Gm-Gg: ASbGncsbv3lTJabxlc41WTzqQxpabSn38wYtHoXZqHsXtCrKarTKTzBV7BGNjBmaMfR
	sjWdemAopkH10dKQJHPAYjWsjidU6SFsTPlNgCyBqntoGy8xDUPEzHOH+B0w/ptntErfm+h9keS
	D7b8xOXR8oVvVfTPzzpb4uZ7W1R9YcHbFqOubnr2QGx5jOF6pwBoxZkfi68RtKsdrF0R6FXmZqQ
	oeVnSALVuSXEMiCtwrZLbS2i5PQNRA390H0exs81L4sW3bImd0bsx+wHHbptuAHmLrn1f9DNmOg
	+NbxB1XlcAPcyA7UIBO2skY4yfxqshV/gnQDcGVa6iVBNxc1ERihdXAcwxJmsjn+9DzCuBA4
X-Google-Smtp-Source: AGHT+IFIdTophs/miB9/xlTl4jvLK4OEGz+hDmt2vEX1tqhdKuzEzU5rVnUz68MbL2Fv5abeXaVDuw==
X-Received: by 2002:a6b:5c13:0:b0:873:f22:f95 with SMTP id ca18e2360f4ac-8730f2210e1mr304766639f.3.1748970708939;
        Tue, 03 Jun 2025 10:11:48 -0700 (PDT)
Received: from [192.168.1.14] ([38.175.170.29])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4fdd7dff2afsm2340661173.5.2025.06.03.10.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 10:11:48 -0700 (PDT)
Message-ID: <7237061b-9b75-4bf3-8d47-4eaf456e8958@linuxfoundation.org>
Date: Tue, 3 Jun 2025 11:11:47 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/444] 6.6.93-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 Shuah Khan <skhan@linuxfoundation.org>
References: <20250602134340.906731340@linuxfoundation.org>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20250602134340.906731340@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/2/25 07:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.93 release.
> There are 444 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 04 Jun 2025 13:42:20 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.93-rc1.gz
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

