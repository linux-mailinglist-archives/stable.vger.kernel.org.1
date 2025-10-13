Return-Path: <stable+bounces-185536-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D3DDBD6A8D
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:48:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 168344E67C5
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58475258ED9;
	Mon, 13 Oct 2025 22:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzNh48bi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1550D1FCF7C
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 22:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395696; cv=none; b=CrYFbZfgZl3IMjzwGybJpAh+HccMyIqU0pXLQ/mZ2oBkWsAAC+8JwOHMYsRHlj/BycCVdx1B9P5TT9AbmFVPD6oa1CJZm4wPaMdFK0f5d4tOjoMvXI9kZHOVmsSm1HgD5jeRdjPN03+JN/5xJJwBQpqPVR7U5UphavL6/nkpgTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395696; c=relaxed/simple;
	bh=B8FCLcr+nfsbpFvJIG62kyxdEgU7kjiopVIXQ6MJQjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e85IWvk6S83ndVRhDt7OXbpp0YlS3OFfhsH/R2m+WKqVsMrRX/iizB9T9tlUfHEvZY9LHj/VBjd4wuVI3BYG7IHnCLxJrXCaehxTxIMFgBmqR4mwBXFJJomyoggpyqkkIinEAZVqkGbvHJTepTQy81hvHOpj9iLTCwOfvrq8SrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzNh48bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8769C113D0;
	Mon, 13 Oct 2025 22:48:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760395695;
	bh=B8FCLcr+nfsbpFvJIG62kyxdEgU7kjiopVIXQ6MJQjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mzNh48bi+rhuN0VRWeeGFWxw3csBGCNZS7Bha1gSdXO7l4oeCcFof88vw5GM66UQD
	 OBQZnB3mWMY19aEXbkYtvmvDJn/2Z4nFhPf7xm+yrhFiAhqkEhn/+OJTwCcYAkLE89
	 auSKU9ux6zEJHMMkD7SHFbQmvddb88+49UaDVOV8N7tLUXIRg5KRmhJvlMqUO1F8NG
	 reLnMswHBZb9nnGwp4b0DX+ixGcvMHETNhDARJ+wiy+hugtNf0thuTMPH9dXxBHi5p
	 2og8caBcWfvZPXqYpJrf8KgS2BeICDnvoj0sQIQDudB7xBSVwyTij1QBXgDvq6mmDT
	 EV1YkAJIhDkNw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] mfd: intel_soc_pmic_chtdc_ti: Drop unneeded assignment for cache_type
Date: Mon, 13 Oct 2025 18:48:11 -0400
Message-ID: <20251013224812.3682599-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013224812.3682599-1-sashal@kernel.org>
References: <2025101306-cufflink-fidgeting-4c7b@gregkh>
 <20251013224812.3682599-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

[ Upstream commit 9eb99c08508714906db078b5efbe075329a3fb06 ]

REGCACHE_NONE is the default type of the cache when not provided.
Drop unneeded explicit assignment to it.

Note, it's defined to 0, and if ever be redefined, it will break
literally a lot of the drivers, so it very unlikely to happen.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20250129152823.1802273-1-andriy.shevchenko@linux.intel.com
Signed-off-by: Lee Jones <lee@kernel.org>
Stable-dep-of: 64e0d839c589 ("mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel_soc_pmic_chtdc_ti.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 8582ae65a8029..4c1a68c9f5750 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -82,7 +82,6 @@ static const struct regmap_config chtdc_ti_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0xff,
-	.cache_type = REGCACHE_NONE,
 };
 
 static const struct regmap_irq chtdc_ti_irqs[] = {
-- 
2.51.0


