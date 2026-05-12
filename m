Return-Path: <stable+bounces-245804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBC9FeNGA2ri2QEAu9opvQ
	(envelope-from <stable+bounces-245804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:27:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC961523A03
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3799E3140BDB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 974F23B5DFC;
	Tue, 12 May 2026 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JnffcA3R"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 538C43B5E03
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596445; cv=none; b=tIoidkELHnsk+mzDuDCm26Qsv0nGY0wPdfZ+SkqQ8IwFDvA4GKDQO/rcg2X3/eJPdrUbDGzCCfCyPpPQrtIQ1+oGLlO3HCmrOi2/7Coje5uSFxwE494Snm+2dSSSlvUrJt1xFrpe/gZNnrYT7m6gcBJ+R6T8BGmjyNN0NGfXWIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596445; c=relaxed/simple;
	bh=MKq5dsI3xOIRUIatOefSJKw/xSCZwX5e8CVQPFU0Oic=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=sVuhCIvvOp2R2V1uTxTSZCsUYyydnwJ9s4i2z3W4CLLp3/bnxtBLZn2Vh9NsAvstuGF3Ga5fDMUyDEadLq3rGKIrGlLU/jWWC3NebGp97gY7PQOYsa7mu79qAc8ITnRveuaqnpKnH+dbEQZysg/PYuy3NPSblm02OMlgzoXD4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JnffcA3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4398C2BCB0;
	Tue, 12 May 2026 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778596445;
	bh=MKq5dsI3xOIRUIatOefSJKw/xSCZwX5e8CVQPFU0Oic=;
	h=Subject:To:Cc:From:Date:From;
	b=JnffcA3R+Ke1NVlRXD+ypxNb/G/3huA87H7l5SDF4lxXVGHstnz5CaVT0GRaMBM9X
	 S1ZUFlMMR/7xH70PpB70fbDL3Xu3ps2+OvEhK9ic3cgecnIcpUr0Vyj897N44P6pCU
	 bs9b9m8fXcPTkAWxI6KafgtY9S5QGvHMjnD8QU9A=
Subject: FAILED: patch "[PATCH] RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()" failed to apply to 5.10-stable tree
To: jgg@ziepe.ca,jgg@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:29:00 +0200
Message-ID: <2026051200-raft-rethink-fe79@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AC961523A03
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245804-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,gregkh:email,sashiko.dev:url,ziepe.ca:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c9341307ea16b9395c2e4c9c94d8499d91fe31d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051200-raft-rethink-fe79@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c9341307ea16b9395c2e4c9c94d8499d91fe31d0 Mon Sep 17 00:00:00 2001
From: Jason Gunthorpe <jgg@ziepe.ca>
Date: Tue, 28 Apr 2026 13:17:45 -0300
Subject: [PATCH] RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()

Sashiko points out the radix_tree itself is RCU safe, but nothing ever
frees the mlx4_srq struct with RCU, and it isn't even accessed within the
RCU critical section. It also will crash if an event is delivered before
the srq object is finished initializing.

Use the spinlock since it isn't easy to make RCU work, use
refcount_inc_not_zero() to protect against partially initialized objects,
and order the refcount_set() to be after the srq is fully initialized.

Cc: stable@vger.kernel.org
Fixes: 30353bfc43a1 ("net/mlx4_core: Use RCU to perform radix tree lookup for SRQ")
Link: https://sashiko.dev/#/patchset/0-v2-1c49eeb88c48%2B91-rdma_udata_rep_jgg%40nvidia.com?part=5
Link: https://patch.msgid.link/r/12-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

diff --git a/drivers/net/ethernet/mellanox/mlx4/srq.c b/drivers/net/ethernet/mellanox/mlx4/srq.c
index dd890f5d7b72..8711689120f3 100644
--- a/drivers/net/ethernet/mellanox/mlx4/srq.c
+++ b/drivers/net/ethernet/mellanox/mlx4/srq.c
@@ -44,13 +44,14 @@ void mlx4_srq_event(struct mlx4_dev *dev, u32 srqn, int event_type)
 {
 	struct mlx4_srq_table *srq_table = &mlx4_priv(dev)->srq_table;
 	struct mlx4_srq *srq;
+	unsigned long flags;
 
-	rcu_read_lock();
+	spin_lock_irqsave(&srq_table->lock, flags);
 	srq = radix_tree_lookup(&srq_table->tree, srqn & (dev->caps.num_srqs - 1));
-	rcu_read_unlock();
-	if (srq)
-		refcount_inc(&srq->refcount);
-	else {
+	if (!srq || !refcount_inc_not_zero(&srq->refcount))
+		srq = NULL;
+	spin_unlock_irqrestore(&srq_table->lock, flags);
+	if (!srq) {
 		mlx4_warn(dev, "Async event for bogus SRQ %08x\n", srqn);
 		return;
 	}
@@ -203,8 +204,8 @@ int mlx4_srq_alloc(struct mlx4_dev *dev, u32 pdn, u32 cqn, u16 xrcd,
 	if (err)
 		goto err_radix;
 
-	refcount_set(&srq->refcount, 1);
 	init_completion(&srq->free);
+	refcount_set_release(&srq->refcount, 1);
 
 	return 0;
 


