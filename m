Return-Path: <stable+bounces-215780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPBKGyNcjGnelgAAu9opvQ
	(envelope-from <stable+bounces-215780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:38:27 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C671B1237D8
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 11:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A28430BF9D5
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 10:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D964368278;
	Wed, 11 Feb 2026 10:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="o1TMA7ES";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H8CBQ1kh"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D83331A5C;
	Wed, 11 Feb 2026 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770806027; cv=none; b=YBP276N9ou7rut7sNn+uucHk4cAA56fYq843s8yXYX++2q2hF3Bkhz7tYqoYdGlpSkSo9XWdAvnxE/9c8RLyiQ3ks8DyK6Z4OJ/XzBO44cd9Bzb6tD60ZCJ0dgha6CFj9R7ESBbvbGCWYlj+rBvckJRfrc7WZBKhZ4BIZpfMVuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770806027; c=relaxed/simple;
	bh=YcQuCgbS5JQeCGirezfrME0aBlRlryirZFDGAuytquY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E47LYUl4ODJeSS5Rpj7iRXxutGM7Pd6bhXdiTzGuETOZuyPKicudg1VXrpV0ZZ/n13G0IG01In33qku2Qwz4slBhrurPl9EzRSWXTv+jlpYcdab5wDqEhvEGYNo+9y1E00Q+ZWp93KBGLjwYayra7OSZeQD9a0DdAsf1cnh0pYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=o1TMA7ES; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H8CBQ1kh; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BAC197A010F;
	Wed, 11 Feb 2026 05:33:43 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 11 Feb 2026 05:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770806023;
	 x=1770892423; bh=4YcXmw/sk3KEG9ORAo2jcxBduwj/YL0T40c4FVadWWI=; b=
	o1TMA7EScUNzzQzpCutIwqqaTsffCXXSjB0NmkNme5CH04XaO46P3tDOQpxXFTGb
	PQ/vmobg8A5b4JCre27rOZkH9MbuND1wCxIvYVYtDVcgyRHUGwwEVP9RyvNM+qXY
	tJ/gT59DOOj5Q6nTcCdiTu1Lj0yv5ItT27JfjSvTJO+raNx1BYxUgraCnzBbiGQs
	QqqrpU3xvtq5CSPb+ryTV8xBIsSyOMAGgzwdjLjS1/KJn2EItrRN5HKyZPZpHizN
	24fPtZXn+OpXC4dnq/XLVFDRaHn5dVHVapVMgS1Di4cNcfy/JRui7NWMaDp7Aigw
	oq11yQ7tI99io2Ktyjzw6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770806023; x=
	1770892423; bh=4YcXmw/sk3KEG9ORAo2jcxBduwj/YL0T40c4FVadWWI=; b=H
	8CBQ1khUJY6Luug88Otn6g4XZYCgQ15pgovodKMTC4mCLLKuZb2xXzCawLLUrFK+
	DWZCIR5VPXQgFBgxGQni9L9O5MFZ3ctxETXGDT8d71o0Ewg41d8Cirrenawh5j01
	QU6Q7W89Piu1BeqbBKwUin9CtB0VNHGdY5SB6ks/3XcHCd4BGj2R0roFr53DZwZW
	l0PdZNP0dKzue5KLiZQKpQpGg3SjgxL1uBJUgTYP37FHr8Nu9Dtg+bJdP31L1YIO
	qzNTNpP8oe1zvfgl7hkwc7mXr/CpGsDXjtfNucxRkv35k6J89lWBDXq2GVihXXGt
	GNxykJKEzOpHI986EEHcQ==
X-ME-Sender: <xms:BluMaQmsfWD5_yoWFM0MEL9iFhHoOEMjXDW1Xrql7m1NjJjo7Txv6A>
    <xme:BluMabukYUDxqybtM2KkpWvRfFwFlXZbuRKw952qaKrfKUfeN_vNB1EuGZa0m5Lg8
    ci2o4cGamPL9-x2o81w6ZMD3Mfd6U_Leno-HT02dzQUvtQde3PTARE>
X-ME-Received: <xmr:BluMaaIMCzPi5ngutLmCy11e-O6o1b-3EuWgnq88Ud09ONv_1jbnW44q2-uvB607iagCVrDQ39SGMOZwkYunPD6ZtQx0Fg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddvfedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:BluMaQjX2B1W5W_ffFIXogkUhJFjddg8kFLA_ucUXUTaxhdWkOICAg>
    <xmx:BluMaWt3UC0XJZrbCCaq7S7ckna5ZkK54bwt3jaw1iXRjyy6eWaiFQ>
    <xmx:BluMaSiRjDcuNoefYogIpotMXick75keKqLLhR1zJx7Ux0pLGnlKtg>
    <xmx:BluMaZff7XtAG0PuhbONzp_5gAQc8UHVmR1Eb8oxmM09u0_5LwTb9w>
    <xmx:B1uMaY6TWPwCH-GHntE2W4IRtG8hKseVPEOXT1ptCDnUgXHV_lEnerxB>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 05:33:40 -0500 (EST)
Message-ID: <e72bff37-ca75-4cc7-bf6d-2f5b35a786a8@pobox.com>
Date: Wed, 11 Feb 2026 02:33:39 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/175] 6.18.10-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260209142320.474120190@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260209142320.474120190@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-215780-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim,pobox.com:mid,pobox.com:dkim,pobox.com:email]
X-Rspamd-Queue-Id: C671B1237D8
X-Rspamd-Action: no action

On 2/9/26 06:21, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.10 release.
> There are 175 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Feb 2026 14:22:44 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.10-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on my amd64 DIY home NAS. (Also lightly tested on my ThinkPad T14 
Gen 1.) Working well, no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

