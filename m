Return-Path: <stable+bounces-107800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 807B4A03865
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 08:07:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA760188670E
	for <lists+stable@lfdr.de>; Tue,  7 Jan 2025 07:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F101DFE0A;
	Tue,  7 Jan 2025 07:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Ghk3cMah"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106D41DD873
	for <stable@vger.kernel.org>; Tue,  7 Jan 2025 07:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736233639; cv=none; b=IqUvTnbL1zF0RYmgqKRUmsVee5lj4fIAuuXCTeCgGqlP6pNYq+RcYq+zm7oygQRbIcJr612EH2Xv3axZrA5no12bEjJNqJ+w5B17whhumcipOHj5e5FkheGGp57CxCRHJUssTedQDOiIFltOfKRnpT5GYGjPqpoTZsRcIZcXNEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736233639; c=relaxed/simple;
	bh=bVFF6ep/AIYozu3OLrkyJA16tKR24TBq2lVnSmcFyFY=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=YYlIme7q78NjCK9RcMetV/s7geQwWLmJa8RDQwZL5xBGX7K8fCnqEcrNS7zv/ymNPwL1rtREcvIHvyyCU/xGt60gUDuMY3wKJPVfI8N7u0WpJ1u5md7/rGqhmR9OJsIXhDSeys0pPbicJL6dSsVcR6XRd/o6Z3oh99ss/BR5p4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Ghk3cMah; arc=none smtp.client-ip=162.62.57.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1736233630;
	bh=2EC2rjonQO3RMSGAzKHzIp0B5MRmFy2W3I1TfsIOGZQ=;
	h=From:To:Cc:Subject:Date;
	b=Ghk3cMah45EdCfa2iqLFfwBmLJhWThInfumFr6QxEyl17Sk2wZbcSYEBSR7wfHhuP
	 wf569e5IqQT4Vydu0YxLfj/IkZrVNGnfA3rSr2UIXQQ/E26NuuMIZx74xNRPLUzH7H
	 gqw2as/pbiVtWHn16bKRW6nx2b5Z+qfvieKzIs9w=
Received: from pek-blan-cn-l1.corp.ad.wrs.com ([120.244.194.133])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 1B88D2BB; Tue, 07 Jan 2025 15:06:56 +0800
X-QQ-mid: xmsmtpt1736233616t8sxbc343
Message-ID: <tencent_8132C47A03471C66AC0181B6AD46F9634705@qq.com>
X-QQ-XMAILINFO: NQR8mRxMnur9Wu40iUsqWyaexMBK3N7Tn6ZUylfZbnK4QecgXiU1PyV2Q9OLkx
	 9qYqi502j0Gncihq4EGbmwdhhfYrNlC56FghXOeph9UHL7x8gu+AjL3+iaaslF8yV2lAkXO/DgME
	 caE7ztaJkCY5NkHAr4juMOcrecNO/yIr5CZs9mAq8NnnwhvniGjwD89H4VM1AA1fU7woD1HJa3Ap
	 P3xacBBPwBXeCPIscKPAA2NuXkDKVh9rKOOwQjp9LhCH4zVmowM4vw8evm5GTqzF/3t8KXZElojE
	 mD9LghKkkgmPEfY+IvFYk3BJsWMJPy4IpJUnOimbfgbxFxCcEo68HUg3uuB4sXzNsiP11on6cDrR
	 5YAAWPUcka68Sgx1KsuIIZgHpj4f+PpBX6oyF6f7AVxv1LUMWRHY3OLT2KbQ3WKyVmYD22rYlp4F
	 FqocdAgoy9xFD6mv5h6AGt+G6yDulCtQ+Pmc09le3mG5E1rW/gMePqrvebDOomsvdhcvH3Lazw24
	 TjHZD9QqJ3TFbjULrTH+eodFvxcs5ENMHFRFFVivpbJQE+PlBz0l9uM7Y7bhBPUsDb+x20WE19sw
	 9NSs0WJZmEuiZfjAaYLFcv4GRsn+B5UH1/Wz6dK5C4YEOn3xK6h/rWLO636Bt6EjMY54YS6oYlWu
	 29+2ywyFDzUjCLhidzCy/n+Zg8ROfbQ1skUi5D0Iu+RlZCQkwnxX4i/RZ4vr1zAgv3ArOm/BNcsD
	 y1NFlu+gjsaEPCTM95xdx8M2hLgGTyCAZJbimLXg0RJj9F2NjX9Z5pmfXnPwJVuzuZnxDiQ0olqF
	 j6wRxcKSsIUFakWNTi5arjIQ+KFfVVDh6cxoZtqeRyShnxbd/Yds/svOIH+OHJn8xCofIM2ZOUuo
	 Y2V+EK07vR6FOzNBs/zS20/xwspsdwEuqaCFm2MRvcUNTiGKT0sUC6Ms6ohkPbnmzVimqX7HjbGF
	 hugxnPeYSETcRrO5oKYg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Alva Lan <alvalan9@foxmail.com>
To: stable@vger.kernel.org,
	qun-wei.lin@mediatek.com
Cc: akpm@linux-foundation.org
Subject: [PATCH 6.1.y] sched/task_stack: fix object_is_on_stack() for KASAN tagged pointers
Date: Tue,  7 Jan 2025 15:06:56 +0800
X-OQ-MSGID: <20250107070656.2135-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
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
2.39.4


