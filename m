Return-Path: <stable+bounces-199963-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A05CCA2968
	for <lists+stable@lfdr.de>; Thu, 04 Dec 2025 08:00:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4C9B93020CE3
	for <lists+stable@lfdr.de>; Thu,  4 Dec 2025 07:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1592B9BA;
	Thu,  4 Dec 2025 07:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b="BGbIey11"
X-Original-To: stable@vger.kernel.org
Received: from smtp153-162.sina.com.cn (smtp153-162.sina.com.cn [61.135.153.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CE32E413
	for <stable@vger.kernel.org>; Thu,  4 Dec 2025 07:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=61.135.153.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764831629; cv=none; b=UPgcT9LkCocXZyE2lo2cXQtfxpUDhdZdF70TLYM1DZnZWsBXVjEkFAaK+Y73plm1z9hPmNV3RUmdSJpluz0PnFEkWUGiax70g20j3Kwkg2YKZuLEtQmLuqbi5ikAgh4PzJ4d+c78BHAuEg6tkZnZS23rvwmLRAnLPiMn20syWFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764831629; c=relaxed/simple;
	bh=TGumV486UZSTAG9s+J/o2EFLLt7SBm+tS9oSmIVoPGU=;
	h=From:To:Subject:Date:Message-Id; b=imkTxPeGSAuMKg7zq2D4H2rCeqb8fTvy/PzjrjtHg33FTttScOLuMDqqVWUwQJxhfZGUuYUWWHlDYCd/gsC2DGY3KKhM+mzRxnwqXOxP9qubSPUPwj+yFBoJeU9zrhy2Am215HLuZtscwEN8oPXIL/Ep9cxsMTFNAHTreP6kq2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn; spf=pass smtp.mailfrom=sina.cn; dkim=pass (1024-bit key) header.d=sina.cn header.i=@sina.cn header.b=BGbIey11; arc=none smtp.client-ip=61.135.153.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.cn; s=201208; t=1764831613;
	bh=4T4Hu8CcUXR/xo+769PMdbdAAMZyE0jOz+3W1ANfS7A=;
	h=From:Subject:Date:Message-Id;
	b=BGbIey115tLYRD7PwKSYNmecZY8gEygwWq86SSoNT2OPMzhgyFjUd3sSQOsBLGyuR
	 9M5CWOKBUXMLap9yiH0ixXogJklZqzM7BwJnVTiRu/zuSbWZKtRUAoA1nwvm1DPzIj
	 jdw5Q8OwKzTmhflbdSnvhjsMg+nduBTuD0QbrPjo=
X-SMAIL-HELO: sina-kernel-team
Received: from unknown (HELO sina-kernel-team)([183.241.245.185])
	by sina.cn (10.54.253.31) with ESMTP
	id 693130DD00000B52; Thu, 4 Dec 2025 14:57:40 +0800 (CST)
X-Sender: xnguchen@sina.cn
X-Auth-ID: xnguchen@sina.cn
Authentication-Results: sina.cn;
	 spf=none smtp.mailfrom=xnguchen@sina.cn;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=xnguchen@sina.cn
X-SMAIL-MID: 1850976816217
X-SMAIL-UIID: C40E6E1353034B1887A75AB51243CAEA-20251204-145740-1
From: Chen Yu <xnguchen@sina.cn>
To: libaokun1@huawei.com,
	dhowells@redhat.com,
	brauner@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 6.1] fscache: delete fscache_cookie_lru_timer when fscache exits to avoid UAF
Date: Thu,  4 Dec 2025 14:57:33 +0800
Message-Id: <20251204065733.21270-1-xnguchen@sina.cn>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Baokun Li <libaokun1@huawei.com>

commit 72a6e22c604c95ddb3b10b5d3bb85b6ff4dbc34f upstream.

The fscache_cookie_lru_timer is initialized when the fscache module
is inserted, but is not deleted when the fscache module is removed.
If timer_reduce() is called before removing the fscache module,
the fscache_cookie_lru_timer will be added to the timer list of
the current cpu. Afterwards, a use-after-free will be triggered
in the softIRQ after removing the fscache module, as follows:

==================================================================
BUG: unable to handle page fault for address: fffffbfff803c9e9
 PF: supervisor read access in kernel mode
 PF: error_code(0x0000) - not-present page
PGD 21ffea067 P4D 21ffea067 PUD 21ffe6067 PMD 110a7c067 PTE 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Tainted: G W 6.11.0-rc3 #855
Tainted: [W]=WARN
RIP: 0010:__run_timer_base.part.0+0x254/0x8a0
Call Trace:
 <IRQ>
 tmigr_handle_remote_up+0x627/0x810
 __walk_groups.isra.0+0x47/0x140
 tmigr_handle_remote+0x1fa/0x2f0
 handle_softirqs+0x180/0x590
 irq_exit_rcu+0x84/0xb0
 sysvec_apic_timer_interrupt+0x6e/0x90
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20
RIP: 0010:default_idle+0xf/0x20
 default_idle_call+0x38/0x60
 do_idle+0x2b5/0x300
 cpu_startup_entry+0x54/0x60
 start_secondary+0x20d/0x280
 common_startup_64+0x13e/0x148
 </TASK>
Modules linked in: [last unloaded: netfs]
==================================================================

Therefore delete fscache_cookie_lru_timer when removing the fscahe module.

Fixes: 12bb21a29c19 ("fscache: Implement cookie user counting and resource pinning")
Cc: stable@kernel.org
Signed-off-by: Baokun Li <libaokun1@huawei.com>
Link: https://lore.kernel.org/r/20240826112056.2458299-1-libaokun@huaweicloud.com
Acked-by: David Howells <dhowells@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ Changed the file path due to missing commit:47757ea83a54 ("netfs,
fscache: Move fs/fscache/* into fs/netfs/") ]
Signed-off-by: Chen Yu <xnguchen@sina.cn>
---
 fs/fscache/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index dad85fd84f6f..7a60cd96e87e 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -114,6 +114,7 @@ static void __exit fscache_exit(void)
 
 	kmem_cache_destroy(fscache_cookie_jar);
 	fscache_proc_cleanup();
+	timer_shutdown_sync(&fscache_cookie_lru_timer);
 	destroy_workqueue(fscache_wq);
 	pr_notice("Unloaded\n");
 }
-- 
2.17.1


