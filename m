Return-Path: <stable+bounces-240108-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Jb2BzlM52lW6QEAu9opvQ
	(envelope-from <stable+bounces-240108-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:06:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DDE439516
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 12:06:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B035A3051D39
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 10:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EF03B0AE1;
	Tue, 21 Apr 2026 10:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XFxvG5To"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D5838F226
	for <stable@vger.kernel.org>; Tue, 21 Apr 2026 10:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776765626; cv=none; b=byhrgL6SlWPjdVc6O63fDuqRVrXnknxUEDfD8QUZrh4QVkezrUiak1ydv9vMIN1YyL5ue3f+rFOmTQMEOJXkgS12k6IQxKS5GFTvJU6iWmhR0P/T5sK2FGLOYk/Hagxh7dSkCrKiMegxcjyiMDsUO7RMHBtQszLLejX/gxoj834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776765626; c=relaxed/simple;
	bh=/8RmMYmmwNGvGVhnupL/glGhwB2u023lC29k8r4ek9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TdsihjOCaDOK/xIfUbhXaFkXEMmT9HPm+hk0aNC6iatOi1pCCXcnulBh+BwNMCn/nZfhNCqs5E5gXjlzrvG/sonRS2x2Tlb30KNYhV+itnQzUnCap+69dqMZSZ+sexuRRLk/CSftXhAudprwwgTKlQjAaElUmcLzpBYo95R9gOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XFxvG5To; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 737C825E4;
	Tue, 21 Apr 2026 03:00:18 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.57.89.2])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3EFAC3FBCB;
	Tue, 21 Apr 2026 03:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776765624; bh=/8RmMYmmwNGvGVhnupL/glGhwB2u023lC29k8r4ek9k=;
	h=From:To:Cc:Subject:Date:From;
	b=XFxvG5ToWnTtlw+Z4Xr+lHHH7itSBWAaA62sUcsSt03kEafsTV4eQIM3mZtxvdOYi
	 dgjKtcFyffdmGWCKigmIe5RZw6GHrUXCROZAOFrSCezcpjWQ8haGTg96HEWZTdXyII
	 iTZA52g6ydTyLvfk78rzYKQwMhsgUJeLoHH+xu8w=
From: Catalin Marinas <catalin.marinas@arm.com>
To: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 6.18.y 0/6] arm64: Stable backport of the C1-Pro erratum 4193714 workaround
Date: Tue, 21 Apr 2026 11:00:11 +0100
Message-ID: <20260421100018.335793-1-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240108-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[catalin.marinas@arm.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[arm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: 59DDE439516
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg, Sasha,

As the workaround for this CPU bug just went in, I'm sending it for
stable 6.18. The first two patches are prerequisites to make the
backporting easier. I do not intend to send them for stable 6.12 since
SME is not supported in that version anyway (Android folk did their own
backports already).

A heads-up, the workaround itself is larger than the recommended max 100
lines suitability for stable backports.

Thanks.

Catalin Marinas (4):
  arm64: tlb: Introduce __tlbi_sync_s1ish_{kernel,batch}() for TLB
    maintenance
  arm64: tlb: Pass the corresponding mm to __tlbi_sync_s1ish()
  arm64: cputype: Add C1-Pro definitions
  arm64: errata: Work around early CME DVMSync acknowledgement

Mark Rutland (2):
  arm64: tlb: Allow XZR argument to TLBI ops
  arm64: tlb: Optimize ARM64_WORKAROUND_REPEAT_TLBI

 Documentation/arch/arm64/silicon-errata.rst |   2 +
 arch/arm64/Kconfig                          |  12 ++
 arch/arm64/include/asm/cpucaps.h            |   2 +
 arch/arm64/include/asm/cputype.h            |   2 +
 arch/arm64/include/asm/fpsimd.h             |  21 +++
 arch/arm64/include/asm/tlbbatch.h           |  10 +-
 arch/arm64/include/asm/tlbflush.h           | 143 ++++++++++++++++----
 arch/arm64/kernel/cpu_errata.c              |  30 ++++
 arch/arm64/kernel/entry-common.c            |   3 +
 arch/arm64/kernel/fpsimd.c                  |  79 +++++++++++
 arch/arm64/kernel/process.c                 |  36 +++++
 arch/arm64/kernel/sys_compat.c              |   2 +-
 arch/arm64/kvm/hyp/nvhe/mm.c                |   2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c               |   8 +-
 arch/arm64/kvm/hyp/pgtable.c                |   2 +-
 arch/arm64/kvm/hyp/vhe/tlb.c                |  10 +-
 arch/arm64/tools/cpucaps                    |   1 +
 17 files changed, 325 insertions(+), 40 deletions(-)


