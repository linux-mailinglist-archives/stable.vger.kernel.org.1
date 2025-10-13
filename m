Return-Path: <stable+bounces-184826-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBDFBD42D1
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 17:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1A6B734E10E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 15:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40AA030E832;
	Mon, 13 Oct 2025 15:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1jKB56IW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F99261B9C;
	Mon, 13 Oct 2025 15:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760368546; cv=none; b=aPnoZXoF+YarmUh464yj/SF1Oy6VfvHzP/jMUmsQ/2IfRi/XjMPKXp6sqJPvuTasyemgmjfmFQN0PnxUkETbSeYbz0Tj7NRd82HJ1370D6MyBSAlTjpN0zDtL/U+LYoHrq2DSWX8FgL49uL7YOKzyPTaI2J1MWk1qEO2W7AzWDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760368546; c=relaxed/simple;
	bh=WkOET0Fr4I9tLMOyiOUkb2cNbzMi7gX3uc8/TcMdHLQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PQ4IpnNm+HGDlaI84QzmRcKXQah6ygakVHzYfmIIyFU2R4wl4s5JKg/t9lP9dYhMHnGVEs42hF5n0lt+CVVovA3R8sMT34q7dkEcyu3BoNLg9/yXbhSf9/0Feu+lsWV4qw3Lxl+10I2K0YCRo+rAtqfzueTdU0RCYj/w5nB0dq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1jKB56IW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DD91C116C6;
	Mon, 13 Oct 2025 15:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760368546;
	bh=WkOET0Fr4I9tLMOyiOUkb2cNbzMi7gX3uc8/TcMdHLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1jKB56IWiB5siHe/nTmfLukfqvkgfwUQl7Jn0qD8DZJru9zc1g666pToYDdDGxHUG
	 qM/f+V+IjnnD/mTPYeNgkHSQmGphgPKVOpFY2VGceyJZXb/aPANL6Y/Ii4zPsyAPpo
	 DslqSxdXjksIF3SHUFVJ88zXgwSgU7U+k+kr/038=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Stefan Metzmacher <metze@samba.org>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 198/262] RDMA/siw: Always report immediate post SQ errors
Date: Mon, 13 Oct 2025 16:45:40 +0200
Message-ID: <20251013144333.377920363@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013144326.116493600@linuxfoundation.org>
References: <20251013144326.116493600@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bernard Metzler <bernard.metzler@linux.dev>

[ Upstream commit fdd0fe94d68649322e391c5c27dd9f436b4e955e ]

In siw_post_send(), any immediate error encountered during processing of
the work request list must be reported to the caller, even if previous
work requests in that list were just accepted and added to the send queue.

Not reporting those errors confuses the caller, which would wait
indefinitely for the failing and potentially subsequently aborted work
requests completion.

This fixes a case where immediate errors were overwritten by subsequent
code in siw_post_send().

Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
Link: https://patch.msgid.link/r/20250923144536.103825-1-bernard.metzler@linux.dev
Suggested-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Bernard Metzler <bernard.metzler@linux.dev>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/siw/siw_verbs.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 7ca0297d68a4a..d0c0cde09f118 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -773,7 +773,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 	struct siw_wqe *wqe = tx_wqe(qp);
 
 	unsigned long flags;
-	int rv = 0;
+	int rv = 0, imm_err = 0;
 
 	if (wr && !rdma_is_kernel_res(&qp->base_qp.res)) {
 		siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
@@ -959,9 +959,17 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 	 * Send directly if SQ processing is not in progress.
 	 * Eventual immediate errors (rv < 0) do not affect the involved
 	 * RI resources (Verbs, 8.3.1) and thus do not prevent from SQ
-	 * processing, if new work is already pending. But rv must be passed
-	 * to caller.
+	 * processing, if new work is already pending. But rv and pointer
+	 * to failed work request must be passed to caller.
 	 */
+	if (unlikely(rv < 0)) {
+		/*
+		 * Immediate error
+		 */
+		siw_dbg_qp(qp, "Immediate error %d\n", rv);
+		imm_err = rv;
+		*bad_wr = wr;
+	}
 	if (wqe->wr_status != SIW_WR_IDLE) {
 		spin_unlock_irqrestore(&qp->sq_lock, flags);
 		goto skip_direct_sending;
@@ -986,15 +994,10 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
 
 	up_read(&qp->state_lock);
 
-	if (rv >= 0)
-		return 0;
-	/*
-	 * Immediate error
-	 */
-	siw_dbg_qp(qp, "error %d\n", rv);
+	if (unlikely(imm_err))
+		return imm_err;
 
-	*bad_wr = wr;
-	return rv;
+	return (rv >= 0) ? 0 : rv;
 }
 
 /*
-- 
2.51.0




