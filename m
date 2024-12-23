Return-Path: <stable+bounces-105977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE939FB28E
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 17:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8885E1881173
	for <lists+stable@lfdr.de>; Mon, 23 Dec 2024 16:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78BDF1A4AAA;
	Mon, 23 Dec 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="j/NkzpxY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A78827;
	Mon, 23 Dec 2024 16:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734970779; cv=none; b=N4VZoNoiztQk/L2z5Z0qRfWxM1tV15s9KLxEWw8CcwobZ9rE0LRjFc2DcT+PI6gTsyhpzTxVfl7dG2fHWy7PsSihkvcxzC1tXIso4QoRGQqFsbZyaiHG0HkLaXOjndmOYG8IMm5kjKVPs1hztGsxcyhMU0XzRaU7NFABQUVprZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734970779; c=relaxed/simple;
	bh=Q/n1STPD1gNQIhyh4sETDsVT19dZPZzgeg8odJKWwM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfqzab+AhXWAl0jbthN633GIzsNW6EtHlAdZ1yJ5UmnLWyZYOcb5hXwbbOi2ckXQ0gdxQD1FP3IeQfgPxS7DjXmAA3bMJmFZoxIumzTdxR6EekqIJhj+MxR5bCVM7mMD2dzP65cC6oUK2oUbDMdvZgv1ORxoMeAQ8yqmbe/YlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=j/NkzpxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99AF6C4CED3;
	Mon, 23 Dec 2024 16:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734970779;
	bh=Q/n1STPD1gNQIhyh4sETDsVT19dZPZzgeg8odJKWwM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j/NkzpxYQIy1B3O8SBW2Xvd0fAmL+rG0WNVdhnN/M8NgL3RtiT8Q3mQBpvNTsBdhD
	 PZHo3QTyEgnY5BOmFDtbiYuqha1rqTaSUpvkaCKpAGxbVIQQUmVac25k05+oLyCIW0
	 IAeKqa6ZK38uTxjrD/FZU2w5mqTeukYlHIlRbPs0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.1 36/83] efivarfs: Fix error on non-existent file
Date: Mon, 23 Dec 2024 16:59:15 +0100
Message-ID: <20241223155355.041993326@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241223155353.641267612@linuxfoundation.org>
References: <20241223155353.641267612@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: James Bottomley <James.Bottomley@HansenPartnership.com>

commit 2ab0837cb91b7de507daa145d17b3b6b2efb3abf upstream.

When looking up a non-existent file, efivarfs returns -EINVAL if the
file does not conform to the NAME-GUID format and -ENOENT if it does.
This is caused by efivars_d_hash() returning -EINVAL if the name is not
formatted correctly.  This error is returned before simple_lookup()
returns a negative dentry, and is the error value that the user sees.

Fix by removing this check.  If the file does not exist, simple_lookup()
will return a negative dentry leading to -ENOENT and efivarfs_create()
already has a validity check before it creates an entry (and will
correctly return -EINVAL)

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: <stable@vger.kernel.org>
[ardb: make efivarfs_valid_name() static]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/efivarfs/inode.c    |    2 +-
 fs/efivarfs/internal.h |    1 -
 fs/efivarfs/super.c    |    3 ---
 3 files changed, 1 insertion(+), 5 deletions(-)

--- a/fs/efivarfs/inode.c
+++ b/fs/efivarfs/inode.c
@@ -47,7 +47,7 @@ struct inode *efivarfs_get_inode(struct
  *
  *	VariableName-12345678-1234-1234-1234-1234567891bc
  */
-bool efivarfs_valid_name(const char *str, int len)
+static bool efivarfs_valid_name(const char *str, int len)
 {
 	const char *s = str + len - EFI_VARIABLE_GUID_LEN;
 
--- a/fs/efivarfs/internal.h
+++ b/fs/efivarfs/internal.h
@@ -50,7 +50,6 @@ bool efivar_variable_is_removable(efi_gu
 
 extern const struct file_operations efivarfs_file_operations;
 extern const struct inode_operations efivarfs_dir_inode_operations;
-extern bool efivarfs_valid_name(const char *str, int len);
 extern struct inode *efivarfs_get_inode(struct super_block *sb,
 			const struct inode *dir, int mode, dev_t dev,
 			bool is_removable);
--- a/fs/efivarfs/super.c
+++ b/fs/efivarfs/super.c
@@ -64,9 +64,6 @@ static int efivarfs_d_hash(const struct
 	const unsigned char *s = qstr->name;
 	unsigned int len = qstr->len;
 
-	if (!efivarfs_valid_name(s, len))
-		return -EINVAL;
-
 	while (len-- > EFI_VARIABLE_GUID_LEN)
 		hash = partial_name_hash(*s++, hash);
 



