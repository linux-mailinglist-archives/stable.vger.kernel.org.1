Return-Path: <stable+bounces-133096-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C0DA91D36
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 15:03:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 207B53AF4A3
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 13:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5DCF24E4A1;
	Thu, 17 Apr 2025 13:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TgyYH8bU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xe3W54XR"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F2524DFE8;
	Thu, 17 Apr 2025 13:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894902; cv=none; b=tIA0RVieIDr7kud7waqSa5X7Z5gLHX228/z1Ze5z5rO4/coyyVlU9pSpcJIdWefHgwN6KKlSP2buyaOQvRfJ7AkqUGg54+4QywnTkW0FUXHBI2cHYAZoHa5R7dcF2fbLjIfyywkdo3IUGA8svI3vSWu71RPoRVUMznP0FZfDQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894902; c=relaxed/simple;
	bh=zMwXesIrrYUaxnfmuve6eO/ifbyuRdJeos7XvzZjbGw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B6eZeNq0zAHjWyzD4oY0sG+sqzIHV8oH4N3s7buGxIvI8picTZPrJDmSqKP0G2nXX+nnY/rOQzgImRPSLXBzDraKHk/GNzInD/tiedPNNJ8wjADesDlKFnuWZ6KVySpVzJRHra8FWkwQxwcEyswm9a0db9dyDUqnS5+otfwUY7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TgyYH8bU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xe3W54XR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 13:01:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744894899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoxKRkUoYCu2TYBYxCJ2tFQSEVpOthLNZDIydkHQRJ8=;
	b=TgyYH8bUAiklCzbcc74jSl/m2A618ajBIV9GN9YAaM/v8nJ+UfjhlEI65pLGrlnIOp7Y3z
	epv/TB4XA6CXBW0CD6mOWSPSNUB4jd0aaP9RjxtfH5L5sil/7oX8s88ax4lpOWYuyUKSog
	yIhzg7rYk27r1CwwcekziIvmO8Ohc6ssFx3i3zERPPGEIT42N24LdyUEEpnFXKTeTG8ckR
	RCjJOA9XrSaJ3rwEhT9h2c8V6VNTtkw4KaeImX4IDvQ29ZsOZ3GylLtJ7Q7YZuONOeaL5X
	QLZa5ydvlOtzUiu3k7+JQkXNor3EmlGcvr6JrJ3QQ2PXICeYWoCexhDC8x7IOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744894899;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KoxKRkUoYCu2TYBYxCJ2tFQSEVpOthLNZDIydkHQRJ8=;
	b=Xe3W54XRpGKPb/xyWJn3BJN/iyDaz8cthOk0GFtRsu3icriMvMAWXMI5B7UUcYVKbsnRFK
	sgcgnoObkCyJdaDw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Allow to update user space GPRs from
 PEBS records
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250415104135.318169-2-dapeng1.mi@linux.intel.com>
References: <20250415104135.318169-2-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174489489799.31282.1186680851817307547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     71dcc11c2cd9e434c34a63154ecadca21c135ddd
Gitweb:        https://git.kernel.org/tip/71dcc11c2cd9e434c34a63154ecadca21c135ddd
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Tue, 15 Apr 2025 10:41:35 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 14:19:38 +02:00

perf/x86/intel: Allow to update user space GPRs from PEBS records

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
---
 arch/x86/events/intel/ds.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1f7e1a6..18c3ab5 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1399,8 +1399,10 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
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
@@ -2123,7 +2125,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 			regs->flags &= ~PERF_EFLAGS_EXACT;
 		}
 
-		if (sample_type & PERF_SAMPLE_REGS_INTR)
+		if (sample_type & (PERF_SAMPLE_REGS_INTR | PERF_SAMPLE_REGS_USER))
 			adaptive_pebs_save_regs(regs, gprs);
 	}
 

