Return-Path: <stable+bounces-76494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE3397A264
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A30591F23D4A
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA24154423;
	Mon, 16 Sep 2024 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="LOq0VcC6"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00A94C70;
	Mon, 16 Sep 2024 12:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726490243; cv=none; b=FoilA5ItSCjaS2b+cDEjfaoN/Za5Xw05g8ARhw9q+x4jEP89pcsOZV8sksMTz19ZaGMsBFccFjgQ6FBBAg8zzPtWYGi95P0KvTFmze2fC3Bhf6JcKmFscT28Ij2mTg3xnJLpNb9onKGSayjGTQqOqbq62hH5xqsNb12FGkiN2Js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726490243; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=I6f1oysyBZ7SPa3B30685FTFtbJaBtNaccn1sck242UQEvEEXyzizd6e3U+b8QT+3hhpwer1gIu5xP8STV/UROZMUx4Dzrf8R/tChKrhRQQomnxQWqtg8BPxHFvSa5KCJrJ1GJ3WFPNjWyinZrhPKzg9It30f0f0Y0JCugA0zyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=LOq0VcC6; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1726490238; x=1727095038; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=LOq0VcC6QZr8ESrHfEYicdpyrwLLNTYYGgmNqY7YKfKVDNHGxbNkRTkTKxEpzq18
	 oLrZJU7UUY/8kLdC7RPKJHRVz/fJ7Fsebrg4ErtXHk12TJXv6bstDO8OIUTAgCBdq
	 sRhYFMiyk0tnXTOcS+oG9Jh9H4Zs1kRy3765rG8aXp2MxQIPJ16Y+blRFxV7pdTcQ
	 ypgW0Xy2jFLnbEBBInb9P2uu/KMuGPGCKH8BlAaG0aRN3VZ6uYuO6c27vnNzmlE0f
	 UxEipsqYCbxB6AiOT6p2Al6/7Tdhjv+IcOqS7FM8pUqTcdMruQOE0nRDits+mVss+
	 1aqW5sh5c9ameID6Lg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.34.123]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MHoNC-1snP0i0ZJG-00Ez7O; Mon, 16
 Sep 2024 14:37:18 +0200
Message-ID: <e2e85b44-237e-4700-93ae-c5d932378989@gmx.de>
Date: Mon, 16 Sep 2024 14:37:17 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ronald Warsow <rwarsow@gmx.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Content-Language: de-DE, en-US
Subject: Re: [PATCH 6.10 000/121] 6.10.11-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:tXt/CCYVRQ1C/vyh/3KmDQeGYAltTJT++XusGSNU5KK7TUPlkiE
 vFHB9T7xwbxWlaA6DM8ifZNYyQWaJU58+JexaEdqBVz6O1i0I1I5YzijX+K1nen3l1U7OcC
 VTHZH2gPcIn0B1nk5f9icOG2+gRehBGTVRql99WSC3qSgrVpy9ebSCFDs8Rli2L0KFmio+r
 kNny0YwIMDpsqOoeGud8A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:IOLTS/fKtDc=;2S4wdv95JCEPSHiofMzrFB2zG9g
 Tw/W533lm1RXC5pfgCp4hvMtdt6OgJ3gZb0Ps3Ixe/RYmfwehgJzgLsEUlh6ocEaU5oZV7v7C
 NnwcvIaXRNXcXsuCN0lhb3h6v/K5Xv3IQ9nFEppNuE0LpmPP1TId8Ad5jHSf1ILQXDdTXAQra
 jb1r4WbAJoebTfX6W0Ezx6EmA3T/QUsJrvgb/we2Ldvb6nmsrlBKYwrC7HLPk/AdMACd0zD5R
 xfNzN2/TdKCfrknYk0JIWsL8wIVQASFgHSXd5Vf8MkYrFWHDw1OH7mvk9yxpQi4qxg4Zdt7xC
 Z2C/o9oMJR0k9KLKL9N5rYsuCdD3a8CsqUeOT2R5dt4YnkKetaj2hIWq3Qv2M8RWyKDkxeSPv
 vIZufnWwBtLtIlBG5fheydm7rMVGL7WpTVJRl0WXj1LJwVsl9pV4+jjjVpjGuJSGKf//75C8a
 x6g+8RYeRFUkZGcNmkWqIQZBngOrepYX4iQCEDNR2ipoJzX5QDacI3hmeClxLB761UqF3IVNK
 +I6QR9/+sRQ0E8Ti9345FYYfMY1MxdciG2qMyXI0wU7G49Ccco+fu4P5on72E/KGTCTDNooj2
 N7LeyLZdFDW9ew7V47CpQ5YKNkCEc8CVTW9gufOkK9n3bwzklgYphbGy6UfMIMcpwMDhuLEH/
 4JsnJu2xLB58iNtrOPWI+j6Ro1QzR1x8ceZ6+tfft74XcHz7gxPUmtPQEE49OZ5S1OmIHniCT
 QzXZhZ58dfzEFRLwtp4SdeL7O+5aYMFf9Ek9p+H1bPYsCbUGV+I3iysgiALUvDAh9XN9XYStO
 qv9tP2/+tUFWbBOffdPFu2cg==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

