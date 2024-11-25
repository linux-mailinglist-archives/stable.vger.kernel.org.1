Return-Path: <stable+bounces-95422-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A20B9D8A30
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 17:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCEA4162475
	for <lists+stable@lfdr.de>; Mon, 25 Nov 2024 16:22:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701021B415D;
	Mon, 25 Nov 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fbpft8Qj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2540C1B4F09
	for <stable@vger.kernel.org>; Mon, 25 Nov 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732551753; cv=none; b=s2s00QvaTTK94MJeTFlrq40kGQi44wUQVgiH9h00QNwmB5vauy5AspC+0at791CZJTUMDnG78pUG0bBZnsevxqJCWylDqDNKjnvN80+TFpi8fjOgdY5o2+4kUN1l8QdJtLtfhW1aHUoch+lAhFjT3HKN/p7iEOSv2pEWIrp0peE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732551753; c=relaxed/simple;
	bh=IwvqIyZdsYQgL+hFzDR2DtKRLoaF/kSW/bZjJEqb3/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5b7N1kwGfUurzSAEF4O8BkfD4n9s2VI8NJMDwAx6QbVCfTdA7UY4/MYN6+AgbJ8vfQr7O+G22aed+zrqiWAPXbK7U7pk9BAp54EJcRe5FTZsE73ALvDXmLaxn9y9hC24qoSo6LadtnYxA1C1tFNiuULYEErwNDR7tFbTkWaCvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fbpft8Qj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E9D6C4CECE;
	Mon, 25 Nov 2024 16:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732551752;
	bh=IwvqIyZdsYQgL+hFzDR2DtKRLoaF/kSW/bZjJEqb3/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fbpft8QjKEGUswv7xUbdStLcX9jCFPszwD1cxxXgZkiQGupDK7wwyaIqubINGhQTm
	 E/HclOUdFpobxRAd/LC26Nc6JgZrbl7Tv0YKyQ838r3TSsFts3JXQAqZA8S8rYMnVt
	 EHHYkqIT9iNLQWpFv4FrsS80gXZ9hcIhsLzZwTGX2YR+E+yvONhhaGaAhgSJdT/FTx
	 vOT73CYSn/90B0y2ug4WAS+2bjI/2o85gE/4Uo0XZgQmg3sO/d5iP2dIMlooIRNsPy
	 RhZWsI4hvZwjEpxyrDAu91jieV3s9eYRssdHnmTFZiGmsT5wV+dy3AGcGwU7jAkffS
	 QsbqltIZuh2Vg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: jguittet.opensource@witekio.com,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.15] Revert "drivers: clk: zynqmp: update divider round rate logic"
Date: Mon, 25 Nov 2024 11:22:30 -0500
Message-ID: <20241125111736-421120d2bcfea06b@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241125160959.3522094-1-jguittet.opensource@witekio.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: 1fe15be1fb613534ecbac5f8c3f8744f757d237d

WARNING: Author mismatch between patch and upstream commit:
Backport author: jguittet.opensource@witekio.com
Commit author: Jay Buddhabhatti <jay.buddhabhatti@amd.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.11.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 37b67480609f)
6.1.y | Present (different SHA1: c249ef9d0978)
5.15.y | Present (different SHA1: 9117fc44fd3a)

Note: The patch differs from the upstream commit:
---
--- -	2024-11-25 11:13:15.044326187 -0500
+++ /tmp/tmp.qTmzowaD8e	2024-11-25 11:13:15.035746470 -0500
@@ -1,108 +1,108 @@
-Currently zynqmp divider round rate is considering single parent and
-calculating rate and parent rate accordingly. But if divider clock flag
-is set to SET_RATE_PARENT then its not trying to traverse through all
-parent rate and not selecting best parent rate from that. So use common
-divider_round_rate() which is traversing through all clock parents and
-its rate and calculating proper parent rate.
+This reverts commit 9117fc44fd3a9538261e530ba5a022dfc9519620 which is
+commit 1fe15be1fb613534ecbac5f8c3f8744f757d237d upstream.
 
-Fixes: 3fde0e16d016 ("drivers: clk: Add ZynqMP clock driver")
-Signed-off-by: Jay Buddhabhatti <jay.buddhabhatti@amd.com>
-Link: https://lore.kernel.org/r/20231129112916.23125-3-jay.buddhabhatti@amd.com
-Signed-off-by: Stephen Boyd <sboyd@kernel.org>
+It is reported to cause regressions in the 5.15.y tree, so revert it for
+now.
+
+Link: https://www.spinics.net/lists/kernel/msg5397998.html
+Signed-off-by: Joel Guittet <jguittet.opensource@witekio.com>
 ---
- drivers/clk/zynqmp/divider.c | 66 +++---------------------------------
- 1 file changed, 5 insertions(+), 61 deletions(-)
+ drivers/clk/zynqmp/divider.c | 66 +++++++++++++++++++++++++++++++++---
+ 1 file changed, 61 insertions(+), 5 deletions(-)
 
 diff --git a/drivers/clk/zynqmp/divider.c b/drivers/clk/zynqmp/divider.c
-index 33a3b2a226595..5a00487ae408b 100644
+index e25c76ff2739..47a199346ddf 100644
 --- a/drivers/clk/zynqmp/divider.c
 +++ b/drivers/clk/zynqmp/divider.c
-@@ -110,52 +110,6 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
+@@ -110,6 +110,52 @@ static unsigned long zynqmp_clk_divider_recalc_rate(struct clk_hw *hw,
  	return DIV_ROUND_UP_ULL(parent_rate, value);
  }
  
--static void zynqmp_get_divider2_val(struct clk_hw *hw,
--				    unsigned long rate,
--				    struct zynqmp_clk_divider *divider,
--				    u32 *bestdiv)
--{
--	int div1;
--	int div2;
--	long error = LONG_MAX;
--	unsigned long div1_prate;
--	struct clk_hw *div1_parent_hw;
--	struct zynqmp_clk_divider *pdivider;
--	struct clk_hw *div2_parent_hw = clk_hw_get_parent(hw);
--
--	if (!div2_parent_hw)
--		return;
--
--	pdivider = to_zynqmp_clk_divider(div2_parent_hw);
--	if (!pdivider)
--		return;
--
--	div1_parent_hw = clk_hw_get_parent(div2_parent_hw);
--	if (!div1_parent_hw)
--		return;
--
--	div1_prate = clk_hw_get_rate(div1_parent_hw);
--	*bestdiv = 1;
--	for (div1 = 1; div1 <= pdivider->max_div;) {
--		for (div2 = 1; div2 <= divider->max_div;) {
--			long new_error = ((div1_prate / div1) / div2) - rate;
--
--			if (abs(new_error) < abs(error)) {
--				*bestdiv = div2;
--				error = new_error;
--			}
--			if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
--				div2 = div2 << 1;
--			else
--				div2++;
--		}
--		if (pdivider->flags & CLK_DIVIDER_POWER_OF_TWO)
--			div1 = div1 << 1;
--		else
--			div1++;
--	}
--}
--
++static void zynqmp_get_divider2_val(struct clk_hw *hw,
++				    unsigned long rate,
++				    struct zynqmp_clk_divider *divider,
++				    u32 *bestdiv)
++{
++	int div1;
++	int div2;
++	long error = LONG_MAX;
++	unsigned long div1_prate;
++	struct clk_hw *div1_parent_hw;
++	struct zynqmp_clk_divider *pdivider;
++	struct clk_hw *div2_parent_hw = clk_hw_get_parent(hw);
++
++	if (!div2_parent_hw)
++		return;
++
++	pdivider = to_zynqmp_clk_divider(div2_parent_hw);
++	if (!pdivider)
++		return;
++
++	div1_parent_hw = clk_hw_get_parent(div2_parent_hw);
++	if (!div1_parent_hw)
++		return;
++
++	div1_prate = clk_hw_get_rate(div1_parent_hw);
++	*bestdiv = 1;
++	for (div1 = 1; div1 <= pdivider->max_div;) {
++		for (div2 = 1; div2 <= divider->max_div;) {
++			long new_error = ((div1_prate / div1) / div2) - rate;
++
++			if (abs(new_error) < abs(error)) {
++				*bestdiv = div2;
++				error = new_error;
++			}
++			if (divider->flags & CLK_DIVIDER_POWER_OF_TWO)
++				div2 = div2 << 1;
++			else
++				div2++;
++		}
++		if (pdivider->flags & CLK_DIVIDER_POWER_OF_TWO)
++			div1 = div1 << 1;
++		else
++			div1++;
++	}
++}
++
  /**
   * zynqmp_clk_divider_round_rate() - Round rate of divider clock
   * @hw:			handle between common and hardware-specific interfaces
-@@ -174,6 +128,7 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
+@@ -128,7 +174,6 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
  	u32 div_type = divider->div_type;
  	u32 bestdiv;
  	int ret;
-+	u8 width;
+-	u8 width;
  
  	/* if read only, just return current value */
  	if (divider->flags & CLK_DIVIDER_READ_ONLY) {
-@@ -193,23 +148,12 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
+@@ -148,12 +193,23 @@ static long zynqmp_clk_divider_round_rate(struct clk_hw *hw,
  		return DIV_ROUND_UP_ULL((u64)*prate, bestdiv);
  	}
  
--	bestdiv = zynqmp_divider_get_val(*prate, rate, divider->flags);
--
--	/*
--	 * In case of two divisors, compute best divider values and return
--	 * divider2 value based on compute value. div1 will  be automatically
--	 * set to optimum based on required total divider value.
--	 */
--	if (div_type == TYPE_DIV2 &&
--	    (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
--		zynqmp_get_divider2_val(hw, rate, divider, &bestdiv);
--	}
-+	width = fls(divider->max_div);
- 
--	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_frac)
--		bestdiv = rate % *prate ? 1 : bestdiv;
-+	rate = divider_round_rate(hw, rate, prate, NULL, width, divider->flags);
- 
--	bestdiv = min_t(u32, bestdiv, divider->max_div);
--	*prate = rate * bestdiv;
-+	if (divider->is_frac && (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && (rate % *prate))
-+		*prate = rate;
+-	width = fls(divider->max_div);
++	bestdiv = zynqmp_divider_get_val(*prate, rate, divider->flags);
++
++	/*
++	 * In case of two divisors, compute best divider values and return
++	 * divider2 value based on compute value. div1 will  be automatically
++	 * set to optimum based on required total divider value.
++	 */
++	if (div_type == TYPE_DIV2 &&
++	    (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT)) {
++		zynqmp_get_divider2_val(hw, rate, divider, &bestdiv);
++	}
+ 
+-	rate = divider_round_rate(hw, rate, prate, NULL, width, divider->flags);
++	if ((clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && divider->is_frac)
++		bestdiv = rate % *prate ? 1 : bestdiv;
+ 
+-	if (divider->is_frac && (clk_hw_get_flags(hw) & CLK_SET_RATE_PARENT) && (rate % *prate))
+-		*prate = rate;
++	bestdiv = min_t(u32, bestdiv, divider->max_div);
++	*prate = rate * bestdiv;
  
  	return rate;
  }
+-- 
+2.25.1
+
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Success   |

