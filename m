Return-Path: <stable+bounces-274184-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q8+hGb78VWrQxQAAu9opvQ
	(envelope-from <stable+bounces-274184-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 11:09:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50DD9752B0C
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 11:09:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=V34uMCAX;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274184-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274184-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 74D2A300861E
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 09:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DD643CEC3;
	Tue, 14 Jul 2026 09:09:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EACA43CECA
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 09:09:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020153; cv=none; b=fnsAgEMMHcqMr8ZWYpgSTgzZEzdMPVCgBWUSNxWCRXETYAKcNyOhv8jNvVXbrH50VApmxD4HbQKjcyLWIj0XScDGrFyaksTdPWqAB4eaCqY/TXWQGj5aqWoj91OxzyvHZReETxvKNCM1XYo5XPKZ2iwN5Kbe9nLD3ft/2wgjLyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020153; c=relaxed/simple;
	bh=ZvlQ1OcN/73ADfk9UgQRlKT2NlZTfJ21cSPlVtwgSoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kEiPMTuqNvz9rpAwEP2KI2x8KySLGZrqbHGrDfjfGPi/6lXPISNKc1TliflO62AfTUhIU/DVvZuAOKPW43sQXFB5ZKOcVvANlnXr6lkwQwjZNIZ4UWD8t6aeWFExKyn1wl8q7hO7S1Q2ZOFOo+ftQimEkdlE6HY6s96gzqaFzqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=V34uMCAX; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 272E12B;
	Tue, 14 Jul 2026 02:09:06 -0700 (PDT)
Received: from [10.1.34.162] (e121487-lin.cambridge.arm.com [10.1.34.162])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50EB23F93E;
	Tue, 14 Jul 2026 02:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784020149; bh=ZvlQ1OcN/73ADfk9UgQRlKT2NlZTfJ21cSPlVtwgSoM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=V34uMCAX6GLDE6QDDVGNjNtSJFA4PZmBPtw1V/yMOp2eNmIN7rtTusZWX8m4uJHMJ
	 C35UC/WkBozRqbJyk2fa+k5E3oNqatu8duMS1kzQoyTsSjKp2tIM2AIYqJV+xA/1P3
	 XEZd9wqXoIgg2jN/vvOWiekbYnox+SJw8mjbjQtg=
Message-ID: <bdb0ee39-7175-46fa-ac0d-8eff2ffbc616@arm.com>
Date: Tue, 14 Jul 2026 10:09:06 +0100
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
 <cd801ce1-7326-49c2-a6d2-218f9e3bd670@huawei.com>
Content-Language: en-GB
From: Vladimir Murzin <vladimir.murzin@arm.com>
In-Reply-To: <cd801ce1-7326-49c2-a6d2-218f9e3bd670@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[arm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274184-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 50DD9752B0C

On 7/9/26 14:19, Jinjie Ruan wrote:
> 
> On 7/9/2026 8:13 PM, Vladimir Murzin wrote:
>> From: Ada Couprie Diaz <ada.coupriediaz@arm.com>
>>
>> The arm64 hibernate code manages the exception masking in an unsound
>> way, leading to potential crashes and/or warnings during resume.
>>
>> When a hibernation image is saved in `swsusp_arch_suspend()`, all DAIF
>> exceptions are masked (by virtue of `local_daif_save()`), and the
>> suspended image is saved assuming that all DAIF exceptions will remain
>> masked when the image is restored.
>>
>> When a hibernation image is resumed by `swsusp_arch_resume()`, only
>> interrupts are masked (by virtue of `local_irq_save()` in
> local_irq_disable()?

Sorry, yes it should be local_irq_disable(). I'll fix that in next iteration.

Cheers
Vladimir

