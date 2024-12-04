Return-Path: <stable+bounces-98263-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D51A9E36BA
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 10:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52740281129
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 09:34:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F1401AF0C5;
	Wed,  4 Dec 2024 09:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QDg03ONS"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DAEF1AF0DD
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 09:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304759; cv=none; b=bQZ9KYK0AigZlFV0HPIPnLX5Lj7/GqH8+IqYf0TdZDJW0r33f8GWvW371ORSj3t9vLBsyIKQqeM4tW7iX77Toau8DsE4v8/nxZcjRvdXtYZ9tsbK7vXaiDNItpCZU0t4aRxXBASxDj9rM1CoaDnADNGctVN0cQN5aBPtbbOK7JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304759; c=relaxed/simple;
	bh=7I0dV6Tgf8J0EGs13l9tNR1YnjIiWQDcyhJBwz21JG0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqYb3YlZGdNR3bB0Voe1aZPz+Ku8o9KqipXDqf9z8+u5Ve1q+x+A7vy4ldI3dWwqhgZtAIRG5s9DP+rRTf1bF8ywUE1X6PFfqLqXcbrx90QsOzr9oOJoHZJlkWKvWZ1fl4kqbjMAnZRXn81dvOR3ZlVIoq8PkEtNaGddDnqooHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QDg03ONS; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733304757; x=1764840757;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T1WSS6imO1XhENb6Uepwf+k9ODxid9drJNDWsXOU/E8=;
  b=QDg03ONSx+p13DzmLUFAgV7LimXzysgqPCTeu8ETntzWoEGgLg53prdI
   O+NUTtcRY5GOhSX/wnkFxYH1acYr1TpOoOc30b+1OGfbdzyfuyMSNfC4D
   v0qZVAlXphAaj0A1fdfRkRFVJpH0sRhaikUlU0ezbOLuAOCrb4S72how3
   4=;
X-IronPort-AV: E=Sophos;i="6.12,207,1728950400"; 
   d="scan'208";a="150180534"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2024 09:32:35 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:56824]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.32.206:2525] with esmtp (Farcaster)
 id 943f02d8-ca6e-47c4-8bf9-0a3ae3951308; Wed, 4 Dec 2024 09:32:34 +0000 (UTC)
X-Farcaster-Flow-ID: 943f02d8-ca6e-47c4-8bf9-0a3ae3951308
Received: from EX19D019EUB001.ant.amazon.com (10.252.51.32) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 4 Dec 2024 09:32:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com (10.250.64.231) by
 EX19D019EUB001.ant.amazon.com (10.252.51.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 4 Dec 2024 09:32:34 +0000
Received: from email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.228) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Wed, 4 Dec 2024 09:32:33 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com (dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com [172.19.75.107])
	by email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com (Postfix) with ESMTP id 8CE0C404F1;
	Wed,  4 Dec 2024 09:32:33 +0000 (UTC)
Received: by dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com (Postfix, from userid 23348560)
	id 16B406F59; Wed,  4 Dec 2024 09:32:33 +0000 (UTC)
From: Jakub Acs <acsjakub@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <acsjakub@amazon.com>, <acsjakub@amazon.de>, <jack@suse.cz>,
	<stable@vger.kernel.org>
Subject: [PATCH v2 6.1] udf: Fold udf_getblk() into udf_bread()
Date: Wed, 4 Dec 2024 09:32:26 +0000
Message-ID: <20241204093226.60654-1-acsjakub@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <2024112908-stillness-alive-c9d1@gregkh>
References: <2024112908-stillness-alive-c9d1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

commit 32f123a3f34283f9c6446de87861696f0502b02e upstream.

udf_getblk() has a single call site. Fold it there.

Signed-off-by: Jan Kara <jack@suse.cz>

[acsjakub: backport-adjusting changes]
udf_getblk() has changed between 6.1 and the backported commit namely
in commit 541e047b14c8 ("udf: Use udf_map_block() in udf_getblk()")

Backport using the form of udf_getblk present in 6.1., that means use
udf_get_block() instead of udf_map_block() and use dummy in buffer_new()
and buffer_mapped().

Closes: https://syzkaller.appspot.com/bug?extid=a38e34ca637c224f4a79
Signed-off-by: Jakub Acs <acsjakub@amazon.de>
---
While doing the backport I have noticed potential side effect of the
upstream commit (present in the mainline):

If we take the if-branch of 'if (map.oflags & UDF_BLK_NEW)', we will
return the bh without the 'if (bh_read(bh, 0) >= 0)' check. Prior to
the folding, the check wouldn't be skipped, was this intentional by the
upstream commit?
---
 fs/udf/inode.c | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index d7d6ccd0af06..626450101412 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -369,29 +369,6 @@ static int udf_get_block(struct inode *inode, sector_t block,
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
 
 /* Extend the file with new blocks totaling 'new_block_bytes',
  * return the number of extents added
@@ -1108,10 +1085,29 @@ struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
 			      int create, int *err)
 {
 	struct buffer_head *bh = NULL;
+	struct buffer_head dummy;
 
-	bh = udf_getblk(inode, block, create, err);
-	if (!bh)
+	dummy.b_state = 0;
+	dummy.b_blocknr = -1000;
+
+	*err = udf_get_block(inode, block, &dummy, create);
+	if (*err || !buffer_mapped(&dummy))
+		return NULL
+
+	bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
+	if (!bh) {
+		*err = -ENOMEM;
 		return NULL;
+	}
+
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

base-commit: e4d90d63d385228b1e0bcf31cc15539bbbc28f7f
-- 
2.40.1


