Return-Path: <stable+bounces-272462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VBHuOMceTWrTvQEAu9opvQ
	(envelope-from <stable+bounces-272462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 17:44:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 439D871D74E
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 17:44:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leemhuis.info header.s=key2 header.b=g1D1lhvV;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272462-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272462-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A6F8F302D101
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 15:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436964229CE;
	Tue,  7 Jul 2026 15:29:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CB11428480
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 15:29:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438167; cv=none; b=ZFhhcvxks3pp36PysGGbuLe6ltrM1IyR6vAJCxKWX91UT6/ypLdPtlqDpHuI6Xgw7pBqpWJ1phKzwoHzkadssxFXzVKWyCTza0CTZGYhSrMfWwqPQlD11LWxn4k1PumFHWSCohLAoAF6FtAxa6lA8WbZo3WAQs0fpwHt/zbGPKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438167; c=relaxed/simple;
	bh=REaOruDBCjhkNh9b2sAumrucOd66GndzoVphB3kYq8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ipka8X4I0/cgmpT+lyJXh9/G1+tpL5wjp7DboD3T2R97QfvRyM1lBWyHOD8R0cssyLbmCZkFcE8Og1DCI1Wl5V/sz6zEPcrtUuGNnqvKj12m/xYqdCBfMmP04eqUSJ0yhj3xlv7AUS3/oq9bUOQmPSfjjlqyHt3PFew6Qb2lCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=g1D1lhvV; arc=none smtp.client-ip=188.68.63.102
Received: from mors-relay-2502.netcup.net (localhost [127.0.0.1])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gvlW15N3bz63JZ;
	Tue,  7 Jul 2026 17:28:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1783438125;
	bh=REaOruDBCjhkNh9b2sAumrucOd66GndzoVphB3kYq8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=g1D1lhvVyb54kjVDB0ENPq+kRlmU65sBRPGgdNB72saJGsnMkxcr9vjkZ/QIPU2Ex
	 /jTz3pHyUV8rGckdji2KsfFHieTgH/Fu2CjXgpknoaIn26X+CRe2stGjQxWrjysRmO
	 ctoHIvhM7rLK0gYMCf711oHL7tahUT6PQbT9uiAPy66lFSfoiAQj/8QOAZ0rSGFNyA
	 DJQES6q7CMUTzZChm4YfOrFRqZYmkJYP4vd/YzZB1jj1NeheUFP1T8Sm4FPbzC6LhM
	 sXz+rcBspPdYOab0yTK3Rz09Rj8+cfl6aVZl6Acf9nnNaKpP9LRngK5ZIDv9DiBzhq
	 BUbJmz13+a7FA==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-2502.netcup.net (Postfix) with ESMTPS id 4gvlVy2Ccvz4xvX;
	Tue,  7 Jul 2026 17:28:42 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gvlVx0PZCz8td4;
	Tue,  7 Jul 2026 17:28:41 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 515CD5FC43;
	Tue,  7 Jul 2026 17:28:40 +0200 (CEST)
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <4291a537-1380-4968-b079-b7bd4a5e688c@leemhuis.info>
Date: Tue, 7 Jul 2026 17:28:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Some 7.1-post fixes that might be worth picking up rather sooner
 than later
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Linus Torvalds <torvalds@linux-foundation.org>
References: <91281f28-eccf-4681-8f62-faaa8a3ba529@leemhuis.info>
 <2026061917-flinch-idealism-898f@gregkh>
 <2026062236-ludicrous-detached-6e20@gregkh>
 <d3d467d3-637c-49fe-8516-8da65cf4261b@leemhuis.info>
 <BN9PR12MB51469BC3FEC959A89AC9CB54F7F02@BN9PR12MB5146.namprd12.prod.outlook.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <BN9PR12MB51469BC3FEC959A89AC9CB54F7F02@BN9PR12MB5146.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178343812072.1558780.9000985482465768600@mxe9fb.netcup.net>
X-NC-CID: aG4WSZhQ1hrK0agcCmggpiaN1BG/R1WIb54YRj3Xtlz7XO5/myo=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272462-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Alexander.Deucher@amd.com,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:regressions@lists.linux.dev,m:stable@vger.kernel.org,m:Christian.Koenig@amd.com,m:airlied@gmail.com,m:simona@ffwll.ch,m:torvalds@linux-foundation.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,amd.com,gmail.com,ffwll.ch,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 439D871D74E

On 7/7/26 17:19, Deucher, Alexander wrote:
>> -----Original Message-----
>> From: Thorsten Leemhuis <regressions@leemhuis.info>
>> Sent: Tuesday, July 7, 2026 6:19 AM
>> To: Greg KH <gregkh@linuxfoundation.org>
>> Cc: Sasha Levin <sashal@kernel.org>; Linux kernel regressions list
>> <regressions@lists.linux.dev>; stable@vger.kernel.org; Deucher, Alexander
>> <Alexander.Deucher@amd.com>; Koenig, Christian
>> <Christian.Koenig@amd.com>; Dave Airlie <airlied@gmail.com>; Simona
>> Vetter <simona@ffwll.ch>; Linus Torvalds <torvalds@linux-foundation.org>
>> Subject: Re: Some 7.1-post fixes that might be worth picking up rather sooner
>> than later
>>
>> [CCing a few people]
>>
>> On 6/22/26 07:32, Greg KH wrote:
>>> On Fri, Jun 19, 2026 at 11:43:41AM +0200, Greg KH wrote:
>>>> On Fri, Jun 19, 2026 at 08:04:35AM +0200, Thorsten Leemhuis wrote:
>>>>> Hi Stable Team! From the regressions point I think it might be nice
>>>>> to pick up the following changes for the next round of stable updates (e.g.
>>>>> 7.1.2), as they seem to fix regressions I've seen multiple people
>>>>> report with 7.1:
>>>>> [...]
>>>>> * 12f58a6caad3be ("drm/amd/display: Fix Color Manager (3DLUT,
>>>>> Shaper,
>>>>> Blend)") [v7.1-post]
>>>
>>> This doesn't apply to 7.1.y, and would need a working backport.
>> Just a quick status update twimc:
>>
>> I pointed that out in
>> https://gitlab.freedesktop.org/drm/amd/-/work_items/5396 , but nothing
>> happened from the AMD side afaics. They have much on their plate, I fully
>> understand that, I guess it fell through the cracks (maybe this mail helps).
>> Thing is: the backport of the revert is quite big, so nobody else (including me)
>> did yet dare to submit it themselves.
> 
> I've put a backport on the ticket.  Just waiting for verification from the affected users.

Great, many thx!

>> So two weeks later the regression caused by e56e3cff2a1bb2
>> ("drm/amd/display: Sync dcn42 with DC 3.2.373") [v7.1-rc1] is still unfixed in
>> 7.1.y as far as I can see it -- a regression that is known since more than two
>> months now, as the revert to fix it (12f58a6caad3be, mentioned in the quote
>> above) was submitted already on 2026-04-29, but only made it to mainline
>> during the merge window for 7.2 (this is another thing that afaics fell through
>> the cracks; sadly I only became aware of the regression after 7.1 was out,
>> otherwise I would have made noise earlier to get it included in 7.1).
>>
>> This all seems rather unfortunate.
>>
>> Luckily is seems the KDE Plasma developer turned off support for the color
>> pipeline stuff in Kwin 6.7.1
>> (https://invent.kde.org/plasma/kwin/-
>> /commit/9079a417b821f80c0d9e3bc5014a388e0e340f82
>> ), which apparently avoids the problem for many users (see the
>> gitlab.freedesktop ticket linked earlier).
>>
>> Ciao, Thorsten


