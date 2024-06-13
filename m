Return-Path: <stable+bounces-50416-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 187489065B3
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 09:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F0B81F266D8
	for <lists+stable@lfdr.de>; Thu, 13 Jun 2024 07:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CE713C8FF;
	Thu, 13 Jun 2024 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vi2zIFvb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4EE13C8E8
	for <stable@vger.kernel.org>; Thu, 13 Jun 2024 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718265238; cv=none; b=JeMA0QFUu1G5eF/XMOccRvtH2Z7ZL7rfDxxk0ViHBeMoANNsijQqSj1yTXDF9SQ7UoEKqBQTwh8eMIMTMsZO8LWGWu0/G9LDvZncrUOMdnoodLO/RHbVerOYFMgJYLNmzhWnuXbZewB8uYVP+pVLr2gpZJwzJjHtis6Cz5EqFw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718265238; c=relaxed/simple;
	bh=WVE/ND8zqIkscNi8sGUFgNHJy0tS0e/K1XZFwjAh2P0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mR2TudNm7Zg4MuyBJcp42a7Yyj8Y/eBie/jGAXqtMTY+MkETptFHmJkwkar3Tt7fFMt7/PsXxCP8Ia5buM3yz7uOh38geJGcz7qQ/YSRo2zHt4D9vT+ipW6clJZjyPMWJIn+Lfd5+C54JH+Y0t9t3RGIKAknkNxUlsdZe3Xlwj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vi2zIFvb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF446C2BBFC;
	Thu, 13 Jun 2024 07:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718265238;
	bh=WVE/ND8zqIkscNi8sGUFgNHJy0tS0e/K1XZFwjAh2P0=;
	h=Subject:To:Cc:From:Date:From;
	b=Vi2zIFvbnf+oe+MjPFcvSwjexJ60tpfZa6izTEVKgCWsJwhJ069Wtdz433WnRVSus
	 ForU28pchR9SE4zHRYYP9tMikSQkAN7NP3SeQQ/l4pLiI1TgpWr/fwimCDyKELVU9g
	 L5liHb8ZBRLfSQHHwK50i+kfqU8v7xG7QJkWD8K4=
Subject: FAILED: patch "[PATCH] rtla/timerlat: Fix histogram report when a cpu count is 0" failed to apply to 6.1-stable tree
To: jkacur@redhat.com,bristot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 13 Jun 2024 09:53:55 +0200
Message-ID: <2024061354-playtime-clumsy-d741@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 01b05fc0e5f3aec443a9a8ffa0022cbca2fd3608
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061354-playtime-clumsy-d741@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

01b05fc0e5f3 ("rtla/timerlat: Fix histogram report when a cpu count is 0")
ed774f7481fa ("rtla/timerlat_hist: Add timerlat user-space support")
2091336b9a8b ("rtla/timerlat_hist: Add auto-analysis support")
272ced2556e6 ("rtla: Add --house-keeping option")
a957cbc02531 ("rtla: Add -C cgroup support")
9fa48a2477de ("rtla/timerlat: Add auto-analysis only option")
1f428356c38d ("rtla: Add hwnoise tool")
ce6cc6f70cad ("Documentation/rtla: Add timerlat-top auto-analysis options")
5def33df84d2 ("rtla/timerlat: Add auto-analysis support to timerlat top")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 01b05fc0e5f3aec443a9a8ffa0022cbca2fd3608 Mon Sep 17 00:00:00 2001
From: John Kacur <jkacur@redhat.com>
Date: Fri, 10 May 2024 15:03:18 -0400
Subject: [PATCH] rtla/timerlat: Fix histogram report when a cpu count is 0

On short runs it is possible to get no samples on a cpu, like this:

  # rtla timerlat hist -u -T50

  Index   IRQ-001   Thr-001   Usr-001   IRQ-002   Thr-002   Usr-002
  2             1         0         0         0         0         0
  33            0         1         0         0         0         0
  36            0         0         1         0         0         0
  49            0         0         0         1         0         0
  52            0         0         0         0         1         0
  over:         0         0         0         0         0         0
  count:        1         1         1         1         1         0
  min:          2        33        36        49        52 18446744073709551615
  avg:          2        33        36        49        52         -
  max:          2        33        36        49        52         0
  rtla timerlat hit stop tracing
    IRQ handler delay:		(exit from idle)	    48.21 us (91.09 %)
    IRQ latency:						    49.11 us
    Timerlat IRQ duration:				     2.17 us (4.09 %)
    Blocking thread:					     1.01 us (1.90 %)
  	               swapper/2:0        		     1.01 us
  ------------------------------------------------------------------------
    Thread latency:					    52.93 us (100%)

  Max timerlat IRQ latency from idle: 49.11 us in cpu 2

Note, the value 18446744073709551615 is the same as ~0.

Fix this by reporting no results for the min, avg and max if the count
is 0.

Link: https://lkml.kernel.org/r/20240510190318.44295-1-jkacur@redhat.com

Cc: stable@vger.kernel.org
Fixes: 1eeb6328e8b3 ("rtla/timerlat: Add timerlat hist mode")
Suggested-by: Daniel Bristot de Oliveria <bristot@kernel.org>
Signed-off-by: John Kacur <jkacur@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>

diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index d4bab86ca1b9..fbe2c6549bf9 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -327,17 +327,29 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
 
-		if (!params->no_irq)
-			trace_seq_printf(trace->seq, "%9llu ",
-					data->hist[cpu].min_irq);
+		if (!params->no_irq) {
+			if (data->hist[cpu].irq_count)
+				trace_seq_printf(trace->seq, "%9llu ",
+						data->hist[cpu].min_irq);
+			else
+				trace_seq_printf(trace->seq, "        - ");
+		}
 
-		if (!params->no_thread)
-			trace_seq_printf(trace->seq, "%9llu ",
-					data->hist[cpu].min_thread);
+		if (!params->no_thread) {
+			if (data->hist[cpu].thread_count)
+				trace_seq_printf(trace->seq, "%9llu ",
+						data->hist[cpu].min_thread);
+			else
+				trace_seq_printf(trace->seq, "        - ");
+		}
 
-		if (params->user_hist)
-			trace_seq_printf(trace->seq, "%9llu ",
-					data->hist[cpu].min_user);
+		if (params->user_hist) {
+			if (data->hist[cpu].user_count)
+				trace_seq_printf(trace->seq, "%9llu ",
+						data->hist[cpu].min_user);
+			else
+				trace_seq_printf(trace->seq, "        - ");
+		}
 	}
 	trace_seq_printf(trace->seq, "\n");
 
@@ -387,17 +399,29 @@ timerlat_print_summary(struct timerlat_hist_params *params,
 		if (!data->hist[cpu].irq_count && !data->hist[cpu].thread_count)
 			continue;
 
-		if (!params->no_irq)
-			trace_seq_printf(trace->seq, "%9llu ",
-					data->hist[cpu].max_irq);
+		if (!params->no_irq) {
+			if (data->hist[cpu].irq_count)
+				trace_seq_printf(trace->seq, "%9llu ",
+						 data->hist[cpu].max_irq);
+			else
+				trace_seq_printf(trace->seq, "        - ");
+		}
 
-		if (!params->no_thread)
-			trace_seq_printf(trace->seq, "%9llu ",
-					data->hist[cpu].max_thread);
+		if (!params->no_thread) {
+			if (data->hist[cpu].thread_count)
+				trace_seq_printf(trace->seq, "%9llu ",
+						data->hist[cpu].max_thread);
+			else
+				trace_seq_printf(trace->seq, "        - ");
+		}
 
-		if (params->user_hist)
-			trace_seq_printf(trace->seq, "%9llu ",
-					data->hist[cpu].max_user);
+		if (params->user_hist) {
+			if (data->hist[cpu].user_count)
+				trace_seq_printf(trace->seq, "%9llu ",
+						data->hist[cpu].max_user);
+			else
+				trace_seq_printf(trace->seq, "        - ");
+		}
 	}
 	trace_seq_printf(trace->seq, "\n");
 	trace_seq_do_printf(trace->seq);


