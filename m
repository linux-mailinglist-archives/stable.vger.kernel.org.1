Return-Path: <stable+bounces-156979-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF94AE51F3
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C94A7A1F48
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE837221FCC;
	Mon, 23 Jun 2025 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AnVPmluS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF75221DA8;
	Mon, 23 Jun 2025 21:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750714738; cv=none; b=lJPQeptGhS/FbvEGDIJAKOko4RE27TkDALLUF9GNMRN9LO2t8R1Mt3LHLHiZAV9gKDAcnQ1vHRvJbUeokM2w7p2yyPf2IxWUWQoTn5cH5+69bdl3BwlbpAGKq4uxcobM2vEbBgD9tbRp7JY7aOLcpTVA3+KputTkc2PxhtxaoQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750714738; c=relaxed/simple;
	bh=WYU5w9ogmvkkaPQJBQstHr+NoUPxivaX1w2s1tJxF2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WboFBoucZ7sNdalkBkd/TivRwuTG89TmFcitF3VBf4VuW7yjChUtBBsy8ZjjtdkkFf58yGnATkCtgTXzr+6ySVpbUQfF8TSTVmlmfcd+qBtiOKMRGX45S03lKBdCpUrnu9wzC1a1B3JoBNW4X+kdZTv3YA8FYFKPgOn7MRpt+jU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AnVPmluS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D091DC4CEEA;
	Mon, 23 Jun 2025 21:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750714738;
	bh=WYU5w9ogmvkkaPQJBQstHr+NoUPxivaX1w2s1tJxF2U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AnVPmluS9xiAI5SpRApG721tPgPphbFOO9wSrnCq8xdbQI+BAiJ/WupXcvUwP4T9i
	 bptDTUYJKDhb0AiNVqO4yNoA9h7N8vJZBqkGovxutaYJZBPOozDh57/co1jCU7QpbJ
	 4fGJ1NGlCj7npa+gX16trbAHY7lqLlFjSbtWxSp8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Hans Verkuil <hverkuil@xs4all.nl>
Subject: [PATCH 5.15 206/411] media: ccs-pll: Start VT pre-PLL multiplier search from correct value
Date: Mon, 23 Jun 2025 15:05:50 +0200
Message-ID: <20250623130638.859222856@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130632.993849527@linuxfoundation.org>
References: <20250623130632.993849527@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sakari Ailus <sakari.ailus@linux.intel.com>

commit 06d2d478b09e6764fb6161d1621fc10d9f0f2860 upstream.

The ccs_pll_calculate_vt_tree() function does a search over possible VT
PLL configurations to find the "best" one. If the sensor does not support
odd pre-PLL divisors and the minimum value (with constraints) isn't 1,
other odd values could be errorneously searched (and selected) for the
pre-PLL divisor. Fix this.

Fixes: 415ddd993978 ("media: ccs-pll: Split limits and PLL configuration into front and back parts")
Cc: stable@vger.kernel.org
Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Hans Verkuil <hverkuil@xs4all.nl>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/media/i2c/ccs-pll.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/media/i2c/ccs-pll.c
+++ b/drivers/media/i2c/ccs-pll.c
@@ -397,6 +397,8 @@ static int ccs_pll_calculate_vt_tree(str
 	min_pre_pll_clk_div = max_t(u16, min_pre_pll_clk_div,
 				    pll->ext_clk_freq_hz /
 				    lim_fr->max_pll_ip_clk_freq_hz);
+	if (!(pll->flags & CCS_PLL_FLAG_EXT_IP_PLL_DIVIDER))
+		min_pre_pll_clk_div = clk_div_even(min_pre_pll_clk_div);
 
 	dev_dbg(dev, "vt min/max_pre_pll_clk_div: %u,%u\n",
 		min_pre_pll_clk_div, max_pre_pll_clk_div);



