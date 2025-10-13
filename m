Return-Path: <stable+bounces-185547-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0459BD6B9C
	for <lists+stable@lfdr.de>; Tue, 14 Oct 2025 01:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AA8019A234E
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 23:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECDF2C15B4;
	Mon, 13 Oct 2025 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luQ/umcM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB592C0F97
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 23:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760397750; cv=none; b=h5gUhV6AgUvUOXnNcZxewAflcOiRZeDIuxsjC+r2YH7hcqMUUxM3CWZFGfIxAtMaJtV6QDZTjubms1nr/VIPc5rC8GWlufUXs3/BgHZRvTnjx4rZoi3Z3bXZH1CDz3naprL5tgxzNovJWsyPdnQRFfLChdFKav6TkPCiKAi09Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760397750; c=relaxed/simple;
	bh=XcL9QjoRPmBcISaKGc6DA3deq8LonPS0dDzFHw9XF8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JmZf14B9EpbmYAY6o6/gVepxcx2jMisLrRJb0i4gVyg6ryjsL49mCLsggUtLrPw+7i4qn0H1TCHaJHH7j+GgCXgkQevfbBpbHmkTvl6KUgfm8juLTD/B0cNRBHeNk5rH35arRMyGny+UQ/RsLM9n3LoECapDGGxlkDGQgn/zWVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luQ/umcM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811C6C116D0;
	Mon, 13 Oct 2025 23:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760397750;
	bh=XcL9QjoRPmBcISaKGc6DA3deq8LonPS0dDzFHw9XF8k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=luQ/umcMYGbojk/q10umTtIDsEouAq6ASPVqEvPAd1QLZEN/VzeF6Wrozs0NgzdDD
	 chTiwG7Z1UW2rF8+Wq9TIPPaQ0VeOexdoBCq+YVzOBlliVmQbR3ep05K3fCSWyYzLJ
	 LYrtdkkB5Nj/wz0d7i9EzHxE/MFBFsi2TO8qklaOzcZ6fWOwGmAQIPPBB9c8o8cZ0C
	 ALYvC2W/pn+3jnYX/tyQ//qUGw6onB1ZQqiSnEB5+av58ttT8aJ8DLXJmY8Zd22v4P
	 +8mEspbBOOlGf+SdCNRqjqRaPsgj00R80YjA01apLYWw+2n3UQaAhipDGyX1Rf4Qw0
	 BNS70Ho/ziVSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Hans de Goede <hansg@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/3] mfd: intel_soc_pmic_chtdc_ti: Set use_single_read regmap_config flag
Date: Mon, 13 Oct 2025 19:22:24 -0400
Message-ID: <20251013232224.3709547-3-sashal@kernel.org>
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

From: Hans de Goede <hansg@kernel.org>

[ Upstream commit 64e0d839c589f4f2ecd2e3e5bdb5cee6ba6bade9 ]

Testing has shown that reading multiple registers at once (for 10-bit
ADC values) does not work. Set the use_single_read regmap_config flag
to make regmap split these for us.

This should fix temperature opregion accesses done by
drivers/acpi/pmic/intel_pmic_chtdc_ti.c and is also necessary for
the upcoming drivers for the ADC and battery MFD cells.

Fixes: 6bac0606fdba ("mfd: Add support for Cherry Trail Dollar Cove TI PMIC")
Cc: stable@vger.kernel.org
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Hans de Goede <hansg@kernel.org>
Link: https://lore.kernel.org/r/20250804133240.312383-1-hansg@kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/intel_soc_pmic_chtdc_ti.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel_soc_pmic_chtdc_ti.c b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
index 18b763a23df7c..5eb790047a4e1 100644
--- a/drivers/mfd/intel_soc_pmic_chtdc_ti.c
+++ b/drivers/mfd/intel_soc_pmic_chtdc_ti.c
@@ -82,6 +82,8 @@ static const struct regmap_config chtdc_ti_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.max_register = 0xff,
+	/* The hardware does not support reading multiple registers at once */
+	.use_single_read = true,
 };
 
 static const struct regmap_irq chtdc_ti_irqs[] = {
-- 
2.51.0


