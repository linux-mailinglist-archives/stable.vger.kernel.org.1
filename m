Return-Path: <stable+bounces-1604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5867E7F8080
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4182280FB2
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62B48339BE;
	Fri, 24 Nov 2023 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nWIsVbqd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E32C87B;
	Fri, 24 Nov 2023 18:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EC0FC433C7;
	Fri, 24 Nov 2023 18:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700851816;
	bh=gZPdJcWOyBrgnR3IIoOq9mu3/yWYKcRFyAaDnD7bSII=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nWIsVbqd5ElXNteCPMu3YtBQdrqI7plhpYTpuMVuuALyM5V9YDji2vJ96UXjKMuAG
	 3/AlGx7PFQB29Y390IdFAw9TH6hK3tbNyBYrMAwArND8VWxPI03jAHMlU6xJ4Wpn40
	 UFIeMkqpuzJNq2ng2mbDAjeac/RFUh1DdsSOOWcU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Longfang Liu <liulongfang@huawei.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 081/372] crypto: hisilicon/qm - prevent soft lockup in receive loop
Date: Fri, 24 Nov 2023 17:47:48 +0000
Message-ID: <20231124172013.217057020@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

From: Longfang Liu <liulongfang@huawei.com>

[ Upstream commit 33fc506d2ac514be1072499a263c3bff8c7c95a0 ]

In the scenario where the accelerator business is fully loaded.
When the workqueue receiving messages and performing callback
processing, there are a large number of messages that need to be
received, and there are continuously messages that have been
processed and need to be received.
This will cause the receive loop here to be locked for a long time.
This scenario will cause watchdog timeout problems on OS with kernel
preemption turned off.

The error logs:
watchdog: BUG: soft lockup - CPU#23 stuck for 23s! [kworker/u262:1:1407]
[ 1461.978428][   C23] Call trace:
[ 1461.981890][   C23]  complete+0x8c/0xf0
[ 1461.986031][   C23]  kcryptd_async_done+0x154/0x1f4 [dm_crypt]
[ 1461.992154][   C23]  sec_skcipher_callback+0x7c/0xf4 [hisi_sec2]
[ 1461.998446][   C23]  sec_req_cb+0x104/0x1f4 [hisi_sec2]
[ 1462.003950][   C23]  qm_poll_req_cb+0xcc/0x150 [hisi_qm]
[ 1462.009531][   C23]  qm_work_process+0x60/0xc0 [hisi_qm]
[ 1462.015101][   C23]  process_one_work+0x1c4/0x470
[ 1462.020052][   C23]  worker_thread+0x150/0x3c4
[ 1462.024735][   C23]  kthread+0x108/0x13c
[ 1462.028889][   C23]  ret_from_fork+0x10/0x18

Therefore, it is necessary to add an actively scheduled operation in the
while loop to prevent this problem.
After adding it, no matter whether the OS turns on or off the kernel
preemption function. Neither will cause watchdog timeout issues.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/crypto/hisilicon/qm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/hisilicon/qm.c b/drivers/crypto/hisilicon/qm.c
index a4a3895c74181..f9acf7ecc41be 100644
--- a/drivers/crypto/hisilicon/qm.c
+++ b/drivers/crypto/hisilicon/qm.c
@@ -841,6 +841,8 @@ static void qm_poll_req_cb(struct hisi_qp *qp)
 		qm_db(qm, qp->qp_id, QM_DOORBELL_CMD_CQ,
 		      qp->qp_status.cq_head, 0);
 		atomic_dec(&qp->qp_status.used);
+
+		cond_resched();
 	}
 
 	/* set c_flag */
-- 
2.42.0




