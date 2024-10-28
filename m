Return-Path: <stable+bounces-88281-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C679B2544
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 07:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98BE5281840
	for <lists+stable@lfdr.de>; Mon, 28 Oct 2024 06:27:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9EC18E340;
	Mon, 28 Oct 2024 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R9Atu7MV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF1D18CC1F;
	Mon, 28 Oct 2024 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730096842; cv=none; b=FDgXCwkBAwFFdfzmxXNMIqPgqiKEUJC81gq8YuvDgq7LjQnd1JyhkKIuF9fg+aie10F9VHfLpD01CyDvvrbi1o2D0DpQu0xrSl6vsCdx9NytHKdWDaT5uFG3pgEcvpuYoXJwR8PbTtG2i/+1vpTnoJiMDaA9no0t5TXTfPyacaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730096842; c=relaxed/simple;
	bh=gZDe6wERDwtj7AD5ro1ITFfNdVAOxcB+J+vmZMDQiZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aqTuZ8DzbR45tcjRrKRwzyVm2KcJT1spwY9wtSBK65NCrHulkwP7aSK7hsk+0YsQZgkxZcSJEt6HiL6X/YHqT7bRkQuUUSAGfg2NiOdFD2yLL3Y5GQjS8hUdKW+BaNfAayl4sj+fQYLFJqXbWYw3Rh2nm5GcWg+xwW9BGnWDyR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R9Atu7MV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170C6C4CEC3;
	Mon, 28 Oct 2024 06:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730096842;
	bh=gZDe6wERDwtj7AD5ro1ITFfNdVAOxcB+J+vmZMDQiZY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R9Atu7MVh3A0VRhUCJ9gjY6FzRYoqwQJ3DpUrUamh+vtybcKptZHK42F1lq4CoOxX
	 p7tEOJ59nJLnNCcnj6KvV7MpKW6ffpNndQB7XMUERp+W8/P0LauPgI/l2ccBxPIdjg
	 JlA4hsyFgJ9r4SjbRyib1+aRhi7aVsGRNNKExoQ8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 11/80] RDMA/bnxt_re: Return more meaningful error
Date: Mon, 28 Oct 2024 07:24:51 +0100
Message-ID: <20241028062252.937412253@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028062252.611837461@linuxfoundation.org>
References: <20241028062252.611837461@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

[ Upstream commit 98647df0178df215b8239c5c365537283b2852a6 ]

When the HWRM command fails, driver currently returns -EFAULT(Bad
address). This does not look correct.

Modified to return -EIO(I/O error).

Fixes: cc1ec769b87c ("RDMA/bnxt_re: Fixing the Control path command and response handling")
Fixes: 65288a22ddd8 ("RDMA/bnxt_re: use shadow qd while posting non blocking rcfw command")
Link: https://patch.msgid.link/r/1728373302-19530-5-git-send-email-selvin.xavier@broadcom.com
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 3b8cb46551bf2..8d5557e3056c4 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -249,7 +249,7 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		/* failed with status */
 		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x status %#x\n",
 			cookie, opcode, evnt->status);
-		rc = -EFAULT;
+		rc = -EIO;
 	}
 
 	return rc;
-- 
2.43.0




