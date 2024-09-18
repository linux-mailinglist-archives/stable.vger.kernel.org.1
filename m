Return-Path: <stable+bounces-76717-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B6F897C09F
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 21:49:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42368283160
	for <lists+stable@lfdr.de>; Wed, 18 Sep 2024 19:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7033C1CA684;
	Wed, 18 Sep 2024 19:49:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282BA1C68AB;
	Wed, 18 Sep 2024 19:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726688958; cv=none; b=AeoZ1gzEZ1QMNleJFY5JPP17fyOAIkg7qywBxxOj5z7sINgtEeIIcNPsMxeiAFcgw1EZdl/ZcLsPD95ljw43ZZ8n366c9rPqKaVpJyY2hX/2J7QdEylZ2OzhWyddfWH48tbnxJog2Tr/XfwwqpqDvagfEPPLfP/e4ssBMjOi77g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726688958; c=relaxed/simple;
	bh=WExMYyNGt9y9Ex94lL0h//oJecQB+e8gT88UZyGJPe8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:Content-Type; b=eaEA3zfi4r6hZIW6hP5ffs3GVDH5AVy+CMmAZi6uZo/J/l7J0ekw+9SD3C6U9OqziLUobvGAa+ifXkyXr3MJKvbUSzUnYPyt48jVWA02M0GuPoa3fP9R75NE+5Y2IhXd4YlLQm+sO3JLj93qgKEFfKG3ord8LFow5WoGQALPQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from [192.168.1.109] (31.173.87.200) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 18 Sep
 2024 22:49:10 +0300
Message-ID: <62f7666d-0a66-9ba5-61fd-a998e4169867@omp.ru>
Date: Wed, 18 Sep 2024 22:49:09 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
From: Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH 5.10.y] udf: Fold udf_getblk() into udf_bread()
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
X-KSE-AntiSpam-Version: 6.1.1, Database issued on: 09/18/2024 19:34:26
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 187837 [Sep 18 2024]
X-KSE-AntiSpam-Info: Version: 6.1.1.5
X-KSE-AntiSpam-Info: Envelope from: s.shtylyov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 34 0.3.34
 8a1fac695d5606478feba790382a59668a4f0039
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: ApMailHostAddress: 31.173.87.200
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 09/18/2024 19:37:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 9/18/2024 4:23:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

From: Jan Kara <jack@suse.cz>

udf_getblk() has a single call site. Fold it there.

[Sergey: moved back to using udf_get_block() and buffer_{mapped|new}().]

Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
This patch prevents NULL pointer dereference in case sb_getblk() fails...

 fs/udf/inode.c |   45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

Index: linux-stable/fs/udf/inode.c
===================================================================
--- linux-stable.orig/fs/udf/inode.c
+++ linux-stable/fs/udf/inode.c
@@ -458,30 +458,6 @@ abort:
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
@@ -1197,10 +1173,27 @@ struct buffer_head *udf_bread(struct ino
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
 
 	if (buffer_uptodate(bh))
 		return bh;

