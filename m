Return-Path: <stable+bounces-236176-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOn/LOsV3WkOZQkAu9opvQ
	(envelope-from <stable+bounces-236176-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:12:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CEA3EE6C2
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 591D930B44B6
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12EA257844;
	Mon, 13 Apr 2026 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n09HWg/d"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3AC523EA94;
	Mon, 13 Apr 2026 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096238; cv=none; b=nkKmjTL550vRVacFElNaggorwSCpoPrIJZJEUgUtYLvuQE21qauoNxwPnKXsWgg8PAO8T8wIHsGhK7+t05nrnb6MoZrRyCWhHdioz5GEq9VbaVzUs6ToLk7G5LSSq4oEcdX2x6t7p8LYd2YIjI++H8tWR6+EhV+dcBJNX8ff3P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096238; c=relaxed/simple;
	bh=ZzIRwurJPnSAFG+JdPj+RbyObskESdeEelNWELd/W6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wy8UjuZq1WsF+2NVmrvDfKkSun4EHrXbIP/CDVRrHqD316cqd0LucbYa55vaMC2z5VVQ75fK7OeUn++S0OTQtaBxgQUKC1Wy0FQhCHBytTnPolK2Dl9lPNzLmv4xVv4zwHsoJrqbqc09G5Gsj0LrvIIdjCBVwQJngm821UX5XiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n09HWg/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D78C2BCB4;
	Mon, 13 Apr 2026 16:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096238;
	bh=ZzIRwurJPnSAFG+JdPj+RbyObskESdeEelNWELd/W6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n09HWg/d4M7+ifznep9F5EGHK5zaSAM/+CWCkwuYr/CBzJptHRKCwPNbwFM/kKq6z
	 t1lhetr0s3XAoey0jU0F1uWwoFSuGFCI6d3ZLfdFmKUwayRsQ6Yo2dhKe5Y/S0fiHc
	 an4tg+AdS7bMokWRtrrfXeyywqqyBO89xiZB2a/w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Carlos Santa <carlos.santa@intel.com>,
	Ryan Neph <ryanneph@google.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 6.19 20/86] workqueue: Add pool_workqueue to pending_pwqs list when unplugging multiple inactive works
Date: Mon, 13 Apr 2026 17:59:27 +0200
Message-ID: <20260413155732.332587971@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,google.com,gmail.com,redhat.com,vger.kernel.org,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236176-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 32CEA3EE6C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matthew Brost <matthew.brost@intel.com>

commit 703ccb63ae9f7444d6ff876d024e17f628103c69 upstream.

In unplug_oldest_pwq(), the first inactive work item on the
pool_workqueue is activated correctly. However, if multiple inactive
works exist on the same pool_workqueue, subsequent works fail to
activate because wq_node_nr_active.pending_pwqs is empty — the list
insertion is skipped when the pool_workqueue is plugged.

Fix this by checking for additional inactive works in
unplug_oldest_pwq() and updating wq_node_nr_active.pending_pwqs
accordingly.

Fixes: 4c065dbce1e8 ("workqueue: Enable unbound cpumask update on ordered workqueues")
Cc: stable@vger.kernel.org
Cc: Carlos Santa <carlos.santa@intel.com>
Cc: Ryan Neph <ryanneph@google.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Waiman Long <longman@redhat.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Matthew Brost <matthew.brost@intel.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/workqueue.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1849,8 +1849,20 @@ static void unplug_oldest_pwq(struct wor
 	raw_spin_lock_irq(&pwq->pool->lock);
 	if (pwq->plugged) {
 		pwq->plugged = false;
-		if (pwq_activate_first_inactive(pwq, true))
+		if (pwq_activate_first_inactive(pwq, true)) {
+			/*
+			 * While plugged, queueing skips activation which
+			 * includes bumping the nr_active count and adding the
+			 * pwq to nna->pending_pwqs if the count can't be
+			 * obtained. We need to restore both for the pwq being
+			 * unplugged. The first call activates the first
+			 * inactive work item and the second, if there are more
+			 * inactive, puts the pwq on pending_pwqs.
+			 */
+			pwq_activate_first_inactive(pwq, false);
+
 			kick_pool(pwq->pool);
+		}
 	}
 	raw_spin_unlock_irq(&pwq->pool->lock);
 }



