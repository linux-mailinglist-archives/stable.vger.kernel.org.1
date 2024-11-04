Return-Path: <stable+bounces-89724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F18959BBB10
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 18:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CB80B20E09
	for <lists+stable@lfdr.de>; Mon,  4 Nov 2024 17:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 459E71D1E70;
	Mon,  4 Nov 2024 17:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="0J6g+SWk"
X-Original-To: stable@vger.kernel.org
Received: from out0-202.mail.aliyun.com (out0-202.mail.aliyun.com [140.205.0.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A88D1C6F73;
	Mon,  4 Nov 2024 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.205.0.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730739799; cv=none; b=rBCTen6UO/YDRvGIJ/qhjG/W+sMtpCGyFHSHEY7FSaeH5dH+rdYiGO1ZrfBO8tgW5SiqU3AYNpRwA/suPblpKixSUhT6LxEaoGAJmUKGGNuQalrcuVNWSPh9b2fXclJXlxl4lizzGCCJw/Fpa2Fu0XVTZjtgI7VnxwHan24ylOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730739799; c=relaxed/simple;
	bh=bnkXs0eHBgCi9mRkEjXqpTkwIdqd4Vd894j5lmD8/vk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uTayF+8ku6gMIPHGAzfHC6zqddRXU145oWEdYb9hFF7MQXEm+vLd74MRVKhDHvZpJU0zkKF3pV6z9lvGuPH5h0YlRnC3CgtkLDDetrJ7qW7iS+HOmr8vi1hKwd9v+KAzvw6hxjQ0SZE4vzAk0u4CE8hbzo0qmJk3VXydKP95+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=0J6g+SWk; arc=none smtp.client-ip=140.205.0.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1730739792; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=A9Ug1sUdXc2iX3oOncxuy+ebR5G1J5WF+JdyHds/Qns=;
	b=0J6g+SWk6LE3oE75yXbZB55ot1YbH6FEJXhPmwt2H5ZYWrtgx4XJMhlm/TcOl6F5TaXo5RimEFyTKWOMU4XAjsdIXYuNwbub6xOEz2cr9Nwrflzp/X4h5IYEW8S8O+EHGjlUQBPZMXZmFhgNh2vyG+fqWxQWQV1hsBHJSHNXdmc=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.a0U4bEN_1730737936 cluster:ay29)
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
Subject: [PATCH 3/4] um: net: Do not use drvdata in release
Date: Tue, 05 Nov 2024 00:32:02 +0800
Message-Id: <20241104163203.435515-4-tiwei.btw@antgroup.com>
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
to get the uml_net instance. Otherwise, removing a network device will
result in a crash:

RIP: 0033:net_device_release+0x10/0x6f
RSP: 00000000e20c7c40  EFLAGS: 00010206
RAX: 000000006002e4e7 RBX: 00000000600f1baf RCX: 00000000624074e0
RDX: 0000000062778000 RSI: 0000000060551c80 RDI: 00000000627af028
RBP: 00000000e20c7c50 R08: 00000000603ad594 R09: 00000000e20c7b70
R10: 000000000000135a R11: 00000000603ad422 R12: 0000000000000000
R13: 0000000062c7af00 R14: 0000000062406d60 R15: 00000000627700b6
Kernel panic - not syncing: Segfault with no mm
CPU: 0 UID: 0 PID: 29 Comm: kworker/0:2 Not tainted 6.12.0-rc6-g59b723cd2adb #1
Workqueue: events mc_work_proc
Stack:
 627af028 62c7af00 e20c7c80 60276fcd
 62778000 603f5820 627af028 00000000
 e20c7cb0 603a2bcd 627af000 62770010
Call Trace:
 [<60276fcd>] device_release+0x70/0xba
 [<603a2bcd>] kobject_put+0xba/0xe7
 [<60277265>] put_device+0x19/0x1c
 [<60281266>] platform_device_put+0x26/0x29
 [<60281e5f>] platform_device_unregister+0x2c/0x2e
 [<6002ec9c>] net_remove+0x63/0x69
 [<60031316>] ? mconsole_reply+0x0/0x50
 [<600310c8>] mconsole_remove+0x160/0x1cc
 [<60087d40>] ? __remove_hrtimer+0x38/0x74
 [<60087ff8>] ? hrtimer_try_to_cancel+0x8c/0x98
 [<6006b3cf>] ? dl_server_stop+0x3f/0x48
 [<6006b390>] ? dl_server_stop+0x0/0x48
 [<600672e8>] ? dequeue_entities+0x327/0x390
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
 arch/um/drivers/net_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/net_kern.c b/arch/um/drivers/net_kern.c
index 77c4afb8ab90..75d04fb4994a 100644
--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -336,7 +336,7 @@ static struct platform_driver uml_net_driver = {
 
 static void net_device_release(struct device *dev)
 {
-	struct uml_net *device = dev_get_drvdata(dev);
+	struct uml_net *device = container_of(dev, struct uml_net, pdev.dev);
 	struct net_device *netdev = device->dev;
 	struct uml_net_private *lp = netdev_priv(netdev);
 
-- 
2.34.1


