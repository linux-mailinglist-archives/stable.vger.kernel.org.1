Return-Path: <stable+bounces-190400-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D260CC105DC
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 20:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1BC3A18968DD
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 18:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AFE32D433;
	Mon, 27 Oct 2025 18:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sZbSHbG+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B703322DD6;
	Mon, 27 Oct 2025 18:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761591203; cv=none; b=biiJ0yIh//jZO/mt78GkPppXbNZkt9vQZG3fSgUB7l+0h2EPiAdSjTPJvN97a28a+tZZVTRxapUqP/BRJKzEzwQZSnSTh+fbQVJILObGfcSjWnq9CDs2NvmHomer0K0cSssIznFp8ZAj15wB14G5DpRwROWjV40aAgBVa9RNT+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761591203; c=relaxed/simple;
	bh=YZl9Kd5MxPBLb4b6fXfUW4MvKJwS1CwEQdvTGCybbbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jhvMUKEYDWq/hvtfDM3x/qksA0IjUrGvkeP9Mf9LO8HOZhW7Eu/soTPdL3dHwKt9cgK+c+AyuMXWTnDdWFztxZKMAobrPkLbZuNynZ1zRAZMizjaITRE/iIZxvNNqGlP5PULf9bnb/SlT+zKNwf0yo7wvxFjro4a6C/8Z6ZfpaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sZbSHbG+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD797C4CEF1;
	Mon, 27 Oct 2025 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761591203;
	bh=YZl9Kd5MxPBLb4b6fXfUW4MvKJwS1CwEQdvTGCybbbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sZbSHbG+2mKlWfL6+jcilwGgLuXYqAyqsoDeHjWeWFF7kLqQQofNl0EV2EZ/SHL8L
	 UElDMEEoQWorsUBnWcOlTYRqSBC6oxy7hTliWzD/E+BooNxx3/SBWMStwAIOThmy5v
	 zK/hSTZbKdOAl8mz0bKK9he0efcNBGPGE+8VWSKk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alok Tiwari <alok.a.tiwari@oracle.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 105/332] clk: nxp: Fix pll0 rate check condition in LPC18xx CGU driver
Date: Mon, 27 Oct 2025 19:32:38 +0100
Message-ID: <20251027183527.387771659@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183524.611456697@linuxfoundation.org>
References: <20251027183524.611456697@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alok Tiwari <alok.a.tiwari@oracle.com>

[ Upstream commit 1624dead9a4d288a594fdf19735ebfe4bb567cb8 ]

The conditional check for the PLL0 multiplier 'm' used a logical AND
instead of OR, making the range check ineffective. This patch replaces
&& with || to correctly reject invalid values of 'm' that are either
less than or equal to 0 or greater than LPC18XX_PLL0_MSEL_MAX.

This ensures proper bounds checking during clk rate setting and rounding.

Fixes: b04e0b8fd544 ("clk: add lpc18xx cgu clk driver")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
[sboyd@kernel.org: 'm' is unsigned so remove < condition]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/nxp/clk-lpc18xx-cgu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/nxp/clk-lpc18xx-cgu.c b/drivers/clk/nxp/clk-lpc18xx-cgu.c
index 44e07a3c253b9..ab8741fe57c99 100644
--- a/drivers/clk/nxp/clk-lpc18xx-cgu.c
+++ b/drivers/clk/nxp/clk-lpc18xx-cgu.c
@@ -385,7 +385,7 @@ static int lpc18xx_pll0_determine_rate(struct clk_hw *hw,
 	}
 
 	m = DIV_ROUND_UP_ULL(req->best_parent_rate, req->rate * 2);
-	if (m <= 0 && m > LPC18XX_PLL0_MSEL_MAX) {
+	if (m == 0 || m > LPC18XX_PLL0_MSEL_MAX) {
 		pr_warn("%s: unable to support rate %lu\n", __func__, req->rate);
 		return -EINVAL;
 	}
@@ -408,7 +408,7 @@ static int lpc18xx_pll0_set_rate(struct clk_hw *hw, unsigned long rate,
 	}
 
 	m = DIV_ROUND_UP_ULL(parent_rate, rate * 2);
-	if (m <= 0 && m > LPC18XX_PLL0_MSEL_MAX) {
+	if (m == 0 || m > LPC18XX_PLL0_MSEL_MAX) {
 		pr_warn("%s: unable to support rate %lu\n", __func__, rate);
 		return -EINVAL;
 	}
-- 
2.51.0




