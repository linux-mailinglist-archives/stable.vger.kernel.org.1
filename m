Return-Path: <stable+bounces-263567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id az7qIbrcMGo/YAUAu9opvQ
	(envelope-from <stable+bounces-263567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:18:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB2A68C14F
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 07:18:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=arm.com header.s=foss header.b=W6E7IUwU;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263567-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263567-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=arm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 456AA30221EC
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 05:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1D33CF049;
	Tue, 16 Jun 2026 05:18:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1593CD8A8
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:18:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781587120; cv=none; b=qDRmMAN4/3KIMFRQ9zE2DasxNLPDA0EZMXdUve3skJmKujDr65jFldFoAO37wMHNH/HW4x8jxLKC2ijU4QkOc/NmBB/7H6F1rpyTwxlrraAihFSz8QBLjjOv6Rhovwv19QBPkQmft260J/amuIZlZe9sPJ8R/S3WJK/qwKPW4jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781587120; c=relaxed/simple;
	bh=yYHz1hGOEbCQ+UwlRrvt7fCrYPbherByy7lUqpuuue8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ERzvmheBx6drpidJQH6sUkN+JkeGZtUZrqDlmWzVbAPe+DzElXkUdDOuxoQrbYj/zp/Gvikp9R+gj7cyivQQgax7Cbk+tb5xjRUfNID81LyGtqRGJfuFBZG2v7sxhMQHzF0yTftGYSzQZ3KJGgOX4SQcwBbVlQ8GE+AJfGrEQfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=W6E7IUwU; arc=none smtp.client-ip=217.140.110.172
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6E3CE3D9B;
	Mon, 15 Jun 2026 22:18:33 -0700 (PDT)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 642803F763;
	Mon, 15 Jun 2026 22:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781587118; bh=yYHz1hGOEbCQ+UwlRrvt7fCrYPbherByy7lUqpuuue8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W6E7IUwUple5MbfGUMxUwA+5W2ivkCV0QB1/3Z5SC/V6z88toiH1xFPku0qXEklxE
	 hqowP4RvFGJjzsNsc0VK54VjUQ67qM0vRhZoKr1d+dCO0jXMdGQzAtMSGys3Ug7g4s
	 Ns9kzvMdldyvewtB+MVNblRJ6WKfC837UM3eEOu8=
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
Subject: [PATCH 6.6.y 2/9] arm64: tlb: Allow XZR argument to TLBI ops
Date: Tue, 16 Jun 2026 06:18:15 +0100
Message-Id: <20260616051822.111870-3-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20260616051822.111870-1-mark.rutland@arm.com>
References: <20260616051822.111870-1-mark.rutland@arm.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	TAGGED_FROM(0.00)[bounces-263567-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,arm.com:dkim,arm.com:email,arm.com:mid,arm.com:from_mime,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EAB2A68C14F

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
[Mark: Backport to v6.6.y]
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/tlbflush.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
index 6eeb56b6fac13..c8d8b9622369f 100644
--- a/arch/arm64/include/asm/tlbflush.h
+++ b/arch/arm64/include/asm/tlbflush.h
@@ -38,12 +38,12 @@
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


