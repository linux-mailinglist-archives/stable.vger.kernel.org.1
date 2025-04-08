Return-Path: <stable+bounces-131270-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44321A80912
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF6D4E4368
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A3A9270EDF;
	Tue,  8 Apr 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kbc1OKKu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154C726656B;
	Tue,  8 Apr 2025 12:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744115944; cv=none; b=MhHA1WGRKV025xYEGJmvGH+180dnjJu/s5YWVGIjBielhiwNH789ugSHVPWUsnxv2QdDHzDHjuXTnihhfR2QD9FILmrAkEQAVvlmdq57GKMVep94a8JlQEZvc73aBi3Gq1A/etTXhuAhIZgy2AWX3XHeDJKV+P0yLs7nQCGuTxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744115944; c=relaxed/simple;
	bh=wAbZ76frId97KDSqg0QFixHKmdodtci6Tpxf05Xl1CI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eUYN3/K8PeAih0RRygeuwvjVeGt5/voKNmLOn+DDlBKT+XQGWppOo9c1pnv8AbC0rq+0apPc5mGduc7edBb57jdq4wo99A/XPqE7ZU+IGvgSup7NR9h6JEnWl/3J6M85iJEJC31MixkWVqr6oyyQmqGZ/bxq/DqnT+abdCi0U40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kbc1OKKu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9981BC4CEE5;
	Tue,  8 Apr 2025 12:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744115944;
	bh=wAbZ76frId97KDSqg0QFixHKmdodtci6Tpxf05Xl1CI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kbc1OKKuD1vdD4GkH+YjWClYY9R0w3OMkzhhGvrGwM0COvIXJ1V/MF68NDic6By95
	 ygq4Y9NJeJLGIpRrqw8B9T8CczrqBRIKLCZtmHULO9g+lnckFbALHHTYJ/psZcVEka
	 MCq0nDVPFyo4TcvmyU86Plg5d/GqMB5M90F6T9Bc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 123/204] sched/smt: Always inline sched_smt_active()
Date: Tue,  8 Apr 2025 12:50:53 +0200
Message-ID: <20250408104823.921017399@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104820.266892317@linuxfoundation.org>
References: <20250408104820.266892317@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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
index 59d3736c454cf..737b50f40137b 100644
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




