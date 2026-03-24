Return-Path: <stable+bounces-230095-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QP8tFeJWwmnEbwQAu9opvQ
	(envelope-from <stable+bounces-230095-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:18:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81846305756
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 10:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D921431C8D34
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 09:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191D3DDDA9;
	Tue, 24 Mar 2026 09:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b4ioA8KL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="155BLQbW"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F243DCD84;
	Tue, 24 Mar 2026 09:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774343340; cv=none; b=IQqd/INABonkL5oewaOqI1W8E8Hj1zo3wOA8ifZTv/4qgxH2WBlIaMd9njZ56koY8CjbTpUXxYIQi1Ov1CWL/tAfctKESraEtD4TkGcKos0gsS215x2+7kp9Rx0yMSE2ASntJ8alN+L/28q1x/f/5cISiR0GtQdWne5wKwa6axA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774343340; c=relaxed/simple;
	bh=/q08/hJS22kkdBfDNaW+au198b3yybnqZiagyp2PT1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DhzAzxb2Rqjd9d31WDFz8vz++THZDRkafy7yjKcqrCEYGs4yF+ked+coZM6GvzoTqnFwg5XSE0vEMQgY2J9mh00OkHiX6M8kBl1DbviLjIeFjUlOBOWvEUu7v0wouHJVMZ06GdPbluMITpPtI2plTuPRWVXLJqxDPjPoheW86gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b4ioA8KL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=155BLQbW; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D80F71400220;
	Tue, 24 Mar 2026 05:08:52 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Tue, 24 Mar 2026 05:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774343332;
	 x=1774429732; bh=QpCnatYRzwCG2zmiscszJ/0kViuwxysZZHdRGdDEVzY=; b=
	b4ioA8KL4B+aDD0GBxeXeVlft9nI8g9u61k3WdeO5cbSuvwl+Wh6qQWzt9EyTa4W
	ufepdBlBxvQfQNDh3wkhFaWneO7/sgA+eVDC/glGGQc7xvJa9P4Gj9FJkMqkAKHp
	+ZVw2uHha1aIzwlGm6Z9s/SLhdb0ZLN4HD6RN8x1sxaYFTLQesAI0BtGjMQDhlYZ
	peJVEQslDpH17oB8o5oq5HKjo4leRCiSRCZZoHTgJMO6BdYNLlLn4VOPWTC22dDh
	ES6Ffmuh/t5bIlEFpvZAQp5AM9KwLbtW0379gzzwUgMDre7FQFyUlgQRda0tB1xd
	ZsXccxf3h4bYttDsFauqXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774343332; x=
	1774429732; bh=QpCnatYRzwCG2zmiscszJ/0kViuwxysZZHdRGdDEVzY=; b=1
	55BLQbWCubmfSpJx2r28C1iW0iNxfsByJqExyTin8dMHLA4+dN5FQ26SO6rlgmkb
	8JWapu7Msr+XbAkKIVoLx5xwLKauulR4dbHDA1lhyVpgs/aGMSgAhq9fYmvHNDjW
	sg56ODqvinfGoFtVLzKV4Kan4T7X2Wl63b1XMGhL7/PC0YJUvfeVLaJIYSdr2nmc
	aLmZJMjmjRKkwceiknT7ycOmJqIp7zorhwsMdeylbDfOW5LNY+YqL0t3DjKnMPOP
	7LMptCRUeyLs8uwDBtC38XIA82zDlqdXwTZMuipHe0MB433TG5SHiJ9X6/V+EVG6
	pGsT9sG0OEWudl11zE1Hg==
X-ME-Sender: <xms:o1TCaVmSf2Q0wMOm0U9WQ6BYSSezStKHUU0o22SZh5uZkuhvXf9A2Q>
    <xme:o1TCacuU3FuYnkA7A9yF9c6Y0rUKyRPxZD2S9QTifhTx3Wdv9bkl36Y1DOUohQyV1
    JQvMYEozl-HU5Cm51now10R0A11LPUNjbqQ1nVguHM4cXeqpWNkceM>
X-ME-Received: <xmr:o1TCaXKj0Yj4lqW3NdiFdg_14mGWzP9P89AvyYpScnazD8ATs9FAxbjeAE1O0DMsUSrlblxF3KkfjEoyffJKhDDtJN9Hrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdduudekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpedfuegrrhhr
    hicumfdrucfprghthhgrnhdfuceosggrrhhrhihnsehpohgsohigrdgtohhmqeenucggtf
    frrghtthgvrhhnpeefleehkeehleekjeelffefhfdvleejteehledtieduffevteffleet
    gefgfefhjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggrrhhrhihnsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohep
    shhtrggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrthgthh
    gvsheslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgush
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghkphhmsehl
    ihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigsehroh
    gvtghkqdhushdrnhgvthdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehprghttghhvghssehkvghrnhgvlhgtihdrohhrgh
X-ME-Proxy: <xmx:o1TCaZjtpXbdMN6a01OrbGgwfQLgl1CfzVeCOIBKryF43orjtj-gOg>
    <xmx:o1TCabtyqOsYwvtEd_jwgfFHGdRJhuXRBIVk2BYcf9EELkjoWIOgyA>
    <xmx:o1TCaThyjFyVI07MMI0zjAvI0TJFHKfSGxrwwovnKDhI6j6bJY2XxA>
    <xmx:o1TCaWcT1Xt7ZUt6L2P-2fgGDDe5TjL1RiClmK-Z7op7pC7zwqYYGQ>
    <xmx:pFTCaXLBpxWPcdLR-BVIU6i6NXe0CuXmkFpade-Ks0i2L7YZBeXwLiTE>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Mar 2026 05:08:49 -0400 (EDT)
Message-ID: <4bdd0b5b-520e-41c9-adf1-940b699736c6@pobox.com>
Date: Tue, 24 Mar 2026 02:08:48 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/567] 6.6.130-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260323134533.749096647@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260323134533.749096647@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-230095-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 81846305756
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/23/26 06:38, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.130 release.
> There are 567 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 25 Mar 2026 13:44:33 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.130-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on an amd64 laptop (Lenovo ThinkPad T14 Gen 1). Working well,
no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

