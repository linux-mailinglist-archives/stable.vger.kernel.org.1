Return-Path: <stable+bounces-185543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFD0BD6B2F
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 01:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC2F40566B
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F31DF2FB628;
	Mon, 13 Oct 2025 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cikDuERW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D7A2E06ED
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 23:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760396867; cv=none; b=Qu04J7bfovJhBImvhgptEUbSFRw7JPmlNBeD4koGv14iTAlcQZlalDTUOac4gY0UhX8w2U1HIX2hrJ4h0VFxeZx1UJIXAC27T9fdSujlytCGd9FxgYxmnbLtK1oFuA8BIqho5Gyn0ovr2L4z1pqvojmBz1HezkjzPHDASvDGrQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760396867; c=relaxed/simple;
	bh=r4sQFHdAk+pmt1aNqxCCsliIuTjKs9SYXduABcsBWRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rpv0iKCYLaPTfJx6/lwflhDOog9nBAW6+I+yjW2J9jxKcc8trqN4QzhMn9F8irKizI2uRZnNJvfTkpfFAAq8EJgKSl+2CateZWJWuWvS6+BEq0S4BSE1bYgh6ZDjOwsyI1y0I/PUb2BfVvLqOWhbu9jpoPqTneqU6jQlE2xcvjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cikDuERW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A92C113D0;
	Mon, 13 Oct 2025 23:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760396867;
	bh=r4sQFHdAk+pmt1aNqxCCsliIuTjKs9SYXduABcsBWRY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cikDuERWbRypNcDUQzEHQxFe5iKV9MWmnmEZyTA0UMMQ6Pskeb43+QN96uf9pPZqZ
	 dqP/biJqKOJzoZKbxAk5KT91DM5Q1h8GKN2FYzIA4VbCrZl/IVrHG3dW21zQzwHufD
	 XjRG+EFYepFtllHFzLCHjg8/n+Y7IU6rdAE8HkD3bLpJqUIizvVKvKRcnMkK1CmsoB
	 4K5sYtPnZYzm2H37zKoeDrgz/5vPOJy7TBTakYujiMTz1LKpa4oDHTVqD8qgf+gZ7q
	 x3tUa4nrcP/AqB1gPLLOAEjOqBS/SEEk2NVjEnr0RWMOYqHci4kc1q0PRjVt3gk7KT
	 2q3kYUyxGL+fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] mfd: intel_soc_pmic_chtdc_ti: Drop unneeded assignment for cache_type
Date: Mon, 13 Oct 2025 19:07:43 -0400
Message-ID: <20251013230744.3697280-2-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251013230744.3697280-1-sashal@kernel.org>
References: <2025101307-little-reseal-5a13@gregkh>
 <20251013230744.3697280-1-sashal@kernel.org>
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
index 0387d7b843e75..4027dc3d995ff 100644
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


