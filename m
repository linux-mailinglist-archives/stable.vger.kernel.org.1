Return-Path: <stable+bounces-131942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE652A824ED
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 14:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D836160C5F
	for <lists+stable@lfdr.de>; Wed,  9 Apr 2025 12:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA2225E816;
	Wed,  9 Apr 2025 12:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="fXqaPu4F"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244E221858D;
	Wed,  9 Apr 2025 12:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744201904; cv=none; b=hhcYGiYsUAQEWvz9Zmx+Z7JeOz0qg65SpTl1EhPN3bYoceKK+3l+a+2RN5pTb04uMMbpxpP3uhOMp0aRhwlaHi71EqbOw5Pu6JikakrRQ23ezCAQI592JXNwmi2E3d4QL57e21iM9qSKZbGX00p3+0V8p0eHOGQ4ijJGRl6IyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744201904; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G19nER0MV8OKV8BtT7Uj08e1MXiJFEFwezlNvTM/3axdccv/CzO9PtQ8kIzbgUFEPVn5kQetMcsM5aZRpXLJgJYpYVX+HX4u/ZhKnUVCybGN7NC9AEI0+H4OhX423oZEjjOqJyvrAPCi7ZjmnxjTEkjyCE6m4q5mGDRJO4f6dac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=fXqaPu4F; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1744201877; x=1744806677; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fXqaPu4Fpu6/nm6QEyAZAjC85NQSQs0PUALi+mkm/syWLchKtEmoLcQM82pjZqwO
	 oJcFolGGMkCdObsGFCtx8P/xbipZCNUJZxdoWc0wvEH0FW1dUEteLuDEIReSE8zQT
	 4RPaz3hXzJm8FXqgHQnBwp41zBAZdfDERqYaP6+Dm7uN0hR99qN8cYjEVurem2WK7
	 gZAyB3DT7IOxkf5ZJHqXfU3tVA+R7Ug3T3tCZSslNvFwRkS/Z/lIevPskL/mD9W3O
	 ItmZra9EhAMhaFscv7mNIt+K42WFebTEbDD/uz535bjU/zZaCjB5ah5zPp0h9inBd
	 KoNHgxWMpn0ZOjQRLQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.88]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MgvvT-1tQQ8m2PHh-00oBvK; Wed, 09
 Apr 2025 14:31:17 +0200
Message-ID: <1ab58338-d663-4457-a113-67ae2142a978@gmx.de>
Date: Wed, 9 Apr 2025 14:31:16 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.14 000/726] 6.14.2-rc4 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250409115934.968141886@linuxfoundation.org>
From: Ronald Warsow <rwarsow@gmx.de>
Content-Language: de-DE, en-US
In-Reply-To: <20250409115934.968141886@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:bORnGVt06sB2sVQc4wayjK/8AUsQgBOI5577Vn2o9FxhtGrsuJj
 oOPlKGbIA+JTqyVYVcgcKGh5HXREoj1Ll3Z7Yvr2unamPEzq7cuuhuhAkMKxknY503+aYQt
 h4kT9QVrTvdIB2l13zIlLd/BUHqhZMS+Wln74DOoxxWYxpxJurJDlNKKbMNJ9hXvS4/CJIm
 KY1s8culc8xgLOPuaSJQw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:G3NdtSYX7jw=;a2sz+NerWmd6+vjyZGdaotYGgsz
 MKvkse2qm7i6/nbn7yFA8+wne8zFMRjzbb1UX58GIjWBzaA+dzlA11PpcNpsldg2sK0P8MBKS
 6Npte8/3vzxNHuL93P2J29gSzw9cywFZNqwbkfl3Rk8PWIY4TVrngMDOr7QlAALaS/JiJquIu
 lT9mFqljkbYS1zSj65/ZOJai2aOex/DUM9czYHa5MM3P6kq04Qyfna4H41c0EnjpSdbcdrYyz
 M7+Bg1zo9GiqDgCSodX60/itxr7+Al1793IaI6DcZMFBBdLNfPhZ7hwsNffkNoIAhgoPYmd0V
 Yhs9uM2AR0TOHOu07oOF3Ba+pbFaXsCGej6U6UYX9BAI/Uc/aj0CT/XSJ0DzJpVtM0RcFvhdH
 7ObBAb8TmJoqnyQRF3YUSsFEC3Fr+Xdm5vSckzpfkohJ2OiPMSRk+UWJd+AnVhilTbc2vAjPd
 nS2R5mnNG/ydC8jt9bDkD0e0HWzImSG8vDBX01gSxxGwYnxRxim39TXWat7WF/oAsg41iwDFm
 XoYZkI1dZfsuWw0KIkNNl80x5r/uB+c8ZOlMfckWsdE2r4tebE9jf6Cy62Smj8fuNG78OwsRj
 aMpXwz8voHca4/l5IAUZKlp4ovHTjiPAggk/fR/hDPCgDONxgdexUMJcTlW5c3TuSoFb9xx1a
 wJ+UydWSj8aLXPFgPMJl3voc3yXlG4Trvcir4tu9mq8uDohJClCX+oo4osMR1ZZUMcIgd7Gwb
 tuB+7kaOey3Y+YgM5U//FUEB4uYn5+WS9T0z/qKrvTo3irUtkqZ/wt+g+/UDkRPzeBYGeNMUE
 oYrri0iz469TqayZ7YRm9NRMuh3m+INjnDkTmJ3QeaVliHxr/HgMzIims3UsYu3FHH2dmIJ4L
 3dB7Atc6MifFZOs5Y78N27YosXtxKFFDyrHCZpSnDIEwO02oSs8mvDaM33NWi9Fwocu2Ow7r/
 /B8Kylc6QaWjxnSP19bgSrsVJjAjp6Z49PU1957MVDO1Zd5qQ4bZZnyXFtnYvBw2LhaGenMqN
 ScDKb55ceYS0PIl1E+DTbPlbefNnvw6e4lj6QPFRfrqGBJNV6Ihpe+UfLqt5Si9Ac0F/eXG18
 IfXaijTN0/izjtEe9r9DlfWFYeU8VkcrATpVGsZDYv0YFFPtvEJ6XxvyjvG+f9PsaQ6IIh52j
 /g4jRd1us3MCvybFtCsyOwBdrCcLfy7NclruxhGtwPaZLof7yc1vMI0FYpm3mH66uQswSkqfE
 /fDZ8wnQYXiEA/JExKaMn9ewJCjoo4sivP+DfGVJbBro+XBhhCd1oexABrEry7yKwV0QyLIA9
 Ruf//NmKgW7yLXuw3F5Hhx8W0TNlHe/NFa+wGatg53uKQc12SkpLHxUO4cTQrFr/yFc1aksTw
 7XxJmAshVDpRSHixjNiYdgRn6mSPrFsmXXDSv1LCmNMRhS/G8ojSNb5kOiUoAmTTuqQUDAyr2
 Rnw5KYwLG6uryHuffrQcMJ46ALGw=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>


