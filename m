Return-Path: <stable+bounces-245801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGWbHJs7A2oq2AEAu9opvQ
	(envelope-from <stable+bounces-245801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:39:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB514522B9E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 16:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EFB313103EC0
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 14:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF6B93B5DFC;
	Tue, 12 May 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oREoZg55"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BAE3B442F
	for <stable@vger.kernel.org>; Tue, 12 May 2026 14:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596437; cv=none; b=pEk2ZR5naXTbjKG+HMBqMS57iTHy/DBgjKhDFV6eedxUtkbulkjKGkqzVnDVOz8xMOdrpdd5GoG+bNViTSTqx1xgitRdUav/3BgGu+whieoHutwI7AUPIrVwG2+wX0fILiu/ezi35s+WdBVL+g2qalb1jK7L5+eTLAO90FqQqd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596437; c=relaxed/simple;
	bh=kHmKl8vqK8dEvXM4+a6m0xmfxXlw6b0yFZj/onc/TYU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=NuvhNWp9GkP7yObcIcpHlTSKPARXZhZvlWPUTgrxYyPUmlgt1O0uhFFGY0chfdfMYi2aeQIoYoS7z/Rh6RUgBMwXHFaeewc7QC/yQiNcnJ3m1CFfLr+0XCExQGfkL0xiOD1FQFTA9Z2h9oEZ6zLJx5Isbm7l/H/dBcpFFkIoZyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oREoZg55; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EF2CC2BCB0;
	Tue, 12 May 2026 14:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778596437;
	bh=kHmKl8vqK8dEvXM4+a6m0xmfxXlw6b0yFZj/onc/TYU=;
	h=Subject:To:Cc:From:Date:From;
	b=oREoZg55NLysZmZPBYNCt0in85aic7aejBBs9OvOzsym5cfJAT+op5sOztySrI2hU
	 3K5YWubwQU2FY790g1eU5EuhAzyffgtQo+FtF36CH+gHFKdCBP+iMTIHqGu4YrM2dz
	 II+fLfdOa/l9tyKbqBvOXWvGCF2D2c6D95q31zhc=
Subject: FAILED: patch "[PATCH] RDMA/mlx4: Fix mis-use of RCU in mlx4_srq_event()" failed to apply to 6.6-stable tree
To: jgg@ziepe.ca,jgg@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 16:28:59 +0200
Message-ID: <2026051259-multitask-wince-b4aa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DB514522B9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245801-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gregkh:email,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,msgid.link:url,sashiko.dev:url,ziepe.ca:email]
X-Rspamd-Action: no action


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x c9341307ea16b9395c2e4c9c94d8499d91fe31d0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051259-multitask-wince-b4aa@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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
 


