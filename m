Return-Path: <stable+bounces-155137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D6DAE1E28
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D136E7A5CDF
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E233D2BDC05;
	Fri, 20 Jun 2025 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kyh/ZMZ+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2695634EC
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432240; cv=none; b=joRz8jTk1TQvQ2z0OJ7s35zbsSPX543V8L9eP6/j8xH4LOPAeJTnt4GQIwRGOP+NkZPu1x/1mKX+RX9l7zDZpBc64zBLK7JSYCNA/WWewutAR3xBfjeGZIfJxEn0TxhyStPBJTr9WX/X/3wh5faDU8CKhwP0DL4a2KSQlpCVw/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432240; c=relaxed/simple;
	bh=lOvDuzMRV2iDpURaYtaKNGqsYBh7hoQc0w6fF1xQw2Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lDgaf1i2X4zU3lL2r+vAXI+BibdettgleZIzBHGgTvges3lbGjY4X+Jo87q0eep5nMpvK6uh/mlmbT6qXJIY7qv7p0UI0GUUseZn4uEGI7xcTwYk0/cDboFZC38MsfM3Z2+Hny47phYxneZPw5iqszDY+PvfRsVhBQKJC60p/Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kyh/ZMZ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17065C4CEE3;
	Fri, 20 Jun 2025 15:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750432240;
	bh=lOvDuzMRV2iDpURaYtaKNGqsYBh7hoQc0w6fF1xQw2Q=;
	h=Subject:To:Cc:From:Date:From;
	b=kyh/ZMZ+vxZcGmWv+Fa2al8/b1/BuNvAmO5Y7M6Mg9SfqpT3Ev7OaABzq3S+AkAxi
	 nx1pbCSzATUICtSDuylS+fKyObRDT81Gfrc65CePtUheG8h16p42bBY7dO1dGT7ID8
	 EUvweLIip55M3wx4XCEgdxvJjp156Aobb6CCqyfM=
Subject: FAILED: patch "[PATCH] net_sched: sch_sfq: reject invalid perturb period" failed to apply to 5.10-stable tree
To: edumazet@google.com,gerrard.tai@starlabs.sg,kuba@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 17:10:26 +0200
Message-ID: <2025062026-excitable-trunks-92e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7ca52541c05c832d32b112274f81a985101f9ba8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062026-excitable-trunks-92e6@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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


