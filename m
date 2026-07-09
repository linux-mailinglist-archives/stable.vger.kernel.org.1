Return-Path: <stable+bounces-273071-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YaYnLLIiUGritwIAu9opvQ
	(envelope-from <stable+bounces-273071-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 00:37:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C070736172
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 00:37:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="T5iR/s/V";
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273071-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273071-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F1193028EEC
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 22:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C63A7296BD3;
	Thu,  9 Jul 2026 22:37:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f202.google.com (mail-oi1-f202.google.com [209.85.167.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E3633D6E3
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 22:37:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783636636; cv=none; b=R95opXUEVs39XwWz59nUuRhqDxdR8R/0h3WClotO7dLq9RMcz7Vk3ryaLbmiF3WCnUSYKjdxJFL52+E3OpFN3vTOeF/8x+kef58hQgm4jxN6d+brfU+695peVED0ORyfwThqsUTqe7vQAM7jBjYpCf1CL+ebVa6SscPCElipTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783636636; c=relaxed/simple;
	bh=EaexnPqrmtpzjh8qzHPIamRGJjDLlHmrtHt32D9rGTQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hW4ULk+O25NGrp+mOY3z4j18cAuB8bp/X3/tyMLJawwYP+611J4xBq+1VOJzaIt5Vi6zQxUTap3qRWNcqHlShomur8SAAO90uagDeLK8eFBptKqk0WN9xnyEtZcIVP1wc9+7nQbkTZCNPBAvR6tJVDCQcp1BWM7QfpsIYRY0zgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T5iR/s/V; arc=none smtp.client-ip=209.85.167.202
Received: by mail-oi1-f202.google.com with SMTP id 5614622812f47-495f637105eso435878b6e.2
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 15:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783636634; x=1784241434; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7wbRxqeXe6OhAyO1MWhkHUo2TrAk/KOd+lAMmZEbmWc=;
        b=T5iR/s/V6gA9UkClOX7JXJLndAsL5QfA8Oc/OG4aoMHtCrgd9My5jBwnIL7i6QLMAo
         HV+ZZeEb58qikxgPvvRWPfC1Roe0Fr91go/j9x3p/aNyp6QD0JXt8un9p9xSKntoV4sD
         iuwdiojy1l/HbCyU22Ar9hQlY2ZHsCbyjOcWsTlMPzOSzLQ8MV5/d87/kqshqV2HaXFM
         qBrklnuwOtPxa+PCDdtM0Pus/q7SDCXIeeG1TyHW7V+cfvZEFYd2+UKl/3m40Gu5rFhI
         gVrVyc2iI3xl9V/9dPIqyyLh7kEJpVwOqrjOMm1wjq666CiLqjKFNqTwlJZF+wgARbPp
         Husg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783636634; x=1784241434;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7wbRxqeXe6OhAyO1MWhkHUo2TrAk/KOd+lAMmZEbmWc=;
        b=suuUKwHKAf1jEQGgmr4GYogUL9/OBAihsbN1UxaFC2dLqYjMj0ner3E7VbuntdOOzZ
         kDPA0N6LbnZuR0eTIitmFSf+4GbsgjSHo7gG+i4aRAPdiB5tZwvBPe3UVQweRg7M6dwJ
         Xm9obD2HqufIEBuuHruVYG+ECc5mvZehI8/d0WCOodHwlxo2NOLm4db4aaJ1J/becIOE
         mseuI2iu+Bukxt7XEPUZTjQZo9Pn8I8Pj4qFBK1z3RxgmzrhS596U1marq/bLNbHJb1W
         zsuFBGMCbpuvTDaJq3vNBWjPGV1QQamJori0QfmdrUzHOwi+7Ltk71Ciw4rpD2MXgAgg
         LgkQ==
X-Gm-Message-State: AOJu0YxP+cgJCAkbje3R9x8spDMxLlPi/Lg2zysruCqsgdyyiS3MNGxa
	BCZY8SMlS0RafNI3tzgPJ/RtNWbImzcPQ3DhH4MdZWqifWDdNJIWYsvNnMl74pEiorSwdsO5MTg
	SaSZpzVpXo6eod5XrsuCXQuifUaWifp1v3LL8PhmaLVy22vm0aqoqzWqkQT2E5Ot8goHOz0AJSV
	KYP/apjTeO4t8SRaAWA0Qnp1JJjkjGJd0kbpjgbH4B+h4KdfgLam2b8ez1/tuUc0Y=
X-Received: from ilax6.prod.google.com ([2002:a92:d306:0:b0:503:4f93:1524])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:c410:b0:48c:3b4:2b95 with SMTP id 5614622812f47-4a2042c6d24mr8647572b6e.29.1783636633855;
 Thu, 09 Jul 2026 15:37:13 -0700 (PDT)
Date: Thu,  9 Jul 2026 22:35:57 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260709223604.12934-1-coltonlewis@google.com>
Subject: [PATCH 6.6 v3 0/6] arm64: KVM: Backport VHE-only boot fixes
From: Colton Lewis <coltonlewis@google.com>
To: stable@vger.kernel.org
Cc: oliver.upton@linux.dev, sashal@kernel.org, gregkh@linuxfoundation.org, 
	mizhang@google.com, catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, ahmed.genidi@arm.com, leo.yan@arm.com, 
	miguel.luis@oracle.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:oliver.upton@linux.dev,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:mizhang@google.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:maz@kernel.org,m:james.morse@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:mark.rutland@arm.com,m:ahmed.genidi@arm.com,m:leo.yan@arm.com,m:miguel.luis@oracle.com,m:kvmarm@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:coltonlewis@google.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[coltonlewis@google.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273071-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coltonlewis@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C070736172

Architectural updates retroactively made FEAT_E2H0 optional, meaning
hardware can implement FEAT_VHE without FEAT_E2H0. On such CPUs,
HCR_EL2.E2H can reset to an unknown state and must be initialized early
so later code can reliably detect whether E2H mode is active.

Without these fixes, booting 6.6.y as a guest under KVM nested
virtualization will hang at boot.

This series targets 6.6.y specifically because these patches are all
present in 6.12.y and applying these patches to 6.1.y and presumably
older kernels has more conflicts and results in other issues booting
as a guest under nested virtualization. More work is needed to enable
that.

Changes in v3:
- Added Signed-off-by: Colton Lewis <coltonlewis@google.com> to all commits.
- Added explicit '[ Backport: ... ]' conflict resolution notes indicating why
  conflicts occurred and how they were resolved (Patches 4, 5, and 6,
  including Patch 4 where the conflict was trivial).

v2:
https://lore.kernel.org/kvmarm/20260708225124.4130846-1-coltonlewis@google.com/

v1:
https://lore.kernel.org/kvmarm/20260701204342.2654385-1-coltonlewis@google.com/

Ahmed Genidi (1):
  KVM: arm64: Initialize SCTLR_EL1 in __kvm_hyp_init_cpu()

Marc Zyngier (4):
  arm64: sysreg: Add layout for ID_AA64MMFR4_EL1
  arm64: Treat HCR_EL2.E2H as RES1 when ID_AA64MMFR4_EL1.E2H0 is
    negative
  arm64: Fix early handling of FEAT_E2H0 not being implemented
  arm64: Revamp HCR_EL2.E2H RES1 detection

Mark Rutland (1):
  KVM: arm64: Initialize HCR_EL2.E2H early

 arch/arm64/include/asm/el2_setup.h   | 56 ++++++++++++++++++++++++++--
 arch/arm64/kernel/head.S             | 20 ++++------
 arch/arm64/kvm/hyp/nvhe/hyp-init.S   |  3 +-
 arch/arm64/kvm/hyp/nvhe/psci-relay.c |  3 ++
 arch/arm64/tools/sysreg              | 37 ++++++++++++++++++
 5 files changed, 101 insertions(+), 18 deletions(-)


base-commit: da47cbc254661aa66d61ef061485a7080305c4be
-- 
2.55.0.795.g602f6c329a-goog

