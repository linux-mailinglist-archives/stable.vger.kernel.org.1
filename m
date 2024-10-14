Return-Path: <stable+bounces-84500-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AC299D07E
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A166284C09
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 329FC1AE00B;
	Mon, 14 Oct 2024 15:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1o5/Byfg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FFF3BBF2;
	Mon, 14 Oct 2024 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728918223; cv=none; b=WNapDUuxnfXRsl4b9lhqz/t9H8siCyW9JVZOhzR3YDlw65BrUyqwvtasDemVQPD4NwCaYXqOfRyLmpswiErLHXgFTDlmJa+LNrTxtiDjSTE0t7tzNcxP+6T4iim8l+wSXk7pX0IuBha+la+kU7UCeiQelF+pZ6DI0jp0gk/zDt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728918223; c=relaxed/simple;
	bh=SQvalBlYKg4lTwSuiRWn2+wcS9FIv4AaA+lg9zaeDeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f8zjD24UagPFLf4QwqABwgiZK8HlttjSmubRmruCkB4yTjDxktrnH21moG1vZCD7ReI7Uitd4exHxXJmmAirwbqjBT1FGpEMrkXkiZPHrmrt/Ezuh/j1YnclVyyHR7Lj/pl3BickkuCcWSGKVPx5dGe3gpCaJbVxpdEBGoqHFKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1o5/Byfg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5482CC4CEC3;
	Mon, 14 Oct 2024 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728918222;
	bh=SQvalBlYKg4lTwSuiRWn2+wcS9FIv4AaA+lg9zaeDeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=1o5/ByfgNgk9NhWQWvHMgSrLRwBXn+pDIwQPqxtDsTa825k8Dz9jvc4FTy/M220sf
	 jYmHqDFe6NkE7VGKo0Dq51KzFD8jC2Xrlyjb2zWADCJ9qxD9+Vucso6wHYSPssrKIL
	 GoPsMXaD2UpgnihwxfqgnshD30FMY16wSVdt7RUA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vitaliy Shevtsov <v.shevtsov@maxima.ru>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 228/798] RDMA/irdma: fix error message in irdma_modify_qp_roce()
Date: Mon, 14 Oct 2024 16:13:02 +0200
Message-ID: <20241014141226.881034928@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vitaliy Shevtsov <v.shevtsov@maxima.ru>

[ Upstream commit 9f0eafe86ea0a589676209d0cff1a1ed49a037d3 ]

Use a correct field max_dest_rd_atomic instead of max_rd_atomic for the
error output.

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: b48c24c2d710 ("RDMA/irdma: Implement device supported verb APIs")
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@maxima.ru>
Link: https://lore.kernel.org/stable/20240916165817.14691-1-v.shevtsov%40maxima.ru
Link: https://patch.msgid.link/20240916165817.14691-1-v.shevtsov@maxima.ru
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/irdma/verbs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index 76c5f461faca0..baa3dff6faab1 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -1324,7 +1324,7 @@ int irdma_modify_qp_roce(struct ib_qp *ibqp, struct ib_qp_attr *attr,
 		if (attr->max_dest_rd_atomic > dev->hw_attrs.max_hw_ird) {
 			ibdev_err(&iwdev->ibdev,
 				  "rd_atomic = %d, above max_hw_ird=%d\n",
-				   attr->max_rd_atomic,
+				   attr->max_dest_rd_atomic,
 				   dev->hw_attrs.max_hw_ird);
 			return -EINVAL;
 		}
-- 
2.43.0




