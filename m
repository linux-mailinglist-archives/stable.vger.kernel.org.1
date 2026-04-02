Return-Path: <stable+bounces-232957-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOI8Lqg7zmmAmAYAu9opvQ
	(envelope-from <stable+bounces-232957-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:49:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B703872C2
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 11:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA37B30A44DB
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 09:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A123DD53F;
	Thu,  2 Apr 2026 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="phjoInpt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DdKPsCGk"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24C43914ED;
	Thu,  2 Apr 2026 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775123049; cv=none; b=jTTCyoyDxgjyRNiH4hsBms6tBrearh3osRlwjLAjMMNjJnex5dAT0GW20SJkwqOoOOIrfn0sCiPmTtM96pTfNqmuhDwGAVvbYDQJLCsqaE9WRYzh/RAPtMd9uDx8P2bYorFRRh1jqKbPkA66w1s53o5nAC8L+Aw4cVkwA2GArOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775123049; c=relaxed/simple;
	bh=wRecm6QuDoU+cHrxvmv/K10KdpFKrXBHy8y9ZpizY7U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=seu8blwtpzFtLmqL5rRAvo6MA69ICR1XFG8gEyqRZVo1dQgdPzRxIFzNbiY7aT5w6gaMMTYERbbUmhMq5fmrwrIkeKgJG3D3zpS9kCGDwYVAg9t2Yp77Eoe3BMn8RXMAYNC8L7k1mBzGwC5CEgsnBbM+9fM12Z++eQQaOv66gy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=phjoInpt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DdKPsCGk; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E65B77A02FE;
	Thu,  2 Apr 2026 05:43:59 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Thu, 02 Apr 2026 05:44:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775123039;
	 x=1775209439; bh=ZhYhxTY4U9xfdMvUe8c1GDNmyJB8rxZmOqwnOhKpqhk=; b=
	phjoInptya4PFMD6jE5NvYFrOlRw9WOoL3j9ef4D2CLl0w98CWV+5fVJ/pICyfrh
	VkOE5hxly+HiXXIKZ4w3YpQxd1VwjAhwiBkbHOqaWnKzJRl4clJai5rZxhGpi4qC
	B3QYbVn7HrNxOSK+uRZHL3tZqHLfD8aHaESvt1pOr5OOlRCJ45TaHLpLO7Gm5Zxd
	RPbdjAfI4RZigGBc3sP6SVLWVKJfSaln9jwJCEMzpY16lQUQHgUefe0WcruRb1v3
	XVfvqTD3W4jdO21ValB7apKDvqGIx2x4k4OdiAdO2AW23sYv2ufEpEjKu+4PaXb9
	i0JanyinclkfzTb76EX8SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775123039; x=
	1775209439; bh=ZhYhxTY4U9xfdMvUe8c1GDNmyJB8rxZmOqwnOhKpqhk=; b=D
	dKPsCGkVYirlD6xrzzWCBtIinGn6SbnkiAvdRrEzUyWLc/Bh4BavWeNVdTK1Lcqm
	DC4c4r+CAcFvYeb0zWu9pN7iirENJxZ0SHQOVhANO/8ZWEjRLwfpSLFOb/JaP4uF
	PKvJqFgWmdzlGPB3npcSf+7Og6jLTq2lytFt3f07eyIA1xRwDj73REloJUz61UzP
	yZf0FSumm8rcML0dXAP3rYWggz8WOeEx3oXc4MgJVWKheQZX/r4+fwBZiqf0MQ/+
	ZThsHV6e5IRNkA25jgyTGhxmkNFky16sPnlR44NvR5kcKcrEWkCZ6UVcS5KwQCIL
	RyczZ3meJO8lnyF9k55DA==
X-ME-Sender: <xms:XjrOaTB8lDW0IbDngKg4Y9Gpw02hrxn2fhlCutwsgwS6o5C6KoszSA>
    <xme:XjrOaXPnH127j2GEon3j0Lvji5tdKjPe0JllOkjRpRAW3DVdsWwvEl-A8xhdBH-Aw
    ZQJckjAkzpm51ajAX2O4WQoE9ptZ8MlTByceH47XR5Xvfca1dBvMxc>
X-ME-Received: <xmr:XjrOaQXI_bul8OF9ymtRF7qfdb71y20WAO66lPjNfWn7TjLo0FqVUddcBP11Ibr6TottabqtUCY6JB7rMJRGyVbbeVF64dzK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdehieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpedfuegrrhhrhicu
    mfdrucfprghthhgrnhdfuceosggrrhhrhihnsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpeefleehkeehleekjeelffefhfdvleejteehledtieduffevteffleetgefg
    fefhjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsggrrhhrhihnsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopedvtddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepgh
    hrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepshht
    rggslhgvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrthgthhgvsh
    eslhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdhkvghrnhgv
    lhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehtohhrvhgrlhgusheslh
    hinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghkphhmsehlihhn
    uhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehlihhnuhigsehrohgvtg
    hkqdhushdrnhgvthdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehprghttghhvghssehkvghrnhgvlhgtihdrohhrgh
X-ME-Proxy: <xmx:XjrOaSRhykJvd7wor8nu-Qighu2LFb8TlDBPnvMhoBeS-NCc_MA9Rg>
    <xmx:XzrOae1K_ci9GBRM3cJH0wyrF2n_yik61Ryc0VWsUTTP_4R61WtIcQ>
    <xmx:XzrOaXj2b8fN_Uu0RDk1Kdg7GyzrC1ApZNoAkxV7sO-qIFSS36PtpQ>
    <xmx:XzrOaUZ1ypJwG5Y9w6-CF1HCyImbO9tCAG2acqRJWyb_Q7L6_FXeuA>
    <xmx:XzrOaadPIxpb1Qn95hoWEUPAJNus9Fcd_q2qE4TuGLeMZK7YncJlDpZ_>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 Apr 2026 05:43:57 -0400 (EDT)
Message-ID: <f06f2716-9253-4be0-a2ae-d555125c1457@pobox.com>
Date: Thu, 2 Apr 2026 02:43:55 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/342] 6.19.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260331161758.909578033@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-232957-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pobox.com:dkim,pobox.com:email,pobox.com:mid,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 31B703872C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 09:17, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.11 release.
> There are 342 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on 4 systems (3 amd64, 1 arm64). Working well, no regressions
observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

