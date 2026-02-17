Return-Path: <stable+bounces-216843-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOY5Aqd+lGmnFAIAu9opvQ
	(envelope-from <stable+bounces-216843-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:43:51 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 204FB14D3ED
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DE2FA300681F
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9263C36B063;
	Tue, 17 Feb 2026 14:43:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C710C36C599;
	Tue, 17 Feb 2026 14:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771339417; cv=none; b=oOzv66lM4ya3h2IiljxgrrDXPsCB2+pMbtIEeJA+xniff1kUSVvUL5Ij57Bwnyno3booEhBJod5wX3IIGgwVCdkvWCTAPO5VI070FCsZ8N7zLe5OuBRuBFYHw7qkGenpMyenepwdelY4kRw7DTOyjxcwLwgqcm/nV0f0KEdz+A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771339417; c=relaxed/simple;
	bh=o002gwLxpjE0faJ0YPgVrlNVLmOsAQCdTKOXcK4c3sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qzVpjvmNTGtjtFIihHxgsFW0tNRPKDI+IQ6WnKO585R+CXbFoH/ha9Yi31j+Fjzlu3uqXaISiLlNRe6HikVKEmCO0SDCQHoE+ZlLU1KWPt0zZ4ZG+Eit7QSHT4vQMuVD4XFUUaig79rjs9NXKhZqC0YvBcB2rZ34qajKgIufP9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC7261477;
	Tue, 17 Feb 2026 06:43:28 -0800 (PST)
Received: from [10.1.30.186] (XHFQ2J9959.cambridge.arm.com [10.1.30.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 841BF3F62B;
	Tue, 17 Feb 2026 06:43:33 -0800 (PST)
Message-ID: <20e320d2-749a-4379-a236-5dbe3d52b07f@arm.com>
Date: Tue, 17 Feb 2026 14:43:31 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.6 0/3] arm64: Speed up boot with faster linear map
 creation
Content-Language: en-GB
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jack Aboutboul <jaboutboul@microsoft.com>,
 Sharath George John <sgeorgejohn@microsoft.com>,
 Noah Meyerhans <nmeyerhans@microsoft.com>,
 Jim Perrin <Jim.Perrin@microsoft.com>
References: <20260217133411.2881311-1-ryan.roberts@arm.com>
 <2026021700-chafe-jurist-cb24@gregkh>
 <17c9efaf-6c33-4485-bde2-345cc15ac000@arm.com>
 <2026021718-citrus-parakeet-dc60@gregkh>
 <7f30a8e4-49c3-421d-be05-08afb544aa41@arm.com>
 <2026021758-subsidy-tinfoil-ee2c@gregkh>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2026021758-subsidy-tinfoil-ee2c@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-216843-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 204FB14D3ED
X-Rspamd-Action: no action

On 17/02/2026 14:26, Greg KH wrote:
> On Tue, Feb 17, 2026 at 02:21:30PM +0000, Ryan Roberts wrote:
>> On 17/02/2026 14:10, Greg KH wrote:
>>> On Tue, Feb 17, 2026 at 01:58:36PM +0000, Ryan Roberts wrote:
>>>> On 17/02/2026 13:50, Greg KH wrote:
>>>>> On Tue, Feb 17, 2026 at 01:34:05PM +0000, Ryan Roberts wrote:
>>>>>> Hi All,
>>>>>>
>>>>>> This series is a backport that applies to stable kernel 6.6 (base v6.6.126), for
>>>>>> some speed ups to enable significantly faster booting on systems with a lot of
>>>>>> memory. The patches were originally posted at:
>>>>>>
>>>>>>   https://lore.kernel.org/linux-arm-kernel/20240412131908.433043-1-ryan.roberts@arm.com/
>>>>>>
>>>>>> ... and were originally merged upstream in v6.10-rc1.
>>>>>>
>>>>>> I'm requesting this be merged to stable on behalf of a partner who wants to get
>>>>>> the benefit of this series in Debian 12.
>>>>>
>>>>> Why can't they just use a newer kernel version (i.e. 6.12)?  Surely they
>>>>> would be able to justify moving to a newer kernel for performance
>>>>> reasons, why enable them to stay on an older one, just delaying the
>>>>> inevitable upgrade they will have to do anyway in a year or so?
>>>>
>>>> I can't answer this presicely, but I did ask and push for that approach. As I
>>>> understand it, they are stuck with Debian 12, which is stuck with kernel 6.1.
>>>> The Debian maintainer apparently requested that these go through stable in order
>>>> to get them into Debian 12.
>>>
>>> I understand the position of Debian not wanting to take patches for new
>>> features that are not already upstream, but really, Debian offers a
>>> newer kernel for hardware that wants to use it for things like this,
>>> right?  Why not just use that instead?
>>
>> Let me go push a bit harder. But I expect we are in the grey zone between bug
>> and feature here; this is a performance bug fix, not a new feature. By
>> selectively backporting I'm guessing they are avoiding the risk of new features
>> that a new kernel brings introducing new bugs? I'm guessing there is a higher
>> qualification bar for that.
> 
> That's a broken "qualification system" if that is the case, given that
> the patches that flow back into stable kernel releases should be
> triggering "full qualification" if anyone actually paid attention to
> what goes into there :)
> 
> Anyway, good luck!  And same for 6.1.y, if they are ok with 6.6.y, why
> would they even care about 6.1.y?

The request was only for 6.1. I did 6.6 as well for continuity; I didn't want it
to get slow again if they moved from 6.1 to 6.6. It's already fixed in 6.12.


> 
> thanks,
> 
> greg k-h


