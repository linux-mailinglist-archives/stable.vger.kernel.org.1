Return-Path: <stable+bounces-142604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF9EAAEB62
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 21:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9D61C09205
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 19:06:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F8A2144BF;
	Wed,  7 May 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zsiESnIF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1DC28DF2A;
	Wed,  7 May 2025 19:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644765; cv=none; b=JEwLetGuViKgm0xXbcEMKUZFGt1FcCW+dAOQPntQijxezFL6Dno2MCAbPfiIMoWYNgVBXR+8JMuguXfcnf6TrY2U6VLo+8NWtvr7vVAVt+s5VFNWORoQbZlL2BRrCHcu+hu56wnuholBzIy8RoK/m9vc96vOACg/7yAjVOXjQKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644765; c=relaxed/simple;
	bh=9rWIiAqIFCyt/x/ZgnR+je6y9YvT7NXY+xFSDpXFhjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iek4VJNeZMg/NjtD3gOXHzh7d8uzz3sNdCzeL70NmO0CGMkufDU11T1wGJbgHvRy+CcWpBPCjkCq1dqDfYXnYc4gaTEQyOx9OtEx4NshNLXvuDyRT8lK+c2PXwvpBjX/aQagmYgTH18dsntUtCZvAQ1sFTma2V1geXbeU+gTIPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zsiESnIF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3429C4CEE2;
	Wed,  7 May 2025 19:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644765;
	bh=9rWIiAqIFCyt/x/ZgnR+je6y9YvT7NXY+xFSDpXFhjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zsiESnIFjRbH4V4NhPKj2jJSPIbfmxxGgB2YZjEdT7mjj/m0WaHnrohwsz4z2Ke28
	 +XGU4ihiSGq4CGB0PdW/9dq028HDXhrJgradYs2VDRfP8ZnVnXnZTjtISNhZLoB0+4
	 GfIeSLSe4eB6zIF7qbF29WJTBE2T1Mfc3osNe6pc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerrard Tai <gerrard.tai@starlabs.sg>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12 149/164] sch_hfsc: make hfsc_qlen_notify() idempotent
Date: Wed,  7 May 2025 20:40:34 +0200
Message-ID: <20250507183827.004283754@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183820.781599563@linuxfoundation.org>
References: <20250507183820.781599563@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

commit 51eb3b65544c9efd6a1026889ee5fb5aa62da3bb upstream.

hfsc_qlen_notify() is not idempotent either and not friendly
to its callers, like fq_codel_dequeue(). Let's make it idempotent
to ease qdisc_tree_reduce_backlog() callers' life:

1. update_vf() decreases cl->cl_nactive, so we can check whether it is
non-zero before calling it.

2. eltree_remove() always removes RB node cl->el_node, but we can use
   RB_EMPTY_NODE() + RB_CLEAR_NODE() to make it safe.

Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20250403211033.166059-4-xiyou.wangcong@gmail.com
Acked-by: Jamal Hadi Salim <jhs@mojatatu.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/sched/sch_hfsc.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -203,7 +203,10 @@ eltree_insert(struct hfsc_class *cl)
 static inline void
 eltree_remove(struct hfsc_class *cl)
 {
-	rb_erase(&cl->el_node, &cl->sched->eligible);
+	if (!RB_EMPTY_NODE(&cl->el_node)) {
+		rb_erase(&cl->el_node, &cl->sched->eligible);
+		RB_CLEAR_NODE(&cl->el_node);
+	}
 }
 
 static inline void
@@ -1225,7 +1228,8 @@ hfsc_qlen_notify(struct Qdisc *sch, unsi
 	/* vttree is now handled in update_vf() so that update_vf(cl, 0, 0)
 	 * needs to be called explicitly to remove a class from vttree.
 	 */
-	update_vf(cl, 0, 0);
+	if (cl->cl_nactive)
+		update_vf(cl, 0, 0);
 	if (cl->cl_flags & HFSC_RSC)
 		eltree_remove(cl);
 }



