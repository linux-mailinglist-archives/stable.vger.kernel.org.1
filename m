Return-Path: <stable+bounces-119638-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C78DBA45916
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 09:56:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E48A1891426
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 08:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B6F0224238;
	Wed, 26 Feb 2025 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="PDGQGBiz"
X-Original-To: stable@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9BD224227;
	Wed, 26 Feb 2025 08:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740560196; cv=none; b=LxyMRxJlb86opKANZDiX7HL8flv/YcxaXD3EmOcZ27dxrGud+3WZYpJBpybwCnuAbXrpaaAQ4QEZJjFAoxso9jE8uoTXZy7XYlDgQZ0F7K+DkaAes7/3qkQVKBjxMJVC+FHjMb4COl3UQU8ZysTKLI5lKmvMlHY5MQ3JMnJPbR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740560196; c=relaxed/simple;
	bh=lapwsaYN/6a8avn+z+sqN0WLDPLDIRMiUEwq5GkoaP0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Ut6yKUUodU1Y2LliP0iVLvI/LexAAoFT0DTfayfY7wgoNATvRghGWdOnL4C+HehN/lcn3NfPe26LXoNYbLBY3vMaWxMfouKF+sgjrz0x33PAk8OgW7eoEIBt5d9l1GjqUsqk/hHONc0XeXxaw2a/xjD41rgx8EcDZdkigQAcA20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=PDGQGBiz; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id 97C467D32D;
	Wed, 26 Feb 2025 09:56:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1740560185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AO4dus6nos3/M4bgaC9Y3FCL/9dfTCqU6L18Mmc1suo=;
	b=PDGQGBizWHjHqqErDtFLxXfrn/cXL4c0DFVc6v7WzWpV33LYdHhFdkyGnSbWB2541jOTC/
	xZq73KuaZVhjAY2AynYlt3F4CStYybnkbr3XSL6MJBUvyo/FvuaI4H847SVk1vZIw+05yN
	WUQuMjRq1KmtN76pC+3VERHTQTdoZBo=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 26 Feb 2025 09:56:18 +0100
Message-Id: <D82937IUEK5I.2KBH1DI5WI8XF@pwned.life>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
 <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
 <srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <broonie@kernel.org>
Subject: Re: [PATCH 6.13 000/137] 6.13.5-rc2 review
From: "Achill Gilgenast" <fossdd@pwned.life>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250225064750.953124108@linuxfoundation.org>
In-Reply-To: <20250225064750.953124108@linuxfoundation.org>

On Tue Feb 25, 2025 at 7:49 AM CET, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.5 release.
> There are 137 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Thu, 27 Feb 2025 06:47:33 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.5-=
rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Tested on Alpine Linux without obvious regressions. Thanks!

Tested-By: Achill Gilgenast <fossdd@pwned.life>

