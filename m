Return-Path: <stable+bounces-195504-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A0EC791C6
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 14:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 318842CF84
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 13:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8751A346A06;
	Fri, 21 Nov 2025 13:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="pTE+HjV/"
X-Original-To: stable@vger.kernel.org
Received: from sg-1-104.ptr.blmpb.com (sg-1-104.ptr.blmpb.com [118.26.132.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35FED25A334
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 13:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=118.26.132.104
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763730175; cv=none; b=FmZvJh3a5X5z9Skscf0eavNY0JxcGHzC7k+DT327YS3fhwM1IA8fWM1Y3RgN4jadwBmZ4/x7OPJOBPh2NrVJ1JQoYpaWBaNTlRwN3LPoaFQNlzBTKlwfWiu0RQVZfI816SpogTiwbFz/FWuSRwFC26oAO0feLMiNd+5CfCsQ+xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763730175; c=relaxed/simple;
	bh=cfFFqilnkQu/kzlf7NrtjgkJi+yymMY8m10CbV5jgwY=;
	h=Subject:Message-Id:Mime-Version:To:Cc:From:Date:Content-Type; b=nRdIT027DkweKYKrU1N8g317oNc0RV3NbKQm8DKVVuVTIxhxOot3C51zuAim6Jt2zzsZ1YkTwmqXTDCXnCAjiXMw/TI1kIEskE95xB/OrGkOH4QQLlfw1wTVarqEiK3IcqCGM+gf5yul2CB26GgOQhK877FAFdNMvB4E2dZY1ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=pTE+HjV/; arc=none smtp.client-ip=118.26.132.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1763730160; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=NV8RfohFlS2KhybzdMZg6sYbvF00S7VGZDxggHg1Rs8=;
 b=pTE+HjV/LkBw8y9VZkzCE907vcF/7yPUKGowcW/4wp7lYe8MypnAWITDA8bTDgqpMEiO36
 r2w8yzMP5+X3KK2gz2lFGaeoPHRSy0gIAkFXuAE9l6PbWaKn1TrE0k9f2NsMenZphq8XGB
 gOocUJhH7ZbDA1uc1Dewf2rUUF8SLmQR2RUygBm0TLxhZ8oYq06XQ5hud2d7QEo8FVqch/
 7tjLXTWKmgdKr68eV1mN/Gv1g+0XCDjRdZJDruglED9mEsElyWe0S9dZVBd3A39V5/fIs1
 g8VJl0MdiK4BCUEHhS0u0CoaZqnOWUD8k3a2YGeZYQEG9adROEpzFm8xghyCLg==
Subject: [PATCH v3] iommu/amd: Relay __modify_irte_ga() error in modify_irte_ga()
Message-Id: <20251121130217.764-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Jinhui Guo <guojinhui.liam@bytedance.com>
X-Lms-Return-Path: <lba+2692062ee+082345+vger.kernel.org+guojinhui.liam@bytedance.com>
Content-Transfer-Encoding: 7bit
To: <joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <Ankit.Soni@amd.com>, 
	<vasant.hegde@amd.com>
Cc: <guojinhui.liam@bytedance.com>, <iommu@lists.linux.dev>, 
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
From: "Jinhui Guo" <guojinhui.liam@bytedance.com>
Date: Fri, 21 Nov 2025 21:02:17 +0800
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain; charset=UTF-8

The return type of __modify_irte_ga() is int, but modify_irte_ga()
treats it as a bool. Casting the int to bool discards the error code.

To fix the issue, change the type of ret to int in modify_irte_ga().

Fixes: 57cdb720eaa5 ("iommu/amd: Do not flush IRTE when only updating isRun and destination fields")
Cc: stable@vger.kernel.org
Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
Reviewed-by: Vasant Hegde <vasant.hede@amd.com>
---

v1: https://lore.kernel.org/all/20251120154725.435-1-guojinhui.liam@bytedance.com/
v2: https://lore.kernel.org/all/20251121052139.550-1-guojinhui.liam@bytedance.com/

Changelog in v1 -> v2 (suggested by Ankit Soni)
 - Trim subject line to the recommanded length
Changelog in v2 -> v3
 - Add Reviewed-by Vasant Hegde; no code changes

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

