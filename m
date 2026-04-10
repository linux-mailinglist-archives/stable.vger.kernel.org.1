Return-Path: <stable+bounces-235670-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wlrXABpz2WmSpwgAu9opvQ
	(envelope-from <stable+bounces-235670-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:00:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB183DD136
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 00:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 83178300B473
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 21:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6451F3DD51E;
	Fri, 10 Apr 2026 21:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KhzMWRpN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YQ6DZwT8"
X-Original-To: stable@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61DD3B38B7;
	Fri, 10 Apr 2026 21:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858308; cv=none; b=RGnV1pr7DWulrwzN2sxc0mYd8xNYcRyZ8PoKMdTL5LDVrFGtCYAQ4sYuaTJ32cjoumNgtA5B9wU7waK/CXmMrNNEXGblo3nLWBSOSugVCyfJ+ygAXGJ6jzUsSwXtCnMpA8G+5EKnYm5eBoMKLQ+LNjaLVOv7RcvqLDdy7Rz1Zcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858308; c=relaxed/simple;
	bh=aw8TOKkE+5QyIGiF5qlPUgilCcZuHeODVen8Sg+YsJI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Osv6gtxpv8+N0HUxnbFqdNWCDbOScn1ZoVsaYJ0buyB1h+qLHfyOLV5wFO1Xwnhc3O34P2G9eMT2+BA6SvrsrKVth/HEV9bgKOGbxnmNj2GWOK4F/5MW+el+SF8IK4WxrJKA+DJHiAt70S/v7mvAp/kjMu1PmIJWdq8Mb6jlB3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KhzMWRpN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YQ6DZwT8; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 93F211D0005E;
	Fri, 10 Apr 2026 17:58:25 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Fri, 10 Apr 2026 17:58:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775858305;
	 x=1775944705; bh=FmE4y9ifJWsccxbLkChS2A9WBPeo+cWUSgVE5dCIPwA=; b=
	KhzMWRpNBFbqy06ZhE7+v1VZSSYTH4plNL89QCAMsZvR9P7XGatwxVlndE6+zD9n
	K83HqAuy0H4Wt6xlouT1IWuJPhUoGx6zA1T+mOEVqIvgWzP99ItXme+jdzJOOyzw
	UhXLrKxincpkwb9REWtVOdbpUaMjE8PstMgTM6DHHcoCj3lw0NDoUV4M1C0sXRxA
	IH9TcK1cu+toppDbcFOb3PGvSfoJUGgPyflOh/nRxYW+Kg4gH1QpLtGKukVfXYnF
	6CXHWYfAKKnezOc0lyy58FwbC6wzbb5sMW9Vih5rm32jIdx7mxUg6Nq2KyB0/dFm
	7WZkVr7BgDhxbGTgsVcLsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775858305; x=
	1775944705; bh=FmE4y9ifJWsccxbLkChS2A9WBPeo+cWUSgVE5dCIPwA=; b=Y
	Q6DZwT8P9tYJ4LR19iFmKmw9vxhXZI+ltdUg1aGoQwl+6Lj70W0nri7twTOTCdTn
	L4395s1PirlQBU3trsEd9SCvbSb3TRHV51dnXqUZ6wSfDNkA/ky3HkP7/Yqpz6JN
	0mnbhVlS5I6fFW8UTwWMY9sh1m+a+pM9TVvX0/pXSnAoWjZQljA2koPF8fjEk6Yv
	TVFvkCXxFXb09TVK1NbbS1y1nVKvOYpV86D6cb29nR0QtspwPIb+/o94grZ+Ks8W
	58C5kVfl37JJdVz8DHF5+rJJ4u9IVe8Nl9ByQA2EnX0HBe2/fghjKes/uOUHWZDt
	C8RIWt0s02Z20NUyWnSRA==
X-ME-Sender: <xms:gHLZaaramTROBJgKKsLOLabWIdpBQnY0ATVmEgMuQnNXusSggj_XbQ>
    <xme:gHLZaUglsnxyqy6S_PCaMp_v32BEwIqNx_3VuYF9NeUOBn9H0NhzxmLEyFpq0RFNc
    vFkF_7FTTtIKhhukecqN3xQdAhmm1tztTsyDNdGno-JbZ2Zhr9_nCs>
X-ME-Received: <xmr:gHLZaat2zPxwUhCMy14aY1SdqVPJUJsJuM6y42xytH-t2DCfEfzKFHYezyz-xhi8jLmcKRvkZma8gOk4VaiXf2kdmhxXpx3L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeftdehiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:gHLZad0Sw1jPGfXvgiPlZJRVMumuA4AEv3NAUPbWls-0WRCisBsbOg>
    <xmx:gHLZaRxPKZODoa6f5DgcqNby76i2-tW8GP1evh5nUIpuhlqhPxuNXQ>
    <xmx:gHLZaYVt1buybkqWqlwTu8pnTllzPmXtxCBLBwsZL-xGreZKM_Wptw>
    <xmx:gHLZaTBBqxAVarI8SKfgdU8da1M28Ro-uJyBHGpGP-aq2bMLMbcaPA>
    <xmx:gXLZab9iGSymeg5efbUO2q-Ppw0ufVDbmgf87MWcKcWOWgCAKacUKl7A>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 17:58:22 -0400 (EDT)
Message-ID: <dcc48de2-09bc-40af-9370-57b29161db4a@pobox.com>
Date: Fri, 10 Apr 2026 14:58:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/160] 6.6.134-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260408175913.177092714@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260408175913.177092714@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	TAGGED_FROM(0.00)[bounces-235670-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3BB183DD136
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 11:01, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.134 release.
> There are 160 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.134-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
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

