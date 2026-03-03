Return-Path: <stable+bounces-222826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKTrJYOcpmlqRwAAu9opvQ
	(envelope-from <stable+bounces-222826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:32:03 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1178E1EAD1A
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B25693054BA6
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 08:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24A9386548;
	Tue,  3 Mar 2026 08:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="K51jjfbA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VZm429iv"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4103845C6;
	Tue,  3 Mar 2026 08:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526693; cv=none; b=AMjIalxxJUvgIwIsgGT4Fe5PLr9LVhX+TJmx0PyP2qL6BCb+2Xb/RR818b4+M5Gh3BaNLwUX8tPmRot+YF4HA45fP/WgK6TGWVsaxzeBmJ7UaVDG6tEDGizNnWN+H3fOrYInDPJcRB2m61gH3geoIUEtJ5cpmmKaHC3MMDJ/xGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526693; c=relaxed/simple;
	bh=Ki/OJPffb844O+vTtB6WCYGxVXcZKdwWDSXsiOrfVZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=upYDCfHUd0QyKvYp83uk4Q+VuA/XkjHCX7u/ZVF6MI91YQzMBUv7pQiFoZU9Ab/D66IvWCoZtX1mP8WqQ16X2whrXRPXDqFjWAq4Cj+yBSelrPu9ZtX2OQXxzTAJb10zok5Bj5t50LGUt+/KZcPGYiC6GeU5z0c017Zi6bcac7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=K51jjfbA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VZm429iv; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0ABA01400051;
	Tue,  3 Mar 2026 03:31:31 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 03 Mar 2026 03:31:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772526691;
	 x=1772613091; bh=jF8P8AkCF4V++kE9eDOyXQahSASYk5G5v2HjlhpRmIw=; b=
	K51jjfbAPP4gui2zrzzXz3QsdhuSe5LE0Xx2mfB0TWOE1L9wy7zRGCs3dVsBph5K
	Ekis6GR7j9SYF9z8AD/9ZYAxC7VTOqTL6GKrXk1RpNqsNxM8lWawaTgV2ymEZ52K
	7s2Lsei7+a8deX9KVUPG4uR8E7SMFYNhZiZZSW/pmbt0sR01Dd2In2Q/xNoJ1CET
	b9DqmFFAwJqezh12fUSgqp7boZxvHkoYm3Hq7YL69QaJuUJLMLmCQ/P83rAkkXQG
	TuxMeY4Ktrj01/EM78oknDJkwiqyKyEEQbyg3PXdN3cOKaxILW4Qu7IUzvCO8wcn
	+zTjHBTvY37XXEaRxL1/XA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772526691; x=
	1772613091; bh=jF8P8AkCF4V++kE9eDOyXQahSASYk5G5v2HjlhpRmIw=; b=V
	Zm429ivd/qi1RYr1c7rXILg8ib/VF5hsavFhQIzLRFO3evWStyPIugKbyL2E7u1p
	MyAvNZUwEAnpHkSvNi/9qIgmhJG1kgwAdfLDWJ4Cfag5nhSFaDjXJgW0yRoK/DXt
	S4oZji6DojxyCGOcOTB0tipCmRVt4s7IopqHXp4sQF/y1eK5zjasVrWgV/OzKjYX
	sWHESF49okFejMcFCPA+TMs8IzEMrocvUwzPzt14XCP82tGSHwW9WTKFiNjrrC0d
	lrI/bNtanyV/RoowOyD2JdYbEsd1ONLl8M3dqU9GBhWXQ7l6rILLcLg7CGnBXmfm
	riRADwuR+1pDGCP40MzAw==
X-ME-Sender: <xms:YpymaWDX_yiAY3tgqFi03VbfSqXTGQpaQGunEwbf0lXNqeg5ag-K5Q>
    <xme:YpymaQ6o_eazreXr25jXJt7lDkZd6AyCB6RymiGS0cAAYiba3V5ZqciLo4mAoM-ax
    MKV7BmcL-d3q5uhgfr6PvwH4f4o6Cgwf046tbj4WKUq3YdI7azmpC4>
X-ME-Received: <xmr:Ypymaasvn841D3LnqV1oRUpm65ojxzdgLDXkJqjVUx14zcdzFR_loUySg4NLjmIffvq1D-cD5skzmZceTsNeFBoYJ2FgAw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedtudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpedfuegrrhhr
    hicumfdrucfprghthhgrnhdfuceosggrrhhrhihnsehpohgsohigrdgtohhmqeenucggtf
    frrghtthgvrhhnpeefleehkeehleekjeelffefhfdvleejteehledtieduffevteffleet
    gefgfefhjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggrrhhrhihnsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopedvuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epshgrshhhrghlsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsthgrsghlvgesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihf
    ohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehprghttghhvghssehlihhsthhsrd
    hlihhnuhigrdguvghvpdhrtghpthhtohepthhorhhvrghlughssehlihhnuhigqdhfohhu
    nhgurghtihhonhdrohhrghdprhgtphhtthhopegrkhhpmheslhhinhhugidqfhhouhhnug
    grthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugiesrhhovggtkhdquhhsrdhnvght
    pdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:YpymaQyfENhbsUQ574Nkj41I22Czbp7Xtn9Yk0i2WpI81-jJ2xryxg>
    <xmx:YpymaaaEN5ArrjkwX7RRnDakHhfPKZiYuk8EiGEj9wy3bNqJ5offpg>
    <xmx:YpymaX5GlDDCmysZzKrYbHBQ4VNLmZgkPMOsT9pBmkOuA1HZPeuAPg>
    <xmx:YpymaR7VxGwypJkJY6MuiylMG7WvvUenk9WwpNvoA0mpo_9GvbnjVA>
    <xmx:Y5ymaRuhbHDBYPnTmjuzfhJtB5nboU6dzsyydxJ4FB6c4qUO7CfCpfEr>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 03:31:28 -0500 (EST)
Message-ID: <1ccbd22d-2323-4f20-998a-3ab04526434f@pobox.com>
Date: Tue, 3 Mar 2026 00:31:27 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/757] 6.18.16-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260302160853.2519610-1-sashal@kernel.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260302160853.2519610-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 1178E1EAD1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-222826-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,pobox.com:dkim,pobox.com:email,pobox.com:mid]
X-Rspamd-Action: no action

On 3/2/26 08:08, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.18.16 release.
> There are 757 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:08:47 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.18.y&id2=v6.18.15
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

Tested on 2 systems (1 amd64, 1 arm64). Working well, no regressions
observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

