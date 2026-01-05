Return-Path: <stable+bounces-204901-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D2DCF567E
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 20:41:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 108F2304A8E5
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 19:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46928325716;
	Mon,  5 Jan 2026 19:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwkR/ZYp"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071BD320383
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 19:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767642061; cv=none; b=DxV9V84hogmEKzagPZgfB66Emuz1fu2WuYbF31XmoDi+a+E2GUDwnY8LGyfYWmSzAgJp0k62y2L8Zhml8R6MmgY35Din3o1O0yHYbCij2h2FOQCMJLL05yyRaWidZYs5aNjs3gOXz4AzJKqgxxvlY1hzj61QSgtTK32h1COee6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767642061; c=relaxed/simple;
	bh=o9xi/HJNWJFm5J8sb5JA4M7A+FOLLVY7ocKFz4n8AiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QxioF27d5VSdNKXPGPVYD0TcjV1OqFPgAADBnh0I8zQszanclVxWZgsqpHtyS3gYOgZzuf4Eu19fMqbFVlIU5gy+YgQxudr9pFH46F+Xn08oOTt6f0lhZkFlnLBLI/3+Wri1HzscMEezoVRr4HQzHr4VcKRs5PhO9UqAIdlNtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwkR/ZYp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096D8C116D0;
	Mon,  5 Jan 2026 19:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767642060;
	bh=o9xi/HJNWJFm5J8sb5JA4M7A+FOLLVY7ocKFz4n8AiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YwkR/ZYpllrlVRZ9M+QMXEbSITYfrybEcY1jtoVLt9VLMeBflyzXRinJjlEb6XK8e
	 5cwCQFRXmfEZ3AMjJcrQASu5BRK+KXU3l8uKnwV3jmrViWd7Rbxn4d+uhYfzYtHvzn
	 DRlAdSG6r/SoYxAFCrbY5BHIPY8O98CknBt+EDw8Krs/Iqh+eomEjANniQQkX5GNO4
	 cr90HTrQvIObXfAICSdHqg4NmxRtQtGo9TRwdiiftTsweVe8eVAefngc0Bc3xpThw3
	 SMTGKIisVIWjcTicQ2pG6IOAFGqeU86OkrMH1CyR8R/MpbunOmH7nKYwCraPgLbQP7
	 8eHAki3uak5aw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miaohe Lin <linmiaohe@huawei.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Muchun Song <songmuchun@bytedance.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] mm/balloon_compaction: make balloon page compaction callbacks static
Date: Mon,  5 Jan 2026 14:40:54 -0500
Message-ID: <20260105194057.2747929-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026010548-hacked-transfer-1f00@gregkh>
References: <2026010548-hacked-transfer-1f00@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit 504c1cabe325df65c18ef38365ddd1a41c6b591b ]

Since commit b1123ea6d3b3 ("mm: balloon: use general non-lru movable page
feature"), these functions are called via balloon_aops callbacks. They're
not called directly outside this file. So make them static and clean up
the relevant code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Link: https://lore.kernel.org/r/20220125132221.2220-1-linmiaohe@huawei.com
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
Stable-dep-of: 0da2ba35c0d5 ("powerpc/pseries/cmm: adjust BALLOON_MIGRATE when migrating pages")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/balloon_compaction.h | 22 ----------------------
 mm/balloon_compaction.c            |  6 +++---
 2 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
index 338aa27e4773..edb7f6d41faa 100644
--- a/include/linux/balloon_compaction.h
+++ b/include/linux/balloon_compaction.h
@@ -80,12 +80,6 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
 
 #ifdef CONFIG_BALLOON_COMPACTION
 extern const struct address_space_operations balloon_aops;
-extern bool balloon_page_isolate(struct page *page,
-				isolate_mode_t mode);
-extern void balloon_page_putback(struct page *page);
-extern int balloon_page_migrate(struct address_space *mapping,
-				struct page *newpage,
-				struct page *page, enum migrate_mode mode);
 
 /*
  * balloon_page_insert - insert a page into the balloon's page list and make
@@ -155,22 +149,6 @@ static inline void balloon_page_delete(struct page *page)
 	list_del(&page->lru);
 }
 
-static inline bool balloon_page_isolate(struct page *page)
-{
-	return false;
-}
-
-static inline void balloon_page_putback(struct page *page)
-{
-	return;
-}
-
-static inline int balloon_page_migrate(struct page *newpage,
-				struct page *page, enum migrate_mode mode)
-{
-	return 0;
-}
-
 static inline gfp_t balloon_mapping_gfp_mask(void)
 {
 	return GFP_HIGHUSER;
diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
index 26de020aae7b..829874221410 100644
--- a/mm/balloon_compaction.c
+++ b/mm/balloon_compaction.c
@@ -203,7 +203,7 @@ EXPORT_SYMBOL_GPL(balloon_page_dequeue);
 
 #ifdef CONFIG_BALLOON_COMPACTION
 
-bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
+static bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
 
 {
 	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
@@ -217,7 +217,7 @@ bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
 	return true;
 }
 
-void balloon_page_putback(struct page *page)
+static void balloon_page_putback(struct page *page)
 {
 	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
 	unsigned long flags;
@@ -230,7 +230,7 @@ void balloon_page_putback(struct page *page)
 
 
 /* move_to_new_page() counterpart for a ballooned page */
-int balloon_page_migrate(struct address_space *mapping,
+static int balloon_page_migrate(struct address_space *mapping,
 		struct page *newpage, struct page *page,
 		enum migrate_mode mode)
 {
-- 
2.51.0


