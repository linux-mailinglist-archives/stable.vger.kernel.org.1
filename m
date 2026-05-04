Return-Path: <stable+bounces-243343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDFFIqCq+GnHxgIAu9opvQ
	(envelope-from <stable+bounces-243343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:18:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A18DF4BF061
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 00CEA3030D23
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BA83DEAC1;
	Mon,  4 May 2026 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EJ9YGCmO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379AD3D5667;
	Mon,  4 May 2026 14:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777903642; cv=none; b=ryfRnsZODZXbY/aGu/9x2yeNcRRSClB7x4tgNTNJSjNjIUNAkJZePNnebaGXbXKwd0ze/vaR2Vezn9JuCJkVZhiuiVssNXq6NLuUw0Ads8dQLlVwW97yoapy8jSqjO1/d1Z9+9IQtYnZkthwJUqXXLIeLopvnMKaarPs5urxUJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777903642; c=relaxed/simple;
	bh=zyXB31vHTu8lvIQcLAEvkrKG2IP9+YWqDK9v/SbDiFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=un2GIimKao1W265xpluwfiTxTrdpc0Q6yH9d5Cpc6aZwpnL57IpeiIMsXbYMiLkTevXkM4CPvmlxwU73Q3ZYbMuUEnbLPDOjvSt/n83h7AflAcT8BqwTAOyB2HMPSej8X0BRbJ5kAlktUxESwFiVOl2WeKe4kjf0BhJWBxrQwh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EJ9YGCmO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFB55C2BCB8;
	Mon,  4 May 2026 14:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777903642;
	bh=zyXB31vHTu8lvIQcLAEvkrKG2IP9+YWqDK9v/SbDiFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EJ9YGCmOtOYbjCY6qqMHGjqQbLhxtWwXglvCBzdoszOmc6eB6e5FV9hNFL3luOMWG
	 6ci18AOEJ8s+sOBIukpcS95AtyRkxHkwL2QDaCcPY+aG23lUWV7lSIsPiwVlmxGGME
	 Z5uFEpln8TuN9mz4tuHYwm9fwCxaoVCN7Zoq8/o8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Andrea Righi <arighi@nvidia.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 7.0 282/307] sched_ext: Documentation: Clarify ops.dispatch() role in task lifecycle
Date: Mon,  4 May 2026 15:52:47 +0200
Message-ID: <20260504135153.404911459@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135142.814938198@linuxfoundation.org>
References: <20260504135142.814938198@linuxfoundation.org>
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
X-Rspamd-Queue-Id: A18DF4BF061
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-243343-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,nvidia.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andrea Righi <arighi@nvidia.com>

commit a313357a346839d40b3a4dec393c71bf30cbb34c upstream.

ops.dispatch() is invoked when a CPU becomes available. This can occur
when a task voluntarily yields the CPU, exhausts its time slice, or is
preempted for other reasons.

If the task is still runnable, refilling its time slice in
ops.dispatch() (either by the BPF scheduler or the sched_ext core)
allows it to continue running without triggering ops.stopping().
However, this behavior is not clearly reflected in the current task
lifecycle diagram.

Update the diagram to better represent this interaction.

Fixes: 9465f44d2df2 ("sched_ext: Documentation: Clarify time slice handling in task lifecycle")
Cc: stable@vger.kernel.org # v6.17+
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Documentation/scheduler/sched-ext.rst |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--- a/Documentation/scheduler/sched-ext.rst
+++ b/Documentation/scheduler/sched-ext.rst
@@ -320,13 +320,15 @@ by a sched_ext scheduler:
                 ops.dispatch(); /* Task is moved to a local DSQ */
             }
             ops.running();      /* Task starts running on its assigned CPU */
-            while (task->scx.slice > 0 && task is runnable)
-                ops.tick();     /* Called every 1/HZ seconds */
-            ops.stopping();     /* Task stops running (time slice expires or wait) */
 
-            /* Task's CPU becomes available */
+            while task_is_runnable(p) {
+                while (task->scx.slice > 0 && task_is_runnable(p))
+                    ops.tick();     /* Called every 1/HZ seconds */
+
+                ops.dispatch();     /* task->scx.slice can be refilled */
+            }
 
-            ops.dispatch();     /* task->scx.slice can be refilled */
+            ops.stopping();     /* Task stops running (time slice expires or wait) */
         }
 
         ops.quiescent();        /* Task releases its assigned CPU (wait) */



