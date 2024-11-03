Return-Path: <stable+bounces-89589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BF8D9BA7AF
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 20:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D91221F21995
	for <lists+stable@lfdr.de>; Sun,  3 Nov 2024 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C1218870F;
	Sun,  3 Nov 2024 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DYZAjIRC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AB3136358;
	Sun,  3 Nov 2024 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730662733; cv=none; b=onDwd/ubrAttPP4uL5l0uscHeq+NTPglT4AO0TeL7LMaZbEqIuNkYr2PcOWRj2ZwYsLHbWuxkNraAefX0l+NtvHJGVRrpA2cJylGddb9ndNdcJ0ozuhdutwIw8R3/pcCTNPqrTGKr397wHyJxUpDrJ0xXl2kceEd2uAdOwNpYFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730662733; c=relaxed/simple;
	bh=sM9GzluozgQPIg5Vs5SoQTDViRP22kkDSOQI1XA113Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pChAouJkA/+E6K9fzrkvASYDNRxM6in5PyWcif0K9FdJy+3gIUzZNkqdLwCT/s9K8gLmlUh4khNlXSSfGgovLqQyiDuY7Inmh4sxCdVXvYv2wXzcsZOYJc4h9bU9jbxm/AbmmR/SEhCMOMNgTq5TgOanyXIX9HNSdc1WGWDBddo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DYZAjIRC; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-431ac30d379so28913035e9.1;
        Sun, 03 Nov 2024 11:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730662730; x=1731267530; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0la0sxqzxsLHUVj5b4t1hec1mDb/IwBoSRs+TYmwypw=;
        b=DYZAjIRCDiKq7AiFHPHLVLyUL/s3dCeHmmpMwxhYY7aE2eP8w57zyzXmmMSHmDFsTp
         gC8hgEWg9Ymv9GLEbaEdTEysZLGBs++my6DWJI24CUUCbhiIRsGH9Lm2diIt69B2jp6i
         TCFZrGj978Eaimkda+OhBkMqvB/pVkF1iS6fUOH5mdR1ODT7QvRdP7NtItW/8KeLQfhA
         XgyAUGJFzLHaELtmM1SIDJjblvO5RtPZ1zIoWw+wzi30QXC+hGLjVjUihE0F8YNOwUKQ
         DJMwOJprZyl7mjOI4L58PRmVudZV3PEqtiqgYmHfiY6m3mFseVt0sa/Gbjau02wChRpv
         FQIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730662730; x=1731267530;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0la0sxqzxsLHUVj5b4t1hec1mDb/IwBoSRs+TYmwypw=;
        b=I1Q6cocOLReGxN9PVQVHaryLmiCSOYiJlGLzK+QLNZTvdVU86KDTayIm8g9T1rKK2I
         KqvRBycMwRIU+cWl+95LkSWybVYq6SU7tpTLtN4QUyOtVcQlple5LYvgSf0e8a9dWEV0
         /WSgO7AEYfgBwGhc15jPpRoV1KYxAL1nzspg4HS+i/tUDbkwuoUl5VfjXRASehRlA3Kq
         iPqt4lkDRN1tf481fMpltzBX8NslWIYBnjsJS1bxPqBbHde61ROd9+5rZNVnAapfVVZq
         VF8UeY48P7DgeZFF9U3ml5+vy1XGVAlyzOVwZhz9AsUDqpp9H885VXYUFqEqrkOCJDqL
         2VWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLWWO15a48ooa+rTYEl52JPhmSM0M32OUEy1M/P1+X9JT59n7jsKnq2crGKS10TPDrTlhInKWK@vger.kernel.org, AJvYcCWvNdnvUTGnhwENhkaiq/RYjlCHjuZ1c/tk1PnwW7VzUkNGSiYVifGUkuJE2qetMg49RWYoo/W6/EXWa4A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVI0q7bwwytAzyv48bgYBYE2dFCLJyizha3E+oPJLGZ96G180k
	4QaoKBOMf1Xe4YhCGN/5BBNEo0do66e5imIahaEUiuTgTwxlZyr12mwAlO/4ctw=
X-Google-Smtp-Source: AGHT+IHQpQ5MNy8oH8DdhfDZP6iuVsNji2bUgccCrZZ5BsDM/DcexIYeciCpQFEqimnM/5PEZj0WaQ==
X-Received: by 2002:a05:600c:5118:b0:42c:b995:2100 with SMTP id 5b1f17b1804b1-4319ac75a0amr229764275e9.6.1730662729505;
        Sun, 03 Nov 2024 11:38:49 -0800 (PST)
Received: from dev7.kernelcare.com ([2a01:4f8:201:23::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4327d5c65absm129759615e9.16.2024.11.03.11.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2024 11:38:49 -0800 (PST)
From: Andrew Kanner <andrew.kanner@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Kanner <andrew.kanner@gmail.com>,
	stable@vger.kernel.org,
	syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com
Subject: [PATCH v2] ocfs2: remove entry once instead of null-ptr-dereference in ocfs2_xa_remove()
Date: Sun,  3 Nov 2024 20:38:45 +0100
Message-ID: <20241103193845.2940988-1-andrew.kanner@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller is able to provoke null-ptr-dereference in ocfs2_xa_remove():

[   57.319872] (a.out,1161,7):ocfs2_xa_remove:2028 ERROR: status = -12
[   57.320420] (a.out,1161,7):ocfs2_xa_cleanup_value_truncate:1999 ERROR: Partial truncate while removing xattr overlay.upper.  Leaking 1 clusters and removing the entry
[   57.321727] BUG: kernel NULL pointer dereference, address: 0000000000000004
[...]
[   57.325727] RIP: 0010:ocfs2_xa_block_wipe_namevalue+0x2a/0xc0
[...]
[   57.331328] Call Trace:
[   57.331477]  <TASK>
[...]
[   57.333511]  ? do_user_addr_fault+0x3e5/0x740
[   57.333778]  ? exc_page_fault+0x70/0x170
[   57.334016]  ? asm_exc_page_fault+0x2b/0x30
[   57.334263]  ? __pfx_ocfs2_xa_block_wipe_namevalue+0x10/0x10
[   57.334596]  ? ocfs2_xa_block_wipe_namevalue+0x2a/0xc0
[   57.334913]  ocfs2_xa_remove_entry+0x23/0xc0
[   57.335164]  ocfs2_xa_set+0x704/0xcf0
[   57.335381]  ? _raw_spin_unlock+0x1a/0x40
[   57.335620]  ? ocfs2_inode_cache_unlock+0x16/0x20
[   57.335915]  ? trace_preempt_on+0x1e/0x70
[   57.336153]  ? start_this_handle+0x16c/0x500
[   57.336410]  ? preempt_count_sub+0x50/0x80
[   57.336656]  ? _raw_read_unlock+0x20/0x40
[   57.336906]  ? start_this_handle+0x16c/0x500
[   57.337162]  ocfs2_xattr_block_set+0xa6/0x1e0
[   57.337424]  __ocfs2_xattr_set_handle+0x1fd/0x5d0
[   57.337706]  ? ocfs2_start_trans+0x13d/0x290
[   57.337971]  ocfs2_xattr_set+0xb13/0xfb0
[   57.338207]  ? dput+0x46/0x1c0
[   57.338393]  ocfs2_xattr_trusted_set+0x28/0x30
[   57.338665]  ? ocfs2_xattr_trusted_set+0x28/0x30
[   57.338948]  __vfs_removexattr+0x92/0xc0
[   57.339182]  __vfs_removexattr_locked+0xd5/0x190
[   57.339456]  ? preempt_count_sub+0x50/0x80
[   57.339705]  vfs_removexattr+0x5f/0x100
[...]

Reproducer uses faultinject facility to fail ocfs2_xa_remove() ->
ocfs2_xa_value_truncate() with -ENOMEM.

In this case the comment mentions that we can return 0 if
ocfs2_xa_cleanup_value_truncate() is going to wipe the entry
anyway. But the following 'rc' check is wrong and execution flow do
'ocfs2_xa_remove_entry(loc);' twice:
* 1st: in ocfs2_xa_cleanup_value_truncate();
* 2nd: returning back to ocfs2_xa_remove() instead of going to 'out'.

Fix this by skipping the 2nd removal of the same entry and making
syzkaller repro happy.

Cc: stable@vger.kernel.org
Fixes: 399ff3a748cf ("ocfs2: Handle errors while setting external xattr values.")
Reported-by: syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/671e13ab.050a0220.2b8c0f.01d0.GAE@google.com/T/
Tested-by: syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com
Signed-off-by: Andrew Kanner <andrew.kanner@gmail.com>
---

Notes (akanner):
    v2: remove rc check completely, suggested by Joseph Qi <joseph.qi@linux.alibaba.com>
    v1: https://lore.kernel.org/all/20241029224304.2169092-2-andrew.kanner@gmail.com/T/

 fs/ocfs2/xattr.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index dd0a05365e79..73a6f6fd8a8e 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -2036,8 +2036,7 @@ static int ocfs2_xa_remove(struct ocfs2_xa_loc *loc,
 				rc = 0;
 			ocfs2_xa_cleanup_value_truncate(loc, "removing",
 							orig_clusters);
-			if (rc)
-				goto out;
+			goto out;
 		}
 	}
 
-- 
2.43.5


