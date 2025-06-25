Return-Path: <stable+bounces-158473-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5394BAE7491
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 04:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9585417B291
	for <lists+stable@lfdr.de>; Wed, 25 Jun 2025 02:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8B19E97A;
	Wed, 25 Jun 2025 02:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b="BaioWFcZ"
X-Original-To: stable@vger.kernel.org
Received: from mo-csw.securemx.jp (mo-csw1121.securemx.jp [210.130.202.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A378222083
	for <stable@vger.kernel.org>; Wed, 25 Jun 2025 02:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.130.202.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750816907; cv=none; b=O27y20zZnCDXW9RTGFc0ARZ+GnTRXibDsDn8R5BMmbJsEoXn/2IayfC57iIfvZyV75M+vp/gc2Xz0QEbzwkA3QzQYOJ+nC+Hf9j4KEL0Ixc3s6exZq7JWIjTy2fmFjeDM2qf4stM3r51ULL+wx/WDNZYMbCEhSMXPdQoLY0Pfp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750816907; c=relaxed/simple;
	bh=qKhXi+SVOnEgEp9P7kPbiqpT672ZpGpgS/QYiom4R7E=;
	h=From:To:Cc:Subject:Date:Message-Id; b=fbBvqNoOg/kAL2/TAo+QZaBeRpFquic4UFzAyspowLr5UsSaa4jdJGlzlJzA3cKCGHfiZCHE4rcSTsZU8gL3oUKj/dXDWgZEu6FTVLRnMO/baG0ZBZJfSipyAGLJZgBdSgSouItkRJEtWbX2Znmg/gID3cZl/4PLykdqAadco9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp; spf=pass smtp.mailfrom=toshiba.co.jp; dkim=pass (2048-bit key) header.d=toshiba.co.jp header.i=nobuhiro1.iwamatsu@toshiba.co.jp header.b=BaioWFcZ; arc=none smtp.client-ip=210.130.202.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toshiba.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toshiba.co.jp
DKIM-Signature: v=1;a=rsa-sha256;c=relaxed/simple;d=toshiba.co.jp;h=From:To:Cc
	:Subject:Date:Message-Id;i=nobuhiro1.iwamatsu@toshiba.co.jp;s=key1.smx;t=
	1750816844;x=1752026444;bh=qKhXi+SVOnEgEp9P7kPbiqpT672ZpGpgS/QYiom4R7E=;b=Bai
	oWFcZSLKB27D76l/KFLkQ2kyFoMl8bnxeVGmxD0xIC9QEpN1Dcrw9Nd+UMPjuOwLZCgFIN4L3zloY
	8ORXd1wdh91eaKC2C0gAOsHdNONXnm5OkvA64aO1dTK1Bp+NSR132fCClmrORa0dB3Oq3xppS6neu
	y8ScV2tdoMBmxYkuOERrI8X91C9HwnlO7d29y0fsHtytaf2Ct4ByxFG0fGfuHllMPNbFwYHFdRXcW
	hPn4C43ROE7+eNlkgXOMRBflPPLIe+orLaZLyBHkZOsOz4VbSFyteGHJTrnK8wtzBC4pQoKHiMWcO
	xn9+jPzl0mO5i9LfIw54YhEbWBmY2lg==;
Received: by mo-csw.securemx.jp (mx-mo-csw1121) id 55P20i2Q3340290; Wed, 25 Jun 2025 11:00:44 +0900
X-Iguazu-Qid: 2rWhyCKR8R2QT014Gx
X-Iguazu-QSIG: v=2; s=0; t=1750816843; q=2rWhyCKR8R2QT014Gx; m=IkIEtXpU8JkOvTK9wIKnQteAHLCEJBNkJwQq7IxZBvw=
Received: from imx12-a.toshiba.co.jp ([38.106.60.135])
	by relay.securemx.jp (mx-mr1122) id 55P20eKm3781710
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 25 Jun 2025 11:00:40 +0900
From: Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
To: cip-dev@lists.cip-project.org, Ulrich Hecht <uli@fpond.eu>,
        Pavel Machek <pavel@denx.de>
Cc: Bart Van Assche <bvanassche@acm.org>,
        Alan Stern <stern@rowland.harvard.edu>, Yi Zhang <yi.zhang@redhat.com>,
        stable@vger.kernel.org,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: [PATCH for 4.4] scsi: core: Remove the /proc/scsi/${proc_name} directory earlier
Date: Wed, 25 Jun 2025 11:00:26 +0900
X-TSB-HOP2: ON
Message-Id: <1750816826-2341-1-git-send-email-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Bart Van Assche <bvanassche@acm.org>

commit fc663711b94468f4e1427ebe289c9f05669699c9 upstream.

Remove the /proc/scsi/${proc_name} directory earlier to fix a race
condition between unloading and reloading kernel modules. This fixes a bug
introduced in 2009 by commit 77c019768f06 ("[SCSI] fix /proc memory leak in
the SCSI core").

Fix the following kernel warning:

proc_dir_entry 'scsi/scsi_debug' already registered
WARNING: CPU: 19 PID: 27986 at fs/proc/generic.c:376 proc_register+0x27d/0x2e0
Call Trace:
 proc_mkdir+0xb5/0xe0
 scsi_proc_hostdir_add+0xb5/0x170
 scsi_host_alloc+0x683/0x6c0
 sdebug_driver_probe+0x6b/0x2d0 [scsi_debug]
 really_probe+0x159/0x540
 __driver_probe_device+0xdc/0x230
 driver_probe_device+0x4f/0x120
 __device_attach_driver+0xef/0x180
 bus_for_each_drv+0xe5/0x130
 __device_attach+0x127/0x290
 device_initial_probe+0x17/0x20
 bus_probe_device+0x110/0x130
 device_add+0x673/0xc80
 device_register+0x1e/0x30
 sdebug_add_host_helper+0x1a7/0x3b0 [scsi_debug]
 scsi_debug_init+0x64f/0x1000 [scsi_debug]
 do_one_initcall+0xd7/0x470
 do_init_module+0xe7/0x330
 load_module+0x122a/0x12c0
 __do_sys_finit_module+0x124/0x1a0
 __x64_sys_finit_module+0x46/0x50
 do_syscall_64+0x38/0x80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

Link: https://lore.kernel.org/r/20230210205200.36973-3-bvanassche@acm.org
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Yi Zhang <yi.zhang@redhat.com>
Cc: stable@vger.kernel.org
Fixes: 77c019768f06 ("[SCSI] fix /proc memory leak in the SCSI core")
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Nobuhiro Iwamatsu (CIP) <nobuhiro1.iwamatsu@toshiba.co.jp>
---
 drivers/scsi/hosts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index c59b3fd6b361..7ffdebdd9c54 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -173,6 +173,7 @@ void scsi_remove_host(struct Scsi_Host *shost)
 	scsi_forget_host(shost);
 	mutex_unlock(&shost->scan_mutex);
 	scsi_proc_host_rm(shost);
+	scsi_proc_hostdir_rm(shost->hostt);
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	if (scsi_host_set_state(shost, SHOST_DEL))
@@ -322,6 +323,7 @@ static void scsi_host_dev_release(struct device *dev)
 	struct request_queue *q;
 	void *queuedata;
 
+	/* In case scsi_remove_host() has not been called. */
 	scsi_proc_hostdir_rm(shost->hostt);
 
 	if (shost->tmf_work_q)
-- 
2.25.1



