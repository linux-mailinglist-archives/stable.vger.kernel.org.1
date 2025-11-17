Return-Path: <stable+bounces-194937-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C8C9C63061
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 10:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9430C4E9CB5
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 09:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A54F2D7DC7;
	Mon, 17 Nov 2025 09:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AnK1WtKl"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE382324B0F;
	Mon, 17 Nov 2025 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370074; cv=none; b=WoGQkW0QDRbfUeivqzIDDbSxpvqH0Kf5nQbNAt27oaKXeVPCGA+/s7CNWkw25AszYIGnhbxwA4IbdKudhfQ4Y19qVWtGMY7RNiNa7jPy1XIhD/cMn86/TxVjnJYMOoICMSJuAeSGe23Wk/MkCxWyDFAlUNVQjLsG6zCLM4frTu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370074; c=relaxed/simple;
	bh=ACJm+u6Gj4h51hX4BzY9VIO91osQ4LYBnz6N6upuuM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rnn+FO6M7Y15NiiQ/zI/wV9Aa/yjV+nspLEBtgoeB2UK3C+foNZsKfAYoWy0mUXY3+rWIn79wreYpreMhfkt2vqHAJi3vrHhC1jgu1WRuI/ZAHos//GlhlH0DRUpjtUVw37A1ThnLR20NySZ8OJcndpauySMTYffqWgn4ee5Ovg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AnK1WtKl; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=UC
	oyTfr8gCn8mJ1uiwDuIzSa07pY7bQVEfFH0JQUb/o=; b=AnK1WtKlwnBLWPojsY
	QV7/mG8PIQ4VkMAhh42b0phurQvL0PxVAvKH3QQKe4v62yfbY58F8bQMIG7AUbtZ
	SvnUP5YJCVSVmWDJ9pj3Gah8d/bgj9GOKdu5Cx4/ceW5fJdQg2R4xhw7WLCkn3Qs
	O+LjLCjdyjAeDM9pSZ5NWg8n4=
Received: from localhost (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXSpP94xppVWuYAw--.64332S3;
	Mon, 17 Nov 2025 16:59:42 +0800 (CST)
From: mambaxin@163.com
To: dennis@kernel.org,
	tj@kernel.org,
	cl@linux.com,
	akpm@linux-foundation.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	mhocko@suse.com,
	Vlastimil Babka <vbabka@suse.cz>,
	Filipe David Manana <fdmanana@suse.com>,
	chenxin <chenxinxin@xiaomi.com>
Subject: [PATCH 6.1.y] mm, percpu: do not consider sleepable allocations atomic
Date: Mon, 17 Nov 2025 16:59:22 +0800
Message-ID: <20251117085922.508060-1-mambaxin@163.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXSpP94xppVWuYAw--.64332S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxGryrXFy3KrW7urW7GFWfXwb_yoW5Kw4DpF
	ZYg3W0vFZ5Xrn3Ww1vv3WIgw4Ygw4rWFW5G3ZxWw18Zrs8Jr1jgr92ya4YqFy8XF9Y9F1Y
	vrZ0qF9aqayjya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jneOJUUUUU=
X-CM-SenderInfo: xpdputx0lqqiywtou0bp/1tbiJhkJCmka3GjFMQAAsP

From: Michal Hocko <mhocko@suse.com>

[ Upstream commit 9a5b183941b52f84c0f9e5f27ce44e99318c9e0f ]

28307d938fb2 ("percpu: make pcpu_alloc() aware of current gfp context")
has fixed a reclaim recursion for scoped GFP_NOFS context.  It has done
that by avoiding taking pcpu_alloc_mutex.  This is a correct solution as
the worker context with full GFP_KERNEL allocation/reclaim power and which
is using the same lock cannot block the NOFS pcpu_alloc caller.

On the other hand this is a very conservative approach that could lead to
failures because pcpu_alloc lockless implementation is quite limited.

We have a bug report about premature failures when scsi array of 193
devices is scanned.  Sometimes (not consistently) the scanning aborts
because the iscsid daemon fails to create the queue for a random scsi
device during the scan.  iscsid itself is running with PR_SET_IO_FLUSHER
set so all allocations from this process context are GFP_NOIO.  This in
turn makes any pcpu_alloc lockless (without pcpu_alloc_mutex) which leads
to pre-mature failures.

It has turned out that iscsid has worked around this by dropping
PR_SET_IO_FLUSHER (https://github.com/open-iscsi/open-iscsi/pull/382) when
scanning host.  But we can do better in this case on the kernel side and
use pcpu_alloc_mutex for NOIO resp.  NOFS constrained allocation scopes
too.  We just need the WQ worker to never trigger IO/FS reclaim.  Achieve
that by enforcing scoped GFP_NOIO for the whole execution of
pcpu_balance_workfn (this will imply NOFS constrain as well).  This will
remove the dependency chain and preserve the full allocation power of the
pcpu_alloc call.

While at it make is_atomic really test for blockable allocations.

Link: https://lkml.kernel.org/r/20250206122633.167896-1-mhocko@kernel.org
Fixes: 28307d938fb2 ("percpu: make pcpu_alloc() aware of current gfp context")
Signed-off-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Cc: Dennis Zhou <dennis@kernel.org>
Cc: Filipe David Manana <fdmanana@suse.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: chenxin <chenxinxin@xiaomi.com>
---
 mm/percpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/percpu.c b/mm/percpu.c
index 39e645dfd46c..651101c895ed 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -1737,7 +1737,7 @@ static void __percpu *pcpu_alloc(size_t size, size_t align, bool reserved,
 	gfp = current_gfp_context(gfp);
 	/* whitelisted flags that can be passed to the backing allocators */
 	pcpu_gfp = gfp & (GFP_KERNEL | __GFP_NORETRY | __GFP_NOWARN);
-	is_atomic = (gfp & GFP_KERNEL) != GFP_KERNEL;
+	is_atomic = !gfpflags_allow_blocking(gfp);
 	do_warn = !(gfp & __GFP_NOWARN);
 
 	/*
@@ -2237,7 +2237,12 @@ static void pcpu_balance_workfn(struct work_struct *work)
 	 * to grow other chunks.  This then gives pcpu_reclaim_populated() time
 	 * to move fully free chunks to the active list to be freed if
 	 * appropriate.
+	 *
+	 * Enforce GFP_NOIO allocations because we have pcpu_alloc users
+	 * constrained to GFP_NOIO/NOFS contexts and they could form lock
+	 * dependency through pcpu_alloc_mutex
 	 */
+	unsigned int flags = memalloc_noio_save();
 	mutex_lock(&pcpu_alloc_mutex);
 	spin_lock_irq(&pcpu_lock);
 
@@ -2248,6 +2253,7 @@ static void pcpu_balance_workfn(struct work_struct *work)
 
 	spin_unlock_irq(&pcpu_lock);
 	mutex_unlock(&pcpu_alloc_mutex);
+	memalloc_noio_restore(flags);
 }
 
 /**
-- 
2.50.1


