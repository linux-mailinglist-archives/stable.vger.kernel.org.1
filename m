Return-Path: <stable+bounces-238327-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCdNGrX64GlloAAAu9opvQ
	(envelope-from <stable+bounces-238327-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 17:05:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D53B410294
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 17:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 000D430028EB
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7AD3806AA;
	Thu, 16 Apr 2026 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LX1OyRSl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qHY6qGLb"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0D730AAA6;
	Thu, 16 Apr 2026 15:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776351885; cv=none; b=V3pzzpPBnm4v0gqRFr8O18q4SX6E9e/kCr0pt8TlWfrTqcGll7of+nC7sPWdZUIGDoVooLSxR8Vt/MW8QS1mJfoW7dqcqEbUZrukNgwagT3OYk30I/DTO1bdvKPfhU+dLLB349wRR3gepmFRRARLvzWLvSGBPInpmPhv19gdeOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776351885; c=relaxed/simple;
	bh=RyrCjZvQNNX5UQTa0dpfSyeGHjjqEAUPQze1wpyOUlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GjvrQaqFTuJ11DdP7eIsdQorQhVYchXrrMdQP1x3e6nUMggc6fEpefx4WyVqU69V0waj3m3taj/j4Kwq8wbbQ52+KmBF0lu+0waXk8MKh/2lfu4P6PIhX2bNA6O7gRk5/eLhJFRbJGv3nt5kE6r+UUxVLRPeO0y/hnwfJFhVpAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LX1OyRSl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qHY6qGLb; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9529C1400068;
	Thu, 16 Apr 2026 11:04:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 16 Apr 2026 11:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776351883;
	 x=1776438283; bh=/JI+iAxqfXdV9TISei4jbboFsY6J8hmpEAfmJwnd2W0=; b=
	LX1OyRSlY0Pf8MYlBNvZlGi4oWjIXdImVBOgczUVGF4V6ShVnegLnb6F9OrPoGRG
	esBuvhdkhU/gy/zpEfndDiGI+J9CvUF2mJAbYK+SQh4SWh13VOhiS1/ThFru0Nr9
	PJPBJzhdUWKb6q7DHj7mMitPPTPQcSl3rUfWz7aENCmESufxMWLX7gDkT1+qy0c/
	bU0oSD3nAUAkeiEa0bAvPARRbYNKLSsi/Zv6B2fgtoHhBhEyfkSyjIuM/b/Mub6k
	8loqSIoZXx6oIXqKkV9WE96iV9hmpR8KQjLwIR95nGTSGpiQOkWyqUcdjLE5gNwF
	neaDPCQSB4cmMLYFfljRiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776351883; x=
	1776438283; bh=/JI+iAxqfXdV9TISei4jbboFsY6J8hmpEAfmJwnd2W0=; b=q
	HY6qGLbg34IMfrsG/G/kFQA9KYrEN0e+8TyUVl8nWfmpx+YmqfoxHtlCizqFEcXZ
	U+Jk4TXgcV9hTX8JcXsrI0Lms3TKjTwnOFM0X0PIFy8rbIx8T6Ww9Js1vfcvtp8Z
	3FOYdvehzIaRDGTLzywfc6emBigec98Mqv4q8RtmPgCBWzZxgvrBjXuE0G+ZTuRi
	tRg+SyID4tU9fFp1wdYFvuWGS7PFM0Lf2z04YnwPJYI9Nc2WT4BYMT5iywvhGxzs
	KdMzGHxCuDjOI7SYr/DsX6M11+EZ0FTIIO6axhhwI7vqg96iroWhV6hpcriIFSLi
	PJtDfPsCXBKv4LKmrHoEg==
X-ME-Sender: <xms:ivrgaR4xkB_BMU6uS2CPZwbwDwJcKGw9gLWlHYFiWLUUKrKZIzlq6A>
    <xme:ivrgaawsMSRCzii69vJqGpWDUs3v9q9YnBB98YFWzqdctuyVH7nxLNwRgi4FGhWDv
    tu7A5cfOv3BU-trkYYj0UhGb8Fme3G65JhM0318G3c7cGbGXjyhQpY>
X-ME-Received: <xmr:ivrgaT90tvYEYjh6hgeaci7TuJ_bwtEZhapQ_N7z8o6b3RzBF6QYDKlAI2pIcR7OO1F4CEMOI2j0DzfXCsIaaUdBcpkv8uET>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegjeefudcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ivrgaeECpxcWABkTWR5xxkHYA0p2O2d-ahwFkZVN5faDOgcBKrhUrw>
    <xmx:ivrgadAYil9R4pUPuXACly2Zl1MOHqVwLdlmne0RZnd0jGuylqrPGg>
    <xmx:ivrgaSkHM8BXvTNSOowdgnjq-4eGrZIxG5BJ8t1ektwOfcI06NhHgw>
    <xmx:ivrgaQQEv9_OJYiVTMLQkrnqOXeY6BNhO-ovVcvBMwrKr1OO94SAcQ>
    <xmx:i_rgaXOSB49QifM3wRz68NFWnq54LSuk4EunVZ5u-N8UZmmcKyBrGyNU>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 Apr 2026 11:04:40 -0400 (EDT)
Message-ID: <f76d0473-fd72-4fca-81d9-3f97bd3deaa0@pobox.com>
Date: Thu, 16 Apr 2026 08:04:39 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.15 000/570] 5.15.203-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260413155830.386096114@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-238327-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.com:email,pobox.com:dkim,pobox.com:mid,messagingengine.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5D53B410294
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 08:52, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.203 release.
> There are 570 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 15 Apr 2026 15:57:08 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.203-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

I took the 5.15 stable-queue as of commit
8704fee09eadb945a49ce5cedc2cb2d506a50b9c
("drop 1 patch from queue-5.15 and queue-5.10 based on RC review feedback")
and applied it on top of 5.15.202. This is up to date with most of the
patch drops after 5.15.203-rc1. I then tested the resulting kernel on my
Lenovo ThinkPad T14 Gen 1. It works well and I have not observed any
regressions.

Tested-by: Barry K. Nathan <barryn@pobox.com>

(As of this writing, one more patch has been dropped from stable-queue,
in gve, however the config I used for testing does not build the gve
driver.)
-- 
-Barry K. Nathan  <barryn@pobox.com>

