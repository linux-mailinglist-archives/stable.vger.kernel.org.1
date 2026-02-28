Return-Path: <stable+bounces-221229-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HhiBzB9o2noEgUAu9opvQ
	(envelope-from <stable+bounces-221229-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 00:41:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E4F1C9C07
	for <lists+stable@lfdr.de>; Sun, 01 Mar 2026 00:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2491D301BA51
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 23:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AF3D368948;
	Sat, 28 Feb 2026 23:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TTyJUxhH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="T28USL3F"
X-Original-To: stable@vger.kernel.org
Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBA422FE0A;
	Sat, 28 Feb 2026 23:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772322093; cv=none; b=MIuUxHCZLKzf8uGTUOVevw3Klrh2vStyWBnUsdReReO6FCcrbPooNQXiznITqF7/GDniJkJgqRaSgyHlFs/trvFpva+XgKcLQqwIXLARl4SzSR7OheoDrUPtj7GwnYXzwFMud7ZwTm9DKbc4B+walfSCAt6ZH8yBWiEWBgLdRmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772322093; c=relaxed/simple;
	bh=eKNZaC3XxAPvfv9hHSICGD9nR0lJKTbaPDsOeXAghxA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=WjGuB+XPyfJRoLun5VzRNRattfbs5Al9u/CyRnkeHdotdwOkqXTMrD+1mRUYJdaDYRB9MrvXwF/fWbtosR0gOVrueVkx8eMrib610qx2C/64f9PyaWnyqIbvmGDVx/xeQfP48Iay/afyksYc0ABTHdFGUvdH3j6EXNqdCjltP4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TTyJUxhH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=T28USL3F; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id BE1841D00125;
	Sat, 28 Feb 2026 18:41:29 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Sat, 28 Feb 2026 18:41:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1772322089;
	 x=1772408489; bh=uuZmFrv9AWrdMZr6yL+vBRfXbPdj+HVHSytH9DSa6UM=; b=
	TTyJUxhH/Uvh8u17qdw6UZhvOc3PBy/Vx3qz8rhh5j1v5p9JYc24QrWOvmOk2wLt
	Zsnrlobv0Ucsvw5FU8fSyC8iVqExXUTx+DL6hDXhOSZy4xndQY/npjrOJKFWcXl+
	Jvyzii7N5KKxU6+gx64cK9LXFFoLrACmgEJDZEmp+6sO/8NV+GuqpiYmwkzCPPyB
	PGzg9Nmd5evj0noL06DlDvmVrMhLsnu2PWg4TpzkdO1c34RCC53WGvy7EfOe9ZXI
	4Lcwy4eWoKq54FDgAWlExbcZAOwiJdfnE6mLTFzhgla7ZqJITzIvjP8YwfgsxiH7
	y+bYZRQo55VTOjBXU3d1Tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1772322089; x=
	1772408489; bh=uuZmFrv9AWrdMZr6yL+vBRfXbPdj+HVHSytH9DSa6UM=; b=T
	28USL3FX9gih0C7TrRhO2eWaJP/ryjuyG6HFwoCUbuS0uz7EO0r+oyqKVJwjDxuV
	yD1nTqSrwKxcs/f6LFsxYfjW9xbWP6Yk/Xdimh9V1JAefG/ml30gW3+/j0S3ka4t
	5bZWr0+y6lafBrhZ0YdHtGs9F9N6B2QYmwxcc0N/anbxDOkXtmhiubtc+vDOmZ5U
	A3GQkDfiOoSZqH6/jBWszPWfpJ5eeKoCNPop7nMjAkp9U1LTpTUiGHpux5P7ROfD
	L2Ick7iFM0GaI9OBVVa2otHlAiLoPj80KOgz+w5ZPCSkWx9FRwb8Iv87pQpMKon3
	Asu8576MUUpoaro5+3J2Q==
X-ME-Sender: <xms:KH2jaV8VtC7gjFmKj_ooiXoCV8J-9oDqHG-yErK_J19oyaau_ckQ9g>
    <xme:KH2jaaI64d7AOfKvSvGz9jjxZBV8kbR-28n_zih72FpootCwn1lu8Q4KnomJq3Bk-
    wm0Q3IL1n3CF7q9Xr4bwBoWPjmOGYo45fVvG_lEU3Fk6-2LjyBWbbaT>
X-ME-Received: <xmr:KH2jaYfGqZ7Mw-u4bNeEJrCiQkAa5_WXBcNeFlLKXfN6vypQ9KerPhfSXKYW6W5W4rly59mKZgR0giGsAuW4-S__KjIz9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheefvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfhffuvfevfhgjtgfgsehtkeertddtvdejnecuhfhrohhmpedfuegrrhhr
    hicumfdrucfprghthhgrnhdfuceosggrrhhrhihnsehpohgsohigrdgtohhmqeenucggtf
    frrghtthgvrhhnpeeiffefteetgeehueetvdfhvdduvdetueeivdeiudduhffhfffhveeg
    ueegheduudenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggrrhhrhihnsehpohgsohigrdgt
    ohhmpdhnsggprhgtphhtthhopedvvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epthgvrhhrrghluhhnrgeljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhifrghr
    shhofiesghhmgidruggvpdhrtghpthhtohepshgrshhhrghlsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehsthgrsghlvgesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphht
    thhopehprghttghhvghssehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtohepth
    horhhvrghlughssehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthho
    pegrkhhpmheslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhg
X-ME-Proxy: <xmx:KH2jaXYoU0MxIoIrnDC1wNIOhuztZWY50Mh-X5V-iIJMDlAqlEEPjw>
    <xmx:KH2jaeC2QfmDqthVOmMvMA1f-NcZ3q9Rwz_KUv-Ji5izt46Ws1vtEg>
    <xmx:KH2jaaIkkRc_kaNThpffKCpHEYUj8-oxDu0ECh13krH_tRjzECPn3Q>
    <xmx:KH2jaVoK0BdpxCOygcTHUHgBkjvXRfvWjPpYYTQuYp4KEDmiSP0Qnw>
    <xmx:KX2jaUb9Kxm442sydkT-7jYbCeVan-KuP-4Dcc7B260FJWTbM35IEvBx>
Feedback-ID: i6289494f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Feb 2026 18:41:26 -0500 (EST)
Message-ID: <2a740a8d-e5f8-4922-bd2b-04bc76893bbc@pobox.com>
Date: Sat, 28 Feb 2026 15:41:25 -0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: "Barry K. Nathan" <barryn@pobox.com>
Subject: Re: [PATCH 6.19 000/844] 6.19.6-rc1 review
To: Woody Suwalski <terraluna977@gmail.com>, Ronald Warsow <rwarsow@gmx.de>,
 Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, patches@lists.linux.dev,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org, pavel@nabladev.com, jonathanh@nvidia.com,
 f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, conor@kernel.org,
 hargar@microsoft.com, broonie@kernel.org, achill@achill.org,
 sr@sladewatkins.com
References: <20260228173244.1509663-1-sashal@kernel.org>
 <601576c7-970a-4e9d-af5e-c818740be8e8@gmx.de>
 <879487cc-c667-8cc6-4775-02c7de3b8c27@gmail.com>
Content-Language: en-US
In-Reply-To: <879487cc-c667-8cc6-4775-02c7de3b8c27@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pobox.com,none];
	R_DKIM_ALLOW(-0.20)[pobox.com:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-221229-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,gmx.de,kernel.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,microsoft.com,achill.org,sladewatkins.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[barryn@pobox.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[pobox.com:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pobox.com:mid,pobox.com:dkim,pobox.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,messagingengine.com:dkim]
X-Rspamd-Queue-Id: 36E4F1C9C07
X-Rspamd-Action: no action

On 2/28/26 14:13, Woody Suwalski wrote:
> Ronald Warsow wrote:
>> On 28.02.26 18:18, Sasha Levin wrote:
>>>
>>> This is the start of the stable review cycle for the 6.19.6 release.
>>> There are 844 patches in this series, all will be posted as a response
>>> to this one.  If anyone has any issues with these being applied, please
>>> let me know.
>>>
>>> Responses should be made by Mon Mar  2 05:32:25 PM UTC 2026.
>>> Anything received after that time might be too late.
>>>
>>> The whole patch series can be found in one patch at:
>>> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable- 
>>> rc.git/patch/?id=linux-6.19.y&id2=v6.19.5
>>> or in the git tree and branch at:
>>> git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable- 
>>> rc.git linux-6.19.y
>>> and the diffstat can be found below.
>>>
>>
>> It would be nice to have a download link to an patch-*.gz what Greg 
>> usually provides.
>>
>> ron
>>
> I second this request. Trying to setup a build for  5.10.252-rc1 was 
> tricky...
> We need something similar to
> 
> https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/ 
> patch-5.10.251-rc1.gz
> 
> Thanks, Woody

I didn't find things particularly difficult for 5.10.252-rc1 through
6.12.75-rc1 (the "hardest" part was renaming the file after each
download), but I get this while trying to apply the patches for
6.18.16-rc1/6.19.6-rc1:


patching file arch/powerpc/platforms/pseries/msi.c
patching file arch/x86/kvm/x86.c
(Patch is indented 2 spaces.)
can't find file to patch at input line 41896
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|--
|cgit 1.2.3-korg
|
|
|From 1d0d76474aeadb174d9fbd27b9f2e9b5cfc124c6 Mon Sep 17 00:00:00 2001
|From: Sean Christopherson <seanjc@google.com>
|Date: Tue, 16 Dec 2025 08:17:54 -0800
|Subject: KVM: nSVM: Remove a user-triggerable WARN on nested_svm_load_cr3()
| succeeding
|
|[ Upstream commit fc3ba56385d03501eb582e4b86691ba378e556f9 ]
|
|Drop the WARN in svm_set_nested_state() on nested_svm_load_cr3() failing
|as it is trivially easy to trigger from userspace by modifying CPUID after
|loading CR3.  E.g. modifying the state restoration selftest like so:
|
|  --- tools/testing/selftests/kvm/x86/state_test.c
|  +++ tools/testing/selftests/kvm/x86/state_test.c
--------------------------
File to patch:


As it turns out, GNU patch (v2.7.6 on Debian 12 bookworm, or v2.8 on
Debian 13 trixie, I tested both) is misinterpreting part of the commit
comment for vm-nsvm-remove-a-user-triggerable-warn-on-nested_sv.patch
and trying to apply that part of the commit description as a patch.

Pressing Enter twice at this prompt causes patch to skip this
incorrectly detected hunk, and all of the actual patches end up being
applied correctly, but it's still an unexpected surprise and I had to
stop and figure out what was going on.

With the way the stable rc patches are usually posted on kernel.org,
the patch file would've omitted the commit comments, thus avoiding
this problem.

-- 
-Barry K. Nathan  <barryn@pobox.com>

