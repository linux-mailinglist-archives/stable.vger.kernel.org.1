Return-Path: <stable+bounces-220797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDtWLexXo2nW/AQAu9opvQ
	(envelope-from <stable+bounces-220797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:02:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E201C8B81
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 22:02:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 112413282EFE
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A164B40E137;
	Sat, 28 Feb 2026 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m74UPxk0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62DB340E12F;
	Sat, 28 Feb 2026 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300681; cv=none; b=QqK3SbVT0Guc1SnMpmuaCbq3N9oOK8F37qEFSJbNlyVUUg2sJ7uw7ufWQNEVPXL/F5xLVOlJvuiknl8pt31XEqQUmmoQiRGD8ZZLGIG4KzYEjHLhGFF50n9gYSbhdPZDUn7MoMrHhW5yJBntt2epBz47mqkGXtaituj0uGssbIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300681; c=relaxed/simple;
	bh=5KGWVuGG68irXfHboGwSA+TrY5NyBPFImHEJnw5iMWA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V92OssgG7GbpMhfx4m1IIBlbHGLP+zDxGXuCs8QaRVNNIwKJlfFVHuWTBP4mVFsOsrilbPS/AyZnB/kzGeam62+oT24uMPttfyy/4OnJkaJFRByEqaGUD2ucq5DXAtSSBw7b59+0IEC/WrWCJplQrHGyQ/8pRZSKoXUOYSfyuhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m74UPxk0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618C8C19423;
	Sat, 28 Feb 2026 17:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300681;
	bh=5KGWVuGG68irXfHboGwSA+TrY5NyBPFImHEJnw5iMWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m74UPxk0xjuLqtd5gdNtnJBqQ1XDvEyXry0Mj+S2RQ8JmakVqMlNjay9h4RCSBuBL
	 LGho2fz1fNBT6JR6ZHIW/4vR3ugw4tnzL9X5B7Ow+DZY+B26+RAort/eRf6qPoHNCL
	 /hO/zsayv1K+L8GPA/mPOXKIX6Un2ba8iUhbBoWBGMqk0Z+pjujk4glDrr0tbEzDi+
	 P3ZgzQq1/vcoyJAG/5OqVVGar7xQzVRdMwygu0ukEjJ7MnrWNyvO7Xv3dqGOKFY5Lq
	 LgWS46E/hszbH3eLVu/+TyEdYccQIBf0naAcUFNkCRG4+r6e60aFafcGpsbMnQ+vyQ
	 iblaSkAgbT5/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 718/844] compiler-clang.h: require LLVM 19.1.0 or higher for __typeof_unqual__
Date: Sat, 28 Feb 2026 12:30:31 -0500
Message-ID: <20260228173244.1509663-719-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,linux-foundation.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220797-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux-foundation.org:email]
X-Rspamd-Queue-Id: 15E201C8B81
X-Rspamd-Action: no action

From: Nathan Chancellor <nathan@kernel.org>

[ Upstream commit e8d899d301346a5591c9d1af06c3c9b3501cf84b ]

When building the kernel using a version of LLVM between llvmorg-19-init
(the first commit of the LLVM 19 development cycle) and the change in
LLVM that actually added __typeof_unqual__ for all C modes [1], which
might happen during a bisect of LLVM, there is a build failure:

  In file included from arch/x86/kernel/asm-offsets.c:9:
  In file included from include/linux/crypto.h:15:
  In file included from include/linux/completion.h:12:
  In file included from include/linux/swait.h:7:
  In file included from include/linux/spinlock.h:56:
  In file included from include/linux/preempt.h:79:
  arch/x86/include/asm/preempt.h:61:2: error: call to undeclared function '__typeof_unqual__'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
     61 |         raw_cpu_and_4(__preempt_count, ~PREEMPT_NEED_RESCHED);
        |         ^
  arch/x86/include/asm/percpu.h:478:36: note: expanded from macro 'raw_cpu_and_4'
    478 | #define raw_cpu_and_4(pcp, val)                         percpu_binary_op(4, , "and", (pcp), val)
        |                                                         ^
  arch/x86/include/asm/percpu.h:210:3: note: expanded from macro 'percpu_binary_op'
    210 |                 TYPEOF_UNQUAL(_var) pto_tmp__;                          \
        |                 ^
  include/linux/compiler.h:248:29: note: expanded from macro 'TYPEOF_UNQUAL'
    248 | # define TYPEOF_UNQUAL(exp) __typeof_unqual__(exp)
        |                             ^

The current logic of CC_HAS_TYPEOF_UNQUAL just checks for a major
version of 19 but half of the 19 development cycle did not have support
for __typeof_unqual__.

Harden the logic of CC_HAS_TYPEOF_UNQUAL to avoid this error by only
using __typeof_unqual__ with a released version of LLVM 19, which is
greater than or equal to 19.1.0 with LLVM's versioning scheme that
matches GCC's [2].

Link: https://github.com/llvm/llvm-project/commit/cc308f60d41744b5920ec2e2e5b25e1273c8704b [1]
Link: https://github.com/llvm/llvm-project/commit/4532617ae420056bf32f6403dde07fb99d276a49 [2]
Link: https://lkml.kernel.org/r/20260116-require-llvm-19-1-for-typeof_unqual-v1-1-3b9a4a4b212b@kernel.org
Fixes: ac053946f5c4 ("compiler.h: introduce TYPEOF_UNQUAL() macro")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Cc: Bill Wendling <morbo@google.com>
Cc: Justin Stitt <justinstitt@google.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/compiler-clang.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 7edf1a07b5350..e1123dd284862 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -153,4 +153,4 @@
  * Bindgen uses LLVM even if our C compiler is GCC, so we cannot
  * rely on the auto-detected CONFIG_CC_HAS_TYPEOF_UNQUAL.
  */
-#define CC_HAS_TYPEOF_UNQUAL (__clang_major__ >= 19)
+#define CC_HAS_TYPEOF_UNQUAL (__clang_major__ > 19 || (__clang_major__ == 19 && __clang_minor__ > 0))
-- 
2.51.0


