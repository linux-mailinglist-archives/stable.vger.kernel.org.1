Return-Path: <stable+bounces-187379-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77799BEAAA1
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E974F947E5A
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74742F12C6;
	Fri, 17 Oct 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f80UIZJl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955E92F12A7;
	Fri, 17 Oct 2025 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715901; cv=none; b=DDi4jDqDuDZd8uvX6hJdbUpKn312TEKFBFUPOYoc3Zf/Oyhe+sdprbH3a6DfLjq0ZraCze5IVadc5dFbxf+up2SGl+sDkkccc66qC6p1UjqL0RNaeMoUES4yaJOYpFCC/Hp9BJ081zWx6QogyCzx+atbEuCqbmHnDskHB+d3c88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715901; c=relaxed/simple;
	bh=fHwukQlYRNacUBWP96LSayUEEilJMV1Yt+VUec0H2q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NAetDgwHUl+4gdIVUH2v/Z/LkkYmPGvrKe44lEhLFF5rpYj/dudiAqjOQer/ntc/VvJZo/L7MvkA5jHGu4m4KqLEffugg2LuR4bcfFhRl9EJvNBy3FWTvPD8g3+/b/I6710zIlftyJUh4l1jyXgPOE2aA9TI5ocJgmyz68n+JzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f80UIZJl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1946DC113D0;
	Fri, 17 Oct 2025 15:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715901;
	bh=fHwukQlYRNacUBWP96LSayUEEilJMV1Yt+VUec0H2q8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f80UIZJltdCIxj3yq3U6MghGBGT2/07GtUbID0HeHj9QMurw2r07sVW+SDWRGRSml
	 qxA1LOO8lULBXB3d30EBgK6XWN+JE5sjxJrSb6Zm9JJ7Mj0xMnJkrSHgDjFtYMtpjX
	 ghUmylMeHrQAeuEKEp17bHU279YmJ3RiBBCkUTs4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Theodore Tso <tytso@mit.edu>,
	syzbot+4c9d23743a2409b80293@syzkaller.appspotmail.com,
	Deepanshu Kartikey <kartikey406@gmail.com>
Subject: [PATCH 6.17 346/371] ext4: validate ea_ino and size in check_xattrs
Date: Fri, 17 Oct 2025 16:55:21 +0200
Message-ID: <20251017145214.598084971@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

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



