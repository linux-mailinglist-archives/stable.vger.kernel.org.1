Return-Path: <stable+bounces-106059-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8572B9FBA6C
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 09:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76FA1883F37
	for <lists+stable@lfdr.de>; Tue, 24 Dec 2024 08:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C98A14A099;
	Tue, 24 Dec 2024 08:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aHkJBYUc"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17E4516F0FE
	for <stable@vger.kernel.org>; Tue, 24 Dec 2024 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735027883; cv=none; b=L5pHh1z2yxUI3QwQntdJJZML0xUuVJBWbNiDFQUrGDk0Y1FFTzvNonAZ33TTmIy00xgWTQIOiHy3cWnvoVVJlCJNRpdmOn8DBiDsqzrteZ3ac7irzuvIOhuhRY2/nahU7iTiuC2Mna6JzFNMEXynrPz4jLb8vJE7ZwkWIbokMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735027883; c=relaxed/simple;
	bh=TYJ918j1tLu7iz37tCV9WlXJfkpm2PR4Gqbf9Lm8Azc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=Fcrsffnxw3p/4Kc55gWDWqUrL8FnU4CjTK6vipjbpimqpMxqA6FnrYUITQbk04ptDkYt2GvT1s+Akc+4npnl/v+DRlVs0O2T+Tf0j3DMngsrVXNzAxFvL/UuOcpWTbHh2ENfBwGgo5Wz+ASknzZ4B1LTdkNEbpRItHI4TyITRTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aHkJBYUc; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=sSO2f
	CafuR5FYd9QutZVYPFDBhE2ZcW84J+ye2N9Qss=; b=aHkJBYUcBlsmU8PKmsKPO
	WuByXLJ5EBibUg/hXC+0UhJDL8M16KN0akcSUWWbHnZ89i6jnm5mu+USk1U44nxF
	/Rv8hQv93ArUsGvFBwbIurRPmyBX7WH24YPqeeXtxUx9SyMJzR/rnbsL7JODYHFL
	oNxoOaDd3Ctv5FBTHlOIIg=
Received: from pek-blan-cn-l1.corp.ad.wrs.com (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3CCyRbGpnGRVFBQ--.20453S2;
	Tue, 24 Dec 2024 16:11:07 +0800 (CST)
From: Wenshan Lan <jetlan9@163.com>
To: stable@vger.kernel.org,
	qun-wei.lin@mediatek.com
Subject: [PATCH 6.6] sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers
Date: Tue, 24 Dec 2024 16:10:57 +0800
Message-Id: <20241224081057.2711-1-jetlan9@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3CCyRbGpnGRVFBQ--.20453S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrWfGrWfGF17ZFy3CrW7Arb_yoWrGr4Up3
	sxKr17GFW8Jr1xtr4UAFWjkrWUJayDuF1UJry2qw18tFy5Ar45tr97tFWfCFyUArWjya43
	tF1qgr97Kr4DAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRWq2iUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/xtbBDx6-yGdqZm6wLQAAs+

From: Qun-Wei Lin <qun-wei.lin@mediatek.com>

[ Upstream commit fd7b4f9f46d46acbc7af3a439bb0d869efdc5c58 ]

When CONFIG_KASAN_SW_TAGS and CONFIG_KASAN_STACK are enabled, the
object_is_on_stack() function may produce incorrect results due to the
presence of tags in the obj pointer, while the stack pointer does not have
tags.  This discrepancy can lead to incorrect stack object detection and
subsequently trigger warnings if CONFIG_DEBUG_OBJECTS is also enabled.

Example of the warning:

ODEBUG: object 3eff800082ea7bb0 is NOT on stack ffff800082ea0000, but annotated.
------------[ cut here ]------------
WARNING: CPU: 0 PID: 1 at lib/debugobjects.c:557 __debug_object_init+0x330/0x364
Modules linked in:
CPU: 0 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-rc5 #4
Hardware name: linux,dummy-virt (DT)
pstate: 600000c5 (nZCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __debug_object_init+0x330/0x364
lr : __debug_object_init+0x330/0x364
sp : ffff800082ea7b40
x29: ffff800082ea7b40 x28: 98ff0000c0164518 x27: 98ff0000c0164534
x26: ffff800082d93ec8 x25: 0000000000000001 x24: 1cff0000c00172a0
x23: 0000000000000000 x22: ffff800082d93ed0 x21: ffff800081a24418
x20: 3eff800082ea7bb0 x19: efff800000000000 x18: 0000000000000000
x17: 00000000000000ff x16: 0000000000000047 x15: 206b63617473206e
x14: 0000000000000018 x13: ffff800082ea7780 x12: 0ffff800082ea78e
x11: 0ffff800082ea790 x10: 0ffff800082ea79d x9 : 34d77febe173e800
x8 : 34d77febe173e800 x7 : 0000000000000001 x6 : 0000000000000001
x5 : feff800082ea74b8 x4 : ffff800082870a90 x3 : ffff80008018d3c4
x2 : 0000000000000001 x1 : ffff800082858810 x0 : 0000000000000050
Call trace:
 __debug_object_init+0x330/0x364
 debug_object_init_on_stack+0x30/0x3c
 schedule_hrtimeout_range_clock+0xac/0x26c
 schedule_hrtimeout+0x1c/0x30
 wait_task_inactive+0x1d4/0x25c
 kthread_bind_mask+0x28/0x98
 init_rescuer+0x1e8/0x280
 workqueue_init+0x1a0/0x3cc
 kernel_init_freeable+0x118/0x200
 kernel_init+0x28/0x1f0
 ret_from_fork+0x10/0x20
---[ end trace 0000000000000000 ]---
ODEBUG: object 3eff800082ea7bb0 is NOT on stack ffff800082ea0000, but annotated.
------------[ cut here ]------------

Link: https://lkml.kernel.org/r/20241113042544.19095-1-qun-wei.lin@mediatek.com
Signed-off-by: Qun-Wei Lin <qun-wei.lin@mediatek.com>
Cc: Andrew Yang <andrew.yang@mediatek.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Casper Li <casper.li@mediatek.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Chinwen Chang <chinwen.chang@mediatek.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ Resolve line conflicts ]
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 include/linux/sched/task_stack.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index f158b025c175..d2117e1c8fa5 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -8,6 +8,7 @@
 
 #include <linux/sched.h>
 #include <linux/magic.h>
+#include <linux/kasan.h>
 
 #ifdef CONFIG_THREAD_INFO_IN_TASK
 
@@ -88,6 +89,7 @@ static inline int object_is_on_stack(const void *obj)
 {
 	void *stack = task_stack_page(current);
 
+	obj = kasan_reset_tag(obj);
 	return (obj >= stack) && (obj < (stack + THREAD_SIZE));
 }
 
-- 
2.43.0


