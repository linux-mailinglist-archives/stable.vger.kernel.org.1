Return-Path: <stable+bounces-98367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 967D99E4091
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57698280E81
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577F63DABF3;
	Wed,  4 Dec 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrjCbauj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBDD20E306;
	Wed,  4 Dec 2024 16:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331539; cv=none; b=tzzrI0iUyR19LTqVfL773d2xuH0JLnv3wDvbmIG3dpkuQ2Larrvp823MMn/DTiVpb6ffvl90ll/FVUvmkC5tvj4AxDMapxNH5bl2sMDWqZEVDrVq9l5Vlioj8rPxvhdln/IIOegK1XmRLNy0DJINpaUnmJ77Qylvn5IaguTMPQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331539; c=relaxed/simple;
	bh=u7iL59JZ+LF+ix8WSFcbLB17jl81Z2NxO53eafh12M8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozeDgK4hlfeof38u3of7EmiIvbU+1f3UTqA+aPTvbnAJTguVV2jEcbnXSDZFG6fRxRJTFiMzZH1sLNLsBhLPSUnwhW5+Omf/bkjvV71L8HjwwsyfeLu47CGiXJLzRHNXx1Jkhqh9eB/ufgcgE+q7LNFOi0IURkGINDLLYg4khSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrjCbauj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE3F8C4CED1;
	Wed,  4 Dec 2024 16:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331538;
	bh=u7iL59JZ+LF+ix8WSFcbLB17jl81Z2NxO53eafh12M8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RrjCbaujZZU4rTws3aN7S8Tcs+ePgAi1kkuRIG3Dc6Fq1DLvpj/lFnBWcD4y6lVYj
	 UDomamL5vq3FwBR86RNsJ5EqfTK0+UZ/QM/sHoItYEEiQTpKaJTO+OvbVPm70G2nbl
	 fNBWpiB+ICe1AeEZJKVQ4J9Wzf2qiWpr3lOWOYGoGeGocASDpXPfIjuiJ1t8R2Mv5i
	 tSAKGCTkRXI/7gewqnddrH3EEXjrzuilTmamOnor6ATmcTVHlLOlvCfDijSPLm8MDg
	 2yMG1pi3APkSnb0TIDfoU0ujTf3I2EZUI/7+CWTf8XYepriiOrq2936SpcTK/+/rJv
	 YTxdQXiJKomNw==
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
Subject: [PATCH AUTOSEL 6.12 34/36] tools/rtla: Enhance argument parsing in timerlat_load.py
Date: Wed,  4 Dec 2024 10:45:50 -0500
Message-ID: <20241204154626.2211476-34-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154626.2211476-1-sashal@kernel.org>
References: <20241204154626.2211476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
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


