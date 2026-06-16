Return-Path: <stable+bounces-263556-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FUJQOxbcMGorYAUAu9opvQ
	(envelope-from <stable+bounces-263556-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:16:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B8368C10A
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:16:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=dnBudIF8;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263556-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263556-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B896303E2F6
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0DF33C344B;
	Tue, 16 Jun 2026 05:16:04 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E1121B9F6
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:16:03 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781586964; cv=none; b=tNUC1M5mY7nIbai6ZsknRNWKAfd3FJQbOoscioiIWkhfAgdjjgdjENSvaRl5Um98T0xL+arKKrSzuZT7NmpN38qUVngY8QyvULm5nIghLFTgsfSwe0ZskOvGZby9SdUI6ncF7fTt3qttityT8YXeCoST/PBOFIW7Ni8etowvpuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781586964; c=relaxed/simple;
	bh=lldkDsAHPaKWKeKBJ8E0S5hUw8nRSjtUIWGjoQS0KnU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BHIFURRbgB8annIgf36GkeutMnY30QxTv4sRSHKVeXsj8gwCGstVQ1+IpeHlrgz0j60vCoVeT2kcsWYlw28j+DX7lMHG/r5raSFZQJrdoKBuOCoFHJqRUPGlgrnWrC9ehQb1b+WgrFZihwT7BuOSpD+K3POf4ZAUHuDJxgUD4rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=dnBudIF8; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 23B3E3D4B;
	Mon, 15 Jun 2026 22:15:58 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 902883F763;
	Mon, 15 Jun 2026 22:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781586962; bh=lldkDsAHPaKWKeKBJ8E0S5hUw8nRSjtUIWGjoQS0KnU=;
	h=From:To:Cc:Subject:Date:From;
	b=dnBudIF87Zk0XlRoh50bIABQDMF9/jCZ/XfP8nowN1oyi+UsYaSVHdNCcWmN8KSK3
	 HBLzsgBk3I0+udQoYX0dHJJaQ2Y2VK4CCOi4+aiS/rSD/21EXW3l3pdaUBW+i0XMbI
	 EaziDR7Tv4GeGIJHJepYV5HMNU1KX2SzVpYppZCk=
From: Mark Rutland <mark.rutland@arm.com>
To: stable@vger.kernel.org
Cc: catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	lee@kernel.org,
	mark.rutland@arm.com,
	maz@kernel.org,
	oupton@kernel.org,
	ryan.roberts@arm.com,
	sdonthineni@nvidia.com,
	will@kernel.org
Subject: [PATCH 6.12.y 0/8] arm64: errata: Mitigate TLBI errata on various Arm CPUs
Date: Tue, 16 Jun 2026 06:15:44 +0100
Message-Id: <20260616051552.111675-1-mark.rutland@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:catalin.marinas@arm.com,m:gregkh@linuxfoundation.org,m:lee@kernel.org,m:mark.rutland@arm.com,m:maz@kernel.org,m:oupton@kernel.org,m:ryan.roberts@arm.com,m:sdonthineni@nvidia.com,m:will@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263556-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:dkim,arm.com:mid,arm.com:url,arm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 52B8368C10A

This is a v6.12-only backport of a workaround for a TLB invalidation
issue affecting several CPUs. The final patches landed in mainline
yesterday:

  https://lore.kernel.org/linux-arm-kernel/178157002783.358810.8206806281627742561.pr-tracker-bot@kernel.org/
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=80476f22b8b7e193b26f285a7c9f9e4b63abca16

This issue has been assigned CVE ID CVE-2025-10263, and Arm have
published a security bulletin:

  https://developer.arm.com/documentation/112137/latest/

This backport includes prerequisite patches which were previously sent
on their own (unchanged since that posting):

  https://lore.kernel.org/stable/20260611134024.1700323-1-mark.rutland@arm.com/

I've pushed a copy of this backport to my kernel.org repo:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.12/arm-4118414/backport

Mark.

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

 Documentation/arch/arm64/silicon-errata.rst | 48 ++++++++++++++++
 arch/arm64/Kconfig                          | 50 ++++++++++++++++
 arch/arm64/include/asm/cputype.h            |  6 ++
 arch/arm64/include/asm/tlbflush.h           | 63 ++++++++++++---------
 arch/arm64/kernel/cpu_errata.c              | 34 ++++++++++-
 arch/arm64/kernel/sys_compat.c              |  2 +-
 arch/arm64/kvm/hyp/nvhe/mm.c                |  2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c               |  8 +--
 arch/arm64/kvm/hyp/pgtable.c                |  2 +-
 arch/arm64/kvm/hyp/vhe/tlb.c                | 10 ++--
 10 files changed, 185 insertions(+), 40 deletions(-)

-- 
2.30.2


