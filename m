Return-Path: <stable+bounces-185531-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21389BD6A5A
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 00:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2CC1887FCA
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 22:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A82A258ED9;
	Mon, 13 Oct 2025 22:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cdh/6x9s"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2322D30ACE5
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 22:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760395020; cv=none; b=RYwHn6nh1Lg4X89+mE5cRjBO+2VP98VgI4BuroRXpaO66IhtkcVbSQ63xZezTO6tFLQ7nbmI213LJQifAO2oKinmEXRE2joKQ7G3njf301JmkHOaUoD7SIM1R92ebhBjbE6mDiSaq6Xchs6TXMD2jrgYtvuyuU/oHi4ZJbx0WrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760395020; c=relaxed/simple;
	bh=B8FCLcr+nfsbpFvJIG62kyxdEgU7kjiopVIXQ6MJQjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZBvCiWVa/SNHdw/u73PrlLmI13Nn1xiT7WsFXpHisDw1JlMNQ/d+k0u0xrXGSuoosvohLo1EtjR38Yz3uz/J5gZ7Vql1xHu2QhszupP1ZH7mAvSowdIb/CV2QWr6mmhEQNEmW9Vn832GRBdtnRBwoiF1YcLbWaJNN2mTJXNcHR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cdh/6x9s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D0B2C116C6;
	Mon, 13 Oct 2025 22:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760395019;
	bh=B8FCLcr+nfsbpFvJIG62kyxdEgU7kjiopVIXQ6MJQjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cdh/6x9siJwWN1ZXHgrJVCR6xxV1r2lSAeqr2Ds5B3nh6uO+D1aAjFWRSS90+F8Nq
	 iSVbI9v4a4GVrnLaILKBIZQCeXfftHHayfUaLv183AOktJ+FdNj+bA9ZLeLsF7lv4X
	 nTh8eFxXJCGPTyhvZNxlW38cAlMYvq1EJrDEg5m7X16rghi1l/K7x9pFNdVdWJsb1d
	 JmQq3250tleyRADeBtFHmoUZ0D9TKygayseGI4CDa/tJeiVEoYJVVBiGh3Eg3WjkYV
	 eZJrFTBvajqfhJPk7rHjg0SQJpfM9KCHWLbMM9PEQF73r6jOh2RjEa7+3CGcGMVdL1
	 QppWBRi0wV7EA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] mfd: intel_soc_pmic_chtdc_ti: Drop unneeded assignment for cache_type
Date: Mon, 13 Oct 2025 18:36:55 -0400
Message-ID: <20251013223656.3673902-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013223656.3673902-1-sashal@kernel.org>
References: <2025101305-cheek-copartner-c523@gregkh>
 <20251013223656.3673902-1-sashal@kernel.org>
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


