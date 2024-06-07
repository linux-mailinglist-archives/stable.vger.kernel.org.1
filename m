Return-Path: <stable+bounces-50005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB02E900C75
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 21:28:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4149DB20F25
	for <lists+stable@lfdr.de>; Fri,  7 Jun 2024 19:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5854A149E1B;
	Fri,  7 Jun 2024 19:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="+/VDFziM"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6281411E6;
	Fri,  7 Jun 2024 19:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717788504; cv=none; b=YIDtCbin2PAfRoTuLKJ0DLS8EBiyx3k6ES7+arEQjlU3zjFEHgjc5HCpn/ydP3g2SU8bWvaicCUJFNxLzi+4iTDUSFzFAD2Gumi5ujgBTYpW1jv7QF4aE7V2aOVwECAs/JbhJ6ATypEUW6Fr72zFUTgFXD4CbuunY14IqGUHfHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717788504; c=relaxed/simple;
	bh=8tFFewtxiNJl4QWYW9HaQx4nW9OdtE14CT7u3e+Uc7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RtJloO2r/hwT/N9RG+eO2vccxZzRxywU89+bZ65D1CV0vNUXo1aeqE5IOcbqUZUqJOKSoKgszZzAL2GERXNcurv7wl7Q2kyEE/EQN+eroGoPpyC9RgXTXCJbFrQ0dT7aFGi/17cI9whlS8VSoXICQqBokmFi/H8ZsAliUO2w2ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=+/VDFziM; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1717787980;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dDMS8z/DLgBUGwZOqSNT0EYKzfW8+6Nh0L0qT3Gf348=;
	b=+/VDFziMv/YtrNTbgDNNiPHpSwl38qJAiMyVHYfAvys1JzuDRgge0X67dluiiZ/zPvPx2I
	DMQ3LkTFL5ijRKDQ==
Message-ID: <a2e931e3-fe92-4419-bcaf-ec61d3a5a68d@hardfalcon.net>
Date: Fri, 7 Jun 2024 21:19:37 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.9 000/374] 6.9.4-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240606131651.683718371@linuxfoundation.org>
Content-Language: en-US
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <20240606131651.683718371@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[2024-06-06 15:59] Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.9.4 release.
> There are 374 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 08 Jun 2024 13:15:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.9.4-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.9.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Hi, 6.9.4-rc1 is running fine on various x86_64 bare metal and virtual 
machines of mine (Haswell, Skylake, Kaby Lake, Coffee Lake).

Tested-by: Pascal Ernster <git@hardfalcon.net>


Regard
Pascal

