Return-Path: <stable+bounces-186691-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 94705BE9D74
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:28:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1F2AE58314E
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E548C335073;
	Fri, 17 Oct 2025 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O5fE/6+l"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A046E32E159;
	Fri, 17 Oct 2025 15:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760713962; cv=none; b=OLgHbQFzexNdyu+eqa86r7jsCl8Fyt66MLGygoVE0zDDsDe5Sm0XaVnd1sRu2sEHjCkO2VgH547vLxdtbo1hdm7XVT4ZknAdWTVxdZkirh9aqMdernNYPy5qqdPm7oVlIKaSw9BzaZ9Vj4L8rGRzvdDh2V4sAdFPtfCzCYRu22k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760713962; c=relaxed/simple;
	bh=gfU8FfYr/mOOlEJf1a/i1obG8N5KaEj/Xtvgn3m5T8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DT4qEeYfWaPp8l4KZ8CR7HksLe4zaYNZO3n9UOcl5QCIKC5hEeSEYLQn76NISpulR3WNPwk6EwwOEiqrqUuF9s6hbLngNmruR9d9AJq3zdszTVnvkfUAiu149f9ZeObIqIiy1a8AMU3QEreMqRhQw/6Hvu2AKkIW/ONg0INNuXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O5fE/6+l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AEBCC4CEF9;
	Fri, 17 Oct 2025 15:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760713962;
	bh=gfU8FfYr/mOOlEJf1a/i1obG8N5KaEj/Xtvgn3m5T8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O5fE/6+lbc6KdsyEft8vM1FgiyRuDpDSZaTJkYPYyWNJqtpHJNygodHZNNoWSgtBV
	 0SskBsHD+2FnqLZkdOC/EXCqLSOTjnqH9pn0F8Q/9ZXK5+qsyJE/kXE8YY0MbOQPXn
	 KmGpGk5rJE1ntryaRvrzhNUbIeZfW43+nuBDn2rY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Theodore Tso <tytso@mit.edu>,
	syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH 6.6 153/201] ext4: validate ea_ino and size in check_xattrs
Date: Fri, 17 Oct 2025 16:53:34 +0200
Message-ID: <20251017145140.352356513@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145134.710337454@linuxfoundation.org>
References: <20251017145134.710337454@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Deepanshu Kartikey <kartikey406@gmail.com>

commit 44d2a72f4d64655f906ba47a5e108733f59e6f28 upstream.

During xattr block validation, check_xattrs() processes xattr entries
without validating that entries claiming to use EA inodes have non-zero
sizes. Corrupted filesystems may contain xattr entries where e_value_size
is zero but e_value_inum is non-zero, indicating invalid xattr data.

Add validation in check_xattrs() to detect this corruption pattern early
and return -EFSCORRUPTED, preventing invalid xattr entries from causing
issues throughout the ext4 codebase.

Cc: stable@kernel.org
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Reported-by: syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=4c9d23743a2409b80293
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Message-ID: <20250923133245.1091761-1-kartikey406@gmail.com>
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ext4/xattr.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -251,6 +251,10 @@ check_xattrs(struct inode *inode, struct
 			err_str = "invalid ea_ino";
 			goto errout;
 		}
+		if (ea_ino && !size) {
+			err_str = "invalid size in ea xattr";
+			goto errout;
+		}
 		if (size > EXT4_XATTR_SIZE_MAX) {
 			err_str = "e_value size too large";
 			goto errout;



