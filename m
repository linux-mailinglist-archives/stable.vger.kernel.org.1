Return-Path: <stable+bounces-272252-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M0QpKOm9S2oMZgEAu9opvQ
	(envelope-from <stable+bounces-272252-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 16:38:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 39085712111
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 16:38:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=WnG2ln2T;
	dmarc=pass (policy=none) header.from=arm.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272252-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-272252-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1387B31BAE62
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 14:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63B7637996B;
	Mon,  6 Jul 2026 14:13:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B46379979
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 14:13:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783347188; cv=none; b=bNbUOXi2i4HEMsMAqg7eN06DslrDODj4nl5/9LlxFnKUO3pcRm0zsPKcSVJYhVY8Eycu9FTXIVB8Jow3JxS0Opw2B8hgRU4ItMs+zDIyuHytAeWA9nLj3+8Q7hnXKAajQjqLG2lY9gxfp2rmtILY1Ocd0MgoumZQxPSWDgKaYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783347188; c=relaxed/simple;
	bh=ybqksaPU55sJFW3qtBXVCD28yakikrTrcL71vkCHABg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PQCqcT0vfadn8UX5AQOHYlWA8v7MmZW+PVmP9L8bjBV1hqRdml2J7QkHW5adZQz5ywP6J2hrg2X8pgSLyDCXd2zaL6uii0JyKBneajPJ4lJm2JOkF58w0mn7XYhUa2EaJlw/fpz2g/Fz+2L91ReOnDr7s3R2zOj9/27/kUw5YRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WnG2ln2T; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 918AF2BCB;
	Mon,  6 Jul 2026 07:13:01 -0700 (PDT)
Received: from [10.57.82.104] (unknown [10.57.82.104])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F14473F85F;
	Mon,  6 Jul 2026 07:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783347185; bh=ybqksaPU55sJFW3qtBXVCD28yakikrTrcL71vkCHABg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WnG2ln2TCLbJEPhs6x3Tu3RJp4t6P7dlYO1Br22WERGMD8ZTHXWog0AN0oLd34Y/f
	 Lqs6a+whjgBQIsnegAb8PydQsN0nM8M67NkZdoDK4+VsFce6PLUMAaMFKSKjZiJ9+Y
	 lbNrijAQVBH2qjGEL/5yzDH2nY9yHIJ6tqktj4dk=
Message-ID: <f13b30cf-e885-44c6-8e61-7924937eb8ac@arm.com>
Date: Mon, 6 Jul 2026 15:13:01 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Add HAFT support for SVA
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: will@kernel.org, joro@8bytes.org, jpb@kernel.org,
 catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, stable@vger.kernel.org
References: <878cd6bcbbe2d5677d2f63da13294c148268552c.1782927917.git.robin.murphy@arm.com>
 <20260703164914.GY7525@ziepe.ca>
 <6465c885-3a9d-4c0b-ab74-7665e274ae72@arm.com>
 <20260703192459.GB1978949@ziepe.ca>
From: Robin Murphy <robin.murphy@arm.com>
Content-Language: en-GB
In-Reply-To: <20260703192459.GB1978949@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-272252-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:will@kernel.org,m:joro@8bytes.org,m:jpb@kernel.org,m:catalin.marinas@arm.com,m:linux-arm-kernel@lists.infradead.org,m:iommu@lists.linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robin.murphy@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:from_mime,arm.com:dkim,arm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39085712111

On 2026-07-03 8:24 pm, Jason Gunthorpe wrote:
> On Fri, Jul 03, 2026 at 07:57:04PM +0100, Robin Murphy wrote:
>> On 03/07/2026 5:49 pm, Jason Gunthorpe wrote:
>>> On Wed, Jul 01, 2026 at 06:45:17PM +0100, Robin Murphy wrote:
>>>
>>>> @@ -211,6 +213,9 @@ bool arm_smmu_sva_supported(struct arm_smmu_device *smmu)
>>>>    	if (system_supports_bbml2_noabort())
>>>>    		feat_mask |= ARM_SMMU_FEAT_BBML2;
>>>> +	if (system_supports_haft())
>>>> +		feat_mask |= ARM_SMMU_FEAT_HAFT;
>>>
>>> I fear this is going to make SVA stop working on systems it currently
>>> does work on, so it might be a major regression.
>>>
>>> SMMU HTTU is not a commonly implemented feature.. I think of all the
>>> NVIDIA ARM chips only one supports it. Given that a quick internal
>>> check is raising concerns this will be breaking for us. We need to
>>> check in more detail which cores have HAFT.
>>>
>>> Breaking already deployed SVA would be a major functional regression.
>>>
>>> I think this should start by just enabling SMMU HAFT when CPU HAFT is
>>> on, when possible. Maybe print a warning on the mismatch instead of
>>> failing.
>>>
>>> Since we can't break already deployed SVA a full solution would either
>>> have to somehow turn off CPU HAFT or we ignore the gap in the AF
>>> updates..
>>
>> TBH I do not know how bad the implications of
>> pmd_young()/pmdp_test_and_clear_young() returning a false-negative are, but
>> if we aren't considering mismatched CPUs harmless then surely the same must
>> apply for SVA. In the POE/GCS cases all that can really be broken is users'
>> expectations, if they've opted in to additional security features, but also
>> opted in to SVA wherein those features can't protect against DMA. Here,
>> though, it's the kernel mm layer itself that's impacted, and I'm not
>> confident to say that that isn't more serious.
> 
> This has come up a few times now where the SMMU and CPU
> incompatibilities in ARM's IP are causing real headaches.
> 
> Let's give it some time and I can say for certain if we have impacted
> chips or not. I was able to confirm the server chips are OK, but there
> is still some concern about the embedded chips..
> 
> I also don't know how harmless it is to ignore the aging. I thought
> the PTE was designed to be backwards compatible, but I never looked at
> how AF works..

HA and HD are effectively just a performance feature, since the software 
fault handler only ends up setting the PTE bits such that the outcome is 
the same either way, it's just hideously inefficient to have to take the 
whole round-trip through the SMMU event queue. HAFT is different because 
it's already a strict superset of HA so there is no software-handlable 
fault; table AFs will *only* be set by agents with HAFT enabled, and 
thus a mismatch leads to actual loss of correctness if a HAFT-aware 
pmd_young() assumes that AF=0 in a table entry means there must be no 
leaf PTEs with AF=1 below it.
>> Making HAFT depend on !SVA could only easily be done at the config
>> level, which seems arguably even more over-reaching
> 
> Yeah, but if you could build a custom embedded kernel with HAFT
> disabled in kconfig maybe that is enough for some people.

Indeed if anyone does want to use SVA on such mismatched hardware and 
are happy to use a custom kernel with CONFIG_ARM64_HAFT disabled then 
they can and will continue to be able to do so. However I don't feel 
it's right to make general distros do that if they want to ship SVA 
support, as then it means future systems that don't use SVA, or do have 
system-wide HAFT, lose out on an additional performance feature 
unnecessarily (I guess if HiSilicon added it to their CPU they might 
have added it to their SMMU as well and just overlooked enabling it?)

Furthermore, as I alluded to, with the idreg-override stuff it should be 
easy enough to add the further option of suppressing HAFT from the 
command line if anyone wants that.

Thanks,
Robin

