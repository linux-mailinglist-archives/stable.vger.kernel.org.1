Return-Path: <stable+bounces-76016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE319976FAE
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 19:39:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 351EAB2436E
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 17:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85963189526;
	Thu, 12 Sep 2024 17:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="TtZuFbrw"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE21891B2
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726162744; cv=none; b=TXjFFnxhO25wqn0a5LoOr1Fx5N8r8leFKVjg4dM+M1GBoirXwGkDOZ2GD+tEZ4KWwws8/tyEjMCmLhMC6axW51JcNkD2UGIpB8+sJjWDcUTmT3JTwRR+m1TKb1B9186f8W2P0ATvV+WZzn65+QvxwCIYR7YsnxDhXXEMyolHHBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726162744; c=relaxed/simple;
	bh=SL6LoCCsrKN1+QtPkn4K2eW+GAZt9Kbb5dKGbhU8+KU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SbUrKwOaSIvAOx5IJVJYMd33tvgEGEOG29Ft7B15Buhwc6kKj7W1UIqV+oVduO+JrMZGQsQwDGIfo5mYpCs9sTolrdRG3V+w88Wjpz9FQbwDIDQtA9TEmMB+r7PmpNBtN/yImoabCMsrVA6wma5cHZ/sVNTTD8Gx572mjy1Leys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=TtZuFbrw; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Date: Thu, 12 Sep 2024 20:38:49 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1726162729;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=GAIRDUyfwKNKgR4eIVr3eAMC+0mox5nYqP3E87WvlDs=;
	b=TtZuFbrwV+Nvs3vUXOagHeBGDnaaLmFpwptUZ7aSkJwNN9lQ7QK5DC7qQf6HL+yeea4l1R
	GAF56+JARD2pDaEpaaeyqRcJGvno6tKZdiqCQ7siHit6/uiS3wlDr2lnZNcJCSnNommUfz
	Ex9lAzde00g6hV9PEkg+991e0PrdQTk=
From: Andrey Kalachev <kalachev@swemel.ru>
To: stable@vger.kernel.org
Cc: Andrey Kalachev <kalachev@swemel.ru>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+2c00ffdada0b04c96497@syzkaller.appspotmail.com,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.15] fs/ntfs3: Use kvfree to free memory allocated by
 kvmalloc
Message-ID: <ZuMnKVYqwoNVhTmB@ural>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Missed master:ddb17dc880ee backport cause 'kernel BUG in __phys_addr' on 5.15.y.
introduced by:
5.15.y:962a3d3d731c (fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN))

Link: https://syzkaller.appspot.com/bug?extid=2c00ffdada0b04c96497

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date: Tue, 16 Jan 2024 10:32:20 +0300
Subject: [PATCH] fs/ntfs3: Use kvfree to free memory allocated by kvmalloc

[ Upstream commit ddb17dc880eeaac37b5a6e984de07b882de7d78d ]

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Signed-off-by: Andrey Kalachev <kalachev@swemel.ru>
---
  fs/ntfs3/attrlist.c | 4 ++--
  fs/ntfs3/bitmap.c   | 4 ++--
  fs/ntfs3/frecord.c  | 4 ++--
  fs/ntfs3/super.c    | 2 +-
  4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ntfs3/attrlist.c b/fs/ntfs3/attrlist.c
index 723e49ec83ce..82bd9b5d9bd8 100644
--- a/fs/ntfs3/attrlist.c
+++ b/fs/ntfs3/attrlist.c
@@ -29,7 +29,7 @@ static inline bool al_is_valid_le(const struct ntfs_inode *ni,
  void al_destroy(struct ntfs_inode *ni)
  {
  	run_close(&ni->attr_list.run);
-	kfree(ni->attr_list.le);
+	kvfree(ni->attr_list.le);
  	ni->attr_list.le = NULL;
  	ni->attr_list.size = 0;
  	ni->attr_list.dirty = false;
@@ -318,7 +318,7 @@ int al_add_le(struct ntfs_inode *ni, enum ATTR_TYPE type, const __le16 *name,
  		memcpy(ptr, al->le, off);
  		memcpy(Add2Ptr(ptr, off + sz), le, old_size - off);
  		le = Add2Ptr(ptr, off);
-		kfree(al->le);
+		kvfree(al->le);
  		al->le = ptr;
  	} else {
  		memmove(Add2Ptr(le, sz), le, old_size - off);
diff --git a/fs/ntfs3/bitmap.c b/fs/ntfs3/bitmap.c
index 7dccff6c9983..2c29a3b386ba 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -129,7 +129,7 @@ void wnd_close(struct wnd_bitmap *wnd)
  {
  	struct rb_node *node, *next;
  
-	kfree(wnd->free_bits);
+	kvfree(wnd->free_bits);
  	run_close(&wnd->run);
  
  	node = rb_first(&wnd->start_tree);
@@ -1340,7 +1340,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
  			       wnd->nwnd * sizeof(short));
  		memset(new_free + wnd->nwnd, 0,
  		       (new_wnd - wnd->nwnd) * sizeof(short));
-		kfree(wnd->free_bits);
+		kvfree(wnd->free_bits);
  		wnd->free_bits = new_free;
  	}
  
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index da21a044d3f8..7a1f57dc58df 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -750,7 +750,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
  	run_deallocate(sbi, &ni->attr_list.run, true);
  	run_close(&ni->attr_list.run);
  	ni->attr_list.size = 0;
-	kfree(ni->attr_list.le);
+	kvfree(ni->attr_list.le);
  	ni->attr_list.le = NULL;
  	ni->attr_list.dirty = false;
  
@@ -899,7 +899,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
  	goto out;
  
  out1:
-	kfree(ni->attr_list.le);
+	kvfree(ni->attr_list.le);
  	ni->attr_list.le = NULL;
  	ni->attr_list.size = 0;
  	return err;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 2ce26062e55e..78b086527331 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -441,7 +441,7 @@ static noinline void put_ntfs(struct ntfs_sb_info *sbi)
  {
  	kfree(sbi->new_rec);
  	kvfree(ntfs_put_shared(sbi->upcase));
-	kfree(sbi->def_table);
+	kvfree(sbi->def_table);
  
  	wnd_close(&sbi->mft.bitmap);
  	wnd_close(&sbi->used.bitmap);
-- 
2.30.2


