Return-Path: <stable+bounces-263587-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id btJRA8rdMGqFYAUAu9opvQ
	(envelope-from <stable+bounces-263587-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:23:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7F068C20C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:23:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=dnPgfqRb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263587-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263587-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 159F13008D21
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F7C3CF050;
	Tue, 16 Jun 2026 05:23:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 370ED3C5836
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:23:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587395; cv=none; b=jI5O29wgvOJeleswwCWKKyxSjctqY6FatmOBQ3KsLhiP1QxiXXdsQystdIfFaAWFn5v53vjTPgMKIPFa9PVwLeBm0T7aBixTLYV4RnJm9JnUyZDcPI0XLImlwmXjFMJukWZ98AI6FZhyzfelX1LkOIfKjlU7m5r6f5E7+JCaPxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587395; c=relaxed/simple;
	bh=mnaAnVZVTYd0m86Ik871edJXE6llVfPMxuFiHLOyjPw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lQBRc9SFrRHTi5XPXp1BTn+nwm0pP8AZ0hIDSRLm6f1vwGHjwKhgJNoCsgiTyyN3yT04NYPgOwW+fLqpTZU//GNDfHixr2UDdbk7Qgd3U0M2r4rPPE86E8tZ5trqOWndt3vCJHrynrHcrt2LhHIj5gQOtLnQzzELdPI6zcrDgdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dnPgfqRb; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27BB3153B;
	Mon, 15 Jun 2026 22:23:09 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 1AD9D3F763;
	Mon, 15 Jun 2026 22:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781587393; bh=mnaAnVZVTYd0m86Ik871edJXE6llVfPMxuFiHLOyjPw=;
	h=From:To:Cc:Subject:Date:From;
	b=dnPgfqRbFdUEuBm+btSWSNf0hLVOKJQx6VgMBFqpMyYXfUWUsR22Q2c5cilkXy8pX
	 cqoofgmNNGk7kfKrRVXsuUumRIMdEEe00rC77myoW9xPFtU508TpWhJtAiwcJd8Gea
	 E4HDOBrME1Asa5otvVlLFyNhHnjA1kEYay5kBkuo=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: anshuman.khandual@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	ryan.roberts@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org,
	yuzenghui@huawei.com
Subject: [PATCH 5.15.y 0/9] arm64: errata: Mitigate TLBI errata on various Arm CPUs
Date: Tue, 16 Jun 2026 06:22:58 +0100
Message-Id: <20260616052307.112083-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-263587-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:anshuman.khandual@arm.com,m:catalin.marinas@arm.com,m:gregkh@linuxfoundation.org,m:lee@kernel.org,m:mark.rutland@arm.com,m:maz@kernel.org,m:oupton@kernel.org,m:ryan.roberts@arm.com,m:sdonthineni@nvidia.com,m:will@kernel.org,m:yuzenghui@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[arm.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arm.com:dkim,arm.com:mid,arm.com:url,arm.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C7F068C20C

This is a v5.15-only backport of a workaround for a TLB invalidation
issue affecting several CPUs. The final patches landed in mainline
yesterday:

  https://lore.kernel.org/linux-arm-kernel/178157002783.358810.8206806281627742561.pr-tracker-bot@kernel.org/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80476f22b8b7e193b26f285a7c9f9e4b63abca16

This issue has been assigned CVE ID CVE-2025-10263, and Arm have
published a security bulletin:

  https://developer.arm.com/documentation/112137/latest/

This backport includes prerequisite patches which were previously sent
on their own (unchanged since that posting):

  https://lore.kernel.org/stable/20260611134706.1700777-1-mark.rutland@arm.com/

I've pushed a copy of this backport to my kernel.org repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-5.15/arm-4118414/backport

Mark.

Marc Zyngier (1):
  KVM: arm64: Remove VPIPT I-cache handling

Mark Rutland (5):
  arm64: tlb: Allow XZR argument to TLBI ops
  arm64: tlb: Optimize ARM64_WORKAROUND_REPEAT_TLBI
  arm64: cputype: Add C1-Ultra definitions
  arm64: cputype: Add C1-Premium definitions
  arm64: errata: Mitigate TLBI errata on various Arm CPUs

Shanker Donthineni (2):
  arm64: cputype: Add NVIDIA Olympus definitions
  arm64: errata: Mitigate TLBI errata on NVIDIA Olympus CPU

Will Deacon (1):
  arm64: errata: Mitigate TLBI errata on Microsoft Azure Cobalt 100 CPU

 Documentation/arm64/silicon-errata.rst | 46 +++++++++++++++++++++
 arch/arm64/Kconfig                     | 50 +++++++++++++++++++++++
 arch/arm64/include/asm/cputype.h       |  6 +++
 arch/arm64/include/asm/kvm_mmu.h       |  4 +-
 arch/arm64/include/asm/tlbflush.h      | 55 ++++++++++++++++++--------
 arch/arm64/kernel/cpu_errata.c         | 34 +++++++++++++++-
 arch/arm64/kernel/sys_compat.c         |  2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c          | 41 ++-----------------
 arch/arm64/kvm/hyp/vhe/tlb.c           | 19 ++-------
 9 files changed, 182 insertions(+), 75 deletions(-)

-- 
2.30.2


