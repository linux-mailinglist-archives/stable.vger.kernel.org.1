Return-Path: <stable+bounces-224941-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGKrBTMds2mDSAAAu9opvQ
	(envelope-from <stable+bounces-224941-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:08:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA06278835
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A91C30138E9
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25429394478;
	Thu, 12 Mar 2026 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="voiB+Ipu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE37A38CFEC
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 20:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346091; cv=none; b=soaSGn5+ge3XLM6aIFQ+QfrqNS7gXl3jkFhclkIAYk8aN1/A9qQyHtxhPS656odMs9NDNrKjl1TEO6JXh0XI1gx5iA2coYSGJ2jXSWwrf7AckFr5nW/4E/DcaVlBYl2SlgyHFzkfbB+d1W7TwMpBAOveXUQ9AAeQwNrScN1KD7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346091; c=relaxed/simple;
	bh=cRaMHG4AXDO53pIcQe9AMaBe1ajjVXBuHFaUGQ6jpfU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=strVy8AHfmMjosqFEa8NDJbqDM+HixOQ16Z1zoBh93BBfA0pLZIqdefYj7xA3KdQuLH3HAh7FoXbMjVlzfYVS4MYjFDhAclWHW2d/GebHBmLO2msFuLXNJAIm4+yo/SZaDUlA3RW2Rqai9EbimFYThR6fSM1d8C70IlNKpX4QMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=voiB+Ipu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37F67C4CEF7;
	Thu, 12 Mar 2026 20:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346091;
	bh=cRaMHG4AXDO53pIcQe9AMaBe1ajjVXBuHFaUGQ6jpfU=;
	h=Subject:To:Cc:From:Date:From;
	b=voiB+Ipu44rPwwAG/DndBXe62mnjHSy12CtRivQgf4a+Smnmckgjaa8pokB9d3BZj
	 JtDdw1MkATgyYngYxlnf2shVG3STXEDGnEecQvzwuz8ofFrRhDYLyIjUct92TSVMb+
	 ElwtWaC4LfDqNaa7cHamJsvMjM16QqgcIz87ZftQ=
Subject: FAILED: patch "[PATCH] sched/fair: Adhere to place_entity() constraints" failed to apply to 6.12-stable tree
To: peterz@infradead.org,efault@gmx.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 12 Mar 2026 21:08:07 +0100
Message-ID: <2026031207-sessions-crablike-5f4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-224941-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_TO(0.00)[infradead.org,gmx.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,gmx.de:email,infradead.org:email]
X-Rspamd-Queue-Id: 1CA06278835
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x c70fc32f44431bb30f9025ce753ba8be25acbba3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026031207-sessions-crablike-5f4d@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c70fc32f44431bb30f9025ce753ba8be25acbba3 Mon Sep 17 00:00:00 2001
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue, 28 Jan 2025 15:39:49 +0100
Subject: [PATCH] sched/fair: Adhere to place_entity() constraints

Mike reports that commit 6d71a9c61604 ("sched/fair: Fix EEVDF entity
placement bug causing scheduling lag") relies on commit 4423af84b297
("sched/fair: optimize the PLACE_LAG when se->vlag is zero") to not
trip a WARN in place_entity().

What happens is that the lag of the very last entity is 0 per
definition -- the average of one element matches the value of that
element. Therefore place_entity() will match the condition skipping
the lag adjustment:

  if (sched_feat(PLACE_LAG) && cfs_rq->nr_queued && se->vlag) {

Without the 'se->vlag' condition -- it will attempt to adjust the zero
lag even though we're inserting into an empty tree.

Notably, we should have failed the 'cfs_rq->nr_queued' condition, but
don't because they didn't get updated.

Additionally, move update_load_add() after placement() as is
consistent with other place_entity() users -- this change is
non-functional, place_entity() does not use cfs_rq->load.

Fixes: 6d71a9c61604 ("sched/fair: Fix EEVDF entity placement bug causing scheduling lag")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/c216eb4ef0e0e0029c600aefc69d56681cee5581.camel@gmx.de

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5e1bd9e8464c..eb5a2572b4f8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3795,6 +3795,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 		update_entity_lag(cfs_rq, se);
 		se->deadline -= se->vruntime;
 		se->rel_deadline = 1;
+		cfs_rq->nr_queued--;
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
@@ -3821,10 +3822,11 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
-		update_load_add(&cfs_rq->load, se->load.weight);
 		place_entity(cfs_rq, se, 0);
+		update_load_add(&cfs_rq->load, se->load.weight);
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
+		cfs_rq->nr_queued++;
 
 		/*
 		 * The entity's vruntime has been adjusted, so let's check


