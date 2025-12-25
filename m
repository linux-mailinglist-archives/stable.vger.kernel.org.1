Return-Path: <stable+bounces-203391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7C3CDD39A
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 03:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A488E3025F86
	for <lists+stable@lfdr.de>; Thu, 25 Dec 2025 02:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C66F526B755;
	Thu, 25 Dec 2025 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uEWInZVt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C51D2638BC;
	Thu, 25 Dec 2025 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766629849; cv=none; b=MWqXPTFnY2crm8DDHn/8ovXcZMtvex6Gjjx/bRDtTBXhhT+iMiwE1AhAwgEmFy1c4uYCDJll9e5Zcl0kkWJjj1TNWAd+sR0MS0eq9m+vmP/vYlCIj32FeJVhr8KAl2Q5YG/4bAEsdYXb4it8YVAl/Cw0U+OjGiYM5ZMavh3nwtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766629849; c=relaxed/simple;
	bh=uCpoE/Jqb55vNr00kSEg/jQImas43u/CkKNXRFT/dX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K0AbrweoDmnV34l0PGa4jn87jqa+DaT6tYVuyDe9tInqtSB+IrkUvTLOdptmUEUQjbZP1oD91ls78vv5Mpqu0U24Sy4d9OYLYOi0YZnVUNg4312V7Wy0m1vkJu3KnQNuL/Dd3xwhnJieMuo26qJDr3DE0wPu1VYKpbjHBSo50rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uEWInZVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A3C5C19421;
	Thu, 25 Dec 2025 02:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766629849;
	bh=uCpoE/Jqb55vNr00kSEg/jQImas43u/CkKNXRFT/dX0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uEWInZVtCJTE18Lw5f2GG6oaCBPdA36k9wlDxYkCYl6oTZ1U7jl40RyUuuDDyqxq+
	 1DdTcRYUgw7Z4IadWoaPWX1Y08pe/S3fqM5sSMtrDPANa16QFdQi99SnWXe1LDlsHt
	 g/Pi1B2px2xVjlI4z3nVxXzdsZrdIcxYqXTlnXtgQAx77BiYjjs9eRUDQerBpLo/M9
	 6NpCeIHIMlDPp4fv0iOapXuESM7xzNCVuXGaCORZ5+aR1PPGQWFqEh85iJNd+1ZLtp
	 S1kpDAlx1GCQRSgntDCTz0Uh5VDZeEInV2cWvB1v19Htu5x2FRz1ScmubbkqE8s3UP
	 hS9ARSMsVnfmQ==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 5 . 18 . x" <stable@vger.kernel.org>,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/4] mm/damon/sysfs: cleanup attrs subdirs on context dir setup failure
Date: Wed, 24 Dec 2025 18:30:35 -0800
Message-ID: <20251225023043.18579-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251225023043.18579-1-sj@kernel.org>
References: <20251225023043.18579-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a context DAMON sysfs directory setup is failed after setup of
attrs/ directory, subdirectories of attrs/ directory are not cleaned up.
As a result, DAMON sysfs interface is nearly broken until the system
reboots, and the memory for the unremoved directory is leaked.

Cleanup the directories under such failures.

Fixes: c951cd3b8901 ("mm/damon: implement a minimal stub for sysfs-based DAMON interface")
Cc: <stable@vger.kernel.org> # 5.18.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index a669de068770..95fd9375a7d8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -950,7 +950,7 @@ static int damon_sysfs_context_add_dirs(struct damon_sysfs_context *context)
 
 	err = damon_sysfs_context_set_targets(context);
 	if (err)
-		goto put_attrs_out;
+		goto rmdir_put_attrs_out;
 
 	err = damon_sysfs_context_set_schemes(context);
 	if (err)
@@ -960,7 +960,8 @@ static int damon_sysfs_context_add_dirs(struct damon_sysfs_context *context)
 put_targets_attrs_out:
 	kobject_put(&context->targets->kobj);
 	context->targets = NULL;
-put_attrs_out:
+rmdir_put_attrs_out:
+	damon_sysfs_attrs_rm_dirs(context->attrs);
 	kobject_put(&context->attrs->kobj);
 	context->attrs = NULL;
 	return err;
-- 
2.47.3

