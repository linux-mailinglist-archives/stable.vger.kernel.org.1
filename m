Return-Path: <stable+bounces-236119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +HVsIHYE3Wn/YwkAu9opvQ
	(envelope-from <stable+bounces-236119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:57:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 048383ED9AF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FB68300BBB9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8243B95FA;
	Mon, 13 Apr 2026 14:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="l6VNZfs0"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E7D73B777D;
	Mon, 13 Apr 2026 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776092273; cv=none; b=KtseEm7+jurK2tp1xWQ3HrWRcvodo2rg9haXHDmuQh3sIfUCJMe42JyjsrUrub7Fknc1X28IprqANnDQ0KLX0+TAASqd4LqsDjiS0WP3nKxfQhySBxn8U24NRjsocMJIYRb4ll6jhezX8+2+i95HA7FCLycuGOQ+ogRzAL4HbR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776092273; c=relaxed/simple;
	bh=6JhUja+jY7Hvs14nTFQKfonq29ce0Ud13IFze0Y80M0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WqLq9cfnqjEcjxMI21wyvS2mgfV1Ip26c5fNLvbhwiPWa9GTHK5uYezdAOsamQBGG+VcRUnHCM/9D6hL8+94uZR9ZBZKpTviq55Mtw7xbW+BRQZLOaomVdtED5a2wLvdqQxVIgnXe1sRFUR7r2AKA7OmQhHu5ruXRXntXnERU1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=l6VNZfs0; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 32BCE32F9;
	Mon, 13 Apr 2026 07:57:46 -0700 (PDT)
Received: from [10.57.62.88] (unknown [10.57.62.88])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CBBE43F641;
	Mon, 13 Apr 2026 07:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776092271; bh=6JhUja+jY7Hvs14nTFQKfonq29ce0Ud13IFze0Y80M0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=l6VNZfs0a1qju11zbgRgB8TIewKUGm0YuGrXo3YGW2Ykr8aKPTMCRtDpT1c7RmAOM
	 Mgj1mtBgLT0dI5YSEbwsqSHB6nV90OLLCu7JIsmSNkSV8m75E7uj7mLaQvzeLRo8LP
	 lH10czl6YjEmHqbLwsdGW9RTPIeo8XaYIJb232SE=
Message-ID: <315131b7-237b-4705-ba84-e03a484128da@arm.com>
Date: Mon, 13 Apr 2026 16:57:43 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
To: Yang Shi <yang@os.amperecomputing.com>,
 Catalin Marinas <catalin.marinas@arm.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>, Will Deacon <will@kernel.org>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Kalyazin, Nikita" <kalyazin@amazon.co.uk>
References: <20260330161705.3349825-2-ryan.roberts@arm.com>
 <ac7VD4Z85nS30GCp@arm.com> <ac-W9oNM_O5RTtaf@arm.com>
 <beacee23-c177-47a1-b8b5-743844b617a8@arm.com> <adTPFrlVCEt-hioX@arm.com>
 <bc4a0246-33bb-443e-a885-a31b24d4a022@arm.com> <adTh8d9k3y5ybemL@arm.com>
 <567dff89-9f0f-40a0-ab10-22e061b4faaf@arm.com> <adfDoatH8hj6zN7_@arm.com>
 <07054475-6b07-4b19-a393-cbe037adef8b@os.amperecomputing.com>
 <adfw_hNDsIWwSAIv@arm.com>
 <e4682b9a-9c18-44c5-a892-b12ce4745474@os.amperecomputing.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <e4682b9a-9c18-44c5-a892-b12ce4745474@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-236119-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kevin.brodsky@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:dkim,arm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 048383ED9AF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 10/04/2026 01:08, Yang Shi wrote:
> On 4/9/26 11:33 AM, Catalin Marinas wrote:
>> On Thu, Apr 09, 2026 at 09:48:58AM -0700, Yang Shi wrote:
>>> On 4/9/26 8:20 AM, Catalin Marinas wrote:
>>>> On Thu, Apr 09, 2026 at 11:53:41AM +0200, Kevin Brodsky wrote:
>>>>> What would make more sense to me is to enable the use of
>>>>> BBML2-noabort
>>>>> unconditionally if !force_pte_mapping(). We can then have
>>>>> can_set_direct_map() return true if we have BBML2-noabort, and we no
>>>>> longer need to check it in map_mem().
>>>> Indeed.
>>> I'm trying to wrap up my head for this discussion. IIUC, if none of the
>>> features is enabled, it means we don't need do anything because the
>>> direct
>>> map is not changed. For example, if vmalloc doesn't change direct map
>>> permission when rodata != full, there is no need to call
>>> set_direct_map_*_noflush(). So unconditionally checking
>>> BBML2_NOABORT will
>>> change the behavior unnecessarily. Did I miss something?
>>>
>>> I think the only exception is secretmem if I don't miss something.
>>> Currently, secretmem is actually not supported if none of the
>>> features is
>>> enabled. But BBML2_NOABORT allows to lift the restriction.
>> Yes, it's secretmem only AFAICT. I think execmem will only change the
>> linear map if rodata_full anyway.
>
> Yes, execmem calls set_memory_rox(), which won't change linear map
> permission if rodata_full is not enabled.

That is a good point, AFAICT set_direct_map_*_noflush() are only used by
execmem and secretmem. excmem only modifies the direct map if
rodata=full, so the proposed change would only be useful for secretmem.

The current situation with execmem is pretty strange: if rodata!=full,
but another feature is enabled (say kfence), then set_memory_rox() won't
touch the direct map but we will still use set_direct_map_*_noflush() to
reset it (directly or via VM_FLUSH_RESET_PERMS). Checking BBML2-noabort
in can_set_direct_map() would make these unnecessary calls more likely,
but it doesn't fundamentally change the situation.

It's also worth considering the series unmapping parts of the direct map
for guest_memfd [1], since it gates the use of
set_direct_map_*_noflush() on can_set_direct_map().

I think it makes complete sense to enable secretmem and the guest_memfd
use-case if BBML2-noabort is available, regardless of the other
features. The question is: are we worried about the overhead of
needlessly calling set_direct_map_*_noflush() for execmem mappings? If
so, it seems that the right solution is to introduce a new API to check
whether set_memory_ro() and friends actually modify the direct map or not.

- Kevin

[1] https://lore.kernel.org/lkml/20260317141031.514-1-kalyazin@amazon.com/

