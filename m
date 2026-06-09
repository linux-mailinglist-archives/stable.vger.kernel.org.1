Return-Path: <stable+bounces-262316-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 3DWDG5tCKGrmBAMAu9opvQ
	(envelope-from <stable+bounces-262316-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 18:43:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 61B6D66287E
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 18:43:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=RWHM2HMx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262316-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262316-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C6CD4314190A
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 15:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78D154949FF;
	Tue,  9 Jun 2026 15:47:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4525749253D;
	Tue,  9 Jun 2026 15:47:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020071; cv=none; b=NjkZzbDEWnVppYeZ0VQeD6r3EvZLgwlj6c8Tkp4+aJqXk63hACT9OSOjOu7PwrP1VHCxwvX/evvZUH9hEFscUe2lyS6DxGv44ujCpTz/CmtX3xEYzQH54M4RMnlC1Tbz6cXZ+7pNIj7YrpixbYCGrxgYd081UNM4XlROMYdnqME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020071; c=relaxed/simple;
	bh=cbrRB3iun2jPOI1G8tDpe8tvqFPshRG9kYKbGP74bHU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lR8edtQzA5n4h5t9myTUOnilMyB6jgUY80r1b/digVtkUjX5r8h+thQQ82Nr9IGeLLZlOjEuAFv4LonbrsAop9+MoL5JPMxS9OlEWNHDcrlucuKptAnSXaSke2Zx8jMwp9XpQZD9gxXufCNXNAVXM0005H+PysLtGTqy6gbNp3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWHM2HMx; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CAD71F0089A;
	Tue,  9 Jun 2026 15:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781020070;
	bh=lmuCWFZUHbzVjGlqSt71AgiXRxPyfL3cM+3WUJCq7Oc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RWHM2HMxAq4nu06OJYqGwgtnq2OWCJIsqamgeAEiOrlo/UYkkmKOQG+/zGsEeI7mB
	 lcNxHuXApUzRbKwmVxrEeMeMWK+Q3CM3/hhsUdedLvu7mjLIhTcMe0Z2NqlgXUeTPD
	 ffkZnlAbwDK2L3q+v/K/j3tITM8Xhb7NacxuqEUcwNXTRevX4qf8HY4ZvtrtwLKPvf
	 mQHyJ1V1fzL+NvyhtQ+L/7MXOHyUppiPrEuwrIpktxvN/hIwuu4RaLHN1cTFmYeywW
	 kC1v6bKcyikIF0fYfQ8bdrtDIk4HoYlr/tp7TVIej2zsCquRMLeT5JJnM6G56sbKxo
	 t1WbdmwKipZlQ==
Message-ID: <91af1da1-e2d0-40c1-87b0-452b48f4a2b6@kernel.org>
Date: Tue, 9 Jun 2026 10:47:48 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/4] platform/x86/amd/pmc: Delay suspend for some
 Lenovo Laptops
Content-Language: en-US
To: Daniel Gibson <daniel@gibson.sh>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hansg@kernel.org>, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>,
 Sindre Henriksen <sindrehenriksen93@gmail.com>,
 Hans de Goede <johannes.goede@oss.qualcomm.com>, stable@vger.kernel.org
References: <20260609105756.2813669-1-daniel@gibson.sh>
 <20260609105756.2813669-3-daniel@gibson.sh>
 <2fbb4d9d-7ad5-d4e7-b510-d7c75f399d97@linux.intel.com>
 <6b6ce9ce-5bda-4924-b2d2-933736cfad9c@gibson.sh>
 <cecea384-7af9-4fc6-b315-84d4ac8fb31d@kernel.org>
 <3b49ba16-d318-4905-bfe0-ebcc7ef374c5@gibson.sh>
 <5b684d9c-2477-488d-a89b-323ca3e51207@gibson.sh>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <5b684d9c-2477-488d-a89b-323ca3e51207@gibson.sh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262316-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:daniel@gibson.sh,m:ilpo.jarvinen@linux.intel.com,m:Shyam-sundar.S-k@amd.com,m:hansg@kernel.org,m:platform-driver-x86@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sindrehenriksen93@gmail.com,m:johannes.goede@oss.qualcomm.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[superm1@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,vger.kernel.org,gmail.com,oss.qualcomm.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[superm1@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 61B6D66287E

On 6/9/26 10:36, Daniel Gibson wrote:
> On 09.06.26 17:06, Daniel Gibson wrote:
>> On 09.06.26 16:40, Mario Limonciello wrote:
>>> On 6/9/26 07:07, Daniel Gibson wrote:
>>>> On 09.06.26 13:46, Ilpo Järvinen wrote:
>>>>> On Tue, 9 Jun 2026, Daniel Gibson wrote:
>>>>>>        },
>>>>>> +    /* https://bugzilla.kernel.org/show_bug.cgi?id=221383 */
>>>>>> +    {
>>>>>> +        .ident = "Zen3-based IdeaPad Slim and similar",
>>>>>> +        .driver_data = &quirk_s2idle_need_suspend_delay,
>>>>>
>>>>> Hi,
>>>>>
>>>>> One more question.
>>>>>
>>>>> Sashiko noted, that amd_pmc_quirks_init() can overwrite
>>>>> disable_8042_wakeup from the AMD_CPU_ID_CZN check when .driver_data
>>>>> provides quirks. Is it okay in this case to not have .spurious_8042?
>>>>>
>>>>
>>>> Good question.
>>>> So far I haven't had complaints that sounded like they'd be related to
>>>> this quirk not being active.
>>>>
>>>> (The only report about things not working as expected on detected
>>>> devices was something about "ACPI event storms" after resume:
>>>> https://github.com/DanielGibson/amd_pmc-ideapad/issues/3 - but no one
>>>> else with similar devices could reproduce that, so no idea what's going
>>>> on there, and it doesn't sound like that IRQ1 issue)
>>>>
>>>> I can test if explicitly enabling .spurious_8042 in
>>>> quirk_s2idle_need_suspend_delay breaks anything on my device, if you
>>>> think that enabling it by default makes more sense?
>>>
>>> Famous last words - but we haven't had a need for spurious 8042 on
>>> recent hardware so I think this is unlikely to be a big problem.
>>
>> FWIW enabling .spurious_8042 didn't break anything on my machine, but
>> didn't improve anything either - only visible difference is that when
>> resuming by pressing a key without that quirk both IRQ1 and IRQ7 are
>> reported as having triggered the resume, and with the quirk only IRQ7 is
>> reported. But it didn't seem like IRQ1 triggers a resume when it shouldn't.
>>
>> OTOH I have a the latest BIOS (from this year), so it's likely fixed
>> there - maybe people with older BIOS versions still need the
>> .spurious_8042 quirk?
>>
>> As these devices are relatively recent and still sold I hope that
>> everyone affected can get a new BIOS (which they should do either way).
> 
> Anyway, overall I'd say that the patches can be merged as they are - the
> affected devices are known to have serious (-ly annoying) suspend
> issues, so it's unlikely that a currently matched devices has working
> suspend that breaks with them, so things at least shouldn't get any
> worse for their users?
> 
> The patches have gotten some testing already on different devices (from
> my out-of-tree patched amd_pmc module on Github) and so far it looks
> like the spurious_8042 quirk isn't needed.
> If reports of needing both quirks turn up after all, that can still be
> easily added in a few lines of code (maybe even just one).
> 
> Cheers,
> Daniel

Even with all that testing; it's only on hardware with problems.
We don't want to have issues exposed by these patches for people that 
didn't need the patches.

So my 2c:
* It's "too risky" to pick up for 7.1 final
* It's a "bit late" in the cycle for 7.2-rc1 (usually new content stops 
being added around rc6).
* This isn't "risky enough" to wait until 7.3 (basically after 7.2-rc1 
merge window is done)

But this has been on the list for a while now, so I would say this makes 
sense to put in for 7.2-rc1 and we should all make sure we test well 
once the RCs are posted.

