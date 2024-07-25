Return-Path: <stable+bounces-61378-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 778D393C0A3
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 13:21:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27A091F2208A
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 11:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC31198E81;
	Thu, 25 Jul 2024 11:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMV52EGV"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134F176224
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906457; cv=none; b=NY10l47jel4o8ZgOY+F5dgwVd7LUr++hAHxzdNJzz5OICVOsWRG43SKg8Bhz8/SvphAg601fdTBfCYKyhGefMaI62lUkbrPPVxmZYWUqC3gLX8iSjUO+knO5UoG1I7YT9/9zYsK+C0iQkSQGPIuQnBgVL5Sd4CUxyJxCsPXO2cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906457; c=relaxed/simple;
	bh=4pLSKsSIlFe0Boofv8OmOs+lznm8wsBMDVlE8ew8Ag0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=f2o/XVlATu7iBG+3YuCdXyZBHN9Kk7CvUWFqH/IShVYuE5FTuYGLvPOwTAYsd2UfphNhec9JWqn3DY6zWl1uy42tf/9Gn55izEfRbBVhQHg9Z4/tSXooHdxfzrdoG+FeEKg/FHDnUyS5TAhpkvD/3EPLFtLNcUw+J66aalCC9HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMV52EGV; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-369f68f63b1so461482f8f.2
        for <stable@vger.kernel.org>; Thu, 25 Jul 2024 04:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721906454; x=1722511254; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5co6LslmYIo4HQfh6P0CfIggT1PGKK0tJqwvRnY71Ik=;
        b=GMV52EGVmrbbzcxSekqI8t1cYHTUmBgrC2JJpMuvtNjL6iUFlUwDFPs22cepPPBlVZ
         IOsfC5EQh9nqjv8Z+iPHCzsVHQd7lGRqvCaMDQN4v7NPt6juov2csAXSAqG7WqgNZAsB
         Kpp0C3mrECQf2uShadoykLlht1LARalzRZht/QUf/0sCMSBoYHyJQUTvG2x3rcu1w+Nk
         sx7O8Nj3NyVGMRIC+DQi3VrorUi0aEdfgn2IHoYkoNcr585wLdlVajPEZjkl3xLXg1aC
         cTR3pJaY9iJhgom60YEPsvzM7rNYHE1kt3uHKiwGBnoyzv6Q9mnEhaDIV3q41KOQ1mJA
         OLmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721906454; x=1722511254;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5co6LslmYIo4HQfh6P0CfIggT1PGKK0tJqwvRnY71Ik=;
        b=j6RkqHSn1x33pXezS+afjD9tqAhOovmg00/oPRYFnNgIq1EZ7iWjvrubxZPFb5Sfxp
         hE+MjJapTOKuZr3uzG0vg1UXFxDj6CmKfFRZaHVBPqNyzrzTg/0YtaVX6eZR9PcrUl4E
         lg7FB7oqPbxoQbo2m4HIyTfwHmmOJHiKfete1acB+tZx48JR2XjeJpe1WXW3kUBixtJ/
         gYKcCO7fxrJOU5V14PrYI+zG/h0jv7DMW1Squmqhk3LtLw8W+IXV4ofIEVe1d0eZdYOs
         KPro11yXQmEkHGxeF02pnL4rckUXNFdtilQKGvCJZSH1lb6IF6kIkaP/AGksuQTGttBs
         +ELw==
X-Gm-Message-State: AOJu0Yz/sneXs5ZmeiIp3Hi1m44CedmaczcBRIyniYTmOXoWke/R3lms
	SiPad6r1KuBbBiUaxslNl+rYKyaDXgtCcIfQggDlJJclQEqmmVCU5X6eYZ6H
X-Google-Smtp-Source: AGHT+IGcxg8RUbMwA0gj9w3ZyO5OTBoq5GmbMpklGggcrtVih0Fx9xSEVTyhCo9zI35eIFDwd5yQqw==
X-Received: by 2002:a5d:63c1:0:b0:368:77f9:fb34 with SMTP id ffacd0b85a97d-36b363894d7mr1220005f8f.15.1721906453714;
        Thu, 25 Jul 2024 04:20:53 -0700 (PDT)
Received: from laptop.home (83.50.134.37.dynamic.jazztel.es. [37.134.50.83])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367fcb78sm1824738f8f.53.2024.07.25.04.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 04:20:53 -0700 (PDT)
From: =?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>
To: stable@vger.kernel.org
Cc: linux-kernel-mentees@lists.linuxfoundation.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	=?UTF-8?q?Sergio=20Gonz=C3=A1lez=20Collado?= <sergio.collado@gmail.com>,
	syzbot+d0ab8746c920a592aeab@syzkaller.appspotmail.com
Subject: [PATCH 6.1.y] f2fs: avoid dead loop in f2fs_issue_checkpoint()
Date: Thu, 25 Jul 2024 13:19:33 +0200
Message-Id: <20240725111933.77493-1-sergio.collado@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 5079e1c0c879311668b77075de3e701869804adf ]

generic/082 reports a bug as below:

__schedule+0x332/0xf60
schedule+0x6f/0xf0
schedule_timeout+0x23b/0x2a0
wait_for_completion+0x8f/0x140
f2fs_issue_checkpoint+0xfe/0x1b0
f2fs_sync_fs+0x9d/0xb0
sync_filesystem+0x87/0xb0
dquot_load_quota_sb+0x41b/0x460
dquot_load_quota_inode+0xa5/0x130
dquot_quota_on+0x4b/0x60
f2fs_quota_on+0xe3/0x1b0
do_quotactl+0x483/0x700
__x64_sys_quotactl+0x15c/0x310
do_syscall_64+0x3f/0x90
entry_SYSCALL_64_after_hwframe+0x72/0xdc

The root casue is race case as below:

Thread A			Kworker			IRQ
- write()
: write data to quota.user file

				- writepages
				 - f2fs_submit_page_write
				  - __is_cp_guaranteed return false
				  - inc_page_count(F2FS_WB_DATA)
				 - submit_bio
- quotactl(Q_QUOTAON)
 - f2fs_quota_on
  - dquot_quota_on
   - dquot_load_quota_inode
    - vfs_setup_quota_inode
    : inode->i_flags |= S_NOQUOTA
							- f2fs_write_end_io
							 - __is_cp_guaranteed return true
							 - dec_page_count(F2FS_WB_CP_DATA)
    - dquot_load_quota_sb
     - f2fs_sync_fs
      - f2fs_issue_checkpoint
       - do_checkpoint
        - f2fs_wait_on_all_pages(F2FS_WB_CP_DATA)
        : loop due to F2FS_WB_CP_DATA count is negative

Calling filemap_fdatawrite() and filemap_fdatawait() to keep all data
clean before quota file setup.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
(cherry picked from commit 5079e1c0c879311668b77075de3e701869804adf)
Signed-off-by: Sergio González Collado <sergio.collado@gmail.com>
Reported-by: syzbot+d0ab8746c920a592aeab@syzkaller.appspotmail.com
---
 fs/f2fs/super.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6bd8c231069a..2d586a6bfe5f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2824,15 +2824,26 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 		return -EBUSY;
 	}
 
+	if (path->dentry->d_sb != sb)
+		return -EXDEV;
+
 	err = f2fs_quota_sync(sb, type);
 	if (err)
 		return err;
 
-	err = dquot_quota_on(sb, type, format_id, path);
+	inode = d_inode(path->dentry);
+
+	err = filemap_fdatawrite(inode->i_mapping);
 	if (err)
 		return err;
 
-	inode = d_inode(path->dentry);
+	err = filemap_fdatawait(inode->i_mapping);
+	if (err)
+		return err;
+
+	err = dquot_quota_on(sb, type, format_id, path);
+	if (err)
+		return err;
 
 	inode_lock(inode);
 	F2FS_I(inode)->i_flags |= F2FS_NOATIME_FL | F2FS_IMMUTABLE_FL;
-- 
2.39.2


