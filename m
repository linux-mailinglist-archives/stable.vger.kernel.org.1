Return-Path: <stable+bounces-102158-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E18E09EF148
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:36:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C1F17A21E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B031E22B8C6;
	Thu, 12 Dec 2024 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jQVZQYLC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBD22332E;
	Thu, 12 Dec 2024 16:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020195; cv=none; b=Rov/JyFwmrDErylwaqtD3OqmtIjMF9SJs+xh1hpoc8kFQnTHLwoLqAFNRZrUoPher6o2jT0Zt9iZqYLWhet2EJMY2cQCTz0yMexMac9bQXcHKBWIAsn+LmgV+ONSLWZrZOhdEOXS+hioY32XlGaivUkIOixOJrsK/oZg65XQxsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020195; c=relaxed/simple;
	bh=e8r0BB1H5OX6ZqVc8TPTARCm1HKiOaIpIaM2QMAxX9k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXVpsehJ+XbYx47hMfX8lWCNwUPVpdDazg4bmU441HWVt5s+f5qiatvIJ/nONbeOOlWclYBfkKsrHNc92A+SCf03GVkwjM2brhHZ0nNIcYhAXjKjX/m6tTZRflr6d41GYXxLETG9cBK1MC3tDoPgRuGPYdZxS43iMbeTy8wgIOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jQVZQYLC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4FDBC4CED0;
	Thu, 12 Dec 2024 16:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734020195;
	bh=e8r0BB1H5OX6ZqVc8TPTARCm1HKiOaIpIaM2QMAxX9k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jQVZQYLCzZ3cSJsjLtWQxZtypSoRCAKQD9RjweShTt9+qWXKyWJSdgizBRRpzGByu
	 EZl9P7UJWh1N2HmVoleDYNiT79XanoZM1zSD5I1P4zPhOnem6SuJzkG9HjmuJ4fvDi
	 IJNyR9rO5BYnHuc1v4q45Bu/if3mEB4j8R0Cirls=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tiwei Bie <tiwei.btw@antgroup.com>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.1 403/772] um: vector: Do not use drvdata in release
Date: Thu, 12 Dec 2024 15:55:48 +0100
Message-ID: <20241212144406.579096348@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tiwei Bie <tiwei.btw@antgroup.com>

commit 51b39d741970742a5c41136241a9c48ac607cf82 upstream.

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
Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Link: https://patch.msgid.link/20241104163203.435515-5-tiwei.btw@antgroup.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/um/drivers/vector_kern.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/arch/um/drivers/vector_kern.c
+++ b/arch/um/drivers/vector_kern.c
@@ -823,7 +823,8 @@ static struct platform_driver uml_net_dr
 
 static void vector_device_release(struct device *dev)
 {
-	struct vector_device *device = dev_get_drvdata(dev);
+	struct vector_device *device =
+		container_of(dev, struct vector_device, pdev.dev);
 	struct net_device *netdev = device->dev;
 
 	list_del(&device->list);



