Return-Path: <stable+bounces-274192-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7NNNMacEVmo8yAAAu9opvQ
	(envelope-from <stable+bounces-274192-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 11:43:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B9D752FE6
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 11:43:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=Wpvkvb3S;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274192-lists+stable=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="stable+bounces-274192-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DE601301FFEF
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 09:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED51543DA27;
	Tue, 14 Jul 2026 09:43:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080D143FD07
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:42:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784022179; cv=none; b=g3K5pRO+4OEcgICPA+zSjwy09qbTce9IHfF52gdwH+wRsmR7DDpIN3D5DZ3ME51by78/htuAn9EUNo1wB3i1WWD+AwgiwVo11J1EYNA+TJCV4cBF/kRfDrHejjO6kgPNbdm1qRpZaO5gFRv69r0W6PordfsXMT5RHAkyKopoGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784022179; c=relaxed/simple;
	bh=ylNE0p+vP/URJswGo08Ck/ZPP2GHVw7Gj8Qa8p1x8pk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s+IYtl5J8787y3iRSffYBYRd+0Z1hkaXoJjCpy21Ij04ZeVcvFhDtpqk7HgJV8MqWWbUBJY9fUI4MvOH2gnPSjDJWPOgfwRUmFlGyd5Z0F9rT3TWtdL2q/F2fGl2nExHyrdNwGneGIoca4hv2Nde8Tcr7hKr0ve2LEi8J2Gq66E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Wpvkvb3S; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2749339;
	Tue, 14 Jul 2026 02:42:43 -0700 (PDT)
Received: from [10.1.34.162] (e121487-lin.cambridge.arm.com [10.1.34.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 489693F93E;
	Tue, 14 Jul 2026 02:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784022167; bh=ylNE0p+vP/URJswGo08Ck/ZPP2GHVw7Gj8Qa8p1x8pk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Wpvkvb3SGvbX1ibnsaSCP2lIzKIqPceDRe6TEiCPFNVo6iY0liDOpW8wHzStJuURI
	 gkc88zuxPiq3Ka3Dm3q1tLwAFrq8Jo5g0r9a5Fc32QwiHl5xio64gwC3UITmGmZQsx
	 paCUTW1F8wot8TMMPcv9BdfgK+3giHkAIVtUzB6Y=
Message-ID: <facc6c75-758d-4790-8c1f-338b9a1c0a11@arm.com>
Date: Tue, 14 Jul 2026 10:42:44 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 03/36] arm64: hibernate: mask DAIF before restoring
 hibernated kernel
To: "Liao, Chang" <liaochang1@huawei.com>,
 linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, maz@kernel.org, ruanjinjie@huawei.com,
 stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org
References: <20260709121333.23507-1-vladimir.murzin@arm.com>
 <20260709121333.23507-4-vladimir.murzin@arm.com>
 <2410686c-bc58-44a0-9f71-ec79791daaa6@huawei.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <2410686c-bc58-44a0-9f71-ec79791daaa6@huawei.com>
Content-Type: text/plain; charset=UTF-8
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
	TAGGED_FROM(0.00)[bounces-274192-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[vladimir.murzin@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:liaochang1@huawei.com,m:linux-arm-kernel@lists.infradead.org,m:mark.rutland@arm.com,m:maz@kernel.org,m:ruanjinjie@huawei.com,m:stable@vger.kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vladimir.murzin@arm.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:from_mime,arm.com:dkim,arm.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 73B9D752FE6

On 7/10/26 04:40, Liao, Chang wrote:
>> @@ -465,9 +466,21 @@ int __nocfi swsusp_arch_resume(void)
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
>> +	local_daif_restore(flags);
> As Jinjie said, the resumed kernel never return from hibernate_exit(). If that's
> the case, it seems better to place unreachable() rather than local_daif_restore(),
> would you agree?

Cannot disagree :) I'll fix that in the next iteration.

Cheers
Vladimir

