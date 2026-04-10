Return-Path: <stable+bounces-235610-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANf7J2S22GnnhAgAu9opvQ
	(envelope-from <stable+bounces-235610-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:35:48 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 093693D429F
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 10:35:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1D5D3036625
	for <lists+stable@lfdr.de>; Fri, 10 Apr 2026 08:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512AD3AC0F0;
	Fri, 10 Apr 2026 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="H20Ou+xe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ggQYyror"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ECBE35BDAD;
	Fri, 10 Apr 2026 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775809799; cv=none; b=cgFXMGX4yFcXukeZ06a0pdK7+vgjrICwOsVyF2Z2MSkBJ71/e4yd4YtxNu4cwMaHtDF3Kdv9BGmnlBc9BdcRxN6tprOoexAa8bMZ5EbqePe66wupVabn5zrz4sWofSLXz0Qqddphn/rO4sABRF1DlrYOFVxLCOJXig+L9/Dorjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775809799; c=relaxed/simple;
	bh=I845HGEPxbH0IkaZYvI2SfdBV6Ys39TgT7kwhiO494g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJ2Ugmyt4d0z0QU63UWXI+Iu0Zlq/4GOEdlq8amt/7D4dFbFMkUEeucKMtLgxTgoSiJNeOMsQrpHvkbsbuHzWNgnwz7RFMfriy5b9DJAP0q3Mb0w6YeCbnKlzv13R5ej58KZL8ctAPtSdGp/xrNCtdn21Ac/Gi8vh0zq1qIkWfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=H20Ou+xe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ggQYyror; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD3A31400207;
	Fri, 10 Apr 2026 04:29:56 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 10 Apr 2026 04:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1775809796;
	 x=1775896196; bh=jeGjcpICleST8v24rZwvokkHatWhWcj7ixN9vXhTAYQ=; b=
	H20Ou+xeOitXxGG9Sm9uMhpyX1aX19BfJNhTiU7RAWorlc3iwE3r67AfVAU/D9jE
	LPn7px1lFiaA+dobaAutvUqVL55URe1sGuP5sFfZmDdDFWVe8HoMJkoqIkrn64KE
	dF3fFJDLmLHgj+qr/F+4Iua5mEe/Z/82QvNdAygSI4kW9XqY/LXDRqdHiK6XEoA0
	ZVflQOc/ZCRDsp1bYEeda81XOdpfdiH4vSjH2dQGw9QuAErzJGnwdCztt+uk03X2
	Mcc8wdOY+fByFEXd2Q5tW54CNGrsxZ7YG7KZ3J3L5qnyH1GmOGSZHfcR+Tj4XZHz
	p590/XsFaAcqwBEHv7SqgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1775809796; x=
	1775896196; bh=jeGjcpICleST8v24rZwvokkHatWhWcj7ixN9vXhTAYQ=; b=g
	gQYyrorXvxDm7GpMylst7lpoVsXAfZx0SFXHp9o0PQ6FjnbZ8NEV5WZNiCtwoduM
	EesK5Ij1JRBM23fs43w8f8iqL094DW7SQSjFAGhyPhuNHLi9J/zq8epgJfOwnG97
	shBdVneWeqKbiRp9irz9lqtEc93QY7cpFL/wmO0Wz6vf8+g7Ay+O+giJ8lRA99HI
	xWVpSESatVuxP4Z9KDyftL2Vgctp9ci9q7vkf0/buapWMAvBfYFry6yoCzdLAy+8
	RYDqgXtwFr9zkVRn0HGfF9OI5Xh5NEh7+NqW24ENsPzcBO2CJYyar1Mglrjj2sjX
	WUpmouq60PQqFuNSPfABw==
X-ME-Sender: <xms:A7XYaSoAYvsWO2AE6h7XSGjmTHlVsVH0m7BI9OiKOPGyIy8FxsMTBw>
    <xme:A7XYacgcm4MkpXm96XOh--V1vDMVA5m6YWj4iOqHc1688wamhXBMuXz44jVQPlvfc
    u4J9XH3KtdidGih_0utTXg7MY6xZWFciSp4WEZarKoSM4eaM3uv6Sg>
X-ME-Received: <xmr:A7XYaSvYWmYm9zz74Z_7nGmoNpmdm3LlMdK9vF7lHUr0OuBb2slPtmZkHz-Fa1_O37fqfEjdeSUsnwzcWFCW_DETKoJ0jnxT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvkeelfecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:A7XYaV2W-xdTEeL7GkC8E3HMyhkkXOrpdV3E0TwR2t6Qof9tpdA5Tg>
    <xmx:A7XYaZxMXv7jh_HJTyVTn3oinyu4JsBWEO7zBxttcklTKJJ-8dX1BQ>
    <xmx:A7XYaQVdJq8AqZLGINYpmuwXgMNtOhUVIlQAazSiVPrVeVvo-zexmQ>
    <xmx:A7XYabA6TivAk7yG-lwQjlnXLQ3x013HiZTgdEZ8UgZGpbRFX0uGUg>
    <xmx:BLXYaT-gx7g_N4I0bZ5UMqr69oa7QLbCDB7Z1HEnluuEUUySm23ZeuNF>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Apr 2026 04:29:53 -0400 (EDT)
Message-ID: <be550d5f-a5bc-4cab-aa75-1c7481ba39c8@pobox.com>
Date: Fri, 10 Apr 2026 01:29:52 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.1 000/312] 6.1.168-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260408175933.715315542@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-235610-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,pobox.com:dkim,pobox.com:email,pobox.com:mid]
X-Rspamd-Queue-Id: 093693D429F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/8/26 10:58, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.1.168 release.
> There are 312 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 10 Apr 2026 17:58:42 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.168-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on an amd64 laptop (Lenovo ThinkPad T14 Gen 1). Working well, no
regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

However, I'm curious about what's happening with 6.1.y and the "CrackArmor"
AppArmor fixes. As far as I can tell, they're still not in 6.1.168-rc1
(and presumably won't be in 6.1.168). Assuming it's not too early to talk
about it in public yet, where does this stand? Is it just a matter of
waiting a bit longer for stuff to happen behind the scenes (or for other
bugs/patches to be dealt with first), or is there something else going on
(such as a specific problem blocking it that needs to be resolved first)?

-- 
-Barry K. Nathan  <barryn@pobox.com>

