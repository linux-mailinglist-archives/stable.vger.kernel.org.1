Return-Path: <stable+bounces-59399-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB11F9322E2
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 11:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC7051C2229B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A439197A81;
	Tue, 16 Jul 2024 09:32:05 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F152C197A61
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 09:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721122324; cv=none; b=kv/sWzwT0Mukho66dLcTqmK83wExpgyzmg60cGOQLk95DVFCw1HJI/7/+AdgVZVwqGKCnQt9cBpxOZt/yw1NJogUv9dv3XjrTJDHtlPNeLJr+qNYMUBfproNKtFZSmBldod8me6I3C8619XosrvworTdGVElQDVTEtD6RDu+5to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721122324; c=relaxed/simple;
	bh=YBZKfkIG/m5I6OPSrvhiArMqjbfjmW8QWVeuKuzfRMs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LriPtSVYfkqO53MH5Owg0LpZ/jTWOFAtyd57maL73uGHBZJcubWFxz/keUubhruPgH7BjAgnTGQ3ndsXSEmTfDF+InidlFdL3AX+ZfFN4jen1AfgvV9uA4CT1NBDl3vPGHFCSQoTmW574ym4Dp3OvfvqSjCeIcKjueIeZlW23NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WNYjv2jdgz4f3jY5
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 17:31:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 590F11A0181
	for <stable@vger.kernel.org>; Tue, 16 Jul 2024 17:31:59 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgC3mjgNPpZmcQsjAQ--.11716S4;
	Tue, 16 Jul 2024 17:31:59 +0800 (CST)
From: libaokun@huaweicloud.com
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: sashal@kernel.org,
	tytso@mit.edu,
	jack@suse.cz,
	patches@lists.linux.dev,
	yi.zhang@huawei.com,
	yangerkun@huawei.com,
	libaokun@huaweicloud.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH 6.6/6.9] ext4: avoid ptr null pointer dereference
Date: Tue, 16 Jul 2024 17:29:29 +0800
Message-Id: <20240716092929.864207-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgC3mjgNPpZmcQsjAQ--.11716S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GFy7uFWxXw1UXF1kWF4kWFg_yoWfKrb_G3
	s5Xr48Crs5Gw1Ik34fCr1YqryrKan5Zr15GFZaqr4a9F4rtr95Ja4qv397Ar48urWxWF9x
	C3Z7CrW3WFyIgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbTAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwAKzVCY07xG64k0F24lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr4
	1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK
	67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI
	8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAv
	wI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14
	v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUO73vUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAGBWaWL5QGDAAAsA

From: Baokun Li <libaokun1@huawei.com>

When commit 13df4d44a3aa ("ext4: fix slab-out-of-bounds in
ext4_mb_find_good_group_avg_frag_lists()") was backported to stable, the
commit f536808adcc3 ("ext4: refactor out ext4_generic_attr_store()") that
uniformly determines if the ptr is null is not merged in, so it needs to
be judged whether ptr is null or not in each case of the switch, otherwise
null pointer dereferencing may occur.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 fs/ext4/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index 63cbda3700ea..d65dccb44ed5 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -473,6 +473,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
 			*((unsigned int *) ptr) = t;
 		return len;
 	case attr_clusters_in_group:
+		if (!ptr)
+			return 0;
 		ret = kstrtouint(skip_spaces(buf), 0, &t);
 		if (ret)
 			return ret;
-- 
2.39.2


