Return-Path: <stable+bounces-71681-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A16D967024
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 09:38:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E86252819AA
	for <lists+stable@lfdr.de>; Sat, 31 Aug 2024 07:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38DF16F0D0;
	Sat, 31 Aug 2024 07:38:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098F14D28F;
	Sat, 31 Aug 2024 07:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725089881; cv=none; b=tvVM1kfZa62ZPAFVUJDw+2B7Qmoifm/KDW5iYu++xJSiVbz3ASvogXbbLXeMwDAf3TcKo9+LFq5cNl/kJZVlCNuGpyues/hy8vOdacwNfIwA5CjrOH+/dyDyp/L7/slEaYx3epd3ZgONq6LF6tlcuTRrfF76pOUTq6laJCl+Qms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725089881; c=relaxed/simple;
	bh=0t6r8K4+BuzINWItainCjUJV4Y8eunJfwWqFqylvwB8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=a9N85GHhiw+bI0Mc1pU4kkt8P4DxeM04vx35UlwbW5iNDtwdypglaCvS4IL5Op8uVUJaDz6dYrh7Gu1atvrNFfDBeHNMqkDUWxTgbxgRxUnYpWPRKcF+n4YukLr2gxAZgjq/v5Qe2lNt7ZC+Z1ObigU599OB6pnQgzig/Xq0Fvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wwn152q39z4f3jjw;
	Sat, 31 Aug 2024 15:37:45 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7B27B1A12E5;
	Sat, 31 Aug 2024 15:37:55 +0800 (CST)
Received: from huaweicloud.com (unknown [10.67.174.193])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4VQyNJmLLDdDA--.28814S4;
	Sat, 31 Aug 2024 15:37:54 +0800 (CST)
From: Luo Gengkun <luogengkun@huaweicloud.com>
To: peterz@infradead.org
Cc: mingo@redhat.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	kan.liang@linux.intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	luogengkun@huaweicloud.com
Subject: [PATCH v5 0/2] Fix perf adjust period algorithm
Date: Sat, 31 Aug 2024 07:43:14 +0000
Message-Id: <20240831074316.2106159-1-luogengkun@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXv4VQyNJmLLDdDA--.28814S4
X-Coremail-Antispam: 1UD129KBjvdXoWrKw47tFW7GrWxGr1rZr43Jrb_yoWkArgE9r
	17AFy0kwn7WF40ga4IyF45tasYkrWUAr1FkF1UtryagwnFyry8GF4kJFyrArnxGa1FqryD
	J3Z8ArnYvr1ayjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb3kFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1x
	MIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIda
	VFxhVjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5oxrwvpqjn3046kxt4xhlfz01xgou0bp/

---
Changes in v5:
1. Read the time once at the beginning instead of each loop
2. Add reviewed by
Link to v4: https://lore.kernel.org/all/20240821134227.577544-1-luogengkun@huaweicloud.com/

Changes in v4:
1. Rebase the patch 
2. Tidy up the commit message
3. Modify the code style
Link to v3: https://lore.kernel.org/all/20240810102406.1190402-1-luogengkun@huaweicloud.com/

Changes in v3:
1. Replace perf_clock with jiffies in perf_adjust_freq_unthr_context
Link to v2: https://lore.kernel.org/all/20240417115446.2908769-1-luogengkun@huaweicloud.com/

Changes in v2:
1. Add reviewed by for perf/core: Fix small negative period being ignored
2. Add new patch perf/core: Fix incorrected time diff in tick adjust period
Link to v1: https://lore.kernel.org/all/20240116083915.2859302-1-luogengkun2@huawei.com/
---

Luo Gengkun (2):
  perf/core: Fix small negative period being ignored
  perf/core: Fix incorrect time diff in tick adjust period

 include/linux/perf_event.h |  1 +
 kernel/events/core.c       | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.34.1


