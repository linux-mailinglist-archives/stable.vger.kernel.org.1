Return-Path: <stable+bounces-64776-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A077F9431EC
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 16:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5626F1F26294
	for <lists+stable@lfdr.de>; Wed, 31 Jul 2024 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F55A1B580C;
	Wed, 31 Jul 2024 14:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b="AmA52vQB"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A7B1B580A;
	Wed, 31 Jul 2024 14:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722435721; cv=none; b=O332SCSVoaf7aWZRCiiwt3fc5SMY1mxZSfHlTaSqkBY3f2IFi+3JkZ69tlFtQQvItfm51UrzwhcIGUhNvojMkvakDwx1bemh8QdR3HCLI+zcjo2MENVVvgNXginYr5qnV+Bx7OF7tejn33X6adiCJQCSjGCO8Q6Iml8HF5QhVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722435721; c=relaxed/simple;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=aCqZoUMvO4NQHxrTV4NB665kVGPDWu0klWU/ouVIRo/ZorYNxfKrE+ogPrybY8pd99yEZvhFSJ5i51001o7wqzGjp8/nS+zbpwpJITputePfHYYxM1rUjn+1CIE7xrc/i8zEboa6z41roduTdnBOpQj8bDKHB2emamtdO5P6n2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=rwarsow@gmx.de header.b=AmA52vQB; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1722435712; x=1723040512; i=rwarsow@gmx.de;
	bh=HtuFhXI63urBA3dRKYyXQ6GHreCYVeNttV6YM+zDLlM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:To:Cc:
	 Subject:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=AmA52vQBGSSda90U8G7NlZ6XP+LMphYGzr60ISqlYB9x500Pj8v0TjPfaMqIYNWB
	 HJxjMW93blY+ERbYWRiQ4KD2M8+RewuyO+gEiVowl/ou2axKiZ+lRf2nRohOOAayz
	 /Gdr3sInQ3hT2P24wYBD6Vg1VkNeAbgjDxL2sF6640i72SCZ2gKha737LxyLtkpN6
	 1zuIzwU+0IdfeN09mjYYtIRaizxewqAclwiH9tzZvSXuNoDQKTDj5u3t0VUT2jysY
	 SxO5KodZyvHJefKrRut5GQ3B6Kful8XEaG8wqnSEWyZGtIU1nS1gjYcN0U2WPMFdD
	 RFjP6XhCNj5QA+wyZw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.100.20] ([46.142.32.146]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M6ll8-1sbvyE03fa-00Fcmw; Wed, 31
 Jul 2024 16:09:16 +0200
Message-ID: <0a468772-3cf0-41cb-90a5-273873063f1f@gmx.de>
Date: Wed, 31 Jul 2024 16:09:15 +0200
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
Subject: Re: [PATCH 6.10 000/809] 6.10.3-rc3 review
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:ARIgxMkGePLC7ZLhy6qw/7piEYKvYDhl5P61SNS2rbcjEYyef3B
 9xLc6ymV5BhpsafjvP09wUuCTybEnugd//d70yee4rDjXcbqHVZ3rPYZOk/F3BgxiXeriSB
 7Xbb55JVRsGbaluCN3QxcAFlMTY6+plRbJyXF0oG+PlHSCwcRBER+FHcUPvTxZX/EzLpuD1
 grpXrFoU8CyDU1+ytTQAA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iOG4lTWkQUA=;/ROP9UjhhEghsoHigUbLIZejgS+
 sMxzt22RNud0BTxaBAJ/60sM4PUjUErQEkWTcN1IHBAGHxR4bOAyoVg2KY6T6D8YujBo96WvN
 Xdy0KnEWRSmxoaGUEkhGcdgzyQt2MexhJzxk+q6GjJTcV+LQ+3az5VDiW+LOcHml343c0eN+r
 1phH/LHuSKjIAYG1LDLnjibzz1lb4ZrMZW7tHavbaJoPv3cnnfaQj0FAWwb26mmKyje0BJzGQ
 9TNKsMtWdcPUF+Y/SmsNB0S/KE6ZXMEdVO9DLHUDvHIq0Zv5W5j6mydn44YtYfrh9nq1SHw9J
 caDtRhBI9wq7S2YipC0H0mPmYCG3tQplQZL+IAsVmk6ZDYXhUIhzD/GFMaNUS0OtW/ZgqfdNG
 AqCMSwdXFa2iKMXkFZNJX3/Wfesd63miYxpuDZsTKhyci8N29tx9Kc3Vdq7LwNfZ+w1cbNIc1
 AZSk3O8NGbt7BGuSC87/w0ulkligrtooXrLYWKpTRo4Q9DDgUi2iJk0JQ/OW7DKQjByScP6G/
 fi5LSKVF2Ioo5yRKEu2WIxQuVFmebqfPwfxKJwlzoXkRggm4qOOH8DL03Z1pthv+gbAcOhp66
 MtP0f8PUht92g/zMvvc3TZU6gG2iJgpKFeCfwHxHAu2IOI3ZmBRV7sz1yYne4MwG9x61fSpuW
 VpFbDb4I5rxh3qAxC9M8krbgiewKy1FG/7SfFm/oqpNZZ6wGXi0FZay1mKA8r5UKMSV/spraO
 O94WqhWOoaJQKmKzUKYXxqDjku1/JxozQcH0HJyb9uoGENgpYxlR+CvHiyYfhp893sXnhDdO8
 vJ5IrD/q465rWB/mU1ViCLUQ==

Hi Greg

no regressions here on x86_64 (RKL, Intel 11th Gen. CPU)

Thanks

Tested-by: Ronald Warsow <rwarsow@gmx.de>

