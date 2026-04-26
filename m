Return-Path: <stable+bounces-241156-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFDyH+a27Wl3mwAAu9opvQ
	(envelope-from <stable+bounces-241156-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 08:55:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FFC468EE8
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 08:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C366300D177
	for <lists+stable@lfdr.de>; Sun, 26 Apr 2026 06:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3C92E54AA;
	Sun, 26 Apr 2026 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YaHJbFa6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sz2PiJ2p"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7442C0268;
	Sun, 26 Apr 2026 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777186527; cv=none; b=C/lTf9xH36uTQLx/4GVwesn03fFITSVkxf+db7a4J/WMUl190/Gwh3dmnuTOxGwF6oZJ4pxVf3CdUbSUDmIJ5mh4pRbwmoML8+wOhvyLlx2tfGjg4+CBp5N1t99ccCEd6rUmGINtRR9Ezbrxas0bQLapMufETtXccq9d0xRzIzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777186527; c=relaxed/simple;
	bh=/+IdPL610OSCflZSmx4fH7+9DZGwOsuqOGwe07eTygE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Efsir6tk1Nbo5ZMz4x1jcpuyN98qWpv/CI0RbC9CBWGPndhMrlVQgCZVFHAmu+trxAv4E0UvnssdgQwfnrR7Onne6QguErIQ0ucyrn58dVuH45aKZmoq/GDIjesorXt42v9cp3JQwoFnILZUKDKysCikL61/abdbDnOi2aPQZ9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YaHJbFa6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sz2PiJ2p; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 544457A00AF;
	Sun, 26 Apr 2026 02:55:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 26 Apr 2026 02:55:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1777186524;
	 x=1777272924; bh=9PCe1qOiwJtrRkEea9STXLTdvJc0Ofd8R+guhuEdnXc=; b=
	YaHJbFa6Kvtu9mcCkZ2X6NjOKyIIDaTWo5n1WUwh8VHSS/rJzV1TPBroC/mEOwqM
	O8fFuiJZpGaMlieBeLtsFZVAmVy2TLRNhrBSTB/Tvp/n6KYevLOtjWc1Zexm9N1Q
	D8nPzWMIkDpwpwXgRd+dE1MiFh1BFzM0gGLi/V4VNU9eU3RjQ4jmKveUKRs3SlfK
	+stm0RAloNHIT6XMRP9VzfMmDsgwINMycFdhdE76iC/mRExRx/dkW6HG7lky+Vif
	Th+NlZSWgjex8rGtAxD1hJIVpi86N06Rk8JexljN+2QK5+paVRNRn72068RSlvi+
	gDOQ5+Zi9RUmpY6cmqIoDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777186524; x=
	1777272924; bh=9PCe1qOiwJtrRkEea9STXLTdvJc0Ofd8R+guhuEdnXc=; b=s
	z2PiJ2pcVjPsk4VNCmzNDUZn83FqvhOSGI2foXqNUyVfNCnltte5xXTNMy2G2N0/
	q/Up8QUqWmlnLapNiS67Dm8bHqZ8fd91Ffr1bTpADeHyIwkBJY3L6HRkArOiykEE
	4P+TKQWJT+tNMfpdyqCUM7sGsfkd3ILln6bLn8VTd6ETjUrD/8I6GdZX5prDRfiz
	Xm313NSNZfXuPv4u4oFnuRYH15NFuBwNqX5cj5tM4Jng+fjiztDlrRTDUxyGQ5CY
	MSOzifpZEKGpF5gfuAXapBdvmd3iCn4ivDf7g4t+BxhRtCdvWwucY6gNGoBxztg2
	S0RM8lfll3DTGSEcPoz6Q==
X-ME-Sender: <xms:27btaSLqAnq6WpNUkwXvhy7lgR0k_J4J1_cyS5BUuPfLo1iJk-UDxA>
    <xme:27btaWCL88C93OakDc2h0qHO1jESPZK_5sfIOB1nSCgj7AUKn2MGZj771unXG2hYv
    HBWt1Comiaft7nMPU0jRbrtL0sDz5JGletbd4poOp-Ra6hK8NloUA>
X-ME-Received: <xmr:27btaeN-fryWbDwDoCQ990KtdHBusjvIyu6oXLqJOiwr5ueI1flG2Q0EdV_eOeiCHtTYnGPBneX5Zd6EmY7CjkXurt2T20xk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdejheduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefkffggfgfuvfevfhfhjggtgfesthejredttddvjeenucfhrhhomhepfdeurghrrhih
    ucfmrdcupfgrthhhrghnfdcuoegsrghrrhihnhesphhosghogidrtghomheqnecuggftrf
    grthhtvghrnhepfeelheekheelkeejlefffefhvdeljeetheeltdeiudffveetffelteeg
    gfefhfejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsrghrrhihnhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepvddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopehs
    thgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehprghttghhvg
    hssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplhhinhhugidqkhgvrhhn
    vghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepthhorhhvrghlughsse
    hlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegrkhhpmheslhhi
    nhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheplhhinhhugiesrhhovg
    gtkhdquhhsrdhnvghtpdhrtghpthhtohepshhhuhgrhheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepphgrthgthhgvsheskhgvrhhnvghltghirdhorhhg
X-ME-Proxy: <xmx:27btabXikg6C4mD29072KcoV-GZcrSZpHZQChUAq3uOuZRT_L6MknQ>
    <xmx:27btaRTegJwInHf4m4W2P-AX97NwzpTxuO1Nld1ZNkv_xSNtUbqegA>
    <xmx:27btaR0dMD1X9mZZYA8Gzhgw_I3zAY71B441DXrIAcxMNeBcAKvDeQ>
    <xmx:27btaeiUKk49KyWZoTEzmUt4qYWnY0iT6lKryvDE-MznC21Zr-sEgA>
    <xmx:3Lbtabf1Mg8z1WhRvA1psixXlp9L4JdQB3M3uHWTd9VbG4rNsyOGIaqe>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Apr 2026 02:55:21 -0400 (EDT)
Message-ID: <174685a8-3a2e-47a8-94d9-7b71b3a752ed@pobox.com>
Date: Sat, 25 Apr 2026 23:55:19 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/166] 6.6.136-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260424132532.812258529@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C1FFC468EE8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-241156-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

On 4/24/26 06:28, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.136 release.
> There are 166 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 26 Apr 2026 13:23:21 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.136-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

