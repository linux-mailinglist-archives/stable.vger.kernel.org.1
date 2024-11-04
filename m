Return-Path: <stable+bounces-89722-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 301E89BBB0E
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 18:06:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C4E6B20A54
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 17:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 481541C9DC8;
	Mon,  4 Nov 2024 17:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="bXwOnQJd"
X-Original-To: stable@vger.kernel.org
Received: from out0-217.mail.aliyun.com (out0-217.mail.aliyun.com [140.205.0.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1941C578C;
	Mon,  4 Nov 2024 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739798; cv=none; b=J4o5m1mD5F3mDUZCbWLc4WfZW6MwlROBC3KciLhQEcflicS4bG3L0XcmHGWQmE/fb8oMCykJVDDsv4aRZ2vxMoaZ2UJd/Nx1GFI6zh2xVbykJgPVphZDaSZBcv56S2kdb8pWbb+eVdHRo6nD8+/baXpsQ9riC7qLsZFOtAH98tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739798; c=relaxed/simple;
	bh=R4TqditmtftCa0w7Rv+EXC8gXYqRB+3vMWA/YUA7hag=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cpn/ipNR2DgPAykg043fbJSimaIgGmUCvMA6v+tocQIomAcnBUzsCiOv/2eUF181SUL9xyFe9OVY2oX+alHcuEhOEiDmbw9OTcSN29WCsESOSk9VrJa9ogyYlUUqboDvSiQdn53HswaPmaAKqE6TBPTCcVKXZA8hsvKTEf/00qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=bXwOnQJd; arc=none smtp.client-ip=140.205.0.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1730739791; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=tBSdLAG+Y+l3AdDcU6iNR/8vWTUM90B1ihEg9KDjLlE=;
	b=bXwOnQJdPryWBHer6Ly3QkxXOU7IwZzlJQCmBuVS/84s7oKrReczSdAN7rJwrO5Sg5izL2qphzoShT6LNoBaNaKa2HrPsiJR5YQQyTWlhsK20uW97YoHtJCmSAQioDghsD2vrEBIY+rLqZQXrCxJXPyvtyZUVdmdoKKRqdpjbM4=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.a0U4bEK_1730737936 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 00:32:16 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>,
   <stable@vger.kernel.org>
Subject: [PATCH 2/4] um: ubd: Do not use drvdata in release
Date: Tue, 05 Nov 2024 00:32:01 +0800
Message-Id: <20241104163203.435515-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241104163203.435515-1-tiwei.btw@antgroup.com>
References: <20241104163203.435515-1-tiwei.btw@antgroup.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The drvdata is not available in release. Let's just use container_of()
to get the ubd instance. Otherwise, removing a ubd device will result
in a crash:

RIP: 0033:blk_mq_free_tag_set+0x1f/0xba
RSP: 00000000e2083bf0  EFLAGS: 00010246
RAX: 000000006021463a RBX: 0000000000000348 RCX: 0000000062604d00
RDX: 0000000004208060 RSI: 00000000605241a0 RDI: 0000000000000348
RBP: 00000000e2083c10 R08: 0000000062414010 R09: 00000000601603f7
R10: 000000000000133a R11: 000000006038c4bd R12: 0000000000000000
R13: 0000000060213a5c R14: 0000000062405d20 R15: 00000000604f7aa0
Kernel panic - not syncing: Segfault with no mm
CPU: 0 PID: 17 Comm: kworker/0:1 Not tainted 6.8.0-rc3-00107-gba3f67c11638 #1
Workqueue: events mc_work_proc
Stack:
 00000000 604f7ef0 62c5d000 62405d20
 e2083c30 6002c776 6002c755 600e47ff
 e2083c60 6025ffe3 04208060 603d36e0
Call Trace:
 [<6002c776>] ubd_device_release+0x21/0x55
 [<6002c755>] ? ubd_device_release+0x0/0x55
 [<600e47ff>] ? kfree+0x0/0x100
 [<6025ffe3>] device_release+0x70/0xba
 [<60381d6a>] kobject_put+0xb5/0xe2
 [<6026027b>] put_device+0x19/0x1c
 [<6026a036>] platform_device_put+0x26/0x29
 [<6026ac5a>] platform_device_unregister+0x2c/0x2e
 [<6002c52e>] ubd_remove+0xb8/0xd6
 [<6002bb74>] ? mconsole_reply+0x0/0x50
 [<6002b926>] mconsole_remove+0x160/0x1cc
 [<6002bbbc>] ? mconsole_reply+0x48/0x50
 [<6003379c>] ? um_set_signals+0x3b/0x43
 [<60061c55>] ? update_min_vruntime+0x14/0x70
 [<6006251f>] ? dequeue_task_fair+0x164/0x235
 [<600620aa>] ? update_cfs_group+0x0/0x40
 [<603a0e77>] ? __schedule+0x0/0x3ed
 [<60033761>] ? um_set_signals+0x0/0x43
 [<6002af6a>] mc_work_proc+0x77/0x91
 [<600520b4>] process_scheduled_works+0x1af/0x2c3
 [<6004ede3>] ? assign_work+0x0/0x58
 [<600527a1>] worker_thread+0x2f7/0x37a
 [<6004ee3b>] ? set_pf_worker+0x0/0x64
 [<6005765d>] ? arch_local_irq_save+0x0/0x2d
 [<60058e07>] ? kthread_exit+0x0/0x3a
 [<600524aa>] ? worker_thread+0x0/0x37a
 [<60058f9f>] kthread+0x130/0x135
 [<6002068e>] new_thread_handler+0x85/0xb6

Cc: stable@vger.kernel.org
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/ubd_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index f19173da64d8..66c1a8835e36 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -779,7 +779,7 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 
 static void ubd_device_release(struct device *dev)
 {
-	struct ubd *ubd_dev = dev_get_drvdata(dev);
+	struct ubd *ubd_dev = container_of(dev, struct ubd, pdev.dev);
 
 	blk_mq_free_tag_set(&ubd_dev->tag_set);
 	*ubd_dev = ((struct ubd) DEFAULT_UBD);
-- 
2.34.1


