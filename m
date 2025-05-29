Return-Path: <stable+bounces-148098-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAEEAC808D
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 17:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84F997A5F9E
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 15:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B73022D78F;
	Thu, 29 May 2025 15:54:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBD922D4F1;
	Thu, 29 May 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534076; cv=none; b=Uz6Y8J+bR6ig4RoJ/v4pUnI8HBfYYGXWpXY3zJllcRp/8xvDCJQM+bNdOC3JJmmXUCsj3mQ55Ijq63C+ReSqw2dd7KU4MCO/xXJzpJYLjmJhJRk8u5S3bLPQqib1TXEoVyCNBkq/ZrBoyh/sfrHllrvkv0LUoLUUI6bdId71/UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534076; c=relaxed/simple;
	bh=9iykyd3qskHYYgZ8CHKhOP7iD/5TnA6IMb1PXIV/U7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UyAqqA5P2FAn5CqrFAWRis+GSOlsgS8juC9afJd9ATdND/gPRbLtidDbPcQyGtGGXXNg5Ov81HY+9tXjOBLusA3SV3h5P5qj0suG9pqHQbxNR84OcyB9pyolXCsGhZ6LkTNSOxMcPec7etfAn9qemU5pIDlMjb4FVU73XOvE754=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4b7WCD5f4YzYQv88;
	Thu, 29 May 2025 23:54:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id DC56B1A1599;
	Thu, 29 May 2025 23:54:31 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBX98EzgzhooMK5Ng--.57784S6;
	Thu, 29 May 2025 23:54:31 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	Liam.Howlett@oracle.com,
	lorenzo.stoakes@oracle.com,
	vbabka@suse.cz,
	jannh@google.com,
	pfalcato@suse.de
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	pulehui@huawei.com
Subject: [PATCH v1 4/4] selftests/mm: Add test about uprobe pte be orphan during vma merge
Date: Thu, 29 May 2025 15:56:50 +0000
Message-Id: <20250529155650.4017699-5-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250529155650.4017699-1-pulehui@huaweicloud.com>
References: <20250529155650.4017699-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBX98EzgzhooMK5Ng--.57784S6
X-Coremail-Antispam: 1UD129KBjvJXoW7ury3JF1xCry8KFyfJrykuFg_yoW8uF4fp3
	WkAwn8tw4rKw13t343Zryq9a1fKrs7Jr47t34fXFy8Z3W7tr9xJF40kFyDXFWkXrWvqrn8
	C39xJFWfCrWUXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
	xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
	z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
	AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAq
	x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
	43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF
	7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI
	0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7I
	U1aLvJUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

Add test about uprobe pte be orphan during vma merge.

Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 tools/testing/selftests/mm/merge.c | 42 ++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/tools/testing/selftests/mm/merge.c b/tools/testing/selftests/mm/merge.c
index c76646cdf6e6..8e1f38d23384 100644
--- a/tools/testing/selftests/mm/merge.c
+++ b/tools/testing/selftests/mm/merge.c
@@ -2,11 +2,13 @@
 
 #define _GNU_SOURCE
 #include "../kselftest_harness.h"
+#include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
+#include <linux/perf_event.h>
 #include "vm_util.h"
 
 FIXTURE(merge)
@@ -452,4 +454,44 @@ TEST_F(merge, forked_source_vma)
 	ASSERT_EQ(procmap->query.vma_end, (unsigned long)ptr2 + 5 * page_size);
 }
 
+TEST_F(merge, handle_uprobe_upon_merged_vma)
+{
+	const size_t attr_sz = sizeof(struct perf_event_attr);
+	unsigned int page_size = self->page_size;
+	const char *probe_file = "./foo";
+	char *carveout = self->carveout;
+	struct perf_event_attr attr;
+	unsigned long type;
+	void *ptr1, *ptr2;
+	int fd;
+
+	fd = open(probe_file, O_RDWR|O_CREAT, 0600);
+	ASSERT_GE(fd, 0);
+
+	ASSERT_EQ(ftruncate(fd, page_size), 0);
+	ASSERT_EQ(read_sysfs("/sys/bus/event_source/devices/uprobe/type", &type), 0);
+
+	memset(&attr, 0, attr_sz);
+	attr.size = attr_sz;
+	attr.type = type;
+	attr.config1 = (__u64)(long)probe_file;
+	attr.config2 = 0x0;
+
+	ASSERT_GE(syscall(__NR_perf_event_open, &attr, 0, -1, -1, 0), 0);
+
+	ptr1 = mmap(&carveout[page_size], 10 * page_size, PROT_EXEC,
+		    MAP_PRIVATE | MAP_FIXED, fd, 0);
+	ASSERT_NE(ptr1, MAP_FAILED);
+
+	ptr2 = mremap(ptr1, page_size, 2 * page_size,
+		      MREMAP_MAYMOVE | MREMAP_FIXED, ptr1 + 5 * page_size);
+	ASSERT_NE(ptr2, MAP_FAILED);
+
+	ASSERT_NE(mremap(ptr2, page_size, page_size,
+			 MREMAP_MAYMOVE | MREMAP_FIXED, ptr1), MAP_FAILED);
+
+	close(fd);
+	remove(probe_file);
+}
+
 TEST_HARNESS_MAIN
-- 
2.34.1


