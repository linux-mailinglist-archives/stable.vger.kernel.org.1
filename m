Return-Path: <stable+bounces-222824-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F6ZH+abpmlqRwAAu9opvQ
	(envelope-from <stable+bounces-222824-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:29:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D21221EACAA
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 09:29:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0B5A30E1CFC
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66BB137DE96;
	Tue,  3 Mar 2026 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="C2YRt1SP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dvtLdKid"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE70382386;
	Tue,  3 Mar 2026 08:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772526213; cv=none; b=MCqIwh6cgsFqRY57uM8gw/Ifx5hibIMfShq9T8VYPlb+FaHdgqimH3LFLgieSeVXsTcAM58pgIZ6+BqWvHiR8PIsdnnf1gx5v4FlD5UCjJP9bX81IhNEaUXh21MasRyoKb46Fm0k4GgNhxyDkcaKTNKupj0sx8u7MxnjgiFpr70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772526213; c=relaxed/simple;
	bh=+BEMGDBP2XO6Jh90Ua+u74wXrnVh9V6HxgghijIPzYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ImRPAzbPhCIyGz+I4VFRJigLHA9LtzslyjpZuY3gx7lp/idzvkUhZusVsh6Rb6uKW5y2p+QPeErQKgL2i+RgZTKwSNi50ZqL7pjHIkY8xwAZbQ8ggyNnSptY1ZyHSxINMj+LtkEp5Dj5KP6AGsuBdTOy+3r18yJnojLqK5hEm6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=C2YRt1SP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dvtLdKid; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD57C140001B;
	Tue,  3 Mar 2026 03:23:28 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Tue, 03 Mar 2026 03:23:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772526208;
	 x=1772612608; bh=YNctY6OBVej4Ku0feFP5iuZ9wqfFdAIR44rGJPDhnus=; b=
	C2YRt1SPYVxY6y7uK83d7MQtJywondDNuBIxkrGbaPgplVJNbaREHcSPkfKe0XUd
	wkaD3WHIVxpHUAbO3l/Tj6MvTeeNWqXqF+JfY4XN2j7OWcJEdsM03dDqbuTrvN66
	vH3KsyslPdPu+tZq8wSnO6ks2YYarLuXxg+qm2jxgqGJnG4TPpUEjMoabE57LnnE
	dxwyc1MtZuPidNbcDiygzRbtsSCJxIYKX4p+h/f+/OlUT2dFMdEsMTrs0/oKyO4/
	QSS7WDFtBI4LAPbVCe2unuel5NL8kzQki7PKp38TBrdyOeQHwwnsc3zu4fu1mKZm
	J3UXHmRJtcqHPvSGxlM/ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772526208; x=
	1772612608; bh=YNctY6OBVej4Ku0feFP5iuZ9wqfFdAIR44rGJPDhnus=; b=d
	vtLdKidppstiusm8QpO+Hbcqh6aYqY1mmBg+j2n/BSglVeNxivO0MBa1E11kjyE0
	E5YKHgYT98/2tw2rSghXIwzOsAxq1IwCLOqhQMQalOVvQUHGwiyqSzHGqRGhpK7u
	AvX3ZTzrnvUspJOSeREkktRNWb7o/cW9BCeao2lEAhTp9IBVpa28h5/WxP7DCsuJ
	TMIPM8EIyWE/AfI03MV1+R6x956sEOvuDJXefE0AGE4k40tTFNiCEcwuOlq/vvdH
	vX0OE7kaExLLg+4tdy0brb4VjFlwdGfTNhmF5S3h6MhOklvmd5JlGwn8ed1Kag5z
	BjH7DRxXDR0k3gR1aR6PQ==
X-ME-Sender: <xms:f5qmaeMEreg6Mfp8szD6-Ih8nHZa-PZIcjXq8EdfPex2uCdsm-4QWw>
    <xme:f5qmadW6YalDpNVUhnDvOqw6EbIzY3q2qMLsYRfcUJvcfVQ4dfcnKUaYwlrCoRSfN
    fK3LKRxsITybNys4XR_spiRN06g9ai2ufgsB2xD7JNEDmq_ZQliJDg>
X-ME-Received: <xmr:f5qmaWb4jV1_M8DFTFXWMyVCcu2_vz6n3nyEjEvmGxUeCc_cxRuQ3HslJP05odmc0IVW-79ikLghWekyKZYoSs5eAE28jA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedttdelucetufdoteggodetrf
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
X-ME-Proxy: <xmx:f5qmaasYeHI-XWfTFbhjIMuZeJlpeppabg_iyMvc3ifJ0A8fjU-opg>
    <xmx:gJqmaVknH0bSUgw8zFTrN3eNRrbjjDOv340CFbHWzcBHyIfNx_SjaQ>
    <xmx:gJqmabVeZfft4lstDQrXjx6rncw_9tSeNUZ9AgQQ2zJnJ0opSnKgYQ>
    <xmx:gJqmaYmOQfSIsMBhf0VPktj1aLakjWjRmyb6Sl1yV9C8tPaYAKfLZw>
    <xmx:gJqmaQaVT4JP7gHAy2G-hS6F3kj5BX7TDt6ThrlnHk1AoxZZNyHNjRHS>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 03:23:25 -0500 (EST)
Message-ID: <df29346f-50db-4d7d-9ea1-876c73ad3e74@pobox.com>
Date: Tue, 3 Mar 2026 00:23:24 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.19 000/850] 6.19.6-rc2 review
To: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260302160834.2518716-1-sashal@kernel.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260302160834.2518716-1-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D21221EACAA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-222824-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,pobox.com:dkim,pobox.com:email,pobox.com:mid]
X-Rspamd-Action: no action

On 3/2/26 08:08, Sasha Levin wrote:
> This is the start of the stable review cycle for the 6.19.6 release.
> There are 850 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar  4 04:07:42 PM UTC 2026.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
>          https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/patch/?id=linux-6.19.y&id2=v6.19.5
> or in the git tree and branch at:
>          git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.19.y
> and the diffstat can be found below.
> 
> Thanks,
> Sasha

Tested on 3 systems (2 amd64, 1 arm64). Working well, no regressions
observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

