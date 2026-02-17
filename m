Return-Path: <stable+bounces-216837-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAC9EXR5lGkfFAIAu9opvQ
	(envelope-from <stable+bounces-216837-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:21:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B16F214D168
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 15:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 097443018D47
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0CE36B066;
	Tue, 17 Feb 2026 14:21:35 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB52212FB9;
	Tue, 17 Feb 2026 14:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338095; cv=none; b=ltMGcGXj1oYKqeMvz1/XmlyQDei3Jvmnhn7KDSqReUitVpj7NyOrsENiEa4XlyC95sHmxJ7Go4hdZZyWzwKSAmqajsNceSBcpDxe/7KicRQujBheDbvxGUswrGAzDx/TT0TkeeLXGEXsQduPxrUOhMwkZKLZqIH/iaiXkkK+D+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338095; c=relaxed/simple;
	bh=pt/TzqqGohw4OTemqHCSOxMjFe3/HcKUKdOSNOwv/Ng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y+NBgxvsQMA41joHELIMotsF7ooW3oc0BK3pzYHVG9coR5RrrNiwRzDseESMhBaq0P9H2Wt1q4punrW3A3fjIHww2RklYfzL8A8ge6XHyM06qW3/9VCiY1wvj2VWcw/RK6DUZUvEdSrIiWRp0tydpJzqAbajCGsgCojDk/u4l6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 523541477;
	Tue, 17 Feb 2026 06:21:27 -0800 (PST)
Received: from [10.1.30.186] (XHFQ2J9959.cambridge.arm.com [10.1.30.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EEFCD3F62B;
	Tue, 17 Feb 2026 06:21:31 -0800 (PST)
Message-ID: <7f30a8e4-49c3-421d-be05-08afb544aa41@arm.com>
Date: Tue, 17 Feb 2026 14:21:30 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2026021718-citrus-parakeet-dc60@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216837-lists,stable=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:mid]
X-Rspamd-Queue-Id: B16F214D168
X-Rspamd-Action: no action

On 17/02/2026 14:10, Greg KH wrote:
> On Tue, Feb 17, 2026 at 01:58:36PM +0000, Ryan Roberts wrote:
>> On 17/02/2026 13:50, Greg KH wrote:
>>> On Tue, Feb 17, 2026 at 01:34:05PM +0000, Ryan Roberts wrote:
>>>> Hi All,
>>>>
>>>> This series is a backport that applies to stable kernel 6.6 (base v6.6.126), for
>>>> some speed ups to enable significantly faster booting on systems with a lot of
>>>> memory. The patches were originally posted at:
>>>>
>>>>   https://lore.kernel.org/linux-arm-kernel/20240412131908.433043-1-ryan.roberts@arm.com/
>>>>
>>>> ... and were originally merged upstream in v6.10-rc1.
>>>>
>>>> I'm requesting this be merged to stable on behalf of a partner who wants to get
>>>> the benefit of this series in Debian 12.
>>>
>>> Why can't they just use a newer kernel version (i.e. 6.12)?  Surely they
>>> would be able to justify moving to a newer kernel for performance
>>> reasons, why enable them to stay on an older one, just delaying the
>>> inevitable upgrade they will have to do anyway in a year or so?
>>
>> I can't answer this presicely, but I did ask and push for that approach. As I
>> understand it, they are stuck with Debian 12, which is stuck with kernel 6.1.
>> The Debian maintainer apparently requested that these go through stable in order
>> to get them into Debian 12.
> 
> I understand the position of Debian not wanting to take patches for new
> features that are not already upstream, but really, Debian offers a
> newer kernel for hardware that wants to use it for things like this,
> right?  Why not just use that instead?

Let me go push a bit harder. But I expect we are in the grey zone between bug
and feature here; this is a performance bug fix, not a new feature. By
selectively backporting I'm guessing they are avoiding the risk of new features
that a new kernel brings introducing new bugs? I'm guessing there is a higher
qualification bar for that.

> 
> thanks,
> 
> greg k-h


