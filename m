Return-Path: <stable+bounces-66501-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F344194EC8B
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 14:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99F3E1F2275D
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 12:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D91179957;
	Mon, 12 Aug 2024 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iXthpT61"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B52C175D3E
	for <stable@vger.kernel.org>; Mon, 12 Aug 2024 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723464847; cv=none; b=J7BV2m2KiQ53s8Nw+sgd+KZ515vyP0sNPNYXBMwmrutzyb4tk9P1ppxRdwWu4Wfvn5OLZqiYwBvzNmkEYyj11EX1lC8ZbkgaI/R2Pcv7S9m5SpHRBWUXOTPfjL7oCaP9OY4juyfExtFe8hSi3pva0u61zBkHzNYK8KrAwXptoKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723464847; c=relaxed/simple;
	bh=AjlGmCPrnjPUzdwqWddo2+fV+5/6lLL7az6D/1tai6o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=gwz4HeVbwIYNjF0DjZKWGMX9K4b34sR9LEDgrKefCBV+ipwE0+t71d65AFibg/m/nouOLPv6nB6VzFX6fOe80xBTDYpRbNJhfyq4Ybp4ITfRaqPsJe/iUX+y3r3WJprLGsVoZlKftoys1GG8G7asBBvzuuMGOO3iJH6urolZQkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iXthpT61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E358C32782;
	Mon, 12 Aug 2024 12:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723464846;
	bh=AjlGmCPrnjPUzdwqWddo2+fV+5/6lLL7az6D/1tai6o=;
	h=Subject:To:Cc:From:Date:From;
	b=iXthpT61JM+GMK6tPhX7XnbJIPJeCFAvJm+w6DwFeUZR+xbt1FnSrsDjwCbGaCN+j
	 pwMjFVtVda+JZ5YerzBAg6mcYFm+QEursI6jzH8iqFqqzmt+MI+oqzP5ZrFP+lU4dd
	 hcqy45p6RKSNCQwgSizjU3zZKaNlFzz5rZ7mpQF8=
Subject: FAILED: patch "[PATCH] sched/core: Fix unbalance set_rq_online/offline() in" failed to apply to 5.10-stable tree
To: yangyingliang@huawei.com,peterz@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Aug 2024 14:13:53 +0200
Message-ID: <2024081253-promotion-degrading-c12f@gregkh>
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
git cherry-pick -x fe7a11c78d2a9bdb8b50afc278a31ac177000948
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081253-promotion-degrading-c12f@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

fe7a11c78d2a ("sched/core: Fix unbalance set_rq_online/offline() in sched_cpu_deactivate()")
e22f910a26cc ("sched/smt: Fix unbalance sched_smt_present dec/inc")
2558aacff858 ("sched/hotplug: Ensure only per-cpu kthreads run during hotplug")
565790d28b1e ("sched: Fix balance_callback()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fe7a11c78d2a9bdb8b50afc278a31ac177000948 Mon Sep 17 00:00:00 2001
From: Yang Yingliang <yangyingliang@huawei.com>
Date: Wed, 3 Jul 2024 11:16:10 +0800
Subject: [PATCH] sched/core: Fix unbalance set_rq_online/offline() in
 sched_cpu_deactivate()

If cpuset_cpu_inactive() fails, set_rq_online() need be called to rollback.

Fixes: 120455c514f7 ("sched: Fix hotplug vs CPU bandwidth control")
Cc: stable@kernel.org
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240703031610.587047-5-yangyingliang@huaweicloud.com

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4d119e930beb..f3951e4a55e5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8022,6 +8022,7 @@ int sched_cpu_deactivate(unsigned int cpu)
 	ret = cpuset_cpu_inactive(cpu);
 	if (ret) {
 		sched_smt_present_inc(cpu);
+		sched_set_rq_online(rq, cpu);
 		balance_push_set(cpu, false);
 		set_cpu_active(cpu, true);
 		sched_update_numa(cpu, true);


