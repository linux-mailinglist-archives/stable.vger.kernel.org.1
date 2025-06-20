Return-Path: <stable+bounces-155136-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C50A8AE1E2E
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11ADA4C0C54
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A033296169;
	Fri, 20 Jun 2025 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k5XAj6mP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6FB634EC
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432237; cv=none; b=FnfiB4A/hvW0z+m4JFN1hOJ7cVvHWAl6pLe6xHBunQ8k1HRCAvUdYNd9A/Omf/IA+Cvt9o945PvPhKQNMznCD9tA6GLokVGSv0fz+ZV/adXVv7BQVjGA9LDMOid+i0OedjgYZu/1BQkiC/zz8/oxPXkat3T0p35Lo6Ba1bFz8BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432237; c=relaxed/simple;
	bh=grGjulADYfnLwuGvZ5sqqROMvX+MVx+MO3S3m1NimHI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YH4NePK3+2swjLM+k7FJEvEVyD+oADT4w0n2sL2TLvo4T899R1AOPbl8uEBgLJ7X7hKINvH+8NJgUpvSl9A286TsJPLNYE3quFeMW6LebHFPgHvjliDibt0QiEA5S7D0ud+dROq1LZw2sbDPkvRBj7Zc+oCfutS0T4cYUcC9zGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k5XAj6mP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3A6C4CEEF;
	Fri, 20 Jun 2025 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750432237;
	bh=grGjulADYfnLwuGvZ5sqqROMvX+MVx+MO3S3m1NimHI=;
	h=Subject:To:Cc:From:Date:From;
	b=k5XAj6mPXNmYPVOEjfVeieJIX8tmcWvlUd5SvWnIESqp5VtkSSuOdEoizHRrVXIA8
	 GTGEXmiwJnsyPXor99x7yRdorcdXyCT7Q7TYTa6QxerBH2Gmlf/BZjwQfEGTnQ1exs
	 RcHIlhJ/82MQut9e8UQteBn/1DNDZTw+t42+Ek/A=
Subject: FAILED: patch "[PATCH] net_sched: sch_sfq: reject invalid perturb period" failed to apply to 5.4-stable tree
To: edumazet@google.com,gerrard.tai@starlabs.sg,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 17:10:26 +0200
Message-ID: <2025062026-stinger-coeditor-bb58@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 7ca52541c05c832d32b112274f81a985101f9ba8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062026-stinger-coeditor-bb58@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7ca52541c05c832d32b112274f81a985101f9ba8 Mon Sep 17 00:00:00 2001
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 11 Jun 2025 08:35:01 +0000
Subject: [PATCH] net_sched: sch_sfq: reject invalid perturb period

Gerrard Tai reported that SFQ perturb_period has no range check yet,
and this can be used to trigger a race condition fixed in a separate patch.

We want to make sure ctl->perturb_period * HZ will not overflow
and is positive.

Tested:

tc qd add dev lo root sfq perturb -10   # negative value : error
Error: sch_sfq: invalid perturb period.

tc qd add dev lo root sfq perturb 1000000000 # too big : error
Error: sch_sfq: invalid perturb period.

tc qd add dev lo root sfq perturb 2000000 # acceptable value
tc -s -d qd sh dev lo
qdisc sfq 8005: root refcnt 2 limit 127p quantum 64Kb depth 127 flows 128 divisor 1024 perturb 2000000sec
 Sent 0 bytes 0 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20250611083501.1810459-1-edumazet@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 77fa02f2bfcd..a8cca549b5a2 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -656,6 +656,14 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		NL_SET_ERR_MSG_MOD(extack, "invalid quantum");
 		return -EINVAL;
 	}
+
+	if (ctl->perturb_period < 0 ||
+	    ctl->perturb_period > INT_MAX / HZ) {
+		NL_SET_ERR_MSG_MOD(extack, "invalid perturb period");
+		return -EINVAL;
+	}
+	perturb_period = ctl->perturb_period * HZ;
+
 	if (ctl_v1 && !red_check_params(ctl_v1->qth_min, ctl_v1->qth_max,
 					ctl_v1->Wlog, ctl_v1->Scell_log, NULL))
 		return -EINVAL;
@@ -672,14 +680,12 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	headdrop = q->headdrop;
 	maxdepth = q->maxdepth;
 	maxflows = q->maxflows;
-	perturb_period = q->perturb_period;
 	quantum = q->quantum;
 	flags = q->flags;
 
 	/* update and validate configuration */
 	if (ctl->quantum)
 		quantum = ctl->quantum;
-	perturb_period = ctl->perturb_period * HZ;
 	if (ctl->flows)
 		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {


