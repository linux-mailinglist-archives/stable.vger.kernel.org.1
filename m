Return-Path: <stable+bounces-246250-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDhGAOltA2pS5wEAu9opvQ
	(envelope-from <stable+bounces-246250-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:14:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F35DC52713E
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:13:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A7089304CC1C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899833EDE79;
	Tue, 12 May 2026 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZmFulghs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA623EDE59;
	Tue, 12 May 2026 17:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608742; cv=none; b=bNxieYzOK61oKRVGb7dFCeoWDOzhxaAC1rM5jfR8Xok8FBrMmKx41USUtvbsU9d7Xw8Sq1Z3R9e68hdP1Sp0WSn56qLM97X3f/fet9Q4/DWIp5bU64G/b/nw9TSPp977h4O0V3AP6cGDXYV+ekXmUk76svEj1xuD8rxbsxuyUH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608742; c=relaxed/simple;
	bh=LoH7y5RhFiCCMZ91x7NvMe1ks31tzHrvqxxEgyz9aV0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZ0Do7nL+LMj+RRj+J4zRNYNGeVlLhTEuz7lCrBVo+B8CnTP06fYNspl7MONwO/63E1RXOvHKZrG6w4yP7qyLuBA+2JU97gAs5Cfbch4BOZ0rSVrGetgQIDKtt7JEwK1T3WwtmlcwbBi6TafTKyFKEKbnIdJsAOV9eKV41SFzLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZmFulghs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64C7C2BCB0;
	Tue, 12 May 2026 17:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608742;
	bh=LoH7y5RhFiCCMZ91x7NvMe1ks31tzHrvqxxEgyz9aV0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZmFulghscdQU5SRElakuqMYouZKMYOeIEt+zzpezFJgE77r3eUOPfgi20xIGdA8l1
	 Dmgag9Dk95yqU0k/7hPYuKSAlWHej49NU9j3YLaUnXrdd8VmgMp8yfNM/LTVMGURnw
	 Fcvs33g/NU52p8/zEpQwQeROEXrNmuMJP9/nAWcI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Long Li <longli@microsoft.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 6.18 196/270] RDMA/mana: Remove user triggerable WARN_ON() in mana_ib_create_qp_rss()
Date: Tue, 12 May 2026 19:39:57 +0200
Message-ID: <20260512173942.575892062@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: F35DC52713E
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
	TAGGED_FROM(0.00)[bounces-246250-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,sashiko.dev:url,msgid.link:url,nvidia.com:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

commit 159f2efabc89d3f931d38f2d35876535d4abf0a3 upstream.

Sashiko points out that the user can specify WQs sharing the same CQ as a
part of the uAPI and this will trigger the WARN_ON() then go on to corrupt
the kernel.

Just reject it outright and fail the QP creation.

Cc: stable@vger.kernel.org
Fixes: c15d7802a424 ("RDMA/mana_ib: Add CQ interrupt support for RAW QP")
Link: https://sashiko.dev/#/patchset/0-v2-1c49eeb88c48%2B91-rdma_udata_rep_jgg%40nvidia.com?part=1
Link: https://patch.msgid.link/r/5-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com
Reviewed-by: Long Li <longli@microsoft.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mana/cq.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/mana/cq.c
+++ b/drivers/infiniband/hw/mana/cq.c
@@ -144,8 +144,9 @@ int mana_ib_install_cq_cb(struct mana_ib
 
 	if (cq->queue.id >= gc->max_num_cqs)
 		return -EINVAL;
-	/* Create CQ table entry */
-	WARN_ON(gc->cq_table[cq->queue.id]);
+	/* Create CQ table entry, sharing a CQ between WQs is not supported */
+	if (gc->cq_table[cq->queue.id])
+		return -EINVAL;
 	if (cq->queue.kmem)
 		gdma_cq = cq->queue.kmem;
 	else



