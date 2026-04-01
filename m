Return-Path: <stable+bounces-232751-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJr5HIX0zGl9YQYAu9opvQ
	(envelope-from <stable+bounces-232751-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:33:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C208037890B
	for <lists+stable@lfdr.de>; Wed, 01 Apr 2026 12:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AEF8630BA506
	for <lists+stable@lfdr.de>; Wed,  1 Apr 2026 10:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F003E9281;
	Wed,  1 Apr 2026 10:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fay0d0wG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RglUUkiz"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2499F3E715C;
	Wed,  1 Apr 2026 10:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775039208; cv=none; b=N5fvmRHhqKOkiaCNDx08+QU3HIRlOhilVf1lKxZRPBKGHeRlm5RFbDWtMN1OZgY9C8wgdaFfwwW13dplck19hNoJl7FAmw5kjSnt7/JS/+9Z54qTRYa9Y/qYpUUWbMpIP6vUAIwrhotYEOTxbQYluOS/m2w9wFk/v4tMVlHOxw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775039208; c=relaxed/simple;
	bh=qYg4omQgzuOE+gP4e8SM1mCN0nyRYHc/epEwQhb1AuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E61422oZsLCO57mlAd5y+yNX4hKPwpU0kAEjCFHa/Li6BpuuQUneFB38m0/LDkx/Lw1uva2BnKsqr5UEDOOqQspShtRb1ENEN+kyubeVO0c7BXILvpX88yXW1AJOoY+i1kePURRGu2K/QYyUdczrHUoiMe4DZ0ircbORspNBX6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fay0d0wG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RglUUkiz; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D21914002B0;
	Wed,  1 Apr 2026 06:26:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Wed, 01 Apr 2026 06:26:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775039206;
	 x=1775125606; bh=nly3ocXdIbCzHD2R31qh8gEREIXQ/Mx8+1BwzEH7Hik=; b=
	fay0d0wGatjvOsalwsgQb+EbrHSU8HEaWFKMcFMgPu9VivjqQze7ARP2NBiVOqsd
	t5Xjke0rnAJMrvmTc74QmmJmAYUMscOh7NWk1dAZkefkN4jr+MzSODDT8iUsiAmd
	O4w1HOndhnw5AZZIgbKgELIiIZyN0bMMI5FMDq8gXqX18eDkwkk3VRnEtwKxHe9G
	wS4VbmAEgPDze6Bc4sP//Ha3hzdt87drwKuJq73dTJo60xRUUSySR+Tj+DNOfGej
	Es9GaHsTcUcZP1TrNnZLkKdoSP7PDBTePVHSWlPusc+ho1lGPzcH+sBhfqEUwttq
	n6HBLiLtcsMylptmGLAv7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775039206; x=
	1775125606; bh=nly3ocXdIbCzHD2R31qh8gEREIXQ/Mx8+1BwzEH7Hik=; b=R
	glUUkizWoXjioO6ofeObeG5u7ORwBhhYy5uH+cca2xg2h4zBymNmebDxXcmDqYIf
	fZoq9Vs/rIvFP8Y1JGm9joWP5k7JER/SqznChSd0rYC4j4JAwC3dYMqDclWjlCSG
	mYjaq9caslbYGVPF3M0Ij0u0KMJmzT9UIUv42Nxgzoqp42cYD17f6cllR4hw5itE
	Driv15SYOXqb/HEdJReutDReeDx6X0+Kophq3lLIx2GtsKpUHnGHE/Hvbfb83MFH
	WEpP+9mZdbFIV1XBk1TIVwLBSPcWGEvfZvs8IbeJV9GahCAx+ujKerfgVRv7Wil5
	+5W/MPMmQ9FhKfQZYudLA==
X-ME-Sender: <xms:5fLMabUr9r8ys3woqCv4fQq7Zv7Cai6j68QoxYznQrwxM8ybt3xBdQ>
    <xme:5fLMafeI9APPLN3nL-SGwTmvnWwJL8vSMi4GwfLXo2VpNf9REzBn5ECz0KJM98jcQ
    09FjV2ToilMAGPygZW78RtOII2ym5W-Xwv4G6RRc8KlGk6EqakQlA>
X-ME-Received: <xmr:5fLMaS4i9OCWotOkrfdJzAcu1yE3WZK0yLjj4Rx32xJPjftLXKoxG2UGg-hXLGC8Fh36f3A7AynDJySN8jLYEeoXGE3w0w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvkeejucetufdoteggodetrfdotf
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
X-ME-Proxy: <xmx:5fLMaaTLgtglcFGXuMxp5NUrUR0ShT3Rb5kcZt-YTBNE59ZWn7Tv8g>
    <xmx:5fLMadfFQSFqfpSG9MIhSsUCBIzEARg08dxvbdDVxp511yCIziBBKA>
    <xmx:5fLMaST9T9WFf4WNnSn4pGrSowUuMjaIUBnPr_TOcBEecoq8m21uUQ>
    <xmx:5fLMaeNBd0_eVR_5f6wmlEmu1Gc1g3ZvLZ8AqKz-_9gXrC5HQoZx4w>
    <xmx:5vLMafpryu5JNjmyQtFbAeVKWaWjGvXsilwvOkY2jsgZ28Pl5PGVtMg2>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Apr 2026 06:26:43 -0400 (EDT)
Message-ID: <33fa2d26-3309-42c0-8253-111d78753690@pobox.com>
Date: Wed, 1 Apr 2026 03:26:42 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 000/175] 6.6.131-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260331161729.779738837@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260331161729.779738837@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-232751-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: C208037890B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/31/26 09:19, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.6.131 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu, 02 Apr 2026 16:16:56 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.131-rc1.gz
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

