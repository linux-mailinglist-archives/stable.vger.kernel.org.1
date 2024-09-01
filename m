Return-Path: <stable+bounces-72628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B40A5967B77
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 19:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C017281CD0
	for <lists+stable@lfdr.de>; Sun,  1 Sep 2024 17:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8038118308A;
	Sun,  1 Sep 2024 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="nHMv3NRr"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A0917ADE1;
	Sun,  1 Sep 2024 17:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725211574; cv=none; b=CH+o2soGC/Mxhh7C+7jW1tpR6hjAVS0nP3q2oINYZu2Dy8yCEU4iYR6wlYrjtLgJDaEdo5OAQYdERuPiopKExcvWQRGKmqXuBGShi8RFSkRw8EQsvpWOsusJd7njYH0PRrax7+xQD0LeXpo5MUx+z+sG9yDin1dytuHq7o40mKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725211574; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=r+smjbd4NQwSBrK2mZXQ/Y7Tqt7cFspjRcK8RlkWbIz0UTg7/aINHsYfa7IZrR7NHZWl0UyWn7e+cxBoinjk3hFT3dSIcZYfxmJ9qGTfdy08iiasE5z9WxEhEeFsTZVEA2xH9RfVH6BRSCpbtIti4Q0nE4E6QyMLtfYEtqdthgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=nHMv3NRr; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1725211568; x=1725816368; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nHMv3NRr9wD/mVomPz/9UkNSOWwWoK5kYBxCvzCqnv6kjMtqTpooHSJiAS+NIt72
	 +SvFhYXU13mRCtD9Qg05/Zdq+Grkm9924OKWiCP7SGOqTxE7+FLO02c55qgsS6jV0
	 qd7ZFMbIJMX+QZJJK/WOjeUnPIpUtv27+PvNJxhTWDrJTF1dx+DBate/9D6VPfb/H
	 Saqd4k9SENsT1W5y6J1unCZNdxSmH4Zxz0lssrqKynOPKcItxnAYiBnHrWLzYxH/E
	 ioujHpRI8g3wPXCcU6btigB4+sPJd4h8m+L7X0o1a5I4h0QAAl0+F6oAUtLY/ptvC
	 KmRA8hQgTydsxve1hQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.35.208]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1sMRs81BlY-00m6F3; Sun, 01
 Sep 2024 19:26:08 +0200
Message-ID: <64a508d8-e93e-4e25-ae23-baf74e73bd23@gmx.de>
Date: Sun, 1 Sep 2024 19:26:07 +0200
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
Subject: Re: [PATCH 6.10 000/149] 6.10.8-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:9lHzAT4uCa6PaVl2zwW2c2RnNHrEhGNvNatK+JOV1fjxeYSwvCz
 5gfTW64iYxA2BkZZuylTJlcY/wDlIiOliDehkB5zq59M47jhpe2vl+x9GMNDH4rEJ4S/iDX
 W9DHlAAA+g52Yq19ej5GEf15O+8CXtTguVknfNTe0RjiE9x33nq13OMXI/iP4fR676r29p0
 q8Fu6XvjnMVMyi+cuLJ4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wqceaBVsemE=;Y658Bj9kz2vua0tySLlvXW+o+Er
 mF9DbSa0Nr+XDtNEmyEOXfzLRl72NfWeUCxxjWotwFkh0+VFAmVrMplm6BYM/JGHCaWLR8NwP
 kGIxAi/Q3G88E8rAOKTG3bJLvVLtaX6vRQVaKEgD186/ROsA2TQ3XEwYj1s1bQdJxx0G4ugQX
 9OYu8RH6Oi8Z4Iyo5Ap4OeKOWIW+2tkZ/CDpuLCNXMsZXpuBM0H2Z0E/uoJ+9oW7asXKMmVaB
 bLSRXrxx11jxROePW+oieqClgLRptEGv51XKJpK9Mr9frVIEtmlHOO04U3PC1SqJHOHQhh1PX
 gfFPaKh7H+J9/RdMZ+QXZsMw6GbgLdY9hsqFch6UWC9jEoUlD0jCi1QGBYfTsOlMn3rrvpqF5
 y/rBwp6u1HsNvApvI7mDiRdPJfdhBGwHHw1+CjBcXuL88+bQvG7tAxfafAvfyl3kMY3EwEhqQ
 nC8JL7YeF9f/D+D16uNF+ofNFZPAHSeIMBHErM5Fr/qYAqwjIgtXO85AeuW3krf/N8gpZjELC
 bsc5qnuhiJ11hJ7P9HunLv0+zf2SAk4+MIKG6vQ3iaP+s1+FTSIywH3hSGy8aY1wzPY0eWRLl
 RtjGe5zWoQ6rpx1jjMFEbF5fVQeuqcIkWCJDyVp2DIVuoLmOskI8/wZwLui2nFKpCKlMx0Seq
 b+WY9axjp9slUtWbGdGZm4Jb2U1RWSOMhsze6Nm+04EpIi55rk2Rq3pTdiT6IRivDDzNBvEAh
 YaFToDy+YBeOo9b1o8Pt1YJkz9FshK8wXB+SRXgx0augjF3RS+Dhta4Ads6Sb+E4NdbI6fseM
 fxI/OhDKcP2deG+hhbDA2Uyw==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

