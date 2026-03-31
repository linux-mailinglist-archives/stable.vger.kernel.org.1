Return-Path: <stable+bounces-231789-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBeWB2b/y2kJNQYAu9opvQ
	(envelope-from <stable+bounces-231789-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:07:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3D336DED8
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4B4D53080908
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84565425CD4;
	Tue, 31 Mar 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RaktPHPl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479F23E559E;
	Tue, 31 Mar 2026 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975073; cv=none; b=pfjGxefVHroXj5mtjpfWRwNi0WD33etCMrP5SbrFiBEus9Rcea2jmBLSa4M46VQfqBeE4ghfWWHFptKVcU+Kh58TOeNTsBd4n0K3cIvNnyIfca6YZjQ2Pbj2Yv3/YMcecZcpyfh76Xs2CH5cOFkznSm2sZmAhfkOWq9rO9cj68g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975073; c=relaxed/simple;
	bh=TfJ83+5+T56leZpFafVk3ZyJDyBwdET29BP1UjiqPkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b7kyPzKzC8TD2P1L8A1sO3RaF8zY5MFNQ/AWdj50n7ITBlNySZu9yxF8do0rflFnb5Xp3TW0nlLqR2DEUGUYcdD3ymUjuK2yY60QobSKuzO4peTZnepwa3xh09mVNUawTuU2eiN7LbU0bCEdqtpzM9uCxeSEoMnwILP32Y6E29E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RaktPHPl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25BFC19423;
	Tue, 31 Mar 2026 16:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975073;
	bh=TfJ83+5+T56leZpFafVk3ZyJDyBwdET29BP1UjiqPkM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RaktPHPlccWg5+zSS9uLVi6rgK70GgUJ1Dcm2Ana6sHgrQa7hS4kOBQz5CIN6rE50
	 vzq6ypXvWBQ5eLHuxQNmG9SSz7nCBidl7reCrrMkZ0M+ThA13h3XzHSiDt1br7hoUb
	 GD9QhOw8TD7+tsOWaR2C/neOFaynbiukYmpM3aAA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chuck Lever <chuck.lever@oracle.com>,
	Christoph Hellwig <hch@lst.de>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 153/342] RDMA/rw: Fall back to direct SGE on MR pool exhaustion
Date: Tue, 31 Mar 2026 18:19:46 +0200
Message-ID: <20260331161804.638468401@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161758.909578033@linuxfoundation.org>
References: <20260331161758.909578033@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231789-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oracle.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lst.de:email,msgid.link:url,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 1F3D336DED8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 00da250c21b074ea9494c375d0117b69e5b1d0a4 ]

When IOMMU passthrough mode is active, ib_dma_map_sgtable_attrs()
produces no coalescing: each scatterlist page maps 1:1 to a DMA
entry, so sgt.nents equals the raw page count. A 1 MB transfer
yields 256 DMA entries. If that count exceeds the device's
max_sgl_rd threshold (an optimization hint from mlx5 firmware),
rdma_rw_io_needs_mr() steers the operation into the MR
registration path. Each such operation consumes one or more MRs
from a pool sized at max_rdma_ctxs -- roughly one MR per
concurrent context. Under write-intensive workloads that issue
many concurrent RDMA READs, the pool is rapidly exhausted,
ib_mr_pool_get() returns NULL, and rdma_rw_init_one_mr() returns
-EAGAIN. Upper layer protocols treat this as a fatal DMA mapping
failure and tear down the connection.

The max_sgl_rd check is a performance optimization, not a
correctness requirement: the device can handle large SGE counts
via direct posting, just less efficiently than with MR
registration. When the MR pool cannot satisfy a request, falling
back to the direct SGE (map_wrs) path avoids the connection
reset while preserving the MR optimization for the common case
where pool resources are available.

Add a fallback in rdma_rw_ctx_init() so that -EAGAIN from
rdma_rw_init_mr_wrs() triggers direct SGE posting instead of
propagating the error. iWARP devices, which mandate MR
registration for RDMA READs, and force_mr debug mode continue
to treat -EAGAIN as terminal.

Fixes: 00bd1439f464 ("RDMA/rw: Support threshold for registration vs scattering to local pages")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260313194201.5818-2-cel@kernel.org
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/rw.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
index 2522ff1cc462c..49fbfe1cef689 100644
--- a/drivers/infiniband/core/rw.c
+++ b/drivers/infiniband/core/rw.c
@@ -326,14 +326,29 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u32 port_num,
 	if (rdma_rw_io_needs_mr(qp->device, port_num, dir, sg_cnt)) {
 		ret = rdma_rw_init_mr_wrs(ctx, qp, port_num, sg, sg_cnt,
 				sg_offset, remote_addr, rkey, dir);
-	} else if (sg_cnt > 1) {
+		/*
+		 * If MR init succeeded or failed for a reason other
+		 * than pool exhaustion, that result is final.
+		 *
+		 * Pool exhaustion (-EAGAIN) from the max_sgl_rd
+		 * optimization is recoverable: fall back to
+		 * direct SGE posting. iWARP and force_mr require
+		 * MRs unconditionally, so -EAGAIN is terminal.
+		 */
+		if (ret != -EAGAIN ||
+		    rdma_protocol_iwarp(qp->device, port_num) ||
+		    unlikely(rdma_rw_force_mr))
+			goto out;
+	}
+
+	if (sg_cnt > 1)
 		ret = rdma_rw_init_map_wrs(ctx, qp, sg, sg_cnt, sg_offset,
 				remote_addr, rkey, dir);
-	} else {
+	else
 		ret = rdma_rw_init_single_wr(ctx, qp, sg, sg_offset,
 				remote_addr, rkey, dir);
-	}
 
+out:
 	if (ret < 0)
 		goto out_unmap_sg;
 	return ret;
-- 
2.53.0




