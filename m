Return-Path: <stable+bounces-216769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAbfN08klGnXAAIAu9opvQ
	(envelope-from <stable+bounces-216769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 09:18:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACBD149D68
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 09:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F791300A63C
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 08:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46BB29C325;
	Tue, 17 Feb 2026 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="K/INfGig"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.61.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C6F33993;
	Tue, 17 Feb 2026 08:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.61.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771316298; cv=none; b=RLUWNN7MgWWrS/Sj0nOX/ryr1GWu22CheYFmfbyzuyIpm+DJOwaKCfpyoQJE5ld9+7VvaMDxKQKntZ8f/q88KnJUDlKDEfXNnnxAmav/nTv4q6c9SQIwA8VUKfVZCFczfCfp9/ESpe/aFVdzImNF+XK5+0DoCeqXUwA56XN0KrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771316298; c=relaxed/simple;
	bh=wNmASthUQB6K1/NE1lVtryc0WHAWlmUfvnJEL99T7II=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:To:
	 In-Reply-To:Content-Type; b=UyZyth+AMFdpRlYcLOx4t8oh8QG+jBb9kjQfNVaRNjGLurtNloiiUuNFgTjhSa781c8Sen1+8Eah6AaU//q4mOKu+g6LKoTWqNKxsUAql2Xh/SQO2DUeXlztLxfOv0ihQsakDwBga4D4VFhISEPDr1Nf0ZuDMksMmQphMbBbJxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=K/INfGig; arc=none smtp.client-ip=188.68.61.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8405.netcup.net (localhost [127.0.0.1])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4fFXZj2MFDz73QD;
	Tue, 17 Feb 2026 09:18:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1771316285;
	bh=wNmASthUQB6K1/NE1lVtryc0WHAWlmUfvnJEL99T7II=;
	h=Date:Subject:Cc:References:From:To:In-Reply-To:From;
	b=K/INfGig2CqnhuhFu1l3cReb1UiZU0ljGlD2Ay1S+/Opx0y8AXgvZVUK4lrSrka81
	 RPr8l0PTa9CuY9CapWdjy4Dq+WueC/ipSxSnmd4Gm0LNoFrhNJ9b1h0LUU4qRgrCAZ
	 stAP+rAtnk0hvt0ykzH/WmnRdkhfefImMx9PfOUwigJQZZ5MNmGNmeD+Bz2B8JXWkX
	 gK/ZbXHhOmecX1JdOtchrAKRHSOXyVwnRfbXC+94c59EZMAAGfm3FTuKDGeh/2NxLe
	 +hqz5NOeurvA+fgZN+4Vig3SoJG4QbAE1CjwdmPiVkQlWR+sU8tznTQQjdIHsG8hZd
	 ETi+s84gglMqQ==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8405.netcup.net (Postfix) with ESMTPS id 4fFXZj1djdz73QC;
	Tue, 17 Feb 2026 09:18:05 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fFXZg1pH9z8sbs;
	Tue, 17 Feb 2026 09:18:03 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 771AE67559;
	Tue, 17 Feb 2026 09:18:01 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <6fce0406-1515-4cf8-afdf-24217148d1c8@leemhuis.info>
Date: Tue, 17 Feb 2026 09:18:00 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] mt8183-kukui: dts: changes in dts caused display to
 no longer initialize - Was: Re: mt8183-kukui: drm/mediatek: dts: Invalid
 display hw pipeline when probing mediatek-drm
Cc: Evans Jahja <evansjahja13@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 regressions@lists.linux.dev, =?UTF-8?Q?Otto_Pfl=C3=BCger?=
 <otto.pflueger@abscue.de>, Denis Gessert <denisgessert@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
References: 
 <CAFLVeg9hwH3PbKu5rPWZWqq6yz5mRRoB9oqxDkxNRdEDLGbVBw@mail.gmail.com>
 <CAFLVeg_soeYV4tOYKMo6TMYOtuWWU4TFCjUTxUrVEyGcRwMz7A@mail.gmail.com>
 <df6fcd73-fe0a-42fc-97ce-7e458c340553@leemhuis.info>
 <CAFLVeg-qeWu4ntgyqotsgjogPEyhqrMGG=UDWuZe+-D3K8YPTA@mail.gmail.com>
 <908f3c03-a8b0-4535-9cfa-294c6ade8152@collabora.com>
 <96e7f0fc-65f4-4613-b556-3a2d869dabb4@leemhuis.info>
 <86e2d0f9-5c25-4cce-b4a8-68fb569f987d@collabora.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
To: Greg KH <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sasha Levin <sashal@kernel.org>
In-Reply-To: <86e2d0f9-5c25-4cce-b4a8-68fb569f987d@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177131628267.3901032.8736787722890015484@mxe9fb.netcup.net>
X-NC-CID: P5UaJjDo5RUgOdWt7kmuYNYP5qwhRRqev6fiWP7bbNuOTjfyU6I=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,abscue.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-216769-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,vger.kernel.org,lists.linux.dev,abscue.de,collabora.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4ACBD149D68
X-Rspamd-Action: no action

On 2/16/26 11:46, AngeloGioacchino Del Regno wrote:
> Il 13/02/26 10:27, Thorsten Leemhuis ha scritto:
>> On 2/9/26 12:42, AngeloGioacchino Del Regno wrote:
>>> Il 06/02/26 17:58, Denis Gessert ha scritto:
>>>> Thanks for the quick response. I compiled 6.18.9 with this patch
>>>> (without reverting the previous commit) and it boots successfully.
>>> Happy to see further confirmation that the patch that we both
>>> mentioned is
>>> actually fixing the issue.
>> The big question remains: Now that this landed in mainline, should we as
>> the stable team to pick this up for 6.18.y and 6.19.y to get it resolved
>> there quickly? They might pick it up on their own due to the Fixes tag,
>> but that is not guaranteed.
> Yes, please, that'd be great.

Hi stable team! Could you please pick up be0b304eeb8c5f ("arm64: dts:
mediatek: mt8183: Add missing endpoint IDs to display graph") [merged
v6.19-post, committed by Angelo, who ACKed this request; see quote
above] for 6.18.y and 6.19.y? It fixes a regression in e72d63fa0563
("arm64: dts: mediatek: mt8183: Migrate to display controller OF
graph"). tia! Ciao, Thorsten

>>>> Am Fr., 6. Feb. 2026 um 15:55 Uhr schrieb Thorsten Leemhuis
>>>> <regressions@leemhuis.info>:
>>>>>
>>>>> On 2/6/26 12:33, Denis Gessert wrote:
>>>>>>
>>>>>> I found this email chain while troubleshooting why my Levovo Duet
>>>>>> (with the MT8183 chip) would not boot using any 6.18.* kernel.
>>>>>>
>>>>>> I can confirm that on my device the current stable 6.18.8 does not
>>>>>> boot unless I revert the commit
>>>>>>
>>>>>> commit e72d63fa0563f8a6e98c10fed3a9ce74dc0536e6 (HEAD)
>>>>>> Author: AngeloGioacchino Del Regno
>>>>>> <angelogioacchino.delregno@collabora.com>
>>>>>> Date:   Thu Jul 24 10:39:08 2025 +0200
>>>>>>
>>>>>>       arm64: dts: mediatek: mt8183: Migrate to display controller OF
>>>>>> graph
>>>>>>
>>>>>> mentioned below. With the reverted commit the device boots as
>>>>>> intended.
>>>>>
>>>>> There is a fix for it from Otto here that I guess should help
>>>>> https://lore.kernel.org/lkml/20260106-mt8183-display-graph-v2-1-
>>>>> e7e56054eef5@abscue.de/
>>>>>
>>>>> Side note: lacks a stable tag and maybe should have been merged this
>>>>> cycle instead of the next. But given that 6.19 is immanent it might be
>>>>> good if this could be backported to 6.19.y once it landed in mainline.
>>>>>
>>>>>> PS: Apologies for the potential double-mail.
>>>>> No worries, happens.
>>>>>
>>>>> Ciao, Thortsten
>>>
>>>
>>>
>>
> 
> 
> 


