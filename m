Return-Path: <stable+bounces-98765-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE259E5153
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 10:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8409163F4A
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 09:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2BA1D61A3;
	Thu,  5 Dec 2024 09:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AU++2agQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280771D5CC5
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733390976; cv=none; b=Mu/owUf+1FFCAJN+33/4UGq4N0ctPMnHQoeiB6w/Isz+86A5rEQiGJbg6rfR1/HVEeBcSE+PdPDNe5VYaMSnK6fX65OXOxE8KiCQxgTRP/KcUDXwjlK67bpClfuiRSlUGROsU4I70hC/C6i5ieNzrR5jiKrZIs1vMeWvmNlRF6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733390976; c=relaxed/simple;
	bh=QxIFO+JsFg5tGSWaoeAZmfMuYYIfEIqTSWqYLk3lglM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KtESYEzK84jDxXjMF4Acb51BEg934tJ0v2rgspzaVNMKS55HPEJ/MAnivGpzHudcOTIgDmjUTjWif1hmvjUCTu0crIzGrcr8dyj9dhS6zKzPnbTn84x7sg3dLJpo6tgcvrubhP2zp30O+4jxz9qVmKiEeW+7nz5w3+kL/Mw44as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=AU++2agQ; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733390975; x=1764926975;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T0zbCwwwOHvNczgWlm9juZW4OhZBr/8be979Bq6ADPE=;
  b=AU++2agQPwjUrLgoYjcuKnDruWugF20VE8As5W7E6IkFccrvmjjoiAV3
   Tie3H61mGeL5799IOzrDoTPLJ+fbN8sAUngWMHT6x3OQP4tmVykpNK/9/
   Ohb6AwLutzSA3gTeyxbRC3QNivgQT8uF30LyulzOOLDpBqkIbYIZSNYgf
   Y=;
X-IronPort-AV: E=Sophos;i="6.12,209,1728950400"; 
   d="scan'208";a="46881805"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2024 09:29:31 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:60223]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.62:2525] with esmtp (Farcaster)
 id b8071f41-1dfb-4758-8bf1-82129f697276; Thu, 5 Dec 2024 09:29:30 +0000 (UTC)
X-Farcaster-Flow-ID: b8071f41-1dfb-4758-8bf1-82129f697276
Received: from EX19D019EUB002.ant.amazon.com (10.252.51.33) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Dec 2024 09:29:28 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D019EUB002.ant.amazon.com (10.252.51.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Dec 2024 09:29:27 +0000
Received: from email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Thu, 5 Dec 2024 09:29:27 +0000
Received: from dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com (dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com [172.19.75.107])
	by email-imr-corp-prod-pdx-all-2b-5ec155c2.us-west-2.amazon.com (Postfix) with ESMTP id 7AAA740210;
	Thu,  5 Dec 2024 09:29:27 +0000 (UTC)
Received: by dev-dsk-acsjakub-1b-6f9934e2.eu-west-1.amazon.com (Postfix, from userid 23348560)
	id 13EA078A0; Thu,  5 Dec 2024 09:29:27 +0000 (UTC)
From: Jakub Acs <acsjakub@amazon.com>
To: <gregkh@linuxfoundation.org>
CC: <acsjakub@amazon.com>, <acsjakub@amazon.de>, <jack@suse.cz>,
	<stable@vger.kernel.org>
Subject: [PATCH v3 6.1] udf: Fold udf_getblk() into udf_bread()
Date: Thu, 5 Dec 2024 09:29:25 +0000
Message-ID: <20241205092925.43310-1-acsjakub@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241204065657-de0ff92045247001@stable.kernel.org>
References: <20241204065657-de0ff92045247001@stable.kernel.org>
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
udf_getblk() has changed between 6.1 and the backported commit, namely
in commit 541e047b14c8 ("udf: Use udf_map_block() in udf_getblk()")

Backport using the form of udf_getblk present in 6.1., that means use
udf_get_block() instead of udf_map_block() and use dummy in buffer_new()
and buffer_mapped().

Closes: https://syzkaller.appspot.com/bug?extid=a38e34ca637c224f4a79
Signed-off-by: Jakub Acs <acsjakub@amazon.de>
---
v3: fix the missing ';', sorry about that

 fs/udf/inode.c | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index d7d6ccd0af06..e2ac428f3809 100644
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
@@ -1108,11 +1085,30 @@ struct buffer_head *udf_bread(struct inode *inode, udf_pblk_t block,
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
 		return NULL;
 
+	bh = sb_getblk(inode->i_sb, dummy.b_blocknr);
+	if (!bh) {
+		*err = -ENOMEM;
+		return NULL;
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
+
 	if (bh_read(bh, 0) >= 0)
 		return bh;
 

base-commit: e4d90d63d385228b1e0bcf31cc15539bbbc28f7f
-- 
2.40.1


