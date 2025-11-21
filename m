Return-Path: <stable+bounces-195461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D39BFC775B9
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 06:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 198B44E83BD
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 05:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E4A274B34;
	Fri, 21 Nov 2025 05:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="NnUWs73n"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-104.ptr.blmpb.com (sg-1-104.ptr.blmpb.com [118.26.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DCD274FC1
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 05:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763702547; cv=none; b=V4M4ZTe3gLIiHQhLm6Y61PtuXfdlbVM/fTyWzK9BIFwuQv+RR40rr+oYFRQ8fI8rtlGM/yuzBubmLmE0oiVuWYaoWcx7m315+qhi6Lj8lxYw8T1/bpVSXJGJRCiLUlVJtarDkky171PNIrmAICTnsVhXJT/ugxIlLuCCNUPEhnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763702547; c=relaxed/simple;
	bh=M4VtsnFS3sSy6ctKZsdH8NYEQz8AP01hXszZIe6aCUo=;
	h=From:Date:Message-Id:To:Cc:Subject:Mime-Version:Content-Type; b=qY2KclbxHLEeiG/ryTpf9CIkqbsVHo5tRZlQXZZZgAd2S8u0b4skpDS4aKOCqvlW3QZHctR1AuZLJVxklGz5Q9hW5Rz/Ygj9/BICwTAcPucmRMCV9xU4nW/avanR1o9PABpF+ObCsMvGgtggIBJ9hlbjey8Ql06OEFo5gujsOq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=NnUWs73n; arc=none smtp.client-ip=118.26.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1763702530; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=zgEUwj6j5+hC+SG+yzkOo1iggkO8ljJ88NxeBRr45B4=;
 b=NnUWs73n2Gp6uTC8rB8g0DUUBpGcbZPlcBi/mdvT3c2Kq+4e5m1PdAscQIOxEmVWMbV479
 JY6KF57KKY4lkni9WqyMQKr11okQCMTqhg8fXl8xdN2kKvIFd5ZkKkp4f4a6HxJ8E57fT4
 V/h/GsYGtc0L7w21Bw0djYZ3oI7DuTpQWf/q7DjcnMC0otgEspPCLVZR+iuGBtYcQVZCsE
 u8Cgd4As5P5m6/lFuDtIBHfkK22Q1IPIth1sMlhr9lT+S+JWW+zjlY6/qp70LLW1cWuJTd
 JiXTWe7xE7rmxPKoO2cXDMZLyV3tnOjgsr1CpBjd7A+3FovvO+g2jyC9OfTd3Q==
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Date: Fri, 21 Nov 2025 13:21:39 +0800
Message-Id: <20251121052139.550-1-guojinhui.liam@bytedance.com>
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <Ankit.Soni@amd.com>
Cc: <guojinhui.liam@bytedance.com>, <iommu@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2] iommu/amd: Relay __modify_irte_ga() error in modify_irte_ga()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+2691ff700+62217c+vger.kernel.org+guojinhui.liam@bytedance.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The return type of __modify_irte_ga() is int, but modify_irte_ga()
treats it as a bool. Casting the int to bool discards the error code.

To fix the issue, change the type of ret to int in modify_irte_ga().

Fixes: 57cdb720eaa5 ("iommu/amd: Do not flush IRTE when only updating isRun and destination fields")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
---

v1: https://lore.kernel.org/all/20251120154725.435-1-guojinhui.liam@bytedance.com/

Changelog in v1 -> v2 (suggested by Ankit Soni)
 - Trim subject line to the recommanded length

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

