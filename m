Return-Path: <stable+bounces-230007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFw4BuqawWlNUAQAu9opvQ
	(envelope-from <stable+bounces-230007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:56:26 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF142FCB25
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 20:56:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0F2BF300B47A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 19:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8443DEFF8;
	Mon, 23 Mar 2026 19:56:23 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2403DD534;
	Mon, 23 Mar 2026 19:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774295783; cv=none; b=JpqXZ4ro/nyqWGmZCiZ4XSDeEKZDtrGS5pyh7yYliXkPFzZ3CXaSawy5m01orMNu90NnGTh292UV5SK1p1x4F+i4ndihHPqBQNEIjTqqxcySf65NhDxt56EqN85wRI7VzHeU+QDpZI4Kazwg3BpAk7Pq7EQMvH08JOTC8shz+8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774295783; c=relaxed/simple;
	bh=ZybiVf9Ui2KshcMzVZ5jtaXR9MAGtDDwOwCMSn4/ewA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZchCEA9Me5jmyq3GjoMqTGIVp1M7coUN3YulGht9aS5kCJdP1i1NBFqDeyzly9qM9W7tKO5Ioi4QCQuawM7CemRJpUZyO7qc6FtMOMo/czlk2jsVR0pnPK4h4pw8jMrfsACBIz9bMhDbvQ05SElBxtNIUol49ZjWR2EXNhBL2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4238414BF;
	Mon, 23 Mar 2026 12:56:14 -0700 (PDT)
Received: from [10.57.59.110] (unknown [10.57.59.110])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 63E533F694;
	Mon, 23 Mar 2026 12:56:14 -0700 (PDT)
Message-ID: <1d364f19-7cf4-400b-ad12-6380152e44e5@arm.com>
Date: Mon, 23 Mar 2026 19:56:10 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] arm64: mm: Handle invalid large leaf mappings
 correctly
To: Ryan Roberts <ryan.roberts@arm.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260323130317.1737522-1-ryan.roberts@arm.com>
 <20260323130317.1737522-3-ryan.roberts@arm.com>
 <588b2b4f-9cf6-43e5-b0e5-55820c74cbbb@arm.com>
 <e36d3b17-dc66-466e-9446-692592e5d7f2@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <e36d3b17-dc66-466e-9446-692592e5d7f2@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[arm.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230007-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.brodsky@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,arm.com:mid]
X-Rspamd-Queue-Id: 9FF142FCB25
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 23/03/2026 18:25, Ryan Roberts wrote:
>>> @@ -132,11 +137,12 @@ static int __change_memory_common(unsigned long start, unsigned long size,
>>>  	ret = update_range_prot(start, size, set_mask, clear_mask);
>>>  
>>>  	/*
>>> -	 * If the memory is being made valid without changing any other bits
>>> -	 * then a TLBI isn't required as a non-valid entry cannot be cached in
>>> -	 * the TLB.
>>> +	 * If the memory is being switched from present-invalid to valid without
>>> +	 * changing any other bits then a TLBI isn't required as a non-valid
>>> +	 * entry cannot be cached in the TLB.
>>>  	 */
>>> -	if (pgprot_val(set_mask) != PTE_VALID || pgprot_val(clear_mask))
>>> +	if (pgprot_val(set_mask) != (PTE_MAYBE_NG | PTE_VALID) ||
>> It isn't obvious to understand where all those PTE_MAYBE_NG come from if
>> one hasn't realised that PTE_PRESENT_INVALID overlays PTE_NG.
>>
>> Since for this purpose we always set/clear both PTE_VALID and
>> PTE_MAYBE_NG, maybe we could define some macro as PTE_VALID |
>> PTE_MAYBE_NG, as a counterpart to PTE_PRESENT_INVALID?
> How about:
>
> #define PTE_PRESENT_VALID_KERNEL	(PTE_VALID | PTE_MAYBE_NG)
>
> The user space equivalent has NG clear, so important to clarify that this is the
> kernel value, I think.

Sounds good to me.

- Kevin

