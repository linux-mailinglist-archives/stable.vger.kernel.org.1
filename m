Return-Path: <stable+bounces-241036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHlfOGnW62lISAAAu9opvQ
	(envelope-from <stable+bounces-241036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:45:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BAE463448
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 22:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C0EB3014B9C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 20:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C3663FF89F;
	Fri, 24 Apr 2026 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH3405rr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E38E3FF893;
	Fri, 24 Apr 2026 20:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777063467; cv=none; b=nJWj7zl9vCw3qAAdj85U0W7AgS0Ha9KuCDeMNzsSNG1JbEz8iypK9P8sod8qbNCf1Y2edcdbwIQWPOZVrqC9T48vsyQ17RPoevXZFXcln5TQTKUhj3RRfu5FpwcNI39flhyCjYT25YuDrT56XUcOWQY9CvzzhIBJGZj3UFkl+Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777063467; c=relaxed/simple;
	bh=BiFlFN0VdRAgrFVj0pqXZnbp2SG8pVL93woh7iQ3n4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxO7yW7/Jgk3i/prm9BoAG01JM+8eFH7PsZb4AJTNzaKyXyz8RudVCz0vCWYEu9etfCYY9kiASY3VtnFMI+PLcuMUF80hKZ1mGUNL/d0tO4vlH8pD3D1HkzcoSld1YOAJ/rhfO7TInhhAd3KpmIBQ+NvAPmcrjHbQSn2CbVw5/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH3405rr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25C30C19425;
	Fri, 24 Apr 2026 20:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777063467;
	bh=BiFlFN0VdRAgrFVj0pqXZnbp2SG8pVL93woh7iQ3n4w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RH3405rrbrhRvgshnSuolCsE4RmQyV6h80by5SVfgRc2hGR9hiNfXhWx0jwiRn7+I
	 7LBl+vRt3P5EPvLUulGJcOtjsvm2ZAtVEqSldW+lIVrY7WxMOWpOBcQtYnBrxaJmKa
	 DacZmBk1BrXRnn7yD+RFb4VlSQttrGnjAyPrKkYTUqIjxCPlHPvgiBoz5lkz2Z+aM3
	 WQYSNYZDCbLeXSlqCmjQlu7BkT5IQRqKZAn2VNcY10vs5drg4o5WunHMCsIxdn1KT1
	 h3vWqLTSWxbB602yxZOZTKL4/wwhy94w1CHpZDuHl+W4u4E+kcMT7g5Wt/GaPHWOmJ
	 6TpcryZVSga3g==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Chris Mason <clm@meta.com>,
	Ryan Newton <newton@meta.com>,
	Tejun Heo <tj@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 07/13] sched_ext: Use dsq->first_task instead of list_empty() in dispatch_enqueue() FIFO-tail
Date: Fri, 24 Apr 2026 10:44:12 -1000
Message-ID: <20260424204418.3809733-8-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424204418.3809733-1-tj@kernel.org>
References: <20260424204418.3809733-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 89BAE463448
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241036-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]

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
Cc: Ryan Newton <newton@meta.com>
---
 kernel/sched/ext.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 4bd1fcba50c5..045b4c914768 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -1495,11 +1495,13 @@ static void dispatch_enqueue(struct scx_sched *sch, struct rq *rq,
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
-- 
2.53.0


