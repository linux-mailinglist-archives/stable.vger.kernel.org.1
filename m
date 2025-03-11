Return-Path: <stable+bounces-123504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE30A5C5E3
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 16:19:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B397E189CEE8
	for <lists+stable@lfdr.de>; Tue, 11 Mar 2025 15:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888A925DB0A;
	Tue, 11 Mar 2025 15:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="fH4zVI3k"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03B37E110;
	Tue, 11 Mar 2025 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741706148; cv=none; b=fZOAly+WbZKuzbkEOnOiIniHzCiPwB+jhXGX3D7an/xTouqJ1lAOZ8YTk7d6XscU/iUmK6m7ydy6ap91Z90vdScyEWAYKz2Xxs2+dVjwsrC5kMzbuy0SRM8o7NA1uAXhzKj4Eny/oTYDf3+KPL5003Nc82n7mgCBl+3lY7irfzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741706148; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uZlPYDsIM2QF5rjJwI9ZqMIg6RaJY6uLjkuF6gTWrifhOVcCi+wlah5p7uzhm5NTQYbCCt9qr5o5APFXVMWA9dhoJ0Ql8fvfkYN5EfjYBXz9/nFHGp9W8xq1dVvyvwKvDp9w0PDHlC1q3AvIaiN9iNOonPoks/4DqyKaffnTd70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=fH4zVI3k; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1741706126; x=1742310926; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=fH4zVI3kI6XIc19fwiwSeNsWGSB2gy1m8YYiPUnOn3sJv6Ew86o99x/zyiB7Hqv/
	 cdGocUAYYNIPULxbLrWlA7L3b/bwn9fsXZKdy2AaMsN5TYZJW0xGV9dLfetYRyztr
	 Ln+gcb1N0ZgINg0/6dsJ12Q5gj0Yc+758Ncg7bHXereZ+r88SMolvP2d9bwu5VVkx
	 MffGuNJrT1YEbdorKDQPe/8/3tjLSedtVS77EXwxugSHmSszcF5O81h0Fd+42X+C5
	 oGtGyfMjzbp6NtdmE7ELUvAVfi6Ux4Pm1g88QHKKJaQz34UnIVzM7dwnBtcX60toZ
	 okXUV+kb9yHd3srsUA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.32.160]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MJVDM-1tcYsA1qAK-00RmpX; Tue, 11
 Mar 2025 16:15:26 +0100
Message-ID: <f2ea4017-5a57-4fa1-aa73-90b3bfb699f5@gmx.de>
Date: Tue, 11 Mar 2025 16:15:24 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.13 000/197] 6.13.7-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org
References: <20250311144241.070217339@linuxfoundation.org>
From: Ronald Warsow <rwarsow@gmx.de>
Content-Language: de-DE, en-US
In-Reply-To: <20250311144241.070217339@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:vTh0HqMWvP97ZqYVTQnETiTjR4dbW50Q3/iHpaWoQOc1nz7Jhs/
 pfwhYsRt0FiYmhy5pJGe2LkSAMPaVOv0lkcD69vVZyREpK7jqlFSdYV/ptUgafIXyLve1sH
 yUH5UhX5H/HLOfrA0SCo7cAusrYznslTvACBk9Ancz3ldcZEYV6QQIh9G273TRny97T7fU4
 lhBRqyOBZQ0qjQvDbA+OQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YMPeiVQDR+Q=;KSuoMgpqlYg9R+ln+HdzfFom8PU
 P++JvP7awCR86BOe0QepLLFH/h74LohQkPC5GuPYOtTnUho2H5wxkHcBqa2hJ22HqV3RoU/Hl
 WSrgG62dl6c+ThpnrMCMsF6a726voxKJZQXUDS1gkHattw6LS/5kiaEqQ5VJbIfCgQGMUFbW6
 PbJhW7FyYSU7kmBG3na799G9KLECo239WiiVF2lLz4W+Fl+WEUDxhe7Zf9yh5tC4dztOvdqq3
 29HXzRjexs1OoVKtk4DMgT+tZ0JNbNb+KYYO6DcpM4Sx6onXfQLkTivSgoBRCGHfpPYothpKc
 tqah1scPQiHCKB9zf3Fs2qYduF7tCISE/BZ2PGFME1Ewb/p0SW6SCgd6BEBw6w24qhx59G0Qi
 412twVa5tvFNoAedS61m9XdHdJx9XVwHtpVdVP/5a2bFv+G2RUieLb+sgDLYbTTE2gVlZgbzd
 T1BmHKqoqpzgGdg2TwpGbaqFpBxHRDDoL7RUjZW8GhrhdQqoBue3hzPy8VmUOaehVlDMQAd7C
 QqhMzphoAlG63dv7kXCFIDigNscC4/jsPbGVFbYS/fFce4UP8rEjZI+mb/HOy3RknBYtSiyBR
 Ko7j6ORtSF0Qh+k56g4MER5785OWo49kye0sYvuEpmwcZbmyASeag7kseY3Ypq8Xb8iBSnUxR
 C91VoY2P03hbrOhWv7xBcLt2Sv5q6D2dMryLGExrmkOxigxODpxEzGiEv1iCQJdubV/h0ECUA
 5z7XNq/8HkOHsX5Kq2CnDy1XNykEpDcAHiA2+BW2m82nY4LtYhDOMMpSMWr5kztfUjUuVc6/a
 6zJiXxg1kn1ZEtqx4udSg5kN4JYbScM7gLtssBZ7jngytgSP5P7esWIRadpdnb012fdmMQ7iC
 J/wttx1uilIveU/D18Lk3eZjYQ0HwD4rY1mcIvxykn6GKbBOE1521uVcgb0WMz1Sh0go/h0Ny
 JAbdowYLL9U4Fi7AqBhgaHe1pCy/Qdt00Q+ZyMoaGWoJABs2ikRIAQ4m7UDLccD0rZYx6a5zQ
 1bkBaykvRHPx5SHdWkl7GPl91MQsrnBMeizzbEZTg9iF3QN3da7p6YJc7eTSHuzkQsNsU9sFE
 hIPkfl2GsC6Iw0IqkNFFGVZb6Bkbeseyr4tdx8jDmJxValXyFWxRf4decegYBh24teLKhIvC4
 YXpnnOXkaj/vPHeF8SG+Rv2nBmjdJ+u44JRbfDpq7lu+7WVc8Ux3Afhqe38CHQPJ+eT2sQZG7
 4idDPPRWsMr89fCGIB67kcyxAJWaaRg3BeFa9sPVC4l7wu1pLRbhPtaV1ETt3ZIVGMTv3eDaA
 emOk/SxhcgoP0l83bN7Sef0NuAtVUCxm2En+56DhGmMxk8uTWkK8cJeQ3TKdssjyStQ6ScS7U
 VRzFbUmkjGuDcM33YmgsFi5ob5SqmA/J5pHTk6KdeVXiFaJ8g09iWHcAzKR02ZUR2tNt0d8L5
 F++Ww2v+59G+W7anijCa28JaD8OA=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

