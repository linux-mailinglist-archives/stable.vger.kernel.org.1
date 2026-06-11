Return-Path: <stable+bounces-262720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OU2dE3K8KmrdvwMAu9opvQ
	(envelope-from <stable+bounces-262720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:47:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 363DC672712
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 15:47:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=QKbJLO1n;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262720-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-262720-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 12E703005316
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 13:47:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8CA2DB7A9;
	Thu, 11 Jun 2026 13:47:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E33A344D8C
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 13:47:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781185640; cv=none; b=M76hcECtCTw7Uq4uUE8c9RMNVWX8sSj1KsdO/cDRwbQb4bExOBr+iBeyTEtUR9CKKuSdDwlA4O4IfOb71AGzerM1DEzJc1gp4gFoWxPB42kpMM6x8dw8e/qvtXgHtlSd3npkh6Gefo1Eh5cGnbdJcZWAbuwmyfLNf+f9H0TLTXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781185640; c=relaxed/simple;
	bh=zlTPSYCkt7DhtIJCcUA3xPW8VmqqJy5pvIc8Fu7VLX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iKq3bdEca6q8d4mGX3PEYkn+CB/XYV9dP0sq3jSBV8XhkU6BNInD2rYi3Hymzcmx41RAbG9y9+eGwXhQ/zEePYCv6snILZ8D78mQTeZ7mGiSjE8DHQpWcJsf5wNx7eOsbskg6IIcrPZh3Sl+GGr32orwr0LZQpMjpxW1IPvGZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QKbJLO1n; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CA0A01E2F;
	Thu, 11 Jun 2026 06:47:13 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CB5E03FAF5;
	Thu, 11 Jun 2026 06:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781185638; bh=zlTPSYCkt7DhtIJCcUA3xPW8VmqqJy5pvIc8Fu7VLX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QKbJLO1nVpeB/Ump5BHwoqCUPznzPW4xiP2f/31zMgrL20rg+Vry7cVNzpSsHV5dQ
	 x8xilGL1eq+/6qGcD/lfdIbsm/kuKBnyjx9aTnHXIQXAwg7GjoHwcVe6kHz5VZo8lo
	 CFUmKv9yki/4PKXtHpAsA2NQjgnEEZIWX30Ofyc4=
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
Subject: [PATCH 5.15.y 2/3] arm64: tlb: Allow XZR argument to TLBI ops
Date: Thu, 11 Jun 2026 14:47:05 +0100
Message-Id: <20260611134706.1700777-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260611134706.1700777-1-mark.rutland@arm.com>
References: <20260611134706.1700777-1-mark.rutland@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
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
	TAGGED_FROM(0.00)[bounces-262720-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 363DC672712

commit bfd9c931d19aa59fb8371d557774fa169b15db9a upstream.

The TLBI instruction accepts XZR as a register argument, and for TLBI
operations with a register argument, there is no functional difference
between using XZR or another GPR which contains zeroes. Operations
without a register argument are encoded as if XZR were used.

Allow the __TLBI_1() macro to use XZR when a register argument is all
zeroes.

Today this only results in a trivial code saving in
__do_compat_cache_op()'s workaround for Neoverse-N1 erratum #1542419. In
subsequent patches this pattern will be used more generally.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Mark: Backport to v5.15.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 412a3b9a3c25d..2626a45849c24 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -37,12 +37,12 @@
 			    : : )
 
 #define __TLBI_1(op, arg) asm (ARM64_ASM_PREAMBLE			       \
-			       "tlbi " #op ", %0\n"			       \
+			       "tlbi " #op ", %x0\n"			       \
 		   ALTERNATIVE("nop\n			nop",		       \
-			       "dsb ish\n		tlbi " #op ", %0",     \
+			       "dsb ish\n		tlbi " #op ", %x0",    \
 			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
 			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
-			    : : "r" (arg))
+			    : : "rZ" (arg))
 
 #define __TLBI_N(op, arg, n, ...) __TLBI_##n(op, arg)
 
-- 
2.30.2


