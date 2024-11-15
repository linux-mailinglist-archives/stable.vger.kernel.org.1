Return-Path: <stable+bounces-93546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D097B9CDFF6
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 14:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 967272814EA
	for <lists+stable@lfdr.de>; Fri, 15 Nov 2024 13:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44B8C7082C;
	Fri, 15 Nov 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="Ju0FtaIW"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992232629D;
	Fri, 15 Nov 2024 13:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731677446; cv=none; b=IgEj2Lr+lVq0nZ3/Up0I3EVqAxhcIVutzAF7yxifcBrY/kvKTXQqkOnCc3m00blv5woBIY+hBdDsbNVF9mdKPZuevL/QN8qRrPUB61TuSMmcK+u9lXbDaRABEFU7zCYwh52r4sPgL6KXAfuIVlXKK7+VR/OS1RmRLEpOkjTWqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731677446; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=Rcnv7zADxs4xGJG25anpywD1H0f+Mshu42TdyWBTRjjYjIRTX5su18zcmov0rkDcFTkOCuzLAZpXlJQw2tTw/7XusI11DCMyx7CY4FHaNcFqfY6jNZEnyQ2CbpwUiwefOFwrSFlzsULPxLMV+AOJ32/urJWFWtoo4w5uGjIGatM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=Ju0FtaIW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1731677441; x=1732282241; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Ju0FtaIWlnmG0olK1NzERif08z2Grvw/jbSThVFSFZgnKGApetcB/aNDsD5Wsx2a
	 y6vuoN8KHSz/74n4PbRqvZDJCKHIhMjRt05KVCnvwcLbamp79K5OHVxJYPTIkhfp2
	 PKkGt0AfsGrQtIaTFxvtoAhhPs0DE4eUVKrav5VxalJR9tsnDX+miCbfsR5ynmXut
	 fsBhDZHYCN/eoBDpR7nb17y3HWtSFr4kiR1lh1r06Fxzpr1g22I8oKDCnIw54U9nf
	 Xa9rKn/MSzQ8K7qVJbuqcMevzRxl9EaGXINf+pw306kGBYTTbKjBGTuuah+qw8TBd
	 FL8k5oF2TA4omIpctQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([87.122.67.115]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mel81-1tjteG0E1F-00ceBv; Fri, 15
 Nov 2024 14:30:41 +0100
Message-ID: <2f29472e-9764-4ea9-81e4-a0bcb176401f@gmx.de>
Date: Fri, 15 Nov 2024 14:30:40 +0100
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
Subject: Re: [PATCH 6.11 00/63] 6.11.9-rc1 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:dMoPA1t64mbDo/GClrleI3JhbzyZVxxKUdnm/RmJS0IP727RrZA
 gVm7tWN9fPwfF47klC7sUzAuC5aHOa+gjC6YTXVvLIuogyUFJGBEDMRp6uTlKl2qd6H6lMY
 UZcyczfbeLfEyFNyqI9A/Fd3a+qu0UXnNQT0jk+jA7X/VijoMiAMSK3tezpAoiN5ohBZJiv
 oU/1zfvw+hwE7WmItAHdw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ZSZN+sE6uxE=;m81qZEj2PKTXKj+LCBPJ6DXaexP
 ZCHjf2w+snG1Mgrl6PY+WYZUoXXS6ptCfyndmvkEu9fgQDJsLGGFbBkJxL/QJ64FmTcv/cNSF
 ieF5meU7dmHpikouya739l2yM6xHcpMoCLH+hn6BA3e1/GIDXCsQEn4cc6Bqblql8dYSQubQg
 IdSh7puwpOiCDFk4vmJjT/wgLBCcy2Up56ll+kODk4vDIRghgHK83VDvKcUS/BQZQiM/6Go0j
 wXn/ZIX2l0ja1CIJtrLE+yOxgoCdB1I0cmZyp2FhgFqBnT5p20DrkJKC3oHMdPKI1j4WbdNGg
 qJMmSfOTejSjVulRz6t+WlAB8toZocppIZMdNcPfGbD1gYLueMxoyAutGmh5Fv5gj5zR7UTyt
 YHn2/Jb0ngCz6uK+221eQP2R2TsF5TUsQ8lJOwOn61m2at37oepssbkxy4etou2KSR6aUVCzo
 Qu4FJNMCVrI7CRwaa5h3zZFP6+rmiZIZ1u3y88tc58LvYNwqGQ9w4ZB5ge5w66YUSmPmVgjbN
 QhwHiqAM57LLeAjq3psG69cOvGtHI+ip/aEgxUGcsDS7Hedail0kzMu5KL4MNxXo6sNhSyPVy
 EQjDUe/i4G1zO/q0PdokwsOfcH7ctjdG/3t6PaW/TaXuNjfY418jmzKle6LSKHZwRTCOM64u/
 COJF7Dedgp3ihEjmm+9Q/cnAPcy3DK0N/LZsyxIn7qUWTFYr0FquIt8XEI61mUBRJB3Xy3sIB
 /0Bql2SfsVwXimWJKAm8f363jkoApHyGNCcHXr4jjVQ2i3/w/Q0fwRqMVjq/+rxy8evacM33b
 xVhLBIMlwOybZiVNqS8W1oMzoXWaRO+d36IJFyjN/XMwm+8nN68BfUdQXLu0O4Ej/Wd1RokwP
 ipOuozTGa2ztAsgboG3b6hbHQ3VNkdm9W0ZYoeg7Gc8Jc77RQgwVqG+8z

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

