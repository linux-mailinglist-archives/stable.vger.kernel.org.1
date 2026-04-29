Return-Path: <stable+bounces-241793-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uDAHJDNj8WnhgQEAu9opvQ
	(envelope-from <stable+bounces-241793-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 03:47:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D81848E15D
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 03:47:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E3F330221E7
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 01:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E556433C518;
	Wed, 29 Apr 2026 01:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHmy7H+h"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744AC1F2B88
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 01:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777427245; cv=none; b=pe1ykM4boigmrJTpTMlqEzvfUMqI3aZ2fje6gFkyVvNvtQ62apekOBLtF60djpYznneAZjWA7C+vu8gVGOorOQvOQOqDaxqm/J/gfG2cW1hWHOjCl8qXQTsV24H8DdHSQDQktY5HwhhMV309Tc//C1dAlY9hdFLBamGn4I/ltPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777427245; c=relaxed/simple;
	bh=WqMv1YckYv/W8D1HJMKDMyO/iFhn+GXZHdYfC+bwTQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A/1s6BxYnhU1u8vIUuceBdl184kSjpDqlr5inPwNy+10dQ8bC9XURE/Gzk2xZ5mliTz9ArvGhA2yi9AfzvqeBs9t/WDMB3ON8wBdqhsK2njFl+Oey4PHYBdD0DghO9+TTLJVuFhabhTMQq5MtOSfamAfszDrarLpiIFxWc1brY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHmy7H+h; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c76d797b180so8185214a12.2
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 18:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777427241; x=1778032041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vQY4IGSDhnPDm3SZbmOaVwD/CLwLKCguemr0HTW+jZ8=;
        b=ZHmy7H+hQhl2GlGaGyksCcJZF4mFtKQriPFwIQZM7G4sg8hxYGULNwOoKjALh7t6rf
         IyIbwPzujwW3LmJveKhTbKDHkjScd4rG++y2cRM53oPPhe1uYHf6/OAcRo6ghI7lbWK0
         RnOCTD9QM5loFrjJyERCKl2u5l64j4je34eVyqIEox3959fKZh+MXGQtONrAnnSiEVEm
         3P4PJU0KWXZGQyq+iB3ufi4AGudcz6rLQUfXQt0n8x1HKLr1sU0Wc+xncD61Eswpbm0l
         zHlEiJS3GdJWnZNcVxKzroTF9OXLfpaYI8y5mIEoQhPQz1HrBQmdGH1PU5+N/Nv8mpn/
         HxYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777427241; x=1778032041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vQY4IGSDhnPDm3SZbmOaVwD/CLwLKCguemr0HTW+jZ8=;
        b=NVdwu3LOKae/yB4F8EbmPD8/l3BtsEGpa/zqz+RpVzQH1pkxZREsOTRyblWiuzxKBF
         wIC8VWtO8vKIIc7xtDxp+KfwXNzpvWjGTjkBmi12our2JYmR690EunaocjbSh8Kpi7QS
         6fqBwkhL/ghanhJi9zTqssmltG3JsTnMHToIMjNxizGwwNSKvb4nCICOwiAVnt/9WFQS
         E7lXSxyekNXonZ3gYpudQOZDXzkl7nEoX+Sij0T3wxtDtJb/8kYmFcwDA04LuRhaBI+e
         lRWDFPxqkKRTGBkNA5tVaXcwaftonWlenXgb2w18Kjzd6VgBrRyxOcWpyfxDkU01XVkr
         85uA==
X-Forwarded-Encrypted: i=1; AFNElJ+il2Qx05bdwMZf13bSujuir0lX+RmkaxLNsbXnu+eGfRy/+zFJ2X9Nrk9D9pXvhXjSt6bdVY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrlJzXnq4KzlEajP9iB1T+KwLBX3CKS84NSuHiVbzq0iyuiqn/
	oL5yqtF8RKTPJhtTJ521HIJQre4IrL3acpNHGNP8znbEvzAl0/KQTYHO
X-Gm-Gg: AeBDieuoCBLWZdUCU4oNETfL/7OSdON0fWVh+1SFY1xAzg9u6H/QvmObi43/dptRQx3
	KOpXGnyHJtQcOD7sm5oeAl3Iw9iDwx+C1rqjOomuZi+dAbDsoaRhguf/odkZL8FtTcF68w4kmxc
	U9JkIzawIY9AF+5c9ZbEKoX9QAQ7WjRo+zVZOqVxevNy6JEXcpG77Y8wt5BGIteVxYgX4njzxPF
	ilbov+yTU5B8FnTPEuVeYpX2f8wXzNbQkZ17kh+0p3lW1qN1wnUy8w5Zw3+1Y3xEHDX2VPgVpyj
	iRyLgoWoJftgfEe11p4ojc18tV34EJHhKG9z35WcKb9bY6dtitbYphREAzpa9O+I5F2uq1vm8fj
	39WdxsOBQH+M4b16XjvSq4y985+XbakAlwXJBsxwKcyrkadkaCd/c+mSKFaHJLtvf245zwB1yWe
	zXm9jbrl+xfcntkD4WGFj33v9l/NFwBWXP1m5fygr1c4fE8h3c6zBKV6R0lXegNgat7hgnw8FHO
	8g9btha7DFhhL/EJw==
X-Received: by 2002:a05:6a21:3290:b0:398:af16:f19f with SMTP id adf61e73a8af0-3a39c2742bemr6744689637.44.1777427241331;
        Tue, 28 Apr 2026 18:47:21 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:383f:4345:dc30:cb53:18e2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed6dd823sm331484b3a.38.2026.04.28.18.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 18:47:19 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: konishi.ryusuke@gmail.com,
	slava@dubeyko.com
Cc: linux-nilfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] nilfs2: reject CLEAN_SEGMENTS ioctl with out-of-range segment numbers
Date: Wed, 29 Apr 2026 07:17:11 +0530
Message-ID: <20260429014711.102110-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 0D81848E15D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,syzkaller.appspotmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241793-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,dubeyko.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kartikey406@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,62f0f99d2f2bb8e3bbd7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Syzbot reported a hung task in nilfs_transaction_begin() where multiple
tasks performing chmod() on a nilfs2 mount blocked for over 143 seconds
waiting to acquire ns_segctor_sem for read:

  INFO: task syz.0.17:5918 blocked for more than 143 seconds.
  Call Trace:
   schedule+0x164/0x360
   rwsem_down_read_slowpath+0x6d9/0x940
   down_read+0x99/0x2e0
   nilfs_transaction_begin+0x364/0x710 fs/nilfs2/segment.c:221
   nilfs_setattr+0x124/0x2c0 fs/nilfs2/inode.c:921
   notify_change+0xc1a/0xf40
   chmod_common+0x273/0x4a0
   do_fchmodat+0x12d/0x230

The writer holding ns_segctor_sem was a concurrent NILFS_IOCTL_CLEAN_SEGMENTS
caller, stuck inside printk while emitting per-element warnings from
nilfs_sufile_updatev():

   __nilfs_msg+0x373/0x450 fs/nilfs2/super.c:78
   nilfs_sufile_updatev+0x21c/0x6d0 fs/nilfs2/sufile.c:186
   nilfs_sufile_freev fs/nilfs2/sufile.h:93 [inline]
   nilfs_free_segments fs/nilfs2/segment.c:1140 [inline]
   nilfs_segctor_collect_blocks fs/nilfs2/segment.c:1261 [inline]
   nilfs_segctor_do_construct+0x1f55/0x76c0
   nilfs_clean_segments+0x3bd/0xa50
   nilfs_ioctl_clean_segments fs/nilfs2/ioctl.c:922 [inline]
   nilfs_ioctl+0x261f/0x2780

The root cause is that nilfs_ioctl_clean_segments() does not validate
the user-supplied segment numbers in kbufs[4] before calling
nilfs_clean_segments(), which acquires ns_segctor_sem for write.  The
range check on each segnum is performed deep inside the call chain by
nilfs_sufile_updatev(), which emits a nilfs_warn() per invalid entry
while still under the segctor lock and the sufile mi_sem.  Under load
(repeated invocations across multiple mounts saturating the global
printk path), the cumulative printk latency keeps ns_segctor_sem held
long enough to trip the hung_task watchdog, blocking concurrent
operations such as chmod() that need ns_segctor_sem for read.

Fix by validating the contents of kbufs[4] in the ioctl entry path,
before any FS-wide lock is acquired.  Out-of-range segment numbers are
rejected with -EINVAL synchronously, with no work performed under
ns_segctor_sem.

Reported-by: syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=62f0f99d2f2bb8e3bbd7
Fixes: 4f6b828837b4 ("nilfs2: fix lock order reversal in nilfs_clean_segments ioctl")
Cc: stable@vger.kernel.org
Tested-by: syzbot+62f0f99d2f2bb8e3bbd7@syzkaller.appspotmail.com
Link: https://lore.kernel.org/all/20260428040256.84403-1-kartikey406@gmail.com/T/ [v1]
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
Changes in v2:
  - Reuse existing 'n' loop variable instead of introducing a new
    one (Slava Dubeyko)
  - Add dedicated out_free_segnums label so the validation-failure
    path falls through the existing cleanup ladder rather than
    duplicating kfree(kbufs[4]) inline (Slava Dubeyko)
---
 fs/nilfs2/ioctl.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index e0a606643e87..41e47f558600 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -876,6 +876,20 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 	}
 	nilfs = inode->i_sb->s_fs_info;
 
+	/*
+	 * Validate segment numbers against the filesystem's segment count
+	 * before entering nilfs_clean_segments(), which acquires
+	 * ns_segctor_sem for write.  Catching invalid segnums here avoids
+	 * holding that lock while emitting per-element diagnostics under
+	 * the segment constructor.
+	 */
+	for (n = 0; n < nsegs; n++) {
+		if (((__u64 *)kbufs[4])[n] >= nilfs->ns_nsegments) {
+			ret = -EINVAL;
+			goto out_free_segnums;
+		}
+	}
+
 	for (n = 0; n < 4; n++) {
 		ret = -EINVAL;
 		if (argv[n].v_size != argsz[n])
@@ -928,6 +942,7 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
 out_free:
 	while (--n >= 0)
 		kvfree(kbufs[n]);
+out_free_segnums:
 	kfree(kbufs[4]);
 out:
 	mnt_drop_write_file(filp);
-- 
2.43.0


