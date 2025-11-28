Return-Path: <stable+bounces-197617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F976C928F2
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 17:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BA3DE3470C1
	for <lists+stable@lfdr.de>; Fri, 28 Nov 2025 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3E1224469E;
	Fri, 28 Nov 2025 16:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="du7gaGS2"
X-Original-To: stable@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E27522F389
	for <stable@vger.kernel.org>; Fri, 28 Nov 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764346752; cv=none; b=peFVO7eX+L7L73OhnT0ACp53aQDU8n5Ts5RehDgAaPr6DEImz7tCIFElR1I6WWiiBvM5w4vpLc41tYxtCU648jmT6g5LIMfBgLaS8ocyyQQLMeFa8ebAM/+S0AWOsWnQ5hslpRLfe5l2cHcs+imqg4A9KHAeXa6Uk2hvd665yic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764346752; c=relaxed/simple;
	bh=BQzEdkpoXexvme6236gcQBYBEHo3/4P69zRqOErPATg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KJVDDsmp8Bwk9J0UNQAQGzVHvpLYbJsebTkijIar/XnlVwsCtoynKmqDI74GDPN+oANY0i48Q6s3x9NwLEDthgSsw4TNRgN7dYmRvsbcbg0zCD5RmpaYGIHgVIPmPy+GSv7pDlztKYlfOcjK8bFZUqGCle7BXDeDFSXrOF/kFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=du7gaGS2; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=kTBCPqMOPdVP7k1B+DzIq7z+N8S7uPQga6yPJGrLbKs=; b=du7gaGS2xkfg7bwxvR6wFI7JiT
	LBL6Az7V3GkmsCalcUKrBSLuFcBrzhLNUbiWIUk2YWf2mPduvKL9TBaBRR8L66qLoHJIw0LYH2dla
	/NPz8peKp+GyjgInBUJueWub7EQcA21gsLAhFrzTEswTDT7DAUUrzfMlgXm53rJqYfWYj3zxod7oM
	U0o9bpwAlyiNuKPpNWxf8hqWvX8IeFuEjpalDY0gI83gBW3cUENs9pUJN7py7/CWadDCuNFGvFPrw
	FUiMK8Idjs/P45mv7uSp1xZZE/QlO2atY9wTrGiwYcgEDdlOc5SJ8Nai/YkMICz6W58S2czjlblze
	5tWcK7pA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vP1BY-0000000DQUP-2RN3;
	Fri, 28 Nov 2025 16:19:04 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Jan Sokolowski <jan.sokolowski@intel.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH] idr: Fix idr_alloc() returning an ID out of range
Date: Fri, 28 Nov 2025 16:18:32 +0000
Message-ID: <20251128161853.3200058-1-willy@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

If you use an IDR with a non-zero base, and specify a range that
lies entirely below the base, 'max - base' becomes very large and
idr_get_free() can return an ID that lies outside of the requested range.

Reported-by: Jan Sokolowski <jan.sokolowski@intel.com>
Reported-by: Koen Koning koen.koning@intel.com
Reported-by: Peter Senna Tschudin peter.senna@linux.intel.com
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/6449
Fixes: 6ce711f27500 (idr: Make 1-based IDRs more efficient)
Cc: stable@vger.kernel.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 lib/idr.c                           |  2 ++
 tools/testing/radix-tree/idr-test.c | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/lib/idr.c b/lib/idr.c
index e2adc457abb4..457430cff8c5 100644
--- a/lib/idr.c
+++ b/lib/idr.c
@@ -40,6 +40,8 @@ int idr_alloc_u32(struct idr *idr, void *ptr, u32 *nextid,
 
 	if (WARN_ON_ONCE(!(idr->idr_rt.xa_flags & ROOT_IS_IDR)))
 		idr->idr_rt.xa_flags |= IDR_RT_MARKER;
+	if (max < base)
+		return -ENOSPC;
 
 	id = (id < base) ? 0 : id - base;
 	radix_tree_iter_init(&iter, id);
diff --git a/tools/testing/radix-tree/idr-test.c b/tools/testing/radix-tree/idr-test.c
index 2f830ff8396c..945144e98507 100644
--- a/tools/testing/radix-tree/idr-test.c
+++ b/tools/testing/radix-tree/idr-test.c
@@ -57,6 +57,26 @@ void idr_alloc_test(void)
 	idr_destroy(&idr);
 }
 
+void idr_alloc2_test(void)
+{
+	int id;
+	struct idr idr = IDR_INIT_BASE(idr, 1);
+
+	id = idr_alloc(&idr, idr_alloc2_test, 0, 1, GFP_KERNEL);
+	assert(id == -ENOSPC);
+
+	id = idr_alloc(&idr, idr_alloc2_test, 1, 2, GFP_KERNEL);
+	assert(id == 1);
+
+	id = idr_alloc(&idr, idr_alloc2_test, 0, 1, GFP_KERNEL);
+	assert(id == -ENOSPC);
+
+	id = idr_alloc(&idr, idr_alloc2_test, 0, 2, GFP_KERNEL);
+	assert(id == -ENOSPC);
+
+	idr_destroy(&idr);
+}
+
 void idr_replace_test(void)
 {
 	DEFINE_IDR(idr);
@@ -409,6 +429,7 @@ void idr_checks(void)
 
 	idr_replace_test();
 	idr_alloc_test();
+	idr_alloc2_test();
 	idr_null_test();
 	idr_nowait_test();
 	idr_get_next_test(0);
-- 
2.47.2


