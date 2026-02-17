Return-Path: <stable+bounces-216834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOYpFzN0lGlMEAIAu9opvQ
	(envelope-from <stable+bounces-216834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:59:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B97E114CE08
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 14:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C769303FF3A
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 13:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228D936BCC8;
	Tue, 17 Feb 2026 13:58:42 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC245339868;
	Tue, 17 Feb 2026 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771336721; cv=none; b=V++ot6gPNg53IyZex0LccMbOtx2J9UXw32m7aCpWnkMTyZ5/zBJEsMY4yhKwApYp28Uq+Buok22DjE3Klqo6VrCK4IWYnHlTZum9cnRq9wN73Wx7+uzdyBvPMTcD7Y5jmuZ34qEPgXlF5nQjOyVtgdRz7+iROijJ+EVYJjYU2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771336721; c=relaxed/simple;
	bh=Oy9HSuzXN4AIsY7ks5K+SiarS60oNpRLrBSoD9RybvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f47GFoWkL1NejdRHofOb3ai0eb34Jm7P/MJb+eHri40DiZ4V5UmV4TfY6IqDSYppTZOAgnXS3I62VEQT2yaPXYZHFR/T/aldSpMqNcM7MdWF0x1yixULyT8iJZmGrmj2YekuJH+hvKlBy2RnhAH9VJN/4uNlGD0NWBe2jbJV0zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E9F501477;
	Tue, 17 Feb 2026 05:58:33 -0800 (PST)
Received: from [10.1.30.186] (XHFQ2J9959.cambridge.arm.com [10.1.30.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92D203F632;
	Tue, 17 Feb 2026 05:58:38 -0800 (PST)
Message-ID: <17c9efaf-6c33-4485-bde2-345cc15ac000@arm.com>
Date: Tue, 17 Feb 2026 13:58:36 +0000
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
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <2026021700-chafe-jurist-cb24@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-216834-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: B97E114CE08
X-Rspamd-Action: no action

On 17/02/2026 13:50, Greg KH wrote:
> On Tue, Feb 17, 2026 at 01:34:05PM +0000, Ryan Roberts wrote:
>> Hi All,
>>
>> This series is a backport that applies to stable kernel 6.6 (base v6.6.126), for
>> some speed ups to enable significantly faster booting on systems with a lot of
>> memory. The patches were originally posted at:
>>
>>   https://lore.kernel.org/linux-arm-kernel/20240412131908.433043-1-ryan.roberts@arm.com/
>>
>> ... and were originally merged upstream in v6.10-rc1.
>>
>> I'm requesting this be merged to stable on behalf of a partner who wants to get
>> the benefit of this series in Debian 12.
> 
> Why can't they just use a newer kernel version (i.e. 6.12)?  Surely they
> would be able to justify moving to a newer kernel for performance
> reasons, why enable them to stay on an older one, just delaying the
> inevitable upgrade they will have to do anyway in a year or so?

I can't answer this presicely, but I did ask and push for that approach. As I
understand it, they are stuck with Debian 12, which is stuck with kernel 6.1.
The Debian maintainer apparently requested that these go through stable in order
to get them into Debian 12.

Thanks,
Ryan

> 
> thanks,
> 
> greg k-h


