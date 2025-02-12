Return-Path: <stable+bounces-115028-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03902A321B3
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 10:05:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8490E188585B
	for <lists+stable@lfdr.de>; Wed, 12 Feb 2025 09:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD62F205ACE;
	Wed, 12 Feb 2025 09:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="T+BU1Zif"
X-Original-To: stable@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54271E7C07;
	Wed, 12 Feb 2025 09:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739351129; cv=none; b=c7QLJRI6xSxwXfHDh+aaJeD6nMyWmPln2+SJTagfvCrtd3IuNW83P2GzbPdloBIIs14Esu2hwqoQbucX9bybXVPw8/YvD86fD3htIBo/doNL7tufXUYkpsx0JOcU8CffwoVTdG2Pyc83lpXhul2dHm+exTZ1/rSb+4L9UUbPNhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739351129; c=relaxed/simple;
	bh=aFTsUnMwWQzKBC/DK5FQncvco/G679V5+HYcSuiwxpY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4cfooJAms4/Fy35OcqPnGp/98n448UJxTt4LnsedqC6yABmxSlFo/tCqI8NkOlVSG2YePdnPrNEhx/dlYpF9MQt1fTCd+CnfRakzL+rbvUyxEEoELR8hgf8d2DkJw+4FYVx71ic5Xk25yDSQj/2dj3u0cZ9BqQ85hsKDXK4C4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=T+BU1Zif; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9EFAE43418;
	Wed, 12 Feb 2025 09:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1739351118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/UOYKKTFWHAEgWX/tpxti6Hahb0bpNQ1UD67p+CryXY=;
	b=T+BU1Zif0FvjjrgHnWDd2zTlA8Ub18LPUOtr7vXpY8VrEk+VfejKm+vD2vaHAEhg7Xkbds
	rzAaydVDPMGuCO8kdZKYdzUxlAPELvFR2KP3virYhihL37bHH3KWWxttwMbMnl0yyWxxd8
	i9ZaOlIGQJXTbuFST5MTtk6Mi9kEJ9G7axptXAhInTxNpQXUHsCZW7BaIDexcPcv4nwfEF
	BI+/3NOoOMjP5uvaJsEvc0ctCUHyBwI5TOqSOEENY90UzkAVpKcrL+KA9/mgzNkvPxolsQ
	KewnvIzYRS4xprFvCow9l0IQ3mCvOx5zCibc8Y+V5oe7AqzIXDwwCbXeufYUMQ==
Message-ID: <fd8da5d5-8e11-4e88-bef3-3e50dad72aa6@bootlin.com>
Date: Wed, 12 Feb 2025 10:05:17 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/2] rtnetlink: Release nets when leaving
 rtnl_setlink()
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: alexis.lothore@bootlin.com, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org,
 stable@vger.kernel.org, thomas.petazzoni@bootlin.com
References: <20250212-rtnetlink_leak-v1-2-27bce9a3ac9a@bootlin.com>
 <20250212083117.32671-1-kuniyu@amazon.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20250212083117.32671-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdegfeegjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpeeurghsthhivghnucevuhhruhhttghhvghtuceosggrshhtihgvnhdrtghurhhuthgthhgvthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhephfehgefgteffkeehveeuvdekvddvueefgeejvefgleevveevteffveefgfehieejnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopegludelvddrudeikedrtddrudegngdpmhgrihhlfhhrohhmpegsrghsthhivghnrdgtuhhruhhttghhvghtsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeduvddprhgtphhtthhopehkuhhnihihuhesrghmrgiiohhnrdgtohhmpdhrtghpthhtoheprghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmpdhrtghpthhtohepuggrvhgvmhesuggrvhgvmhhlohhfthdrnhgvthdprhgtphhtthhopegvughumhgriigvthesghhoohhglhgvrdgtohhmpdhrtghpthhtohephhhorhhmsheskhgvrhhnvghlr
 dhorhhgpdhrtghpthhtohepkhhusggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-GND-Sasl: bastien.curutchet@bootlin.com

On 2/12/25 9:31 AM, Kuniyuki Iwashima wrote:
> From: "Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>
> Date: Wed, 12 Feb 2025 09:23:48 +0100
>> rtnl_setlink() uses the rtnl_nets_* helpers but never calls the
>> rtnl_nets_destroy(). It leads to small memory leaks.
>>
>> Call rtnl_nets_destroy() before exiting to properly decrement the nets'
>> reference counters.
>>
>> Fixes: 636af13f213b ("rtnetlink: Register rtnl_dellink() and rtnl_setlink() with RTNL_FLAG_DOIT_PERNET_WIP.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bastien Curutchet (eBPF Foundation) <bastien.curutchet@bootlin.com>
> 
> It's fixed in 1438f5d07b9a ("rtnetlink: fix netns leak with
> rtnl_setlink()").
> 

Oops, I missed it, sorry about that.

Best regards,
Bastien

