Return-Path: <stable+bounces-273043-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ol75AiUFUGrLrwIAu9opvQ
	(envelope-from <stable+bounces-273043-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 22:31:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56EE07355A4
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 22:31:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=JpSoI2Of;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273043-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273043-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3836E305EA57
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 20:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFCF3C5823;
	Thu,  9 Jul 2026 20:30:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CCFB3C09FF
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 20:30:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629013; cv=none; b=T1wcd52clKhBKP5zabQiOOOmnLcoB6ze+zJKBJqruAulYXwPyCJsGZw3vQkgY44SfFVFhY0lgLhUxIK0NLdB7ip9OpXnmgPOxTk8QLlEIgQj0Tybgnlg8buj8LsmK7ut6OKIloXNTE+0gUwlFsxF1LDPYHBCq0j47M/T/zLbul4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629013; c=relaxed/simple;
	bh=Hh90mVt6XcR3iqrqcDw0knKu1XwU2GWLwg4NQnXR5F0=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=lLEUuUGptIjLvmdQ7qtiKxlprhAsIH6C85VME4A14dCcgtDPpvY5s47dY6ElZQGjX78vdjMOc6hdsAR/Z5grtAek67jUBZxPzQZSJu4s5xc90zftWAsLzsGUJEUrm9wa8ddW2cSK5QOEUXPRjF0G/tA7otRl68t0a9AyYlGgh0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpSoI2Of; arc=none smtp.client-ip=209.85.167.202
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-4909b046dabso270577b6e.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 13:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783629008; x=1784233808; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PzslN++gvwF111Oxj75aJ3QDVnvg6D0q7xeFijnE/DM=;
        b=JpSoI2Of0uH/DQ2oFiL8Rc8Sk/60qO9R/psr4pVf0SqiO9y5CRJvh25xNwnieAftbi
         9CRNo5zfXvOzImFTVimsNDEnzMV2hrQL3Rrug5NtL88NKJU1WUqyirPa/U+ePJOj+xuT
         xxvbfxo4f5HZ4M0QfUJPVQ//CgyViOt7o6NKaEaj1dehPMjDEQrQ8hGubQVdugIy075H
         GJhNR5uI9IkS2J3wh5+cPjkD8WpwryAqnm4AXL35UPcK+lWwr96wPHxnyuIbsmv4mr+x
         TtrvTQCa+ud4RMg2Rb4G32jPIMYbJNdVWneiKNbA3LiAqnM9DBuRl7Lg2RdN78m8Amaq
         aJeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783629008; x=1784233808;
        h=content-type:cc:to:from:subject:message-id:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzslN++gvwF111Oxj75aJ3QDVnvg6D0q7xeFijnE/DM=;
        b=AhAWRayLYfF5RrNN0BYLyrifTEQgLGuKeim7ME5cHvsyI2Iv3+JqNlSVKckKqhgbQ0
         h8IN/KobCsRhdHZuj3LOCOhCcXp9itzFX9vI5GbMQCp7j9w2GFNd75FbgzRGlK7PJ/AO
         Vye6jakVdmL9o6xEtBlDi5I8IqzMtaNZj3wRS4mE1CZzVJfVa3hNfoiDvSpbsHUHtn7y
         5RXwlw3Vc3lyqwkLFRO4SLLjlfff5+VYde0mpyt9DwvsA/gLJ/myALWP2UWqZGQ4XFbn
         OERBaMtZ9obvdmc/am8SOG/QOKSWNhAFuB5RUL0eyGcXOOsB48RqfW1NSm+xC/7fZtwu
         0OVQ==
X-Gm-Message-State: AOJu0Yy5M5wGn4J11SmcaccImqFJ1+C5CPu9rhSA63XMmvVwRUI93KRB
	mw4O+3Rb2wtDkRc9DT+7sv64Gi17hTx+S1Jd+vxPZb3iJ+xu0tvRvACV0APu6mF4yUkWWINg3Yg
	2z7RNeftzn/aR6Uid4sAaWIE1mQ==
X-Received: from jaaf25.prod.google.com ([2002:a05:6638:c7d9:b0:5e9:4c3:fe2b])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:1a1a:b0:495:f85b:d08f with SMTP id 5614622812f47-4a20241e89cmr7170981b6e.18.1783629008168;
 Thu, 09 Jul 2026 13:30:08 -0700 (PDT)
Date: Thu, 09 Jul 2026 20:30:07 +0000
In-Reply-To: <87y0fk5uyi.wl-maz@kernel.org> (message from Marc Zyngier on Thu,
 09 Jul 2026 11:16:37 +0100)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <gsntjyr36h4g.fsf@coltonlewis-kvm.c.googlers.com>
Subject: Re: [PATCH 6.6 v2 1/6] arm64: sysreg: Add layout for ID_AA64MMFR4_EL1
From: Colton Lewis <coltonlewis@google.com>
To: Marc Zyngier <maz@kernel.org>
Cc: stable@vger.kernel.org, oliver.upton@linux.dev, sashal@kernel.org, 
	gregkh@linuxfoundation.org, mizhang@google.com, catalin.marinas@arm.com, 
	will@kernel.org, james.morse@arm.com, suzuki.poulose@arm.com, 
	yuzenghui@huawei.com, mark.rutland@arm.com, ahmed.genidi@arm.com, 
	leo.yan@arm.com, miguel.luis@oracle.com, dbrazdil@google.com, 
	kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:maz@kernel.org,m:stable@vger.kernel.org,m:oliver.upton@linux.dev,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:mizhang@google.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:james.morse@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:mark.rutland@arm.com,m:ahmed.genidi@arm.com,m:leo.yan@arm.com,m:miguel.luis@oracle.com,m:dbrazdil@google.com,m:kvmarm@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[coltonlewis@google.com,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-273043-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56EE07355A4

Hi Marc,

Marc Zyngier <maz@kernel.org> writes:

> On Wed, 08 Jul 2026 23:51:19 +0100,
> Colton Lewis <coltonlewis@google.com> wrote:

>> From: Marc Zyngier <maz@kernel.org>

>> [ Upstream commit cfc680bb04c54e61faa51a34d8383a0aa25b583f ]

>> ARMv9.5 has infroduced ID_AA64MMFR4_EL1 with a bunch of new features.
>> Add the corresponding layout.

>> This is extracted from the public ARM SysReg_xml_A_profile-2023-09
>> delivery, timestamped d55f5af8e09052abe92a02adf820deea2eaed717.

>> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> Signed-off-by: Marc Zyngier <maz@kernel.org>
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Reviewed-by: Miguel Luis <miguel.luis@oracle.com>
>> Link: https://lore.kernel.org/r/20240122181344.258974-5-maz@kernel.org
>> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>

> Please read Documentation/process/backporting.rst, and in particular
> the section indicating the requirement for your own SoB.

> None of these patches can be merged if this is missing.

That taught me a few tricks. Thanks. And I'll make sure to include my
SoB.

> 	M.

> --
> Jazz isn't dead. It just smells funny.

