Return-Path: <stable+bounces-185552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B76ABD6D01
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 01:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 763FC42023B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A092D2FE599;
	Mon, 13 Oct 2025 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qpXgmJjM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC5526E6FA
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 23:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399787; cv=none; b=KYbHcNTi9dGoDfLAknHGQeOWj4ag7B3T2IPwdfxR1HwCuR8I8iiOzH5BHggAq0XOPMsU2e+tywi11C4OVvnrDl4NTf5oqVNZBkXdJtyW9MIwnsnDO9zvTtFmmShJeuZDpizmaOBYi6JamTamyYRoDzTvqf/Djj3+Yt/ptGC65Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399787; c=relaxed/simple;
	bh=ixWSgdv0V8B1x5iuEtwIBYT1UuRENhdJ1SbbYJc8Onw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PN28VVBDrtRk+UyunxWWW+zkCYCSwnO8/HE/sCtq5WzOYZR6BkjLTImBlA95yZyj5cdRoNuvOUBaynWUWW5ZiUkTRtjBpsXcEthQSUK13VOPRfZMvZ8xjpejdmEKmmEnJ9cm3fn0a5Dwh7jV7dW+JbIe+aRS/BV16wizloq9k38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qpXgmJjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 481E7C116C6;
	Mon, 13 Oct 2025 23:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760399786;
	bh=ixWSgdv0V8B1x5iuEtwIBYT1UuRENhdJ1SbbYJc8Onw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qpXgmJjMXNF7ZrVlt1CD1CIBeUYmCrShEoU14CdNTRp27YjGxNzrfXfadj84m27ar
	 5nQaRqsz/ryHgtPE5Mmxb8SQeny6iQ3aRuS4MatWeM6m/O6zL/H/AcfzO0YUhGbviJ
	 ExyGiV7u7C60hapoLM+kLXOBNcD5YC0HNghOOmgt4JaSLjLphDLYtThuLZ7BRVx6EW
	 cPiDvVD9zdpndz/M8F3DiRKXF7HgCkLon72ZyQ1gU7YmyIgxkmTYiDON2IohImV85X
	 Yj2/3ZbMQbGQbw5NF8yo4b7BXeyYman2yRFtAc0WTWTnbwSUn/9x321PsEtcbDLsqZ
	 AEDvCkfGkQ2hA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] mfd: intel_soc_pmic_chtdc_ti: Drop unneeded assignment for cache_type
Date: Mon, 13 Oct 2025 19:56:22 -0400
Message-ID: <20251013235623.3733198-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013235623.3733198-1-sashal@kernel.org>
References: <2025101315-glue-daylight-739b@gregkh>
 <20251013235623.3733198-1-sashal@kernel.org>
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
index e787d5655a315..31b30a919348c 100644
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


