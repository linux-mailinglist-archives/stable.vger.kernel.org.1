Return-Path: <stable+bounces-118517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38D34A3E610
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 21:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C3347A82D4
	for <lists+stable@lfdr.de>; Thu, 20 Feb 2025 20:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51EC213E7C;
	Thu, 20 Feb 2025 20:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b="b4iQDpzK";
	dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b="NHwMntY1"
X-Original-To: stable@vger.kernel.org
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76A31C6FE9
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.129.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740084397; cv=none; b=avG9ZbGTT+9V1oHu1VpjE/AdfRsHwogFCwf9DFzt/31PJWbrvjscApMOJVS8NkVs88hmWa1s6P/aQ5/ZYSaGFFcI9ldU04M2brXV/S7HhARK37HvLEC/2DcH/zveHn5HOJO/3P1j/Qt+H/pfrGPHb3EZriYmHDsiZG/VxQNQpfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740084397; c=relaxed/simple;
	bh=EXXbsELd4TnDhPR+oLxmC6mb4dDV4YYCWuYKmzQgrW4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOwged6kb1k8U2uLHxNH5aHjiI9a2QhLopkC35qlAfMIpOqCPQXnRdeawRtquHU300EGLagBloyrTwyJiWIzLKrB+eEW7jXIS98QCNpJH3YKOBDjcizxQKUb9m/DSm0P6mcjUt8XcD038Yt8O21joaFMFPJGxmhw7FMF+Xr7WO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net; spf=pass smtp.mailfrom=sladewatkins.com; dkim=pass (2048-bit key) header.d=sladewatkins.com header.i=@sladewatkins.com header.b=b4iQDpzK; dkim=pass (2048-bit key) header.d=sladewatkins.net header.i=@sladewatkins.net header.b=NHwMntY1; arc=none smtp.client-ip=148.163.129.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sladewatkins.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sladewatkins.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sladewatkins.com;
 h=cc:cc:content-transfer-encoding:content-transfer-encoding:content-type:content-type:date:date:from:from:in-reply-to:in-reply-to:message-id:message-id:mime-version:mime-version:references:references:subject:subject:to:to;
 s=selector-1739986532; bh=MWhuwPKRWHuBZzoHcb+oOoXnrhWEnQoYXYXKtP6logA=;
 b=b4iQDpzK7Qt0irFVVmnSEieIo7FsIkqKYnOUsZi2ej5L2FXEEULlgE5U2bExNSOVRIBTGIyhaeUlYzDAbMTgAgwWmcf5sKckOezpRyYoFBBAeNxTtJLVi3OO+S0/ZwnXwE5Z6R1gq0bBYw1bu8CyCTuIvTGk4SQJURoU1+u2YI8N3fEajr/8pniN93JOO+ovNcTjS25adgOC7p5ZHzIpBxfkSRclJc1i95Lx/pBFd5TDcpXlhq1W5ViBLk5EzjrD2+2GmnxEtrXofR7Wh/u/hPFzbxzDpbWCEt9NRv46dVKrZnHmCG4Cz8JaYok4Se01uYCY8Kp48xAaajf8WnoTcw==
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E6064400158
	for <stable@vger.kernel.org>; Thu, 20 Feb 2025 20:46:32 +0000 (UTC)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-472107c4b5eso25686201cf.1
        for <stable@vger.kernel.org>; Thu, 20 Feb 2025 12:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sladewatkins.net; s=google; t=1740084392; x=1740689192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MWhuwPKRWHuBZzoHcb+oOoXnrhWEnQoYXYXKtP6logA=;
        b=NHwMntY1o3tbflOqqZeLVQShutpfocudVOLx/eQhwBaZeFepdPIPBHX/G8fEqbB/rJ
         bqaZPqxfl19LLVfMO/+Mpjgspb9V2T/guSe5aUb+/YSzkXsCgl7/lsX5MdSYKLwOHKi5
         DoAVtdkoFr/gXVwspdVY2ZeC+PXaesmri6AHxKnW0z3/eHs7CpJBXA1Izc0iUDD6CsLp
         USYpJBvPMtj5wpShbM0dB9trU8jrl3fgg6m+CR9YWJWMz81P/M3wEdR521I5X4+oNdcn
         caGY6B6lFX2zIz/QBY1/rRW/nF/q+dF9qvLjsFWQqXTVZtavh/fL8Mtw5JUQ/2cpZW+a
         hLsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740084392; x=1740689192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MWhuwPKRWHuBZzoHcb+oOoXnrhWEnQoYXYXKtP6logA=;
        b=pOoj8vgWQkFqaQqBRb6KiM2Wl7+uyVrF7IATFla6vmSN+c2sjCtvSihApqg5uEJWp7
         qB4uaQfPEACuUrPHrvOzWFSkMFQaCElKPmvO/HcLHKIBcUMeiQUr0hFiVdTKCyyh7TN1
         Wm8x87OC9N03DbgXXihBfF931ABxTYA7ANqgsy81cQ8G1ViPz/HmMOWb3GtwZxoREi0/
         NiCkWQ5UQpa1GfMnHMno6NndJyNrtMWApJ2FfxhwW/XT9LwP19nEA3XXJy+p3MLEUq1K
         LxOF28NMJ0g3Z4fYvbIZrEOC4b2X1kJBM/q0B4PRdg48Z9Y8c0aqv0BoVqUn2ySuIFEL
         fJGw==
X-Forwarded-Encrypted: i=1; AJvYcCVdhpS5y2gFjOQKMyuZyzDnDRd4A4ni4f0RdnSd4ru+XUPZL+5ASiaKe0j2Ld73+tZB+WuT4Vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfIYkTQL7rhw2rzLfQqWhkIw71lEq0+ACB3rUdgTF0Fmu18bU+
	BENvAhKZoANfj3v9L5L4r78YxHESfQyxeeMdEiZtPhNBYLJXuoWo8uo7DE8G5YGm1R1m3Bal8VP
	IDsjH2hYXphKpannR6XPF+3w8q2hUTalYbLviNbB4++alPP+MR6cHH4dKSw0O3PM4s2BrmdnQTp
	o=
X-Gm-Gg: ASbGncu/xOFY+41sCpodr34WKwRcOph3CR7jMBT/57HAtIji/ub8Rh/NTLQM4/zJozT
	segiQqXk6guAvEakMGFL9qUVIs9FLl+wYeb8PQhZjFVyjCvxtdaeqQmlPGkBfqCFD/ZBcZ43ZTq
	Zmt1IG/6FAut+NSP7bktZXh6RmpHBf9RjDmjc3Bl7Sy8VHkGL3+XQs3ws9tG8WpufgpLIAaUl80
	rDZlH8SVZUiPZyURJ15SPnEYZxEWaFG+5q08P1zyrXNomDUR3d23B6nBsBRiOgr+31ca9WN6wSc
	0RhCBQVlg1ng56rqVNCKteM8tPcaLJDLU5tQN1CwtYOGogZDV/Q9bRyHpu7ArQpWmzli
X-Received: by 2002:ac8:5d8a:0:b0:471:fa00:fb9b with SMTP id d75a77b69052e-47215028ef8mr70119371cf.7.1740084392168;
        Thu, 20 Feb 2025 12:46:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwIrdDUc97c/BKbB21dPMuIBxKNLN7eS9xsTKAR4FBChuikeOlqXnwO7mamsv7/7FKtD0kyg==
X-Received: by 2002:ac8:5d8a:0:b0:471:fa00:fb9b with SMTP id d75a77b69052e-47215028ef8mr70119061cf.7.1740084391862;
        Thu, 20 Feb 2025 12:46:31 -0800 (PST)
Received: from [192.168.86.34] (syn-076-037-141-128.res.spectrum.com. [76.37.141.128])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471f0eba93dsm49479581cf.80.2025.02.20.12.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Feb 2025 12:46:31 -0800 (PST)
Message-ID: <7e94a24d-d2dc-4f77-b2ac-dc900552ec90@sladewatkins.net>
Date: Thu, 20 Feb 2025 15:46:28 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/258] 6.13.4-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250220104500.178420129@linuxfoundation.org>
Content-Language: en-US
From: Slade Watkins <srw@sladewatkins.net>
In-Reply-To: <20250220104500.178420129@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1740084393-JATpSlxE221j
X-MDID-O:
 us5;ut7;1740084393;JATpSlxE221j;<slade@sladewatkins.com>;3898a0dee3d557fa468e7fbfdd1a7683
X-PPE-TRUSTED: V=1;DIR=OUT;



On 2/20/2025 5:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.4 release. 
> There are 258 patches in this series, all will be posted as a response 
> to this one. If anyone has any issues with these being applied, please 
> let me know.

Hi Greg,
No regressions or any sort of issues to speak of. Builds fine on my 
x86_64 test machine.

Tested-by: Slade Watkins <srw@sladewatkins.net>

All the best,
Slade

