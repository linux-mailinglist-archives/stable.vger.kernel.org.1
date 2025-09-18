Return-Path: <stable+bounces-176349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E334CB36CBF
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 17:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4311C44A83
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 14:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453E735E4D5;
	Tue, 26 Aug 2025 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YOgL7l30"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB248352FC2;
	Tue, 26 Aug 2025 14:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756219427; cv=none; b=sBMXb87zfdvNwszbXfwSeOpRp6Wn4FNp7uKmbFNnGRzTKB2PA1zWx0Emk3Hp1K/HOcgyJYfOgpABk6TsINxIJrQ8dSgS/TV5jzErZrRCYhlrk52GpVApCMUJ9rRkBdJKc8oUp5PHqYH2IzmMm7c8Q0eX5rs4O+E4VLekICIIGfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756219427; c=relaxed/simple;
	bh=sTYwLo+jVaKAq3PJB5BO2CTBQ1fbQLu9Z+ejsWG2cbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzbctJUfdkstj4DwuhptVKrDUJL5HIm2aGLI4u4pjoy+L86sewkOXUoI1Ow6L3MrILdiYmf7qo5/kt58V1DUEQFhX8gxvi+VfMH9HsXSKlUdlr3CcEwOKUJaSyVMW/LwfbdzSl6FehxRxKX/iA44zQe/LVUIKlzqXLS/NFfKPpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YOgL7l30; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7D1C4CEF1;
	Tue, 26 Aug 2025 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756219427;
	bh=sTYwLo+jVaKAq3PJB5BO2CTBQ1fbQLu9Z+ejsWG2cbY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YOgL7l30vXyI2ceX7bcmGMkB7UEgJCRIOzxgExT03SKjv2FfEeURDJOD3UdubkRpH
	 L9o6KSJ9RZ69TQbSiIJ4zw5QKdkeA1MgnN1f5NLNnuLuestNJSVTf8iJPkpdUojiRU
	 5/47V+P2Ouyw2DwM2mB/PgPORq6Ly5Cjf62gnADM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerrard Tai <gerrard.tai@starlabs.sg>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Siddh Raman Pant <siddh.raman.pant@oracle.com>
Subject: [PATCH 5.4 377/403] sch_qfq: make qfq_qlen_notify() idempotent
Date: Tue, 26 Aug 2025 13:11:43 +0200
Message-ID: <20250826110917.435503588@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110905.607690791@linuxfoundation.org>
References: <20250826110905.607690791@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 55f9eca4bfe30a15d8656f915922e8c98b7f0728 upstream.

qfq_qlen_notify() always deletes its class from its active list
with list_del_init() _and_ calls qfq_deactivate_agg() when the whole list
becomes empty.

To make it idempotent, just skip everything when it is not in the active
list.

Also change other list_del()'s to list_del_init() just to be extra safe.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250403211033.166059-5-xiyou.wangcong@gmail.com
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_qfq.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -348,7 +348,7 @@ static void qfq_deactivate_class(struct
 	struct qfq_aggregate *agg = cl->agg;
 
 
-	list_del(&cl->alist); /* remove from RR queue of the aggregate */
+	list_del_init(&cl->alist); /* remove from RR queue of the aggregate */
 	if (list_empty(&agg->active)) /* agg is now inactive */
 		qfq_deactivate_agg(q, agg);
 }
@@ -482,6 +482,7 @@ static int qfq_change_class(struct Qdisc
 
 	cl->common.classid = classid;
 	cl->deficit = lmax;
+	INIT_LIST_HEAD(&cl->alist);
 
 	cl->qdisc = qdisc_create_dflt(sch->dev_queue, &pfifo_qdisc_ops,
 				      classid, NULL);
@@ -1001,7 +1002,7 @@ static struct sk_buff *agg_dequeue(struc
 	cl->deficit -= (int) len;
 
 	if (cl->qdisc->q.qlen == 0) /* no more packets, remove from list */
-		list_del(&cl->alist);
+		list_del_init(&cl->alist);
 	else if (cl->deficit < qdisc_pkt_len(cl->qdisc->ops->peek(cl->qdisc))) {
 		cl->deficit += agg->lmax;
 		list_move_tail(&cl->alist, &agg->active);
@@ -1433,6 +1434,8 @@ static void qfq_qlen_notify(struct Qdisc
 	struct qfq_sched *q = qdisc_priv(sch);
 	struct qfq_class *cl = (struct qfq_class *)arg;
 
+	if (list_empty(&cl->alist))
+		return;
 	qfq_deactivate_class(q, cl);
 }
 



