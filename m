Return-Path: <stable+bounces-248856-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOQ8J8BaB2pH0AIAu9opvQ
	(envelope-from <stable+bounces-248856-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:41:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 000BC5556C8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C65DE30C18DE
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 965DD3CE4B2;
	Fri, 15 May 2026 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z+CwcBF3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F873B19DE;
	Fri, 15 May 2026 16:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862805; cv=none; b=bC8q5ulgygBGd2jgKW+oS5q1CUJn+bQM1bPAequnmnegXbh9zOp+/9jHTDSxTFKA81Cz+Qpx46mk2LFmiGPLoHSglMETSIOb0J/i0vBciKfVV4XiCFQbVVsWho9Ka9bxH7YVi1STPyYCcaNyY89thhTJm++m35uWn6eK4gaoV5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862805; c=relaxed/simple;
	bh=zQDyTLhVaU/QFi1qY5rgmb+k9I87ButNpLmw1NWqtRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N2dRIuOjWbt0/xWIQ9srK2xDIz0j3ibp7+hEaAPGam2wn9IWfuebwmZb0oC/+CzIKjyJThNDeonToYSV8iNnqTcVqax2PqePmrXFMpGYmSoOFlKALviAeNXYMO7Li9+zhpLIpQM37ThGDw+6TENqcEqUokex23wROIDnxyfcWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z+CwcBF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1BA0C2BCB0;
	Fri, 15 May 2026 16:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862805;
	bh=zQDyTLhVaU/QFi1qY5rgmb+k9I87ButNpLmw1NWqtRs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z+CwcBF36QUoEhRNEK7GyhEKfiaBYXTpVerz1LxwlgPazJtf4PzNbxdeqajJpiuiu
	 ivftHLM6q/lf99R9Ln1EFZy6XeZ6gVWaIYWDs1HNk2ljdcSsOiuA/J4Xpu/WH0ukaO
	 nJNiLZx8t7sFnQQldO3mcwlWUT/0bZZLR+12exN0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Malat <oss@malat.biz>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.0 190/201] cgroup: Increment nr_dying_subsys_* from rmdir context
Date: Fri, 15 May 2026 17:50:08 +0200
Message-ID: <20260515154702.696773436@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 000BC5556C8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-248856-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,malat.biz:email]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Petr Malat <oss@malat.biz>

[ Upstream commit 13e786b64bd3fd81c7eb22aa32bf8305c32f2ccf ]

Incrementing nr_dying_subsys_* in offline_css(), which is executed by
cgroup_offline_wq worker, leads to a race where user can see the value
to be 0 if he reads cgroup.stat after calling rmdir and before the worker
executes. This makes the user wrongly expect resources released by the
removed cgroup to be available for a new assignment.

Increment nr_dying_subsys_* from kill_css(), which is called from the
cgroup_rmdir() context.

Fixes: ab0312526867 ("cgroup: Show # of subsystem CSSes in cgroup.stat")
Signed-off-by: Petr Malat <oss@malat.biz>
Signed-off-by: Tejun Heo <tj@kernel.org>
Stable-dep-of: 93618edf7538 ("cgroup: Defer css percpu_ref kill on rmdir until cgroup is depopulated")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/cgroup/cgroup.c |   22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5768,16 +5768,6 @@ static void offline_css(struct cgroup_su
 	RCU_INIT_POINTER(css->cgroup->subsys[ss->id], NULL);
 
 	wake_up_all(&css->cgroup->offline_waitq);
-
-	css->cgroup->nr_dying_subsys[ss->id]++;
-	/*
-	 * Parent css and cgroup cannot be freed until after the freeing
-	 * of child css, see css_free_rwork_fn().
-	 */
-	while ((css = css->parent)) {
-		css->nr_descendants--;
-		css->cgroup->nr_dying_subsys[ss->id]++;
-	}
 }
 
 /**
@@ -6089,6 +6079,8 @@ static void css_killed_ref_fn(struct per
  */
 static void kill_css(struct cgroup_subsys_state *css)
 {
+	struct cgroup_subsys *ss = css->ss;
+
 	lockdep_assert_held(&cgroup_mutex);
 
 	if (css->flags & CSS_DYING)
@@ -6125,6 +6117,16 @@ static void kill_css(struct cgroup_subsy
 	 * css is confirmed to be seen as killed on all CPUs.
 	 */
 	percpu_ref_kill_and_confirm(&css->refcnt, css_killed_ref_fn);
+
+	css->cgroup->nr_dying_subsys[ss->id]++;
+	/*
+	 * Parent css and cgroup cannot be freed until after the freeing
+	 * of child css, see css_free_rwork_fn().
+	 */
+	while ((css = css->parent)) {
+		css->nr_descendants--;
+		css->cgroup->nr_dying_subsys[ss->id]++;
+	}
 }
 
 /**



