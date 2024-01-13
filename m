Return-Path: <stable+bounces-10766-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C103082CB87
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 11:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F67F284448
	for <lists+stable@lfdr.de>; Sat, 13 Jan 2024 10:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDFADF6D;
	Sat, 13 Jan 2024 10:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="07SI4Dt3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26430111BB;
	Sat, 13 Jan 2024 10:00:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4DCC433F1;
	Sat, 13 Jan 2024 10:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705140040;
	bh=wzCWX38v3j5koHhlM411NgU279ozWn78xUCL0G9DMxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=07SI4Dt3Y8oDFwWiIFucDSA96/FHwpbu+cAr2CTHpDsj6uJUbFsm0tuUZ2BsunNdH
	 4gSmyNAJrIi/vVCm2zr64Clsyafv0Y7LcY8+XAzv9C/Kr25nODCGC8E1J2OsH5v3fz
	 RRfMDcjdJ4hSMaqp47oP5fuHWUjl081KfWda7wzo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dinghao Liu <dinghao.liu@zju.edu.cn>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 34/59] net/qla3xxx: fix potential memleak in ql_alloc_buffer_queues
Date: Sat, 13 Jan 2024 10:50:05 +0100
Message-ID: <20240113094210.356829015@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240113094209.301672391@linuxfoundation.org>
References: <20240113094209.301672391@linuxfoundation.org>
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

From: Dinghao Liu <dinghao.liu@zju.edu.cn>

[ Upstream commit 89f45c30172c80e55c887f32f1af8e184124577b ]

When dma_alloc_coherent() fails, we should free qdev->lrg_buf
to prevent potential memleak.

Fixes: 1357bfcf7106 ("qla3xxx: Dynamically size the rx buffer queue based on the MTU.")
Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
Link: https://lore.kernel.org/r/20231227070227.10527-1-dinghao.liu@zju.edu.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/qlogic/qla3xxx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qlogic/qla3xxx.c b/drivers/net/ethernet/qlogic/qla3xxx.c
index 29837e533cee8..127daad4410b9 100644
--- a/drivers/net/ethernet/qlogic/qla3xxx.c
+++ b/drivers/net/ethernet/qlogic/qla3xxx.c
@@ -2589,6 +2589,7 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
 
 	if (qdev->lrg_buf_q_alloc_virt_addr == NULL) {
 		netdev_err(qdev->ndev, "lBufQ failed\n");
+		kfree(qdev->lrg_buf);
 		return -ENOMEM;
 	}
 	qdev->lrg_buf_q_virt_addr = qdev->lrg_buf_q_alloc_virt_addr;
@@ -2613,6 +2614,7 @@ static int ql_alloc_buffer_queues(struct ql3_adapter *qdev)
 				  qdev->lrg_buf_q_alloc_size,
 				  qdev->lrg_buf_q_alloc_virt_addr,
 				  qdev->lrg_buf_q_alloc_phy_addr);
+		kfree(qdev->lrg_buf);
 		return -ENOMEM;
 	}
 
-- 
2.43.0




