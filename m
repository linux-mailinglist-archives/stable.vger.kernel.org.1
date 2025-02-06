Return-Path: <stable+bounces-114039-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0653A2A250
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 08:32:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10C3A3A8608
	for <lists+stable@lfdr.de>; Thu,  6 Feb 2025 07:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676ED22688C;
	Thu,  6 Feb 2025 07:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y/WYexoL"
X-Original-To: stable@vger.kernel.org
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFB022654C
	for <stable@vger.kernel.org>; Thu,  6 Feb 2025 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738826664; cv=none; b=T1RVClU283mVVfUXOdjSFV8Td+58Sz3W98IkpJ5qhgHTH/7atTsPNy+omuCEAdx++obo8ab0mHWfCaansQH/Pl3fBpcfoeMxYXwY4wIW4eRUKmFYCUa0VNQEVYyevZViN7j2A8CsT6iZ4V9f5U7tsIukar2OT5FTA6i56Op/VXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738826664; c=relaxed/simple;
	bh=g8KfvhuWCpFMJ5MwLkydHvuFRhofLM17eTPAyIJQ0Vc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gKS1GAQz2DmQMLjbk4s8f6uqv4CsxBTJhcQ0C8hF7I47zHlLKNvLu0s5ILksR5+8nMdcSCinyB7KGHtaPWDnjRnqxGYxkm081bWxpIhIq0PVcIT/zjdGMfNp78nNjIJl2VnB+WEa8vMz5MSm/7ufi21wSEWGP/2D6XBPQvuGxEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y/WYexoL; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1738826652; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=osBs3jQs68YhRSnmeBmzf+//GuKwTQHRQSYRlL6Tj1s=;
	b=Y/WYexoLFEN53N/3vA7dPIwUrTqMeV+GsY2Dx5eppz8v/kUuS9HzKKJblo27iByFGcWHjZvTkvAJN2dbff0/8kcAWOeSCnpb2EtE1v2DExR8+PpVPvHosDv3J+F+NVPeRnJSzfHlyp8WSzZ5pQiF5QYvt5Yu7GOepvJNqLHkajA=
Received: from x31l07245.sqa.na131.tbsite.net(mailfrom:yixingrui@linux.alibaba.com fp:SMTPD_---0WOvTW-D_1738826648 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Feb 2025 15:24:11 +0800
From: Xingrui Yi <yixingrui@linux.alibaba.com>
To: tglx@linutronix.de,
	rostedt@goodmis.org
Cc: stable@vger.kernel.org,
	Xingrui Yi <yixingrui@linux.alibaba.com>
Subject: [PATCH 5.10.y] profile: Fix use after free in profile_tick()
Date: Thu,  6 Feb 2025 15:24:06 +0800
Message-ID: <20250206072406.975315-1-yixingrui@linux.alibaba.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[free]
profiling_store()
  --> profile_init()
    --> free_cpumask_var(prof_cpu_mask)                           <-- freed

[use]
tick_sched_timer()
  --> profile_tick()
    --> cpumask_available(prof_cpu_mask)                          <-- prof_cpu_mask is not NULL
                                                                      if cpumask offstack
      --> cpumask_test_cpu(smp_processor_id(), prof_cpu_mask)     <-- use after free

When profile_init() failed if prof_buffer is not allocated,
prof_cpu_mask will be kfreed by free_cpumask_var() but not set
to NULL when CONFIG_CPUMASK_OFFSTACK=y, thus profile_tick() will
use prof_cpu_mask after free.

Signed-off-by: Xingrui Yi <yixingrui@linux.alibaba.com>
---
 kernel/profile.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/profile.c b/kernel/profile.c
index 0db1122855c0..b5e85193cb02 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -137,6 +137,9 @@ int __ref profile_init(void)
 		return 0;
 
 	free_cpumask_var(prof_cpu_mask);
+#ifdef CONFIG_CPUMASK_OFFSTACK
+	prof_cpu_mask = NULL;
+#endif
 	return -ENOMEM;
 }
 
-- 
2.43.5


