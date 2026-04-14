Return-Path: <stable+bounces-237686-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJabIoiL3Wm4fQkAu9opvQ
	(envelope-from <stable+bounces-237686-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 02:34:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E357D3F4906
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 02:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A12E30BC9AB
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5A371D5CC6;
	Tue, 14 Apr 2026 00:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="0yGxp9TE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fz905O3t"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD271F8AC5;
	Tue, 14 Apr 2026 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776126561; cv=none; b=K2eztqZ7ORxDKOXd+fqFKqhF4jrnCRPsoyyq2mKg25fWamtKD6ASdCiOf/LmSFLTR3PAyttSCLvMpaIXLjCXJPZCQv/V9m4+T9gUkvNZ+4dXr1d9/9HJaVkMqsHOsgHiFtOn9SwN/h3QHMs0xTbRViZymhwa7K4rvXiSfYYY1Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776126561; c=relaxed/simple;
	bh=ilqCm2IWieRAYcDMszPK68i8mdhs9B/KZHu227ICfVI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uUs5KQ/lqVBT2uf7h8NMjDKHWcvkHoXi3hDHJqNysAWDz5fvcLowToZAx8eqFtTrKspKgmPHgFmW9dzpOkjsibnm5qco820Cfg8Lo0P1PvBFIynMgnjoc/C5aUIMEQNKQXvv6gbPBI4hqW4HZXNZsCgnosO2zF7MWncJHnrAsX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=0yGxp9TE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fz905O3t; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 912187A0273;
	Mon, 13 Apr 2026 20:29:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Mon, 13 Apr 2026 20:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776126558;
	 x=1776212958; bh=OzjsKwz9LC30RD2gFYtEDz+hf33m8pEgJ7FdOVeuBoQ=; b=
	0yGxp9TE4eZ4a23Wb5d4u+EWNY3ztpzpnn1iXjgfodcazbvMSfR6DnYi0NyWV6eP
	H1o23LzBQm1xcAIsai//pUgP25cUO9FnUHp4aiCBvOzNglKXA0NfAT6fbouKutEX
	2YEGxb4ulTHMLx4f34FpbJCBmaDWXUHmqV3VkjzXbGyYVdw65ngO6lbxrAMHc4bH
	COsmtIGWwiyvjVAXPltkJE6kd334vY9ZkhamCKOnM2dphSbDk7xJqkh4tv52xzz2
	yQScYGltt0XySLcMkj0jmCrKonsdK8R1lVv1xcEQVLrZpg5E8910//ZxQK4EETQH
	lsQl8klTfj6fBYrmV44NsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776126558; x=
	1776212958; bh=OzjsKwz9LC30RD2gFYtEDz+hf33m8pEgJ7FdOVeuBoQ=; b=f
	z905O3tDx3yBlkwyL2T2ryJIict9xe0lyViREzPXy4XPLOfmrcRvRKQdelPMVU4X
	YRE1GunBMcbpEx5TPHAsw4JKYHI5eg0GKFtYKZMgFAlPqRCwKH2dYd77WbIBWUzW
	H07dbiA5o0HBql/5dGPhZEBIVe1mkRxowLHIpmAANQjEqZve6qF16qWXx8U8QEwR
	E6n98AtDQWpJEQNt3hneYekh/yQ4WAKzLHm0s0F6D+M5N5xeQTvWicXwHnuey9Ps
	IYaZxNhmmT+zhPENMr8ui97mvLL4QG/+YBIZnDpp6EH2gi/IwfOxLteHdL/sSr0l
	VkdIUim86D4Cr+ofDXQAg==
X-ME-Sender: <xms:XYrdaT3i3XWmvIeCIoeCnrl7Q084W2yMfgt74VFs3KUk9M82wGJ-PA>
    <xme:XYrdafwIDAi2o4Qe9Hm2Pm4ayyOWy6M9L0tMIgdDvMOGbufY1Ph8oDgdNygHVJSDi
    qUslgFJPipLZN6np-RIHgBEIakIggyObiV4kjBWrMur_37OB9SyF-8>
X-ME-Received: <xmr:XYrdaVol9WADlabLvKC-biZ3pQTkmCARO5a2gNlnhIH5MrgN6FeeR3EBg07eKmRfQA9v7EXx-4zDWNy2UjIL03CPLCMsRgjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdefleeikecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:XYrdaVV8U37fkado1GMw1xKY9OSmh2tCYdFlhxTHNFFWwMN0-UdDvw>
    <xmx:XYrdacrk99_ASoh9LzH4cf_2_3qg_GljW17K2hQMS10A-2BkakHDHw>
    <xmx:XYrdaZEHHDSflAkQ3IuMRHcilD1bg3Ofjxt2WrY_2NodCSlrz8Dyhw>
    <xmx:XYrdaesyduA-33hKh6EnDk24q5PD9h0RlDwR2LGEouHkNdd_-iboPA>
    <xmx:XordaQSLWHo0wYfzY6pxqSktO0m6xNjtRnobJ1LIpAZXMjCUa0PIOoJV>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Apr 2026 20:29:15 -0400 (EDT)
Message-ID: <5ea3d90e-9983-43a5-bbe8-e3999abb9e42@pobox.com>
Date: Mon, 13 Apr 2026 17:29:14 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 00/70] 6.12.82-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260413155728.181580293@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm1,messagingengine.com:s=fm2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-237686-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,pobox.com:dkim,pobox.com:email,pobox.com:mid]
X-Rspamd-Queue-Id: E357D3F4906
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 08:59, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.12.82 release.
> There are 70 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.12.82-rc1.gz
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

