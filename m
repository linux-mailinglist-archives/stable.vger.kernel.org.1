Return-Path: <stable+bounces-76018-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C96976FD7
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 19:53:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 328521F249E2
	for <lists+stable@lfdr.de>; Thu, 12 Sep 2024 17:53:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 084B21BC09F;
	Thu, 12 Sep 2024 17:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b="F38EVkWG"
X-Original-To: stable@vger.kernel.org
Received: from mx.swemel.ru (mx.swemel.ru [95.143.211.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F901B78FC
	for <stable@vger.kernel.org>; Thu, 12 Sep 2024 17:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.143.211.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726163603; cv=none; b=TTXGaZWv6WiVWJWSqq4T5SrepKG0Zg2dUxln1YZL2cTn51pivy5WDyrbNAonkY0k6ySP8L5GzTUc8lUwxlXo76TFhcX+tH4fsIUBBUvqoEVwBXS0Kfn3F6mn6+06EsfzPt/GyGwauYcyLV+QlBZmvpsSrmLAcNGi/+JfeZ7Vp5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726163603; c=relaxed/simple;
	bh=cBuSfb7CzdADziaXUGWxjqnM5/nK+MqMdWFK46ocGFs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hvPn8tkJCcMCVf0ARu+QbQms4CETYicIztKiIT/Vcrn7SJ5VW2XVSvPfSDZA74i3Hjfl/OPG520emb0uVKjvQq4iUAcZPcXr49/iSKwDA1JHAyYGRt3qjnzc6tw1bwugE8WaNJWEQbN3WfX9jsaLRH1f2e4ESjrnKt/J9nCg17M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru; spf=pass smtp.mailfrom=swemel.ru; dkim=pass (1024-bit key) header.d=swemel.ru header.i=@swemel.ru header.b=F38EVkWG; arc=none smtp.client-ip=95.143.211.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=swemel.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=swemel.ru
Date: Thu, 12 Sep 2024 20:53:04 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=swemel.ru; s=mail;
	t=1726163584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=CVeeczlAGhGV1CSjYTRiGJ0LWpqgLS9u7EDdEB4BdMk=;
	b=F38EVkWGSY4lU8VlPiCjpy1v35ooSbTmyjOg+w3VYm+AyDtMbTpm4jDT5bZ9kFgn4oG7xw
	4P+papw138fNJz6wfjvtUGEb/G8aSmp9NItxfnOtze0efD/jv7WShK9RYMpBTnJsYR5/Fw
	qvE1tooH2R6LfsBaqB92iKZ9aokdn3k=
From: Andrey Kalachev <kalachev@swemel.ru>
To: stable@vger.kernel.org
Cc: Andrey Kalachev <kalachev@swemel.ru>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	syzbot+3c339e6f719df0a7faac@syzkaller.appspotmail.com,
	lvc-project@linuxtesting.org
Subject: [PATCH 6.1] fs/ntfs3: Use kvfree to free memory allocated by kvmalloc
Message-ID: <ZuMqgLBLrL57UBOW@ural>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

Missed master:ddb17dc880ee backport cause 'kernel BUG in __phys_addr (2)' on 6.1.y.
introduced by:
6.1.y:6fe32f79abea fs/ntfs3: Use kvmalloc instead of kmalloc(... __GFP_NOWARN)

Link: https://syzkaller.appspot.com/bug?extid=3c339e6f719df0a7faac

------------------

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Date: Tue, 16 Jan 2024 10:32:20 +0300

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
index 70d9d08fc61b..8dbd8e70c295 100644
--- a/fs/ntfs3/bitmap.c
+++ b/fs/ntfs3/bitmap.c
@@ -124,7 +124,7 @@ void wnd_close(struct wnd_bitmap *wnd)
  {
  	struct rb_node *node, *next;
  
-	kfree(wnd->free_bits);
+	kvfree(wnd->free_bits);
  	run_close(&wnd->run);
  
  	node = rb_first(&wnd->start_tree);
@@ -1333,7 +1333,7 @@ int wnd_extend(struct wnd_bitmap *wnd, size_t new_bits)
  		memcpy(new_free, wnd->free_bits, wnd->nwnd * sizeof(short));
  		memset(new_free + wnd->nwnd, 0,
  		       (new_wnd - wnd->nwnd) * sizeof(short));
-		kfree(wnd->free_bits);
+		kvfree(wnd->free_bits);
  		wnd->free_bits = new_free;
  	}
  
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index 6cce71cc750e..b460d1da9440 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -773,7 +773,7 @@ static int ni_try_remove_attr_list(struct ntfs_inode *ni)
  	run_deallocate(sbi, &ni->attr_list.run, true);
  	run_close(&ni->attr_list.run);
  	ni->attr_list.size = 0;
-	kfree(ni->attr_list.le);
+	kvfree(ni->attr_list.le);
  	ni->attr_list.le = NULL;
  	ni->attr_list.dirty = false;
  
@@ -924,7 +924,7 @@ int ni_create_attr_list(struct ntfs_inode *ni)
  	goto out;
  
  out1:
-	kfree(ni->attr_list.le);
+	kvfree(ni->attr_list.le);
  	ni->attr_list.le = NULL;
  	ni->attr_list.size = 0;
  	return err;
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 667ff92f5afc..eee54214f4a3 100644
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

To: 
Cc: 
Bcc: 
Subject: 
Reply-To: 


