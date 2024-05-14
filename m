Return-Path: <stable+bounces-44948-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B920F8C5518
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33094B20E62
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:55:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01575103D;
	Tue, 14 May 2024 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tA9FQ1Sx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB3A3D0D1;
	Tue, 14 May 2024 11:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715687641; cv=none; b=oHvNji/WbTC/IK7ErXtcuaNcsQOoZKIDZVTGrHFO16MR/L87EOid/oESdwINcrJxxvC/53YtnqCPWAKdlLXnfJRxRyTUVUB2LEp/oVkBwBd3snbVP9//2PV3PlDj4zU/IeIQtnZTD9NBFD4V4E4elJMLCouEK7Uxd140dRMkZPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715687641; c=relaxed/simple;
	bh=JfLR82c6/N/rNskPed7edyVwNd1E+NifH48orcK1el0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=halYSiaQkBcaJ0/o8Y9tkmMJwysfRp6z2EdzVYoO9YmfF26TuJ60isHvr/81klXcACLc0kvFf7Ft1XE6NgKLPRPCvNyZv7niHO6V0DzIswhyP5CaQSwAvd7rSWGEY2pRAhJI0kpmDvintz7NvnbYEs0Kip5QkwvSkG6qzQusMc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tA9FQ1Sx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30629C2BD10;
	Tue, 14 May 2024 11:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715687641;
	bh=JfLR82c6/N/rNskPed7edyVwNd1E+NifH48orcK1el0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tA9FQ1SxlqaUGXYqJ+tHGfqICtDQrIousR1W/VgLnpnUsbi7POp28JPQQJdmCAefM
	 kdc8d+wTH49IVQcnuQtX8xRbqpxyJQmqIx7CT2k/aWiGsqBE8JOIzgfnC724aEthPi
	 NVKymGDLLIvhRfknkIITvKpiIzeAQhXUNEV3U4S8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexandra Winter <wintera@linux.ibm.com>,
	Simon Horman <horms@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 055/168] s390/qeth: Fix kernel panic after setting hsuid
Date: Tue, 14 May 2024 12:19:13 +0200
Message-ID: <20240514101008.766081353@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101006.678521560@linuxfoundation.org>
References: <20240514101006.678521560@linuxfoundation.org>
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

From: Alexandra Winter <wintera@linux.ibm.com>

[ Upstream commit 8a2e4d37afb8500b276e5ee903dee06f50ab0494 ]

Symptom:
When the hsuid attribute is set for the first time on an IQD Layer3
device while the corresponding network interface is already UP,
the kernel will try to execute a napi function pointer that is NULL.

Example:
---------------------------------------------------------------------------
[ 2057.572696] illegal operation: 0001 ilc:1 [#1] SMP
[ 2057.572702] Modules linked in: af_iucv qeth_l3 zfcp scsi_transport_fc sunrpc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6
nft_reject nft_ct nf_tables_set nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set nf_tables libcrc32c nfnetlink ghash_s390 prng xts aes_s390 des_s390 de
s_generic sha3_512_s390 sha3_256_s390 sha512_s390 vfio_ccw vfio_mdev mdev vfio_iommu_type1 eadm_sch vfio ext4 mbcache jbd2 qeth_l2 bridge stp llc dasd_eckd_mod qeth dasd_mod
 qdio ccwgroup pkey zcrypt
[ 2057.572739] CPU: 6 PID: 60182 Comm: stress_client Kdump: loaded Not tainted 4.18.0-541.el8.s390x #1
[ 2057.572742] Hardware name: IBM 3931 A01 704 (LPAR)
[ 2057.572744] Krnl PSW : 0704f00180000000 0000000000000002 (0x2)
[ 2057.572748]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:3 PM:0 RI:0 EA:3
[ 2057.572751] Krnl GPRS: 0000000000000004 0000000000000000 00000000a3b008d8 0000000000000000
[ 2057.572754]            00000000a3b008d8 cb923a29c779abc5 0000000000000000 00000000814cfd80
[ 2057.572756]            000000000000012c 0000000000000000 00000000a3b008d8 00000000a3b008d8
[ 2057.572758]            00000000bab6d500 00000000814cfd80 0000000091317e46 00000000814cfc68
[ 2057.572762] Krnl Code:#0000000000000000: 0000                illegal
                         >0000000000000002: 0000                illegal
                          0000000000000004: 0000                illegal
                          0000000000000006: 0000                illegal
                          0000000000000008: 0000                illegal
                          000000000000000a: 0000                illegal
                          000000000000000c: 0000                illegal
                          000000000000000e: 0000                illegal
[ 2057.572800] Call Trace:
[ 2057.572801] ([<00000000ec639700>] 0xec639700)
[ 2057.572803]  [<00000000913183e2>] net_rx_action+0x2ba/0x398
[ 2057.572809]  [<0000000091515f76>] __do_softirq+0x11e/0x3a0
[ 2057.572813]  [<0000000090ce160c>] do_softirq_own_stack+0x3c/0x58
[ 2057.572817] ([<0000000090d2cbd6>] do_softirq.part.1+0x56/0x60)
[ 2057.572822]  [<0000000090d2cc60>] __local_bh_enable_ip+0x80/0x98
[ 2057.572825]  [<0000000091314706>] __dev_queue_xmit+0x2be/0xd70
[ 2057.572827]  [<000003ff803dd6d6>] afiucv_hs_send+0x24e/0x300 [af_iucv]
[ 2057.572830]  [<000003ff803dd88a>] iucv_send_ctrl+0x102/0x138 [af_iucv]
[ 2057.572833]  [<000003ff803de72a>] iucv_sock_connect+0x37a/0x468 [af_iucv]
[ 2057.572835]  [<00000000912e7e90>] __sys_connect+0xa0/0xd8
[ 2057.572839]  [<00000000912e9580>] sys_socketcall+0x228/0x348
[ 2057.572841]  [<0000000091514e1a>] system_call+0x2a6/0x2c8
[ 2057.572843] Last Breaking-Event-Address:
[ 2057.572844]  [<0000000091317e44>] __napi_poll+0x4c/0x1d8
[ 2057.572846]
[ 2057.572847] Kernel panic - not syncing: Fatal exception in interrupt
-------------------------------------------------------------------------------------------

Analysis:
There is one napi structure per out_q: card->qdio.out_qs[i].napi
The napi.poll functions are set during qeth_open().

Since
commit 1cfef80d4c2b ("s390/qeth: Don't call dev_close/dev_open (DOWN/UP)")
qeth_set_offline()/qeth_set_online() no longer call dev_close()/
dev_open(). So if qeth_free_qdio_queues() cleared
card->qdio.out_qs[i].napi.poll while the network interface was UP and the
card was offline, they are not set again.

Reproduction:
chzdev -e $devno layer2=0
ip link set dev $network_interface up
echo 0 > /sys/bus/ccwgroup/devices/0.0.$devno/online
echo foo > /sys/bus/ccwgroup/devices/0.0.$devno/hsuid
echo 1 > /sys/bus/ccwgroup/devices/0.0.$devno/online
-> Crash (can be enforced e.g. by af_iucv connect(), ip link down/up, ...)

Note that a Completion Queue (CQ) is only enabled or disabled, when hsuid
is set for the first time or when it is removed.

Workarounds:
- Set hsuid before setting the device online for the first time
or
- Use chzdev -d $devno; chzdev $devno hsuid=xxx; chzdev -e $devno;
to set hsuid on an existing device. (this will remove and recreate the
network interface)

Fix:
There is no need to free the output queues when a completion queue is
added or removed.
card->qdio.state now indicates whether the inbound buffer pool and the
outbound queues are allocated.
card->qdio.c_q indicates whether a CQ is allocated.

Fixes: 1cfef80d4c2b ("s390/qeth: Don't call dev_close/dev_open (DOWN/UP)")
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://lore.kernel.org/r/20240430091004.2265683-1-wintera@linux.ibm.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core_main.c | 61 ++++++++++++++-----------------
 1 file changed, 27 insertions(+), 34 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 9b7f518395e16..5c69cba6459f2 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -366,30 +366,33 @@ static int qeth_cq_init(struct qeth_card *card)
 	return rc;
 }
 
+static void qeth_free_cq(struct qeth_card *card)
+{
+	if (card->qdio.c_q) {
+		qeth_free_qdio_queue(card->qdio.c_q);
+		card->qdio.c_q = NULL;
+	}
+}
+
 static int qeth_alloc_cq(struct qeth_card *card)
 {
 	if (card->options.cq == QETH_CQ_ENABLED) {
 		QETH_CARD_TEXT(card, 2, "cqon");
-		card->qdio.c_q = qeth_alloc_qdio_queue();
 		if (!card->qdio.c_q) {
-			dev_err(&card->gdev->dev, "Failed to create completion queue\n");
-			return -ENOMEM;
+			card->qdio.c_q = qeth_alloc_qdio_queue();
+			if (!card->qdio.c_q) {
+				dev_err(&card->gdev->dev,
+					"Failed to create completion queue\n");
+				return -ENOMEM;
+			}
 		}
 	} else {
 		QETH_CARD_TEXT(card, 2, "nocq");
-		card->qdio.c_q = NULL;
+		qeth_free_cq(card);
 	}
 	return 0;
 }
 
-static void qeth_free_cq(struct qeth_card *card)
-{
-	if (card->qdio.c_q) {
-		qeth_free_qdio_queue(card->qdio.c_q);
-		card->qdio.c_q = NULL;
-	}
-}
-
 static enum iucv_tx_notify qeth_compute_cq_notification(int sbalf15,
 							int delayed)
 {
@@ -2586,6 +2589,10 @@ static int qeth_alloc_qdio_queues(struct qeth_card *card)
 
 	QETH_CARD_TEXT(card, 2, "allcqdbf");
 
+	/* completion */
+	if (qeth_alloc_cq(card))
+		goto out_err;
+
 	if (atomic_cmpxchg(&card->qdio.state, QETH_QDIO_UNINITIALIZED,
 		QETH_QDIO_ALLOCATED) != QETH_QDIO_UNINITIALIZED)
 		return 0;
@@ -2626,10 +2633,6 @@ static int qeth_alloc_qdio_queues(struct qeth_card *card)
 		queue->priority = QETH_QIB_PQUE_PRIO_DEFAULT;
 	}
 
-	/* completion */
-	if (qeth_alloc_cq(card))
-		goto out_freeoutq;
-
 	return 0;
 
 out_freeoutq:
@@ -2643,6 +2646,8 @@ static int qeth_alloc_qdio_queues(struct qeth_card *card)
 	card->qdio.in_q = NULL;
 out_nomem:
 	atomic_set(&card->qdio.state, QETH_QDIO_UNINITIALIZED);
+	qeth_free_cq(card);
+out_err:
 	return -ENOMEM;
 }
 
@@ -2650,11 +2655,12 @@ static void qeth_free_qdio_queues(struct qeth_card *card)
 {
 	int i, j;
 
+	qeth_free_cq(card);
+
 	if (atomic_xchg(&card->qdio.state, QETH_QDIO_UNINITIALIZED) ==
 		QETH_QDIO_UNINITIALIZED)
 		return;
 
-	qeth_free_cq(card);
 	for (j = 0; j < QDIO_MAX_BUFFERS_PER_Q; ++j) {
 		if (card->qdio.in_q->bufs[j].rx_skb)
 			dev_kfree_skb_any(card->qdio.in_q->bufs[j].rx_skb);
@@ -3707,24 +3713,11 @@ static void qeth_qdio_poll(struct ccw_device *cdev, unsigned long card_ptr)
 
 int qeth_configure_cq(struct qeth_card *card, enum qeth_cq cq)
 {
-	int rc;
-
-	if (card->options.cq ==  QETH_CQ_NOTAVAILABLE) {
-		rc = -1;
-		goto out;
-	} else {
-		if (card->options.cq == cq) {
-			rc = 0;
-			goto out;
-		}
-
-		qeth_free_qdio_queues(card);
-		card->options.cq = cq;
-		rc = 0;
-	}
-out:
-	return rc;
+	if (card->options.cq == QETH_CQ_NOTAVAILABLE)
+		return -1;
 
+	card->options.cq = cq;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(qeth_configure_cq);
 
-- 
2.43.0




