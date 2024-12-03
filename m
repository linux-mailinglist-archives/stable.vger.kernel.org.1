Return-Path: <stable+bounces-97236-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF2E9E2371
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 16:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D937A16749B
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C949A1F9F69;
	Tue,  3 Dec 2024 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i3fJSjQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E261F75A8;
	Tue,  3 Dec 2024 15:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733239908; cv=none; b=kITygiZHYCc/FLXyRLRCRstne0tYmICkTlur/56XgLHWkp472+f3UDDimQeelH7/ytFGq2tXdQDV/pmqzhPU5JMiDpxMqjSQ+CzQK+fDTqp9aFrF78YDbGZV9gQr+tbAc+gcIxDAZpXeghADdjlhODL79nKs3UjDKSKn0jSlVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733239908; c=relaxed/simple;
	bh=ZKSyxQSjNQ2dM5CbD2KiomQt/uve8oWpIYhfdCyT6Qw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cf4Sd1XcisB1t+kKoubwa6IeIA6io/v1dlqM05v5mFqSVhOKmvtgMNQzG4jCSX3FeNSswZ/ydqTFChSwdk4tkgxpPOWmOGgO9I8nNXDh40h2df2AhpGJh8GusIzXqlJLl4va10JC9PveZT9IwyKprUmD9RN+uP6W+41ZIeOER9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i3fJSjQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E751C4CED8;
	Tue,  3 Dec 2024 15:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733239908;
	bh=ZKSyxQSjNQ2dM5CbD2KiomQt/uve8oWpIYhfdCyT6Qw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3fJSjQL0lnjnBgvz2nstjAK7mknhXNOM1ecRSyMeCTVNu1bhAgS+/ZVed6JcFCC8
	 2XfO30tRy7j4OjFAvEAiwxP5ot+V33Wg0S30rnj286uLU4nSPMwB7rjD7PDRL+oCzc
	 PtYvrFSZjneA9M0DuYRx9UCGKgZS5xIFvVN1b8Ew=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 774/817] ubi: fastmap: wl: Schedule fm_work if wear-leveling pool is empty
Date: Tue,  3 Dec 2024 15:45:46 +0100
Message-ID: <20241203144026.225993604@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241203143955.605130076@linuxfoundation.org>
References: <20241203143955.605130076@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhihao Cheng <chengzhihao1@huawei.com>

[ Upstream commit c4595fe394a289927077e3da561db27811919ee0 ]

Since commit 14072ee33d5a ("ubi: fastmap: Check wl_pool for free peb
before wear leveling"), wear_leveling_worker() won't schedule fm_work
if wear-leveling pool is empty, which could temporarily disable the
wear-leveling until the fastmap is updated(eg. pool becomes empty).
Fix it by scheduling fm_work if wl_pool is empty during wear-leveing.

Fixes: 14072ee33d5a ("ubi: fastmap: Check wl_pool for free peb before wear leveling")
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/ubi/fastmap-wl.c | 19 ++++++++++++++++---
 drivers/mtd/ubi/wl.c         |  2 +-
 drivers/mtd/ubi/wl.h         |  3 ++-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/ubi/fastmap-wl.c b/drivers/mtd/ubi/fastmap-wl.c
index 2a9cc9413c427..9bdb6525f1281 100644
--- a/drivers/mtd/ubi/fastmap-wl.c
+++ b/drivers/mtd/ubi/fastmap-wl.c
@@ -346,14 +346,27 @@ int ubi_wl_get_peb(struct ubi_device *ubi)
  * WL sub-system.
  *
  * @ubi: UBI device description object
+ * @need_fill: whether to fill wear-leveling pool when no PEBs are found
  */
-static struct ubi_wl_entry *next_peb_for_wl(struct ubi_device *ubi)
+static struct ubi_wl_entry *next_peb_for_wl(struct ubi_device *ubi,
+					    bool need_fill)
 {
 	struct ubi_fm_pool *pool = &ubi->fm_wl_pool;
 	int pnum;
 
-	if (pool->used == pool->size)
+	if (pool->used == pool->size) {
+		if (need_fill && !ubi->fm_work_scheduled) {
+			/*
+			 * We cannot update the fastmap here because this
+			 * function is called in atomic context.
+			 * Let's fail here and refill/update it as soon as
+			 * possible.
+			 */
+			ubi->fm_work_scheduled = 1;
+			schedule_work(&ubi->fm_work);
+		}
 		return NULL;
+	}
 
 	pnum = pool->pebs[pool->used];
 	return ubi->lookuptbl[pnum];
@@ -375,7 +388,7 @@ static bool need_wear_leveling(struct ubi_device *ubi)
 	if (!ubi->used.rb_node)
 		return false;
 
-	e = next_peb_for_wl(ubi);
+	e = next_peb_for_wl(ubi, false);
 	if (!e) {
 		if (!ubi->free.rb_node)
 			return false;
diff --git a/drivers/mtd/ubi/wl.c b/drivers/mtd/ubi/wl.c
index 8a26968aba11f..fbd399cf65033 100644
--- a/drivers/mtd/ubi/wl.c
+++ b/drivers/mtd/ubi/wl.c
@@ -683,7 +683,7 @@ static int wear_leveling_worker(struct ubi_device *ubi, struct ubi_work *wrk,
 	ubi_assert(!ubi->move_to_put);
 
 #ifdef CONFIG_MTD_UBI_FASTMAP
-	if (!next_peb_for_wl(ubi) ||
+	if (!next_peb_for_wl(ubi, true) ||
 #else
 	if (!ubi->free.rb_node ||
 #endif
diff --git a/drivers/mtd/ubi/wl.h b/drivers/mtd/ubi/wl.h
index 7b6715ef6d4a3..a69169c35e310 100644
--- a/drivers/mtd/ubi/wl.h
+++ b/drivers/mtd/ubi/wl.h
@@ -5,7 +5,8 @@
 static void update_fastmap_work_fn(struct work_struct *wrk);
 static struct ubi_wl_entry *find_anchor_wl_entry(struct rb_root *root);
 static struct ubi_wl_entry *get_peb_for_wl(struct ubi_device *ubi);
-static struct ubi_wl_entry *next_peb_for_wl(struct ubi_device *ubi);
+static struct ubi_wl_entry *next_peb_for_wl(struct ubi_device *ubi,
+					    bool need_fill);
 static bool need_wear_leveling(struct ubi_device *ubi);
 static void ubi_fastmap_close(struct ubi_device *ubi);
 static inline void ubi_fastmap_init(struct ubi_device *ubi, int *count)
-- 
2.43.0




