Return-Path: <stable+bounces-116572-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6232A38262
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 12:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A6A016433D
	for <lists+stable@lfdr.de>; Mon, 17 Feb 2025 11:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFCB21A42B;
	Mon, 17 Feb 2025 11:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Hivv4NR2"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E5219E8F
	for <stable@vger.kernel.org>; Mon, 17 Feb 2025 11:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739793220; cv=none; b=DzUjhOZrbjQhUHUayOJGaMkiHnhOpgvZqq7iZnDip8ezhzBgbevBfw8yGJWOpQvNC2Xt2UXQAREp+MlNF8QDoxGD4p0Ssa3Hj2nvj1xyfvdlbKjje8VgONAvcL/rYoqIWvaeT2ehrvYbbvHVdUd24OJYaNhPz4Lc8d5udm1tzCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739793220; c=relaxed/simple;
	bh=NfntH+NWqU9RBWPzk1oalEdgKdPZw+ZZNwVx6tJS+LQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=HhrU7ARyZRyGQpIdSuqQTBeo57vaXnDsB33GV8wBZS0UTyLJwtMTMHmjbD04u36F2G1Yx4XekfOTBo3jjwOqED4BKI8ADbn7Rw9dIl4XOw4S5d7hZEzQGsVvc4mzoYgysKLPI5+N512hOPqpeAOpbpetI8ul+3/W2YW4wDatP6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Hivv4NR2; arc=none smtp.client-ip=203.205.221.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1739792909;
	bh=9e2KJ78Z1iXp0uSJvJj2y0Na0oGXCCdCbjP3snr8siA=;
	h=From:To:Cc:Subject:Date;
	b=Hivv4NR2EAbBtVNbHmo1OKZjNc74IkP5IOMO/EyTASBepKJ5orAwpovxp23CykEx9
	 BVmjmhQ+NOkHSOMG79K3h2wOr35VL/UJewKPSk5uXegOGW+rpRMssXVM5vNYBWW72M
	 NwC3znvhyS3Tl6WzY/euuh3uPz5qGaF4hxm82SdI=
Received: from public ([120.244.194.234])
	by newxmesmtplogicsvrszgpua8-1.qq.com (NewEsmtp) with SMTP
	id C11A42DE; Mon, 17 Feb 2025 19:48:17 +0800
X-QQ-mid: xmsmtpt1739792897tphnvb4gw
Message-ID: <tencent_9E7C104ABA59FBE394C188378CD0E6D7080A@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uA1io7K5ztokOTkkMEAEqaHlxaonRkvPWYc1JfbTm3ugI94ADKq
	 sv1B6R9A2GDbdwuY9AgfJlv2dSphgQEFnLFjeWOxdeOr5Ly77kXAxDqO3d1TyUjy8H6rNaSReiFv
	 6gI/pQaOpVfu/3tJfwDBb/Wr0wz2lsPaNkBQTEKDGxsXm7XUgtCc/iI60Q0Ea79uVI7YZkThRgnn
	 xTpHG7CuTwmeACjXRZnV/My3hs5WjBozMrK6hRaIgH7Wtat6OOtDRflynO0Qbgxm4Qkqb2aNPIiB
	 3Fwfew48mUDS2xcg38O8SJBl3F4gKZ60+w1rDLk2urlnorzVMwjZuLSTDbdNISXZBJXuIhaJKXMr
	 dJvrFQQpcTp5dGVfzfXINWXnDnFl84wu35weyUYqHj8PGUYR/ps3JQXfJUab7N2a+b47dAUMH6UA
	 xw8BgSkDz9rIkaLInZnra7nLZ6uKItRA1LKpFMhpLyo2iS7ICAUIFj2YYwmdz1r2lXwe7lfi4cwF
	 bm0J8etcSwbf2fPjI+p6exkUajSiO+DbYyF23lFIrG/ufT7z9bHBcZpIR+Rgzy97hd7od+UFtZUC
	 BRUVYMQEkHt4Zot3vk3/bfi/CNs73gjinX4C0cDBRm/iY2FK0AlhXHHnOA64T6T1OUgXo/5WOMqg
	 +qug/K+GGkOFj1L8Xeq3qgJe7ED3PbSTHWIaaVCg4LdlUp4e5BHYnWAdA+NrCOFYMEHewdBwFQDV
	 XAS+MeK+nwgL/oM+bZABAS1RAjgOKopISKCupxdRVlrHjcJX79Sa1gvocHo/1E2//kcfH3CloUAL
	 uRDt0ZA/m2tfWlX7vNcq+EgoHQo6bxDB0mRAUwB4pA0cjxElYEyWLjsW5EL0lIsvwtzMbrIV1z+c
	 aPBVxgN9OFmxVUqRAVHXOMM3T8UB6nR/dcq5m30LRJ/BQ5pyWLzw/60VzhlBV2t2479CWdBDkT4T
	 wj93rsXQC2XPMHJ3aobbKM8nnm/wZM1h2iu60l0E1jkDA33CEJawV++sHUcA/gPIxy08vuseBR2A
	 2DxcMLI+tba1EhkF22aA0rUhXNsoi0vdEouaklzQ==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: alvalan9@foxmail.com
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 5.10.y] f2fs: fix to wait dio completion
Date: Mon, 17 Feb 2025 19:48:20 +0800
X-OQ-MSGID: <20250217114820.1839-1-alvalan9@foxmail.com>
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
index 9ecf39c2b47d..81ebbc1d37a6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -957,6 +957,13 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
 				return err;
 		}
 
+		/*
+		 * wait for inflight dio, blocks should be removed after
+		 * IO completion.
+		 */
+		if (attr->ia_size < old_size)
+			inode_dio_wait(inode);
+
 		down_write(&F2FS_I(inode)->i_gc_rwsem[WRITE]);
 		down_write(&F2FS_I(inode)->i_mmap_sem);
 
@@ -1777,6 +1784,12 @@ static long f2fs_fallocate(struct file *file, int mode,
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


