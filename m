Return-Path: <stable+bounces-118677-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2026A40C71
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 01:57:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 729F07AB506
	for <lists+stable@lfdr.de>; Sun, 23 Feb 2025 00:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552418C1E;
	Sun, 23 Feb 2025 00:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=empx@gmx.de header.b="TeOHdiiH"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06C2747F;
	Sun, 23 Feb 2025 00:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740272258; cv=none; b=N25I/zkv9Wh1+kKMbLwJ5DBGWQBKvFFFsBixl5K+KV0cS8HkxuEQlhyY8vmCLvn0aNDtbmwokUc0oF9qcPp5478ILqGAzC3uNgDiYzhaNVJyC148ybZJDqNdp6+F4imhKDuMUoi5/BJaiYZ06gPD7J37ODPHw1+y/0GTb62vDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740272258; c=relaxed/simple;
	bh=24FyHwbbtE3R+lcYLPvbsuj0Xvo9HyC6yPeoSp7wSMg=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=GQoqOybBWk9oQS1HVmh1v2/wiX6gCteCz0ftvibmIL5LpAbUDwIC2Erj+bzePr9hf7J6Ejuasx5nenlAmCsZEd11zwHYh7C2oXlkqTxsraq0Afwq26bOLkU9+t9Bsnp1HFOaG7iZ85WxH1OFJppT2fRX4t3o/HXjb/vsr89qcXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=empx@gmx.de header.b=TeOHdiiH; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1740272253; x=1740877053; i=empx@gmx.de;
	bh=24FyHwbbtE3R+lcYLPvbsuj0Xvo9HyC6yPeoSp7wSMg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=TeOHdiiHiOcNLJiRtN1KTU/bi3/vIrBftOSRR1e+jpZ7SN3urD3HDZPmpWRp/GS7
	 n1j2EMxjI4ki3CLJgLMbZbqvp+4T0SsGW/xPUBvL4hSenPeIV8INhWqMFsv0kaQrZ
	 PI+nFgPPEtl8uE5D/uM8GhMdJAxPFQjGzit0jSXICg5nFRQpqHlziRYu18DoTYwub
	 FWsVv60rHEOEOIbhn8LKvRtUL7wUh+DIpB/ZKWh1jYWpDKJ/7SQC/X758+f0P0aY7
	 tKrHyUOuIdqt4wKPiGHHQKnzqhKn9AjEcd9Q/bkSpWxixo4kInymsw/f8zaSSRHxo
	 mANJKXMEoP6QRWpOAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ep.spdns.de ([185.94.38.157]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MF3DW-1tWYtR3LCK-00CT7a; Sun, 23
 Feb 2025 01:57:33 +0100
Received: from [192.168.0.50] (M1.ep.spdns.de [192.168.0.50])
	by ep.spdns.de (Postfix) with ESMTP id F13BE1695492;
	Sun, 23 Feb 2025 01:57:31 +0100 (CET)
Message-ID: <6ae5e229-c440-4522-a9d9-7581a7e0ce1b@gmx.de>
Date: Sun, 23 Feb 2025 01:57:32 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: sashal@kernel.org
Cc: davem@davemloft.net, edumazet@google.com, hkallweit1@gmail.com,
 kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 nic_swsd@realtek.com, pabeni@redhat.com, stable@vger.kernel.org
References: <ZrkqNUHo5rGKtbf3@sashalap>
Subject: Re: [PATCH AUTOSEL 6.10 03/27] r8169: remove detection of chip
 version 11 (early RTL8168b)
Content-Language: en-US
From: =?UTF-8?Q?Michael_Pfl=C3=BCger?= <empx@gmx.de>
In-Reply-To: <ZrkqNUHo5rGKtbf3@sashalap>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:m/H3/ycIJkKhix3kp/7EI2Al0yXtcINkCPsd8yM8fV+dZ5MKXSm
 v21VFFNPwokF1tFN6mLkTMQkWaBPpRaqvu9LNDxUl8X24apc+cAg87at27SdmdoQ4o6uLXb
 LpyOfh1XYbRLyINVbg2BX/ekvAzGVna/aP+dQHfRmsGKpcb1IIyjPkAMY2GZakAsfSDOVB5
 scECA9cIhIEGlMxv5PxBA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gsRDtAsX0Fs=;DAQCA6NFkp0a2N1jp3LC/UmwSrv
 oUeJu1TemMoW1qEd32mu1pr657s5bhBmLTg8MdXEiq5DzrysM4N+fGjqFa1MoP5H2E7sfvcjY
 l7GGtcl8C4kxxXLS5oOuEW28sPovU1fHRvDbfufoYC0Cvysb2cjM4Gq0CNO93z1UK3Qpa+q5m
 R1ooPxQJQDojYd/ZYNaOmxe1kectjqp69c2LZzKXd7wQJXllTD+BPI/jy0ApGuC6G4sy1agJB
 gJUurGog/yejQtmsZeUnJfb/AhY4p4PoVThCW029P5rf05CUXE9ZvMeK/3lHxNxyCn2upaEtm
 Wuqi8WnT0mhYYLzY/Xml/wQFjmn+WPyCudegyxZHm7Jv6e7dbMSd9ypaBT0+eiziG3fMPCbNL
 347Hhx59RVfNz7f5WlNme35qAQ+xzOp7hCkqggdbTIIkQu5A1RjfomYHFlbDbx0cD+k0lh0bE
 +qYhc91tcgVor5+r7kvvdprH+DHIKpsdVrj+FB2y/zHoU3d70rxh1v6hShm7zv998qzBZoomx
 QEAz+qI74k3sJ3sBdR8vU/LLVlYU1dzmxm0mmJ6hTNN8TmkdGKf2VMXCfsMA5jJcBSFPhQXXM
 BzyPlbTrcC9Hvq16ORbAOZIcVwAfgL7CUPM98B2g+hAJRA5mDoN6TveJQrdfYiIaushy99qnE
 saiyUmSd/TujoKD1R0hn8JCn0SlGMXniHbLTL8G6FOoIb2KAtrOchDrj/++T4+AT5fcf2DFj5
 +S0nPh/xQEuZgvn2wwKWkXZHA5Wd2hsHNRIBaYjdfPcw2hKTDWiaq74wJP+smMW/0tz7z0bMD
 7gXlt0iAzacN+lzNY2pnJr9ChcmyuFcj/j2bcSvi9ewzJTPyAYDYuZ9RoQt9g2SlUkyfcSey1
 3Cc7S0MRDe8u7iIiw9+q7OFKq9XhwxX3vOQlO6wi1MAriUjCnEoqIB3cf3AJHewNFZSLW98LP
 ABUwxQ5tp3Jgn27zi8PpVXmW/1Hk7Dy36SSBkTn7I1A5AuFxcodTdKANSUiKWTHLZnQbkpWMZ
 5XSd0+Z8RgNxKcx1r9qf+24aLuxi5rtOzvXX9QcJHONsH+w6hqN4iCoFizSNGdSgTGfKF9EHE
 bGJngaDutqtAKApY/0I/36iV6bnQ3aM/JX6faTuI6YCN0IfjNcH8uCAzo6tJCxjEVQolH93r/
 GwA5rjao3B75C37unZROXAgUAR651aEL0SBv8GftHVkgkbzz9YnGXbjYr6ZMhoHptQKBAzjbL
 htsLqmhLGky+CUQtU1sZtK/9CENeGHU8SuHY2Gx7kxEM+4ggNeBtjCQWqopfk18hBp5H9jn7L
 qnFbhOCFFEIHj27pMh3QBzp4Jb6IKogH8PsadxlvG/BrHkfjpNyvDWL7jqXPQFVrSsWrFJz0R
 9A3xX+gTwTjr+YE5pmWXY+WGpfEIRa+MI0onQ=

 > Indeed, I ended up dropping from the wrong local branch yesterday

So it looks like the patch was kept in stable because i hit the problem
now after upgrading from kernel 6.9 to 6.13. It's a PCIe card which was
cheaply available in europe so it wouldn't surprise me if some more of
these are around and in use. So, can we keep supporting that chip and
revert the change, or do i have to get a new card?

Regards,

Michael


