Return-Path: <stable+bounces-41214-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 577CA8AFAC2
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88CE01C2351B
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B63714A60E;
	Tue, 23 Apr 2024 21:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m+BYdxIf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45CC143899;
	Tue, 23 Apr 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908756; cv=none; b=CWW24PvRD0mbaHaPg8aJYrl6Sy2AU2zWCWcONurwvElOfMeNgGrrNRCu6z4N+CyBTTv6mqQXy2iF4j1D9gbhwELxKMMKNShfeGjY44MUenP60/cCkcuvEPqJ59Qn4sjeblgPawXSi34+nirYU3IHaSrWEIuakFdCYn5xdN9K2w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908756; c=relaxed/simple;
	bh=yeKyTV4wYNfSaoDWQz/GmnSovWQb00QuRBhOeTtHc88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QdXpQk/qv0RhCKO21xXgyz89zOiqvKf30HKiTIo9lAAbTVjz5LoaQqPGbr1Ad/k2noW0DOCcCQC0vVI6eTPCKlaqi2BUUHuDDAmYdY4hCE/M2rlkbHYSnfYDoRxykWcNEy4xTclY8aHoQ5luNdYPU/PerhoP0ydjyAXFxXWus24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m+BYdxIf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CFC1C32786;
	Tue, 23 Apr 2024 21:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908755;
	bh=yeKyTV4wYNfSaoDWQz/GmnSovWQb00QuRBhOeTtHc88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m+BYdxIfqftKyG+UrFh0HCux+upEQhTzok/5vEGU2ic74FfMc026NUDPZ04MtPWly
	 Uf09ztXT0JErz4WKyLnA0gG1HMW5kdckgilr9XLDu60c+CaL6exUgI16/+hAtDmQUA
	 w3LfX5geja8jKCGCDZIEy8EKdBuSgxBjJrnqTPh0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot+2e22057de05b9f3b30d8@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.1 132/141] nilfs2: fix OOB in nilfs_set_de_type
Date: Tue, 23 Apr 2024 14:40:00 -0700
Message-ID: <20240423213857.497823166@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213853.356988651@linuxfoundation.org>
References: <20240423213853.356988651@linuxfoundation.org>
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

From: Jeongjun Park <aha310510@gmail.com>

commit c4a7dc9523b59b3e73fd522c73e95e072f876b16 upstream.

The size of the nilfs_type_by_mode array in the fs/nilfs2/dir.c file is
defined as "S_IFMT >> S_SHIFT", but the nilfs_set_de_type() function,
which uses this array, specifies the index to read from the array in the
same way as "(mode & S_IFMT) >> S_SHIFT".

static void nilfs_set_de_type(struct nilfs_dir_entry *de, struct inode
 *inode)
{
	umode_t mode = inode->i_mode;

	de->file_type = nilfs_type_by_mode[(mode & S_IFMT)>>S_SHIFT]; // oob
}

However, when the index is determined this way, an out-of-bounds (OOB)
error occurs by referring to an index that is 1 larger than the array size
when the condition "mode & S_IFMT == S_IFMT" is satisfied.  Therefore, a
patch to resize the nilfs_type_by_mode array should be applied to prevent
OOB errors.

Link: https://lkml.kernel.org/r/20240415182048.7144-1-konishi.ryusuke@gmail.com
Reported-by: syzbot+2e22057de05b9f3b30d8@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=2e22057de05b9f3b30d8
Fixes: 2ba466d74ed7 ("nilfs2: directory entry operations")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/nilfs2/dir.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/nilfs2/dir.c
+++ b/fs/nilfs2/dir.c
@@ -243,7 +243,7 @@ nilfs_filetype_table[NILFS_FT_MAX] = {
 
 #define S_SHIFT 12
 static unsigned char
-nilfs_type_by_mode[S_IFMT >> S_SHIFT] = {
+nilfs_type_by_mode[(S_IFMT >> S_SHIFT) + 1] = {
 	[S_IFREG >> S_SHIFT]	= NILFS_FT_REG_FILE,
 	[S_IFDIR >> S_SHIFT]	= NILFS_FT_DIR,
 	[S_IFCHR >> S_SHIFT]	= NILFS_FT_CHRDEV,



