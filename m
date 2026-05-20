Return-Path: <stable+bounces-251335-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WLnAKE3xDWp+4wUAu9opvQ
	(envelope-from <stable+bounces-251335-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:37:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D9559420F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ED5943020EB1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E84EE3BA246;
	Wed, 20 May 2026 17:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LILcFKhS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DfmZeMtM"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2075366075;
	Wed, 20 May 2026 17:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779297713; cv=none; b=G+eVPXjTB8mLFiAoYWtTvrsJBiraqauy0EMKLajzd9u43w6PsxjKZx/q4oiFgixn71x3mAASBtkhMS911H5OwpcEm/Q5KPYL+SDRgT3SkGxc7kCnj8Da7YwZNMsXK7eHgXISuZofdiJYBaZlukrBNiSZzBcZKegxyPk035NQRdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779297713; c=relaxed/simple;
	bh=KEZN0tIdJ/tpCnij4TRWiS6/Ddt+vaax6cRZrbqB+lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I/9/KrfRCO04iqsmv0NM4RHLV7YRo8PqB0Ok3PxDjHdbWcDtcT6I0ABHe+UNCSMHlE84qcMHa/veMF9Vomhk0s3VJ9B2CE1dUVk5ADBMnY/6vQzcPsHnRttiCPyRZikckt/Lvqgr01Q1Af3HBHMmkA+BY6LBMb4QjV1vmmQ/SME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LILcFKhS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DfmZeMtM; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 432CD1400143;
	Wed, 20 May 2026 13:21:51 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 20 May 2026 13:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1779297711;
	 x=1779384111; bh=Bz1xSwgN2zbeFw3q55uypEc+uWclnHWl86UYq0jDTxE=; b=
	LILcFKhSlxV7+szc9tP1JuwIuYSBRaUqp35i5Fk+COOoIP9pwJLAIMjEfn07hXd/
	EW+TmE884jnaAxoMeIdR7gbLhg3Fw4wPpR/OlaFnDwNvA6Hqfm1/k8TEVo4T1J4x
	4TsHYr86MIqFa9AnW+DGa6rnmqW2h1XUHjNku01JTfkyadanVb/8B0eSVrKX+4Mp
	TypL2WJ1VpIgc2ZSnXq+uS7jOaFYcXvZ4C9ylNbJV4lmtviOog5QnoBVGv4bNeAN
	nzX7W21vL9zEUXY9JuYlzLikqnkyMP+KOmbru8VW4HNA+ecZtM9l6GkbmXjbK/Hi
	MXZ8u2jASdWvrxbeCzBXWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1779297711; x=
	1779384111; bh=Bz1xSwgN2zbeFw3q55uypEc+uWclnHWl86UYq0jDTxE=; b=D
	fmZeMtMrRvwH6NwZDxbBUvSLMHX2uELHAYfUYEMuQEK0n2IqrnnOUWKJcb4bNUxG
	5mhrRTu6RQ5VaNaPg1mB7ZD1byeoKziMakJomNMMrO8ncycP3Eb4b+tbdkwbjTjd
	9lUvYb/sb5GwV5T5O6yTPfbYrPX+DLj/pjsiyvtO8BEngHLwi5SKu9OBITnElQby
	u2HlMrV24Ze2Ac3TKUa4U/Jshp4EoYn8P0jenavQrx4RRiC9MRmUqmPN+SAguXam
	aWEt2SYovg5efvpUawXOdQWrLKOaTRKbcLJNPqjLhExbDeqvK5tsNJnyVnArGKtU
	xphfcEIkxE2cWt72OA7rQ==
X-ME-Sender: <xms:ru0Nao8S5_la2d9xmVWtiN0AAauCz45gEg0M-z379erESvshWWfpCA>
    <xme:ru0NauZH9ygbZBZyNFPnFOK79iY9k2_yeVyuVrY_SQB8XJCECARzZQJ0OkQLFZ39g
    ktd9Q68cJ-7EjxEP6C-jr277wrSRVo-8Jc9eX380BL6B4brOzPoZLY>
X-ME-Received: <xmr:ru0NavwqXaubKKRHUAzokGH_ok3xMRb66vOse6N66DVBHxnokWiMDvsIXasitJSkA4CP-icW_B9pheuw_Gmyw2kw5Xvy0hLd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeehvdduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:ru0Nak9uBU-PUjvj6Mg9LnMHo3T8Q1Tjf3_hR-VoUFeKYE8FljdZHw>
    <xmx:ru0NajyImnn1qGtZ0O1V572lo9-oV0X5O8VkuqTosG0GAzL71h40NQ>
    <xmx:ru0NahsLTEa6_xHVsCn2xZpp0Da-pgcQcxRSg4V6Mit4gA0jneVU6A>
    <xmx:ru0Naq2wTbEK8zeQuRW5LMaNt_2F9il1IqbmFB-7-fL7P6vPhJm6sg>
    <xmx:r-0NanYV3prfm3ULh4jKA2mUUiMYo8cl_f42MkwUDrHpitlyFcfNGxff>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 May 2026 13:21:48 -0400 (EDT)
Message-ID: <a30bbf1a-5f0e-4e28-a775-142d75494c83@pobox.com>
Date: Wed, 20 May 2026 10:21:46 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/957] 6.18.32-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260520162134.554764788@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-251335-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 35D9559420F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/20/26 9:08 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.32 release.
> There are 957 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 May 2026 16:20:16 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.32-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

I hope you don't mind me asking, but shouldn't this be 6.18.33-rc1, since
6.18.32 was released a few days ago?  I think you forgot to increment
the version number.

-- 
-Barry K. Nathan  <barryn@pobox.com>

