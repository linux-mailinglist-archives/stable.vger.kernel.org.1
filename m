Return-Path: <stable+bounces-136389-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6623EA993FA
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 18:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37DBB1BA6603
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 314402980B8;
	Wed, 23 Apr 2025 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lKXTQwNy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BA02949EB;
	Wed, 23 Apr 2025 15:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745422418; cv=none; b=dUtbHCYcrerMlc51gazDvYOXl3onmwq6GGvGHPO+FHQA3f3hM7N6rKxGAKOzburs28QizhVTkO7JKShExIWvn/6l1r1AHanRTFwBylz7YNJlqPF5DfRsFx0xUZ4gUXIohOXdpOe/l3ShKQYY1c/xbE3cgoOMDNF5Pqbad0dLPBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745422418; c=relaxed/simple;
	bh=NKnBSK0j7KZ4lLsO1KrZhakgTnPNgmLeqUyhu/Mh5G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA8cBjDzz79QWKNsv76S6OEdkD183OTYl0xp3XjsuNHJdrQ+WBN4tMbU96VGaENHw0oSMJ7dQltCrMjt38H+9kOX7oYeTAAqxHHfjKHI9K6maYvWcxXktyCxAeBn8GToW6QMPtR8nVa2qaaJULhfgBbdTL6vl0wmpB6DiT8MN5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lKXTQwNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DB1DC4CEE2;
	Wed, 23 Apr 2025 15:33:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745422417;
	bh=NKnBSK0j7KZ4lLsO1KrZhakgTnPNgmLeqUyhu/Mh5G8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lKXTQwNyhn8hlrGpKQaMQUo4K2yk16GVmmgDZdPvz99fzRzdre1LnJVuCdd9+ywRx
	 zGor/uh/Dpyg0/Y2QscwVG18jfD9Rdk0LZPpFwTiAd/4wYuLegRzwT7wowlc8gg7UC
	 9ooEnWOVvPcYrHKwW1+xzVGmywlpcDW2B2bC//1g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 6.6 342/393] perf/x86/intel: Allow to update user space GPRs from PEBS records
Date: Wed, 23 Apr 2025 16:43:58 +0200
Message-ID: <20250423142657.469831837@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dapeng Mi <dapeng1.mi@linux.intel.com>

commit 71dcc11c2cd9e434c34a63154ecadca21c135ddd upstream.

Currently when a user samples user space GPRs (--user-regs option) with
PEBS, the user space GPRs actually always come from software PMI
instead of from PEBS hardware. This leads to the sampled GPRs to
possibly be inaccurate for single PEBS record case because of the
skid between counter overflow and GPRs sampling on PMI.

For the large PEBS case, it is even worse. If user sets the
exclude_kernel attribute, large PEBS would be used to sample user space
GPRs, but since PEBS GPRs group is not really enabled, it leads to all
samples in the large PEBS record to share the same piece of user space
GPRs, like this reproducer shows:

  $ perf record -e branches:pu --user-regs=ip,ax -c 100000 ./foo
  $ perf report -D | grep "AX"

  .... AX    0x000000003a0d4ead
  .... AX    0x000000003a0d4ead
  .... AX    0x000000003a0d4ead
  .... AX    0x000000003a0d4ead
  .... AX    0x000000003a0d4ead
  .... AX    0x000000003a0d4ead
  .... AX    0x000000003a0d4ead
  .... AX    0x000000003a0d4ead
  .... AX    0x000000003a0d4ead
  .... AX    0x000000003a0d4ead
  .... AX    0x000000003a0d4ead

So enable GPRs group for user space GPRs sampling and prioritize reading
GPRs from PEBS. If the PEBS sampled GPRs is not user space GPRs (single
PEBS record case), perf_sample_regs_user() modifies them to user space
GPRs.

[ mingo: Clarified the changelog. ]

Fixes: c22497f5838c ("perf/x86/intel: Support adaptive PEBS v4")
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20250415104135.318169-2-dapeng1.mi@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/events/intel/ds.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1203,8 +1203,10 @@ static u64 pebs_update_adaptive_cfg(stru
 	 * + precise_ip < 2 for the non event IP
 	 * + For RTM TSX weight we need GPRs for the abort code.
 	 */
-	gprs = (sample_type & PERF_SAMPLE_REGS_INTR) &&
-	       (attr->sample_regs_intr & PEBS_GP_REGS);
+	gprs = ((sample_type & PERF_SAMPLE_REGS_INTR) &&
+		(attr->sample_regs_intr & PEBS_GP_REGS)) ||
+	       ((sample_type & PERF_SAMPLE_REGS_USER) &&
+		(attr->sample_regs_user & PEBS_GP_REGS));
 
 	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT_TYPE) &&
 		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
@@ -1856,7 +1858,7 @@ static void setup_pebs_adaptive_sample_d
 			regs->flags &= ~PERF_EFLAGS_EXACT;
 		}
 
-		if (sample_type & PERF_SAMPLE_REGS_INTR)
+		if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
 			adaptive_pebs_save_regs(regs, gprs);
 	}
 



