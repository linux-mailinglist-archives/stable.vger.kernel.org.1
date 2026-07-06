Return-Path: <stable+bounces-272322-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BlC1MsceTGpLggEAu9opvQ
	(envelope-from <stable+bounces-272322-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 23:31:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD7715BB6
	for <lists+stable@lfdr.de>; Mon, 06 Jul 2026 23:31:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=ujXuQxMl;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272322-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272322-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8F293020A4A
	for <lists+stable@lfdr.de>; Mon,  6 Jul 2026 21:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8E147DD75;
	Mon,  6 Jul 2026 21:31:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FA318AE3
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 21:31:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783373486; cv=none; b=C1gpRtL8mcScoQ7PKf6BzvN2lgh5x9Qv198zDeRAAD2jeBtBaPKkQ69PAO/f5fPFeeHQ7SwJn4NcoSSglwRz6lPXPpURf43ugH4jYCOf6nyqZHnrWbyCv3PxVuwKba8DN++Fz4coOceIncx+naXWwsGdza6nTFL8fCTBHH5ceAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783373486; c=relaxed/simple;
	bh=KNBWdwrXuVuLe1pGgzoYnnrur2xfF1tee4C4t7SlKBI=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=ilH90pTkJWlwOnUxG1c5w5/jZOSBoBqGDu9FPxTCxvY/GQfZ7TsTQ1LyPworvfZCDrHjq6Y2jcm68ga+Dp+2I764IGV0KczJNrUkdglRyEI7sWAT4LUiWNqTDQOC4Nmf/g7s/gIcG5pHp9UORYCPcerqHIvjuTFvyKNaAS5Cs4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ujXuQxMl; arc=none smtp.client-ip=209.85.210.73
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7e9dc0f5900so38749a34.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 14:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783373484; x=1783978284; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wrEtuZnNKTHhXzzXH6FBZuUyiD4QdjI7aUV2ges9QRI=;
        b=ujXuQxMltjCwjeaRO5X/+cs9wjpq4TcLMkHSBFigL65F4d77USM6no6VrftLLdtPNB
         kTkMo59K++FToNKieSQzWhfuF19MM5hSATEqZvnNXSyMAHqDpBzQBL9+wjHo0hl385Se
         Wg2Z0uOXMLc0UaLb9d0Bz+4vOTNt7PC3iba/fbaBEFt5OVNvCIID+bMbZpwe94YGxg6R
         JqF+LV8ZGG5V1jC95fguLgdhV7xakvhbRqIzyeIm2xPM9OgMZ7zCnz6bSzLh6yqqYxOr
         Ibl+Ytmz5AYMSnuoWP9wPqweEpOlLsKIRL7p8jX2UrnR3MRSDpoHEPwntRVlXAG9Ekld
         90WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783373484; x=1783978284;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wrEtuZnNKTHhXzzXH6FBZuUyiD4QdjI7aUV2ges9QRI=;
        b=PZfDwgXid/GTDfQOndtJeCM42Q8KmXvvBruoivCxMGIInoaqEzoHh8R9WxXi8UvP6X
         /Gh2VigAN8U4sctMCHK9w/HjuzVhan18RvzxGK+AiZ4f9p8E+bV4mQGKSLoL7DabsJ0n
         ygxqvDkS4jcOX3BetDmUBee6ddqqzynwz1BzJCoijtRiFzxkgQDoCc3UUsDNhv86x2OT
         jJoOV0w1MzMSjvaEOlsR6gOkonto8Wb42QuqB6J07az22eKk0zvI9d1fo4oYxqED2uej
         VbpeHeHfjkiYJEXuF5gJKFonqZU6R6+v0DiYexZ3Nm6eNjmyzDAg2c+AkPuf9uQJ9t6u
         u5uw==
X-Gm-Message-State: AOJu0YyAuMPDLH3wNk+BKI4KC2MIDgLuuzqz8cKQd0ZaeTIfnHcyCyYU
	26fcdf1YTvtDeLURR9fUDt7e4js+ZfifeA2LcpSGi9DK+RQrJL5pbNXPb+eXKoXMCZuVoztlTbs
	X4kgpo4hVpYGCCDlA9ZdRn712ng==
X-Received: from ioel1.prod.google.com ([2002:a05:6602:2761:b0:9a7:ea8a:6db6])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:c92:b0:6a1:93a5:cd70 with SMTP id 006d021491bc7-6a35c45cbfbmr12190eaf.31.1783373483917;
 Mon, 06 Jul 2026 14:31:23 -0700 (PDT)
Date: Mon, 06 Jul 2026 21:31:22 +0000
In-Reply-To: <akWhad3U5VNjWzxu@kernel.org> (message from Oliver Upton on Wed,
 1 Jul 2026 16:23:21 -0700)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntqzlf6c0l.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 0/5] Backport ARM64 VHE boot fixes to 6.6.y
From: Colton Lewis <coltonlewis@google.com>
To: Oliver Upton <oupton@kernel.org>
Cc: stable@vger.kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	maz@kernel.org, oliver.upton@linux.dev, james.morse@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, mizhang@google.com, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:oupton@kernel.org,m:stable@vger.kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:maz@kernel.org,m:oliver.upton@linux.dev,m:james.morse@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:mizhang@google.com,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[coltonlewis@google.com,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-272322-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coltonlewis@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,coltonlewis-kvm.c.googlers.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 41DD7715BB6

Hi Oliver, thanks for reviewing.

Oliver Upton <oupton@kernel.org> writes:

> The subject prefix should be "[PATCH 6.6 0/5]" so people know right up
> front where this is going.

I'll make sure to include that in the subject.


> On Wed, Jul 01, 2026 at 08:43:37PM +0000, Colton Lewis wrote:
>> This series backports VHE CPU boot fixes to the 6.6.y stable branch.

>> These fixes are already present in the 6.12.y stable branch (and
>> newer), but are missing in 6.6.y. They are required to enable booting
>> L1 guests with nested virtualization enabled (kvm-arm.mode=nested).

> It's a bit worse than this. The architecture retroactively made
> FEAT_E2H0 an optional feature, there are now implementations in the wild
> that do not support the feature.

Good to know. I'll include that context in my next cover letter.

>> Without these patches, a 6.6.y guest boots with HCR_EL2.E2H
>> incorrectly configured (because it misses VHE-only detection or early
>> initialization), causing early boot hangs/trap loops.

>> Conflict resolutions:
>> - Patch 4 (KVM: arm64: Initialize HCR_EL2.E2H early) had conflicts in
>>    arch/arm64/kvm/hyp/nvhe/hyp-init.S due to differences in state
>>    initialization. Resolved by extracting EL2 state initialization into
>>    __kvm_init_el2_state.
>> - Patch 5 (arm64: Revamp HCR_EL2.E2H RES1 detection) had conflicts in
>>    arch/arm64/include/asm/el2_setup.h. Resolved by using raw msr hcr_el2
>>    instead of the missing msr_hcr_el2 macro.


>> Marc Zyngier (4):
>>    arm64: sysreg: Add layout for ID_AA64MMFR4_EL1
>>    arm64: Treat HCR_EL2.E2H as RES1 when ID_AA64MMFR4_EL1.E2H0 is
>>      negative
>>    arm64: Fix early handling of FEAT_E2H0 not being implemented
>>    arm64: Revamp HCR_EL2.E2H RES1 detection

>> Mark Rutland (1):
>>    KVM: arm64: Initialize HCR_EL2.E2H early

>>   arch/arm64/include/asm/el2_setup.h | 52 ++++++++++++++++++++++++++++++
>>   arch/arm64/kernel/head.S           | 17 +++-------
>>   arch/arm64/kvm/hyp/nvhe/hyp-init.S | 16 +++++++--
>>   arch/arm64/tools/sysreg            | 37 +++++++++++++++++++++
>>   4 files changed, 107 insertions(+), 15 deletions(-)


>> base-commit: d1cfde2d5d15be14123bdd1689162bd27f995a90
>> --
>> 2.55.0.rc2.803.g1fd1e6609c-goog


