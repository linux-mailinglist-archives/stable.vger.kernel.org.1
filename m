Return-Path: <stable+bounces-116428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B97A3A361CC
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 16:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24DE43AA73F
	for <lists+stable@lfdr.de>; Fri, 14 Feb 2025 15:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992B5266B7D;
	Fri, 14 Feb 2025 15:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="j3/Ml5YN"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B56266EED;
	Fri, 14 Feb 2025 15:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739547271; cv=none; b=HyqUOoPVbVaDQRS5QqXPzWnWLfmGNnubEcdSaLQEYMPmmnJW6SQM9ahB2obag+ceqQZ5Aap64qiF4qnn0FnY75uOiV7dcy363MOlhdTlTSN4o2Ji33ExjJPk8Qfndwzx9DoshghaRVo5Bwl3LFo+p/f4EeHqhp8zkMb/MKO4RFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739547271; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=A6nq7k6sKU7n4EebHTczh9bPNrIWMXJaJXTvSlOx1kkY+ahNwf0094PW5Ba9K0tKQmC6INV9SwOHciklOpyK3B1UtVlRuDzajIFcBPFKQfNyUsPy/zMB9iCsAYHlWL7J94q7u/WMEdy8l0B+IT8+Yk2qKMsMp4ZWSFipRW/3uns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=j3/Ml5YN; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739547266; x=1740152066; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=j3/Ml5YNMjBE1ZYSgk9h8TA+g1PGUnUnwPcyd8vofNSk+gvuX+hBGNT36gr+EHOh
	 7cp6p/vlUUF3D0w2Fwon8iF4r5NWjg1s8JQF3lSU3QCv0cqeq8a0uRn4vlzZ5hMDa
	 qWsO577eLRxV0CB+9UIw/ufx9/ZwrAfww1fjZOq8uwfNyq6Wk9KkjUDuvBSGQetNo
	 A7iNFWjNR7YYB5ObP9Vy11aO3FwCBKiD+vE6lidkb6wC5AGsUzObihI4lVG61+Edr
	 qcc5Ff28pISSLU2mhKdZqrGv3GFOuLSbOam3nWQrZ1124yI3/DMVQ8r5jixScE+PJ
	 Ozxs2NgbrOt2V8HqHg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.200.20] ([46.142.33.122]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MAfYm-1tXwAE2URs-006lmQ; Fri, 14
 Feb 2025 16:34:26 +0100
Message-ID: <f48a704a-8cb3-452d-95fb-fda16a484e83@gmx.de>
Date: Fri, 14 Feb 2025 16:34:25 +0100
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
Subject: Re: [PATCH 6.13 000/443] 6.13.3-rc2 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:zLdJm+nrSOgp8ni7IZYRm/YQ0D/imNaN3c5frWqS5o+eA+M58AZ
 onEMaD1qcD1E7WKwRObOmyWxNVgIFMEKsOr/JocIkS373sc84aVUOJg+dDfRumcJBED1ZMO
 bf7ke0Smd39mYI44L6AGOMsCtb7LoWwky7fobyORz/kSTUlfK8QZH5hKIcQc0P8vyULQNcX
 852/p/602HfOmVNaAdBaA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:7ttD5aQwKMU=;jbYOPEkEe1U9BiW1E2o3oL3DZnT
 uPbwyUmOLSPlHHotk5M9kA7633GvI55mswDB8SwajVbNEtn3kOE1XMiUp5hkSpS63An9wX1SY
 I9pLzegM2sxl+712SlmcY8ivJN6QwS4tb9+8RMsxEITp2GaYcMRRMcqtlYnqMwB2oRIhqv6Ap
 Hrlv0GT2Vtt+9t2tGnwbLUKWeSm3ozhdsUPJAX6FkijSNtkifiWEIc7wZ/UI+NLaZBSvIdZwP
 yQPkBZq07lEEGttlcWyrTT6XjiNrf0Gn/ZpuxgoR2x1MhhEyeBkaktAqugaDSCa1BSf0+ypAl
 PzO9SAMl1nTe5s+bGAG443b+XwBQsug9Z+0anv9BGvhct9yVQecJX5rBVKOGBqvRvDMpfiN9n
 e+BHWRbMc9m90VMotpcbLmJSNm+S6Kj/qeESmhCDEY9B5fIfEudFCJr+hYGGLjAp5UUGsqr4A
 WCW6OOXwWtLMIo7VbB4z4hhv62am/CgZBNC7tnlfun8Kd9767hxjF78Sjd4pEIr6qSjnSKAXP
 g+0BGJAy1wqFzCfmkDflPMAN+fYO8Kf0yWHw+3fEESVDrAtTeXe5qi3J6dElQFyo5B862Sc8J
 URFbVIF5XxS1Fa6oXhnjQoazq2YdMnzra5cpRoedsrrEuYWmdG7IHqg5biBKmY/oD4fXSDJUs
 WCCWD7cAtPOJF3y3YUSARl8kvHsakG65H4KbRK84hyhPBi5yimER0agIb2V757z8PMImGqx1G
 2xMKLbpipcnMUUONnTr/UYxbU7S7CMTsfkLTF6mGd/2ioFwibCCiOqfAeOGy9YgdFrNAmjCps
 STHpUZw8X8WzgWOVaiiR+NOK2KoeeBj8A8NY/UcKmSr4c6aJ/YrpRdhTqvvahRc7EppMaa1i0
 3Dxq9FbbeFnAjHuzCYJw9cn4Mho9fGiB1bOd8Uvp1eyRzjKOfRE+Xv0pcG/+TQtOokCQx0iUx
 09Tdi8/KDlOoctxb5xOJG6gwZR6P889Ma1vvPQzVy0t4Is7SmlVcA2NDkTRZFn8/SvkSMUNBe
 erJH1P6tjVC64VV3VpjrXlETNmUDEl9+3RgwnGf1pzfcg3xXriUpjUbOZIm1/rQDNIYWTnN/L
 zmGFiUfy3iJFnxMqUUEizpQdYFyVX/ZEGutiJ8/XhkJ1G/ZwYBbtUEGWSTTRsLIzfNHmVqmVm
 dvrwwmE7p24o9tWshZZIKoEPsICvjIofVG9peUH2d8rfAIkDyFj+9Y93DnsG1ZXTXACoOdb9M
 bm+PxcrxPvRMlhzOlZYB6ri8oWFALCgMr/q8WVtO6aWNKBDA+kOV07BwCxM3EoGyxLvhNdPpJ
 lySQeaPbCbwcsnAjCj0azR5mvhecddko24EjtAOjD3sx0IBgQoYv8OZFZH5vlbznPTLZeizTA
 bg3m7DEBJzYBIJkuUgB+H7LYOeIQlFTnduGY0lyRhDIXeR4Ji4Y3y5PvZU

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

