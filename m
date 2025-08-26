Return-Path: <stable+bounces-174497-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA52BB3636F
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 15:29:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02321884894
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740A730146D;
	Tue, 26 Aug 2025 13:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KHVZ9ou+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322C824169D;
	Tue, 26 Aug 2025 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214549; cv=none; b=Szalb4gUz7eAWfhe6RGjKG/ZVwm03oH+NDtt+9JtNogh3a5fZEu0qJ/mjj4l6LrCusIli9ZeayLPYspjefk9MH7TIiArRkx1oA+LYVgp3inu0tKTC9q07MuN2pzYoIakRUBXd+ns2fOTE5J16978Jyrw58bixofON6sacrepggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214549; c=relaxed/simple;
	bh=aaAMW922A1rj+pR4DJCtkSKJcMPT0y8SQiEMZILsx3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qxKzMWgN8A/ddjyj+a5oFRlEa3pAxdv+BWyjNsdk+239AUMu55pPQIwuu9RDj8vnxddjixr2GyR7El1/cw63b6xiITf/yiNFaNPK23tsGh91+rm4XkJhYR52KXzroQs2WAoWk7Obq8UPIlzTl3Vb5TfWY+IHupP5O7VUgZH7PY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KHVZ9ou+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC44C4CEF1;
	Tue, 26 Aug 2025 13:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756214548;
	bh=aaAMW922A1rj+pR4DJCtkSKJcMPT0y8SQiEMZILsx3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KHVZ9ou+BbTerwQXEe0wsfsE+HG21Xf203jQiQ0VaFc6JPSVTFJ5aDm+H+K8Kv9N0
	 zrZ5QPcLIYjWvcEeWCDXkp0q4gTm5A2Uad40N2r8xrJoz7bUvgDrn1yHaF442+R598
	 TNDDqqbE+Z1Q9kyd9FpkRNHcDruSHAmo91B8Q3CE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+544248a761451c0df72f@syzkaller.appspotmail.com,
	Theodore Tso <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 178/482] ext4: do not BUG when INLINE_DATA_FL lacks system.data xattr
Date: Tue, 26 Aug 2025 13:07:11 +0200
Message-ID: <20250826110935.204973064@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110930.769259449@linuxfoundation.org>
References: <20250826110930.769259449@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Theodore Ts'o <tytso@mit.edu>

[ Upstream commit 099b847ccc6c1ad2f805d13cfbcc83f5b6d4bc42 ]

A syzbot fuzzed image triggered a BUG_ON in ext4_update_inline_data()
when an inode had the INLINE_DATA_FL flag set but was missing the
system.data extended attribute.

Since this can happen due to a maiciouly fuzzed file system, we
shouldn't BUG, but rather, report it as a corrupted file system.

Add similar replacements of BUG_ON with EXT4_ERROR_INODE() ii
ext4_create_inline_data() and ext4_inline_data_truncate().

Reported-by: syzbot+544248a761451c0df72f@syzkaller.appspotmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/inline.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 312be3d7cfb3..af2d6e92cb7f 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -299,7 +299,11 @@ static int ext4_create_inline_data(handle_t *handle,
 	if (error)
 		goto out;
 
-	BUG_ON(!is.s.not_found);
+	if (!is.s.not_found) {
+		EXT4_ERROR_INODE(inode, "unexpected inline data xattr");
+		error = -EFSCORRUPTED;
+		goto out;
+	}
 
 	error = ext4_xattr_ibody_set(handle, inode, &i, &is);
 	if (error) {
@@ -350,7 +354,11 @@ static int ext4_update_inline_data(handle_t *handle, struct inode *inode,
 	if (error)
 		goto out;
 
-	BUG_ON(is.s.not_found);
+	if (is.s.not_found) {
+		EXT4_ERROR_INODE(inode, "missing inline data xattr");
+		error = -EFSCORRUPTED;
+		goto out;
+	}
 
 	len -= EXT4_MIN_INLINE_DATA_SIZE;
 	value = kzalloc(len, GFP_NOFS);
@@ -2002,7 +2010,12 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 			if ((err = ext4_xattr_ibody_find(inode, &i, &is)) != 0)
 				goto out_error;
 
-			BUG_ON(is.s.not_found);
+			if (is.s.not_found) {
+				EXT4_ERROR_INODE(inode,
+						 "missing inline data xattr");
+				err = -EFSCORRUPTED;
+				goto out_error;
+			}
 
 			value_len = le32_to_cpu(is.s.here->e_value_size);
 			value = kmalloc(value_len, GFP_NOFS);
-- 
2.39.5




