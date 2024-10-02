Return-Path: <stable+bounces-79069-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA98198D66A
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6E21C222CE
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD8951D07B0;
	Wed,  2 Oct 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S3FgLrlv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA5A1D07AB;
	Wed,  2 Oct 2024 13:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727876348; cv=none; b=LkzuwgKudXfKE0saTN4GtmnUBdJRr4bAm+rEyWtdVjsqhVmSQ4acjFiJ1dLRwNDrafnnaLqwkauSGkoKLq6mU3H1WpltxeE2vzY2PqtCiUhf8f7yFJct31LA2JcYWtbyLZqOKGEAU+w9uPrfCE3wTKATxqt5gGOV0j4brb1cYTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727876348; c=relaxed/simple;
	bh=42qQH5Js/ZWe3pXskT/naUg24zQMFuGU/S14RmHODEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t1SGwSjc+55FxRzPhix0zxikrGmhS5hQ6DvTVwYEsVEt1kO9Nu8tUmkJd//KmgqV3OU8PoF8OMPYnVM9MVoJTnqQbIddfPhMd6qxD5bNAXl6tGwwarxA6j1aaGnMiZeWt1f7cRoF8MKcPHNfckTCMC6bKrCnQ3tw4CHQOAgN9k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S3FgLrlv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0795AC4CEC5;
	Wed,  2 Oct 2024 13:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727876348;
	bh=42qQH5Js/ZWe3pXskT/naUg24zQMFuGU/S14RmHODEY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S3FgLrlvYIlrUArTC5uggc8OCWj/qEKQ+8SvinhzgZRPXNUMHq54vGXOo0I/k4nke
	 pdHQC9j9CvzQmb3OreiOBH8TJOGbceJDj4Zr7kyLe0CoeeC8x2xlCHBvW4+34bWEJh
	 OYiVMkIsapUbT0pJ0SlcYq2doa68Rh882u6BWeQE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Leon Romanovsky <leon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 413/695] RDMA/hns: Fix spin_unlock_irqrestore() called with IRQs enabled
Date: Wed,  2 Oct 2024 14:56:51 +0200
Message-ID: <20241002125838.937090769@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chengchang Tang <tangchengchang@huawei.com>

[ Upstream commit 74d315b5af180220d561684d15897730135733a6 ]

Fix missuse of spin_lock_irq()/spin_unlock_irq() when
spin_lock_irqsave()/spin_lock_irqrestore() was hold.

This was discovered through the lock debugging, and the corresponding
log is as follows:

raw_local_irq_restore() called with IRQs enabled
WARNING: CPU: 96 PID: 2074 at kernel/locking/irqflag-debug.c:10 warn_bogus_irq_restore+0x30/0x40
...
Call trace:
 warn_bogus_irq_restore+0x30/0x40
 _raw_spin_unlock_irqrestore+0x84/0xc8
 add_qp_to_list+0x11c/0x148 [hns_roce_hw_v2]
 hns_roce_create_qp_common.constprop.0+0x240/0x780 [hns_roce_hw_v2]
 hns_roce_create_qp+0x98/0x160 [hns_roce_hw_v2]
 create_qp+0x138/0x258
 ib_create_qp_kernel+0x50/0xe8
 create_mad_qp+0xa8/0x128
 ib_mad_port_open+0x218/0x448
 ib_mad_init_device+0x70/0x1f8
 add_client_context+0xfc/0x220
 enable_device_and_get+0xd0/0x140
 ib_register_device.part.0+0xf4/0x1c8
 ib_register_device+0x34/0x50
 hns_roce_register_device+0x174/0x3d0 [hns_roce_hw_v2]
 hns_roce_init+0xfc/0x2c0 [hns_roce_hw_v2]
 __hns_roce_hw_v2_init_instance+0x7c/0x1d0 [hns_roce_hw_v2]
 hns_roce_hw_v2_init_instance+0x9c/0x180 [hns_roce_hw_v2]

Fixes: 9a4435375cd1 ("IB/hns: Add driver files for hns RoCE driver")
Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
Link: https://patch.msgid.link/20240906093444.3571619-6-huangjunxian6@hisilicon.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/hw/hns/hns_roce_qp.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
index 1de384ce4d0e1..6b03ba671ff8f 100644
--- a/drivers/infiniband/hw/hns/hns_roce_qp.c
+++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
@@ -1460,19 +1460,19 @@ void hns_roce_lock_cqs(struct hns_roce_cq *send_cq, struct hns_roce_cq *recv_cq)
 		__acquire(&send_cq->lock);
 		__acquire(&recv_cq->lock);
 	} else if (unlikely(send_cq != NULL && recv_cq == NULL)) {
-		spin_lock_irq(&send_cq->lock);
+		spin_lock(&send_cq->lock);
 		__acquire(&recv_cq->lock);
 	} else if (unlikely(send_cq == NULL && recv_cq != NULL)) {
-		spin_lock_irq(&recv_cq->lock);
+		spin_lock(&recv_cq->lock);
 		__acquire(&send_cq->lock);
 	} else if (send_cq == recv_cq) {
-		spin_lock_irq(&send_cq->lock);
+		spin_lock(&send_cq->lock);
 		__acquire(&recv_cq->lock);
 	} else if (send_cq->cqn < recv_cq->cqn) {
-		spin_lock_irq(&send_cq->lock);
+		spin_lock(&send_cq->lock);
 		spin_lock_nested(&recv_cq->lock, SINGLE_DEPTH_NESTING);
 	} else {
-		spin_lock_irq(&recv_cq->lock);
+		spin_lock(&recv_cq->lock);
 		spin_lock_nested(&send_cq->lock, SINGLE_DEPTH_NESTING);
 	}
 }
@@ -1492,13 +1492,13 @@ void hns_roce_unlock_cqs(struct hns_roce_cq *send_cq,
 		spin_unlock(&recv_cq->lock);
 	} else if (send_cq == recv_cq) {
 		__release(&recv_cq->lock);
-		spin_unlock_irq(&send_cq->lock);
+		spin_unlock(&send_cq->lock);
 	} else if (send_cq->cqn < recv_cq->cqn) {
 		spin_unlock(&recv_cq->lock);
-		spin_unlock_irq(&send_cq->lock);
+		spin_unlock(&send_cq->lock);
 	} else {
 		spin_unlock(&send_cq->lock);
-		spin_unlock_irq(&recv_cq->lock);
+		spin_unlock(&recv_cq->lock);
 	}
 }
 
-- 
2.43.0




