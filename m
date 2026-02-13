Return-Path: <stable+bounces-216239-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJWhEGg3j2n2MgEAu9opvQ
	(envelope-from <stable+bounces-216239-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:38:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E24E01371F9
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 15:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDFD13046EA1
	for <lists+stable@lfdr.de>; Fri, 13 Feb 2026 14:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16D57361DC4;
	Fri, 13 Feb 2026 14:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1DOWlcXn"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070CD22E3F0
	for <stable@vger.kernel.org>; Fri, 13 Feb 2026 14:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770993499; cv=none; b=Sp8u5W7Rt7NTJLxyvnplpMredPEqJV11RYXgfbGO3YJf4a1r+622WHHyKmxG/egUzvveGICNDSDB4LEXdhbhsJnu3QFKYGPoJE20CFpbv8+EbreKF50S3KrjAhE9qPqJqpO/MWUNx9U9qJ1h4WzJqDVyfc34Ag3+CTmZ/iXr1/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770993499; c=relaxed/simple;
	bh=tgCJ0yXfYRIrO5tRfb5O7+h3Cr2Uakv1/lFQiNz9wC0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SOOSQwZl+yZ3vEtlYvLfork7tvYBv8hwKwqpQ8iQJtR1OimQicIEWVacR33yKYmvm/AXdkMtrVxhYQDuk1gyzO4U1t5D2dZ2lQ1nLKY1l4yvYAa5FrUNun2BpLK6i5MqoEN0MW5kLP2HQvgbczG8VVQ2RQQdwOhiSkVsKS9V0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1DOWlcXn; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tabba.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-b8f10615953so117170066b.2
        for <stable@vger.kernel.org>; Fri, 13 Feb 2026 06:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770993496; x=1771598296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UUp+ZPHGqL5Ruf8kk7PuU1fhAJIx8L0ts8JU7bSIkH8=;
        b=1DOWlcXnR1bbpSxDUubDPjNbRNj+OWab4naSJGS8jxONOruAKChyRYeqScEOOfptB5
         FxYRoqc6AKVlxCIsui6RO4TqMrUewqR5io2Xqjbs5UdFQUmCDQL0+uwMuq/lUlsXpgjA
         gLmInrnLw0hZgnDBu033CL7V0ft8rw6zzX1xaaBu/CBu9R/0QV+9MGkZllM6psN46G8S
         wtYchgeOG5lBryFYMZ538t5R54qy91csOc7Wlq0l4i+Y7apZghbck+nGZu+FUTsLm1RL
         vL4eApyCW2sHpFSnN19yxd8/Wjxw27o0wa4Oxl6CFG8gP/LosVuAU+VcHqUo5v5gbUQ0
         Xk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770993496; x=1771598296;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUp+ZPHGqL5Ruf8kk7PuU1fhAJIx8L0ts8JU7bSIkH8=;
        b=bErSDxRiqxd9FEoB8UE2M103jWRVxhLgvwktBxj/ZqWGfGLBNjdC3DNst55DBbWz5K
         x0CT/v/XNKb5AHJVRY0oKPAmfMn0hRW90pAIzs770wuLa98QOn7nCJFThN0N4Wm5LTHl
         atP/y8RkiybV7hKV7AUO1OykUUft5bPmbslT8CFg/9YSW8ne4onx6MPal78Hkc4qCt4Y
         M1KErtKGZFt7tbXMh0EiiZL+2jRD065b2mdQbLYVAK/67WbysZkiQp+cOT+uHBIiHqyh
         /jWc/0im6EqcL1tuPjjCQEDj7eQ5OEK5352z4fW5VAlvH9mIeGKHmVc3J15JHEgfaypa
         VIww==
X-Forwarded-Encrypted: i=1; AJvYcCVLyUMOLRy7dVC8lDWFdGWK0fk6Pbu/Bwpxz662/etQuC9VEvn2M0r6RXLIJ68sC+2mGnXe/SE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8s9otRSRblb0wptv1RdRtPAfjRuBmrUXoqNHBzm2I8+KufaPd
	fOBMbX5L3O0ccHrnYMaJAm3+YK6JGWwX0KcbpCTBOnxm0vE5P8O8ARrphctX4n1Oo/rLgKceQ2H
	irw==
X-Received: from ejbme9.prod.google.com ([2002:a17:906:aec9:b0:b87:1864:34ed])
 (user=tabba job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:728c:b0:b8f:848b:4456
 with SMTP id a640c23a62f3a-b8fb41937f6mr98615266b.13.1770993496347; Fri, 13
 Feb 2026 06:38:16 -0800 (PST)
Date: Fri, 13 Feb 2026 14:38:11 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.273.g2a3d683680-goog
Message-ID: <20260213143815.1732675-1-tabba@google.com>
Subject: [PATCH v2 0/4] KVM: arm64: Fix guest feature sanitization and pKVM
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-216239-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tabba@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E24E01371F9
X-Rspamd-Action: no action

This series addresses state management and feature synchronization
vulnerabilities in both standard KVM and pKVM implementations on arm64.
The primary focus is ensuring that the hypervisor correctly handles
architectural extensions during context switches to prevent state
corruption.

Changes since v1 [1]:
- Moved optimising away S1POE handling when not supported by host to a
  separate patch.
- Fixed clearing, checking and setting KVM_ARCH_FLAG_ID_REGS_INITIALIZED

[1] https://lore.kernel.org/all/20260212090252.158689-1-tabba@google.com/

Based on Linux 6.19.

Cheers,
/fuad

Cc: stable@vger.kernel.org

Fuad Tabba (4):
  KVM: arm64: Hide S1POE from guests when not supported by the host
  KVM: arm64: Optimise away S1POE handling when not supported by host
  KVM: arm64: Fix ID register initialization for non-protected pKVM
    guests
  KVM: arm64: Remove redundant kern_hyp_va() in unpin_host_sve_state()

 arch/arm64/include/asm/kvm_host.h |  3 ++-
 arch/arm64/kvm/hyp/nvhe/pkvm.c    | 37 ++++++++++++++++++++++++++++---
 arch/arm64/kvm/sys_regs.c         |  3 +++
 3 files changed, 39 insertions(+), 4 deletions(-)


base-commit: 05f7e89ab9731565d8a62e3b5d1ec206485eeb0b
-- 
2.53.0.273.g2a3d683680-goog


