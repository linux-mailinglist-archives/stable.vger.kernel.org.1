Return-Path: <stable+bounces-148101-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2247BAC8095
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 17:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4E68A40D81
	for <lists+stable@lfdr.de>; Thu, 29 May 2025 15:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500B122E3E6;
	Thu, 29 May 2025 15:54:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F6D22CBF1;
	Thu, 29 May 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748534077; cv=none; b=PRGoaJhpbTHFCYV07sTe/IKBHjabBqXEXfd438vgqGF+fkAxa1LYikRde0UXR3P8Yx5Wa6X8kQHsgWlPoBnEnUFZyZtWpFZQwwfJhzXCGqEG5Nftwx7wR+6yjgBpA0N7JpYyHfDll/9d27P//oqxQfCgIIDCeAtZUiQwA/C5qUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748534077; c=relaxed/simple;
	bh=BP8Qw+tMHBsbt4rBLP4J5Z6ssjPgliQK5cZVXjCzkho=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XxScTeyqkyrQWNrG24yNteJ396zwQXuzhXBRcQ7o1FznRhjuJAt7K14JyVsQBZJ6KsBPimNSNH1MeyhmrFkkpjz60yo/4A+qaEhFbvfqSWzDFjfWDVIfE34/jePIu40r2TeSF0VghMQ/G9saXnVDkQ7qOzLFpJ1Lkw0nRkKIvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4b7WCF1KRkzKHMmL;
	Thu, 29 May 2025 23:54:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 977071A1599;
	Thu, 29 May 2025 23:54:31 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP3 (Coremail) with SMTP id _Ch0CgBX98EzgzhooMK5Ng--.57784S2;
	Thu, 29 May 2025 23:54:29 +0800 (CST)
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
Subject: [PATCH v1 0/4] Fix uprobe pte be overwritten when expanding vma
Date: Thu, 29 May 2025 15:56:46 +0000
Message-Id: <20250529155650.4017699-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgBX98EzgzhooMK5Ng--.57784S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWrCF47Wr4UCrW7Cr1fCrg_yoW8Xr4fp3
	Z3tw1agw1Sqr13J3s3ArsFg34FgF4kJFyUAr13X34rAr18tFy0krWIgF40vFyUJFZ3WryS
	y3Z7Kas3C3yUA3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0E
	n4kS14v26r1q6r43MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I
	0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWU
	tVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcV
	CY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU17KsUUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

patch 1: the mainly fix for uprobe pte be overwritten issue.
patch 2: WARN_ON_ONCE for new_pte not NULL during move_ptes.
patch 3: extract some utils function for upcomming selftest.
patch 4: selftest related to this series.

v1:
- limit skip uprobe_mmap to copy_vma flow.
- add related selftest.
- correct Fixes tag.

RFC v2:
https://lore.kernel.org/all/20250527132351.2050820-1-pulehui@huaweicloud.com/
- skip uprobe_mmap on expanded vma.
- add skip_vma_uprobe field to struct vma_prepare and
  vma_merge_struct. (Lorenzo)
- add WARN_ON_ONCE when new_pte is not NULL. (Oleg)
- Corrected some of the comments.

RFC v1:
https://lore.kernel.org/all/20250521092503.3116340-1-pulehui@huaweicloud.com/

Pu Lehui (4):
  mm: Fix uprobe pte be overwritten when expanding vma
  mm: Expose abnormal new_pte during move_ptes
  selftests/mm: Extract read_sysfs and write_sysfs into vm_util
  selftests/mm: Add test about uprobe pte be orphan during vma merge

 mm/mremap.c                            |  2 ++
 mm/vma.c                               | 20 ++++++++++--
 mm/vma.h                               |  7 +++++
 tools/testing/selftests/mm/ksm_tests.c | 32 ++------------------
 tools/testing/selftests/mm/merge.c     | 42 ++++++++++++++++++++++++++
 tools/testing/selftests/mm/thuge-gen.c |  6 ++--
 tools/testing/selftests/mm/vm_util.c   | 38 +++++++++++++++++++++++
 tools/testing/selftests/mm/vm_util.h   |  2 ++
 8 files changed, 113 insertions(+), 36 deletions(-)

-- 
2.34.1


