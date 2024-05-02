Return-Path: <stable+bounces-42942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D23C18B94C4
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 08:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72C8C1F22952
	for <lists+stable@lfdr.de>; Thu,  2 May 2024 06:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D7B41527BD;
	Thu,  2 May 2024 06:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b="u+9HfPLx"
X-Original-To: stable@vger.kernel.org
Received: from 0.smtp.remotehost.it (0.smtp.remotehost.it [213.190.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C673B8C15;
	Thu,  2 May 2024 06:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.190.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714632072; cv=none; b=MjQanTbvZlHStKvtNVVGFq+RWeVGXjPMJenCBtXtU4kuTb2cNIQTguR8epF4RtBxM1YNpuM4a7TP06vT3QJ9+wu1UJVfAmcmT5SWwBsKDwj/OEEwy83H9ZDErPjX0fzevU0JG8GwbA4YP+kb/JeWZhZT9XdJ6LEMVAfIg+9i/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714632072; c=relaxed/simple;
	bh=y16Kulm7GuIB4w0cXKXc95gA3DzzCvHJ4ghEutGBNoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dG+7+ulsIjSC9wShWSkgfiy8lyphuF8IJlFz+aLVQVpOnU8LkAhBPOztxZqCws9kx+8pjyVwNq3xoetFgPJZnmR7/GZK3AsaAZVNlCqPJKxkkKRIiFxpn1e+2SDdMqYjhuqhyH1t+j/ksSzedaM62a2YEh9FiFKsN6jCC21Ze3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net; spf=pass smtp.mailfrom=hardfalcon.net; dkim=permerror (0-bit key) header.d=hardfalcon.net header.i=@hardfalcon.net header.b=u+9HfPLx; arc=none smtp.client-ip=213.190.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hardfalcon.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hardfalcon.net
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=hardfalcon.net;
	s=dkim_2024-02-03; t=1714632066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=10wXGK1h2+gkH0wUgW6fYCI4MjswRALv+lI2lWqR/MA=;
	b=u+9HfPLxQcb02xn6DyAByDQuCAqXs3Id4LBWnHxNpvzcDKg8iIhYJA5YvcSEc4hwCUTdyJ
	ejOYvMEIsf+FafBQ==
Message-ID: <c565faef-bf23-4704-a3e4-b95abd964e35@hardfalcon.net>
Date: Thu, 2 May 2024 08:41:05 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 6.1 000/110] 6.1.90-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, broonie@kernel.org
References: <20240430103047.561802595@linuxfoundation.org>
Content-Language: en-US
From: Pascal Ernster <git@hardfalcon.net>
In-Reply-To: <20240430103047.561802595@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[2024-04-30 12:39] Greg Kroah-Hartman:
> This is the start of the stable review cycle for the 6.1.90 release.
> There are 110 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 May 2024 10:30:27 +0000.
> Anything received after that time might be too late.

Hi, 6.1.90-rc1 is running fine on a TP-Link Archer C7 v4 (the SoC is a 
Qualcomm Atheros QCA9563, which has a 74Kc MIPS core).

Note that I have *not* tested building the kernel documentation, and I 
suspect that building the documentation with docutils >= 0.21 would 
likely fail without the patch from

https://lore.kernel.org/all/faf5fa45-2a9d-4573-9d2e-3930bdc1ed65@gmail.com/

Tested-by: Pascal Ernster <git@hardfalcon.net>

Regards
Pascal

