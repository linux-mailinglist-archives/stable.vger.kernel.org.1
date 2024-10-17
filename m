Return-Path: <stable+bounces-86556-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70A69A1A1D
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 07:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AC7C28459E
	for <lists+stable@lfdr.de>; Thu, 17 Oct 2024 05:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C4313D298;
	Thu, 17 Oct 2024 05:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tzVG7NYW"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEADE21E3C1;
	Thu, 17 Oct 2024 05:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729142426; cv=none; b=G0W4zMbc76IbZ/WnID7rtM7s61hi+JJJSaziNzcvUU/7hHfLKldRY9trzQlL+f0Mq0jqad6Dy/uzaSkojFGo6ypFvj9AC+EXln7okyE9zzF+l2w2+lVZhYPBqq81B4rvhSOh+cWoXuR++AQggo9pe6MdU7y7EQSoy3Zk6iSiS90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729142426; c=relaxed/simple;
	bh=eMNb+2BquZXlS9LDuU8s3n3SpsAQpEY9rgKeU1b8bc4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ev/roiNCwVHqgiPqSY63IIrc1u8SzREApe9aOpjDgdKW2QFkV8Z+q7VmLifTu4+0AyR7RcBt8GQiBNRQb1mqOFv5Sfms53xqjnIl/V1Ztxq1jqkcWM0YKpqIZGRgNy6AK2tJu2La3zFGgLVftFwsHuQRD34aJQkEd/gug58h1HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tzVG7NYW; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729142425; x=1760678425;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mWe2YeZ80uokwCci72Iww2HMukKBNuati+Itectcv9I=;
  b=tzVG7NYWYeUBLBdCL1Nr95uzamv/escFAoXscJ36UGu29DmZ4bvTMV5P
   fmW3nRKUewIpxnUd89hBFqrlxIr6VyIqjVia+glxKY44Bexm08NmhpUXF
   3Mh2LRW2HSJwT+p5i2f1JNzCQhx9flpUaUAslLKAiT23oYktB68eqXqmJ
   k=;
X-IronPort-AV: E=Sophos;i="6.11,210,1725321600"; 
   d="scan'208";a="33914739"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 05:20:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:22077]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id 12569ee5-0466-4090-aa2d-ce74ca440d4c; Thu, 17 Oct 2024 05:20:22 +0000 (UTC)
X-Farcaster-Flow-ID: 12569ee5-0466-4090-aa2d-ce74ca440d4c
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 05:20:22 +0000
Received: from 88665a51a6b2.amazon.com (10.106.178.54) by
 EX19D016UWA004.ant.amazon.com (10.13.139.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 05:20:20 +0000
From: Cristian Prundeanu <cpru@amazon.com>
To: <linux-tip-commits@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, Bjoern Doebel <doebel@amazon.com>,
	Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>, Geoff Blake
	<blakgeof@amazon.com>, Ali Saidi <alisaidi@amazon.com>, Csaba Csoma
	<csabac@amazon.com>, Cristian Prundeanu <cpru@amazon.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 1/2] [tip: sched/core] sched: Disable PLACE_LAG and RUN_TO_PARITY
Date: Thu, 17 Oct 2024 00:19:59 -0500
Message-ID: <20241017052000.99200-2-cpru@amazon.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241017052000.99200-1-cpru@amazon.com>
References: <20241017052000.99200-1-cpru@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA004.ant.amazon.com (10.13.139.7) To
 EX19D016UWA004.ant.amazon.com (10.13.139.119)

With these features are enabled, the EEVDF scheduler introduces a large
performance degradation, observed in multiple database tests on kernel
versions using EEVDF, across multiple architectures (x86, aarch64, amd64)
and CPU generations.
Disable the features to minimize default performance impact.

Cc: <stable@vger.kernel.org> # 6.6.x
Fixes: 86bfbb7ce4f6 ("sched/fair: Add lag based placement")
Fixes: 63304558ba5d ("sched/eevdf: Curb wakeup-preemption")
Signed-off-by: Cristian Prundeanu <cpru@amazon.com>
---
 kernel/sched/features.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index a3d331dd2d8f..8a5ca80665b3 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -4,7 +4,7 @@
  * Using the avg_vruntime, do the right thing and preserve lag across
  * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
  */
-SCHED_FEAT(PLACE_LAG, true)
+SCHED_FEAT(PLACE_LAG, false)
 /*
  * Give new tasks half a slice to ease into the competition.
  */
@@ -17,7 +17,7 @@ SCHED_FEAT(PLACE_REL_DEADLINE, true)
  * Inhibit (wakeup) preemption until the current task has either matched the
  * 0-lag point or until is has exhausted it's slice.
  */
-SCHED_FEAT(RUN_TO_PARITY, true)
+SCHED_FEAT(RUN_TO_PARITY, false)
 /*
  * Allow wakeup of tasks with a shorter slice to cancel RUN_TO_PARITY for
  * current.
-- 
2.40.1


