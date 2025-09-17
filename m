Return-Path: <stable+bounces-180435-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E422B8190D
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 21:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CB954029E
	for <lists+stable@lfdr.de>; Wed, 17 Sep 2025 19:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9599F332A46;
	Wed, 17 Sep 2025 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b="benAjWNm"
X-Original-To: stable@vger.kernel.org
Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08993233F8
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 19:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758136482; cv=none; b=dMrKzLT6J1FPVddMrDBfqj8m4tXJIlaIoX9ez4KQP9CACL5LZgrVOtLIaCZq1qS6aquIKWLKXzptYSBPG3Mc+e6uEdYPjA2wsXdsPfH+3ftzrnTYJdWzqEJJwrCEN8/g4c61EnwX32k+DVMnCsc63Erxc5dJQCagqtLX5HbQzms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758136482; c=relaxed/simple;
	bh=e4+uMr+jK9MjVCUf13Vcm10orDiY6sPPMMsrDnuNaz4=;
	h=Mime-Version:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=fsq1pzppuoCBdzH9hJpQUPK7sxYJbbCILDOqgQYL8sRIXjvLTaLMFDByGkAD2TgADCin3mTIE3Lutq0CxsJFNpgtemUFoUu08evXz/lIWrwVrB7iNAC/tDgrsRdA7iRt9u4W6KE62gS4p/oTvCNZd1mE4Ldp/AnKGM4QH3amN8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org; spf=pass smtp.mailfrom=achill.org; dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b=benAjWNm; arc=none smtp.client-ip=89.58.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id 5A8FF9A292E
	for <stable@vger.kernel.org>; Wed, 17 Sep 2025 19:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1758136093; h=date:message-id:subject:from:to;
	bh=e4+uMr+jK9MjVCUf13Vcm10orDiY6sPPMMsrDnuNaz4=;
	b=benAjWNm+xrzfUO4QFHi+EseWDJm/N87fcCPy/+elvGKRsPsMRjwtpuZDaFyIjQ2sHaQvwZJ/Cx
	RTS+racLuez55ElZMMXEkKT06AvRfgU78R9vCQfwKt4RrEb62jnKA1sntaPk1u4iz1v4rIkdTv6+5
	u1tcYC5s54Uj8QZNP9SXPzSoBZ1dprhPGzb9HYLappJXUpfP3OKHIsBJjS9JP36dNj7pV005dCaFr
	co3qlAGSbiwiCC6mejxfyHO7SUw5xdb+LIDCDnK/Xzg70vwMGSaAKtmTNMR67Qv+I43OrEVeCOa6h
	HJ2Yx2MOA+OWwV8Okkyop6N5ylA3o0AMl3RQ==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Date: Wed, 17 Sep 2025 21:08:12 +0200
Message-Id: <DCVB8AY7VTYK.1B8UFEG97596N@achill.org>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
 <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
 <srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <broonie@kernel.org>, <achill@achill.org>
Subject: Re: [PATCH 6.16 000/189] 6.16.8-rc1 review
From: "Achill Gilgenast" <achill@achill.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.21.0
References: <20250917123351.839989757@linuxfoundation.org>
In-Reply-To: <20250917123351.839989757@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8

On Wed Sep 17, 2025 at 2:31 PM CEST, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.16.8 release.
> There are 189 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 19 Sep 2025 12:32:53 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.16.8-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.16.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Thanks! Builded on all Alpine architectures & booted on x86_64.

Tested-By: Achill Gilgenast <achill@achill.org>=

