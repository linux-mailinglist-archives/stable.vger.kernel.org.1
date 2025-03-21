Return-Path: <stable+bounces-125696-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1926FA6B1AC
	for <lists+stable@lfdr.de>; Fri, 21 Mar 2025 00:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D97A7AD7DC
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 23:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F120822259E;
	Thu, 20 Mar 2025 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="fNgr/Eey"
X-Original-To: stable@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AB321577D;
	Thu, 20 Mar 2025 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742513416; cv=none; b=b87SvYQJCjwcDuvKknuBYR4GzvJuphHLmz4yBwqyoyXQ0IqJvaVtjPIXvLXEwln2rceQlI+wpuFgdhEnDbSRzNY3PYy79fWsOIcSvRWL9X4FjlKe33eMI15Wxy/geiIuuvIBOGYKk92FQwFyf1d0AXBnLEfqNhHbZBsf3qfMUEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742513416; c=relaxed/simple;
	bh=SYuzpk+px42U3u0B0b6aH3gUKA150zqr0yAGUPT6MkY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=EIHi+g+mRx+Wrl+lBZF1iKf7DFHzb5SELvB3mripUrYE683mZ6EDtjyqzLSnmi1r5qYq0qoDjPyje3lJtZqzQQP0F0W7q52EMpOh4bUZH5bKtAP2TuWI4y7k2y3gJtfB6tsW0LffrBWD2Z1/mhJbpf3TUqFD2IqkmUAYnHWIeqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=fNgr/Eey; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id 9B1CD7D2E3;
	Fri, 21 Mar 2025 00:20:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1742512842;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=avCcyNinvHxHfLjLW9hb3JXsotFCmyMou6TeLSEEHuA=;
	b=fNgr/EeyA5/GxyI0wJjivl4bb8ZmCHEPa55i55BX2qKVnKZeg+Esbl7RXBWg0Xbj6NLhtZ
	A2hbvK7Jiq11p7YImesnNkOcnLNN5KT0v7483mBWXzpedppBPcPjIaTFaiBVJz4u5r1vtp
	h/UXo7LB2+A/35wbor03NjRvMyVJ65c=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Mar 2025 00:20:38 +0100
Message-Id: <D8LH8Z7F0IO7.210MAQO7ZF8DT@pwned.life>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
 <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
 <srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <broonie@kernel.org>
Subject: Re: [PATCH 6.13 000/207] 6.13.7-rc1 review
From: "Achill Gilgenast" <fossdd@pwned.life>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250310170447.729440535@linuxfoundation.org>
In-Reply-To: <20250310170447.729440535@linuxfoundation.org>

On Mon Mar 10, 2025 at 6:03 PM CET, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.13.7 release.
> There are 207 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 12 Mar 2025 17:04:00 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.13.7-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.13.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Thanks! Builded and tested with Alpine Linux configs.

Tested-By: Achill Gilgenast <fossdd@pwned.life>

