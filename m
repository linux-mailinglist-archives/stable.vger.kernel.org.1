Return-Path: <stable+bounces-110397-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FF5AA1BC61
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 19:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1CC0188D22B
	for <lists+stable@lfdr.de>; Fri, 24 Jan 2025 18:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F812253EB;
	Fri, 24 Jan 2025 18:48:47 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D28224B15;
	Fri, 24 Jan 2025 18:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737744527; cv=none; b=Ja32gjPNpnBNBTwfVsPhtbThTRq4RvicTOgpFqIOeEVQQlhoE3JPjULVr2BxiHQVvpM8kLiadrhjTgC8/H6+FEms72mP1+H2J5u4h02SpLmRlYS75eODRlrcyqy53/7lARhCZpXR2iIuULCmjsYasJAKuNDctXJIKovtaEjmVSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737744527; c=relaxed/simple;
	bh=mzph4wXrV2wL+OMS9ENgef/SCO0U7I85XCJ2FN5AuBk=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=lBHIBFsvXsX6mdwhAZIxVN0lbN4Rw+wLx963/OQv1ye11sDZcP4c1Z+btkkqemfSBj7ogR96SMOBGzTEVUyVKF3WXxtFL7CAygU6DbJgtVqSbZXDYizL3lsZMKa4e6klaUQ9gbU/M3Kz0beM2KMbkDMDAo9chL/MudRy15qKImk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74ADC4CEDD;
	Fri, 24 Jan 2025 18:48:46 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tbOjh-00000001FD8-3fiV;
	Fri, 24 Jan 2025 13:48:57 -0500
Message-ID: <20250124184857.729167222@goodmis.org>
User-Agent: quilt/0.68
Date: Fri, 24 Jan 2025 13:48:44 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>,
 John Kacur <jkacur@redhat.com>,
 stable@vger.kernel.org,
 Luis Goncalves <lgoncalv@redhat.com>
Subject: [for-next][PATCH 09/14] rtla/timerlat_top: Set OSNOISE_WORKLOAD for kernel threads
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

$ rtla timerlat top -u
^\Quit (core dumped)
$ rtla timerlat top -k -d 1s
                                     Timer Latency
  0 00:00:01   |          IRQ Timer Latency (us)        |         Thread Timer Latency (us)
CPU COUNT      |      cur       min       avg       max |      cur       min       avg       max

The issue persists until OSNOISE_WORKLOAD is set manually by running:
$ echo OSNOISE_WORKLOAD > /sys/kernel/tracing/osnoise/options

Set OSNOISE_WORKLOAD when running rtla with kernel-space threads if
available to fix the issue.

Cc: stable@vger.kernel.org
Cc: John Kacur <jkacur@redhat.com>
Cc: Luis Goncalves <lgoncalv@redhat.com>
Link: https://lore.kernel.org/20250107144823.239782-4-tglozar@redhat.com
Fixes: cdca4f4e5e8e ("rtla/timerlat_top: Add timerlat user-space support")
Signed-off-by: Tomas Glozar <tglozar@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 tools/tracing/rtla/src/timerlat_top.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index d358cd39f360..f387597d3ac2 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -851,12 +851,15 @@ timerlat_top_apply_config(struct osnoise_tool *top, struct timerlat_top_params *
 		}
 	}
 
-	if (params->user_top) {
-		retval = osnoise_set_workload(top->context, 0);
-		if (retval) {
-			err_msg("Failed to set OSNOISE_WORKLOAD option\n");
-			goto out_err;
-		}
+	/*
+	* Set workload according to type of thread if the kernel supports it.
+	* On kernels without support, user threads will have already failed
+	* on missing timerlat_fd, and kernel threads do not need it.
+	*/
+	retval = osnoise_set_workload(top->context, params->kernel_workload);
+	if (retval < -1) {
+		err_msg("Failed to set OSNOISE_WORKLOAD option\n");
+		goto out_err;
 	}
 
 	if (isatty(STDOUT_FILENO) && !params->quiet)
-- 
2.45.2



