Return-Path: <stable+bounces-98444-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 692EC9E4171
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:27:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43533161F7F
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EF6218523;
	Wed,  4 Dec 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oV/2leAR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCFF2251C1;
	Wed,  4 Dec 2024 17:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331784; cv=none; b=D4DTo/jGd9pNoP6eEaAOauYI7YxhOttKqvWwsueTrwurbwWqBdLFD9UK2WRtCZ57JDh8QDQVKjlcaoZXk2mi+vCkVYoyoWNf38BnhZIda0ktQhNOcDqc23W9L12Qy/cgVtIeZrWlPYxIeu8mN2fuybdMzvJvAwsuCEb/gsfsN+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331784; c=relaxed/simple;
	bh=fC/P+NXT1Xq29IOXPtZlW5MtBQt2Y0J6BcGdgH5t1XU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mg3c2YBWYZ/aFENiYrbi7sGoNIghqGxnzPtsI9UFhFrkZtteFSeyNpiux2XSmiipvxn2IcEZM4S47IBGqCjyP5dsfg5znGJIQvNmor5VJvCPNjWZ2tvr6unMUuufYROVlNzPgLHZNZYKqA+59WF7IpozLiK5I8BBI+agPw+EtrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oV/2leAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4056FC4CEDF;
	Wed,  4 Dec 2024 17:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331784;
	bh=fC/P+NXT1Xq29IOXPtZlW5MtBQt2Y0J6BcGdgH5t1XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oV/2leARu/agg1nhxzl2P5PzOYBOphhy9yESqCiu4no66L/qUoefSRYwZmAGfI36v
	 zJ7LXnZ8FK+Aaw94CrwQobyiAh0HHLBZVovJEWfPHa3AErXonau7eELth9IKIxoS/l
	 f3tLOHplS3/lb1Uq3mab96Ye3aEFRHY/03uxqVDbvpqxEmPkC5SHlOqV4AINH8mhg9
	 RbpNcGKWY4C7Nn7haQnWZXaENVlmFapXZuFuotiXT6t79MhcHMt45X6CUX4R83SNhV
	 SyiVyE/fMtv7mz4iQDclNAq7PwkKyxDSxQkP8QMvmlGt7kmTnNPhm0bQFL6f5ljx8s
	 HjuBX5TyPyr4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yihang Li <liyihang9@huawei.com>,
	Xiang Chen <chenxiang66@hisilicon.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 3/9] scsi: hisi_sas: Add cond_resched() for no forced preemption model
Date: Wed,  4 Dec 2024 10:51:33 -0500
Message-ID: <20241204155141.2214748-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204155141.2214748-1-sashal@kernel.org>
References: <20241204155141.2214748-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.173
Content-Transfer-Encoding: 8bit

From: Yihang Li <liyihang9@huawei.com>

[ Upstream commit 2233c4a0b948211743659b24c13d6bd059fa75fc ]

For no forced preemption model kernel, in the scenario where the
expander is connected to 12 high performance SAS SSDs, the following
call trace may occur:

[  214.409199][  C240] watchdog: BUG: soft lockup - CPU#240 stuck for 22s! [irq/149-hisi_sa:3211]
[  214.568533][  C240] pstate: 60400009 (nZCv daif +PAN -UAO -TCO BTYPE=--)
[  214.575224][  C240] pc : fput_many+0x8c/0xdc
[  214.579480][  C240] lr : fput+0x1c/0xf0
[  214.583302][  C240] sp : ffff80002de2b900
[  214.587298][  C240] x29: ffff80002de2b900 x28: ffff1082aa412000
[  214.593291][  C240] x27: ffff3062a0348c08 x26: ffff80003a9f6000
[  214.599284][  C240] x25: ffff1062bbac5c40 x24: 0000000000001000
[  214.605277][  C240] x23: 000000000000000a x22: 0000000000000001
[  214.611270][  C240] x21: 0000000000001000 x20: 0000000000000000
[  214.617262][  C240] x19: ffff3062a41ae580 x18: 0000000000010000
[  214.623255][  C240] x17: 0000000000000001 x16: ffffdb3a6efe5fc0
[  214.629248][  C240] x15: ffffffffffffffff x14: 0000000003ffffff
[  214.635241][  C240] x13: 000000000000ffff x12: 000000000000029c
[  214.641234][  C240] x11: 0000000000000006 x10: ffff80003a9f7fd0
[  214.647226][  C240] x9 : ffffdb3a6f0482fc x8 : 0000000000000001
[  214.653219][  C240] x7 : 0000000000000002 x6 : 0000000000000080
[  214.659212][  C240] x5 : ffff55480ee9b000 x4 : fffffde7f94c6554
[  214.665205][  C240] x3 : 0000000000000002 x2 : 0000000000000020
[  214.671198][  C240] x1 : 0000000000000021 x0 : ffff3062a41ae5b8
[  214.677191][  C240] Call trace:
[  214.680320][  C240]  fput_many+0x8c/0xdc
[  214.684230][  C240]  fput+0x1c/0xf0
[  214.687707][  C240]  aio_complete_rw+0xd8/0x1fc
[  214.692225][  C240]  blkdev_bio_end_io+0x98/0x140
[  214.696917][  C240]  bio_endio+0x160/0x1bc
[  214.701001][  C240]  blk_update_request+0x1c8/0x3bc
[  214.705867][  C240]  scsi_end_request+0x3c/0x1f0
[  214.710471][  C240]  scsi_io_completion+0x7c/0x1a0
[  214.715249][  C240]  scsi_finish_command+0x104/0x140
[  214.720200][  C240]  scsi_softirq_done+0x90/0x180
[  214.724892][  C240]  blk_mq_complete_request+0x5c/0x70
[  214.730016][  C240]  scsi_mq_done+0x48/0xac
[  214.734194][  C240]  sas_scsi_task_done+0xbc/0x16c [libsas]
[  214.739758][  C240]  slot_complete_v3_hw+0x260/0x760 [hisi_sas_v3_hw]
[  214.746185][  C240]  cq_thread_v3_hw+0xbc/0x190 [hisi_sas_v3_hw]
[  214.752179][  C240]  irq_thread_fn+0x34/0xa4
[  214.756435][  C240]  irq_thread+0xc4/0x130
[  214.760520][  C240]  kthread+0x108/0x13c
[  214.764430][  C240]  ret_from_fork+0x10/0x18

This is because in the hisi_sas driver, both the hardware interrupt
handler and the interrupt thread are executed on the same CPU. In the
performance test scenario, function irq_wait_for_interrupt() will always
return 0 if lots of interrupts occurs and the CPU will be continuously
consumed. As a result, the CPU cannot run the watchdog thread. When the
watchdog time exceeds the specified time, call trace occurs.

To fix it, add cond_resched() to execute the watchdog thread.

Signed-off-by: Yihang Li <liyihang9@huawei.com>
Link: https://lore.kernel.org/r/20241008021822.2617339-8-liyihang9@huawei.com
Reviewed-by: Xiang Chen <chenxiang66@hisilicon.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 1651d03d3b463..3f3d768548c57 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -2402,6 +2402,7 @@ static irqreturn_t  cq_thread_v3_hw(int irq_no, void *p)
 	/* update rd_point */
 	cq->rd_point = rd_point;
 	hisi_sas_write32(hisi_hba, COMPL_Q_0_RD_PTR + (0x14 * queue), rd_point);
+	cond_resched();
 
 	return IRQ_HANDLED;
 }
-- 
2.43.0


