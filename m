Return-Path: <stable+bounces-274187-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ayoDMsYEVmplyAAAu9opvQ
	(envelope-from <stable+bounces-274187-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 11:43:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EB4753008
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 11:43:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=jbdJEVsw;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274187-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274187-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B5B03043FC8
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 09:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1106D3F4128;
	Tue, 14 Jul 2026 09:35:08 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C3A3EE1F2
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:35:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784021707; cv=none; b=szGA5b54fQyQUv9cPvWpJAg72UAF2WP8OBIxDrWUsSsjSD6yWYgIB/9IFhOjfHALx/BOP0els32cO9f8ugQEbJRCuclObXgfsPvda2KOiinfk7UJQaocFPO74m3lNQ+Dkxz9BCHT5a4G+NxbFGJrs6ueACxhu2+PJ8aGTKDlX3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784021707; c=relaxed/simple;
	bh=XM92JNOSdj3ojRIKBMMYaaElVGPDddS9HZgAe+hXh1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W3PS51kpCNfLPjw3hi/bAhRxqXzWLrSkSlwjqkNzVVqM8WGlrptZFltw5BeXPdXEEMQjDf9mhNxCMQkc3Pw2CkfltqDYIjg54ta50YeMeVlsOY7B5l50WkwlYnTAMmvNcPDxq14Qys+vcAaOiF2SaA26Z4NTA2L5jnXL8fyDuhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jbdJEVsw; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 636A32F;
	Tue, 14 Jul 2026 02:35:01 -0700 (PDT)
Received: from [10.1.34.162] (e121487-lin.cambridge.arm.com [10.1.34.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4913D3F93E;
	Tue, 14 Jul 2026 02:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784021705; bh=XM92JNOSdj3ojRIKBMMYaaElVGPDddS9HZgAe+hXh1Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jbdJEVswRCgfjDqjKMQ1tBdBT4UJGWKOK2gb5TGJuXBdmxH+vQqs4p9eU1jMpIvp/
	 uyETnuUvAq37LE0JEh0f2TruzitCqNNHjvQ76zflxgRBInYYODrMV9otjKMFxe7LZb
	 WcVDVfpUhwqP+Q7qaUTpVaGTKx2SjzVLYdcBeIOY=
Message-ID: <8ffe2df2-90c2-45a1-ace2-185ef1f4e011@arm.com>
Date: Tue, 14 Jul 2026 10:35:02 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/36] arm64: hibernate: mask DAIF before restoring
 hibernated kernel
To: Jinjie Ruan <ruanjinjie@huawei.com>, linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, maz@kernel.org, will@kernel.org,
 catalin.marinas@arm.com, Ada Couprie Diaz <ada.coupriediaz@arm.com>,
 stable@vger.kernel.org
References: <20260709121333.23507-1-vladimir.murzin@arm.com>
 <20260709121333.23507-4-vladimir.murzin@arm.com>
 <68e740e3-5fa6-4ab7-92f1-3f570fc07801@huawei.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <68e740e3-5fa6-4ab7-92f1-3f570fc07801@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274187-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vladimir.murzin@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ruanjinjie@huawei.com,m:linux-arm-kernel@lists.infradead.org,m:mark.rutland@arm.com,m:maz@kernel.org,m:will@kernel.org,m:catalin.marinas@arm.com,m:ada.coupriediaz@arm.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.murzin@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:from_mime,arm.com:dkim,arm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D5EB4753008

On 7/10/26 04:00, Jinjie Ruan wrote:
>> @ -465,9 +466,21 @@ int __nocfi swsusp_arch_resume(void)
>>  	if (el2_reset_needed())
>>  		__hyp_set_vectors(el2_vectors);
>>  
>> +	/*
>> +	 * It is necessary to mask all DAIF exceptions here as:
>> +	 *
>> +	 * - The copy of swsusp_arch_suspend_exit() in the hibernation
>> +	 *   text cannot handle taking any exceptions.
>> +	 *
>> +	 * - The suspended kernel masked all DAIF exceptions in
>> +	 *   swsusp_arch_resume(), and expects to be re-entered in the
>> +	 *   same state : with all DAIF exceptions masked.
>> +	 */
>> +	flags = local_daif_save();
>>  	hibernate_exit(virt_to_phys(tmp_pg_dir), resume_hdr.ttbr1_el1,
>>  		       resume_hdr.reenter_kernel, restore_pblist,
>>  		       resume_hdr.__hyp_stub_vectors, virt_to_phys(zero_page));
> hibernate_exit() is a noreturn function, the following
> local_daif_restore() will not be called.

Agree. I'll fix that in the next iteration.

Cheers
Vladimir


