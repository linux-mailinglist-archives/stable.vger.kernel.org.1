Return-Path: <stable+bounces-254711-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBfHIhu2F2pvOAgAu9opvQ
	(envelope-from <stable+bounces-254711-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 05:27:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05B4A5EC333
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 05:27:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 025DC30262F7
	for <lists+stable@lfdr.de>; Thu, 28 May 2026 03:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553192F49FD;
	Thu, 28 May 2026 03:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b="PaaqCB9N"
X-Original-To: stable@vger.kernel.org
Received: from n169-110.mail.139.com (n169-110.mail.139.com [120.232.169.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994661AAE17;
	Thu, 28 May 2026 03:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=120.232.169.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779938624; cv=none; b=Zw/c++MHYIkzIAihN+wXrCbCnuLZA1zA5GzbK/9CZIcDaZtBCSOzNvoza21fCCAmEqwZW5IpSLNCFb1ooaT+kN0S5ofsSPXjNx8FBfWJRAZ/H21irQ4t9rXILSjb3H4Ekv2HY0T1M+K36ucKNmjeVPS3EiuJBdEAvgaY4jLzsw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779938624; c=relaxed/simple;
	bh=dwG2OU9Ik+Kuq9Tfm/ROlnq0ncqNVDB4KwhEpOJzlJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BRyyCZQ9ZkJ0ueEMGHMkJTbnMJ612jz6fkqJ3BGgq4ena8wXEDGsJE2YZEIB80oVmuFtJrV8TOZwLYfXbOmZF0XCtfRiBp/kdGOjt9jpqNstVz9H/JYalRW4E0D3otPvSUYrkyBmLg1DGi8wKUdH6IdgDJ8EvVp1yzVZGA60AVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com; spf=pass smtp.mailfrom=139.com; dkim=pass (1024-bit key) header.d=139.com header.i=@139.com header.b=PaaqCB9N; arc=none smtp.client-ip=120.232.169.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=139.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=139.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=139.com; s=dkim; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=PaaqCB9NnRljddtSPISjqfkRuhM5v4SiW3KnA1YW9t/Ar5GJwxsVzo581Emd8tHFpzmTK+4w6HFj5
	 uUgtH1LN+xcZ6ajKAWP0SQirWJ/NTrK2j3cxD8HYioBu9FhbghYss8dva9FozE1Cmz95SnPuJ2QJzI
	 oSxdS42I758/54lM=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM:                                                                                        
X-RM-SPAM-FLAG:00000000
Received:from China-139-kernel-team (unknown[47.95.114.252])
	by rmsmtp-lg-appmail-09-12087 (RichMail) with SMTP id 2f376a17b53104c-080e9;
	Thu, 28 May 2026 11:23:33 +0800 (CST)
X-RM-TRANSID:2f376a17b53104c-080e9
From: Bin Lan <lanbincn@139.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Bin Lan <lanbincn@139.com>
Subject: [PATCH 6.12.y] fs/ntfs3: handle attr_set_size() errors when truncating files
Date: Thu, 28 May 2026 11:23:27 +0800
Message-ID: <20260528032327.58596-1-lanbincn@139.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_REJECT(1.00)[139.com:s=dkim];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254711-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[139.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[139.com];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,paragon-software.com,139.com];
	DKIM_TRACE(0.00)[139.com:-];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[lanbincn@139.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.474];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[paragon-software.com:email,139.com:mid,139.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 05B4A5EC333
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 576248a34b927e93b2fd3fff7df735ba73ad7d01 ]

If attr_set_size() fails while truncating down, the error is silently
ignored and the inode may be left in an inconsistent state.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
[ Minor context conflict resolved. ]
Signed-off-by: Bin Lan <lanbincn@139.com>
---
 fs/ntfs3/file.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 3f144a049d71..b7d87fd57063 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -500,8 +500,8 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 {
 	struct super_block *sb = inode->i_sb;
 	struct ntfs_inode *ni = ntfs_i(inode);
-	int err, dirty = 0;
 	u64 new_valid;
+	int err;
 
 	if (!S_ISREG(inode->i_mode))
 		return 0;
@@ -517,7 +517,6 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 	}
 
 	new_valid = ntfs_up_block(sb, min_t(u64, ni->i_valid, new_size));
-
 	truncate_setsize(inode, new_size);
 
 	ni_lock(ni);
@@ -531,22 +530,19 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 		ni->i_valid = new_valid;
 
 	ni_unlock(ni);
+	if (unlikely(err))
+		return err;
 
 	ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
 	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	if (!IS_DIRSYNC(inode)) {
-		dirty = 1;
+		mark_inode_dirty(inode);
 	} else {
 		err = ntfs_sync_inode(inode);
 		if (err)
 			return err;
 	}
 
-	if (dirty)
-		mark_inode_dirty(inode);
-
-	/*ntfs_flush_inodes(inode->i_sb, inode, NULL);*/
-
 	return 0;
 }
 
-- 
2.43.0



