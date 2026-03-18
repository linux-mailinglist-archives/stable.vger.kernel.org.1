Return-Path: <stable+bounces-227007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBJIEbBqumnnWAIAu9opvQ
	(envelope-from <stable+bounces-227007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:04:48 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CC82B8A4D
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 10:04:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85FF830117BD
	for <lists+stable@lfdr.de>; Wed, 18 Mar 2026 09:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29A039C649;
	Wed, 18 Mar 2026 09:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kMGHv6SK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F169359A97
	for <stable@vger.kernel.org>; Wed, 18 Mar 2026 09:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773824664; cv=none; b=kbbbjzt8xZlS7zNJyCHvPMqTLmPYQ5rnXs8IcsKc87hU1zTxA+WxcfzRlffqMLaLpUgxB2+gkJsUt5Qk/WD3VB0WL2NFwn6Ey0oR4wC01WtQve++nbszRu9bON0ieraEqHxTbQ7hK70LAQvjdYFryMootnEeOAVjygzteFQPqlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773824664; c=relaxed/simple;
	bh=7ExxdqElaBF3VBS7A/NFMdalwrBWC5WkBI0NzubXZhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sMirnR3uZH5FrFOyXBQ09MmFuhr2UVpx/VjAEvK7uvzvDom32h3stZgzu2nEHhFZkM6uVOmFrcMRHVV7TVF85eNb2XS89jxO0B67yJB2r8kGGsrQsDYOtpFvdRlMrSZAbqe/tqCMJtkbUHW75sME8CEPyvsFKgqrXAxktoyA07o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kMGHv6SK; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-82a62714fe6so371587b3a.0
        for <stable@vger.kernel.org>; Wed, 18 Mar 2026 02:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773824662; x=1774429462; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bl+hlvVpCQaqxcRnovEkM7RqYY7uFTt4xrtlJUrWOI0=;
        b=kMGHv6SK1WpaghEJYAoOBfLa9oqd01BO476HVFJEYXFNfmU7eEe20aiOr6KEtGKxa9
         1yx0wieyjpZ4l31jhQyZd2LqIplCKN8li7PtuOx6JUoRYaMKuYyXpSk8+dJ9VHfsGka4
         2K3C5xgrGk4EAjeO5rgwh29DNsHtgtBMbqLtXkkB6RO7EuI57h5sw1Asd+YNNcD0qujn
         zk4gRThuouK7yJXf2jB9wWa62Ttgt/uuhxVgZsN7EDGk4pxHpt7P+heTAws/n+k3C0i5
         Hmjd5nYIdEnHcBTDEMMcy+Vwm6PTYkliAVwlLfMcxG/yXpXO7Z1Jgx/tkKa0CdYrFUNR
         XaoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773824662; x=1774429462;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bl+hlvVpCQaqxcRnovEkM7RqYY7uFTt4xrtlJUrWOI0=;
        b=rQ0pSX5pakmMHR8pF/QErlRkZuA9MuS3/eVM2KOPnQ5OL3PokmJnRWia8cd4+IpmAp
         yWkNPzQn2XrgVwdcLWkDrmeOLFq55/4UvqB+WLMt54UF7Ps1AIwv3cwUGBrMN++ndMhM
         i2tCYXdJl9V0K04DRj2qg8bNu+RpbnaDShpYy40lIl1RPH5ygOd52DlTYkRhAvcznd7+
         Mj7X7P3933FZyIv3p9E/Ei2Br3Wv3zgAylR3F+TnKMQ5ryfVJ97BWr4Bkau/BhYJdvPl
         ghy4RpMknKUBZCxJpwuLwe2lIsn8CRTGcNcQjN3shFnZunV+BWJ8ceB5hWdNIGYMoRu4
         aBug==
X-Forwarded-Encrypted: i=1; AJvYcCVZKnRPICpmqGWjGV5G5AOLIHuSVVE/I5rUoGFmk4WN/QtAy/0mfNDbOu+Ub2KTunhpStz+S7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIPuW0HB8f047K3n6rui1nCBDV0bsTm7BgYwdA8+NyBZIvixYT
	t6IXfYZk6T9NpKr3VvJ7ysb7++ZF5a2zDxnOaxfxuu/8yoDTItQPOKeF
X-Gm-Gg: ATEYQzyrfmCXlPvZLoFoIAfV+5kuecn3Eoq7yUn5phqCAX2auys8frXrpz4ujhQHRN6
	6TSY5RJUJnTMYclkpZopY+nqOqwpCHkB4oOZS9kFSohxcvvtmJfygcbo5Uw5ZRKWlBc09sjtJvk
	lmxMslAAVcXcr5wo2bH/068lIJyr8vjJSoDExZvJdFKxZJv0vD1XZ6z/wjYi/2eawmgZkQ6uM10
	Rob2lQbvZco5z2J2wSfIOMhf4TI4r5LVcneAyfuwxpGFcrajfx9kKVIxahPuuOB+5YrfMvAOwsF
	nwBPXIq8p3HieSKqYXPkq9RBB/wZlIa8nPgJufDsAdi9OQSLKARrRtJaTlvMPcZq3qal+c7LG7L
	aPt+5C+q9uN5gYK9nWjqrU2dDyRToUs8zG0oD73i5XwiwnGl6tEDHLmAolh0R8mTKtBQTfHGTjj
	fBbe7I8Wb+g6+dYWm/PyQR4TPgisVe6lFxbQa/5A4nmbuKrqcjh9q1BjY7mEg5EeGQO2MSRw0=
X-Received: by 2002:a05:6a00:7089:b0:823:1444:7873 with SMTP id d2e1a72fcca58-82a56277fb7mr4670214b3a.32.1773824662246;
        Wed, 18 Mar 2026 02:04:22 -0700 (PDT)
Received: from kernel-fuzz.. ([103.172.182.26])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6b52e5a0sm2608913b3a.4.2026.03.18.02.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 02:04:21 -0700 (PDT)
From: ZhengYuan Huang <gality369@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org,
	cm224.lee@samsung.com
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	r33s3n6@gmail.com,
	zzzccc427@gmail.com,
	ZhengYuan Huang <gality369@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] f2fs: reject non-directory inode in f2fs_get_parent() to prevent null-ptr-deref
Date: Wed, 18 Mar 2026 17:04:10 +0800
Message-ID: <20260318090410.3368669-1-gality369@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[lists.sourceforge.net,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227007-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B5CC82B8A4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

[BUG]
When accessing a crafted f2fs filesystem via open_by_handle_at(2), a
KASAN null-pointer dereference is triggered deep inside the fscrypt
inline-encryption path:

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:__fscrypt_inode_uses_inline_crypto fs/crypto/inline_crypt.c:266
  RIP: 0010:fscrypt_set_bio_crypt_ctx+0x200/0x300 fs/crypto/inline_crypt.c:308
  Call Trace:
    f2fs_set_bio_crypt_ctx fs/f2fs/data.c:492 [inline]
    f2fs_grab_read_bio+0x262/0x7d0 fs/f2fs/data.c:1056
    f2fs_submit_page_read+0xb2/0x180 fs/f2fs/data.c:1095
    f2fs_get_read_data_folio+0x633/0xbe0 fs/f2fs/data.c:1263
    f2fs_find_data_folio+0x146/0x330 fs/f2fs/data.c:1286
    find_in_level fs/f2fs/dir.c:302 [inline]
    __f2fs_find_entry+0x651/0xe10 fs/f2fs/dir.c:377
    f2fs_find_entry+0xc6/0x200 fs/f2fs/dir.c:418
    f2fs_inode_by_name+0x2a/0x1d0 fs/f2fs/dir.c:435
    f2fs_get_parent+0x9b/0x160 fs/f2fs/namei.c:451
    reconnect_one fs/exportfs/expfs.c:130 [inline]
    reconnect_path+0x1f6/0x8c0 fs/exportfs/expfs.c:220
    exportfs_decode_fh_raw+0x3f3/0x780 fs/exportfs/expfs.c:535
    do_handle_to_path fs/fhandle.c:276 [inline]
    handle_to_path fs/fhandle.c:400 [inline]
    do_handle_open+0x62f/0xb30 fs/fhandle.c:415
    __do_sys_open_by_handle_at fs/fhandle.c:455 [inline]
    __se_sys_open_by_handle_at fs/fhandle.c:446 [inline]
    __x64_sys_open_by_handle_at+0x7a/0xc0 fs/fhandle.c:446
    x64_sys_call+0x1cd5/0x26a0 arch/x86/include/generated/asm/syscalls_64.h:305
    ...

The bug is reproducible on next-20260313 with our dynamic
metadata fuzzing tool that corrupts f2fs metadata at runtime.

[CAUSE]
The export reconnect path (exportfs_decode_fh_raw -> reconnect_path ->
reconnect_one -> f2fs_get_parent) does not validate that the inode
embedded in a file handle is actually a directory before treating it
as one.

A crafted file handle can therefore supply a non-directory inode that
has IS_ENCRYPTED set and S_IFREG in i_mode. f2fs_get_parent() calls
f2fs_inode_by_name() on this inode, which eventually calls
f2fs_grab_read_bio() to read the inode's data blocks.
f2fs_grab_read_bio() calls fscrypt_set_bio_crypt_ctx(), which detects:

  fscrypt_needs_contents_encryption() == true  (IS_ENCRYPTED && S_ISREG)

and proceeds to call __fscrypt_inode_uses_inline_crypto(), which does:

  fscrypt_get_inode_info_raw(inode)->ci_inlinecrypt

Because the inode was never opened through the normal f2fs_file_open()
path, fscrypt_file_open() was never called, so i_crypt_info is NULL.
fscrypt_get_inode_info_raw() returns NULL unconditionally (only
printing a VFS_WARN_ON_ONCE), and the subsequent dereference of
NULL->ci_inlinecrypt triggers the null-ptr-deref.

[FIX]
Add an S_ISDIR() check at the top of f2fs_get_parent().  The function
is the f2fs implementation of export_operations::get_parent, which by
contract is only supposed to receive directory dentries.  Reject any
non-directory inode with -ENOTDIR before attempting to search for the
".." entry, so that a crafted file handle carrying a non-dir inode
cannot reach the fscrypt bio setup path without a properly initialised
i_crypt_info.

After this fix, the same crafted file handle will instead be rejected by
f2fs_get_parent() with -ENOTDIR, and the export reconnect path will not
proceed to call f2fs_inode_by_name() on the non-directory inode.

Fixes: 57397d86c62d ("f2fs: add inode operations for special inodes")
Cc: stable@vger.kernel.org
Signed-off-by: ZhengYuan Huang <gality369@gmail.com>
---
 fs/f2fs/namei.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index b882771e4699..0e81a2124a50 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -447,8 +447,14 @@ static int f2fs_link(struct dentry *old_dentry, struct inode *dir,
 
 struct dentry *f2fs_get_parent(struct dentry *child)
 {
+	struct inode *inode = d_inode(child);
 	struct folio *folio;
-	unsigned long ino = f2fs_inode_by_name(d_inode(child), &dotdot_name, &folio);
+	unsigned long ino;
+
+	if (!S_ISDIR(inode->i_mode))
+		return ERR_PTR(-ENOTDIR);
+
+	ino = f2fs_inode_by_name(inode, &dotdot_name, &folio);
 
 	if (!ino) {
 		if (IS_ERR(folio))
-- 
2.43.0


