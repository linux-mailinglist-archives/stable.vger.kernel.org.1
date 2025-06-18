Return-Path: <stable+bounces-154653-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C610CADEAAB
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 13:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D5E83B520B
	for <lists+stable@lfdr.de>; Wed, 18 Jun 2025 11:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06EB276059;
	Wed, 18 Jun 2025 11:45:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB022F5323;
	Wed, 18 Jun 2025 11:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750247151; cv=none; b=eHNr88SSAIb1TtbBqYSvphYZVP8koRvGhIzazDLKEc1jHJjjYNhiqv9FYzQcNbA7aDrVwV1zZ8v2hjwnCc4wgsD8HI0p+u1+UWBt7GLt/FVc1DQv/iG/jVJ4cVwisLo2FuHhYgYTDri6vZ05rpx5TLYOhBm2cZxQ4K78mA+qOZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750247151; c=relaxed/simple;
	bh=WYJ16Alk09q6fIdfKWEBzJa6GAWM1uSoSPLuY7xDDcI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=q1GN5sUk+K6xivIRVbIyfMvHLBxRv6o/YhcdnDNiCkbeETFpzYtEWg+4uU1dQTJ8OlcYpxl1nNTbh2UBebwLnb6TSQgjxlXcBT1mndFYY0tJX1Bq7XlSl/g6gUoYlUISLPAE33MAbu6agdm1jNoMgURYbwf5EIlmoti7xQiRD+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (188.234.0.8) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 18 Jun
 2025 14:45:30 +0300
From: d.privalov <d.privalov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg
	<johan.hedberg@gmail.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, <linux-bluetooth@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>, Miklos Szeredi <mszeredi@redhat.com>, Dmitriy
 Privalov <d.privalov@omp.ru>
Subject: [PATCH 5.10/5.15 1/1] fuse: don't increment nlink in link()
Date: Wed, 18 Jun 2025 14:44:09 +0300
Message-ID: <20250618114409.179601-1-d.privalov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 06/18/2025 11:27:56
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 194137 [Jun 18 2025]
X-KSE-AntiSpam-Info: Version: 6.1.1.11
X-KSE-AntiSpam-Info: Envelope from: d.privalov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 62 0.3.62
 e2af3448995f5f8a7fe71abf21bb23519d0f38c3
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: {Tracking_ip_hunter}
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 188.234.0.8
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 06/18/2025 11:29:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 6/18/2025 9:13:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: Miklos Szeredi <mszeredi@redhat.com>

commit 97f044f690bac2b094bfb7fb2d177ef946c85880 upstream.

The fuse_iget() call in create_new_entry() already updated the inode with
all the new attributes and incremented the attribute version.

Incrementing the nlink will result in the wrong count.  This wasn't noticed
because the attributes were invalidated right after this.

Updating ctime is still needed for the writeback case when the ctime is not
refreshed.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Dmitriy Privalov <d.privalov@omp.ru>
---
 fs/fuse/dir.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4488a53a192d..7055fdc1b8ce 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -807,7 +807,7 @@ void fuse_flush_time_update(struct inode *inode)
 	mapping_set_error(inode->i_mapping, err);
 }
 
-void fuse_update_ctime(struct inode *inode)
+static void fuse_update_ctime_in_cache(struct inode *inode)
 {
 	if (!IS_NOCMTIME(inode)) {
 		inode->i_ctime = current_time(inode);
@@ -816,6 +816,12 @@ void fuse_update_ctime(struct inode *inode)
 	}
 }
 
+void fuse_update_ctime(struct inode *inode)
+{
+	fuse_invalidate_attr(inode);
+	fuse_update_ctime_in_cache(inode);
+}
+
 static int fuse_unlink(struct inode *dir, struct dentry *entry)
 {
 	int err;
@@ -986,25 +992,10 @@ static int fuse_link(struct dentry *entry, struct inode *newdir,
 	args.in_args[1].size = newent->d_name.len + 1;
 	args.in_args[1].value = newent->d_name.name;
 	err = create_new_entry(fm, &args, newdir, newent, inode->i_mode);
-	/* Contrary to "normal" filesystems it can happen that link
-	   makes two "logical" inodes point to the same "physical"
-	   inode.  We invalidate the attributes of the old one, so it
-	   will reflect changes in the backing inode (link count,
-	   etc.)
-	*/
-	if (!err) {
-		struct fuse_inode *fi = get_fuse_inode(inode);
-
-		spin_lock(&fi->lock);
-		fi->attr_version = atomic64_inc_return(&fm->fc->attr_version);
-		if (likely(inode->i_nlink < UINT_MAX))
-			inc_nlink(inode);
-		spin_unlock(&fi->lock);
-		fuse_invalidate_attr(inode);
-		fuse_update_ctime(inode);
-	} else if (err == -EINTR) {
+	if (!err)
+		fuse_update_ctime_in_cache(inode);
+	else if (err == -EINTR)
 		fuse_invalidate_attr(inode);
-	}
 	return err;
 }
 
-- 
2.34.1


