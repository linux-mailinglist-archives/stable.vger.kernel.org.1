Return-Path: <stable+bounces-246810-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sNIsHrdcBGrbHQIAu9opvQ
	(envelope-from <stable+bounces-246810-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:12:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7419531FAD
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 13:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A184305CBE6
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 11:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9233FAE00;
	Wed, 13 May 2026 11:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dqjF2fOt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FEgsxbsx"
X-Original-To: stable@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE7637C0E4;
	Wed, 13 May 2026 11:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778670756; cv=none; b=oN12fbao/IaoyMLVCSKipxx1H6feqd+wDsia7OMRZDwnshqszoB6FQFCXX7nBs+vXB8NRJ7GHCJ+XyAbaWkFngVPIfAcX4Il+EdQ/FmALZwcOUu4Ruy/+pWbeVB+GxdlBaRidVRMbQitV54IWCFctARUVZitAQlIQR93CZ/4cVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778670756; c=relaxed/simple;
	bh=/ylwYKaVpVFAkZP5opJh6xBmyiAu/nn4aSiCglRwa7A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hN4XIL7/ZciOIlAC7JDdgDoycLV22fa7jQSMeWs9skBehxPOIjkYy3PHSrHBvqVTEazr8nE9Vrmhy+Svu4hTVnk5/I/VC3Jke3J1ZKfDv2OFQP/MwJd0VW2upm51IPN4XRfA352e1sc44ygHE8t8FLQ0GEIAUY6M9Jvq9ClT3xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dqjF2fOt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FEgsxbsx; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F1B9EC00C6;
	Wed, 13 May 2026 07:12:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 13 May 2026 07:12:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1778670753;
	 x=1778757153; bh=rGRk6nUUQ5KQI+G0pR/AAS29d0HuCabY8UYtZJX0GhI=; b=
	dqjF2fOtTVwlskJJ4OBOGamtip7K0yVfWzuVV92N7IcDdueCyhGfRv6nqjdy6Vn4
	yBIGKRnmd4/71uorrJKniG7m2iiXUwp103lLtTntBldMME0jvAojtvnraEUhj39I
	sRjzY7FKH8Say8d2nKw3gbUwxPoKWRyIYCYY04XDxtETmHl8a/HEp/0M5W+DMLn3
	WCByIg2VPoEPWYpD8xL+JRrxbnvilMzWFFhneYHWaEjQjFqqrWIsYC7N8UjKuVIM
	H5q5aJsRHaFFUZq9QIhyrUyeRrM96T2QmkcnfZZG8qwLasdAdY8Y4pjRB71FjyJS
	oglHANR53+o2nYMdrymDcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778670753; x=
	1778757153; bh=rGRk6nUUQ5KQI+G0pR/AAS29d0HuCabY8UYtZJX0GhI=; b=F
	EgsxbsxLP+l8QJoIQgu/O6vlZ3HWMvU69Dp54DeM8xDXghjcZjPQpiZF6QL3lhAC
	8hY3+HbE1RJagq598iO77JU8ElIUVod8+CAwEVRssLKJEJY93gSmC0zqAN+ejOgq
	Tmn1yAWrWKOg7Lr+cEukeM8aks0wdV2/OEjZSrTnVano9/qUD9J4Xv+WrtdJ5zhE
	V2WxtqgLllmH41W1XG4Ok80ogkN3K00adLk+u2vFdukA3a0gIoXj7lRmNJUjQUWg
	B67P/WvhOMW/eSjAXEzl3TqGzeGSLNEIoRBwu+GUYwZhFOhv/UwsJzQWW4patee6
	Ir6hOATixHpzlg3XEX1tA==
X-ME-Sender: <xms:oFwEavX0OX7I4snavgQxhU97hlrKcH3LKIjeBNP8frYSTYgF8UjiKA>
    <xme:oFwEaje5oPRofiBTpt5RaOtlhnO0sM5EOPu8ebQMXYr7kiseSWO7354fX_zJbu-if
    Zlng_6mpvcQibL6b2MqxNSLXWJvq15xDG12AgmbJ8rOX3C0bGJslw>
X-ME-Received: <xmr:oFwEam4tngjgZF8hYoAC-jiRvVfnSZ8j1d7h7CzPwOxKcN_G8-pGrPVuLEUzKNRwgUz5VoWcsFg6SfefJ88oMl7cpPpH_XB7>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvdegheduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:oFwEauQVBWFUS9lGDtyLiXT55Y1zkL4WSw0P9_WRHez8C52L4Pxf5w>
    <xmx:oFwEahfjcELxo4qXkjwc_zoWs0D_mSYPKHAOXwxZ67fEVlDmj2l-gQ>
    <xmx:oFwEamTxpsFYQJJ-h2BUFw4w2-jN4k97OMTQt7NqWT9JhNGaqauQMQ>
    <xmx:oFwEaiPB7rr3ehBLXKanxB7Er8xXpC90eITu6Bolttf0GMsdWg2x9Q>
    <xmx:oVwEap5qRhuZvhjsxlmSsnt6eObXBsha6GnnMRwSsTygF8zFWmbqlnlD>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 13 May 2026 07:12:30 -0400 (EDT)
Message-ID: <3bb9e657-449e-4eed-babf-ad881308a5df@pobox.com>
Date: Wed, 13 May 2026 04:12:29 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 000/206] 6.12.88-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260512173932.810559588@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D7419531FAD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-246810-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,pobox.com:email,pobox.com:mid,pobox.com:dkim]
X-Rspamd-Action: no action

On 5/12/26 10:37 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.88 release.
> There are 206 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 14 May 2026 17:38:03 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.88-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.12.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on my Lenovo ThinkPad T14 Gen 1. Working well, no regressions
observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

