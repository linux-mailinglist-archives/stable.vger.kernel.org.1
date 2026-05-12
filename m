Return-Path: <stable+bounces-246564-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA0pOlpxA2q55wEAu9opvQ
	(envelope-from <stable+bounces-246564-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:28:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EAB5279A2
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69F5732C8DFB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41063343D9D;
	Tue, 12 May 2026 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0lYyfk2m"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00ABC284883;
	Tue, 12 May 2026 18:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609551; cv=none; b=gUxa2L0QfxSANbF9ZAHkMnfkh4ewE10QnbPtfjgcL2+Db9/WLr4knBM7SEXO3B14SpD1MG/wPIZvq1ZBA+t9uc1ll97pkyV55W3gKMv5OQGUQ1MWd7BLVRtlFyh0R6qp/+OvH9AgTj16GMYwxySPLElJhbbnzl+9joNeylbkyrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609551; c=relaxed/simple;
	bh=HYGV2yWNZaFKJicVyqj+leCG6/nKQiv98eiPOSAFaGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PnYrpwlIFbioVsaRrYKTGkTAxdL0/GHhndGJ9e4FZX9ljPn1SzpVyOiJQjyeBxHwo1VI2bbeFc81yRQ84YkjvKrSk/ZSb4dOySlmN+Hefqu9cftihE1gCX8Lg+frN6Ph/k87Tj/Jge4qAib+bFtpBuWxknaoW+lL5G74fdvbwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0lYyfk2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C182C2BCB0;
	Tue, 12 May 2026 18:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609550;
	bh=HYGV2yWNZaFKJicVyqj+leCG6/nKQiv98eiPOSAFaGc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0lYyfk2mOC2MTY0hMOxcXdF1O3Jo032kVZVXW19gYmXU629yv7VbFqGFd9AO1fKvd
	 dqjzOYpWqk/C7PeMHycNTRJNiFny8txLcJD2PQdVBS9Tzw9g2c1Fq5v0/yhlFn3QYY
	 quAlAo1elHPAJ3assEczi2uRW6T29cRvgssCkxCQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 7.0 238/307] RDMA/mlx4: Fix resource leak on error in mlx4_ib_create_srq()
Date: Tue, 12 May 2026 19:40:33 +0200
Message-ID: <20260512173945.143730999@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 64EAB5279A2
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246564-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,nvidia.com:email,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@nvidia.com>

commit c54c7e4cb679c0aaa1cb489b9c3f2cd98e63a44c upstream.

Sashiko points out that mlx4_srq_alloc() was not undone during error
unwind, add the missing call to mlx4_srq_free().

Cc: stable@vger.kernel.org
Fixes: 225c7b1feef1 ("IB/mlx4: Add a driver Mellanox ConnectX InfiniBand adapters")
Link: https://sashiko.dev/#/patchset/0-v1-e911b76a94d1%2B65d95-rdma_udata_rep_jgg%40nvidia.com?part=8
Link: https://patch.msgid.link/r/11-v1-41f3135e5565+9d2-rdma_ai_fixes1_jgg@nvidia.com
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx4/srq.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -193,13 +193,15 @@ int mlx4_ib_create_srq(struct ib_srq *ib
 	if (udata)
 		if (ib_copy_to_udata(udata, &srq->msrq.srqn, sizeof (__u32))) {
 			err = -EFAULT;
-			goto err_wrid;
+			goto err_srq;
 		}
 
 	init_attr->attr.max_wr = srq->msrq.max - 1;
 
 	return 0;
 
+err_srq:
+	mlx4_srq_free(dev->dev, &srq->msrq);
 err_wrid:
 	if (udata)
 		mlx4_ib_db_unmap_user(ucontext, &srq->db);



