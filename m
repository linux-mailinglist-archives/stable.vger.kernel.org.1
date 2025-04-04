Return-Path: <stable+bounces-128335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679AAA7C0EE
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 17:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2792017AC18
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 15:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C271DF962;
	Fri,  4 Apr 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="dmAcv2nD"
X-Original-To: stable@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F0D282EB
	for <stable@vger.kernel.org>; Fri,  4 Apr 2025 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743781697; cv=none; b=uQjBubnpdBbObFa+4ba2LIQ0b4hfgUDKPXawk0sZdT3pS8c3iQprKluqy5rz5vGO0vSOb8vB/jbwXmAdfiVOy6+G5LsXeZW41wGMEgh1Wxedb6KHIKALi+2Hu+jX/BKcfBPeqhcJsTdN0QAW0EJoBv7ON1udeFkNjpewKhFHMSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743781697; c=relaxed/simple;
	bh=8r1m9fc+vyqVKOYV7zCfY2tdVy2wsncIAcvQu6UVnx0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XcOGbzGlGbkEYI32W7q98Ee7APXH2P5TSR2efuQanwVmZjovNqKg58aXDt1M8srYORxmxHXEhJj8aCTB0kSDaSX4FHmhx6qpgyGPJ04o+zYVd3iMAXUBFv8T4zZyiB5RN5eAtexAcZAiLo2tBO3YtHtvLGv7MEM44YezakSytHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=dmAcv2nD; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1743781697; x=1775317697;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HJuLRb5tEILCIYDX6pf4P+o6kjU6peS9V7uJ4PrbV1E=;
  b=dmAcv2nDMkj/FG0rhO5u4JUwy46MXS7VeSU6/RXJkR/xE6SQvjqDqMYS
   xOwWBCXpocW+sCFs1wdqKUqlci2FmhCYy0AWGEc1kfADCGmg5Qh1WaW0r
   M1GLyUtUyYVjehH+EaRJyf227oUKA282gcQl78/21/DaD6mnoSHrO2VJ9
   w=;
X-IronPort-AV: E=Sophos;i="6.15,188,1739836800"; 
   d="scan'208";a="813448003"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2025 15:48:10 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:58115]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.46.175:2525] with esmtp (Farcaster)
 id 12a29dab-f828-4acf-92e1-4489dc61422c; Fri, 4 Apr 2025 15:48:08 +0000 (UTC)
X-Farcaster-Flow-ID: 12a29dab-f828-4acf-92e1-4489dc61422c
Received: from EX19D023EUB003.ant.amazon.com (10.252.51.5) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 4 Apr 2025 15:48:08 +0000
Received: from dev-dsk-dssauerw-1b-2c5f429c.eu-west-1.amazon.com
 (10.13.238.31) by EX19D023EUB003.ant.amazon.com (10.252.51.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1544.14; Fri, 4 Apr 2025 15:48:05 +0000
From: David Sauerwein <dssauerw@amazon.de>
To: <stable@vger.kernel.org>
CC: Miaohe Lin <linmiaohe@huawei.com>, David Hildenbrand <david@redhat.com>,
	Dan Williams <dan.j.williams@intel.com>, Alistair Popple
	<apopple@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>, "Linus
 Torvalds" <torvalds@linux-foundation.org>, Sasha Levin <sashal@kernel.org>,
	David Sauerwein <dssauerw@amazon.de>
Subject: [PATCH 5.10.y] kernel/resource: fix kfree() of bootmem memory again
Date: Fri, 4 Apr 2025 15:47:40 +0000
Message-ID: <20250404154740.33979-1-dssauerw@amazon.de>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA002.ant.amazon.com (10.13.139.11) To
 EX19D023EUB003.ant.amazon.com (10.252.51.5)

From: Miaohe Lin <linmiaohe@huawei.com>

[ Upstream commit 0cbcc92917c5de80f15c24d033566539ad696892 ]

Since commit ebff7d8f270d ("mem hotunplug: fix kfree() of bootmem
memory"), we could get a resource allocated during boot via
alloc_resource().  And it's required to release the resource using
free_resource().  Howerver, many people use kfree directly which will
result in kernel BUG.  In order to fix this without fixing every call
site, just leak a couple of bytes in such corner case.

Link: https://lkml.kernel.org/r/20220217083619.19305-1-linmiaohe@huawei.com
Fixes: ebff7d8f270d ("mem hotunplug: fix kfree() of bootmem memory")
Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Suggested-by: David Hildenbrand <david@redhat.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alistair Popple <apopple@nvidia.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: David Sauerwein <dssauerw@amazon.de>
---
 kernel/resource.c | 41 ++++++++---------------------------------
 1 file changed, 8 insertions(+), 33 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 1087f33d70c4..ea4d7a02b8e8 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -53,14 +53,6 @@ struct resource_constraint {
 
 static DEFINE_RWLOCK(resource_lock);
 
-/*
- * For memory hotplug, there is no way to free resource entries allocated
- * by boot mem after the system is up. So for reusing the resource entry
- * we need to remember the resource.
- */
-static struct resource *bootmem_resource_free;
-static DEFINE_SPINLOCK(bootmem_resource_lock);
-
 static struct resource *next_resource(struct resource *p, bool sibling_only)
 {
 	/* Caller wants to traverse through siblings only */
@@ -149,36 +141,19 @@ __initcall(ioresources_init);
 
 static void free_resource(struct resource *res)
 {
-	if (!res)
-		return;
-
-	if (!PageSlab(virt_to_head_page(res))) {
-		spin_lock(&bootmem_resource_lock);
-		res->sibling = bootmem_resource_free;
-		bootmem_resource_free = res;
-		spin_unlock(&bootmem_resource_lock);
-	} else {
+	/**
+	 * If the resource was allocated using memblock early during boot
+	 * we'll leak it here: we can only return full pages back to the
+	 * buddy and trying to be smart and reusing them eventually in
+	 * alloc_resource() overcomplicates resource handling.
+	 */
+	if (res && PageSlab(virt_to_head_page(res)))
 		kfree(res);
-	}
 }
 
 static struct resource *alloc_resource(gfp_t flags)
 {
-	struct resource *res = NULL;
-
-	spin_lock(&bootmem_resource_lock);
-	if (bootmem_resource_free) {
-		res = bootmem_resource_free;
-		bootmem_resource_free = res->sibling;
-	}
-	spin_unlock(&bootmem_resource_lock);
-
-	if (res)
-		memset(res, 0, sizeof(struct resource));
-	else
-		res = kzalloc(sizeof(struct resource), flags);
-
-	return res;
+	return kzalloc(sizeof(struct resource), flags);
 }
 
 /* Return the conflict entry if you can't request it */
-- 
2.47.1


