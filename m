Return-Path: <stable+bounces-61399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6431293C246
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 14:44:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C7D282EA4
	for <lists+stable@lfdr.de>; Thu, 25 Jul 2024 12:44:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA2D19938A;
	Thu, 25 Jul 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Sw0pm+oA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B27B198E7D
	for <stable@vger.kernel.org>; Thu, 25 Jul 2024 12:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721911449; cv=none; b=NYqUvEWSZ2Tqi1Mx7oWP4fyvLlxrryIjLUzRK6+UqBFBOn1T+hjvB7EybhkHaasThZu7Sr/L+NyLJy/cD80NQdigorswcVW0ooqi7ew1ggMAqrF77XKbOs1DIcEkBKIM0f9VksBea5/gxwHavpexCAae4zuALEAFO6OcM/bpNtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721911449; c=relaxed/simple;
	bh=8T691T1kUKL1BgbOEDUILQIohX6y5c7tK0Psi3Ilg1Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QCe8JJLmMFeG+m3cnLC1s/TLhEYWN5Gn66kZHs2cwxs30iBeLd8AoQuonI5UfJSu5VKbijjmyEua3Sz6aUCBM+Mjh01zN0IZ6cvIxYgYABajprUPZYtHvdpxow2i2TxuY4ZvzM9F7PJWGZo4l3OlCdw8mXKSGruvnvk6ZGQEg+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Sw0pm+oA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE68C116B1;
	Thu, 25 Jul 2024 12:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721911449;
	bh=8T691T1kUKL1BgbOEDUILQIohX6y5c7tK0Psi3Ilg1Q=;
	h=Subject:To:Cc:From:Date:From;
	b=Sw0pm+oA/ds9Okh3r+Rj4jtma9q6LCfm2SBLlsJ4x9zUGLQrXKG7Gb+69im2rrdht
	 LQtT+vRDgUQcJmECoh9jAESIt2X3BwV1mOLXbSZabJerYwbEMiqJJ7x/Xkk0M0asAq
	 3OEx9AmvM28uWUTCKenJczbfulxqWD2UVjb+O3s0=
Subject: FAILED: patch "[PATCH] ocfs2: strict bound check before memcmp in" failed to apply to 5.15-stable tree
To: mengferry@linux.alibaba.com,akpm@linux-foundation.org,gechangwei@live.cn,ghe@suse.com,jlbec@evilplan.org,joseph.qi@linux.alibaba.com,junxiao.bi@oracle.com,llfamsec@gmail.com,mark@fasheh.com,piaojun@huawei.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 25 Jul 2024 14:43:55 +0200
Message-ID: <2024072555-hubcap-monetary-01bc@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x af77c4fc1871847b528d58b7fdafb4aa1f6a9262
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024072555-hubcap-monetary-01bc@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

af77c4fc1871 ("ocfs2: strict bound check before memcmp in ocfs2_xattr_find_entry()")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From af77c4fc1871847b528d58b7fdafb4aa1f6a9262 Mon Sep 17 00:00:00 2001
From: Ferry Meng <mengferry@linux.alibaba.com>
Date: Mon, 20 May 2024 10:40:24 +0800
Subject: [PATCH] ocfs2: strict bound check before memcmp in
 ocfs2_xattr_find_entry()

xattr in ocfs2 maybe 'non-indexed', which saved with additional space
requested.  It's better to check if the memory is out of bound before
memcmp, although this possibility mainly comes from crafted poisonous
images.

Link: https://lkml.kernel.org/r/20240520024024.1976129-2-joseph.qi@linux.alibaba.com
Signed-off-by: Ferry Meng <mengferry@linux.alibaba.com>
Signed-off-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Reported-by: lei lu <llfamsec@gmail.com>
Reviewed-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Cc: Changwei Ge <gechangwei@live.cn>
Cc: Gang He <ghe@suse.com>
Cc: Joel Becker <jlbec@evilplan.org>
Cc: Jun Piao <piaojun@huawei.com>
Cc: Junxiao Bi <junxiao.bi@oracle.com>
Cc: Mark Fasheh <mark@fasheh.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 8aea94c90739..35c0cc2a51af 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -1068,7 +1068,7 @@ static int ocfs2_xattr_find_entry(struct inode *inode, int name_index,
 {
 	struct ocfs2_xattr_entry *entry;
 	size_t name_len;
-	int i, cmp = 1;
+	int i, name_offset, cmp = 1;
 
 	if (name == NULL)
 		return -EINVAL;
@@ -1083,10 +1083,15 @@ static int ocfs2_xattr_find_entry(struct inode *inode, int name_index,
 		cmp = name_index - ocfs2_xattr_get_type(entry);
 		if (!cmp)
 			cmp = name_len - entry->xe_name_len;
-		if (!cmp)
-			cmp = memcmp(name, (xs->base +
-				     le16_to_cpu(entry->xe_name_offset)),
-				     name_len);
+		if (!cmp) {
+			name_offset = le16_to_cpu(entry->xe_name_offset);
+			if ((xs->base + name_offset + name_len) > xs->end) {
+				ocfs2_error(inode->i_sb,
+					    "corrupted xattr entries");
+				return -EFSCORRUPTED;
+			}
+			cmp = memcmp(name, (xs->base + name_offset), name_len);
+		}
 		if (cmp == 0)
 			break;
 		entry += 1;


