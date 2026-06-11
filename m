Return-Path: <stable+bounces-262709-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w2bHFaS7KmqzvwMAu9opvQ
	(envelope-from <stable+bounces-262709-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:44:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C69946726A2
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:44:03 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=aQb36LSy;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262709-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262709-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CC239309D102
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 13:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4FC3F788A;
	Thu, 11 Jun 2026 13:42:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A158130C158
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 13:42:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185379; cv=none; b=DxG3RIHYoA0WT5tO1oOFKecDeYLPi/82lYB5icEqog1xDy5oFBvQvdR1pyYUu4Xm9Qf+EZhzOVQbGXs2PLh0bYlxbk4HQPc0zwHSzQtO76bpPirJQjBYR/XScbEftdmOzKTJ8g/IvcZngAm29HRqqRQC1fTFkAh2oWC+693MS6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185379; c=relaxed/simple;
	bh=qYopb4hIwF340W9FD7UKVqpxzWbwQPH5UqqJAHzjrh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pIrWncDSMHoASfuaAgrYUG4E/Xp51Z6VLRyl3EGFzwiD60WJW/JlomyWgcmQYoQEV/l8WsJjbrkzkIyTsKvhbX0WBnft1DqsSoAki3n2wjImwgoJsajvsNNG8Ap6Ux/I9JoRdVxFlEWJyRAAOOErKC+4WxU4GXYLx931ezkzlOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aQb36LSy; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A2EF1DB5;
	Thu, 11 Jun 2026 06:42:52 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 4CE973FAF5;
	Thu, 11 Jun 2026 06:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781185377; bh=qYopb4hIwF340W9FD7UKVqpxzWbwQPH5UqqJAHzjrh4=;
	h=From:To:Cc:Subject:Date:From;
	b=aQb36LSyq3z4qsxYa5r8eonClhg+ZPXLhQbQtu/ZYfKLfpgjGr0PwqMoHbbv1oSfT
	 zkIsEzwPNUZe62c4koc0Xe18tmnJVnuSzI3UqfDZ9zCAU8K8j6TY4v3Sv457ZeZGVk
	 b2TGMgPJ0uhl5AXs7IBJqihMN0pwX/+eRjNDWii0=
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
	will@kernel.org,
	yuzenghui@huawei.com
Subject: [PATCH 6.6.y 0/3] arm64: tlb: Prerequisites for TLBI erratum workaround
Date: Thu, 11 Jun 2026 14:42:45 +0100
Message-Id: <20260611134248.1700496-1-mark.rutland@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:anshuman.khandual@arm.com,m:catalin.marinas@arm.com,m:gregkh@linuxfoundation.org,m:lee@kernel.org,m:mark.rutland@arm.com,m:maz@kernel.org,m:oupton@kernel.org,m:ryan.roberts@arm.com,m:will@kernel.org,m:yuzenghui@huawei.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[mark.rutland@arm.com,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-262709-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:dkim,arm.com:mid,arm.com:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C69946726A2

This is a v6.6.y-only backport of updates to arm64's
ARM64_WORKAROUND_REPEAT_TLBI erratum workaround, which have been
upstream since v7.0 and have already been backported to v6.18.y. These
are prerequisites for patches to enable the workaround for many more
CPUs, which are queued in the arm64 tree targetting v7.2-rc1:

  https://lore.kernel.org/linux-arm-kernel/20260609101203.1512409-1-mark.rutland@arm.com/
  https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/errata

I'm sending backports of these ahead of backports of the
not-yet-upstream portion as these have the key logic changes and I'm
hoping they could be queued early and see more testing. On their own
they serve as an optimization to existing users of the workaround.

I've pushed this series to my stable-6.6/arm-4118414/prerequisites
branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.6/arm-4118414/prerequisites

I've pushed a v6.6.y backport of all the not yet upstream patches to my
stable-6.6/arm-4118414/backport branch:

  https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/log/?h=stable-6.6/arm-4118414/backport

... and once those are merged into mainline I will submit stable
backports.

Mark.


Marc Zyngier (1):
  KVM: arm64: Remove VPIPT I-cache handling

Mark Rutland (2):
  arm64: tlb: Allow XZR argument to TLBI ops
  arm64: tlb: Optimize ARM64_WORKAROUND_REPEAT_TLBI

 arch/arm64/include/asm/kvm_mmu.h  |  5 +--
 arch/arm64/include/asm/tlbflush.h | 64 ++++++++++++++++------------
 arch/arm64/kernel/sys_compat.c    |  2 +-
 arch/arm64/kvm/hyp/nvhe/mm.c      |  2 +-
 arch/arm64/kvm/hyp/nvhe/pkvm.c    |  2 +-
 arch/arm64/kvm/hyp/nvhe/tlb.c     | 69 ++-----------------------------
 arch/arm64/kvm/hyp/pgtable.c      |  2 +-
 arch/arm64/kvm/hyp/vhe/tlb.c      | 21 ++--------
 8 files changed, 51 insertions(+), 116 deletions(-)

-- 
2.30.2


