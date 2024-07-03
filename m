Return-Path: <stable+bounces-57323-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A615D925C0C
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 13:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D10E1F21156
	for <lists+stable@lfdr.de>; Wed,  3 Jul 2024 11:14:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A0A178CCD;
	Wed,  3 Jul 2024 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XPkjzIEQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8592916FF2A;
	Wed,  3 Jul 2024 11:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720004533; cv=none; b=sANHHvCjszhc/Fygg/14Xg8o+YygYL4LuRBVf7ORlP7CLmt9TV3QRfNLMsdEjTaX29xTf+Eq7ENWGvohBEFm7qDl+3vm+rjizRCpR9EPCeCyQMFu4/9OkCx+fXLtegaiVAzjxtJMVFo4aCELB1BSjsQUhMh0wzUK2VCpG80PgiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720004533; c=relaxed/simple;
	bh=byNbasGmYFjaGmgPuRNuckd54Tt4xJXsKO+ehWzqV1c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGW1RbT7kasZm62rcHcQ42RINTqUhl76Apmv5bG+M6g9UjWFaAmJAqUVs6AubVg8y88IFdzwjeLN36tExl2mobTKOaSU17jUfTojFJ7/VV4XJAl2hwL3SOrE+/uNtIhqgxhKwhqgtOSPu2+PG9vwebQwfYmEqhpswHhxiomU3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XPkjzIEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B906C2BD10;
	Wed,  3 Jul 2024 11:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720004533;
	bh=byNbasGmYFjaGmgPuRNuckd54Tt4xJXsKO+ehWzqV1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XPkjzIEQAl0ofWDmzXg5RdhA1wraFxfmfvUJLvAdy/sdTGzuEh3JA35UAIFX/Fghx
	 AuGZZUgBx1BxUYjFBbDK6nzGUb/I0+nYONVBSY6BPgHLKcvNLQAToi5Rat12sgQfuK
	 bWPxJDe5KgQYpsT0F5Mo98tk5n4EnqkBFARYq5go=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Taehee Yoo <ap420073@gmail.com>,
	Brett Creeley <brett.creeley@amd.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 073/290] ionic: fix use after netif_napi_del()
Date: Wed,  3 Jul 2024 12:37:34 +0200
Message-ID: <20240703102906.956455393@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240703102904.170852981@linuxfoundation.org>
References: <20240703102904.170852981@linuxfoundation.org>
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

From: Taehee Yoo <ap420073@gmail.com>

[ Upstream commit 79f18a41dd056115d685f3b0a419c7cd40055e13 ]

When queues are started, netif_napi_add() and napi_enable() are called.
If there are 4 queues and only 3 queues are used for the current
configuration, only 3 queues' napi should be registered and enabled.
The ionic_qcq_enable() checks whether the .poll pointer is not NULL for
enabling only the using queue' napi. Unused queues' napi will not be
registered by netif_napi_add(), so the .poll pointer indicates NULL.
But it couldn't distinguish whether the napi was unregistered or not
because netif_napi_del() doesn't reset the .poll pointer to NULL.
So, ionic_qcq_enable() calls napi_enable() for the queue, which was
unregistered by netif_napi_del().

Reproducer:
   ethtool -L <interface name> rx 1 tx 1 combined 0
   ethtool -L <interface name> rx 0 tx 0 combined 1
   ethtool -L <interface name> rx 0 tx 0 combined 4

Splat looks like:
kernel BUG at net/core/dev.c:6666!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 PID: 1057 Comm: kworker/3:3 Not tainted 6.10.0-rc2+ #16
Workqueue: events ionic_lif_deferred_work [ionic]
RIP: 0010:napi_enable+0x3b/0x40
Code: 48 89 c2 48 83 e2 f6 80 b9 61 09 00 00 00 74 0d 48 83 bf 60 01 00 00 00 74 03 80 ce 01 f0 4f
RSP: 0018:ffffb6ed83227d48 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff97560cda0828 RCX: 0000000000000029
RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff97560cda0a28
RBP: ffffb6ed83227d50 R08: 0000000000000400 R09: 0000000000000001
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: ffff97560ce3c1a0 R14: 0000000000000000 R15: ffff975613ba0a20
FS:  0000000000000000(0000) GS:ffff975d5f780000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8f734ee200 CR3: 0000000103e50000 CR4: 00000000007506f0
PKRU: 55555554
Call Trace:
 <TASK>
 ? die+0x33/0x90
 ? do_trap+0xd9/0x100
 ? napi_enable+0x3b/0x40
 ? do_error_trap+0x83/0xb0
 ? napi_enable+0x3b/0x40
 ? napi_enable+0x3b/0x40
 ? exc_invalid_op+0x4e/0x70
 ? napi_enable+0x3b/0x40
 ? asm_exc_invalid_op+0x16/0x20
 ? napi_enable+0x3b/0x40
 ionic_qcq_enable+0xb7/0x180 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
 ionic_start_queues+0xc4/0x290 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
 ionic_link_status_check+0x11c/0x170 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
 ionic_lif_deferred_work+0x129/0x280 [ionic 59bdfc8a035436e1c4224ff7d10789e3f14643f8]
 process_one_work+0x145/0x360
 worker_thread+0x2bb/0x3d0
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xcc/0x100
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2d/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30

Fixes: 0f3154e6bcb3 ("ionic: Add Tx and Rx handling")
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Link: https://lore.kernel.org/r/20240612060446.1754392-1-ap420073@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_lif.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index a37ca4b1e5665..324ef6990e9a7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -272,10 +272,8 @@ static int ionic_qcq_enable(struct ionic_qcq *qcq)
 	if (ret)
 		return ret;
 
-	if (qcq->napi.poll)
-		napi_enable(&qcq->napi);
-
 	if (qcq->flags & IONIC_QCQ_F_INTR) {
+		napi_enable(&qcq->napi);
 		irq_set_affinity_hint(qcq->intr.vector,
 				      &qcq->intr.affinity_mask);
 		ionic_intr_mask(idev->intr_ctrl, qcq->intr.index,
-- 
2.43.0




