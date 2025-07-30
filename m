Return-Path: <stable+bounces-165573-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E14CB164FC
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 18:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276223A66E2
	for <lists+stable@lfdr.de>; Wed, 30 Jul 2025 16:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A392DFA31;
	Wed, 30 Jul 2025 16:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b="nrhQbFst"
X-Original-To: stable@vger.kernel.org
Received: from mx.nixnet.email (mx.nixnet.email [5.161.67.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E72DEA8C;
	Wed, 30 Jul 2025 16:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.161.67.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894081; cv=none; b=Bmqa/RvfXRsEZX99QcTZMXz2IgR4diAcc2CizV6xb6TVbtqD7Ur9HTLaSeiMaFw+sYkqZ9jnN7c6tTnW9rJeKcESzl3secuwhnUVfkQ0/e6jU/VPyuVaKSBYRFkS9j3rESPfTewpmxKp5Qcv5Ew0lyLl93UbnKCIYHE1N/In/N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894081; c=relaxed/simple;
	bh=27cNGqR2HBCGoB0i0kCeT87pItI5N86fPkvQOIBnvb0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=nNCoYV1/FAHWh2KVp77GzlnoqnzdUfJItFI3x2E+4wpeOZ//Rr6YQPF8beaxA5QuqGaHDTXQCpCzYSj2fZXAWTNyNni0xPug92jqNS05EBGu9MVyra6sBW5oom4XjW5MH6z/aIClFjEiUptsGN31DMs3YqRP7RziLIOlF97awIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life; spf=pass smtp.mailfrom=pwned.life; dkim=pass (1024-bit key) header.d=pwned.life header.i=@pwned.life header.b=nrhQbFst; arc=none smtp.client-ip=5.161.67.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwned.life
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwned.life
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by mx.nixnet.email (Postfix) with ESMTPSA id BDE617D32D;
	Wed, 30 Jul 2025 18:47:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pwned.life; s=202002021149;
	t=1753894071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkPyu4Og5SaPSLjRik/W2SWQQu0//xaih98MCg9FLPA=;
	b=nrhQbFstZTjveQuaniMkMaWAjGVyPf7yUTjSekuldt5BFYmnEJ9pUrMx2ooT+aYgG63HXP
	SLYIh225XjYbSkNyBiadhNhAZJ/anzx6YyQXkUMTVUyLLTK011HdX+JloXZeBbmU/q/fur
	KTUVXntQ1lX942PL5gwo3Fx5BsgMun8=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 30 Jul 2025 18:47:47 +0200
Message-Id: <DBPJK39WD6QM.2PN6V5C26FSUY@pwned.life>
Cc: <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
 <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
 <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
 <lkft-triage@lists.linaro.org>, <pavel@denx.de>, <jonathanh@nvidia.com>,
 <f.fainelli@gmail.com>, <sudipm.mukherjee@gmail.com>,
 <srw@sladewatkins.net>, <rwarsow@gmx.de>, <conor@kernel.org>,
 <hargar@microsoft.com>, <broonie@kernel.org>, "Achill Gilgenast"
 <fossdd@pwned.life>
Subject: Re: [PATCH 6.15 00/92] 6.15.9-rc1 review
From: "Achill Gilgenast" <fossdd@pwned.life>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <stable@vger.kernel.org>
X-Greeting: Hi mom! Look, I'm in somebodys mail client!
X-Mailer: aerc 0.20.1
References: <20250730093230.629234025@linuxfoundation.org>
In-Reply-To: <20250730093230.629234025@linuxfoundation.org>

On Wed Jul 30, 2025 at 11:35 AM CEST, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.15.9 release.
> There are 92 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Fri, 01 Aug 2025 09:32:07 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.15.9-=
rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git=
 linux-6.15.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Tested-By: Achill Gilgenast <fossdd@pwned.life>

Thank you! Builds on all Alpine architectures and boots on x86_64. No
regressions noticed.

