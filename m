Return-Path: <stable+bounces-76777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ABD97CE3F
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 21:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE14A284FF3
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 19:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E6677119;
	Thu, 19 Sep 2024 19:50:59 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E3B524B4;
	Thu, 19 Sep 2024 19:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726775459; cv=none; b=fOYYp336/UBw4ZGd8mQZn/wEuUcaAmubLqlhfqorOh0JTZ+hdWyWbHdSOh+06w+LBammuTr4wVdLNIYODaRhfKy+O3C71cAkQ8bUeXcqSSE8Klwp+05OV07wHbqdxrMbxS3V+8zJWgTBB7wypMwxgqnPV3bs62m4Na8dM4JXb9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726775459; c=relaxed/simple;
	bh=vzZiWjqkbum8uw7vhizL/BKTOXunpeeofOueZU+7x8I=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=Jm5UOvnt1ugAxYbzs0f/y3fBbH8Ob5HZ2bfGy8LY8F9slkuFo6fn/9gMK0VEd1JYlF4OecpTMhoZdgGhKaZqYSZLyuRXfBX41Mpsv1nIDxUVfbfa4jEAQcKzc5LiIllRTL2zpMvLozppGz2zKjqgWTlVUyvepMENm06iL9H8de0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.111] (31.173.81.63) by msexch01.omp.ru (10.188.4.12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 19 Sep
 2024 22:50:42 +0300
Message-ID: <3cafe5c0-c00e-b9ef-24ff-2809e3fd36c1@omp.ru>
Date: Thu, 19 Sep 2024 22:50:42 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2 6.1.y] udf: Fold udf_getblk() into udf_bread()
To: Jan Kara <jack@suse.cz>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
CC: <lvc-project@linuxtesting.org>
Content-Language: en-US
Organization: Open Mobile Platform
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/19/2024 19:39:25
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 59
X-KSE-AntiSpam-Info: Lua profiles 187870 [Sep 19 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {relay has no DNS name}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.63 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info: {Found in DNSBL: 31.173.81.63 in (user) dbl.spamhaus.org}
X-KSE-AntiSpam-Info:
	127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.81.63
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 59
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/19/2024 19:43:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/19/2024 3:09:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 32f123a3f34283f9c6446de87861696f0502b02e ]

udf_getblk() has a single call site. Fold it there.

[Sergey: moved back to using udf_get_block() and buffer_{mapped|new}().]

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch prevents NULL pointer dereference in case sb_getblk() fails...

Changes in version 2:
- mentioned the original commit.

 fs/udf/inode.c |   45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

Index: linux-stable/fs/udf/inode.c
===================================================================
--- linux-stable.orig/fs/udf/inode.c
+++ linux-stable/fs/udf/inode.c
@@ -459,30 +459,6 @@ abort:
 	return err;
 }
 
-static struct buffer_head *udf_getblk(struct inode *inode, udf_pblk_t block,
-				      int create, int *err)
-{
-	struct buffer_head *bh;
-	struct buffer_head dummy;
-
-	dummy.b_state = 0;
-	dummy.b_blocknr = -1000;
-	*err = udf_get_block(inode, block, &dummy, create);
-	if (!*err && buffer_mapped(&dummy)) {
-		bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
-		if (buffer_new(&dummy)) {
-			lock_buffer(bh);
-			memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
-			set_buffer_uptodate(bh);
-			unlock_buffer(bh);
-			mark_buffer_dirty_inode(bh, inode);
-		}
-		return bh;
-	}
-
-	return NULL;
-}
-
 /* Extend the file with new blocks totaling 'new_block_bytes',
  * return the number of extents added
  */
@@ -1198,10 +1174,27 @@ struct buffer_head *udf_bread(struct ino
 			      int create, int *err)
 {
 	struct buffer_head *bh = NULL;
+	struct buffer_head dummy;
+
+	dummy.b_state = 0;
+	dummy.b_blocknr = -1000;
+	*err = udf_get_block(inode, block, &dummy, create);
+	if (*err || !buffer_mapped(&dummy))
+		return NULL;
 
-	bh = udf_getblk(inode, block, create, err);
-	if (!bh)
+	bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
+	if (!bh) {
+		*err = -ENOMEM;
 		return NULL;
+	}
+	if (buffer_new(&dummy)) {
+		lock_buffer(bh);
+		memset(bh->b_data, 0x00, inode->i_sb->s_blocksize);
+		set_buffer_uptodate(bh);
+		unlock_buffer(bh);
+		mark_buffer_dirty_inode(bh, inode);
+		return bh;
+	}
 
 	if (bh_read(bh, 0) >= 0)
 		return bh;

