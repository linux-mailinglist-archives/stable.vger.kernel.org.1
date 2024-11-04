Return-Path: <stable+bounces-89723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 874AF9BBB0F
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 18:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC141281376
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 17:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459601D1E60;
	Mon,  4 Nov 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="jOH3dmFq"
X-Original-To: stable@vger.kernel.org
Received: from out0-220.mail.aliyun.com (out0-220.mail.aliyun.com [140.205.0.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439481C82E3;
	Mon,  4 Nov 2024 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739799; cv=none; b=JBki0jogcnlW4rHdWm3z37I4aRWpip3nC6if9CKtdsrgVLMuRGNxaBWhFsT+W5G2zqxFPfesJsz+Xj7pK4KvKvBLc0BwZw30LfgzTfB+zTsmIJExUKV/7T2r/aUsm7e4LlO8J6QIRYDMjugNwSNxH9VsdlkY1XBKyrfPgIP6hmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739799; c=relaxed/simple;
	bh=RD6ACfGQMfkzmvPFOmFJqfSuqq5hmkgyOO7L+g/02OI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pI+SVqT7TYZRpgUvAD6Ft/9N+lY/1OpNpqXiVfNe5VNCyPqlrz9k5+1USN29FgWHgL2HYJAIHwrzFLEDDD1E5Iup8ksv+NJf6EpzY69t1M7BTCkh+ObE+YGezVXdsYM1ZAZeTs7AS9e7p+vwqTslYp519O16hk/F7QevKpTP3VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=jOH3dmFq; arc=none smtp.client-ip=140.205.0.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1730739793; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=McKha1hmKH1clDOz2fCI8A4BsEcNH5WhtqM/+Bq5yME=;
	b=jOH3dmFqM+Ir+b5ZM1Pk/gUNuPjx1bADUL2Pd9QgPe0or5WpJkABnpraMB659wQvwL234/DWRaCYKl/X6FAv2E7qqT6xLweAm5Nnvh8JCjDW+R9uItwvLetOCCuHoYb1kpnvqEGgP/nd0MoPK5MJBkrGGjXU8f7xjNHBb770tOc=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.a0U4bET_1730737936 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 00:32:17 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc:  <linux-um@lists.infradead.org>,
   <linux-kernel@vger.kernel.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>,
   <stable@vger.kernel.org>
Subject: [PATCH 4/4] um: vector: Do not use drvdata in release
Date: Tue, 05 Nov 2024 00:32:03 +0800
Message-Id: <20241104163203.435515-5-tiwei.btw@antgroup.com>
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
to get the vector_device instance. Otherwise, removing a vector device
will result in a crash:

RIP: 0033:vector_device_release+0xf/0x50
RSP: 00000000e187bc40  EFLAGS: 00010202
RAX: 0000000060028f61 RBX: 00000000600f1baf RCX: 00000000620074e0
RDX: 000000006220b9c0 RSI: 0000000060551c80 RDI: 0000000000000000
RBP: 00000000e187bc50 R08: 00000000603ad594 R09: 00000000e187bb70
R10: 000000000000135a R11: 00000000603ad422 R12: 00000000623ae028
R13: 000000006287a200 R14: 0000000062006d30 R15: 00000000623700b6
Kernel panic - not syncing: Segfault with no mm
CPU: 0 UID: 0 PID: 16 Comm: kworker/0:1 Not tainted 6.12.0-rc6-g59b723cd2adb #1
Workqueue: events mc_work_proc
Stack:
 60028f61 623ae028 e187bc80 60276fcd
 6220b9c0 603f5820 623ae028 00000000
 e187bcb0 603a2bcd 623ae000 62370010
Call Trace:
 [<60028f61>] ? vector_device_release+0x0/0x50
 [<60276fcd>] device_release+0x70/0xba
 [<603a2bcd>] kobject_put+0xba/0xe7
 [<60277265>] put_device+0x19/0x1c
 [<60281266>] platform_device_put+0x26/0x29
 [<60281e5f>] platform_device_unregister+0x2c/0x2e
 [<60029422>] vector_remove+0x52/0x58
 [<60031316>] ? mconsole_reply+0x0/0x50
 [<600310c8>] mconsole_remove+0x160/0x1cc
 [<603b19f4>] ? strlen+0x0/0x15
 [<60066611>] ? __dequeue_entity+0x1a9/0x206
 [<600666a7>] ? set_next_entity+0x39/0x63
 [<6006666e>] ? set_next_entity+0x0/0x63
 [<60038fa6>] ? um_set_signals+0x0/0x43
 [<6003070c>] mc_work_proc+0x77/0x91
 [<60057664>] process_scheduled_works+0x1b3/0x2dd
 [<60055f32>] ? assign_work+0x0/0x58
 [<60057f0a>] worker_thread+0x1e9/0x293
 [<6005406f>] ? set_pf_worker+0x0/0x64
 [<6005d65d>] ? arch_local_irq_save+0x0/0x2d
 [<6005d748>] ? kthread_exit+0x0/0x3a
 [<60057d21>] ? worker_thread+0x0/0x293
 [<6005dbf1>] kthread+0x126/0x12b
 [<600219c5>] new_thread_handler+0x85/0xb6

Cc: stable@vger.kernel.org
Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/vector_kern.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
index c992da83268d..64c09db392c1 100644
--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -815,7 +815,8 @@ static struct platform_driver uml_net_driver = {
 
 static void vector_device_release(struct device *dev)
 {
-	struct vector_device *device = dev_get_drvdata(dev);
+	struct vector_device *device =
+		container_of(dev, struct vector_device, pdev.dev);
 	struct net_device *netdev = device->dev;
 
 	list_del(&device->list);
-- 
2.34.1


