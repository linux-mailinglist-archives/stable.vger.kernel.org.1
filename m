Return-Path: <stable+bounces-225083-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJItAn8gs2mpSQAAu9opvQ
	(envelope-from <stable+bounces-225083-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:22:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81796278E4E
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 21:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B23AF301DE23
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 20:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA53F3491D6;
	Thu, 12 Mar 2026 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2oF/CPJv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AE344DB5;
	Thu, 12 Mar 2026 20:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773346877; cv=none; b=b6z45ogpBrpAidira6mvua5zM5CsxWuVWH7jCDmZUNRE+yZsEO7EbSCboJZJVrzcCzF6N5douiibZ9JkLMJZos0IQnxPjlLd2XCkLPO/w9ABlCQZCQN5mGWJVYZNHCx2LZdF2k+xzJFtxa/98RJQPtccgSePQikYS01v7byJAzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773346877; c=relaxed/simple;
	bh=t4GXNjukBVuoN11pz6KLu1PEYQHd9p6ExbV57D76/io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClZO64lEbB6aQqbEdx6zcXIfLtYOnPpemSiFzFSarLWZEeOr6H9bW4r1IuwDHFYBX9pDDbgqclm5dy/jzevXWY2RkzUVp/Xy5waZ+GH4sr0ahmzmbbz7QaccLFqAX+JxTJ0HAxACH4t9c9d+3k3bGMS4coUrjEYYzM46L64Pe6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2oF/CPJv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3C5AC4CEF7;
	Thu, 12 Mar 2026 20:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773346877;
	bh=t4GXNjukBVuoN11pz6KLu1PEYQHd9p6ExbV57D76/io=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2oF/CPJvqGNqvMYSvZovq1gmKuZnPABl/wsF/dtfX0FbpNS6MkPnfLi01G/7O580T
	 Zl49tUBjbdr6cqAPm8UdRLZuzILQm6HVAZjFJ+ahGyk7ShsMJCv6Q2rsiqQ36JKbUT
	 m+sf6dVgW9LPwhpUj3rPwdLj2/xSk7OU3Ki3HmXQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 6.12 148/265] IB/mthca: Add missed mthca_unmap_user_db() for mthca_create_srq()
Date: Thu, 12 Mar 2026 21:08:55 +0100
Message-ID: <20260312201023.606126103@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312201018.128816016@linuxfoundation.org>
References: <20260312201018.128816016@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-225083-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,nvidia.com:email]
X-Rspamd-Queue-Id: 81796278E4E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

commit 117942ca43e2e3c3d121faae530989931b7f67e1 upstream.

Fix a user triggerable leak on the system call failure path.

Cc: stable@vger.kernel.org
Fixes: ec34a922d243 ("[PATCH] IB/mthca: Add SRQ implementation")
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Link: https://patch.msgid.link/2-v1-83e918d69e73+a9-rdma_udata_rc_jgg@nvidia.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mthca/mthca_provider.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -428,6 +428,8 @@ static int mthca_create_srq(struct ib_sr
 
 	if (context && ib_copy_to_udata(udata, &srq->srqn, sizeof(__u32))) {
 		mthca_free_srq(to_mdev(ibsrq->device), srq);
+		mthca_unmap_user_db(to_mdev(ibsrq->device), &context->uar,
+				    context->db_tab, ucmd.db_index);
 		return -EFAULT;
 	}
 
@@ -436,6 +438,7 @@ static int mthca_create_srq(struct ib_sr
 
 static int mthca_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
 {
+	mthca_free_srq(to_mdev(srq->device), to_msrq(srq));
 	if (udata) {
 		struct mthca_ucontext *context =
 			rdma_udata_to_drv_context(
@@ -446,8 +449,6 @@ static int mthca_destroy_srq(struct ib_s
 		mthca_unmap_user_db(to_mdev(srq->device), &context->uar,
 				    context->db_tab, to_msrq(srq)->db_index);
 	}
-
-	mthca_free_srq(to_mdev(srq->device), to_msrq(srq));
 	return 0;
 }
 



