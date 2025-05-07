Return-Path: <stable+bounces-142434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85F77AAEA98
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F6369C2104
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FE128D836;
	Wed,  7 May 2025 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GFkZO5as"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3B528BA9D;
	Wed,  7 May 2025 18:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644238; cv=none; b=KKdbHVnKHYw/fe0ZPzHW1N21lsQDvOF2SnBS/+maEx55o/dbJWh5y1QiIV0tLfnzl+eYQOm34Lrx9oXTt5hyuc+PbyAWB6c8NKhVJ83tgA0lYud1ZlWiy9rqcXLQAkjUiwpEJq2DrYipCzS5P3pkdZg5OzoxD6f++95NOcDWp8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644238; c=relaxed/simple;
	bh=wj7vyevrlhh3xdOwOcqmqhNe0d6RGPwyNRjcu/UcOGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyFx6ZOwaLc5AyOmVhlHCKCDMALcp+ygD0lObXM3WnKbymGHe9xZ3LAg94tP01lAY8g7pJk/Em0E+DRj+ELsktschae3zyVk8/rh1sWB/Z0OdoQrx7QLo0n6CB1ZdnT4TnuJSzNH2bOb8TbPhM2wGWD32Rh5kyy8jVH+bimf6+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GFkZO5as; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28EBCC4CEE2;
	Wed,  7 May 2025 18:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644238;
	bh=wj7vyevrlhh3xdOwOcqmqhNe0d6RGPwyNRjcu/UcOGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GFkZO5as0pj75yZHiV88GnAnjg6iC8rH8txhATquMzJnBNxZdI2nXAudezSeRc6Pc
	 au42BqG9dcRCHWHbDIb6rLkiCkUZIn7MOWVYadte6u83Hl1cFDP6SbbbomONRcvISj
	 viAvbcFJqYX81sjbY+Zd/io2yjOtBFVUI6HtfwP4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gerrard Tai <gerrard.tai@starlabs.sg>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.14 163/183] sch_hfsc: make hfsc_qlen_notify() idempotent
Date: Wed,  7 May 2025 20:40:08 +0200
Message-ID: <20250507183831.473191807@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
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

6.14-stable review patch.  If anyone has any objections, please let me know.

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



