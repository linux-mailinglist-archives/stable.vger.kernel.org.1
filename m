Return-Path: <stable+bounces-185546-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C53BD6B99
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 01:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 440E2407D8B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7222C1589;
	Mon, 13 Oct 2025 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RduPvesA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1A62C0F97
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760397749; cv=none; b=U0DbGcgs8CXS4ARxnoyfLHmt6ZRfICahH1wcRbuGHL/vG2ButQ36bzTikD1/ZeIhTkC/zoMcSvzttbvZG8RNGG07l5D9YFF09YwMb+jFVoTocidFnWsXI6gjqaB34yI8g98HummY53GlYNX+6PmTDemuHoXlPuLc/FibG+XBqiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760397749; c=relaxed/simple;
	bh=Usj7W7YhrBcBi5hUb4j7DQXlAOHQYnqyvZH5MsuMpCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gai2z58xdWVz7vbGHeCEGo1E6QEehPEEzKe4YxeegH0tEHQtbAvmFfM0k5JoGBs9mOtjHpmWASo+cSLTOFGGXYQP8Pshbb13BYblRqXSRdg81XQzEZqUfIENv81j+gwa3GoE3XgApCxXF/+5HwVe7cIVAcs1h/CmLawWEWwOk78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RduPvesA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90B5CC113D0;
	Mon, 13 Oct 2025 23:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760397749;
	bh=Usj7W7YhrBcBi5hUb4j7DQXlAOHQYnqyvZH5MsuMpCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RduPvesAxLT2a49bFS+c9npv5eobF674fZnkAoV+WvkKkK2dJ8G4fXrqfpt4c0f12
	 DBhvMTd/ZTPLBR4G/ioEF5Y2Sk1WqZMktdKVDN3ii9crwvV5vUDPdpb0V8CkQqQhyf
	 MT/1XLvCyhsl+vsG3ycFtrd7i93cLqveOXSdKo89XVmTYcnCeBoYAVRMgxvcq9T1eX
	 CN9OnqiO2U58/FdUYxIQHzh/i5hJ4HgVKUQrXE8IrGhkX4g5EoVBbe8pOwILP2Wbfr
	 2igOw75sNwkG3HvSTGm+8qbr2vo6ZzD5qMx7BxozNtevL7vuDCWREuQjnYKxy/5KpF
	 IbtevRENeUUBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] mfd: intel_soc_pmic_chtdc_ti: Drop unneeded assignment for cache_type
Date: Mon, 13 Oct 2025 19:22:23 -0400
Message-ID: <20251013232224.3709547-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013232224.3709547-1-sashal@kernel.org>
References: <2025101308-pedometer-broadness-3e95@gregkh>
 <20251013232224.3709547-1-sashal@kernel.org>
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
index 6864d906d1957..18b763a23df7c 100644
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


