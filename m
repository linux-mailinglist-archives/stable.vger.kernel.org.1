Return-Path: <stable+bounces-160272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F680AFA245
	for <lists+stable@lfdr.de>; Sun,  6 Jul 2025 00:03:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F1317B437
	for <lists+stable@lfdr.de>; Sat,  5 Jul 2025 22:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706A429A9ED;
	Sat,  5 Jul 2025 22:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="VI9ywYDm"
X-Original-To: stable@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 312621F3BAB;
	Sat,  5 Jul 2025 22:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751753026; cv=none; b=qE7gMl8gKHin9il1CtjzWR0DjT2nb8QP+pfholblcM8OWqcc3Wi4RO7rFhPzj/17pLr1Na3F6GvtH1Y5DqMSSu7sFqqXe9vJFNSAJe7BDA0QkVVkB2HTa9H4ciL9Q4MW9d/UYqSakgZR8MJmMcxwRlYdxz/ffsDITBXDJAHzIwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751753026; c=relaxed/simple;
	bh=xXFbzOnfC2CrpRZVcn+5wjfcfrhkHDNHpbB/bf2AZHE=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=FV+yCS3tjzcJX9nagQocrNyzqhftnalZHVEcVPr97ovRM+LmCoxT22rw+haJMrlSdjlr82Yidq9bxYz51/n9A9ymSbrBqjs/hA7uOP5qA9HghhQplrYkPxLJ/pZcjb3AZpr5gN/dfgJYkFSHoCDpivq4fewj1yEl3+2Iak62gv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=VI9ywYDm; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id 949237D326;
	Sun,  6 Jul 2025 00:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1751753016;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EtDtuQnQikM7M8EfskxhTrdIYkPuTWZBEvcAabOWCLI=;
	b=VI9ywYDmyG0n3lSa9/xQGfWsWOCiCr7z630MIjcQficlzVvWyA6FSF+3B16FMvr21EWntr
	RkxGPKqe03zJt5+QOZbKQJxgb3pe+nSzUpC5MfE1pUG1Y2qGwtfA5UBvmWHhs884GoNbwN
	GQJIhWtcAucuHfQec4En3mcFLlOBOKI=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Jul 2025 00:03:30 +0200
Message-Id: <DB4GM7GOMKLR.SIKNZTPSOZJI@pwned.life>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
 <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
 <srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <broonie@kernel.org>
Subject: Re: [PATCH 6.15 000/263] 6.15.5-rc2 review
From: "Achill Gilgenast" <fossdd@pwned.life>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250704125604.759558342@linuxfoundation.org>
In-Reply-To: <20250704125604.759558342@linuxfoundation.org>

On Fri Jul 4, 2025 at 4:44 PM CEST, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.5 release.
> There are 263 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun, 06 Jul 2025 12:55:09 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.5-=
rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Tested-By: Achill Gilgenast <fossdd@pwned.life>

Meow, thanks! Build-tested on all Alpine architectures and boot-tested
on x86_64.

