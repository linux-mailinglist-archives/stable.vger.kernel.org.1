Return-Path: <stable+bounces-216595-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id e2cHExcLkWn0egEAu9opvQ
	(envelope-from <stable+bounces-216595-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 00:53:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A8313DC9B
	for <lists+stable@lfdr.de>; Sun, 15 Feb 2026 00:53:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09FF5301D06E
	for <lists+stable@lfdr.de>; Sat, 14 Feb 2026 23:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4AAC2836B0;
	Sat, 14 Feb 2026 23:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="FIaoCMIa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pVL2Bx2q"
X-Original-To: stable@vger.kernel.org
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BDCC255F2C;
	Sat, 14 Feb 2026 23:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771113231; cv=none; b=n2wgXNkBIzqZoPdPoAk6jlPbiU9n9DqIpDttV4xBUPHnTVhZSK2738h6MT7PLVnsQuTGzdLuiFu72Jp+dv3MgEzs+/pjIdq1x8P6F6jQKPxBrjgNZSMU9qaYELNxnD+FrrmeShrjTyMATnNVZxqHMgAEZnYLk2UDZV+zlY90Mxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771113231; c=relaxed/simple;
	bh=JfVGDR6m/UsWYnwaxHfd33Cz8JY/DLj4YpcWIWfFnzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t3TOjhn+6BjQPOe/LW05Es+Bea5Wcai4TnKzL1/kBfdjxUkjuZEQXkbTUnWlYSIldy8ziGaRiuAEWya0MgBoH0OLwZhJQkQrhngNrUmJWl0qzhHrxm8a02FaZGyOE3rhVrOW7qCHV5B8LeTzMTj+9N1Cn0RwCTwkQVD8vn+W+uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=FIaoCMIa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pVL2Bx2q; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5BB6FEC060D;
	Sat, 14 Feb 2026 18:53:49 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sat, 14 Feb 2026 18:53:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1771113229;
	 x=1771199629; bh=zed6duxfQEU7sTUSuzhsr8XcM+tG58bpCG0rc84R/z0=; b=
	FIaoCMIa5pOnWx7MxXi3T5qZywybdw2IUm4AMc5pHKVYx+FxMr+xlTPCVJLHafIJ
	s+ZH2xg/wlNqBDlpApeMUQKI7qpIii6Mov0+ITBY3ki4abHt83idU3Ef92UktVxw
	0+RwJTetX7wQW8TrDYKRm9RL9e2/9On8J2Vc48PVgRDDjWLUY2NWnrA4+uvvIelJ
	anzNbOZE5etFeC6oyFVnzM3EGTJ+RjnqLw7/dHx/M0i17ryIj0fwVvQPnfY55A4+
	jOBibSeGoNcN/L1htwvyc+/tS81siZmOlbsfm+nIGM/vCpWlwCnZmjel6U7v/Zt7
	R6J3tiU084r/RDZApOPWTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771113229; x=
	1771199629; bh=zed6duxfQEU7sTUSuzhsr8XcM+tG58bpCG0rc84R/z0=; b=p
	VL2Bx2qaR5fja4nzERJlHc9TnmHeJvfKiIP9RKGlEwEnVIQQ2a1c8Q6OeQpefgGn
	/qPDnLhjhAtjE3OUIdHD7JShjlM04y1iAMjfV9paiXTIaHra9wX4gv34xPyUniUH
	2Eg8gwQaYVhMOlKXqruOZXTyVGEp03HeCiJJib+KiLSguVzMu8tMVLuSZ5ceSn2o
	TlioZgiHQxetduuqVUViMgU8oNtfLJKRkUYbzyjNlDZat+45L9Qde/HV/NA+Hprp
	l+7JbIggYaIMDQMDc1a+GEXE0sAvhvZj0y5GNXkl2hnZnYrgYoOzYFbDhwMm+vmV
	HmnHKA26IdFKYnpPAKuLA==
X-ME-Sender: <xms:DAuRaWDwUrl8DCCgLQsVsBoDd2wQuTw9TXHupDFGkUpnj4suJbGxzA>
    <xme:DAuRacbnySBacL3v3TfiUoWImVfxE43QfIZBfKicJAA6zODgfjynFLBUK6qrxWfbi
    Unw0fO_rZ2LNiRqxoLbn16uA2F8N01CzlczDNpjhtRQ4ujtTGor-g>
X-ME-Received: <xmr:DAuRaVF6z8MArFTFrODuARkCGtaYjFOIflN_XC2bGUgB8gwW_CP3ZsbCfw1eT3iEq6dq6pKUwNO1df8HFov9rSLqNKvf9w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvuddvgeekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:DAuRaYvEWhv9jp9SQfFSY5KZ38_oc2Ls_Z5-1uMyWx_fpaU8hhIf7A>
    <xmx:DAuRaTJKymfUvhwC8A7jNIoEhYv5qMERmxwZ4jEF8A1WueeQXKSL8w>
    <xmx:DAuRaeMZPnLqmrow7wtDBaddGomJ9maH7-ZhZc1jQ33IDHJuFGbung>
    <xmx:DAuRaTYZwTCI1Ivb39QjKOVVUhnHp3Be3X2UGkGzGvdE6ScTs356Kw>
    <xmx:DQuRadWydlUevwiNVkMiboUm0IrKfgWiCXENZl8jQqTkAwXhXUh63DEn>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 14 Feb 2026 18:53:46 -0500 (EST)
Message-ID: <0ee2ef14-172d-4b77-95a1-a643f1872969@pobox.com>
Date: Sat, 14 Feb 2026 15:53:45 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 00/49] 6.18.11-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260213134708.885500854@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260213134708.885500854@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm2,messagingengine.com:s=fm3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[20];
	TAGGED_FROM(0.00)[bounces-216595-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 88A8313DC9B
X-Rspamd-Action: no action

On 2/13/26 05:47, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.11 release.
> There are 49 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun, 15 Feb 2026 13:46:52 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.11-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on my amd64 DIY home NAS. Working well, no regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>
-- 
-Barry K. Nathan  <barryn@pobox.com>

