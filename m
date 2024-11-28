Return-Path: <stable+bounces-95687-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A452A9DB356
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 09:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA50B219CF
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 08:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A7D146018;
	Thu, 28 Nov 2024 08:01:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AEE45025
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 08:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732780871; cv=none; b=VwU89OIFkU6mpxY5KqWnXHgTzIvCV79gH/6AUmJmMAlQco4D1lKlszVYPw8HZmS3qMDWLY44fNzLtJrZMGnQFGYqOmsVUs93UoOF/5qfjd3Uf5jRFpG97kUwJPebtLRgtkaDkz2DlTboCFhrkdjGro2iCZcDOPnge92GIPiohkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732780871; c=relaxed/simple;
	bh=1rABFZuehj/QTb4wWR2C+Ila6lDBFreLSTJyGpwplw4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SpWZxzw/6lZHTlFxFr5o+ALXC8CYPD7ejacTg4O1fqXFETrjfoZYAjvnzbxyqxW+kA3ktD/4ncu3enKCDn5KaMgt6E4pBIr/kCaq4HDt2xjqP06dWWBlnEXvCmS5D2uHV25rClNfzijZhVEg16aBW8X/BwI7b6Gq3fSIxKZVQjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=eng.windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AS7UKFA019551
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 00:01:07 -0800
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 43671c8r6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 28 Nov 2024 00:01:07 -0800 (PST)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.43; Thu, 28 Nov 2024 00:01:06 -0800
Received: from pek-lpg-core4.wrs.com (128.224.153.44) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.43 via Frontend Transport; Thu, 28 Nov 2024 00:01:05 -0800
From: <mingli.yu@eng.windriver.com>
To: <stable@vger.kernel.org>
Subject: [PATCH 5.15] tty: n_gsm: Fix use-after-free in gsm_cleanup_mux
Date: Thu, 28 Nov 2024 16:01:04 +0800
Message-ID: <20241128080104.195641-1-mingli.yu@eng.windriver.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: DfJey_Y4LjRh_vZTRX4w83LPTNTSyJ91
X-Proofpoint-ORIG-GUID: DfJey_Y4LjRh_vZTRX4w83LPTNTSyJ91
X-Authority-Analysis: v=2.4 cv=QYicvtbv c=1 sm=1 tr=0 ts=67482343 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=VlfZXiiP6vEA:10 a=VwQbUJbxAAAA:8 a=t7CeM3EgAAAA:8 a=ag1SF4gXAAAA:8 a=DWr4oNudKj5MoudNrjUA:9 a=FdTzh2GWekK77mhwV6Dw:22
 a=Yupwre4RP9_Eg_Bd0iYG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-11-28_06,2024-11-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.21.0-2411120000 definitions=main-2411280063

From: Mingli Yu <mingli.yu@windriver.com>

commit 9462f4ca56e7d2430fdb6dcc8498244acbfc4489 upstream.

BUG: KASAN: slab-use-after-free in gsm_cleanup_mux+0x77b/0x7b0
drivers/tty/n_gsm.c:3160 [n_gsm]
Read of size 8 at addr ffff88815fe99c00 by task poc/3379
CPU: 0 UID: 0 PID: 3379 Comm: poc Not tainted 6.11.0+ #56
Hardware name: VMware, Inc. VMware Virtual Platform/440BX
Desktop Reference Platform, BIOS 6.00 11/12/2020
Call Trace:
 <TASK>
 gsm_cleanup_mux+0x77b/0x7b0 drivers/tty/n_gsm.c:3160 [n_gsm]
 __pfx_gsm_cleanup_mux+0x10/0x10 drivers/tty/n_gsm.c:3124 [n_gsm]
 __pfx_sched_clock_cpu+0x10/0x10 kernel/sched/clock.c:389
 update_load_avg+0x1c1/0x27b0 kernel/sched/fair.c:4500
 __pfx_min_vruntime_cb_rotate+0x10/0x10 kernel/sched/fair.c:846
 __rb_insert_augmented+0x492/0xbf0 lib/rbtree.c:161
 gsmld_ioctl+0x395/0x1450 drivers/tty/n_gsm.c:3408 [n_gsm]
 _raw_spin_lock_irqsave+0x92/0xf0 arch/x86/include/asm/atomic.h:107
 __pfx_gsmld_ioctl+0x10/0x10 drivers/tty/n_gsm.c:3822 [n_gsm]
 ktime_get+0x5e/0x140 kernel/time/timekeeping.c:195
 ldsem_down_read+0x94/0x4e0 arch/x86/include/asm/atomic64_64.h:79
 __pfx_ldsem_down_read+0x10/0x10 drivers/tty/tty_ldsem.c:338
 __pfx_do_vfs_ioctl+0x10/0x10 fs/ioctl.c:805
 tty_ioctl+0x643/0x1100 drivers/tty/tty_io.c:2818

Allocated by task 65:
 gsm_data_alloc.constprop.0+0x27/0x190 drivers/tty/n_gsm.c:926 [n_gsm]
 gsm_send+0x2c/0x580 drivers/tty/n_gsm.c:819 [n_gsm]
 gsm1_receive+0x547/0xad0 drivers/tty/n_gsm.c:3038 [n_gsm]
 gsmld_receive_buf+0x176/0x280 drivers/tty/n_gsm.c:3609 [n_gsm]
 tty_ldisc_receive_buf+0x101/0x1e0 drivers/tty/tty_buffer.c:391
 tty_port_default_receive_buf+0x61/0xa0 drivers/tty/tty_port.c:39
 flush_to_ldisc+0x1b0/0x750 drivers/tty/tty_buffer.c:445
 process_scheduled_works+0x2b0/0x10d0 kernel/workqueue.c:3229
 worker_thread+0x3dc/0x950 kernel/workqueue.c:3391
 kthread+0x2a3/0x370 kernel/kthread.c:389
 ret_from_fork+0x2d/0x70 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:257

Freed by task 3367:
 kfree+0x126/0x420 mm/slub.c:4580
 gsm_cleanup_mux+0x36c/0x7b0 drivers/tty/n_gsm.c:3160 [n_gsm]
 gsmld_ioctl+0x395/0x1450 drivers/tty/n_gsm.c:3408 [n_gsm]
 tty_ioctl+0x643/0x1100 drivers/tty/tty_io.c:2818

[Analysis]
gsm_msg on the tx_ctrl_list or tx_data_list of gsm_mux
can be freed by multi threads through ioctl,which leads
to the occurrence of uaf. Protect it by gsm tx lock.

Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Cc: stable <stable@kernel.org>
Suggested-by: Jiri Slaby <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20240926130213.531959-1-xialonglong@kylinos.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[Mingli: Backport to fix CVE-2024-50073, no guard macro defined resolution]
Signed-off-by: Mingli Yu <mingli.yu@windriver.com>
---
 drivers/tty/n_gsm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index aae9f73585bd..1becbdf7c470 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2443,6 +2443,7 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	int i;
 	struct gsm_dlci *dlci;
 	struct gsm_msg *txq, *ntxq;
+	unsigned long flags;
 
 	gsm->dead = true;
 	mutex_lock(&gsm->mutex);
@@ -2471,9 +2472,12 @@ static void gsm_cleanup_mux(struct gsm_mux *gsm, bool disc)
 	mutex_unlock(&gsm->mutex);
 	/* Now wipe the queues */
 	tty_ldisc_flush(gsm->tty);
+
+	spin_lock_irqsave(&gsm->tx_lock, flags);
 	list_for_each_entry_safe(txq, ntxq, &gsm->tx_list, list)
 		kfree(txq);
 	INIT_LIST_HEAD(&gsm->tx_list);
+	spin_unlock_irqrestore(&gsm->tx_lock, flags);
 }
 
 /**
-- 
2.34.1


