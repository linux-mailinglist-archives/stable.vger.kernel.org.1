Return-Path: <stable+bounces-222490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JnqDOYvXpGlytwUAu9opvQ
	(envelope-from <stable+bounces-222490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 01:19:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1528E1D20F8
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 01:19:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F2689300E3F4
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 00:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B429188713;
	Mon,  2 Mar 2026 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fcZ/ULfD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HmwzbWNy"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA158F7D;
	Mon,  2 Mar 2026 00:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772410761; cv=none; b=ab4p2zCEL0dxRXJi44k7HN7HJnk/5ujBQ1ST1D0lqb2tbQww02fiZ8id2QDOxIzec1nSz96CCipT0apv7d7DiPbZRry58qC7Lwx2hTzx/DM8g34NIsuz+C9KlNLQ+k3hGaitXaG1s1jixu1L9V9WZ/3ZIvK8cJ96HhNCE2uDGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772410761; c=relaxed/simple;
	bh=UrRKZ6udpjy7FRGyNBxTpigDMu3PdozIkrb8O05QVqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ATfQatWpMWaIu/uiWEXFnztKzPm56kYFmVVIM4Y+2RUzHqApXy8aHu6ghMdr7LvAto2Zt3e5mqHQ/c1dU5oK77g/h2jFBwnsYuRuztKqiOP3+khH4UwZhihvjhCZfzRLUpJbllilLpAfCRyUEsSbybagwlQAg2EsA/cGfadBXZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fcZ/ULfD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HmwzbWNy; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 820731400031;
	Sun,  1 Mar 2026 19:19:17 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 01 Mar 2026 19:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772410757;
	 x=1772497157; bh=rP5iPIFV5jE9//0Ar+Id46QM7ZUghPfG/34WKULZwCY=; b=
	fcZ/ULfDb56au45QQsNU0bUBa3jBQ5a98l5O1UVh3PzCz9ZiOign0+lHDbOrpqzV
	9I7/sCM4G/TQsgO6y1GUAB4F8M2LiC27ncxzYtHTBXphofExWeenMJQfTHaxOUdy
	1vOtDk6tAXxB64RxUwv1lnDj01RAtAKUKN1K62vzJW9jQrXVfCcz52V4t8CzClMj
	e2+qXIFJ5S03qX9OpSKR/qao/trEO8VN677qp4HRSoNweNVB+5iOnQy3i3Ag8tjh
	3MDO1o4O+JN4XvPtNU38PZqJ+L3JXh2tmfBEBf7/KyovKKvqAy40w2rzeS8pTcXG
	bCYJQUSuUak57NFp5/Ccfg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772410757; x=
	1772497157; bh=rP5iPIFV5jE9//0Ar+Id46QM7ZUghPfG/34WKULZwCY=; b=H
	mwzbWNybcjUpvPvzSMW/Z17Se4BJsYUlPJ+DJCguQczih6BOs3v10BwKqNtOPzY4
	NiAdSeCJLlNlM6JFVVNKOU96nHgDQJuGOfXEk08Nocpsdvh38m2grpvOaTpetWPX
	8/RS586xdWzXdNhOWZfrD+2F5EB+YUf9iR5Nv2OWD4wSJLwhIyttoSp7TpuUIOY4
	JUZmaKhZMPZDJgTPitinSmwtiJowhi7F8P4qOP4Ur4L218JJlVmHAB/2ZtReunke
	BCM2QvsDIpMrOrs0jb5deBnVs+UXFIFJANcceO3/5E4EhcCEvdhVDNWd+HsnWXn3
	U7lnwhCSKy5AoFWqSKLSg==
X-ME-Sender: <xms:hNekaVuSVTysxCL_R359lu7PHO4yMt2g_uIy_I9eSiZ819SCNAsmVA>
    <xme:hNekae3G3zGKoTarnH-booGnrS8TPNEIqpaBHzpo9kruSGzZvNgVPvP1lGaL6WaSK
    PSlCQ0kaNscRov5w2mMTF_unt4cvboMNwBafwgm8_B76VgJ0PgzgA>
X-ME-Received: <xmr:hNekaZ6uNrADgZIsV8bxc3tZMuTXxYHAb8diTUZVeMivSDTZCgGXlk25lLq4ySdaiTXMa-B3kIWSxKQ7gqP-0EH3ffSWlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheeivdduucetufdoteggodetrf
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
X-ME-Proxy: <xmx:hNekaYP-o8PWYXOPgRb0j1HK4GoMXb4LDT0IlXTmAroDynOoORjkvw>
    <xmx:hNekaVEUcHkiNrSy2AMdcAkwPePn1ufHb7-u_x-Auof3nuI5ygDNgw>
    <xmx:hNekaU0UYQp1BbP32NcOdmrHvRnZuRs_ulpt0Dym7KMyYYwa2OKVJQ>
    <xmx:hNekaUFwtGausI3Dj0gs0iLaXW6Sz2k6GBzyPk0I9itWkBc0XFsL8A>
    <xmx:hdekaWUTbPrPrgbuxNj55wMQhn76P0OLG8Tb9J8XkESnE9a-BrHOFVe4>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Mar 2026 19:19:14 -0500 (EST)
Message-ID: <b850e316-e13f-4bc4-996b-b4112f118bd0@pobox.com>
Date: Sun, 1 Mar 2026 16:19:13 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/752] 6.18.16-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260228174736.1542240-1-sashal@kernel.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260228174736.1542240-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-222490-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,pobox.com:mid,pobox.com:dkim,pobox.com:email]
X-Rspamd-Queue-Id: 1528E1D20F8
X-Rspamd-Action: no action

On 2/28/26 09:47, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.18.16 release.
> There are 752 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar  2 05:47:08 PM UTC 2026.
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

Tested on 3 systems (2 amd64, 1 arm64). Working well, no regressions
observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

