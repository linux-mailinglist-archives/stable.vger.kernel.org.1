Return-Path: <stable+bounces-155158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA2DAE1E4C
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 17:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F1F2189BFCA
	for <lists+stable@lfdr.de>; Fri, 20 Jun 2025 15:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D2419A297;
	Fri, 20 Jun 2025 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nn54N7Ct"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8688083A14
	for <stable@vger.kernel.org>; Fri, 20 Jun 2025 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750432553; cv=none; b=JgZRlj0W/TzKZQMRyJARgrtxs/ODIWE91B+C1tAxmaIHP68p1luHyKJZZwOit06Ar87q385WiSwqAyCBki9jwd+Li3p/KQf3UmQUluyirYQdC6x3vn18jFa33Hvkvij7TfClmS/dZuIbg7H32Pezvy/AEJ9fb1fYp0kGDV12kwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750432553; c=relaxed/simple;
	bh=riLO10VnOMA5S0TtkbhVlhRllYtjocQs/R9+JeKoMq4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HwmSEgVIAskQMj49Do8gIzPafBdjc1kdJKVRuvBrIypB6xQBYBaBsKXYd9kHmk8UfoVr7aCcK0ocR+QXutaGlVl1d0mo/GLuQRzGFVAeWYLqgE0Mwqy55pTFQQoxZDNsh3GpvXyqcEwXg0S99UfAxlhLOlP7FvMr3ly+wYnsNGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nn54N7Ct; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 134FAC4CEE3;
	Fri, 20 Jun 2025 15:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750432553;
	bh=riLO10VnOMA5S0TtkbhVlhRllYtjocQs/R9+JeKoMq4=;
	h=Subject:To:Cc:From:Date:From;
	b=nn54N7CtJDutU/WfyRGq5Smn1IYGw0apuHOmqKamSc86bMcVfBl+IwZ0DijXUmLgQ
	 jYi3zWgpUYSR5HBnirRaaJp9Pt93Q3O7AjhqmlpKdMSfrj6iQAfjEMJ8+7wuYpsjZa
	 //EJAYbA4PB/c5NQdV8DJXBhkoxGvAPeK5intnb4=
Subject: FAILED: patch "[PATCH] sched_ext: Make scx_group_set_weight() always update" failed to apply to 6.12-stable tree
To: tj@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 20 Jun 2025 17:15:42 +0200
Message-ID: <2025062042-retention-refocus-df92@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c50784e99f0e7199cdb12dbddf02229b102744ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025062042-retention-refocus-df92@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c50784e99f0e7199cdb12dbddf02229b102744ef Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Fri, 13 Jun 2025 13:23:07 -1000
Subject: [PATCH] sched_ext: Make scx_group_set_weight() always update
 tg->scx.weight

Otherwise, tg->scx.weight can go out of sync while scx_cgroup is not enabled
and ops.cgroup_init() may be called with a stale weight value.

Signed-off-by: Tejun Heo <tj@kernel.org>
Fixes: 819513666966 ("sched_ext: Add cgroup support")
Cc: stable@vger.kernel.org # v6.12+

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2c41c78be61e..33a0d8c6ff95 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4241,12 +4241,12 @@ void scx_group_set_weight(struct task_group *tg, unsigned long weight)
 
 	percpu_down_read(&scx_cgroup_rwsem);
 
-	if (scx_cgroup_enabled && tg->scx_weight != weight) {
-		if (SCX_HAS_OP(sch, cgroup_set_weight))
-			SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_weight, NULL,
-				    tg_cgrp(tg), weight);
-		tg->scx_weight = weight;
-	}
+	if (scx_cgroup_enabled && SCX_HAS_OP(sch, cgroup_set_weight) &&
+	    tg->scx_weight != weight)
+		SCX_CALL_OP(sch, SCX_KF_UNLOCKED, cgroup_set_weight, NULL,
+			    tg_cgrp(tg), weight);
+
+	tg->scx_weight = weight;
 
 	percpu_up_read(&scx_cgroup_rwsem);
 }


