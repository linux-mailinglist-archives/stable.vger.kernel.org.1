Return-Path: <stable+bounces-272758-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8vJ+OZzUTmrcUwIAu9opvQ
	(envelope-from <stable+bounces-272758-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 00:52:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E0572AF6E
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 00:52:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=eeYwGlDC;
	dmarc=pass (policy=reject) header.from=google.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272758-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272758-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E72E83011057
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 22:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8CE3859EB;
	Wed,  8 Jul 2026 22:52:10 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f73.google.com (mail-ot1-f73.google.com [209.85.210.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042EC36E497
	for <stable@vger.kernel.org>; Wed,  8 Jul 2026 22:52:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783551130; cv=none; b=PE6Lm7Lx9atA177hvvxhD6sZ1jHjOVIgRgYys9mZNw6nmFfHVhdoZkKguoizSst3y5apwLf6fi0xCkf8iH4pxnMDSYs+1MTodOYJKsYC4IOXMdSTbKCkp/W3GQjONiyNE1T4Yrp1Nu+kd5KZfHz6FeF8l8r/Fcnw6MQo/yOlKFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783551130; c=relaxed/simple;
	bh=W9eRCyxeQaxWVre9xRAxVREG5IbAzd3SpzWk9523/DY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CipvM/fHT/EynDzccuz5xJDy0OBCHsyF9wpUDVf3NlWQUNGUwMPMsJQ7Z+kDtZ2JlAUdvGNnO/UvvHFztBvyw4smvxE8ICWgorz1oean/dTNaTVMQ6EvAULE0IOfK6Dut5ZkUAiakk/KmgN8jD32XNyMbB/6Z+8q59Gnl/1a/uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eeYwGlDC; arc=none smtp.client-ip=209.85.210.73
Received: by mail-ot1-f73.google.com with SMTP id 46e09a7af769-7e9dc0f5900so629919a34.0
        for <stable@vger.kernel.org>; Wed, 08 Jul 2026 15:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1783551128; x=1784155928; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VXjaTRbhjgdEqS1UyFYRJTvGMmWZaq4i6pqgK3sf76s=;
        b=eeYwGlDCZv9DMSp2DV/952sAT1XXPr0a0IpWJolHGBB9GwE2BiCN3kRDUfvk6d9ZKt
         +N1NmdjSic3gwp+vSoefI8nXSuJD8C6MB8AsxNZkIOB2QLD2dXJeftK+8c2QTeBHb4bE
         70lJpPp+rqgmn/w1qWzpCjpFLMJk+SfLpi9Pq2Y1dPUGN8ih9A1uoqrP/ok/gNGhJnzB
         WyKExpp3lvggpEkTUPb8VeKeb+qb2VPGeRZQmmAe0mj7JARLFlzCHDY/iZ5oZdAD+O5/
         YQWxekosGnwkOdtEZpracdN8o+5iM8zqjBbHqbFwG8xPa6HhPoYRCDqjY/L75RGdR44+
         6OYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783551128; x=1784155928;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VXjaTRbhjgdEqS1UyFYRJTvGMmWZaq4i6pqgK3sf76s=;
        b=NdAB9SvmI7cnFcBZQ+L04GOGf9KKQiwr3/b+RC/UC7iCPpQpgflQw2uXY2vhsRKwvp
         Jw2xsQPAft+QK1iNKnnmPYwsBKLKmUrFMrAbXLyEXAjuQfIBu7S3Re8uuj1X7mpwkw9y
         zjmCBK9aKK6qF9HegVqAZWZWfEXIbvktNZ/IWe7/sKWPmYLseuNF2cR+I7+FOaruJXfZ
         1MOJeOHBA+annMhFhnTVDNWA456Re0qVO/MX4baJNA+C5/iM5tJTkm3s6/kc0ViS5HjW
         4tlASxxbi2soAt2mVCG+hQHEfdFUrn1vXK3169o55pEf49fYKHlxzBEDHLQXEHwNzBJ/
         iLnw==
X-Gm-Message-State: AOJu0YyzlH8k3Alq9jlk5oVHhGempIb7+RNiyQDUkKmWhfceNTdMcMEw
	DQthVTLloAzqtITWdKp0+gPl4OR6JgYwn6Cy3v10eTVD9qawcaHgPajbVmlPZ3mjtEaQUq16H95
	tXbnYfb3yprVFXwPw8Lhmt8THrBm7ABwapX+ZGj2rBBTeuq+qnKEX5coEsioyMK1+0xX49Pvz3H
	r5F04vO7LII55THiZsDM5B4RBdcb5GjdHKOJwX4PFyqAKWtCqgCUAvnVgiiTv2nR0=
X-Received: from ilsl6.prod.google.com ([2002:a05:6e02:5c6:b0:502:20e8:e7ce])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6820:2209:b0:6a3:7d5a:1ae0 with SMTP id 006d021491bc7-6a37d9d6e0amr220936eaf.29.1783551127438;
 Wed, 08 Jul 2026 15:52:07 -0700 (PDT)
Date: Wed,  8 Jul 2026 22:51:18 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
Message-ID: <20260708225124.4130846-1-coltonlewis@google.com>
Subject: [PATCH 6.6 v2 0/6] arm64: KVM: Backport VHE-only boot fixes
From: Colton Lewis <coltonlewis@google.com>
To: stable@vger.kernel.org
Cc: oliver.upton@linux.dev, sashal@kernel.org, gregkh@linuxfoundation.org, 
	mizhang@google.com, catalin.marinas@arm.com, will@kernel.org, maz@kernel.org, 
	james.morse@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	mark.rutland@arm.com, ahmed.genidi@arm.com, leo.yan@arm.com, 
	miguel.luis@oracle.com, dbrazdil@google.com, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Colton Lewis <coltonlewis@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272758-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[coltonlewis@google.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:oliver.upton@linux.dev,m:sashal@kernel.org,m:gregkh@linuxfoundation.org,m:mizhang@google.com,m:catalin.marinas@arm.com,m:will@kernel.org,m:maz@kernel.org,m:james.morse@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:mark.rutland@arm.com,m:ahmed.genidi@arm.com,m:leo.yan@arm.com,m:miguel.luis@oracle.com,m:dbrazdil@google.com,m:kvmarm@lists.linux.dev,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:coltonlewis@google.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[coltonlewis@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78E0572AF6E

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

Changes in v2:
- Updated commit messages to reference correct upstream SHA1s.
- Preserved inline EL2 state initialization in Patch 4 to avoid
  unrelated code churn.
- Added upstream commit 3855a7b91d42 ("KVM: arm64: Initialize SCTLR_EL1 in
  __kvm_hyp_init_cpu()") as Patch 5.
- Verified boot and KVM initialization across all KVM execution modes
  (nVHE, hVHE/nested, VHE, and protected).

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

