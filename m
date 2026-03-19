Return-Path: <stable+bounces-227230-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBmfHYKzu2k8mgIAu9opvQ
	(envelope-from <stable+bounces-227230-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:27:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D26202C7DD4
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 09:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 551BA302794F
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 08:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEC53A2549;
	Thu, 19 Mar 2026 08:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ea6ugang";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="x0D+huwD"
X-Original-To: stable@vger.kernel.org
Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F18523D2B1;
	Thu, 19 Mar 2026 08:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908816; cv=none; b=p1+lhQYGVv0Hifq+3e1BA9sPA59mgo6bpJ4hRIVqv1deWODicE5tUF+7V+NvtdXCV84IOalFFx0wPhfuBLPclcMteUdoESCVreqW5gDuNudry3e8B95WWTlTIljhMTif9fD2ozmUBMTBLtpTrzBy2XsXGaQwOWE3azOdQ18mu98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908816; c=relaxed/simple;
	bh=QJOhTaAddVnvsG09Wf+rZMNOQ4xuFVwCy16hK5JFG5A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P4om/dc+v5XtyseT8HxJ1c2SNIOq8wIf1jWdvl6TcEmm1e2dWjXZWq1JeMd6s175iClPNlwVGmamzJNrbXHbZsZQp/B/Ud2j8ZqMY6uqj01B0YCEYAPFDDZDphZ5Q42shjRACkOxrTGOurdZr5PndYQa1jVj0Qm5hGH5RwuUB0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ea6ugang; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=x0D+huwD; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8C4DC7A0132;
	Thu, 19 Mar 2026 04:26:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 19 Mar 2026 04:26:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1773908812;
	 x=1773995212; bh=WFwuZnAjuhsMYTU68qmvbTKAqdxZhPbPWdtmqubrYYQ=; b=
	Ea6ugangEBeBWxFyrjCGSZ9DvG+c5v1kVBBJPZByWAFyXYd2uj+xg54XEecMgCJn
	AqIBy8yb9GeTOSkRBG42ZrZ6ztUP+9deyoqcPpl0QNN8aaVpT+dnXVMCci8YMiR6
	6TJT7XFmIElC/bfjHYYqcYT+cBLxTl/RvP0YN3rzNDYfXVYjbd+420hBi26lncvN
	vcQALdGgIWxdItQ9Y8cwqg+hPTcPIohfEqh6pBrgwwY462LH6EPznvVemAJLvAO4
	m/1IL78PzKkBl49hNd5hWgsfNx3FFXgxdWkhvw0R76djpHlVLVSFGS7WGvQ+0yMV
	vKV1s+rBL/YyaW+hssz/Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1773908812; x=
	1773995212; bh=WFwuZnAjuhsMYTU68qmvbTKAqdxZhPbPWdtmqubrYYQ=; b=x
	0D+huwDSYTPXc5WV7DrWpJJj65BTehudEZnbqWpYiGQxH8akDeTju07IZfLurjRZ
	bnyP0cVUPTsZIAnOHUOBXncpMcBkuvFjU1enq1aihk01RRBg3H7eXblMXBPznESu
	6egqpGzuNYanaJ4V/NoRqJH/4hIY85IwVkNlTLDADVNGcIbWfagMn18eSUlX9H56
	dYL/WiTaZ6iwucARvRGtBmMJyfjZEsBhm9v1FtEEhzSctXldURonhpBmpaYCmbHh
	ErThOCmeY57rNWBKv6frwM9OlWdlQA+uCFdSx4oC7LqSInsN5WozPbYhS+6fpxQw
	YYDq9803Vfb+Dp/gs2MSQ==
X-ME-Sender: <xms:S7O7aYTIx5LkY-e0PlkeQw2jvJfSS9HHPPV53vB_5DPjA2CG5ndVVg>
    <xme:S7O7aRpH6iqpsKkX_vKwOVz_8hbPRKQoHak5ipiAj4cpvBnKl_OFaCk8WPfn-BrgH
    s51wdHgsYI_3iKrWbBG5GLVnyF0wl9Tqq81UGMZDodRh3plqgZOJus>
X-ME-Received: <xmr:S7O7aRWJreLOIrn3Hkb7vQvYHzgYKPSl7Zz4UNQ74930_cP24Ol-pp6r6YZMpstDTH7e3bbFd2lDhIK4yRiI0Bx7Szj9rA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeftdeihedvucetufdoteggodetrf
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
X-ME-Proxy: <xmx:S7O7af8l21Wz9IgJWJ9z5ukNdvuDm7Ovsu82i6p9JH76gW_BE1WSCw>
    <xmx:S7O7aZYA8hbhz4O_uMMKfZk1kqiW7-SG4TFhr-ESbYDL4A9fosLRiQ>
    <xmx:S7O7aXeaNJCL3-ReTdjQ4UgHucb5pgssZ6kNA0YWz-L5QRaFlSh23g>
    <xmx:S7O7aTrQqkrkeCKzJeJsTY1wYFxL9890q2BxeJXdgrTO58I_xs4hLw>
    <xmx:TLO7aTl3xDE2j1rBR50wHugH_DtpxkoxVa5wKVNKxKo0i8Iz2yZT9hjE>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Mar 2026 04:26:48 -0400 (EDT)
Message-ID: <d5d10fc9-27fc-4c8b-b827-adb345ccb486@pobox.com>
Date: Thu, 19 Mar 2026 01:26:47 -0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.18 000/335] 6.18.19-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, rwarsow@gmx.de,
 conor@kernel.org, hargar@microsoft.com, broonie@kernel.org,
 achill@achill.org, sr@sladewatkins.com
References: <20260318122621.714862892@linuxfoundation.org>
Content-Language: en-US
From: "Barry K. Nathan" <barryn@pobox.com>
In-Reply-To: <20260318122621.714862892@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	TAGGED_FROM(0.00)[bounces-227230-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.985];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: D26202C7DD4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/18/26 05:27, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 6.18.19 release.
> There are 335 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 20 Mar 2026 12:25:23 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.18.19-rc2.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.18.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Tested on 2 systems (1 arm64, 1 amd64). Working well, no
regressions observed.

Tested-by: Barry K. Nathan <barryn@pobox.com>

-- 
-Barry K. Nathan  <barryn@pobox.com>

