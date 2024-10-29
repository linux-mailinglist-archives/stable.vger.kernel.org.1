Return-Path: <stable+bounces-89269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D94579B55E9
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 23:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EE7B1F23A5B
	for <lists+stable@lfdr.de>; Tue, 29 Oct 2024 22:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAC220A5CF;
	Tue, 29 Oct 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZlPtZGR"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C89199FBB;
	Tue, 29 Oct 2024 22:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730241799; cv=none; b=s1swfRcftJe/Yb0m9EM5TK4sdoFoCmdQ+ZoAG38JNQJ7tDQL2fTSsuL6+edhO2zbJVxiyPyp00tIrb3I+kc4eFC7Eznq85K+QtSzE/NPZU3gHotI2QSqffraRXwqVQYLLc0COy4AeSswYdmb+qEeYl7t6GZIVveuKY28ds6GgWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730241799; c=relaxed/simple;
	bh=xBy/03HYfBlb70X4LjELrQm6dmLET2cm759oyRzlIKg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qA1Lep6UdLsKdPTaJI4a4Go9EJoLUK4ls7/GIycKR5a1fuohjruBgk84MSoTLiL5ikQTOLXplcRWHHZleT9GS5VO5cjrvtstN2WrJu6t8d2JUd+UrTGCkCLf3/ZuwX7sBuVdvYEYYlQJoSkJNnA7Fyj3DKvTZm/ftNSfkxxXhUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZlPtZGR; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so60954045e9.1;
        Tue, 29 Oct 2024 15:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730241795; x=1730846595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NpE1d0EoW69nYU3J7zp+HGEmecn3oGwA/5+kV7hcNXc=;
        b=MZlPtZGR9zg3AmAQvEzFDIe6gnaMidqrBqHP34F7OHN6VOZNqcmuezsxYaGq9xEnMj
         S0W14RTpU7d867OLqLZ/SA6gOYmPmYDwWc83kCdcDdH4FaQRo9Th7cQG2wrbp4zhXe4L
         15l1IkScD9ICT8kcIQVMY1ddbV/h1WuogoWy+62wZfK8H88Hf+scypWiOvt5EoI0i0Xz
         ASOrXlHIAxJf3ErYegNIfIuR2Uu3vLQlcrNo9j1tmLbfQEHoCiapwYzV1u7snJpjdJck
         Z8DTgX2mmdC16cMkQZzVHDLHTycbvhUelXbSRQyDPGEg29hRoYzxF+VBvUCSMvBTlyic
         H4kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730241795; x=1730846595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NpE1d0EoW69nYU3J7zp+HGEmecn3oGwA/5+kV7hcNXc=;
        b=M2xoDWRvAo0YC9hzYTjx62HgtLT5BvwdtPzhRzUT6teoLVSFWrzXodNs411JVd8+Yl
         5vfATANFHH6emYXySSJUSI2NKINbbNDHzYKgNil9mQJu6wMirZPA/dfk885u/wOefc18
         4LitizLg7EzDXD4E22eSIsAX5/0Py0QN+AUJlJEI+Pyy9vDSy8BOHEaHIKJ/5Jd3EUGj
         fVY+pTddxHPT8HbEmG+3cGKyvzecgSWm8yB1rPix7+Ga0ql4N8vvRVvh5XUqyJtPsPfk
         UXdh5/nY4e3U9cp5BleYOEcAw/QcpGjbyvJUFEN23pqRxqQHgDDzgYM58S6roJhK+KZs
         XxCw==
X-Forwarded-Encrypted: i=1; AJvYcCUc0bnNNCdshTvDD3YO5eYRt/C5ikcSbGT4k32czcM9awvt3EggwmHyOsYvjwQc56d/d76SusoLTkXzE1g=@vger.kernel.org, AJvYcCXilSI8Gu1pJCPnh0HLbeyelsCZKKLzW2xgo63m0ZQwQuTl+WMaLZb8N5m0I1xhKwEOvOq7LY8o@vger.kernel.org
X-Gm-Message-State: AOJu0YwcpFoSzE6+i8aPCjcrgjHD9TIjPFGy5nKGHD/mC1VgH+irJOJ9
	aT48X0CkNJuQVIYYqMTRpmputgETbvfbrgSx+uUHQ27+pYAkUuUv
X-Google-Smtp-Source: AGHT+IFK9fk5eMXXFOs6cc2VOy6ViQTADXNGFL9a2kyUdP69q3i86yTHcyTIUMuBDor6JBl+F+zQDA==
X-Received: by 2002:a05:6000:eca:b0:37d:4a16:81d6 with SMTP id ffacd0b85a97d-38061141921mr10080745f8f.24.1730241794879;
        Tue, 29 Oct 2024 15:43:14 -0700 (PDT)
Received: from dev7.kernelcare.com ([2a01:4f8:201:23::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38058b13251sm13747192f8f.6.2024.10.29.15.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 15:43:14 -0700 (PDT)
From: Andrew Kanner <andrew.kanner@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Andrew Kanner <andrew.kanner@gmail.com>,
	stable@vger.kernel.org,
	syzbot+386ce9e60fa1b18aac5b@syzkaller.appspotmail.com
Subject: [PATCH] ocfs2: remove entry once instead of null-ptr-dereference in ocfs2_xa_remove()
Date: Tue, 29 Oct 2024 23:43:05 +0100
Message-ID: <20241029224304.2169092-2-andrew.kanner@gmail.com>
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
 fs/ocfs2/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index dd0a05365e79..5bc4d660e15a 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -2036,7 +2036,7 @@ static int ocfs2_xa_remove(struct ocfs2_xa_loc *loc,
 				rc = 0;
 			ocfs2_xa_cleanup_value_truncate(loc, "removing",
 							orig_clusters);
-			if (rc)
+			if (rc == 0)
 				goto out;
 		}
 	}
-- 
2.43.5


