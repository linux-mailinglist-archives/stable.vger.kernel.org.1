Return-Path: <stable+bounces-192904-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 486F5C44FE6
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 06:21:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA663B1F52
	for <lists+stable@lfdr.de>; Mon, 10 Nov 2025 05:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29FA02D77E2;
	Mon, 10 Nov 2025 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N8DvFvAI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FDA2E8DEF;
	Mon, 10 Nov 2025 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762752035; cv=none; b=XqRGVIz2VNEZqIa7HVsDw3NIxUQfxziyKQN7+SkKvgzPDHweH0l7hTLYYq0YgnlTiVDCrXeyY+omOPMiBNcd+SSDS+fVHHTaPA+HVQ1i5jhOCA7Hke5u3RmMX7uLKlhIZlYL7AzMOs50eYquPM/nAfO0QNrGyBfq8czY1WGawXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762752035; c=relaxed/simple;
	bh=7kVfc2iAbnvBJCCDgeISOU8QnmpgokQRSkFAOwkVeV8=;
	h=Date:To:From:Subject:Message-Id; b=PLue1Xq92MD8TTKnuTTnWf0Pph4uSrYj8w8FRXUkKFHCctJeG54eYkPi7bYutGI2fAJ4xd4T3joDXTapf8cFwQWc6Oa262iw0p+zQ5iBwelFroLphNsRcdHzHFVVIMnfoPV2VUCSiBR35+ZpJZ5Cot7dh0gu7iiLcR3xwW79w2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N8DvFvAI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07B4C116D0;
	Mon, 10 Nov 2025 05:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762752035;
	bh=7kVfc2iAbnvBJCCDgeISOU8QnmpgokQRSkFAOwkVeV8=;
	h=Date:To:From:Subject:From;
	b=N8DvFvAI9xn/cLa6OlNf6hHDYd3KYJsDcD2f1j63T1J5oluLitAhwXCZn+c+qmkVm
	 eGtJKtY/VLHOpVEL1Zjn5L6Z5a41hJ/67s/MihUuDEyfe+UtvzJXtktt7t8mNjP/5t
	 0yV6Pwzf3rkRi8T2QrcqpW9cmBgyoOmLYFPub2oA=
Date: Sun, 09 Nov 2025 21:20:35 -0800
To: mm-commits@vger.kernel.org,zuoze1@huawei.com,wangkefeng.wang@huawei.com,stable@vger.kernel.org,sj@kernel.org,yanquanmin1@huawei.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-hotfixes-stable] mm-damon-sysfs-change-next_update_jiffies-to-a-global-variable.patch removed from -mm tree
Message-Id: <20251110052035.B07B4C116D0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>


The quilt patch titled
     Subject: mm/damon/sysfs: change next_update_jiffies to a global variable
has been removed from the -mm tree.  Its filename was
     mm-damon-sysfs-change-next_update_jiffies-to-a-global-variable.patch

This patch was dropped because it was merged into the mm-hotfixes-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Quanmin Yan <yanquanmin1@huawei.com>
Subject: mm/damon/sysfs: change next_update_jiffies to a global variable
Date: Thu, 30 Oct 2025 10:07:46 +0800

In DAMON's damon_sysfs_repeat_call_fn(), time_before() is used to compare
the current jiffies with next_update_jiffies to determine whether to
update the sysfs files at this moment.

On 32-bit systems, the kernel initializes jiffies to "-5 minutes" to make
jiffies wrap bugs appear earlier. However, this causes time_before() in
damon_sysfs_repeat_call_fn() to unexpectedly return true during the first
5 minutes after boot on 32-bit systems (see [1] for more explanation,
which fixes another jiffies-related issue before). As a result, DAMON
does not update sysfs files during that period.

There is also an issue unrelated to the system's word size[2]: if the
user stops DAMON just after next_update_jiffies is updated and restarts
it after 'refresh_ms' or a longer delay, next_update_jiffies will retain
an older value, causing time_before() to return false and the update to
happen earlier than expected.

Fix these issues by making next_update_jiffies a global variable and
initializing it each time DAMON is started.

Link: https://lkml.kernel.org/r/20251030020746.967174-3-yanquanmin1@huawei.com
Link: https://lkml.kernel.org/r/20250822025057.1740854-1-ekffu200098@gmail.com [1]
Link: https://lore.kernel.org/all/20251029013038.66625-1-sj@kernel.org/ [2]
Fixes: d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file internal work")
Suggested-by: SeongJae Park <sj@kernel.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: ze zuo <zuoze1@huawei.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 mm/damon/sysfs.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/mm/damon/sysfs.c~mm-damon-sysfs-change-next_update_jiffies-to-a-global-variable
+++ a/mm/damon/sysfs.c
@@ -1552,16 +1552,17 @@ static struct damon_ctx *damon_sysfs_bui
 	return ctx;
 }
 
+static unsigned long damon_sysfs_next_update_jiffies;
+
 static int damon_sysfs_repeat_call_fn(void *data)
 {
 	struct damon_sysfs_kdamond *sysfs_kdamond = data;
-	static unsigned long next_update_jiffies;
 
 	if (!sysfs_kdamond->refresh_ms)
 		return 0;
-	if (time_before(jiffies, next_update_jiffies))
+	if (time_before(jiffies, damon_sysfs_next_update_jiffies))
 		return 0;
-	next_update_jiffies = jiffies +
+	damon_sysfs_next_update_jiffies = jiffies +
 		msecs_to_jiffies(sysfs_kdamond->refresh_ms);
 
 	if (!mutex_trylock(&damon_sysfs_lock))
@@ -1607,6 +1608,9 @@ static int damon_sysfs_turn_damon_on(str
 	}
 	kdamond->damon_ctx = ctx;
 
+	damon_sysfs_next_update_jiffies =
+		jiffies + msecs_to_jiffies(kdamond->refresh_ms);
+
 	repeat_call_control->fn = damon_sysfs_repeat_call_fn;
 	repeat_call_control->data = kdamond;
 	repeat_call_control->repeat = true;
_

Patches currently in -mm which might be from yanquanmin1@huawei.com are

mm-damon-add-a-min_sz_region-parameter-to-damon_set_region_biggest_system_ram_default.patch
mm-damon-reclaim-use-min_sz_region-for-core-address-alignment-when-setting-regions.patch


