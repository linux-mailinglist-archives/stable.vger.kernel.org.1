Return-Path: <stable+bounces-108570-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667B8A0FFCC
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 04:54:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8279616411E
	for <lists+stable@lfdr.de>; Tue, 14 Jan 2025 03:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5FC1BC069;
	Tue, 14 Jan 2025 03:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="iKq6/NOB"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-233.mail.qq.com (out203-205-221-233.mail.qq.com [203.205.221.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8040B240235
	for <stable@vger.kernel.org>; Tue, 14 Jan 2025 03:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736826890; cv=none; b=bu8yer+WFYSkh03+WO21m8Q+bAQkiwT3GKFDDXx7JbK7uT5HYcn+id0gpwnKT2Z69bQFOudvjpsXN3H9znzt3G6Z7AWAqbYUe7vS2IaRm6TJnLovIrgpZg7Zz5rJ6S8SGZwIQD11H7RrNSOQRwNOYdt2XZuqo/s9Ztb1Fh/HfT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736826890; c=relaxed/simple;
	bh=yFSAsmeHtMpf1O9zleDvuOp6GdmMb9WV6Yj3TlcNul8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=s8MamoFOoQvbuKcrc0V62EDfQSXkOPJnfXKRTAIVlETyxaCxeccBTdW7y1OaPR4sDjn8jmtOYN6A+aV8BI1FBs+1MVXiOBWKfwDcLfL4G0+9xEXrZfQYDaX2NKutnhMmrqGav0AI76RFXp46WixcpVZJWIrxrPMEj2vToPScTus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=iKq6/NOB; arc=none smtp.client-ip=203.205.221.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1736826584; bh=5cJkK1L3UmIqAcQtUQJwY65ca5UXSvZBYzqF0704z/A=;
	h=From:To:Cc:Subject:Date;
	b=iKq6/NOBPSSDUAt1KKv5EkOyS/hpxs7KGiO7A9VWeeTkC59Brzuf/16g5rQjp4nAJ
	 S4b/h9dm3+Oy7KdosA6CpPEIhaFdFTvVN//L5i8UQdueMwPaC38jmXubnvLEajSOaS
	 fvZrQaf98Wm/Vld80aeiAE2VvbISIJYm6xeD/BA8=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.130])
	by newxmesmtplogicsvrszgpuc5-0.qq.com (NewEsmtp) with SMTP
	id C35852BD; Tue, 14 Jan 2025 11:48:53 +0800
X-QQ-mid: xmsmtpt1736826533ty9wg1eky
Message-ID: <tencent_92588BE248C1F834ECD126D5EC7E0048320A@qq.com>
X-QQ-XMAILINFO: MhK4DKsBP06iWCjaT0guv22qs4LbWE5K3xDab3s2P2hHX5QR4I2dHsatZjdOgd
	 48k50BA6VOtDSqsQfUJ9yZkCEdArlBSEEG6Oi1CVjUbKb0pJswOpzYtRtFM/e5bADxJOHKqNs5CF
	 SNk2U5Gpw4uX8AH7WgOHc9QdcejCj2SpT/Tn1hpmNMd/eg1HBx73Vi4qzVXJpwmt8HPECNLSMs/R
	 J8Z+lmfoOE3OHGHuJgnzfzNvyZxtlScgws+ef4qPzBJRuUKWVB6z/Hn5ObQMFN63L0KTUwvEEwMD
	 1+Uzusdidqg76kWT3LQXnBtlBdVWOlnltfk0nPhMgt2olIxz863mhMt3/Yc8Ye9cPVzmclEWSiWL
	 gI3ZYdMbQS3jzQzTcwOxaCsotrlklfxOQdOTrcJILW6Qofom1vNOLWW8V4RZzWaGH4yLDzMOUF0X
	 CvKGODZqCG0issVSf5DguxoARJ8aZhe+MBPx7EKaHnNbevY0NXqltcUSMPRP0hQohRMkU557YU+B
	 O845jhMBp4G5m/g1AFC9SEGSgCdEyJ1Ph/mA6XvRJDroq/xlGbAQIBRmGhyUWq3q8C2ECPmVvWQE
	 eHqCyY+YdabJZZX682Xl+hS18SWeeECh8XQkaNoay1b7HAqJghj38/HfyF+hREqBsDc9JwP79iQ5
	 eic6TgfBdu+U42Gnv/eroCOf49CFq6xNBVg3v0J56BHHP0rn+6g+kGOYtdWbf3U5YxIV6T9FTVlK
	 Y+0KXSKtSpTi6Vdm+M4JA8b7DsJj2bpmVwzOu/fulL0cs7IVapFdXbb9ntSYaZ0M8aIrABs04dku
	 mlQvAcYCCMXsv7BQ1vzhbNKCYAxjVb4aZJafFMtFsgQ5FKe3EKpB+mV+kqYoSJojUG5c/lpCJB3A
	 g6A32gdNyKfjDW29GxqfrGRYRtpmuN1Ygn9ud++YZVNa682wyLYnba0WQ3XCDwE10z6shMXN9C42
	 0b5qETYZqvVi0/L8YjDtMlw/rsaQ5vD+xi/LrL6Gmls6r789dEmpihnHbNXY7HI9yeYwifmv8=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: lanbincn@qq.com
To: stable@vger.kernel.org,
	yanjun.zhu@linux.dev
Cc: lanbincn@qq.com,
	leon@kernel.org
Subject: [PATCH 6.1.y] RDMA/rxe: Fix the qp flush warnings in req
Date: Tue, 14 Jan 2025 11:48:53 +0800
X-OQ-MSGID: <20250114034853.3414-1-lanbincn@qq.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Yanjun <yanjun.zhu@linux.dev>

commit ea4c990fa9e19ffef0648e40c566b94ba5ab31be upstream.

When the qp is in error state, the status of WQEs in the queue should be
set to error. Or else the following will appear.

[  920.617269] WARNING: CPU: 1 PID: 21 at drivers/infiniband/sw/rxe/rxe_comp.c:756 rxe_completer+0x989/0xcc0 [rdma_rxe]
[  920.617744] Modules linked in: rnbd_client(O) rtrs_client(O) rtrs_core(O) rdma_ucm rdma_cm iw_cm ib_cm crc32_generic rdma_rxe ip6_udp_tunnel udp_tunnel ib_uverbs ib_core loop brd null_blk ipv6
[  920.618516] CPU: 1 PID: 21 Comm: ksoftirqd/1 Tainted: G           O       6.1.113-storage+ #65
[  920.618986] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
[  920.619396] RIP: 0010:rxe_completer+0x989/0xcc0 [rdma_rxe]
[  920.619658] Code: 0f b6 84 24 3a 02 00 00 41 89 84 24 44 04 00 00 e9 2a f7 ff ff 39 ca bb 03 00 00 00 b8 0e 00 00 00 48 0f 45 d8 e9 15 f7 ff ff <0f> 0b e9 cb f8 ff ff 41 bf f5 ff ff ff e9 08 f8 ff ff 49 8d bc 24
[  920.620482] RSP: 0018:ffff97b7c00bbc38 EFLAGS: 00010246
[  920.620817] RAX: 0000000000000000 RBX: 000000000000000c RCX: 0000000000000008
[  920.621183] RDX: ffff960dc396ebc0 RSI: 0000000000005400 RDI: ffff960dc4e2fbac
[  920.621548] RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffffac406450
[  920.621884] R10: ffffffffac4060c0 R11: 0000000000000001 R12: ffff960dc4e2f800
[  920.622254] R13: ffff960dc4e2f928 R14: ffff97b7c029c580 R15: 0000000000000000
[  920.622609] FS:  0000000000000000(0000) GS:ffff960ef7d00000(0000) knlGS:0000000000000000
[  920.622979] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  920.623245] CR2: 00007fa056965e90 CR3: 00000001107f1000 CR4: 00000000000006e0
[  920.623680] Call Trace:
[  920.623815]  <TASK>
[  920.623933]  ? __warn+0x79/0xc0
[  920.624116]  ? rxe_completer+0x989/0xcc0 [rdma_rxe]
[  920.624356]  ? report_bug+0xfb/0x150
[  920.624594]  ? handle_bug+0x3c/0x60
[  920.624796]  ? exc_invalid_op+0x14/0x70
[  920.624976]  ? asm_exc_invalid_op+0x16/0x20
[  920.625203]  ? rxe_completer+0x989/0xcc0 [rdma_rxe]
[  920.625474]  ? rxe_completer+0x329/0xcc0 [rdma_rxe]
[  920.625749]  rxe_do_task+0x80/0x110 [rdma_rxe]
[  920.626037]  rxe_requester+0x625/0xde0 [rdma_rxe]
[  920.626310]  ? rxe_cq_post+0xe2/0x180 [rdma_rxe]
[  920.626583]  ? do_complete+0x18d/0x220 [rdma_rxe]
[  920.626812]  ? rxe_completer+0x1a3/0xcc0 [rdma_rxe]
[  920.627050]  rxe_do_task+0x80/0x110 [rdma_rxe]
[  920.627285]  tasklet_action_common.constprop.0+0xa4/0x120
[  920.627522]  handle_softirqs+0xc2/0x250
[  920.627728]  ? sort_range+0x20/0x20
[  920.627942]  run_ksoftirqd+0x1f/0x30
[  920.628158]  smpboot_thread_fn+0xc7/0x1b0
[  920.628334]  kthread+0xd6/0x100
[  920.628504]  ? kthread_complete_and_exit+0x20/0x20
[  920.628709]  ret_from_fork+0x1f/0x30
[  920.628892]  </TASK>

Fixes: ae720bdb703b ("RDMA/rxe: Generate error completion for error requester QP state")
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Link: https://patch.msgid.link/20241025152036.121417-1-yanjun.zhu@linux.dev
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Bin Lan <lanbincn@qq.com>
---
 drivers/infiniband/sw/rxe/rxe_req.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
index 35768fdbd5b7..1ef5819e75ff 100644
--- a/drivers/infiniband/sw/rxe/rxe_req.c
+++ b/drivers/infiniband/sw/rxe/rxe_req.c
@@ -643,13 +643,15 @@ int rxe_requester(void *arg)
 
 	if (unlikely(qp->req.state == QP_STATE_ERROR)) {
 		wqe = req_next_wqe(qp);
-		if (wqe)
+		if (wqe) {
 			/*
 			 * Generate an error completion for error qp state
 			 */
+			wqe->status = IB_WC_WR_FLUSH_ERR;
 			goto err;
-		else
+		} else {
 			goto exit;
+		}
 	}
 
 	if (unlikely(qp->req.state == QP_STATE_RESET)) {
-- 
2.43.0


