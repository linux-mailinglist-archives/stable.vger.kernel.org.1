Return-Path: <stable+bounces-210140-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A819AD38D74
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 10:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FCAD301EF90
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 09:43:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7055333436;
	Sat, 17 Jan 2026 09:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jPS4ytmo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WJ33KxMb"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A151684BE;
	Sat, 17 Jan 2026 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768643034; cv=none; b=f4Vjo69buQmghmy8bPc88Y4RWKNZdjJfGEXo4kHcB5VLVjwWnJC7mWmqJpHYJN0uLCWJpM9iXpg64T4puHvuJysZ2FBTtsdFJPzGnPlihh8s5QdI4XA2uYXKBnip/z7rTxcmmida6WthQxJlNxSoeob/HztPU3r1WFHvlduPKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768643034; c=relaxed/simple;
	bh=SUnlxxwwlQCfug9SMMV+tp7b1YgQvtN2bQLZ+AqXgpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bI3LEoOcuuu0IrirQKN8ayVwlr/M2MeSemrpCvSTfKRIIWZIszLlAqAf6lk/9gVx1f6CZwoQwNxpkFgvjLDY0QL/p2a6CcUmWMuj4EZj/1fvEhCv9oO4f+QRXmvw/IKbOrvdbmpFqBKK2hHSNrKoWWopF79UpKPKwpf5+EF51mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jPS4ytmo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WJ33KxMb; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 11EAF1D00479;
	Sat, 17 Jan 2026 04:43:50 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sat, 17 Jan 2026 04:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1768643029;
	 x=1768729429; bh=AB75+ehpmJVu2X5wj/D0uqTDaB7fq+rVUrPzQx/5eW8=; b=
	jPS4ytmoT+jX2jWvjKLBSdIUaskyk/uHRb2JUYOR7B7F+Ytk9jOiHHUdTw7jGQmx
	0AW15jv++bs//Im2hjWZE5HZTVYiqHXV3GaV/AS2Ym1ZK5t6NKPkXR6YNAm5X8LC
	KyHuFA6RnWHosqQJqfiY2pUfa3LUBFDrGgSTw82FVJ5QT7N7kyHvgmMv6kbGVaWX
	Q0FQtNPG5X2VeQSPBiMVHpJRdkLHlZWQeAT9DCnloYF0D4L0HHqC1ibnoTo61RYN
	uXKFEJsMWaVecObDt1E6RXmbBVie6SwcCtXqSMUfA8NbPZxbjx+AxY5Q8feXuJBM
	Y0/Avy8YH5yX5loR6XC3Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768643029; x=
	1768729429; bh=AB75+ehpmJVu2X5wj/D0uqTDaB7fq+rVUrPzQx/5eW8=; b=W
	J33KxMbkmgmYyqRQIm150MytAd6f2jpAXfDENudg5Dgmoq3aO1nyMvvchSXhnIC2
	KkNUGiufqhLAnxtprLJutrJMFOK9342EUSsyLMweI+BrzM+c7//V42t9IeHw4Tb8
	hoKUdEC94uJanVPSPtZCH+AvbpvJhJcile4B8S4txEMhl3wezfEhNYRL1T1Q8jmm
	Tqmdn3Y5ze6E7NjpvSroDnNw6tCj/jKyRXsu9ElTUCsQUYoxo6RIvS6XabSM77+B
	StSlzcXkkTrTfZuCIXb/LCdY8hiur044OpHPHBbHcv5ziSwaUoW+oEIwbOthJhHu
	OBxFXm/EiLeWgtdpBFFEA==
X-ME-Sender: <xms:1FlrabRvLH6jYjLQrfVbK5FZQgh84uIoWGx34IdN6Q8ZBgR1t3IaaQ>
    <xme:1FlrabIxqgpFubWa5P41Ck1pXZbhfjGmWAUAvoHW_89yWKpYGYx20I5JR8JC-nXHR
    AQXMbhfUNnivdMy2ZwkzPjIfk0f7qL15zsgjukQCYIJT2axu3sssw>
X-ME-Received: <xmr:1Flrac3NoBqyTkeQ2yx2WVlf-bqxchGNB3gDHH3X9Z09vDkkEUxYmDnHtKNxtRRR2u6nFht2sMY3t-OqeSYr4IWh9i4zHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddufedugeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpedfuegrrhhr
    hicumfdrucfprghthhgrnhdfuceosggrrhhrhihnsehpohgsohigrdgtohhmqeenucggtf
    frrghtthgvrhhnpeefleehkeehleekjeelffefhfdvleejteehledtieduffevteffleet
    gefgfefhjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggrrhhrhihnsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrthgthh
    gvsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgush
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghkphhmsehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigsehroh
    gvtghkqdhushdrnhgvthdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehprghttghhvghssehkvghrnhgvlhgtihdrohhrgh
X-ME-Proxy: <xmx:1FlraeJktQ7-borY8IvFDY1aFADoLBrY0An6SYUYa12ERVR8lgUpNQ>
    <xmx:1FlrackhAUJ-yeFUVCE5lP_QEj6gXj8XcO2EjXJ7CnxpQNXc33YalA>
    <xmx:1FlracOsMFx24UoxfGkf_2h3zGdZWJgfZ_pKx5PBOmOPS7_cLxPsDw>
    <xmx:1FlrabzObtjkaKRGBjk_6qsRvapwJLqiI36Co0j5cAHN08wZJHfaVw>
    <xmx:1VlraUPPNvPXOWxf1MsA_TUy5PCeD-q4HUMjTJvAxUYi05ikBTvM0L0A>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 Jan 2026 04:43:46 -0500 (EST)
Message-ID: <c283a0c0-abb7-49c2-aaac-5b24c44361b6@pobox.com>
Date: Sat, 17 Jan 2026 01:43:45 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/451] 5.10.248-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260115164230.864985076@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260115164230.864985076@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/15/26 08:43, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.248 release.
> There are 451 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 17 Jan 2026 16:41:26 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.248-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

5.10.248-rc1 has been running fine on a physical amd64 system for 
roughly a day now, doing several tasks including running some KVM guests 
(also running 5.10.248-rc1 successfully) and compiling other stable 
kernel rc's. I can confirm it fixes the virtual console regression from 
5.10.247, and I have not seen any new regressions.

Tested-by: Barry K. Nathan <barryn@pobox.com>


(As I described in a previous email, linked below, the 5.10.248-rc1 
fbdev patches allow two additional patches -- previously applied to 
5.15.y -- to apply cleanly to 5.10.y. It seems to me these are not 
important/urgent enough to delay 5.10.248 and they could go into the 
queue for 5.10.249.)

https://lore.kernel.org/stable/64874115-dcc0-4f3d-9a82-2ad2abf86fbb@pobox.com/

-- 
-Barry K. Nathan  <barryn@pobox.com>

