Return-Path: <stable+bounces-106631-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBADB9FF4C7
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 19:59:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B32D218820BC
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 18:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F611E260A;
	Wed,  1 Jan 2025 18:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DcWSbZFn"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF4214F9C4
	for <stable@vger.kernel.org>; Wed,  1 Jan 2025 18:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735757949; cv=none; b=W4/3nkyA6n+PPkwupfK4bLgR0thwVcO9Q4GOahBlzVrE/QbXtbe8PD28s6wCnlqkxO/GJJNMw+7Xqq34dLx4p1cfxjheRc70pfm2jdjwAFeamNZBjuqmITwsx95exbB2ngZ59ScRY5Edgf8BBw8rZPcIQgWR7O6NoqeWE8t2d0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735757949; c=relaxed/simple;
	bh=hGlCrdyFUF433ifSGsYrvmsc+0ABCY5Bd9DWM8Ui9e8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q3/URoRjgx5BgE5c0do4WpGKjXT/Ci+VPsBJ/5vkzRrWGcXK5Hgm3HdJw5wPo2lHqM/Ib/50rR9Ko1Vb1HLhl+7SMxAeZQ9uR5MR/0+XiXZ3jWgo9XZbON2DUn08Tzp8dyeezOLFff4ji/Rdvc8ZnoqKlQuxqPhumDxgB43Gi2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DcWSbZFn; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735757948; x=1767293948;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tSCf1vqTZy5T4uG3mHMhQF6YNwxBn5hUVnGrzvpbKLI=;
  b=DcWSbZFn5UKecFkGDc0+/sD6pUM+DlnUmgDGnFkHi79Ei9+11RccjrAG
   WgAAPrHkP2UAgX49l3A1yA4qS8eZuFlPeiQCCX1RSMA/0Xkk0bDMG6A8N
   1/RtC7WobDZBWp3JIbCT3T3PDhpxYmCPYmp9r56LYyGeAHms/9UOkFnh3
   o=;
X-IronPort-AV: E=Sophos;i="6.12,283,1728950400"; 
   d="scan'208,223";a="455757427"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2025 18:59:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:36989]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.75:2525] with esmtp (Farcaster)
 id 8b08c66a-a5d3-446d-a5b6-99e8a3da8069; Wed, 1 Jan 2025 18:59:04 +0000 (UTC)
X-Farcaster-Flow-ID: 8b08c66a-a5d3-446d-a5b6-99e8a3da8069
Received: from EX19D003ANC003.ant.amazon.com (10.37.240.197) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 1 Jan 2025 18:59:00 +0000
Received: from b0be8375a521.amazon.com (10.119.15.26) by
 EX19D003ANC003.ant.amazon.com (10.37.240.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 1 Jan 2025 18:58:58 +0000
From: Kohei Enju <enjuk@amazon.com>
To: Kohei Enju <enjuk@amazon.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH v1] ftrace: Fix function profiler's filtering functionality
Date: Thu, 2 Jan 2025 03:58:45 +0900
Message-ID: <20250101185845.68814-1-enjuk@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWA001.ant.amazon.com (10.13.139.92) To
 EX19D003ANC003.ant.amazon.com (10.37.240.197)

From commit c132be2c4fcc ("function_graph: Have the instances use their own
 ftrace_ops for filtering"), function profiler (enabled via function_profil
e_enabled) has been showing statistics for all functions, ignoring set_ftra
ce_filter settings.

While tracers are instantiated, the function profiler is not. Therefore, it
 should use the global set_ftrace_filter for consistency.
This patch modifies the function profiler to use the global filter, fixing
the filtering functionality.

Before (filtering not working):
```
  Function                               Hit    Time            Avg
     s^2
  --------                               ---    ----            ---
     ---
  schedule                               314    22290594 us     70989.15 us
     40372231 us
  x64_sys_call                          1527    8762510 us      5738.382 us
     3414354 us
  schedule_hrtimeout_range               176    8665356 us      49234.98 us
     405618876 us
  __x64_sys_ppoll                        324    5656635 us      17458.75 us
     19203976 us
  do_sys_poll                            324    5653747 us      17449.83 us
     19214945 us
  schedule_timeout                        67    5531396 us      82558.15 us
     2136740827 us
  __x64_sys_pselect6                      12    3029540 us      252461.7 us
     63296940171 us
  do_pselect.constprop.0                  12    3029532 us      252461.0 us
     63296952931 us
```

After (filtering working):
```
  Function                               Hit    Time            Avg
     s^2
  --------                               ---    ----            ---
     ---
  vfs_write                              462    68476.43 us     148.217 us
     25874.48 us
  vfs_read                               641    9611.356 us     14.994 us
     28868.07 us
  vfs_fstat                              890    878.094 us      0.986 us
     1.667 us
  vfs_fstatat                            227    757.176 us      3.335 us
     18.928 us
  vfs_statx                              226    610.610 us      2.701 us
     17.749 us
  vfs_getattr_nosec                     1187    460.919 us      0.388 us
     0.326 us
  vfs_statx_path                         297    343.287 us      1.155 us
     11.116 us
  vfs_rename                               6    291.575 us      48.595 us
     9889.236 us
```

Cc: stable@vger.kernel.org
Fixes: c132be2c4fcc ("function_graph: Have the instances use their own ftrace_ops for filtering")
Signed-off-by: Kohei Enju <enjuk@amazon.com>
---
 kernel/trace/ftrace.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 9b17efb1a87d..2e113f8b13a2 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -902,16 +902,13 @@ static void profile_graph_return(struct ftrace_graph_ret *trace,
 }
 
 static struct fgraph_ops fprofiler_ops = {
-	.ops = {
-		.flags = FTRACE_OPS_FL_INITIALIZED,
-		INIT_OPS_HASH(fprofiler_ops.ops)
-	},
 	.entryfunc = &profile_graph_entry,
 	.retfunc = &profile_graph_return,
 };
 
 static int register_ftrace_profiler(void)
 {
+	ftrace_ops_set_global_filter(&fprofiler_ops.ops);
 	return register_ftrace_graph(&fprofiler_ops);
 }
 
@@ -922,12 +919,11 @@ static void unregister_ftrace_profiler(void)
 #else
 static struct ftrace_ops ftrace_profile_ops __read_mostly = {
 	.func		= function_profile_call,
-	.flags		= FTRACE_OPS_FL_INITIALIZED,
-	INIT_OPS_HASH(ftrace_profile_ops)
 };
 
 static int register_ftrace_profiler(void)
 {
+	ftrace_ops_set_global_filter(&ftrace_profile_ops);
 	return register_ftrace_function(&ftrace_profile_ops);
 }
 
-- 
2.39.5 (Apple Git-154)


