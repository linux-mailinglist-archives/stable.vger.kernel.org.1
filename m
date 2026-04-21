Return-Path: <stable+bounces-240157-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLpEEl5652mZ9QEAu9opvQ
	(envelope-from <stable+bounces-240157-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:23:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CF343B469
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 15:23:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 13BC4300FA21
	for <lists+stable@lfdr.de>; Tue, 21 Apr 2026 13:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E773D667F;
	Tue, 21 Apr 2026 13:23:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0E6B3A3E87;
	Tue, 21 Apr 2026 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776777812; cv=none; b=tnBmNlbn82qK0g1k+a2bnclMAa0UaO03Ek9Cz8PIfYzr0Qhu/pEjAukcYE+8i0UcaQHbByYfbogv6mbIsZy7/tRdHge9XfOyiQDxcIGpKJGxxqgBX6p4QdpBmm8WlFBMYQ2O8PGoD9IAkVoP0XvOJagrtfJnnRAxW04JtwQvBw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776777812; c=relaxed/simple;
	bh=DowfC0GwkUFxvbJyUhNd/xF0NmfrrwC4qigEL0s4soI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XqqgBhQwXUvJxyWML+/beZfkORggGHuEX3ss52zaLqoQkgHxcyERqDIPXJvsAw+zoVzrU1XBR2uA4MgoPHvuubyFTnO41Emf8DyCEyY3wdtY0asfh/+847FoTXF1eVO4Rz0gK1fqHc2aZ4ikDiTDq7qnDyXezcwb//S1+5XfnWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [193.43.11.2])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 9FDA523390;
	Tue, 21 Apr 2026 16:23:28 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>,
	Nilesh Javali <njavali@marvell.com>,
	linux-scsi@vger.kernel.org,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y 1/2] scsi: qla2xxx: Fix warning message due to adisc being flushed
Date: Tue, 21 Apr 2026 16:23:26 +0300
Message-Id: <20260421132327.38389-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20260421132327.38389-1-kovalev@altlinux.org>
References: <20260421132327.38389-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[altlinux.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-240157-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[kovalev@altlinux.org,stable@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oracle.com:email,altlinux.org:mid,altlinux.org:email,marvell.com:email]
X-Rspamd-Queue-Id: F0CF343B469
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Quinn Tran <qutran@marvell.com>

commit 64f24af75b79cba3b86b0760e27e0fa904db570f upstream.

Fix warning message due to adisc being flushed.  Linux kernel triggered a
warning message where a different error code type is not matching up with
the expected type. Add additional translation of one error code type to
another.

WARNING: CPU: 2 PID: 1131623 at drivers/scsi/qla2xxx/qla_init.c:498
qla2x00_async_adisc_sp_done+0x294/0x2b0 [qla2xxx]
CPU: 2 PID: 1131623 Comm: drmgr Not tainted 5.13.0-rc1-autotest #1
..
GPR28: c000000aaa9c8890 c0080000079ab678 c00000140a104800 c00000002bd19000
NIP [c00800000790857c] qla2x00_async_adisc_sp_done+0x294/0x2b0 [qla2xxx]
LR [c008000007908578] qla2x00_async_adisc_sp_done+0x290/0x2b0 [qla2xxx]
Call Trace:
[c00000001cdc3620] [c008000007908578] qla2x00_async_adisc_sp_done+0x290/0x2b0 [qla2xxx] (unreliable)
[c00000001cdc3710] [c0080000078f3080] __qla2x00_abort_all_cmds+0x1b8/0x580 [qla2xxx]
[c00000001cdc3840] [c0080000078f589c] qla2x00_abort_all_cmds+0x34/0xd0 [qla2xxx]
[c00000001cdc3880] [c0080000079153d8] qla2x00_abort_isp_cleanup+0x3f0/0x570 [qla2xxx]
[c00000001cdc3920] [c0080000078fb7e8] qla2x00_remove_one+0x3d0/0x480 [qla2xxx]
[c00000001cdc39b0] [c00000000071c274] pci_device_remove+0x64/0x120
[c00000001cdc39f0] [c0000000007fb818] device_release_driver_internal+0x168/0x2a0
[c00000001cdc3a30] [c00000000070e304] pci_stop_bus_device+0xb4/0x100
[c00000001cdc3a70] [c00000000070e4f0] pci_stop_and_remove_bus_device+0x20/0x40
[c00000001cdc3aa0] [c000000000073940] pci_hp_remove_devices+0x90/0x130
[c00000001cdc3b30] [c0080000070704d0] disable_slot+0x38/0x90 [rpaphp] [
c00000001cdc3b60] [c00000000073eb4c] power_write_file+0xcc/0x180
[c00000001cdc3be0] [c0000000007354bc] pci_slot_attr_store+0x3c/0x60
[c00000001cdc3c00] [c00000000055f820] sysfs_kf_write+0x60/0x80 [c00000001cdc3c20]
[c00000000055df10] kernfs_fop_write_iter+0x1a0/0x290
[c00000001cdc3c70] [c000000000447c4c] new_sync_write+0x14c/0x1d0
[c00000001cdc3d10] [c00000000044b134] vfs_write+0x224/0x330
[c00000001cdc3d60] [c00000000044b3f4] ksys_write+0x74/0x130
[c00000001cdc3db0] [c00000000002df70] system_call_exception+0x150/0x2d0
[c00000001cdc3e10] [c00000000000d45c] system_call_common+0xec/0x278

Link: https://lore.kernel.org/r/20220110050218.3958-5-njavali@marvell.com
Cc: stable@vger.kernel.org
Reported-by: Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
Signed-off-by: Quinn Tran <qutran@marvell.com>
Signed-off-by: Nilesh Javali <njavali@marvell.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
[ kovalev: bp to fix CVE-2022-49158; in qla2x00_async_prli_sp_done used
  'if (res)' instead of 'else if (res)' due to the older kernel not having
  the preceding QLA_OS_TIMER_EXPIRED check (see upstream commit 4de067e5df12) ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/scsi/qla2xxx/qla_init.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/qla2xxx/qla_init.c b/drivers/scsi/qla2xxx/qla_init.c
index 7b6227fde7be..79b9571f6350 100644
--- a/drivers/scsi/qla2xxx/qla_init.c
+++ b/drivers/scsi/qla2xxx/qla_init.c
@@ -283,6 +283,8 @@ static void qla2x00_async_login_sp_done(srb_t *sp, int res)
 		ea.iop[0] = lio->u.logio.iop[0];
 		ea.iop[1] = lio->u.logio.iop[1];
 		ea.sp = sp;
+		if (res)
+			ea.data[0] = MBS_COMMAND_ERROR;
 		qla24xx_handle_plogi_done_event(vha, &ea);
 	}
 
@@ -563,6 +565,8 @@ static void qla2x00_async_adisc_sp_done(srb_t *sp, int res)
 	ea.iop[1] = lio->u.logio.iop[1];
 	ea.fcport = sp->fcport;
 	ea.sp = sp;
+	if (res)
+		ea.data[0] = MBS_COMMAND_ERROR;
 
 	qla24xx_handle_adisc_event(vha, &ea);
 
@@ -1238,6 +1242,8 @@ static void qla2x00_async_prli_sp_done(srb_t *sp, int res)
 		ea.iop[0] = lio->u.logio.iop[0];
 		ea.iop[1] = lio->u.logio.iop[1];
 		ea.sp = sp;
+		if (res)
+			ea.data[0] = MBS_COMMAND_ERROR;
 
 		qla24xx_handle_prli_done_event(vha, &ea);
 	}
-- 
2.50.1


