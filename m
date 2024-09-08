Return-Path: <stable+bounces-73891-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF8A970758
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 14:20:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E17392822E5
	for <lists+stable@lfdr.de>; Sun,  8 Sep 2024 12:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CE7158860;
	Sun,  8 Sep 2024 12:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t0a2Pyum"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64E2157485
	for <stable@vger.kernel.org>; Sun,  8 Sep 2024 12:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725798007; cv=none; b=TL3AE8o7pOyIu0rg9hK8GpK2A/kXTJVmekp22ng7eoepP5UHFrRlGNnfzzlNRD2LL9zJEVS/n5xB1SwM/nC0g+ACvecxoN7q2S2HShzbzZALuSqlKF98AzksyX2rihPIMBoH6XURslBVgzFaaoWaC2rL4N4GaXgUogC5p4YAixo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725798007; c=relaxed/simple;
	bh=PuYtTAwexj0LX+7dyxhk1uC6INYKuf4xLs9gppMeYUE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=kGqnsMZdK+M7nz9Zg829CTFRwFhVIXdhCdN8GfBzFulpkCmYOU4mX0bN+yrRpjWO8HGcvozhdYGWyj7Bmw5pj/Qn2vFpRgtHoadYFH5MzQDVFWTC5xTDrKfNR9ZYm2AD7dRaNCKX3T2H5WuBjwbg2cwZJjBdAYZOqTuNG2SiCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t0a2Pyum; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FECC4CEC3;
	Sun,  8 Sep 2024 12:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725798007;
	bh=PuYtTAwexj0LX+7dyxhk1uC6INYKuf4xLs9gppMeYUE=;
	h=Subject:To:Cc:From:Date:From;
	b=t0a2Pyum6zF7LtNpS7lm0A/OBQu8uJuKumxlK5BmiRNB+ZrQWKLt4azYuB36P76jE
	 Pqv5hduiJ3dczv+pF6vRzlaeZIo/L7NlVtE45XuZSQu/oNAd5QuKC6c73RjY5YRoTR
	 ntPr6rZuniMiv1PeF2Tlcvr/J/4BESDO0WTqsLy0=
Subject: FAILED: patch "[PATCH] nilfs2: protect references to superblock parameters exposed" failed to apply to 5.15-stable tree
To: konishi.ryusuke@gmail.com,akpm@linux-foundation.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 08 Sep 2024 14:20:04 +0200
Message-ID: <2024090804-voyage-foothill-5ace@gregkh>
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
git cherry-pick -x 683408258917541bdb294cd717c210a04381931e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024090804-voyage-foothill-5ace@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

683408258917 ("nilfs2: protect references to superblock parameters exposed in sysfs")
3bcd6c5bd483 ("nilfs2: replace snprintf in show functions with sysfs_emit")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 683408258917541bdb294cd717c210a04381931e Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sun, 11 Aug 2024 19:03:20 +0900
Subject: [PATCH] nilfs2: protect references to superblock parameters exposed
 in sysfs

The superblock buffers of nilfs2 can not only be overwritten at runtime
for modifications/repairs, but they are also regularly swapped, replaced
during resizing, and even abandoned when degrading to one side due to
backing device issues.  So, accessing them requires mutual exclusion using
the reader/writer semaphore "nilfs->ns_sem".

Some sysfs attribute show methods read this superblock buffer without the
necessary mutual exclusion, which can cause problems with pointer
dereferencing and memory access, so fix it.

Link: https://lkml.kernel.org/r/20240811100320.9913-1-konishi.ryusuke@gmail.com
Fixes: da7141fb78db ("nilfs2: add /sys/fs/nilfs2/<device> group")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/fs/nilfs2/sysfs.c b/fs/nilfs2/sysfs.c
index a5569b7f47a3..14868a3dd592 100644
--- a/fs/nilfs2/sysfs.c
+++ b/fs/nilfs2/sysfs.c
@@ -836,9 +836,15 @@ ssize_t nilfs_dev_revision_show(struct nilfs_dev_attr *attr,
 				struct the_nilfs *nilfs,
 				char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
-	u32 major = le32_to_cpu(sbp[0]->s_rev_level);
-	u16 minor = le16_to_cpu(sbp[0]->s_minor_rev_level);
+	struct nilfs_super_block *raw_sb;
+	u32 major;
+	u16 minor;
+
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	major = le32_to_cpu(raw_sb->s_rev_level);
+	minor = le16_to_cpu(raw_sb->s_minor_rev_level);
+	up_read(&nilfs->ns_sem);
 
 	return sysfs_emit(buf, "%d.%d\n", major, minor);
 }
@@ -856,8 +862,13 @@ ssize_t nilfs_dev_device_size_show(struct nilfs_dev_attr *attr,
 				    struct the_nilfs *nilfs,
 				    char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
-	u64 dev_size = le64_to_cpu(sbp[0]->s_dev_size);
+	struct nilfs_super_block *raw_sb;
+	u64 dev_size;
+
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	dev_size = le64_to_cpu(raw_sb->s_dev_size);
+	up_read(&nilfs->ns_sem);
 
 	return sysfs_emit(buf, "%llu\n", dev_size);
 }
@@ -879,9 +890,15 @@ ssize_t nilfs_dev_uuid_show(struct nilfs_dev_attr *attr,
 			    struct the_nilfs *nilfs,
 			    char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
+	struct nilfs_super_block *raw_sb;
+	ssize_t len;
 
-	return sysfs_emit(buf, "%pUb\n", sbp[0]->s_uuid);
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	len = sysfs_emit(buf, "%pUb\n", raw_sb->s_uuid);
+	up_read(&nilfs->ns_sem);
+
+	return len;
 }
 
 static
@@ -889,10 +906,16 @@ ssize_t nilfs_dev_volume_name_show(struct nilfs_dev_attr *attr,
 				    struct the_nilfs *nilfs,
 				    char *buf)
 {
-	struct nilfs_super_block **sbp = nilfs->ns_sbp;
+	struct nilfs_super_block *raw_sb;
+	ssize_t len;
 
-	return scnprintf(buf, sizeof(sbp[0]->s_volume_name), "%s\n",
-			 sbp[0]->s_volume_name);
+	down_read(&nilfs->ns_sem);
+	raw_sb = nilfs->ns_sbp[0];
+	len = scnprintf(buf, sizeof(raw_sb->s_volume_name), "%s\n",
+			raw_sb->s_volume_name);
+	up_read(&nilfs->ns_sem);
+
+	return len;
 }
 
 static const char dev_readme_str[] =


