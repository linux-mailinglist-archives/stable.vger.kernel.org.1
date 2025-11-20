Return-Path: <stable+bounces-195280-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8946EC7528E
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3C83D364F2B
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AC335A954;
	Thu, 20 Nov 2025 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="JKhNmBLs"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-109.ptr.blmpb.com (sg-1-109.ptr.blmpb.com [118.26.132.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E8F2E1EE5
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.109
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763653676; cv=none; b=iztgNgU3c5oxw4mNAzhUXSL1ykrYMyFTF2cWngtPWO69vuNA2+vhQkMbM2K5oj6Jvho1oLfRyzj6wQePWTj0+DOksH4W9LAcddNhw79tSmeJwv4ckXKWQEO8ovsX32cVfKOOWEs2vzyNXeEmErD/VYPnRxgjj0nUTRKbQU2AB+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763653676; c=relaxed/simple;
	bh=zdTEn0O/J36J8UqLQeFaRty83CHTcnreU5erwZ7OJ84=;
	h=To:From:Subject:Mime-Version:Content-Type:Cc:Date:Message-Id; b=qj5DrKF4GWKS1mNkTaKvnnco+dU/gcx/NNvW3TLAlCND/r/u75pABDYaVaGTxQO8tX0YRzJfEysIiJFscz0wGhKkWzmd5RoKXckBj4iWWaRdUWfZCajT0rlE3W3A4LhPZ6Aw+IOMAcsMfOwgSMzgHYqe+3y0O2GmGdIqZUBMYWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=JKhNmBLs; arc=none smtp.client-ip=118.26.132.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1763653667; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=w7KQNIS4KvyAgzeaI3AFA+HnGPm5Ojc2cIZQaHEZ5KE=;
 b=JKhNmBLsChKWseQEaiJDuHvxugemKUDo1Pc918cv0jOnfV2kRmI1us/Y78fvbQ4GAUXb/r
 QHCY9Wh2OKAYAKrktuXKGz/lYU4m1C1Y9KdPkimZ/1TwgjupUgSy31WN8oT7P3dLfCdRYQ
 BUYZFZzMxbputFg9crlSWkl5W8tj0u7NdweqdPT/+NkIy27a5+52VO7Yinv9yK4Dvl6wg4
 z6Cy5Gh6EH5k8Oc67wldPgBDTZPiO3VLElZ54Fx1Q/9mbOa7VXGBRho4zdtAoEVCiqHRTO
 Ws/5HAmIc3xuoRlbYTX9p8hThLCZTj3NxXhxp+0iSbsuSMmUvGA0by/Yb9TPUg==
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Subject: [PATCH] iommu/amd: Propagate the error code returned by __modify_irte_ga() in modify_irte_ga()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Cc: <guojinhui.liam@bytedance.com>, <iommu@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Date: Thu, 20 Nov 2025 23:47:25 +0800
Message-Id: <20251120154725.435-1-guojinhui.liam@bytedance.com>
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+2691f3821+2c636e+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: 7bit

The return type of __modify_irte_ga() is int, but modify_irte_ga()
treats it as a bool. Casting the int to bool discards the error code.

To fix the issue, change the type of ret to int in modify_irte_ga().

Fixes: 57cdb720eaa5 ("iommu/amd: Do not flush IRTE when only updating isRun and destination fields")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
---
 drivers/iommu/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e1865daa1ce..a38304f1a8df 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3354,7 +3354,7 @@ static int __modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 static int modify_irte_ga(struct amd_iommu *iommu, u16 devid, int index,
 			  struct irte_ga *irte)
 {
-	bool ret;
+	int ret;
 
 	ret = __modify_irte_ga(iommu, devid, index, irte);
 	if (ret)
-- 
2.20.1

