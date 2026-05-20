Return-Path: <stable+bounces-251953-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOhZDVH9DWok5QUAu9opvQ
	(envelope-from <stable+bounces-251953-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:28:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A99596421
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:28:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A012D35301B4
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A797F3F23B7;
	Wed, 20 May 2026 17:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vg2WH32Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3784B3F1AB8;
	Wed, 20 May 2026 17:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779299362; cv=none; b=tvu7s0R8/oJ89/+AKMOTOuq0MY1iMuiQB8W20Lwn765Ja1Gwlk7xDz2TqRu95jfK9lgJdRqQk4yFdROFmpXFAR2yYCNSKnyMxLKrCeGjE8RZWIcnrLs3ygv6krihy/SgxnWr0mNjITDijhubVv7GhCViFbJ0yYOrzWf7bNhEC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779299362; c=relaxed/simple;
	bh=QFQibX+VW2DskrmCHnIILuT8eOuEQ81rifW+k4dZV/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Afr81jIEUSwpatLb2Acz0j56ABkPyikBmgZLAyVcP5Df0F2SVJtXNdGn32BaOVzOrXvRiPn+V4bFymq7E7LiMIteGl3a8ab6MDUOdnU2KZ8uUy7gVyUrSDVGfstBLPHd+9AEyY1XfV0s8O2qFf5vYm+Y0wTK55QnNSwoLz1PVWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vg2WH32Q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA1B1F000E9;
	Wed, 20 May 2026 17:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779299361;
	bh=OFUXq6YMdiQWR1QDwUyMiXRAe/9RvuSSnS8UZUNHr8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vg2WH32QUF18uR/7zlRNnv0h9MaEUXu7voyO72JsosTukIziTfjbhHn0kWXiV720I
	 5OzqudxAFSsq8tZo3sc8I+aTR4kn7coF15d21k3N9GIaH9jT9ndo+DltMhNbzbRXZU
	 1dEPgbgITck15NRBCQa72jT9PMVw+Whg4QbbMjBA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Petr Malat <oss@malat.biz>,
	Tejun Heo <tj@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 742/957] cgroup: Increment nr_dying_subsys_* from rmdir context
Date: Wed, 20 May 2026 18:20:25 +0200
Message-ID: <20260520162150.651796650@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162134.554764788@linuxfoundation.org>
References: <20260520162134.554764788@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-251953-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,malat.biz:email]
X-Rspamd-Queue-Id: A9A99596421
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/cgroup/cgroup.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index b60fc0b2c6036..1239bff9a994c 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5773,16 +5773,6 @@ static void offline_css(struct cgroup_subsys_state *css)
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
@@ -6094,6 +6084,8 @@ static void css_killed_ref_fn(struct percpu_ref *ref)
  */
 static void kill_css(struct cgroup_subsys_state *css)
 {
+	struct cgroup_subsys *ss = css->ss;
+
 	lockdep_assert_held(&cgroup_mutex);
 
 	if (css->flags & CSS_DYING)
@@ -6130,6 +6122,16 @@ static void kill_css(struct cgroup_subsys_state *css)
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
-- 
2.53.0




