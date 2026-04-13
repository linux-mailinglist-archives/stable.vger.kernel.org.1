Return-Path: <stable+bounces-236597-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDYuJ1sd3WlWaAkAu9opvQ
	(envelope-from <stable+bounces-236597-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:44:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7893EFA57
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BDF1A319BF71
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29F930EF68;
	Mon, 13 Apr 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o2TQFaAC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F7330B50A;
	Mon, 13 Apr 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097316; cv=none; b=AQavq36n3FdrNDwt/CGZ9jFCP9Wv17mf3g2R00QiuNSW8w5ukKy3Rf0NQ8NrwUv3xIPJ5okIcWm55r/G98qZjxxp8K8GP9ZnF4M3CfT6XbS3jt8CIc5+46r5YKjxPsX3sSoaMWI7qwDpag8GZ0xrMJ76tpwxNm8mX6iDjY0hIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097316; c=relaxed/simple;
	bh=JU7mJvv9t4mVEeJJ1dxCCjvGpPKvhuRGBt5IY09Akc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=toGxetR3NIhIIs1SRHP6tk5bpbX91wmClKekJ5+HwyFyU8+icy84YKJa/o614jKSoRfjAdWN4hnnLUQQ6bql2BUDQXr4ErmuXzcp+6CTYV5c1vHQSLQBKbba7s53+Rl6QeQeThw2BD9zWNbQvol8EdHmaktcqgMNU54OrALcD+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o2TQFaAC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44DCBC2BCAF;
	Mon, 13 Apr 2026 16:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097316;
	bh=JU7mJvv9t4mVEeJJ1dxCCjvGpPKvhuRGBt5IY09Akc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o2TQFaAC0EAGxdcWsK13ZQWSxt9pciCszmgqoxs4pII4dA/ABRnMuefPqWSEwgTdr
	 CgFBYLRZQdNJ/nfxw6AGUdGv9Ee0LqDaxaBC84sXqMuXYqBV2Z7O54Ge3GJ3Gs6LMp
	 JOjqOJ5wbnKYkUr+AXuHIKHPIekDDUBGmDReXRyk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: [PATCH 5.15 057/570] IB/mthca: Add missed mthca_unmap_user_db() for mthca_create_srq()
Date: Mon, 13 Apr 2026 17:53:08 +0200
Message-ID: <20260413155832.577338124@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236597-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0D7893EFA57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -436,6 +436,8 @@ static int mthca_create_srq(struct ib_sr
 
 	if (context && ib_copy_to_udata(udata, &srq->srqn, sizeof(__u32))) {
 		mthca_free_srq(to_mdev(ibsrq->device), srq);
+		mthca_unmap_user_db(to_mdev(ibsrq->device), &context->uar,
+				    context->db_tab, ucmd.db_index);
 		return -EFAULT;
 	}
 
@@ -444,6 +446,7 @@ static int mthca_create_srq(struct ib_sr
 
 static int mthca_destroy_srq(struct ib_srq *srq, struct ib_udata *udata)
 {
+	mthca_free_srq(to_mdev(srq->device), to_msrq(srq));
 	if (udata) {
 		struct mthca_ucontext *context =
 			rdma_udata_to_drv_context(
@@ -454,8 +457,6 @@ static int mthca_destroy_srq(struct ib_s
 		mthca_unmap_user_db(to_mdev(srq->device), &context->uar,
 				    context->db_tab, to_msrq(srq)->db_index);
 	}
-
-	mthca_free_srq(to_mdev(srq->device), to_msrq(srq));
 	return 0;
 }
 



