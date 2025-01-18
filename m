Return-Path: <stable+bounces-109455-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FA3A15E27
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 17:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 300BB1886F38
	for <lists+stable@lfdr.de>; Sat, 18 Jan 2025 16:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AA519CC24;
	Sat, 18 Jan 2025 16:54:38 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45ABC7FD
	for <stable@vger.kernel.org>; Sat, 18 Jan 2025 16:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737219277; cv=none; b=a8y/4SoubiPq1K7BcYlRWWJ4qKG7B444xKcork/GcKL+PCATTg5BagqDcvUkJp2VLzlxzEolfXRaBFMaueFOAzVNJEIBqK/4o/EunK2tQqpfZUGRX/wVs7jG5ns3CJ8nOCW3YJWiwinhkh8D5iYH/5AOmU0U8G/gaJQn7T1vCGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737219277; c=relaxed/simple;
	bh=Tp7Wc2DVq6fBV+4ZDRn2KausfnrCiU9P2SQTjMaUG78=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=A8yLIXo5gsMNHkxeTPI1X9KzMn9+NHlhfl76JnSd+zARPJII4QMyEfPeGisKW+l9XHvgCrNVRSZKdj/UgYo152jzb81OP/avo2y7gx9Twbf3VrjGHmwGhmeZNfp8E81mvUO+7s+dO/o5crsiSrlEaxmq/vLDy+DJliSA6OhV8dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 56109233BA;
	Sat, 18 Jan 2025 19:54:24 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org,
	Baokun Li <libaokun1@huawei.com>,
	stable@kernel.org,
	Christian Brauner <brauner@kernel.org>
Subject: [PATCH 6.1] fscache: delete fscache_cookie_lru_timer when fscache exits to avoid UAF
Date: Sat, 18 Jan 2025 19:53:49 +0300
Message-Id: <20250118165349.472773-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
[kovalev: use the `del_timer_sync()` call instead of `timer_shutdown_sync()`]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
Backport to fix CVE-2024-46786
Link: https://www.cve.org/CVERecord/?id=CVE-2024-46786
---
 fs/fscache/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/fscache/main.c b/fs/fscache/main.c
index dad85fd84f6f9f..dc37c9df3bef7d 100644
--- a/fs/fscache/main.c
+++ b/fs/fscache/main.c
@@ -114,6 +114,7 @@ static void __exit fscache_exit(void)
 
 	kmem_cache_destroy(fscache_cookie_jar);
 	fscache_proc_cleanup();
+	del_timer_sync(&fscache_cookie_lru_timer);
 	destroy_workqueue(fscache_wq);
 	pr_notice("Unloaded\n");
 }
-- 
2.33.8


