Return-Path: <stable+bounces-215926-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNkbKXGXjWkt5AAAu9opvQ
	(envelope-from <stable+bounces-215926-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 10:03:45 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5182B12BAB5
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 10:03:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 560BB303A26F
	for <lists+stable@lfdr.de>; Thu, 12 Feb 2026 09:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4F12DB7A8;
	Thu, 12 Feb 2026 09:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iR8GYkFZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8B93EBF3C
	for <stable@vger.kernel.org>; Thu, 12 Feb 2026 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770886976; cv=none; b=pKNXdP+9KWIFl3WYhxP7nRxevybaedBTZhfeh9XFsBYEwyFxXIE/f6zWVaIpFmzRAS8StZhmj57ZKhc/ue8v8xtiaz/P5QmrZ3qi3/Hsmx/dYjPtVMjI/qrDVMZrCotuls3f/s/jrmOnumRybBDznVF8WlV+OgPkxCkQ3RmO45w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770886976; c=relaxed/simple;
	bh=yiRsdt570K13+Sp7adOYctz55UhJ5uxrG+YyJGo4m4M=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Z0LZ0rO7zXU624BpBgDGpSFZt0ImfUWW0N+4b1fv9kzUYSCBgQogxlxmxjP4DySuGgDvq4gyRxaYA3p3uc7nlwbrokNJcOiS8svAzvEZAtDjcia/4WEgstn5T2FHSMphW+kWOy3LxePeNBz3h6w3P9utT2Qi0/SvcxoEL0nKi0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iR8GYkFZ; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b885979bfa9so299695866b.1
        for <stable@vger.kernel.org>; Thu, 12 Feb 2026 01:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770886973; x=1771491773; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3lZ/FXSzIrKV2ZCN0nh7sjPuVDRySXe1YLtlGIVn0Sc=;
        b=iR8GYkFZnaEj+ktcMlygtLwFjTnhp0Ji7sVAcDZydvuVsmEeTMo1tR769LN9Tr5tCX
         ul7Zv1ggbFH/eNmt1B1f6TLDDo9dHnPBaSY9Q3hcUJn/c2t2rE4fOVvHJx/64xEdCu3E
         6BHHYAXbFpYRByuJ7irGu/Cd7YGrr8VBcV9VooAJ7GQfUtOqZtmOPmvPztiY6VOFmFgQ
         Ml5ZX6XhJSPf0uvmPOBoNaXZTlBEzep6SFrl5EDxMixQP5uW10qAmgmHzjdeoHCS575/
         nkP7Gus/bnPPkwlS16RXUVbqPvFIy0YzkZyAQF4aYrrdzQDLLkf3ae/fpOkmY7aTZf9V
         3aSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770886973; x=1771491773;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3lZ/FXSzIrKV2ZCN0nh7sjPuVDRySXe1YLtlGIVn0Sc=;
        b=IAp7BIe4Q56opgqRy3U4CLiwEE0jhLJs6WwHWopEGS0beQjckwNn8dGsSfK0WcsvmX
         hYutKmtMg6etDSaA4/2C5jGSR+IumxmkKt/JiZEvfCa8e91ft1tix25mxPvrs/Ff7OPC
         LuxTe8XAaJCRxSSK2UhimrrXS2Bj07ng1zoRu8jCrW7kug/zVGDNmsTTkZZehZO6RaSp
         0/Yz8no+b4LEBBL8BJqYLmQLVgeS76MmEhiplbmCAdBE5IOllFQfwpCq6EAkY8IazqO5
         Px6Bj1/jbauDrLC1QpLeEHUsh3qJRb0i/K4Ky/h/Yk8ZmbQZFmftjH59VNJ8/bJeQVZn
         Lk0A==
X-Forwarded-Encrypted: i=1; AJvYcCUq6TFX1J3H775yJUMGX/4PMgadugs/AjIEkgMMSSi0SrV7fEnI9zTU8hTOUl5zMqCNgt1oVno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLkSoZzy2vupNj3N79G72Pjm/f3gLeJRLR9wK+5ek6NiQy2mBY
	7nlvmoZIFZGmp6IH3gpakPZV0UHPY+fHIvT8h1q57/kPwNf6ZpjR45h92qR1TaT3635PfqO3rL3
	PMw==
X-Received: from ejdr2.prod.google.com ([2002:a17:906:38c2:b0:b8f:9c02:805c])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:fe44:b0:b87:322d:a8bc
 with SMTP id a640c23a62f3a-b8f92be341cmr98528366b.31.1770886973514; Thu, 12
 Feb 2026 01:02:53 -0800 (PST)
Date: Thu, 12 Feb 2026 09:02:49 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.239.g8d8fc8a987-goog
Message-ID: <20260212090252.158689-1-tabba@google.com>
Subject: [PATCH v1 0/3] KVM: arm64: Fix guest feature sanitization and pKVM
 state synchronization
From: Fuad Tabba <tabba@google.com>
To: kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org
Cc: maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com, 
	suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, 
	will@kernel.org, tabba@google.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-215926-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5182B12BAB5
X-Rspamd-Action: no action

This series addresses state management and feature synchronization
vulnerabilities in both standard KVM and pKVM implementations on arm64.
The primary focus is ensuring that the hypervisor correctly handles
architectural extensions during context switches to prevent state
corruption.

The series is structured as follows:

* Patch 1: Addresses an issue in KVM/arm64 in general where FEAT_S1POE
  is exposed to guests based solely on hardware capability. If the host
  kernel is built without CONFIG_ARM64_POE, it will not context-switch
  POR_EL1. Masking the S1POE bit in ID_AA64MMFR3_EL1 when
  system_supports_poe() is false prevents state corruption.

* Patch 2: Fixes a bug in pKVM non-protected guest initialization.
  Previously, pkvm_init_features_from_host() copied the initialized flag
  without copying the actual id_regs array. This caused EL2 feature
  checks (such as ctxt_has_tcrx()) to silently fail, breaking the
  save/restore logic for system registers like TCR2_EL1, PIR_EL1, and
  POR_EL1 during world switches. The fix initializes the ID registers.

* Patch 3: Removes a redundant kern_hyp_va() macro invocation in
  unpin_host_sve_state(). The sve_state pointer is already initialized
  as a hypervisor virtual address. While idempotent, the macro is
  unnecessary here.

Based on Linux 6.19.

Cheers,
/fuad

Cc: stable@vger.kernel.org

Fuad Tabba (3):
  KVM: arm64: Hide S1POE from guests when not supported by the host
  KVM: arm64: Fix ID register initialization for non-protected pKVM
    guests
  KVM: arm64: Remove redundant kern_hyp_va() in unpin_host_sve_state()

 arch/arm64/include/asm/kvm_host.h |  3 ++-
 arch/arm64/kvm/hyp/nvhe/pkvm.c    | 39 ++++++++++++++++++++++++++++---
 arch/arm64/kvm/sys_regs.c         |  3 +++
 3 files changed, 41 insertions(+), 4 deletions(-)


base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
-- 
2.53.0.239.g8d8fc8a987-goog


