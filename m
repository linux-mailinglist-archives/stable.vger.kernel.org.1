Return-Path: <stable+bounces-173303-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0162B35C6F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:34:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80167684DAD
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 11:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A52534A30F;
	Tue, 26 Aug 2025 11:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U87dwWWV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD54929D273;
	Tue, 26 Aug 2025 11:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756207899; cv=none; b=ueyGfNZwyLde2J7IXjB6oYhVG9UKeqFJVETj7G5LZ1z3Lo6kvvLUosYe/7Fj++9oneE9nxovJagRNHgcg5vTzNR9CFODTucNlI73j/0k6WxPFR4hbhS5Qx6qYJf9rAiGi2ad2j+RHtPGmnlXnk16NJHV7yR/LqOXgmOrk1DBLJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756207899; c=relaxed/simple;
	bh=L5pUcxsgRor/y763SSILTIiZv/bVZnhgBPiYczDI+lY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRRTAqzR38kfcP0i7CAPZCp+kBrfrIJRJ+vsjNWuLQvSlq7BZG+10ilSGLxw7d2cCBxMRi2zpTiE1cHzK/MrvNVGAVuUBAF9UDUR7nOJ6pKwiLpMnt42lT14N/9QX/eS6ehtGZBDEYZ1Nl3t4RrsZVt/m7sX270kZn61MpzQp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U87dwWWV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2181EC4CEF1;
	Tue, 26 Aug 2025 11:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756207895;
	bh=L5pUcxsgRor/y763SSILTIiZv/bVZnhgBPiYczDI+lY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U87dwWWVjwTAHvGGvhxaQAw2uJkoNMIN+DQC2Tpt7O2YDVqRL6uvfPU4zbCTCx5Zx
	 JhpVNf39s8vvY07S3jZMpSqYW/mjhHzt9aYG8wn+wtAlp9DLaDytRUoixZrd1LxwAW
	 bSlsw0/A6IdOZBn7mw9rD/3d4duJetuvrz0CxOB4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Cheng Xu <chengyou@linux.alibaba.com>,
	Boshi Yu <boshiyu@linux.alibaba.com>,
	Zhu Yanjun <yanjun.zhu@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 359/457] RDMA/erdma: Fix unset QPN of GSI QP
Date: Tue, 26 Aug 2025 13:10:43 +0200
Message-ID: <20250826110946.185775977@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110937.289866482@linuxfoundation.org>
References: <20250826110937.289866482@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Boshi Yu <boshiyu@linux.alibaba.com>

[ Upstream commit d4ac86b47563c7895dae28658abd1879d266b2b4 ]

The QPN of the GSI QP was not set, which may cause issues.
Set the QPN to 1 when creating the GSI QP.

Fixes: 999a0a2e9b87 ("RDMA/erdma: Support UD QPs and UD WRs")
Reviewed-by: Cheng Xu <chengyou@linux.alibaba.com>
Signed-off-by: Boshi Yu <boshiyu@linux.alibaba.com>
Link: https://patch.msgid.link/20250725055410.67520-4-boshiyu@linux.alibaba.com
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index c1b2b8c3cdcc..8d7596abb822 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -994,6 +994,8 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 		old_entry = xa_store(&dev->qp_xa, 1, qp, GFP_KERNEL);
 		if (xa_is_err(old_entry))
 			ret = xa_err(old_entry);
+		else
+			qp->ibqp.qp_num = 1;
 	} else {
 		ret = xa_alloc_cyclic(&dev->qp_xa, &qp->ibqp.qp_num, qp,
 				      XA_LIMIT(1, dev->attrs.max_qp - 1),
-- 
2.50.1




