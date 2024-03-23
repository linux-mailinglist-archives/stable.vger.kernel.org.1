Return-Path: <stable+bounces-28648-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63E9A8877E5
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 11:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EDFF2816A4
	for <lists+stable@lfdr.de>; Sat, 23 Mar 2024 10:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B49FBE9;
	Sat, 23 Mar 2024 10:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a9tQKJWM"
X-Original-To: stable@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324B611A;
	Sat, 23 Mar 2024 10:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711188466; cv=none; b=gx02DbFjOGbdzlofdRZJGn5HIvxDXqOwal08p0DMEm12mZj5staVVXxvyY95/CiYqS80V37H5RU2VT3pQPSr3u68nGDasjhHyUPS/u7kn/XvFEPmnXJVe+ebo2Sf5jcVwXsrp8NSqZfljBrruK5fg97jcPyUkvHINigx5Q1N/6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711188466; c=relaxed/simple;
	bh=yrz5tJD2ivBv8gxu9RFIQB3uNbtNOvkzFSgl/OgbRwM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0QRTxcyxNBew80hn+SNvgbryzRT/QlxS2bR8d7Gl1zmNrhDf4NDfrNvX33CIzKMQxYtk2PT0IaR70ffJ1TBDYyMBwXjZtsJQP8PSHm6QQagxqqqpOidjVtgrYTtfVFfu+9AHYvxHYYraVmparoRvFOzVfPy6Pke7ZR+mGfDSoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=a9tQKJWM; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5448AE0002;
	Sat, 23 Mar 2024 10:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711188460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GV1XuF5JPp4v9bymBXmpBt4KWMPJCGuzZuFHxkgtHXI=;
	b=a9tQKJWMioaXkkZXzJKhyupBC0HxXD7byrFMal0CMz3Vp6zrsiZtfOxpcMbl5TNjpCWTVc
	OznU9lGvw8iS4zS8fyUthRJ+yLLarToIftuK/RLAmwCHqjl8vAWHvPaB37SHhIaEC7L0s2
	5nlscm6QXxxrL/qs14et4VpAzTEQwcciyu2hdeB3gW7IDodyl0kJOHOzhv0En3gro4gSIP
	sfYK236t3T6CgwtDIEkvQapzWV7cJKmMEnqlQpYWTvdhyj87rul3U5goeysSRAt/UmDOby
	gLiIXbxquLXbiRzk4XYedFHFMqnD7u+3FnaKaDjK5W4j7T4GPqhJ1UcUjQvLzA==
Message-ID: <4c87bc80-c4e4-4a7d-a1d4-c2f90ffbe791@bootlin.com>
Date: Sat, 23 Mar 2024 11:07:39 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Patch "wifi: wilc1000: revert reset line logic flip" has been
 added to the 6.1-stable tree
To: Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>,
 stable@vger.kernel.org
References: <20240322181725.114042-1-sashal@kernel.org>
Content-Language: en-US
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
In-Reply-To: <20240322181725.114042-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello,

On 3/22/24 19:17, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     wifi: wilc1000: revert reset line logic flip
> 
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      wifi-wilc1000-revert-reset-line-logic-flip.patch
> and it can be found in the queue-6.1 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This patch is expected to introduce a breakage on platforms using a wrong device
tree description. After discussing this consequence with wireless and DT people
(see this patch RFC in [1]), it has been decided that this is tolerable. However,
despite the Fixes tag I have put in the patch, I am not sure it is OK to also
introduce this breakage for people just updating their stable kernels ? My
opinion here is that they should get this break only when updating to a new
kernel release, not stable, so I _would_ keep this patch out of stable trees
(currently applied to 6.1, 6.6, 6.7 and 6.8, if I have followed correctly).

Thanks,

Alexis

[1]
https://lore.kernel.org/all/20240213-wilc_1000_reset_line-v1-1-e01da2b23fed@bootlin.com/

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


