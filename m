Return-Path: <stable+bounces-270243-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7F8YCAt8RWq9AwsAu9opvQ
	(envelope-from <stable+bounces-270243-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 22:43:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D070A6F18C5
	for <lists+stable@lfdr.de>; Wed, 01 Jul 2026 22:43:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b=o2OyOllU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-270243-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-270243-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D697030569FB
	for <lists+stable@lfdr.de>; Wed,  1 Jul 2026 20:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC01A3B19D4;
	Wed,  1 Jul 2026 20:43:46 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f201.google.com (mail-oi1-f201.google.com [209.85.167.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F3A3A83AC
	for <stable@vger.kernel.org>; Wed,  1 Jul 2026 20:43:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938626; cv=none; b=P/mmhoGPgmP6Aw1G5sPy/XbJ3RlptK99QFmQnqknBIOKE0x/Hach0Rm1YoTgBpNQd3J5PBogVLJugTWsgDn26eYSL30HvCOFDeufDyRjOwfnp0S7+9Bw5sayD7Qgtbw5SqmtbRLTsi9bjBn7j98M/y3cCqJTXKcWEXojZ92Evf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938626; c=relaxed/simple;
	bh=60S4kFwxnDVBWFD5Z3yw/BFmHxkCUVWvN3+3KkqvXoY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tY8JHZXwyy9L+ixgpIqJzCu2xXbFTtLmiAaKWWrYA2nZAaPh3gGrrlsuBS5k0QlfEAg0gZrZfYh7DYNj3vlGU402WtTSJbk+Tgy0qUDIZ+Dmvh6A9I3jEsqYCeaG5W5SYGa8lgfsw2QzyfRZYoVBcLM8xPonS0Gkx5v4StpCG8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--coltonlewis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o2OyOllU; arc=none smtp.client-ip=209.85.167.201
Received: by mail-oi1-f201.google.com with SMTP id 5614622812f47-486e64c8edeso1143800b6e.2
        for <stable@vger.kernel.org>; Wed, 01 Jul 2026 13:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782938624; x=1783543424; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LgbAV7Db884sdO2wBFSay1l144nmKC6A4dcsE5Jnxg8=;
        b=o2OyOllUrCY3iYeIRZR1htn+aAhTyxx3dj6VkRY2AqomE2ErJSfbWlEQS4lIzu3tEX
         w4W3tRF/yYRhnHFUDjFrUFw/b23tj3QWEd8uthRCVqnW+gjP8AvvUki8QgQIxqXoAEIF
         iLMeUVBNcFP8ZpUKZDfooLEljNvto0HbWBQlKwL2AKXsIgD+2WaV2ep9CBSiCZmp4XaI
         G2MjyzVbmqAvegx4WocEhqd7sa03fY56eFk6WubzM8cc21Si9SDXTBbnrlRUtZCW+xZq
         gVXnrSByQqLDcQ+wOJMdzPOIugcczUP94X4Jgpcvyr9R4VVbOGfUqTaiDEXoih3jFeTW
         jD3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938624; x=1783543424;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LgbAV7Db884sdO2wBFSay1l144nmKC6A4dcsE5Jnxg8=;
        b=H1C4AKeSzLRb7g9FZm0B12qRVYUZIoQrgsp7ZMnUnlZRieNqI+f9GfSZ6c+I8c/VdS
         c6/nFJgoNutVv2zyuj+PfZEDH19Or5Pmq6lEWfI0yBBpvMLin1hdypQ+cLEIzKHrm1bp
         AuB2b+VQQwBi38ns+hv/u8u5Lz5SXUXUY7d4fzq+mS08t+NEh1JrDcuVAnBv8V3sEn1G
         z2dm2UHhy5xefYdaxW2wT7tfaAvzQTztdNutcPh+Addpjzj4kmfG5kF7Kk9vmmyWtu6M
         WrcxxSUV35fDVns+hYGUkMJy49tFOOxPR89lYite/y+V44nlKSTUGjorcnegzyeGR4Kj
         4CrQ==
X-Gm-Message-State: AOJu0YxPo9K/VMFUzxKX8Jq/T2/lBxl968Q8kzWxpAVZY6kKu43MQLat
	GM2p4Hzd0EdeJotSBPzOZu8i9WkzIGycPUpd2LKSS1q1/yUS4nidWWxjuqp23UQj/9w3URQipCk
	EyFgxZyJaunQTDvdBubVkgUVV2mGYJ9fuMbATWPWly3az8gcSqoQN6oO1r6JH3tMAarVMwzR5Yd
	89fqFf2iD0lDa1flD7Vn209ZdFN39irUSYZ1tF5ZChbkBOb+973rO+bfKFfBz5pf4=
X-Received: from jablt3.prod.google.com ([2002:a05:6638:ac03:b0:5e7:3fde:8787])
 (user=coltonlewis job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6808:10d2:b0:496:b7c:274b with SMTP id 5614622812f47-4960edef744mr2368951b6e.19.1782938623414;
 Wed, 01 Jul 2026 13:43:43 -0700 (PDT)
Date: Wed,  1 Jul 2026 20:43:37 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc2.803.g1fd1e6609c-goog
Message-ID: <20260701204342.2654385-1-coltonlewis@google.com>
Subject: [PATCH 0/5] Backport ARM64 VHE boot fixes to 6.6.y
From: Colton Lewis <coltonlewis@google.com>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	James Morse <james.morse@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Mingwei Zhang <mizhang@google.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Colton Lewis <coltonlewis@google.com>
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
	TAGGED_FROM(0.00)[bounces-270243-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[coltonlewis@google.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:catalin.marinas@arm.com,m:will@kernel.org,m:maz@kernel.org,m:oliver.upton@linux.dev,m:james.morse@arm.com,m:suzuki.poulose@arm.com,m:yuzenghui@huawei.com,m:mizhang@google.com,m:linux-arm-kernel@lists.infradead.org,m:kvmarm@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:coltonlewis@google.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
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
X-Rspamd-Queue-Id: D070A6F18C5

This series backports VHE CPU boot fixes to the 6.6.y stable branch.

These fixes are already present in the 6.12.y stable branch (and
newer), but are missing in 6.6.y. They are required to enable booting
L1 guests with nested virtualization enabled (kvm-arm.mode=nested).

Without these patches, a 6.6.y guest boots with HCR_EL2.E2H
incorrectly configured (because it misses VHE-only detection or early
initialization), causing early boot hangs/trap loops.

Conflict resolutions:
- Patch 4 (KVM: arm64: Initialize HCR_EL2.E2H early) had conflicts in
  arch/arm64/kvm/hyp/nvhe/hyp-init.S due to differences in state
  initialization. Resolved by extracting EL2 state initialization into
  __kvm_init_el2_state.
- Patch 5 (arm64: Revamp HCR_EL2.E2H RES1 detection) had conflicts in
  arch/arm64/include/asm/el2_setup.h. Resolved by using raw msr hcr_el2
  instead of the missing msr_hcr_el2 macro.


Marc Zyngier (4):
  arm64: sysreg: Add layout for ID_AA64MMFR4_EL1
  arm64: Treat HCR_EL2.E2H as RES1 when ID_AA64MMFR4_EL1.E2H0 is
    negative
  arm64: Fix early handling of FEAT_E2H0 not being implemented
  arm64: Revamp HCR_EL2.E2H RES1 detection

Mark Rutland (1):
  KVM: arm64: Initialize HCR_EL2.E2H early

 arch/arm64/include/asm/el2_setup.h | 52 ++++++++++++++++++++++++++++++
 arch/arm64/kernel/head.S           | 17 +++-------
 arch/arm64/kvm/hyp/nvhe/hyp-init.S | 16 +++++++--
 arch/arm64/tools/sysreg            | 37 +++++++++++++++++++++
 4 files changed, 107 insertions(+), 15 deletions(-)


base-commit: d1cfde2d5d15be14123bdd1689162bd27f995a90
--
2.55.0.rc2.803.g1fd1e6609c-goog

