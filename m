Return-Path: <stable+bounces-233539-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIDJAmjZ1GlxyAcAu9opvQ
	(envelope-from <stable+bounces-233539-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:16:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC843ACA35
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 12:16:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC56F308001A
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 10:13:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 849483A7F51;
	Tue,  7 Apr 2026 10:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BWNVh6AN"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 814233A6F0B;
	Tue,  7 Apr 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775556793; cv=none; b=imHBGgRd5OvJcD7Higb9ZyiFYG88cGIBBUwim0YVlYRZ9QkVO4avyNXyccKAuhJpNSXq58xm3cXB5L2IL6CnaS2lp0fMs+QzLDuldUdICT1HA6Bp3ij6tZjJJVbCqdj8bGiW8TTt8GbOqCyCWGd0KwbtjSnRPibq3+jMfy+ehuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775556793; c=relaxed/simple;
	bh=u6k7KReiIMT35ffIgZho6g6CodialPIJRfoN0WPK8T8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRU2Fl+kqHSEPKNICEaplD8HwL2SGR/9LtfrxwTGNvtqW4Se3/C42APaVIpMoBhfsz5QS48qC8CHnWNmfpDUOCvKSR57PDIGG+uTF95xM51n9EgfrwlmeTDYj/I4/qSYTXwkQtEs50Bh5Bu5ubXDHoT7OfqgecUt+rFZEPUoTu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BWNVh6AN; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D5061BB2;
	Tue,  7 Apr 2026 03:13:05 -0700 (PDT)
Received: from [10.57.87.42] (unknown [10.57.87.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B2DD3F641;
	Tue,  7 Apr 2026 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775556790; bh=u6k7KReiIMT35ffIgZho6g6CodialPIJRfoN0WPK8T8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BWNVh6ANFtw0ueWu9yyum/s4AQLzADYVEGNe1bxpMRtjve3MThvdmz4uAY0F2iy4R
	 4PJrXK6QtuNLXqjAhnWeXyLIfgZSsfwLCKBML6k8kvo+BXcXRP0C3FTBqeV+daqvc2
	 bQkJZMH+IaAC4mVQ55h9T0x8Df47exrCEMB2Hmc4=
Message-ID: <bc4a0246-33bb-443e-a885-a31b24d4a022@arm.com>
Date: Tue, 7 Apr 2026 11:13:07 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, "David Hildenbrand (Arm)"
 <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com> <ac7VD4Z85nS30GCp@arm.com>
 <ac-W9oNM_O5RTtaf@arm.com> <beacee23-c177-47a1-b8b5-743844b617a8@arm.com>
 <adTPFrlVCEt-hioX@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <adTPFrlVCEt-hioX@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233539-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: 8BC843ACA35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 07/04/2026 10:32, Catalin Marinas wrote:
> On Tue, Apr 07, 2026 at 09:43:42AM +0100, Ryan Roberts wrote:
>> On 03/04/2026 11:31, Catalin Marinas wrote:
>>> On Thu, Apr 02, 2026 at 09:43:59PM +0100, Catalin Marinas wrote:
>>>> Another thing I couldn't get my head around - IIUC is_realm_world()
>>>> won't return true for map_mem() yet (if in a realm). Can we have realms
>>>> on hardware that does not support BBML2_NOABORT? We may not have
>>>> configuration with rodata_full set (it should be complementary to realm
>>>> support).
>>>
>>> With rodata_full==false, can_set_direct_map() returns false initially
>>> but after arm64_rsi_init() it starts returning true if is_realm_world().
>>> The side-effect is that map_mem() goes for block mappings and
>>> linear_map_requires_bbml2 set to false. Later on,
>>> linear_map_maybe_split_to_ptes() will skip the splitting.
>>>
>>> Unless I'm missing something, is_realm_world() calls in
>>> force_pte_mapping() and can_set_direct_map() are useless. I'd remove
>>> them and either require BBML2_NOABORT with CCA or get the user to force
>>> rodata_full when running in realms. Or move arm64_rsi_init() even
>>> earlier?
>>
>> I'd need Suzuki to comment on this. As I said in the other mail, I was treating
>> this like a pre-existing bug. But I guess linear_map_requires_bbml2 ending up
>> wrong is a problem here. I'm not sure it's quite as simple as requiring
>> BBML2_NOABORT with CCA as we still need can_set_direct_map() to return true if
>> we are in a realm.
> 
> can_set_direct_map() == true is not a property of the realm but rather a
> requirement. 

Yes indeed. It would be better to call it might_set_direct_map() or something
like that...

> In the absence of BBML2_NOABORT, I guess the test was added
> under the assumption that force_pte_mapping() also returns true if
> is_realm_world(). We might as well add a variable or static label to
> track whether can_set_direct_map() is possible and avoid tests that
> duplicate force_pte_mapping().

I'm not sure I follow. We have linear_map_requires_bbml2 which is inteded to
track this shape of thing; if we have forced pte mapping then the value of
can_set_direct_map() is irrelevant - we will never need to split because we are
already pte-mapped. But if can_set_direct_map() initially returns false because
is_realm_world() incorrectly returns false in the early boot environment, then
linear_map_requires_bbml2 will be set to false, and we will incorrectly
short-circuit splitting any block mappings in split_kernel_leaf_mapping().

I think we are agreed on the problem. But I don't understand how tracking
can_set_direct_map() in a cached variable helps with that.

> 
> This won't solve the is_realm_world() changing polarity during boot but
> at least we know it won't suddenly make can_set_direct_map() return
> true when it shouldn't.

But is_real_world() _should_ make can_set_direct_map() return true, shouldn't
it? If we are in realm-world, we need to be able to flip the NS_SHARED bit on
parts of the linear map. So if we are in realm-world, we _might_ need to update
he direct map and that's what can_set_direct_map() is supposed to tell us.



