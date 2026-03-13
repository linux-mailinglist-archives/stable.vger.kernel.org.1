Return-Path: <stable+bounces-225281-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IC2zLBTus2m4dQAAu9opvQ
	(envelope-from <stable+bounces-225281-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 11:59:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D499281D8B
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 11:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04162302E795
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 10:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4959638E12B;
	Fri, 13 Mar 2026 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g29j7miP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TVnwGrUb"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010323358BF;
	Fri, 13 Mar 2026 10:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773399387; cv=none; b=YZPrkx7KYmkJYMDL5+gvC932i25GDLrMr6tKTB5DIs0sjriwbe3K1Xs+amvGcWKoYN549qhYKhDFKA5FjpmzkUnlddYVZO+28AzWj5BoSnvkMUjDWB9vMAb1m49mwSmsZnW0T5inIxe0yRfiFY8VJZe/zfMrz2P2XjZ3PZ5ueps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773399387; c=relaxed/simple;
	bh=5ZPjRv3+kuZW9Wbf/xiO2oiJBprplQtqQqT4VhXdgT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I638XNDo7JEEFVCJ4MGjlHEkfmLPIGyzHqkuM067+MsoCu/oBnJNY2jxklr2LpkBr7ZgQBhig+N2vswo0D78Q5WyiEHCw+nFD9h1x2ge8+8+FHe2nh7MALwEd3hvu4sY+HX6LE3NQnSyJqTQcrzPRxaHiR8eHsS5ZpHJlyaMsGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g29j7miP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TVnwGrUb; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id AED821D000DD;
	Fri, 13 Mar 2026 06:56:24 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 13 Mar 2026 06:56:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773399384;
	 x=1773485784; bh=S0t6i4/vUos1Wl73D5ulyMe1xjx+cP7BeAJ+Lf55VNo=; b=
	g29j7miPZOni0F30xpiEKbjsETCsmabcj72rjs6cE/JglOhbpTqSCOZ5bDKtG6sM
	GCpUvAjgshHuWezvRHG2MMEZgKrBGfvgcNnz1o2uwty0d1HhR4ecyF7FxN2Db7Fc
	oEg/0Ko2tHkADJlYzQ38dx9IgThfWZRpjUJl5cHO2WdHpeKMThmt6v5CULsrxvJ4
	AdtJcunZcO4OMadPeiFlFKPegGNNdE7AAkYtcSXHLkURTpPqmIHFU9XZTPl/paWf
	LAH6wDD4lP8vOMO1mvLoUPWBriWGZQvEsuUeDTzZKfwdS9tzvGSxK+XdhXTUC6wX
	6cbxqR5n6BINGx+Xp0mhxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773399384; x=
	1773485784; bh=S0t6i4/vUos1Wl73D5ulyMe1xjx+cP7BeAJ+Lf55VNo=; b=T
	VnwGrUbaJAFAiScSGmrGgWZ25Ej/BioN24Fkr7cFoU4sJwvegA8owNMkReYjDiNK
	iKd2SqE9BnvJ10wjKaCwni/yJIq5jKq3ECM9PGBWg4L9NWTjYATRRYnIhqXLRStd
	ZfYISWkeFR0aD2sDxbYI7Gcw4375PNPn49gA3gMbs/RYHexwdul9qiT3gwXb0wJL
	KGzMYUJ7oc+puL6LuYMRycUvskmzTUd40WjGM0OEF7Pj1S7ZNeR1QmOSbqAs7yQO
	g6JJEdVwMCPaVq06XwvIhEaPAP0g0948ikFTgZoWHiMg+Ey38Lx1W3rVBvoT5gVT
	7J7p4Arn4cWuq4hejD53A==
X-ME-Sender: <xms:WO2zaR9vL7SPwCrvebC7O5F93aQuQBzHroZHMjxFry69hWW50ffZuQ>
    <xme:WO2zaRl5n4ThmRrp4IN7rw0LFHy3taKo6xph77fODmLSF-dazL64gXG49_qcMhgdS
    j-U4TZSmjM1uy3vAzFF4w4RJCTFlgmGEF9ZdkXoQnUFVOf0T2JifM8>
X-ME-Received: <xmr:WO2zaajs0hhLv5Ad8ODv2Apkzc0A7X2WKe6DwuF8DcQeOuVvNzrxQzizJOWTUUQoRMudZSotiaT9jvqjTJbwRlyUh9wpfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeelgeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:WO2zaZadwEAlWCzO7ED8cXUm90Z09d0tuTP4XBNtQ4w6S9CqAV1JsQ>
    <xmx:WO2zaeGVS3WOFK-S50gsGqrR8OluaTIDocFJ71U6n4UiDcyjefqd0A>
    <xmx:WO2zaWaNnuMeDVf36194XJYxEz3sKmfM85eLMcnCNpv7wZBTqheuCQ>
    <xmx:WO2zaf35XTW1zIvREC1m7GYdV7WQP3ifKflYUTHv7Aw3U3oL3y3zLw>
    <xmx:WO2zaQRXPCRhpRpuRA0FB9CLui0oAcWSEXs3WxIs5KcKfiJk-SBExqT->
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 06:56:22 -0400 (EDT)
Message-ID: <16804b0d-631d-46cc-b983-a8f1f4cb05a9@pobox.com>
Date: Fri, 13 Mar 2026 03:56:21 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/13] 6.18.18-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260312200326.246396673@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260312200326.246396673@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-225281-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.com:dkim,pobox.com:email,pobox.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 1D499281D8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/12/26 13:03, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.18 release.
> There are 13 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 13 Mar 2026 20:03:15 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.18-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on two systems (one arm64, one amd64). Working well, no
regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

