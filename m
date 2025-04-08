Return-Path: <stable+bounces-129727-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49715A800E7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D20A118820E6
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68539268683;
	Tue,  8 Apr 2025 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uAmwpuez"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A212288CB;
	Tue,  8 Apr 2025 11:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744111818; cv=none; b=JlI78Mek1WZrajiNXMlXh/afIYg0g8QEer4k5XDHalE7XK0E5317pmJXBdLSWRIeaep6tyjOiMwetpGQIZf7qLkIHV35/SCEk0FyXocZf69JLSVIBs2cVmrj9CU0TSCkkjvSHHmwhA0zgeQA+b+AELS5/qLRFxHRMTR8zwK2MwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744111818; c=relaxed/simple;
	bh=eOssochFnRDAAS6a2lisg66NhYKkVa+QDctpauke+18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcpbgx+eFiDtTb2aFk8s6vjVRR7RPn2EhS3CwuCCoeGs+lNx4rjgFC3mEy5I/psSfcgbpKU9XauVXz0SFg/hHiHn7cKMOvzdolp0viMeL/rXJeFWw3J8o5OVLF1SHyreIkkFZzmg/pkE8MJDhJuI3HCnjHfM8F3pTVGorpzogn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uAmwpuez; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD1BCC4CEE5;
	Tue,  8 Apr 2025 11:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744111818;
	bh=eOssochFnRDAAS6a2lisg66NhYKkVa+QDctpauke+18=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uAmwpuez6pIGnCOV/gaD4cPsGYtLQZ7fZj5PP28N2vfeKITAMm7T8eHB68MPsH7qv
	 2rl0DYZYIt+iaewGI2Y1p/jsJSLfsK2Cjc5bEkiLZTunRtdFjHqVDqNFtkfS1UpNCl
	 lfUgWOo8gLqnSjwJp5WCvEcSa4Zx9THVzdOSR5r4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.14 571/731] sched/smt: Always inline sched_smt_active()
Date: Tue,  8 Apr 2025 12:47:48 +0200
Message-ID: <20250408104927.555428099@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104914.247897328@linuxfoundation.org>
References: <20250408104914.247897328@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Josh Poimboeuf <jpoimboe@kernel.org>

[ Upstream commit 09f37f2d7b21ff35b8b533f9ab8cfad2fe8f72f6 ]

sched_smt_active() can be called from noinstr code, so it should always
be inlined.  The CONFIG_SCHED_SMT version already has __always_inline.
Do the same for its !CONFIG_SCHED_SMT counterpart.

Fixes the following warning:

  vmlinux.o: error: objtool: intel_idle_ibrs+0x13: call to sched_smt_active() leaves .noinstr.text section

Fixes: 321a874a7ef8 ("sched/smt: Expose sched_smt_present static key")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/1d03907b0a247cf7fb5c1d518de378864f603060.1743481539.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/r/202503311434.lyw2Tveh-lkp@intel.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sched/smt.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched/smt.h b/include/linux/sched/smt.h
index fb1e295e7e63e..166b19af956f8 100644
--- a/include/linux/sched/smt.h
+++ b/include/linux/sched/smt.h
@@ -12,7 +12,7 @@ static __always_inline bool sched_smt_active(void)
 	return static_branch_likely(&sched_smt_present);
 }
 #else
-static inline bool sched_smt_active(void) { return false; }
+static __always_inline bool sched_smt_active(void) { return false; }
 #endif
 
 void arch_smt_update(void);
-- 
2.39.5




