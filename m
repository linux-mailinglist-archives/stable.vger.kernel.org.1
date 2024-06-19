Return-Path: <stable+bounces-53850-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D2390EAEF
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 14:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 063451C21656
	for <lists+stable@lfdr.de>; Wed, 19 Jun 2024 12:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEA9145324;
	Wed, 19 Jun 2024 12:20:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5375714388C
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 12:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799654; cv=none; b=rgpgxNyQt3XG58hUU0kHE1d6JH8HHsoVFabkMhzgAd6QpVVGwg9P2jJDnRZyigNV6btxq3xhFrbC77YNqCfg3EG1GvFh9kA2N5t8tY1mDNIHT1JCiwOVcAimZRYXOdfrTWEbOTPN/JO3WyHxRBVMN/IGlXvpmc2OE6xmdt8SJ/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799654; c=relaxed/simple;
	bh=zyKNDeOuJFJ7n0axNHGLYLHLxoQRlY2vd9pMdY9Buao=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fdiGg7+9I4tMWqjICNBTG0VCDj8bYB7YJG390w+dbt18JDDYo9Sfs3BWfDgkjhVkn2NN4iKA/iwHJ0NZLFIcZGsGvBzB+G+H8QgmUBFNmNgxTqpGLTLyg/b72pfMyYFQtanVcKGZSD/wGPXlj7K8xTN7vWYop57H8/+JIrczNAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W42l85cNnz4f3jLg
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 20:20:36 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 94BEF1A0F44
	for <stable@vger.kernel.org>; Wed, 19 Jun 2024 20:20:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgCH8A0dzXJmYKiAAQ--.12076S4;
	Wed, 19 Jun 2024 20:20:47 +0800 (CST)
From: libaokun@huaweicloud.com
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	yangerkun@huawei.com,
	libaokun1@huawei.com,
	libaokun@huaweicloud.com,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 6.6/6.9 v2 1/2] ext4: avoid overflow when setting values via sysfs
Date: Wed, 19 Jun 2024 20:19:51 +0800
Message-Id: <20240619121952.3508695-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH8A0dzXJmYKiAAQ--.12076S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAryUuF4rurW8Gw4xKw1Utrb_yoW5GF43p3
	W3J34UJr4jqw48G39ruFnxua4Skw4kuFy7GFZ3Ga43ZF9rAF4fKry3KF1YqF1kJ3y8Cry0
	vrsFyFn3urW7GaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwAKzVCY07xG64k0F24l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbveHDUUUUU==
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQASBV1jkHu0lAABsi

From: Baokun Li <libaokun1@huawei.com>

[ Upstream commit 9e8e819f8f272c4e5dcd0bd6c7450e36481ed139 ]

When setting values of type unsigned int through sysfs, we use kstrtoul()
to parse it and then truncate part of it as the final set value, when the
set value is greater than UINT_MAX, the set value will not match what we
see because of the truncation. As follows:

  $ echo 4294967296 > /sys/fs/ext4/sda/mb_max_linear_groups
  $ cat /sys/fs/ext4/sda/mb_max_linear_groups
    0

So we use kstrtouint() to parse the attr_pointer_ui type to avoid the
inconsistency described above. In addition, a judgment is added to avoid
setting s_resv_clusters less than 0.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20240319113325.3110393-2-libaokun1@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Stable-dep-of: 13df4d44a3aa ("ext4: fix slab-out-of-bounds in ext4_mb_find_good_group_avg_frag_lists()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/sysfs.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 6d332dff79dd..ca820620b974 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -104,7 +104,7 @@ static ssize_t reserved_clusters_store(struct ext4_sb_info *sbi,
 	int ret;
 
 	ret = kstrtoull(skip_spaces(buf), 0, &val);
-	if (ret || val >= clusters)
+	if (ret || val >= clusters || (s64)val < 0)
 		return -EINVAL;
 
 	atomic64_set(&sbi->s_resv_clusters, val);
@@ -451,7 +451,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 						s_kobj);
 	struct ext4_attr *a = container_of(attr, struct ext4_attr, attr);
 	void *ptr = calc_ptr(a, sbi);
-	unsigned long t;
+	unsigned int t;
+	unsigned long lt;
 	int ret;
 
 	switch (a->attr_id) {
@@ -460,7 +461,7 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 	case attr_pointer_ui:
 		if (!ptr)
 			return 0;
-		ret = kstrtoul(skip_spaces(buf), 0, &t);
+		ret = kstrtouint(skip_spaces(buf), 0, &t);
 		if (ret)
 			return ret;
 		if (a->attr_ptr == ptr_ext4_super_block_offset)
@@ -471,10 +472,10 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 	case attr_pointer_ul:
 		if (!ptr)
 			return 0;
-		ret = kstrtoul(skip_spaces(buf), 0, &t);
+		ret = kstrtoul(skip_spaces(buf), 0, &lt);
 		if (ret)
 			return ret;
-		*((unsigned long *) ptr) = t;
+		*((unsigned long *) ptr) = lt;
 		return len;
 	case attr_inode_readahead:
 		return inode_readahead_blks_store(sbi, buf, len);
-- 
2.39.2


