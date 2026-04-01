Return-Path: <stable+bounces-232646-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WFuUK217zGkbTQYAu9opvQ
	(envelope-from <stable+bounces-232646-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:57:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B7637396D
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 03:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F56F30293DC
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 01:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207BD2D781E;
	Wed,  1 Apr 2026 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ggJDtU0O";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OquKW59T"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2B92D8796;
	Wed,  1 Apr 2026 01:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775008596; cv=none; b=BNZpWBHX+/kI91E1TvVvQerWu0KJFzO3XExTu8879aanRuiyO7MHwwZV0wmGh9E2PiMyUtjCBQ3MCApoEa/VyT47wp3hayw8swjGpVoRWfaskN9Fzx2RRP0ybTdcEMhk2jfdQxXw2xOz+A2Yo2kQBnt8P8TrM61ac3qNDpS0Ll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775008596; c=relaxed/simple;
	bh=0PcZJ5VnMp7jkpbm971+ApzbfLbU08dwDsKnlT83D2U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NMwNJfANQ9pOSiOydDMDJesraYGewhjO4GVGvSRJ+cTuaNb/RO1du7KbSlzZVHGHq2sZy13dCrCDOOso6GhBb8SJUB9tulVqzRWNzEif6u/gTvLUasdMqN2d0+mU8L+6kcrd5KA92CQxEd37hBTgU2g1lnLt7rgeLfSPG3sZzSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ggJDtU0O; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OquKW59T; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 03DEC14001D5;
	Tue, 31 Mar 2026 21:56:33 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 31 Mar 2026 21:56:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775008592;
	 x=1775094992; bh=PJG3b2DUa2nKIA7SoVhxRtC3B4qi+WFinCqJ0q3opm8=; b=
	ggJDtU0OG3rZ6BRYPeurSH+9j1Wzdm1XSaaIT04wIkXWxJiQJcXC7PHe8ExAquF8
	KKHaJVObB8aCPKODdHiyaXECmFsY6JDkjZwHjB3Gpkkbi9MRJ9DsYC+z1WbFXhiA
	txwVBLp46Z+ywjE1Aa6vkCW11AZyKtzISXc7R4F8t/1S9NYjKa/EkyC71XKp+jwQ
	2YGfsfSa0APcsy0bq9K/ZPKWlgFqSYrt4q5FpMY3qgjgz3eNYYjcyJbmEqR98lfv
	VboYEABrcuy2GoZZBRpWKgFG+d94vyaV6abLSNAF1qxTKEKhZWQiK/DuCFktP6RU
	jMmDwlbuoeDRu/E7KAZhiA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775008592; x=
	1775094992; bh=PJG3b2DUa2nKIA7SoVhxRtC3B4qi+WFinCqJ0q3opm8=; b=O
	quKW59TrnEVBeNaXf1zJvgSeIfOjy8MaHmuw9mfDEj4sAlQFAD+DQeeQsTs15+uj
	FHFK4MtPe1TVhlJM04nDIr4UKlJ9V66SiwpgjkKkHGgPnMGAaD4cFHrmbOyoM0bM
	3xTD+nAJrE0WVECaoW2juAHQIuPaGm4fu6otda0pguwlsf4yxLxUmRXmlIIsCCFh
	Y8eXXbTAKwbJjFTN68+hTMcIp8FirOakytGAQ707xF3L83c3TtvbtL4of/k0ubRk
	Aynqn85hQeDN6jrIiPvUokySY37b3+oxbDiZIYU/SNLQeYIa8rOB5qyY3r0ZyO5e
	pfS+/3KPb57HXO27nYVfQ==
X-ME-Sender: <xms:T3vMaa6W-zu2ofqoKwfXwJqwSp5ektLWDzxqquY7ARjEYRdixHNdWQ>
    <xme:T3vMafzK6jvgZmgrYF7c5QKYiGv4FJTP5nb6sgByOtG5YpvaIqCjqiwGdRHQe5HeF
    Ogw1HNoHr6yyPLdEP467TYcx2C5tYGw5eK8blLRBpah8P3Jz5YaMN4>
X-ME-Received: <xmr:T3vMaU-8uiZV-pRjrmuzq6zPY8msxGOGc6fLG5Dqj8oFrgYTmBWfRfku67HjSTy4SSEaIB9G6Co0vKsC8lwQI2qC-e4SRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddukedvucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:T3vMabER-LD6MrMNDJIMjwUXvYxjqNGLvwjl662t_SvHF0KYewIdjg>
    <xmx:T3vMaWBHHIJC8mT1DU4F53qOSRWwEnXWDPyPWTRVH0jOVe1CVSb4-g>
    <xmx:T3vMaXk6Bpvvr1LFTWBsRJH0cQJIGZWk-IodVkCLw1X-i_l5grPXnw>
    <xmx:T3vMaRS9hXl1AftsdopuKBl5MBgAj_VgKxmLON1AqG7WQ-mnatGFNA>
    <xmx:UHvMaQN5lwUEaui6Qk3y6xSOvtNCU7C9yHlhXumFZoy_BVH6N_twnpj9>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 21:56:29 -0400 (EDT)
Message-ID: <0b7d4f58-2edd-4c92-9265-555c6e85408b@pobox.com>
Date: Tue, 31 Mar 2026 18:56:28 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/244] 6.12.80-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260331161741.651718120@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-232646-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,pobox.com:dkim,pobox.com:email,pobox.com:mid]
X-Rspamd-Queue-Id: 16B7637396D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 09:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.80 release.
> There are 244 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.80-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on an amd64 laptop (Lenovo ThinkPad T14 Gen 1). Working well, no
regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

