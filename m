Return-Path: <stable+bounces-6558-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E968B8108CA
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 04:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A21F1F21B1B
	for <lists+stable@lfdr.de>; Wed, 13 Dec 2023 03:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04D2B946F;
	Wed, 13 Dec 2023 03:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="PrOdtmp9";
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="S8DFaLiu"
X-Original-To: stable@vger.kernel.org
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3537ACF;
	Tue, 12 Dec 2023 19:43:48 -0800 (PST)
Received: by nautica.notk.org (Postfix, from userid 108)
	id 9F3D1C01B; Wed, 13 Dec 2023 04:43:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1702439026; bh=UrKlhox60uGLohgaxY79+fFkJthdoBHo15vb6K7U5+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PrOdtmp94HQBa6JPqH/g58XIY8nszdp6O5q36tKX8JrxRSPptUV9ZCBZauXJ7HVJX
	 PMB0jO4t2wpyihLu68M9CEWFMxZHw8AM2M7YGo/b9tPddSgfYH4rkIR8zh4zLnK6sU
	 f0A78NIfXAvcqESXpfho20ar5rC3v88SbOcORcSja8iqKNp5mgZXUENTOZWwh/sgwm
	 mw5B4+mliOcq3Sv+mj1ZJTiRKPNERZ7XnJgU/H4MDEvXXLXgzSD05AEbVa8kbC5NbH
	 TL73LQx2PeG56spQ8Q3lyMNOMJLxNPTXXrxzhaI6OigVpbkAgk+CW8wQKstURHOdYq
	 yG30T8XZZjxQQ==
X-Spam-Level: 
Received: from gaia (localhost [127.0.0.1])
	by nautica.notk.org (Postfix) with ESMTPS id 60CA8C009;
	Wed, 13 Dec 2023 04:43:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
	t=1702439024; bh=UrKlhox60uGLohgaxY79+fFkJthdoBHo15vb6K7U5+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8DFaLiuaLbooMkwxcLBi6WBNIlmW3sCXRBVaf8PezEwpgvyy6ObyI4iWQ0epBE1I
	 mQBQtbe9gf4GX5zZXdjiW9Scsk9p8IqLwGHotUY9/GD5kpWnyDZVsaUwDWEDsDCaWr
	 xKEBRXmkmRIGjcOP1EQ508w3VKLhJLorPDLxjrEaSq+bB9kiJAeyNNcHq0O5Cmj1V/
	 9iHramo3q+nyTI0OKe/yeKdfpEZYIwzCeuH1MGBq/X+Y68WL1kGuNwRDy9wNCptN4F
	 3U9ppGHWHPwbmUQdE60qnYNcNE9BXbUXeM+HhAxnN/hf3wH+pwwvoqkVlX1i8j9Pb9
	 JR7twfXwQXz7w==
Received: from localhost (gaia [local])
	by gaia (OpenSMTPD) with ESMTPA id 4bd87644;
	Wed, 13 Dec 2023 03:43:36 +0000 (UTC)
Date: Wed, 13 Dec 2023 12:43:21 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com
Subject: Re: [PATCH 5.10 00/97] 5.10.204-rc1 review
Message-ID: <ZXkoWdKza5SLvjm0@codewreck.org>
References: <20231211182019.802717483@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231211182019.802717483@linuxfoundation.org>

Greg Kroah-Hartman wrote on Mon, Dec 11, 2023 at 07:21:03PM +0100:
> This is the start of the stable review cycle for the 5.10.204 release.
> There are 97 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 13 Dec 2023 18:19:59 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.204-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.

Tested 670205df0377 ("Linux 5.10.204-rc1") on:
- arm i.MX6ULL (Armadillo 640)
- arm64 i.MX8MP (Armadillo G4)

No obvious regression in dmesg or basic tests:
Tested-by: Dominique Martinet <dominique.martinet@atmark-techno.com>

-- 
Dominique Martinet | Asmadeus

