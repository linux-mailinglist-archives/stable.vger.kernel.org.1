Return-Path: <stable+bounces-246591-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qMdgAqxxA2q55wEAu9opvQ
	(envelope-from <stable+bounces-246591-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:30:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F8E527A59
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:30:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B901F30595AF
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57568366831;
	Tue, 12 May 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wyE9CB8E"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D3A364959;
	Tue, 12 May 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609618; cv=none; b=a377ecyhnRJsgSnBI7zae5PF6S1gjI3wVDHmKQk1njzQxuyAkJfBbI2hC7ujR6o7DzPwofUUl3TysN1yb1Z61SEXy1l/qrK4NfZa57yoTpXk2JfGCFadsAstubkvLSb/ehZWKi4xnJm/6gbuzG/2NYHkjBEgkiarRJTXlUidouU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609618; c=relaxed/simple;
	bh=TEh8kxenU2OWLIglqZHAErCa133EZhFh48f4n+j0IwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9H4YJjL6NV6h3CeLLwHnc75URf03g3WsMToOsFcJ3Mj37yqOSN3wyE3Jx2mxpilR59Mk8T5AKRDagGE3w82L8cLEEO04Wi7sf6M35mBqOaSEL8M0CdXT5/Hws1dRAEjToKROAftO4l0NPGwnw5AKoAb2MpiV9+deTd8Z+Lq3yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wyE9CB8E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E60C2BCB0;
	Tue, 12 May 2026 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609617;
	bh=TEh8kxenU2OWLIglqZHAErCa133EZhFh48f4n+j0IwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wyE9CB8E+haKSCf5xhVWlKVk8UGcEj5wbCAs/x02Pn+yxvVMAZ/3RmfLPfPCZZVrp
	 W5RaoBJMF/h0ZoAmMZfl/uzxGwNuO33yMeIfBhqxqDHO2WolskSCwSGHHZScq33trO
	 WDtA9XI7R12X60oBXEZ5NQZu1gambiIK7B4J1MnI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Mason <clm@meta.com>,
	Tejun Heo <tj@kernel.org>,
	Andrea Righi <arighi@nvidia.com>,
	Ryan Newton <newton@meta.com>
Subject: [PATCH 7.0 248/307] sched_ext: Use dsq->first_task instead of list_empty() in dispatch_enqueue() FIFO-tail
Date: Tue, 12 May 2026 19:40:43 +0200
Message-ID: <20260512173945.360002090@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 88F8E527A59
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246591-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,nvidia.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tejun Heo <tj@kernel.org>

commit 2f2ea77092660b53bfcbc4acc590b57ce9ab5dce upstream.

dispatch_enqueue()'s FIFO-tail path used list_empty(&dsq->list) to decide
whether to set dsq->first_task on enqueue. dsq->list can contain parked BPF
iterator cursors (SCX_DSQ_LNODE_ITER_CURSOR), so list_empty() is not a
reliable "no real task" check. If the last real task is unlinked while a
cursor is parked, first_task becomes NULL; the next FIFO-tail enqueue then
sees list_empty() == false and skips the first_task update, leaving
scx_bpf_dsq_peek() returning NULL for a non-empty DSQ.

Test dsq->first_task directly, which already tracks only real tasks and is
maintained under dsq->lock.

Fixes: 44f5c8ec5b9a ("sched_ext: Add lockless peek operation for DSQs")
Cc: stable@vger.kernel.org # v6.19+
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: Andrea Righi <arighi@nvidia.com>
Cc: Ryan Newton <newton@meta.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/sched/ext.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1093,11 +1093,13 @@ static void dispatch_enqueue(struct scx_
 			if (!(dsq->id & SCX_DSQ_FLAG_BUILTIN))
 				rcu_assign_pointer(dsq->first_task, p);
 		} else {
-			bool was_empty;
-
-			was_empty = list_empty(&dsq->list);
+			/*
+			 * dsq->list can contain parked BPF iterator cursors, so
+			 * list_empty() here isn't a reliable proxy for "no real
+			 * task in the DSQ". Test dsq->first_task directly.
+			 */
 			list_add_tail(&p->scx.dsq_list.node, &dsq->list);
-			if (was_empty && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
+			if (!dsq->first_task && !(dsq->id & SCX_DSQ_FLAG_BUILTIN))
 				rcu_assign_pointer(dsq->first_task, p);
 		}
 	}



