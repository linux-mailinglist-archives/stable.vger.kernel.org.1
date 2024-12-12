Return-Path: <stable+bounces-102066-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCBD9EF0BA
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCF918942AF
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E7A236F89;
	Thu, 12 Dec 2024 16:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="dHW6kSOT"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A085E225412;
	Thu, 12 Dec 2024 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019838; cv=none; b=ua4LsLbAJHOKkUBvYOO61cJvoXiIxPGAYQpY5+6cVFx83urJFG5Dyzl95IbC1A8iYyoPDJXeIYwLoI5pWgJzbiB6YH7S5IA+iCntNV+4jQeFmE0JhW0Srf4En2XKJmUlpBfdi9cEKMIAPbkYamFef4xLKkYOYUsQlZ6CxvhYMAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019838; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=j/WABzTzm/P8gNfP/Kjgs+Io58Sg3H56dxea9huuFff6pQITkQU4sYvd6bRsJ3Qf4Yku86d7W39sZ2NQ6Tt9KMe4Uljum2HJRT8lh9UsmjI3d+M0qzPZiXwPizzdqodhyJLGYl6VJg6j2pKUpkbIj9pSCZRFYw9F0un0OHMC4wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=dHW6kSOT; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1734019833; x=1734624633; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dHW6kSOTRO0atGwBvjEBNx9VMLfoZpIa7lwm9vr7o3W/nu5hIhFloUtORNws79Da
	 45eiWC7XpCraFAUfKfkr7mwf5v/m8KOtGzkL/W1PdikF2iu1NljTMGq9fsWXQZdKb
	 7xJIaXqYpVgNGudAudgr+Bvr1WWgppM9E9JVDi3JifYAmhF87K9+UMIu6MV9YTi7n
	 88fQG2uUTzgix70m0O1cOG63MIcHIneFVd/SSeZq37oBdGLnFdczQnaiaMrSTvKn8
	 0LKZhFZCM1beiyctgP8gOvd7uhfjuhRO+o3bU4Mt2r/7/K1AsIFp+dCuaerBVsEYi
	 KQZq4l9fDtiwLCOwkw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.232]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMobO-1t5LLg3vtc-00QUWS; Thu, 12
 Dec 2024 17:10:32 +0100
Message-ID: <e028e4ac-9058-487e-accf-063421e35832@gmx.de>
Date: Thu, 12 Dec 2024 17:10:32 +0100
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
Subject: Re: [PATCH 6.12 000/466] 6.12.5-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:DNx8quqLI5bJOAIjgmRCWaKaa9imRGxPgHCgd1mG3b3ej3bICcf
 jG0sxHCHAl2+t6kWrfIOGULrZrYjpBLj9x75Y8M8mPjTjMiNUGDY44mdD6VGYA3pcjV6okI
 hDfNw4Rv7MKkWqi3EwG5TbdSmhR9qkh91lFlmB2scAgMAEhNYKD/6eOXWGy6ac8fuUOL9Yy
 EaDqDV3kWaFH2x0cXgrzg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Vxsk595eiw8=;Vip839rEdxicgs47xbksBje9aGL
 zlwlMWo1AWoNxVhnITtuFMCv5dBxgghkV4giWVyQBzy1qzu/bn4pBB+QZk8f5mnwYjK/punu5
 0qSJe/Dhqi2O10kYTTTJgsq4EyGFVuImCoJIqb3w5o2WORYcGgxHGM2iugdSE8s08En5chQQ7
 /SNqmlyExkwDbqIqAEJl2ckvmTLNFd5x6KK+9yuVAyeJm8vC09PRNa1Q/URHPZ2/Sx8ERRQOx
 dAgFgio9BNKKfuVaJz5RGgMQOdXHjvqRhS1c55P7g81a5D1p13gVrAtrXOC0+34/CHb6sS/FM
 k54s7e12OIYN46p3+PeRiSFkjPHX6T2jKttYmuvsjPU46mi5gRf01IQWoI/kmEbi1we7Wji9D
 hbbl3alf0vTGIw60wwBfLZu4f4QyidkNCgTHcALgr7ezOl8Ab1sFOlAFrXD/vPsh4WR3szb5h
 0xQ1bdEWvrJclmbp24uBiiwULYkL6uk2zSkbKA8+Mg9k4+T3NQ837B7Xm1tDopt2ZvnB0X5iy
 KIgnuPQGeZ0mw4eYIC8GMm17wQBm1aRmBGEvDZl0u59P3nqvC7s1SWTv60zgvf2X7G8qB+796
 2zVaFd0sEriOCzspa3Rqszd3UqOimtk35OhPzFsi+1dRNKHhDSbrwFej8AZNu9z8wLfG8gYrp
 f/gi8O6aQXO2gEfjLnIA4/MShdslvVBY0PECiXgu18+Wd8p9d6FkSQQwv3jOPqhEtDCMJoAsU
 kTqyPueChMxYVSQScsI4NEbTREO7/A7wzItKdGxuQuAUhFCd/2Ew0Zc5eAtj3KYxzfCm85/5d
 wFCPssimBWtw3EascsNJ0CSkG8ZwRQoQ0wT49ulx52bTexaKsHXEG1ZSodJHMUvR0n4ZXPKrJ
 KwvKldnhbnctAGTWoTXOxvKBAb9OYu517+FYFetQN2KiRpYLfmB9x2FbxQ3g0OMIrYtvpG4wq
 Igx5V6Q/HD9QDcajZRJ1UZPZdOKqFHvKBW9d+TZPjRd5lAz1n3DBK2E3Tzv3Kjwwyr4tqL/xT
 eSU5zsQQjeKcSMSt0Li4siSdfakRUGU1uF6nG1jsKzE9QHJ+tIMO5/vwg+4GW6S0ZGfGQu38/
 tx1uEwCt4=

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

