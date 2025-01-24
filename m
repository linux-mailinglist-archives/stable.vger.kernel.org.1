Return-Path: <stable+bounces-110396-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 382E8A1BC60
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:49:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85C6918901A5
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 18:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A052253E4;
	Fri, 24 Jan 2025 18:48:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46CB224B14;
	Fri, 24 Jan 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744526; cv=none; b=WeVFzWXSp70oDoTJrNoUf/HJMDYTDgU8Ufp76dzPkdLJcd0295zK8GR7ZADLiolwWe2M67hqQESEZFJ+ee3ZNrBc2CGHf73x+wgArjVRbcVsemJanuPtZFWr5GhvCSQti3bQEREgH8epaFlvpYMC9SWFvCdxWjBE6TGMJRdGfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744526; c=relaxed/simple;
	bh=Z9XmZjSlN4ifomFliB1zNxdAIaQZCbK5Rci4u2A1spM=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=bVg0Gb6UtZItkOab1nMT+oCh4yG39Da5G2vMviJGd0Eicp0jMurfgbQ2GDrKKOPgrgA5f8tKDwlZ3MlVeM3p35O60XRGqFxVcrbmBs+sAvHc67F/2z1racZZsFIwgvIkU1B6Ax3bBUtEK1PEQa1g/3YN8IqGrorPQf0w2k5xmHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE09C4CEE7;
	Fri, 24 Jan 2025 18:48:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tbOjh-00000001FCd-2yQt;
	Fri, 24 Jan 2025 13:48:57 -0500
Message-ID: <20250124184857.558050033@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 Jan 2025 13:48:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 stable@vger.kernel.org,
 Luis Goncalves <lgoncalv@redhat.com>
Subject: [for-next][PATCH 08/14] rtla/timerlat_hist: Set OSNOISE_WORKLOAD for kernel threads
References: <20250124184835.052017152@goodmis.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Tomas Glozar <tglozar@redhat.com>

When using rtla timerlat with userspace threads (-u or -U), rtla
disables the OSNOISE_WORKLOAD option in
/sys/kernel/tracing/osnoise/options. This option is not re-enabled in a
subsequent run with kernel-space threads, leading to rtla collecting no
results if the previous run exited abnormally:

$ rtla timerlat hist -u
^\Quit (core dumped)
$ rtla timerlat hist -k -d 1s
Index
over:
count:
min:
avg:
max:
ALL:        IRQ       Thr       Usr
count:        0         0         0
min:          -         -         -
avg:          -         -         -
max:          -         -         -

The issue persists until OSNOISE_WORKLOAD is set manually by running:
$ echo OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options

Set OSNOISE_WORKLOAD when running rtla with kernel-space threads if
available to fix the issue.

Cc: stable@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20250107144823.239782-3-tglozar@redhat.com
Fixes: ed774f7481fa ("rtla/timerlat_hist: Add timerlat user-space support")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat_hist.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 53ded187b33a..d4bd02c01c53 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -1085,12 +1085,15 @@ timerlat_hist_apply_config(struct osnoise_tool *tool, struct timerlat_hist_param
 		}
 	}
 
-	if (params->user_hist) {
-		retval = osnoise_set_workload(tool->context, 0);
-		if (retval) {
-			err_msg("Failed to set OSNOISE_WORKLOAD option\n");
-			goto out_err;
-		}
+	/*
+	* Set workload according to type of thread if the kernel supports it.
+	* On kernels without support, user threads will have already failed
+	* on missing timerlat_fd, and kernel threads do not need it.
+	*/
+	retval = osnoise_set_workload(tool->context, params->kernel_workload);
+	if (retval < -1) {
+		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+		goto out_err;
 	}
 
 	return 0;
-- 
2.45.2



