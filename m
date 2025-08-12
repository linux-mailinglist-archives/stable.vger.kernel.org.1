Return-Path: <stable+bounces-169288-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6860B23A5E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 23:09:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B6A1B60409
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD18261393;
	Tue, 12 Aug 2025 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b="Z7bOETaj"
X-Original-To: stable@vger.kernel.org
Received: from mailout02.platinum-mail.de (mx02.platinum-mail.de [89.58.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCE523C505
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755032964; cv=none; b=qVMbpVJ7ZM7L9Pdp9aYiNMM4h0efExuNIDFJ2qB9QVoN9PE7npiLZvS7BTkiX46p7SfoCvRX9j03Vnf6WWKQqQxtrLon8YGSSyyVNla7aPeSPwh2jlNo+ySnDpj4O5R70y0riprL+cuKSg1IgW217i3QmbPLvkxGqEvqy7uLbVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755032964; c=relaxed/simple;
	bh=nlz94/12tGKOGIP7I3mDjoSbnHBOPTZwWTMcmg5RrJo=;
	h=Mime-Version:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=rp9E9x+o/g45EdLWi0E3G5/2/PtJnTTyyIv81tVQCKYMmuQvkOeb2Q27spIirzj8c/Tyw3+s+kDK2pPFHvp+i+XH7Om1DNCHSamJfbp6JYFv6GTmFWMPb1W+dTgies8XdeIT2j6kTD+X6a78cfkOYc/1HB6TYCkd4F/gvcS3D5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org; spf=pass smtp.mailfrom=achill.org; dkim=pass (2048-bit key) header.d=achill.org header.i=@achill.org header.b=Z7bOETaj; arc=none smtp.client-ip=89.58.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=achill.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=achill.org
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mailout02.platinum-mail.de (Mail Service) with ESMTPS id ACEFF9A2968
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 21:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; d=achill.org; s=mail; c=relaxed/simple;
	t=1755032955; h=date:message-id:subject:from:to;
	bh=nlz94/12tGKOGIP7I3mDjoSbnHBOPTZwWTMcmg5RrJo=;
	b=Z7bOETajqvAhvQ58ek6rJyB+11LjoeHvS2+OxoVIs4yJVvLqng4fI9xTChPxfLsp5oc4/Ux5YWt
	rrhGqTNhQmOhrr3KSVY842Xam0RmfBev4fe+TcrNoaFVzArguXnYLITg3fzw8HnINsKcsNmW1B7Fz
	+9rNqJjDOHu8y6Or1iqdm1SZPPROaZ4OuytugAaW5N9zwTTewQwF3vbr5Z90L9x6VabUDCZPSTodr
	dlqhuiD6unpSDM0mj945tR93UVlrRcOQDnZVDiOO7+HFmhhT7On8rf8XJ5DX98N3vmOMeGRDrqoBk
	8JGRK8Qg4rpg3EXA+6C+XQBCAjZC+VcXvUtw==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Date: Tue, 12 Aug 2025 23:09:14 +0200
Message-Id: <DC0R9CV2PQCG.26IYGBPDZBPR2@achill.org>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
 <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
 <srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <broonie@kernel.org>
Subject: Re: [PATCH 6.15 000/480] 6.15.10-rc1 review
From: "Achill Gilgenast" <achill@achill.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1
References: <20250812174357.281828096@linuxfoundation.org>
In-Reply-To: <20250812174357.281828096@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8

On Tue Aug 12, 2025 at 7:43 PM CEST, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.10 release.
> There are 480 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 14 Aug 2025 17:42:20 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.10=
-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Thanks, build-tested on all Alpine architectures and boot-tested on
x86_64.

Tested-By: Achill Gilgenast <achill@achill.org>=

