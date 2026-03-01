Return-Path: <stable+bounces-222402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id go49LeK2o2mLKgUAu9opvQ
	(envelope-from <stable+bounces-222402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:47:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 377941CE71E
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 04:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3147A300C0FA
	for <lists+stable@lfdr.de>; Sun,  1 Mar 2026 03:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A852D1931;
	Sun,  1 Mar 2026 03:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ewuVQY0f";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X1XdJNaA"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DD11CEADB;
	Sun,  1 Mar 2026 03:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772336861; cv=none; b=VE3SYDtRHisLkqkdDZvCOPo7v25gU7Mzdk9rWr5rf4sOwcy9vf7m/1qI6KcCZiGaO8vurMHFFguyaSlY6nUhqsGI8Xmt2YPxjHeaB/rnDs2uXqyKuN+sD64zUVLI5FWSKKUlTmQ+jfRLdmAFw4X6tdmKrWtqBtYsCNFuGr+0yvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772336861; c=relaxed/simple;
	bh=Jicj6pzhUz5nrLCK+0MFfAYA4dyLWhWWqcgZyyr+8dM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqlA1aUyw6Wipvr8P1h9UUdws3BjmDiqM5jiBlqKx6B+njMHKVOOvHeQz4XfhsuoLXyA+3FA83yqER+TSl1Ki2uZtlFnTXqEw2BUBUid4gahtvMqCe0naoCUHf2cat4tgZhFSM5qdXaq+Cx/QOuTNx548zwLAeRX+qJ9wsInl9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ewuVQY0f; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=X1XdJNaA; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 114257A007C;
	Sat, 28 Feb 2026 22:47:36 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 28 Feb 2026 22:47:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772336856;
	 x=1772423256; bh=q4zm0dsCRx6yq5T9GyTIEBmkmp5SlS2fNta05mobAs8=; b=
	ewuVQY0fNii1GejHC9QQuKE+jU2uecOMtN4geUDKWg9k6gx/L4CVjjItnneQC6ZK
	CAO7F2XY7fgHB6OGqWxSmkHQZ4SIIl0vewDCRQCSj39cXXGTdNI2ocg0SGNwCRIz
	4OZjGvDxqqbfgbnQOPvZ4XKgMWV6sPVayAnbNGO49ZS3UJvqPjqrXikitzX9sVOs
	OPBGAjl+U8vj5NGLik0IH1PoB2eOnzaws0kws4/N5yDJZNiZDYoNePjAa35URjEf
	U5+pWEt4NwpPVizvgntJYS6qM3tFMEYGsER6bFx+IcoE4JwWeqj2THxsCljxFcAf
	oB71NUtVVnEoQrYgW+rZcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772336856; x=
	1772423256; bh=q4zm0dsCRx6yq5T9GyTIEBmkmp5SlS2fNta05mobAs8=; b=X
	1XdJNaAjtfJHcIVEsbcE2toKBjOnkj6jm6UF/1fMYsm8fANfeZOXmGF+X8Uqv5h8
	1SAUmo0mh/7gqIO7032ozfBtyecnS2NS44oO3t5iKZXt8JqZpOjSqcf0mqd6IhX+
	zoIaUwL2gVIyZ0ECPhLAdIlGmIVh5+4H1+5S6hViEwuNN4TNHd7B4IFZmhGaY5PP
	ZJJVZso9RzcAdgHP0X4ZlPmdnc0ZuUcNn1tZlWLscGXWOgSAwdpZhxF0N8HcWKCV
	KVgSvck1AvnK3/r5ESPs1m48j7od4h3X6XDJe4zADcb1rgnz/8cl/kkhnedStLoR
	D9RWI/10Z5hSsVCOJLsIQ==
X-ME-Sender: <xms:2LajaeoD_n8qogfV97HcDhyQaKqNMQWm-KXRqCvYhkk-TzkuKFbZsw>
    <xme:2LajaVf0Hb1nI-H8hsQ37d-APEnxMsV9lnlyaYDtKM6vB_w1sohq79e8NnQ0BbkjF
    TrRrzSIydWP9pv0Zg_xva-84Aett89jZpLSACjEOeUIWtIuULnFPDH3>
X-ME-Received: <xmr:2LajaUjkTL8ueRPFZ5CFbPRXKzJpWJDVdmp7TUIFvWLkGN1m2NY-C9kae1C8iqWdY9DvfXEPX1VtloPyzStO5UpfbRrpnQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheefjeehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:2LajaTLnZAZCCGF7S-gv7kZaeGJNxoAGrEW98gZEE_x0wUxS49Rekg>
    <xmx:2LajaRoEgYk_SMROHwOfe0h66dxlvYP3cyvpDCmFcDRrFym2q_I62Q>
    <xmx:2LajaYq4uw8khtBr5zSnrOhuL0J8PfIeTUAAuyKm9y1XsEfNd8M32A>
    <xmx:2LajafFVXkEhjJ0oCMm_YXVqochI8CRNGVJSzkzJ3f5otFI_1baZAw>
    <xmx:2LajaYeOKfweJp2uD9XrOYFTDxo7E1rwYuGTVFKCVLpCqsJo0vRTuehx>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Feb 2026 22:47:33 -0500 (EST)
Message-ID: <b902b20e-4ec8-4ea7-9ee7-16606c9dc147@pobox.com>
Date: Sat, 28 Feb 2026 19:47:32 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 000/147] 5.10.252-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260228181731.1605473-1-sashal@kernel.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260228181731.1605473-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-222402-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,messagingengine.com:dkim,pobox.com:mid,pobox.com:dkim,pobox.com:email]
X-Rspamd-Queue-Id: 377941CE71E
X-Rspamd-Action: no action

On 2/28/26 10:17, Sasha Levin wrote:
> 
> This is the start of the stable review cycle for the 5.10.252 release.
> There are 147 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar  2 06:17:30 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-5.10.y&id2=v5.10.251
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

Tested on an amd64 laptop (Lenovo ThinkPad T14 Gen 1). Working well,
no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

