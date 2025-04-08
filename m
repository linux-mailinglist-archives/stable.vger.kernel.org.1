Return-Path: <stable+bounces-131563-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC4C2A80B23
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 15:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8173C504C07
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B387276043;
	Tue,  8 Apr 2025 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="q3/R38Jt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DE326AAA3;
	Tue,  8 Apr 2025 12:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116734; cv=none; b=U6fyCY3JQD5gOYbDqDrqFqh905HiKF8vB7RRWMVIWljjIteCgoLaSfYwYJRPhmgPyhDgAlEbKX+rZFPozM6UYVADR7h5kfmdEaMf3WoYhEF6PH23O5ziTDKneOzkJjNJ06Tbp/rgg/H+Yz4Tvy9WawGBdi5WP7NYwcpOHRpUvbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116734; c=relaxed/simple;
	bh=1C/jG3Em0pshN4/8IQFK8XbmI+zHQv5n3ZAvi0X1/kg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fbafSrJFPUPSnFGyyM8IEAODPd/shT9TrptsFGuFtTrwkSW8PGidJ42P/hqGPjct/FWcqVV9Xip4XGFQlEDQvls8czjo0SeCe+Vap3gHcoSMH8fvQzcWGFOHgXhwGwXfAAdSpUujqyNbmUkBSz+3+nsxU2M0KanhTN9DxedlWMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=q3/R38Jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EA4C4CEE7;
	Tue,  8 Apr 2025 12:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116734;
	bh=1C/jG3Em0pshN4/8IQFK8XbmI+zHQv5n3ZAvi0X1/kg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q3/R38JtfMzBaJ1RUlyjy3J6J6B5txBxteyqUtJ4fxtw2Cu88tPgmISdrC1dMF1zk
	 8pCnPP4HJ1erttnorgC5GGXHkKPMTzCnHlXXnRFcaasHwQ9o1afMuCUdkkI4rypMmw
	 MhJxhUyyZpkrZ25oj6dB9/Opj6D66Rqni1bvgka4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 248/423] sched/smt: Always inline sched_smt_active()
Date: Tue,  8 Apr 2025 12:49:34 +0200
Message-ID: <20250408104851.510116152@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

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




