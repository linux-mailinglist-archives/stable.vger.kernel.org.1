Return-Path: <stable+bounces-240227-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGlAEVzI52nyAgIAu9opvQ
	(envelope-from <stable+bounces-240227-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 20:56:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91AAF43ED23
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 20:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 30C4E302BEBA
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 18:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973D8381AF7;
	Tue, 21 Apr 2026 18:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AUEBxAyz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C7WqM558"
X-Original-To: stable@vger.kernel.org
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D1137269A;
	Tue, 21 Apr 2026 18:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776797766; cv=none; b=KGr9ztmukMKNif6hsZ6BoL5OxC4fwoRYbKC+i3y0QqI7+aaBHVuwJMn2tHUt0dVKE6KfESV6ypn0CZ6xtJCVLk78VuQ8vwMqyCkx4Qp0RmD/Ak447SNLbR+oOLJE6jR+CK+Dn1HtcgW7v7F555sI2P9N0NqDfzVtctuIqms2vGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776797766; c=relaxed/simple;
	bh=pc5k28CdkEIEGl9w8+aTBg+Zi2VCJFoN1K3cja689+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pETenEOPzmwrL9eAJf3EAZMRDeEIoxGlzf4jPcNLo50aUZUGFd9e+D2SMdl9Sf5yFX54BMeGXJPwSJDywgQgZdG0O24aGch+m+DgcDx+jXPQUnHqquP6SCvrdfhPFr9UjThwY+6sjS442W38R1Ocfj46gksVjlbV/m9B6m9NZ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AUEBxAyz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C7WqM558; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9F3E01D00225;
	Tue, 21 Apr 2026 14:56:02 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Tue, 21 Apr 2026 14:56:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776797762;
	 x=1776884162; bh=FU5SERuNRwp1fxnNy9VVslX5YHm2/7sMha/wVjgQT+U=; b=
	AUEBxAyzMwb6e4mYyHwgtXvIa2M7weEFMqUkrbQ72CMs4Vi+E6WWSL/vTPrlA0by
	kwPGwa+hK+oizda2Y8bafGvyT1ULkVpwl8GlUblMrvq1TQ3SHKAftKEMgCxQLSt/
	o61ftO8GiPFaBdSljfwTF8g3I0QlFZuq5f+VUTrc/zsV8kmQ+ILdv9J77UYAwkmd
	bZJaacTo/3Dv+lyN9uTw6PBNFtCzPWh38fEjWymXVcLw7x98dVe+WQsMT6tRLcWj
	V2oRo2QHgTGNtEXgQ30GidYbiGkpZfEyw0tqNW3e5vK1umefZSwwRhDBKWi98eP3
	mcCu94hBwn8zatVEAyqmFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776797762; x=
	1776884162; bh=FU5SERuNRwp1fxnNy9VVslX5YHm2/7sMha/wVjgQT+U=; b=C
	7WqM558/R0VwNNmTYeAeEidxc9Lb/c3Wi9mE1AN8KmvCS9VgzB5OoLHmcoDyZMOQ
	uTK19999Zd7EeYwfwUpWBKahVuoHIOMVqgn3SWZF2cF0NLqkMnMn501y84bWZEyR
	XdrtV270S/46JtPwC0nb/WeHODGbHcAwRGx9H6eCHsEWGsNIB2i02S7eM9rZDulj
	qCuFyfsNV0NatQgfwUyzqcuzKVhOoN7MAL41Q+Yh3CrKiRdL7RW+pGLQrUY6vdZE
	0KPmTk2Rc9SLDQtTh8JdEoX0Hqd/EetbKmYnk9ttO/WXxlhjrCpfD8a0nfIEPX5o
	1HTevXryxmqPst4e+ixhw==
X-ME-Sender: <xms:Qcjnabou8LzFASjm5FQ_ArVI_KBowXnq3RFBDhu7Q2dp6bPaK_5F7Q>
    <xme:QcjnaRhQuneIXlFAu-o8WkpxHZqHdRMPY19b-dJhbMqdlPgAVJw2iVF61P_2ppgAm
    LJlt9KO3l1N6erI4oB1rvRgdy9u9zjSl_XBqWZqm2iiXZfMKpgppGU>
X-ME-Received: <xmr:QcjnaTuRfQ2oKkrzLdrzD2o2zVPvO3RRMQL-8S5xk9z2xwut2zEiR8123neFW5bwMYN5JmizTdYEjbjYp8c-l9p9YSDKKVLC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeivdduiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:QcjnaS3CyO5JTfQWhBY6pFgzabrqfouIEJhp-usqjqWvkiqAE-ceFQ>
    <xmx:QcjnaSzU1oy567HzPZFjhTDPB9lNK4cbJsZBHDB9XJRsxVlT0fTGKQ>
    <xmx:QcjnaVV1A3u2pE7cyIeqwtPr2lWMXqJEVitmWgOLy48DsW99EiFFAg>
    <xmx:QcjnacB0CWaSPuh3KbuEHCPdksu0_9QFdnOemCaI9TisfMyXhH_B-A>
    <xmx:Qsjnac9fYQSDFp8DDabK5JKieO_jw4DRodrfByKFfqusim8W6gtuJaNc>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Apr 2026 14:55:59 -0400 (EDT)
Message-ID: <136d6ad2-3521-4a5c-a8db-5121789f999f@pobox.com>
Date: Tue, 21 Apr 2026 11:55:58 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/220] 6.19.14-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260420153934.013228280@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-240227-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.com:email,pobox.com:dkim,pobox.com:mid]
X-Rspamd-Queue-Id: 91AAF43ED23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 08:39, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.19.14 release.
> There are 220 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2026 15:38:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.19.14-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

I tested 6.19.14-rc1 with clockevents-prevent-timer-interrupt-starvation.patch
reverted (since it has been reverted in the stable-queue) on 2 different
amd64 systems. Working well, no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

