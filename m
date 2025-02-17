Return-Path: <stable+bounces-116571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD3FA38244
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 12:51:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E95A3A654B
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C883216E10;
	Mon, 17 Feb 2025 11:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="YkMcbAnL"
X-Original-To: stable@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD02C2EF
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 11:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793079; cv=none; b=JR+mjoFZb42GX5ZXa1IyVx+g6SvmFGc99vuDxtLv5DmpIbP8w9oXaQEKeG+K8mxYSAtRc9mTQQf0vEJo/4HpemE28MIcH/VDUH+3JnLNeyhSitTMPV5k+g8amcgHn7ki8e0CFBP6Ri9p9MyO0G4i1XJGwwNyODwlOGVxEsKctMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793079; c=relaxed/simple;
	bh=/++wlYECu1bAVF8WyQi6cZGtH9Hj0M2oadDYNmhAt3c=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qdOgHcd9WUjiKhb3Nxpj9kj+QNhP9k4tbPwUms/ML212OEzdQIlQ2QPbtJuEovMiCrt/UWjOnGQ2n/f0J5l4Au60933F+7ExIcuXfHLpd/WkVtATgFfB5ToyO7OBpMmfO0LmhCv6JHKO/G5UVbkCjetu2YRFBJxLqYLncxQH9A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=YkMcbAnL; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1739792765;
	bh=qWKL0q8zg1HnYrxT09ud0byPjMFRV4ibdxOAgxB99ic=;
	h=From:To:Cc:Subject:Date;
	b=YkMcbAnLSzsrer5mDoGBaYOYBS2wKZpMOZKRXvDlbdo7RQIOoBRGr8aQ+zoUWNdh5
	 0YZNF+KzLgfiw4yv8y5BawRHsqoGjrjUO8ZGnP8PHv7oaGi2QnDbqv3DoDuFqx0G8b
	 wW6GJHFrTjT0rB5y4oHvjy0a/6yrjApI9ejbL7G4=
Received: from public ([120.244.194.234])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id B5EB884A; Mon, 17 Feb 2025 19:45:30 +0800
X-QQ-mid: xmsmtpt1739792730ti4osgomr
Message-ID: <tencent_12AC63705E617E1B6268656A223ED6246109@qq.com>
X-QQ-XMAILINFO: NCrRxdeazcoFeL/bDWfZvgco+AvHGu+s/vwWxQJoKmpv2ANU8+kffgTcWFX+u2
	 JVGi+a68UmrGxidsyvGNNBz6vBMIY+th+cHwaHgCbgWLLhAs7OcrChUfQeGdeaQY4NFALWQEmPDW
	 4Hd3CKvwSQCWtOrJXyeGv095i1GRO08mp3n88Z/QW8T8HlB4rCcOZ6y8ItyMRx6uJJa2Bp7BHVfz
	 npI6jidxt6Avn/Nk+yRwrg8lp6gem8qpD9zf+mAnyRSld93ROWKPl3JknuN4THC7LkndRVcM/ClG
	 E3mDFpedfdDbXIDIHWnNmrPL5wdhIBXy0IWIP7RMJNLPrz8k+k5GYtqNcdUaZdTp3YM//mPdHcYS
	 WbzzhJjQyd+mDSVdyH7e/bTSBZzzwm9QEaamRj+uZ4Pp5Jgh9hK5k/+Q78u/5BCS+WW+Geyzm1js
	 y9o6InsMGNIKcJeCuhsvmLgHqbLcRHxia9poUYNdNmnu6Mqwu0E88n8fXyV7MToW9v97Nt3+aOMu
	 6ensPxIOJwILIIq9ZyS6tEU7CGth/tgvdpAwUw56DopyIOYp/aD/FALkAgYvT6L611SSycStL14i
	 d+dB/UskLjQhu+TpSFsi7WQ495Yc/4tiJgkdojrP8LoVxDciNqsEhRh64zWxWrf0Am/UN4LoZBuF
	 vIBPdwbr+qWgJ1vNHzMynG4Zin7TV0MlihUITgYEe/Fb+olnkrUH1PDjxVIxDMy9XEClkor/G6Mc
	 ZdWnen6vUOHkkZV3pjpNmEw1F2HrFHyDHgdSlzzpJmZ+1iSc2jpw62pR3d65OtGBgGpLnMmWW0Y2
	 f4bn2dHRiLQIQCY3cmuRZ+XVaPCT/2pwETt9Z2yWc/k2TC8l/lSKx+E9h6sRqXX+Ar6rAEZxnYp9
	 QhhK25NgznMFR1zMMWAshHAFp36//4ruxuDvms5wTxVjlGYUxcxBsSNcWxy3iTpJUIXiERPjhR3e
	 Y1BzFzfB9t0bFUvCu9aHOF8BUnpG63
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y] f2fs: fix to wait dio completion
Date: Mon, 17 Feb 2025 19:45:11 +0800
X-OQ-MSGID: <20250217114511.1053-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

commit 96cfeb0389530ae32ade8a48ae3ae1ac3b6c009d upstream.

It should wait all existing dio write IOs before block removal,
otherwise, previous direct write IO may overwrite data in the
block which may be reused by other inode.

Cc: stable@vger.kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 fs/f2fs/file.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3bab52d33e80..5e2a0cb8d24d 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1048,6 +1048,13 @@ int f2fs_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 				return err;
 		}
 
+		/*
+		 * wait for inflight dio, blocks should be removed after
+		 * IO completion.
+		 */
+		if (attr->ia_size < old_size)
+			inode_dio_wait(inode);
+
 		f2fs_down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		filemap_invalidate_lock(inode->i_mapping);
 
@@ -1880,6 +1887,12 @@ static long f2fs_fallocate(struct file *file, int mode,
 	if (ret)
 		goto out;
 
+	/*
+	 * wait for inflight dio, blocks should be removed after IO
+	 * completion.
+	 */
+	inode_dio_wait(inode);
+
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		if (offset >= inode->i_size)
 			goto out;
-- 
2.43.0


