Return-Path: <stable+bounces-90725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 603D29BEA02
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:39:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 245E02821C4
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D421F472B;
	Wed,  6 Nov 2024 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KGrJhfBc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6611EF95B;
	Wed,  6 Nov 2024 12:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896628; cv=none; b=HnAU7adljSnvGf8eP75rMyubHW7rTlkjqliNPrUhwq5niai49DMdkbdO7iAMdalGM6Q/CKzC8I9AJN4zN/Uog9V+9L6gwHU8+JEqPsYUjw/MIJ2YP+/Co1/Lx0AIUI2CLw4IQHI05VVjW4t2rrJ54XS+mRTFnBxy4Tsbqj2/aEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896628; c=relaxed/simple;
	bh=1Rlk/7/RshM4q6k+whdEJKT/t23jJEU4rIjsk9xo5Xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nlMnlBgiJmCaLNI0N32CBN8HqJF5u91ThT5LjrpdUFKYFGVuzE+EhJNer8bj5wMLKVckypje0Fe+v7l9C1FFpAbHjIh2+CPmtWJ0PBzqh2e9LGeO54rhZUMdNamH37VntQSHhV5Yfb/Pt9afG7DZ6q9QsAv6KlWmYjYtHlUaJ0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KGrJhfBc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F2A9C4CECD;
	Wed,  6 Nov 2024 12:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896628;
	bh=1Rlk/7/RshM4q6k+whdEJKT/t23jJEU4rIjsk9xo5Xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KGrJhfBcBU6Nca8exlcj1K50YDFJ7YQ1CcJ3W+asf0q7SQ3NVkx99An6Q0ORmQuJk
	 K1CjhWqLmsBsGjC3l8g5A04tiY0WDQ9PEURhTJRUkod50rvLJP/PthbCMdMegKm307
	 ZXx/7LJCgPMCVjpHr5FNkPY+niQebIfyXW83K6pI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 002/110] RDMA/bnxt_re: Add a check for memory allocation
Date: Wed,  6 Nov 2024 13:03:28 +0100
Message-ID: <20241106120303.210108692@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120303.135636370@linuxfoundation.org>
References: <20241106120303.135636370@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit c5c1ae73b7741fa3b58e6e001b407825bb971225 ]

__alloc_pbl() can return error when memory allocation fails.
Driver is not checking the status on one of the instances.

Fixes: 0c4dcd602817 ("RDMA/bnxt_re: Refactor hardware queue memory allocation")
Link: https://patch.msgid.link/r/1726715161-18941-4-git-send-email-selvin.xavier@broadcom.com
Reviewed-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 123ea759f2826..2861a2bbea6e4 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -243,6 +243,8 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 			sginfo.pgsize = npde * pg_size;
 			sginfo.npages = 1;
 			rc = __alloc_pbl(res, &hwq->pbl[PBL_LVL_0], &sginfo);
+			if (rc)
+				goto fail;
 
 			/* Alloc PBL pages */
 			sginfo.npages = npbl;
-- 
2.43.0




