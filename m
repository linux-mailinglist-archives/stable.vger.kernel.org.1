Return-Path: <stable+bounces-123127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BDBA5A4FD
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 21:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C408016BC2B
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 20:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B561D8DF6;
	Mon, 10 Mar 2025 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="jcqFhnZI"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9D41B87F0
	for <stable@vger.kernel.org>; Mon, 10 Mar 2025 20:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638669; cv=none; b=AHeJJU18WSmXXRLL8jmWyU0p6qbyIWMzRPxRBhu+PKl9yh+UHuSU/XjQhs5RYGVKwJc8VqtbgBNGKRUqnFPlfGuBCCKa3hpGiWJ2uZSQV7ku2usxrOiA067J2XmuoqLB2ckKdEO6GHjf2Rj2veRSI/fPP0A24BBA5bEoS4M1Spw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638669; c=relaxed/simple;
	bh=8gNPWhlGr3JCDKf0zqb4PNCZ9i0jmUCaAmb6qosXVnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VhObU/XgpMhT9OzkR63GCFMd5fT6vgGMsZuKyQxN8dFBURC1iRCLulBaAa4E9dH+Srtvzzz/FUXPU++ITJg4CEXucw10/eZ6yjGOH1ERVJEtCYYK8K9w/iaBxlj6EN1pwhOkn5DJ6QJyqNM0YXKEtgn2IXeiTDn3yhX5Ph3Kito=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=jcqFhnZI; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1741638659; x=1742243459; i=wahrenst@gmx.net;
	bh=8gNPWhlGr3JCDKf0zqb4PNCZ9i0jmUCaAmb6qosXVnc=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=jcqFhnZIzz1oBMZi0NP3k96zYgn0lGw4bI8ahRPR6UaKZ1Lo6C0GOWVY4zf2zFoU
	 YkZlpK8/6miH2cwmvu1Q7ICmYDdPdMdhPH3pD+wzJ0LzHU+vEMPT7ZtzNrfIaH9fC
	 604gmrRO0h80m1bpjiEIxCNXtJZq5ZKakP3QcU7pnPKwvfRjzPUtmhv155c9JE4dx
	 Je8+Nz+s6u25SWwN0/2o8J2F14mboA5g3nG9/PGVoFOkva4zg5pmGkueaiVwge68Y
	 7nPkEwQBbzQbVUh95rZ6AO79VXw96CUxc9l6BSCkaeFCqaj6YBT2xI/KNirbIRNPa
	 EHaC4nRVB3SThuqFEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvsEn-1sz5Hw2Bi3-00z06S; Mon, 10
 Mar 2025 21:30:59 +0100
Message-ID: <5980c4f2-00cc-4381-8ac7-4c3a01b4004a@gmx.net>
Date: Mon, 10 Mar 2025 21:30:58 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [5.4/5.10/5.15/6.1/6.6] spi-mxs: Fix chipselect glitch
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Ralf Schlatterbeck <rsc@runtux.com>,
 stable@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <a83d17ac-1d17-4859-b567-fe2abc8638ab@gmx.net>
 <2025031033-pantry-schedule-e9d9@gregkh>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <2025031033-pantry-schedule-e9d9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:t8mDx2CwvRzCHugXrQiAWIzBRVDYKPGaU/nJAhYOAcLtx7mA/6b
 TPko/8ahPMeQHg+A2pdmOLmD8gU4LWd6JKiSdocicmOvlvtNbHD5TBh9li6USDiVhWBtUjs
 IM7vTle1hrrlb8qi919PsnEK5BLDoDHiuw+12/u23BHiR9WednD462Zc+hWpFXkAOYqJZy4
 NMcVxCQBfAY2P1AFLYD+g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Nlr/egoM1o8=;g5dz8RwwnW0uSttzGl4nc9eWeMC
 Wcch5aVyzugfz+gplubQ67fc9rmN2cSc4VKkD4WUZRANKN3emLXjbfQl7U8vDW7AIAeQeLEIY
 SALgT0KeQf+1lCykpz97YEeMK5Juty4wbVlL+rOX1RaNlTSLiI2e6YNgmTKTg4PW9xPtnssO4
 jmzrM3J6nG0f8EdGWfsJ+vAqvt+a6piDzvkkGPkGgPFZa4Lmrj2EfF9b93oOUPOVLEJd8BTKx
 SPVGV130Jf9rYyGATqR6QZqHJStOdO6dBZhLTwYgCz7U4Qii5FDlJ6rAJkrxJLI4vkEZtUskH
 pEExd4yyA3TVKpt7pGILbDeDS1GjqXxPWIu9UttbykK368TUua6ewv/fbgszpubAFcKcAnb++
 N/Mt5sLh1HoSkl5nPN+JZuvv9bBXVJ9ACiakAlYw7MbIDDlD5mqwdQjw3NxSudtbonKXnKOxN
 DOdK4Bc2YX9YZtw18BTpV5DBHky1W2i1Ipyy8zt9qCNzkVWcbOjuq9xf65/nVjNshGsglrHxL
 3ELjwnQvqNGY8MVd/WUmVeGCigPB/U/bGp9B4hN9JE+1P/bC7ZdHacxlY4/bUZfNTU0/GTeue
 N5PvihawGQC/0MzlVq6EZ60xSe95R7K8cuZn6RAWDVtYu+7cOJ6mKxji/bGqM2UAC1pHuV2u4
 N50srlDp72IetjZaEEZe58+inn/83adoSSMGqFCelvCk0MvflDUN6MZNZ8/7GYZa0l9UvK9qb
 j+xuNypZROSzlnZDsC+U3RnJHVoFYF911TVjd0hyxlijeonFR6ruFZa2hD6SyPn1Y/qs+idiO
 vYyyUVD7xY6iaK9qXWEyOtdXVeK+HihF3c3hEQYJ6ALkbpzV4CS7jFHL/dU92VTpS28DFRgwu
 029TUcHoATU2waIemqP0iFCMI6ulyInMFrTzkq1Jg5chgWwotc+9d/sGQXQP4VKiz0HatYqNx
 ucJMlbh9vrSlXG3ORvrK4P1Lt1mbbWqusyqcERbDftK9+Qz9HuwbQgRarXeN+eqslCMoXPbwR
 CiLGayXjkZ6mj45r7wRM5bFbUyM2xEbXhrWfgBS4dQJSA8WIUkVfn9M9Ga6LoJCzUc2uUn1fH
 JppwUEBj9gd/U0pNYCkK698q/BkcT20W862PxjeIbtQexPFSTVfB0P6QYJ4FGfqGg39YhXnff
 DG0pYtBFiJV+o2imjr5sxd5XJV2G3A+A6HWAzxGH87+6igTU2rSON0vAxLnrzaSo3U44b8eDZ
 bF4/mQijk1Rv3dlCFPNCohMARiI0oF6tkDezFpCvUVwT7EvkNgNjE7cZK1l9/f0jnZZQqm2Kk
 6WO923oFvIijiVbvduJCaZFucQfL/hIIvtBsn6B40pUplGvxK4ADIjexT0wwp7ZzLBK9zlRxt
 UliS0OVwPWrVXYa7YGLrEMHWgebNO56M4bk73yp8UATsDiB+By364jM6qO

Am 10.03.25 um 17:12 schrieb Greg Kroah-Hartman:
> On Wed, Mar 05, 2025 at 11:25:01PM +0100, Stefan Wahren wrote:
>> Dear stable team,
>>
>> I noticed that ceeeb99cd821 ("dmaengine: mxs: rename custom flag") got backported, but the additional fix 269e31aecdd0 ("spi-mxs: Fix chipselect glitch") hasn't.
>> I think was caused by the lack of Cc to stable. Without the latter patch the SPI is causing glitches on MXS platform.
>>
>> Please backport it from 5.4 to 6.6.
> Now queued up,thanks.
Great!
>
> greg k-h


