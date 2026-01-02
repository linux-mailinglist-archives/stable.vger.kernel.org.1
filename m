Return-Path: <stable+bounces-204502-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 29605CEF41B
	for <lists+stable@lfdr.de>; Fri, 02 Jan 2026 21:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC5AC3006601
	for <lists+stable@lfdr.de>; Fri,  2 Jan 2026 20:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08885299A81;
	Fri,  2 Jan 2026 20:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b="ggWQAXOs"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258F41E0DE8
	for <stable@vger.kernel.org>; Fri,  2 Jan 2026 20:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767384197; cv=pass; b=H3fAgbfRZr8gbFyY8xiGfYmGxqfecBLGETWlZGyoe6mOEi79SRU+Mr8Tooggp1rAQhoIuaPa7TgypmwjWO6uUQfOkSHtPOcbrxkchi4HPD9w1dcRgH9KABzbTQzTmhg/52YBfIlB0r1g6iyoUX53GfoK2PMpV7CoiHILCdCppIw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767384197; c=relaxed/simple;
	bh=HL9g3IiRh/7v/gSN4CVjhdK+W2b8ub21i2k4emcxwT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kCU0dRFIDf5LuZJ6INxDD4xtZZkKhHvQv2Uf0PXO0BA6GpL+cSXORUUCpdqZjCzAf3YulpK2nsBV4jIg3cCNOOg6ef1YXEZsUSviuvnRgLfuHgYfBF/KnBgQXtBefe8Eyvm3sJE4bkGu02zb8xr/Yvv7tpdZrPVNs6Sev1T5sCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com; spf=pass smtp.mailfrom=laveeshbansal.com; dkim=pass (1024-bit key) header.d=laveeshbansal.com header.i=laveeshb@laveeshbansal.com header.b=ggWQAXOs; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=laveeshbansal.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=laveeshbansal.com
ARC-Seal: i=1; a=rsa-sha256; t=1767384191; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=dDZ9v0vVdZBwWlIFQRobSAm2rQFKK9xG8OZbZIEfjPbzRqc3NP5o0ZyTF0K2CLxu6MXqkguTVsnFRjNQnzcp65rAOW97JF44B8oiB4harraZ6Yq3EwZaSsIJ/hxzSzCzh/xzYCCP79v8q1fTAJMD24fE7o6K3GS94S9jSVVKJz0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767384191; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=QPh1YxFoOf98EOefNXPyJqrOlYSuleOd4VTYQxKsWLQ=; 
	b=KDkV5YqR6mXoms03lqCy4FgyOwPNaKSXKuXr31mTZ6xRheOT6ocu65kox0poGmyraZJp0+I2BWXDbHF55yAGK/2PPMHCW212Z+2eXTBg7N2p5gahaA5rEvqVFEg55D+EnA4bEDXAk22jfsfClSiGtxCXN69vxKkb65gDc5BsEyM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=laveeshbansal.com;
	spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
	dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767384191;
	s=zoho; d=laveeshbansal.com; i=laveeshb@laveeshbansal.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=QPh1YxFoOf98EOefNXPyJqrOlYSuleOd4VTYQxKsWLQ=;
	b=ggWQAXOsCc5j9YWAseOzFXZe9MyGPxDh4zutCrnvbDAuMG5DVX+UZ13dDz3WBdmj
	MIM+M1n+Lgeew39AGtKCjbBpXEPaKc8Pwl02+LxlajQWDPBxr6A5GlaeVhd/sjj96Ff
	UaNU6celwOD4DjHXFImVe5L+gR7WxodYiBf8YH4A=
Received: by mx.zohomail.com with SMTPS id 1767384188458512.8364472405593;
	Fri, 2 Jan 2026 12:03:08 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: laveeshbansal@gmail.com,
	laveeshb@microsoft.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/2] writeback: fix 100% CPU usage when dirtytime_expire_interval is 0
Date: Fri,  2 Jan 2026 20:01:20 +0000
Message-ID: <20260102200121.303578-2-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260102200121.303578-1-laveeshb@laveeshbansal.com>
References: <20260102200121.303578-1-laveeshb@laveeshbansal.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Laveesh Bansal <laveeshbansal@gmail.com>

When vm.dirtytime_expire_seconds is set to 0, wakeup_dirtytime_writeback()
schedules delayed work with a delay of 0, causing immediate execution.
The function then reschedules itself with 0 delay again, creating an
infinite busy loop that causes 100% kworker CPU usage.

Fix by:
- Only scheduling delayed work in wakeup_dirtytime_writeback() when
  dirtytime_expire_interval is non-zero
- Cancelling the delayed work in dirtytime_interval_handler() when
  the interval is set to 0
- Adding a guard in start_dirtytime_writeback() for defensive coding

Tested by booting kernel in QEMU with virtme-ng:
- Before fix: kworker CPU spikes to ~73%
- After fix: CPU remains at normal levels
- Setting interval back to non-zero correctly resumes writeback

Fixes: a2f4870697a5 ("fs: make sure the timestamps for lazytime inodes eventually get written")
Cc: stable@vger.kernel.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=220227
Signed-off-by: Laveesh Bansal <laveeshbansal@gmail.com>
---
 fs/fs-writeback.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 6800886c4d10..cd21c74cd0e5 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2492,7 +2492,8 @@ static void wakeup_dirtytime_writeback(struct work_struct *w)
 				wb_wakeup(wb);
 	}
 	rcu_read_unlock();
-	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
+	if (dirtytime_expire_interval)
+		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
 }
 
 static int dirtytime_interval_handler(const struct ctl_table *table, int write,
@@ -2501,8 +2502,12 @@ static int dirtytime_interval_handler(const struct ctl_table *table, int write,
 	int ret;
 
 	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
-	if (ret == 0 && write)
-		mod_delayed_work(system_percpu_wq, &dirtytime_work, 0);
+	if (ret == 0 && write) {
+		if (dirtytime_expire_interval)
+			mod_delayed_work(system_percpu_wq, &dirtytime_work, 0);
+		else
+			cancel_delayed_work_sync(&dirtytime_work);
+	}
 	return ret;
 }
 
@@ -2519,7 +2524,8 @@ static const struct ctl_table vm_fs_writeback_table[] = {
 
 static int __init start_dirtytime_writeback(void)
 {
-	schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
+	if (dirtytime_expire_interval)
+		schedule_delayed_work(&dirtytime_work, dirtytime_expire_interval * HZ);
 	register_sysctl_init("vm", vm_fs_writeback_table);
 	return 0;
 }
-- 
2.43.0


