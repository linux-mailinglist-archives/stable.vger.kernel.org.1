Return-Path: <stable+bounces-238009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GOnTNNv13mkCNAAAu9opvQ
	(envelope-from <stable+bounces-238009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:20:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D72F13FFB4B
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 04:20:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 510B4303C63E
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 02:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E91422DB78C;
	Wed, 15 Apr 2026 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IgIjcwec";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VyLC3DqJ"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5576F5477E;
	Wed, 15 Apr 2026 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776219607; cv=none; b=oHUCnIk+MVcYCzv0Y0GxaQt9mwQVI0tOEqqyZFnUtqSHy+5nZGyGWY7OUhw2eB7nUoKBlUUbAutp5sg5BX0oMkCHV6VvuoS4J82YYpJ3kxSNT+AYslmvr3hyiNG8//5ocPaefeZ2H3fJG8HbRLMLriD3XxInc07zqbtM0mO1VCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776219607; c=relaxed/simple;
	bh=qpzKRfUSFGDR0tW+7kxkH6TC/wOhrSGt3Cw8zvuzyOM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KP/VVgk2NR+wYrLla7yoCFxz4RTs6IKbhmB+eomfqLJOYy36e6jAN91+kT1B3doyjEH6PaYGHpRNJ2UJupgMWjc2HYdNISrm7uTGBYhWu290P/qEy11vqfSOe4UjVlrpsPgqXo+8/8kNuwvjcSMMH0ZjFKko5OB6bjMVEyh2oWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IgIjcwec; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VyLC3DqJ; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6C07B1400082;
	Tue, 14 Apr 2026 22:20:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Tue, 14 Apr 2026 22:20:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776219605;
	 x=1776306005; bh=TYqzbA6ss++6e6wVwIkKBbvcY8DcHSeG+6xQS+AxkRM=; b=
	IgIjcwec39gUg1pl94vABHnNlnwkJHXF73nbPmmMdUHTGMr46hxPKa80aJ9KrnFb
	L68fV+UwjiDbSC1KMBULqJjjd943orYcUJ0pnysBY7aLwpcD+Tdjp7IkMCbDsRqI
	tvBmmOPUx3k7K7ntfzEA4IAwhqhl/8RG8xcoxF1V8mL5pbmu63qyA61XVwUgNneP
	qzidLIWxJ/nXsvDngSI/kRP2VCw4dj5nSXn3A1y4LuQ3j/me4CJCkuXhHNGXgd2W
	+nD6cYJFOmC4cvg/6vskFU8VXyF8V4u/PvJwqZ3OEI08WC+7Di1CF5gOomGAgFwL
	W43z5yMb7wQKaZAD06UjOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776219605; x=
	1776306005; bh=TYqzbA6ss++6e6wVwIkKBbvcY8DcHSeG+6xQS+AxkRM=; b=V
	yLC3DqJDDOJfcJE+Z5rrRlVc3YuCu1Mbuyia9JHx864Z1eDaMdrHs9Gznhz4nTFf
	XB8hghrmD61IDV4bZBT0YHR6DXZaK3cx3hujuC8dvebpVgySho4aiR8TtmIH+TCg
	2ItLEZ3klGTuRQvGzoCJdMR0wm0MgOq5ZvG1WV+xq+OQx/At38bFK6zTyeEvV7nU
	0B6E41GYilDmaUDWKqH9WWK/bSDl0g3NtL+QV9sYqGNX/fSjtE8vXCpxjD3fR4x+
	nid3ZCMy4K/OTgq4TDqKpm/6/y5esLIaN6NYELxFxlPTyAQZWREwLeN08R7UElPb
	ZQ6uzjJl0epVkP/34C8aw==
X-ME-Sender: <xms:1PXeaZ0GuGbDzD0__edYRDXt2Ujsvf-4sIc6AVG6558vZjv28utAfg>
    <xme:1PXeab8tCy3MI_I9gFdH4Rmg8KydAnUY4I2YqRfAdU36upk8AHK-L3UIeye3J-PN9
    lf0sVDbcU8w3QQKzoY4pkT2kMWPqwyEw9gu81xzbLIklRs-9pHbTWM>
X-ME-Received: <xmr:1PXeaVb7AxDoYBuyoscPzm5orr1WirFWGduXvabnNtH1NJWjvzubn4txpld5DMWt49sY9UPgo1iCGl_xaWAiZj_pwD4Ni1rd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegvdekhecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:1PXeaawxPADonv1w0piZfdwq9Ud0hy4cLkRgW6kmjRTLvA7kfdp1WQ>
    <xmx:1PXeaT9nPZy7QqxSJBiUVKgce2h5UOfPok_ex7dmg_5uPxOzsGri0Q>
    <xmx:1PXeaWwmV0GtKLAtlY271sC2seZbV_asFXVp0mHJTN9NbFKm-fTekQ>
    <xmx:1PXeaYuF-jvRhkyuW6ngC50GbIW77JRPWborDkDGXLvdyA7d4GPiCQ>
    <xmx:1fXeaaabktyYoaUJP9XS-_1cxyxpE_PRia4uzmaaHlKAGzzcM3JsQlP2>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 22:19:59 -0400 (EDT)
Message-ID: <fec7cacd-a410-4d16-9374-2b1c2b4e00cb@pobox.com>
Date: Tue, 14 Apr 2026 19:19:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 00/86] 6.19.13-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260413155731.568515178@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-238009-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D72F13FFB4B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 08:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.13 release.
> There are 86 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.13-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on my amd64 DIY home NAS. Working well, no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

