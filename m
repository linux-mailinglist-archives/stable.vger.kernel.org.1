Return-Path: <stable+bounces-188180-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A6514BF25A4
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 18:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6C2514F7EAF
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 16:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEB928504F;
	Mon, 20 Oct 2025 16:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3LaKZ2Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F04226FA5E
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 16:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976970; cv=none; b=BQWoePsxYmY/iedbbKmzpbkWQHlLRSQxx+0IRYv8y3LxMxlVAZZAWwTtrPe9usDEFvBdxPvtveqVsAgmfiEUU2Y0tzJuQuJWHIAyXKbgETBZHVO6LCje5QmySncIlfUv0h5wqCizOZAdC8VXxgIbYHq0nqbPo65JwGMe0xZoI98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976970; c=relaxed/simple;
	bh=K0w1FU+s4UC4lDvgP+y6tdM2pnR1vatRv0rbto5g1Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IXde5Ct7RLerTv/sqspfq5fCBFOK4f7T3jot9nQ/qEAPNNAm/CB5ADg2nlFpCDhevN/Qmx+kybVwWnw8pVo+O/Tw3PTf8W2dP1ICwLBMWelkMk1H8yiMgjluVuBqoi5yxF/1MyAxlkyUSjiK+4lS2/jv46XxFOLhe8pSBjzyuE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3LaKZ2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2160BC4CEF9;
	Mon, 20 Oct 2025 16:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760976968;
	bh=K0w1FU+s4UC4lDvgP+y6tdM2pnR1vatRv0rbto5g1Rw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V3LaKZ2QfX5X4FfBLEf5LIM8j/z8/ZCQk705V5B2ouV8CAGjr41W3AodYG5tpWZbO
	 bScBbc0TkJ6eHIaj0YLDvCub5F35HiBhFWGSFngv32Jsz510KWiFxwBZsc6lOHNo0y
	 DpAxPoZMGq6FLcEz9XJBbkMRR1Xdj027foOr0PAfJwzC0r9CfPeuQBEqbGIDJseJl9
	 lMQ+cvdvgTWbz6ZZmtAApyVm3t81finRd8QJYXmJyjLI4J4aTHs5JWLoQIiglqMuTQ
	 TUdLKzQzJ2YvHoiw852BXtYU82UE6wnSnDmE2pY2LIVsmV4kn5h1t3ow8lw6FFvOJy
	 7EpcY2qRZC70w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kemeng Shi <shikemeng@huaweicloud.com>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] quota: remove unneeded return value of register_quota_format
Date: Mon, 20 Oct 2025 12:16:04 -0400
Message-ID: <20251020161605.1834667-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025101650-tighten-fleshed-6fe0@gregkh>
References: <2025101650-tighten-fleshed-6fe0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kemeng Shi <shikemeng@huaweicloud.com>

[ Upstream commit a838e5dca63d1dc701e63b2b1176943c57485c45 ]

The register_quota_format always returns 0, simply remove unneeded return
value.

Link: https://patch.msgid.link/20240715130534.2112678-3-shikemeng@huaweicloud.com
Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Stable-dep-of: 72b7ceca857f ("fs: quota: create dedicated workqueue for quota_release_work")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ocfs2/super.c      | 6 ++----
 fs/quota/dquot.c      | 3 +--
 fs/quota/quota_v1.c   | 3 ++-
 fs/quota/quota_v2.c   | 9 +++------
 include/linux/quota.h | 2 +-
 mm/shmem.c            | 7 +------
 6 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index e585e77cdc88e..18dba873a1633 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1571,15 +1571,13 @@ static int __init ocfs2_init(void)
 
 	ocfs2_set_locking_protocol();
 
-	status = register_quota_format(&ocfs2_quota_format);
-	if (status < 0)
-		goto out3;
+	register_quota_format(&ocfs2_quota_format);
+
 	status = register_filesystem(&ocfs2_fs_type);
 	if (!status)
 		return 0;
 
 	unregister_quota_format(&ocfs2_quota_format);
-out3:
 	debugfs_remove(ocfs2_debugfs_root);
 	ocfs2_free_mem_caches();
 out2:
diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 67562c78e57d5..ba227502b03d7 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -163,13 +163,12 @@ static struct quota_module_name module_names[] = INIT_QUOTA_MODULE_NAMES;
 /* SLAB cache for dquot structures */
 static struct kmem_cache *dquot_cachep;
 
-int register_quota_format(struct quota_format_type *fmt)
+void register_quota_format(struct quota_format_type *fmt)
 {
 	spin_lock(&dq_list_lock);
 	fmt->qf_next = quota_formats;
 	quota_formats = fmt;
 	spin_unlock(&dq_list_lock);
-	return 0;
 }
 EXPORT_SYMBOL(register_quota_format);
 
diff --git a/fs/quota/quota_v1.c b/fs/quota/quota_v1.c
index a0db3f195e951..8aaf4a501fc0d 100644
--- a/fs/quota/quota_v1.c
+++ b/fs/quota/quota_v1.c
@@ -229,7 +229,8 @@ static struct quota_format_type v1_quota_format = {
 
 static int __init init_v1_quota_format(void)
 {
-        return register_quota_format(&v1_quota_format);
+	register_quota_format(&v1_quota_format);
+	return 0;
 }
 
 static void __exit exit_v1_quota_format(void)
diff --git a/fs/quota/quota_v2.c b/fs/quota/quota_v2.c
index 7978ab671e0c6..d73f443292771 100644
--- a/fs/quota/quota_v2.c
+++ b/fs/quota/quota_v2.c
@@ -422,12 +422,9 @@ static struct quota_format_type v2r1_quota_format = {
 
 static int __init init_v2_quota_format(void)
 {
-	int ret;
-
-	ret = register_quota_format(&v2r0_quota_format);
-	if (ret)
-		return ret;
-	return register_quota_format(&v2r1_quota_format);
+	register_quota_format(&v2r0_quota_format);
+	register_quota_format(&v2r1_quota_format);
+	return 0;
 }
 
 static void __exit exit_v2_quota_format(void)
diff --git a/include/linux/quota.h b/include/linux/quota.h
index 07071e64abf3d..89a0d83ddad08 100644
--- a/include/linux/quota.h
+++ b/include/linux/quota.h
@@ -526,7 +526,7 @@ struct quota_info {
 	const struct quota_format_ops *ops[MAXQUOTAS];	/* Operations for each type */
 };
 
-int register_quota_format(struct quota_format_type *fmt);
+void register_quota_format(struct quota_format_type *fmt);
 void unregister_quota_format(struct quota_format_type *fmt);
 
 struct quota_module_name {
diff --git a/mm/shmem.c b/mm/shmem.c
index ecf1011cc3e29..2260def68090c 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4617,11 +4617,7 @@ void __init shmem_init(void)
 	shmem_init_inodecache();
 
 #ifdef CONFIG_TMPFS_QUOTA
-	error = register_quota_format(&shmem_quota_format);
-	if (error < 0) {
-		pr_err("Could not register quota format\n");
-		goto out3;
-	}
+	register_quota_format(&shmem_quota_format);
 #endif
 
 	error = register_filesystem(&shmem_fs_type);
@@ -4650,7 +4646,6 @@ void __init shmem_init(void)
 out2:
 #ifdef CONFIG_TMPFS_QUOTA
 	unregister_quota_format(&shmem_quota_format);
-out3:
 #endif
 	shmem_destroy_inodecache();
 	shm_mnt = ERR_PTR(error);
-- 
2.51.0


