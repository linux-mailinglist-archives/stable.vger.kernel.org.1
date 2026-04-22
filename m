Return-Path: <stable+bounces-240278-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNscEsRm6GkLKAIAu9opvQ
	(envelope-from <stable+bounces-240278-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:12:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DE58442508
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 08:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0EDD4301D335
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 06:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3402DC77F;
	Wed, 22 Apr 2026 06:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gkex6D+1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t5huA2K0"
X-Original-To: stable@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C492D8DC2;
	Wed, 22 Apr 2026 06:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776838336; cv=none; b=dD6zma80I8nMmttq9gke7dcTdl8QB9dSSY9u7uJR+kIKHRvn40Uco6mmtFZlcqbT4K24o8xw3ycP78tLf3iN0CNWXEky8Dc5tX1GaLUlOdTknrfcc7WiVKAFIoQE5puRIancIhxQbc32eXdi3DlxNZsIM8oaxOogOl8Urdi/HrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776838336; c=relaxed/simple;
	bh=r2TttHa/vISVoHfzpQpcn6y/vaY2bVfneMj2BmPb7cY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+Ed1WiZlfswjUqmmVYjJTfH/B4QulKk7oNfvuvLsQi5uJAOoz0/5X94Y5hjvb3tnY8IFsR2OlKRO9AeOw74XSrlpDqLqu3Pui6pLoKw58ZlScUdpVqPF08mxCRU3nzq7aVedqzUvfZeiyGjNCneEdKBATmQMul9zh0GXOJiPI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gkex6D+1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t5huA2K0; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 24791EC00C5;
	Wed, 22 Apr 2026 02:12:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Wed, 22 Apr 2026 02:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1776838332;
	 x=1776924732; bh=dKN91OZq0hHnIny0oiHWCqw9IUVu6LE2eBKBnWbpGjU=; b=
	Gkex6D+1JnNXQHvOs7iTwyG/J77jxuCRQa3pY9k8v6lsnLyVKx7V+qN8jqvqRu1A
	b3O4PUxAE+Ia6Bo+WBFYmzWAd+WU5wKNFDnLzzeiqsjfqGLPxvHqr8T1rdofWRl3
	HkdjIx39GT1oAWGJs1/9VTECkDqugHJXyIdS61digoEiuQBk9TRV+j6IZphfyiTL
	vKB/2rVAqeGIV2PTv0zxEUq5+31sJcX0z2RAp2F+Qms3TZtNeiNQFGp6B4zi3d4E
	cl0aX19q8JZ4xYtL6mxfG4vUtF8Wcykx8dTD8hdM+EpqL89ln93xWEm/EGLf3Qu7
	53f5skhCMOIJUBnN1oq1bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1776838332; x=
	1776924732; bh=dKN91OZq0hHnIny0oiHWCqw9IUVu6LE2eBKBnWbpGjU=; b=t
	5huA2K0f5lvz5R06U82cIH1bKehST2TLGn3qtAlk/vv5OqRRvf3bCG/8KXh9J3W4
	rUNYUUPMfq5opSI+Z7KlYPqtUZNJPk1clcMiJtsnvGkrg+rpVKVfH1dR3W0Lz2wY
	/HhaWvDF/B+ZqA9PSi0XVI23VbGGVXqQWW+iSu7phjY4pgM23sKQKAmJhst830J2
	H+dNjnbpA6jrQOtJgrO7isr2Nd2HleWLAn/bgs+GYP+2dAk9bUGiyUX73tb1gRkB
	gtVm9/6hMMyfbNCA3B2u59YWoUUXPrzrMH59aTHngH+xnNI0NApjr/22olBQmpJ3
	9aja2Y94jYwlzJRZ+7B0A==
X-ME-Sender: <xms:u2boaVY5nVJKgTEM17N3LiJhYRpH_iko0ycgCBDydCDzcMwp-O3-0g>
    <xme:u2boaYT8v7n3B_rfTlh2A_Je2Ep8SXevPMIsFpuKMRNT0rRrWYJMoTVXZzWX3Z0xE
    wP9CDRE64m_yJfJpZ3BNQ-gf6mtQqDZ8TQcJrwn3YReF8_sDG5TvuWK>
X-ME-Received: <xmr:u2boaTcDYd7ZYDRKEpH3NM-__GBXWuQIYmQ-AA5Fg3iQJkiCKB1-mEu7Y5sLxlPJyl-TxNsAhhZYEYbvDjj92S-6VOfCLBxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdeifeehvdcutefuodetggdotefrod
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
X-ME-Proxy: <xmx:u2boaXmyWNTNC7NyiK_rFV1BT9-VCKaeJpykpwr9gGrdMz2zr4IzKg>
    <xmx:u2boaYhsFAuDJaFe9cGsOGocImoL5qPOmu1WY-FpySqRxaqwnesO9Q>
    <xmx:u2boaYH8787poLZZ-k-zWn81UjNP5If95GbU7nvZ2A6ealGVA_TyxA>
    <xmx:u2boaXyKwGew5YVpnReVCP1ITYSiUSxvlHBAdoFEaJ1ZoHGOZgmggQ>
    <xmx:vGboaSuKzYmgCgBjW7UAThZPQGrwpcU5v-I66Uw_5QNbg9v72tI53f9O>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Apr 2026 02:12:09 -0400 (EDT)
Message-ID: <ecffaa3c-ed9d-4962-aa24-73e20363edbb@pobox.com>
Date: Tue, 21 Apr 2026 23:12:08 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.0 00/76] 7.0.1-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260420153910.810034134@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260420153910.810034134@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm1,messagingengine.com:s=fm2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-240278-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3DE58442508
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/20/26 08:41, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 7.0.1 release.
> There are 76 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 22 Apr 2026 15:38:50 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v7.x/stable-review/patch-7.0.1-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-7.0.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

I tested 7.0.1-rc1 plus clockevents-prevent-timer-interrupt-starvation.patch
(since that patch has been added to the 7.0.y stable-queue) on 2 different
amd64 laptops. Working well, no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

