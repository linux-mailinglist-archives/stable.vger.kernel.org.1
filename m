Return-Path: <stable+bounces-83058-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B6D9953E1
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 17:59:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B16A286F67
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E962D3BBDE;
	Tue,  8 Oct 2024 15:59:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF271E0B68
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728403140; cv=none; b=c5nDQPkfKbAr8aWTkUbTwIfbBJb/FBpPH32XVoegKbYP4GLqURAeE/bh4gepldPl+TsVcn+8ZwS7EaM/yQrhDJJP4zfopBBhiqtwXQU+WK+rXKHoLs5E0lpjoTAoz8omhgMfBn0FFy6+ID0DNlHl4WaqTZWeFV+1ddZOYO0Vq+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728403140; c=relaxed/simple;
	bh=DhnlNXBkjc8b/3gJoE/oApypT6XPA9bkuPL/Qd/sIOk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sXv4qCiG89m9WuhWjhs4y78TK6lEQHGr4vXlTKqQODTOIugLfBSp8PuuF45WE2k9sCcOuxTAe9668rgoCZGljjfgHZQUroan0M6txu7JzgzL1pVcVPIswi923h41+ozT2NFkgkdDNkk1djjVyzU3XGGVRTcnWbDmdVIJy/m13ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D006ADA7;
	Tue,  8 Oct 2024 08:59:27 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 3B4723F73F;
	Tue,  8 Oct 2024 08:58:57 -0700 (PDT)
From: Mark Rutland <mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: catalin.marinas@arm.com,
	catalin.marnias@arm.com,
	mark.rutland@arm.com,
	stable@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 0/6] arm64: probes: fixes and cleanup
Date: Tue,  8 Oct 2024 16:58:45 +0100
Message-Id: <20241008155851.801546-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches address some issues I spotted while looking at kprobes and
uprobes.

Patch 1 is the most pressing, as a uprobes user can trigger a kernel
BUG(). Patches 2 and 3 fix latent endianness bugs which only manifest on
big-endian kernels, and patchs 4-6 clean things up so that it's harder
to get this wrong again in future.

Mark.

Mark Rutland (6):
  arm64: probes: Remove broken LDR (literal) uprobe support
  arm64: probes: Fix simulate_ldr*_literal()
  arm64: probes: Fix uprobes for big-endian kernels
  arm64: probes: Move kprobes-specific fields
  arm64: probes: Cleanup kprobes endianness conversions
  arm64: probes: Remove probe_opcode_t

 arch/arm64/include/asm/probes.h          | 11 +++----
 arch/arm64/include/asm/uprobes.h         |  8 ++---
 arch/arm64/kernel/probes/decode-insn.c   | 22 ++++++++-----
 arch/arm64/kernel/probes/decode-insn.h   |  2 +-
 arch/arm64/kernel/probes/kprobes.c       | 39 ++++++++++++------------
 arch/arm64/kernel/probes/simulate-insn.c | 18 +++++------
 arch/arm64/kernel/probes/uprobes.c       |  8 ++---
 7 files changed, 53 insertions(+), 55 deletions(-)

-- 
2.30.2


