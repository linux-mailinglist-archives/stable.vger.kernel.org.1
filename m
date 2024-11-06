Return-Path: <stable+bounces-90736-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769EF9BEA34
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C9CC2817A8
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 12:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87B31F76B6;
	Wed,  6 Nov 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Pg+vhWsm"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76CF01F6697;
	Wed,  6 Nov 2024 12:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896661; cv=none; b=MyvouCbFFafy1EDiEpMcotTgE1WywCU85achXvs6T+cp4a/+MhCnh48EYb7a6u/+ogsBP4fUnuIIF9qTF3T4FhJ0kzTwiJ/iewkA6lRK76DrWc9qZqG2HQFmsE43L/wvwFFFjptTR+acusW2mJkLW45QlnO7sJ/iJPnJRipv01I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896661; c=relaxed/simple;
	bh=W5s7o+mQ+/wRZSoRbNVslR3oBWoyT7hnGETduic6YnI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UfZjQop5nsmPVm+mx4XL46IB7L2pB0ccNcqLzZOFVom6+g0BKOVloznigqDpaAsoOJNpH34K4kGXaQXu2ruBpGhqqrTkK6FqNV1RRC92qEloetGq9zdgTLyhHPdyOQyrCQ8KnwO+X+mx6cv4pIss8e1W1qQ4IVIRYXJBBTcbMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Pg+vhWsm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED6EC4CED4;
	Wed,  6 Nov 2024 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730896661;
	bh=W5s7o+mQ+/wRZSoRbNVslR3oBWoyT7hnGETduic6YnI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pg+vhWsmbVM/0xM35GvxUtIcmgHr9q1heifbZpuYDVbChJ18EX97YSylGGwQuLvTt
	 teiqxJPixwEqoIYVEIK32e/eT4M06FZ/iAPqkgwXV1ZBVeqzqKJ1yB/Q5Ktz9GnyDr
	 RTKVvr4GAXjS1AfTudd65wUFN/T6mYP11wdNDKUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 006/110] RDMA/bnxt_re: Return more meaningful error
Date: Wed,  6 Nov 2024 13:03:32 +0100
Message-ID: <20241106120303.321685384@linuxfoundation.org>
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
index 2b0c3a86293cf..148f2c51a9460 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -245,7 +245,7 @@ int bnxt_qplib_rcfw_send_message(struct bnxt_qplib_rcfw *rcfw,
 		/* failed with status */
 		dev_err(&rcfw->pdev->dev, "cmdq[%#x]=%#x status %#x\n",
 			cookie, opcode, evnt->status);
-		rc = -EFAULT;
+		rc = -EIO;
 	}
 
 	return rc;
-- 
2.43.0




