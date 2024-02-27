Return-Path: <stable+bounces-24159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9370586933C
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:43:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4395DB2E5CD
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A92F13B791;
	Tue, 27 Feb 2024 13:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iHV+5oBN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DD313B2B9;
	Tue, 27 Feb 2024 13:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709041196; cv=none; b=qw/zhJGDMDpe8koNIXUq6/vlJzouDd+l2QlLNaMcRLfoZLmilSb+NFtRraHbMSqiIt32ZfMSkQ3sXbKR8W44+4V773J1CGGWwXfcrpYhX/JcmL67+6Zsv1dd5BzX2jA6GSp6GKMC8H+pOPqsAI8pjyIRf3itvSjFQEyNyjWLGC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709041196; c=relaxed/simple;
	bh=OjNDO7nlvHurVrWEmkicHQBrKkKMe3fi9S79kFchkb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq4EZQ26LJFP4WOFrWkUXscuoIvMNqqReujA5ZbgiHeEA7h6nG8vUcisXilvisIMdV3Nl2/br3qyABivyFOpIhd/Mi6Pdt0Z2ZJ8SGjKoL998g/dVr2QNVK8e3vRKimnxU0YpBa4NZkkPfxDNVh16jqBKHr6RO0up/lf6UYabAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iHV+5oBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 379A1C433C7;
	Tue, 27 Feb 2024 13:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709041195;
	bh=OjNDO7nlvHurVrWEmkicHQBrKkKMe3fi9S79kFchkb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iHV+5oBN8H4SkcHZzUm4yN8hezIAP/sjig77YK9sk4n/Jez//pGWl2sLRW6goRAyO
	 DBVNh9MnGAfLqQNemPvdJpb8fukn8A6QxzzplLOa9Y6TzJrHb3I5DPCazMJzF9FbXj
	 Ffbr4HNep9IOzxF7tlRURipNdXo6l9pDXFnFpJgo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yogesh Chandra Pandey <YogeshChandra.Pandey@microchip.com>,
	Scott Benesh <scott.benesh@microchip.com>,
	Scott Teel <scott.teel@microchip.com>,
	Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>,
	Mike McGowen <mike.mcgowen@microchip.com>,
	Kevin Barnett <kevin.barnett@microchip.com>,
	Don Brace <don.brace@microchip.com>,
	Tomas Henzl <thenzl@redhat.com>,
	"Ewan D. Milne" <emilne@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 255/334] scsi: smartpqi: Fix disable_managed_interrupts
Date: Tue, 27 Feb 2024 14:21:53 +0100
Message-ID: <20240227131639.145565479@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240227131630.636392135@linuxfoundation.org>
References: <20240227131630.636392135@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Don Brace <don.brace@microchip.com>

[ Upstream commit 5761eb9761d2d5fe8248a9b719efc4d8baf1f24a ]

Correct blk-mq registration issue with module parameter
disable_managed_interrupts enabled.

When we turn off the default PCI_IRQ_AFFINITY flag, the driver needs to
register with blk-mq using blk_mq_map_queues(). The driver is currently
calling blk_mq_pci_map_queues() which results in a stack trace and possibly
undefined behavior.

Stack Trace:
[    7.860089] scsi host2: smartpqi
[    7.871934] WARNING: CPU: 0 PID: 238 at block/blk-mq-pci.c:52 blk_mq_pci_map_queues+0xca/0xd0
[    7.889231] Modules linked in: sd_mod t10_pi sg uas smartpqi(+) crc32c_intel scsi_transport_sas usb_storage dm_mirror dm_region_hash dm_log dm_mod ipmi_devintf ipmi_msghandler fuse
[    7.924755] CPU: 0 PID: 238 Comm: kworker/0:3 Not tainted 4.18.0-372.88.1.el8_6_smartpqi_test.x86_64 #1
[    7.944336] Hardware name: HPE ProLiant DL380 Gen10/ProLiant DL380 Gen10, BIOS U30 03/08/2022
[    7.963026] Workqueue: events work_for_cpu_fn
[    7.978275] RIP: 0010:blk_mq_pci_map_queues+0xca/0xd0
[    7.978278] Code: 48 89 de 89 c7 e8 f6 0f 4f 00 3b 05 c4 b7 8e 01 72 e1 5b 31 c0 5d 41 5c 41 5d 41 5e 41 5f e9 7d df 73 00 31 c0 e9 76 df 73 00 <0f> 0b eb bc 90 90 0f 1f 44 00 00 41 57 49 89 ff 41 56 41 55 41 54
[    7.978280] RSP: 0018:ffffa95fc3707d50 EFLAGS: 00010216
[    7.978283] RAX: 00000000ffffffff RBX: 0000000000000000 RCX: 0000000000000010
[    7.978284] RDX: 0000000000000004 RSI: 0000000000000000 RDI: ffff9190c32d4310
[    7.978286] RBP: 0000000000000000 R08: ffffa95fc3707d38 R09: ffff91929b81ac00
[    7.978287] R10: 0000000000000001 R11: ffffa95fc3707ac0 R12: 0000000000000000
[    7.978288] R13: ffff9190c32d4000 R14: 00000000ffffffff R15: ffff9190c4c950a8
[    7.978290] FS:  0000000000000000(0000) GS:ffff9193efc00000(0000) knlGS:0000000000000000
[    7.978292] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    8.172814] CR2: 000055d11166c000 CR3: 00000002dae10002 CR4: 00000000007706f0
[    8.172816] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[    8.172817] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[    8.172818] PKRU: 55555554
[    8.172819] Call Trace:
[    8.172823]  blk_mq_alloc_tag_set+0x12e/0x310
[    8.264339]  scsi_add_host_with_dma.cold.9+0x30/0x245
[    8.279302]  pqi_ctrl_init+0xacf/0xc8e [smartpqi]
[    8.294085]  ? pqi_pci_probe+0x480/0x4c8 [smartpqi]
[    8.309015]  pqi_pci_probe+0x480/0x4c8 [smartpqi]
[    8.323286]  local_pci_probe+0x42/0x80
[    8.337855]  work_for_cpu_fn+0x16/0x20
[    8.351193]  process_one_work+0x1a7/0x360
[    8.364462]  ? create_worker+0x1a0/0x1a0
[    8.379252]  worker_thread+0x1ce/0x390
[    8.392623]  ? create_worker+0x1a0/0x1a0
[    8.406295]  kthread+0x10a/0x120
[    8.418428]  ? set_kthread_struct+0x50/0x50
[    8.431532]  ret_from_fork+0x1f/0x40
[    8.444137] ---[ end trace 1bf0173d39354506 ]---

Fixes: cf15c3e734e8 ("scsi: smartpqi: Add module param to disable managed ints")
Tested-by: Yogesh Chandra Pandey <YogeshChandra.Pandey@microchip.com>
Reviewed-by: Scott Benesh <scott.benesh@microchip.com>
Reviewed-by: Scott Teel <scott.teel@microchip.com>
Reviewed-by: Mahesh Rajashekhara <mahesh.rajashekhara@microchip.com>
Reviewed-by: Mike McGowen <mike.mcgowen@microchip.com>
Reviewed-by: Kevin Barnett <kevin.barnett@microchip.com>
Signed-off-by: Don Brace <don.brace@microchip.com>
Link: https://lore.kernel.org/r/20240213162200.1875970-2-don.brace@microchip.com
Reviewed-by: Tomas Henzl <thenzl@redhat.com>
Reviewed-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/smartpqi/smartpqi_init.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/smartpqi/smartpqi_init.c b/drivers/scsi/smartpqi/smartpqi_init.c
index 081bb2c098063..868453b18c9ae 100644
--- a/drivers/scsi/smartpqi/smartpqi_init.c
+++ b/drivers/scsi/smartpqi/smartpqi_init.c
@@ -6533,8 +6533,11 @@ static void pqi_map_queues(struct Scsi_Host *shost)
 {
 	struct pqi_ctrl_info *ctrl_info = shost_to_hba(shost);
 
-	blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
+	if (!ctrl_info->disable_managed_interrupts)
+		return blk_mq_pci_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT],
 			      ctrl_info->pci_dev, 0);
+	else
+		return blk_mq_map_queues(&shost->tag_set.map[HCTX_TYPE_DEFAULT]);
 }
 
 static inline bool pqi_is_tape_changer_device(struct pqi_scsi_dev *device)
-- 
2.43.0




