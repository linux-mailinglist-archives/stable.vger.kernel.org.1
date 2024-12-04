Return-Path: <stable+bounces-98400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF20E9E4292
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:57:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A144B2CF5B
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:15:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA66213253;
	Wed,  4 Dec 2024 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sI0+S8uz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA66C213251;
	Wed,  4 Dec 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331654; cv=none; b=DHlq871Bc1p8TAnhNB0i+LwUnKGVDnB6G1OxvVoMYNm4RlZTWy+RG/SopJ7h7euRgHk0Kbr+9P8rQ9SiRJwzyOt4k67HbXMHrW64RsTk3eg1My/QfdVbZA0ODXA07C1qvAYWikeVmZi621iK5G32XJjEvW6JJkCLZeumrmrSO7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331654; c=relaxed/simple;
	bh=u7iL59JZ+LF+ix8WSFcbLB17jl81Z2NxO53eafh12M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iwQlyKGBOtNPXU5DYFPkPjjxuIqF2XqW2mD57zRKp8eB33ABd1ujM//jXCV3OP7eoS1grCPC8smfo37nf5RUh+uRPuk1tR6U3bsYM0gI3BxqdzFwrU98v5zJoyETojiPf5fCgQlMXXTXi+3S4dxgEG9ArnWLgP9tT2T6Jcf+uQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sI0+S8uz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D7CFC4CECD;
	Wed,  4 Dec 2024 17:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331653;
	bh=u7iL59JZ+LF+ix8WSFcbLB17jl81Z2NxO53eafh12M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sI0+S8uzBNdUqgHmoWrOYFnssFpJ6mb9ygfYxE0HXF7p2FNaN1EDS7jL1Qog7B+Uo
	 iEL52LIPHJZL+ylQ5hagiEU+HNL75OR9I9GETYaFdJPzNad9w8TEy5+ZBpeHdcHfFU
	 kU9w4pzx31XcuA78bYch8XsSf9JaASH+YiAYQp23HcswSha4rAJD1jAiUh8iEWEWJb
	 6TlVkei6f94+f7eQEmwtwooU/utCBbxEwSK4bzbgG6KYu6P9JoBussZX9WI1DS1ib0
	 W/zxqoUyFA3KuCxKOciFhzsb01z2CBdEnLHfssJoF1VpSSINuTAO/hyqttX4QqqMsU
	 xUdGcXUXiKy4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: furkanonder <furkanonder@protonmail.com>,
	"jkacur@redhat.com" <jkacur@redhat.com>,
	"lgoncalv@redhat.com" <lgoncalv@redhat.com>,
	Tomas Glozar <tglozar@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	bristot@kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 31/33] tools/rtla: Enhance argument parsing in timerlat_load.py
Date: Wed,  4 Dec 2024 10:47:44 -0500
Message-ID: <20241204154817.2212455-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154817.2212455-1-sashal@kernel.org>
References: <20241204154817.2212455-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: furkanonder <furkanonder@protonmail.com>

[ Upstream commit bd26818343dc02936a4f2f7b63368d5e1e1773c8 ]

The enhancements made to timerlat_load.py are aimed at improving the clarity of argument parsing.

Summary of Changes:
- The cpu argument is now specified as an integer type in the argument
  parser to enforce input validation, and the construction of affinity_mask
  has been simplified to directly use the integer value of args.cpu.
- The prio argument is similarly updated to be of integer type for
  consistency and validation, eliminating the need for the conversion of
  args.prio to an integer, as this is now handled by the argument parser.

Cc: "jkacur@redhat.com" <jkacur@redhat.com>
Cc: "lgoncalv@redhat.com" <lgoncalv@redhat.com>
Link: https://lore.kernel.org/QfgO7ayKD9dsLk8_ZDebkAV0OF7wla7UmasbP9CBmui_sChOeizy512t3RqCHTjvQoUBUDP8dwEOVCdHQ5KvVNEiP69CynMY94SFDERWl94=@protonmail.com
Signed-off-by: Furkan Onder <furkanonder@protonmail.com>
Reviewed-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/tracing/rtla/sample/timerlat_load.py | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/tracing/rtla/sample/timerlat_load.py b/tools/tracing/rtla/sample/timerlat_load.py
index 8cc5eb2d2e69e..52eccb6225f92 100644
--- a/tools/tracing/rtla/sample/timerlat_load.py
+++ b/tools/tracing/rtla/sample/timerlat_load.py
@@ -25,13 +25,12 @@ import sys
 import os
 
 parser = argparse.ArgumentParser(description='user-space timerlat thread in Python')
-parser.add_argument("cpu", help='CPU to run timerlat thread')
-parser.add_argument("-p", "--prio", help='FIFO priority')
-
+parser.add_argument("cpu", type=int, help='CPU to run timerlat thread')
+parser.add_argument("-p", "--prio", type=int, help='FIFO priority')
 args = parser.parse_args()
 
 try:
-    affinity_mask = { int(args.cpu) }
+    affinity_mask = {args.cpu}
 except:
     print("Invalid cpu: " + args.cpu)
     exit(1)
@@ -44,7 +43,7 @@ except:
 
 if (args.prio):
     try:
-        param = os.sched_param(int(args.prio))
+        param = os.sched_param(args.prio)
         os.sched_setscheduler(0, os.SCHED_FIFO, param)
     except:
         print("Error setting priority")
-- 
2.43.0


