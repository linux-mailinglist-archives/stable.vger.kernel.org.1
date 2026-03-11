Return-Path: <stable+bounces-224764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAnMK7basWlPFwAAu9opvQ
	(envelope-from <stable+bounces-224764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 22:12:22 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A822926A4E1
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 22:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7AF60300BC8C
	for <lists+stable@lfdr.de>; Wed, 11 Mar 2026 21:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41899324716;
	Wed, 11 Mar 2026 21:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="OfiDuzRv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DFVbU4Vx"
X-Original-To: stable@vger.kernel.org
Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B23348463;
	Wed, 11 Mar 2026 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773263524; cv=none; b=TRLB3k7LPine5eYrjH2QK2aS1bKXfVrEKiCV4IaIKSO8BiLImDJdtBVqdw0d9ydsa/lRYTzj8ynggWsH/BzOJ7F519Tv17V1lqwUYhzHUgw3MNHjPaho5SiAHoT85xW44lo6IdOkf2Vi3pm2QE/Uz5p4i891eo4whL3P5q7Qzto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773263524; c=relaxed/simple;
	bh=Sj4zX/S23GPj1wyeuErmNsj4HmsDaVeLN12KuI5pa9w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nfnQYnMlcGB7N2FdkaHXecKSHMBZEWOQQIXic2M4l9uxzDhq8UOYackynXTkDVOVruQu5vEfAyiiuH0jxCKE1OFdu+7DOwz7mCRLmUMoYvb3DQI+IQsUeGfazcXJIxEfWugHxdwyVMi+QjMn3vKKSzSRfYipY0cQSotlTqNWNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=OfiDuzRv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DFVbU4Vx; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id B43E1EC0084;
	Wed, 11 Mar 2026 17:12:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 11 Mar 2026 17:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773263520;
	 x=1773349920; bh=2kLcxQ5uHtJF2LRuY58mGLZDxlGYrIiQDrP2UpeFq1Q=; b=
	OfiDuzRvg8iU3ZxD80BNAY3FW+kfx+YCX91apdmhkA/BYCh5/7FYRFjTrM51ejGw
	Fc6UH5nJzz1NXt1rPV9WZoprq9DHfc5SVqd5EuYJg9FVjE5/xYBMsGLshJtYl48M
	/XJoLCjhgBmpOqqPi83sbSKF9aPwlpHR+OCMCyvxY5CRCS483rBnIIA2LOnGjdJr
	UfW0YZpocexIRU4GPfTqK8n7Bk1NMbIUNr/GdTNC05qOY7uyHtWzDcOT4e7ManFC
	89jy+F8+/fkSpAl/r3kZ3yy3XJSyoSp5zJrUi39VxHcNw8XRLDblO5EJPo80JF4W
	JRc/LiDeySR+QphH/ltsWA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773263520; x=
	1773349920; bh=2kLcxQ5uHtJF2LRuY58mGLZDxlGYrIiQDrP2UpeFq1Q=; b=D
	FVbU4VxwMeeVJFqW0lxHJ9fVPlGf1xRnxQv26V/y0R5I9AaJXbMEqbPcxWu4fcYj
	n6y8DkxfIN/b6UPqTflEXg+/TBztOnXhH7OzBTY/3K6bl4L78YOXIjBA2OwZiqz0
	+FNBPbYBVgHnyw+qJ1bGVQJQsyQdBx19bLp40xhGNHu/PPVoYOKZ4bSUu0XJrtZA
	sfeFsmPxV8/AITRnKcDbrez2qyqdIj5MIkSF7OWMVCPS4cdfn2PoIHJ2hCecDZMc
	jtKv2UkzZHE7QLChEqeq6Z+LJgGiHnp20f1PE/5lKcvhapIcpb5to9JuhG5xRaMq
	6Ru3qG3dE9vbsixI2MOGg==
X-ME-Sender: <xms:n9qxaeWlmitVyKf9PThQ1y8CIJVOalJUw-rMmOqiZccq4eoeAa6ogw>
    <xme:n9qxaa8UD9HQstoTwTq8JINfYbgfSS5Tz-Yb35CSWb9zev9m7GQptuRe8kbDBGhC6
    vkE-EYtUPDL6g2Cb8a6MxCY5WuL_ATDhXSuRz3LrbSJwwu-9yctQMs>
X-ME-Received: <xmr:n9qxaTgWD-LnU1Sx7_c2wbCxOMm7px-y9WTJpdmaGrcQiv9I9-hBsWlf2Yd8n4ygyi6HvbocFPxEWPPaagtU3myDAA5uBg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeegleehucetufdoteggodetrf
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
X-ME-Proxy: <xmx:n9qxaRV31Hd4XpHPjor1lqTDy5DSW934_HGY6DuRpLFW8uD6avbB7A>
    <xmx:n9qxaXuW_oD9Wayc35WTgRTgxWXe6H0Si3aq64aqWTmqHVz1Sqebuw>
    <xmx:n9qxaS88uLX4fDydIQGcprPs4UhHPGHWnJ0EfRURY1VmMp8BfzARwQ>
    <xmx:n9qxaXt3_Wg8bXVU0Gc3b6AJUzJsCCjOQTfk--mfPXvHEhEBa6L09Q>
    <xmx:oNqxaUfqvuJRVbWJ-rld3MbLu8xVg2-_fh_gmNXOz0DeWEQFboWyof1y>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Mar 2026 17:11:57 -0400 (EDT)
Message-ID: <a03c5a90-880b-42f5-9f63-4dabb19ca369@pobox.com>
Date: Wed, 11 Mar 2026 14:11:56 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/311] 6.19.7-rc1 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <cover.1773140654.git.sashal@kernel.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <cover.1773140654.git.sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-224764-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,pobox.com:dkim,pobox.com:email,pobox.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A822926A4E1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/10/26 04:05, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.19.7 release.
> There are 311 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Thu Mar 12 11:04:16 AM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/rawdiff/?id=linux-6.19.y&id2=v6.19.6
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

Tested on my amd64 DIY home NAS. Working well, no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

