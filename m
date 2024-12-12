Return-Path: <stable+bounces-102730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 359569EF358
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC0AB290243
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C648231A2B;
	Thu, 12 Dec 2024 16:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uBuC5h+p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5996E2253FE;
	Thu, 12 Dec 2024 16:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734022283; cv=none; b=raN+qM8aO8OSnRQg8T1TnLKwp/+b+zNJyr1evwPC1yisorQJD4aEKgnXE28DuEzNtBwQw8+t+UXLkmcKM48pAcP1wR4oAYz9hWetkZsEZPZZgdnpICH0LlLzwqRWfGwn9lUBUaus/Bs5aQXjCue+wtIEbkiITAZrkPsFdkcZoSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734022283; c=relaxed/simple;
	bh=fH+ZqloMN0cVIYHz3EM2sJJeabjBOVuBCsMa4UFnczo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNi69fpTANV+HwIgZSPTUxLfhrXcBx3Fx6a/7vrRVvN3EWYv6tTMq52Ix4KjXAC1mKJdcnaDDkjO+SKiK71EMaf6sOLQRjELZTTXXWvT8v5fIXNpThmArosON+EY2kPTN0SrNjA6iO5XAEmtxVabb17sHfk2T6HbdRHnBeEPPaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=uBuC5h+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0CFC4CECE;
	Thu, 12 Dec 2024 16:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734022282;
	bh=fH+ZqloMN0cVIYHz3EM2sJJeabjBOVuBCsMa4UFnczo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uBuC5h+pzJYiwCXgjWnWEIuIl/NK7hZP30xn+mJZqIe2D3nqsIrulyqsdvq832RC5
	 LLaZAOS8P3x1Gu9X0xvvUxrfJsZoAHLFKa4mu5VqAr1NbW1z9mxZ7dCOgAHe2pnrIL
	 QEXRlh4Rx46ClsLKeoy4RJZTy/Nbe7KSjXFG1VYQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mingwei Zheng <zmw12306@gmail.com>,
	Jiasheng Jiang <jiashengjiangcool@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 199/565] net: rfkill: gpio: Add check for clk_enable()
Date: Thu, 12 Dec 2024 15:56:34 +0100
Message-ID: <20241212144319.354268101@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144311.432886635@linuxfoundation.org>
References: <20241212144311.432886635@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Mingwei Zheng <zmw12306@gmail.com>

[ Upstream commit 8251e7621b25ccdb689f1dd9553b8789e3745ea1 ]

Add check for the return value of clk_enable() to catch the potential
error.

Fixes: 7176ba23f8b5 ("net: rfkill: add generic gpio rfkill driver")
Signed-off-by: Mingwei Zheng <zmw12306@gmail.com>
Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
Link: https://patch.msgid.link/20241108195341.1853080-1-zmw12306@gmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rfkill/rfkill-gpio.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
index f74baefd855d3..2df5bf240b64a 100644
--- a/net/rfkill/rfkill-gpio.c
+++ b/net/rfkill/rfkill-gpio.c
@@ -30,8 +30,12 @@ static int rfkill_gpio_set_power(void *data, bool blocked)
 {
 	struct rfkill_gpio_data *rfkill = data;
 
-	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled)
-		clk_enable(rfkill->clk);
+	if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled) {
+		int ret = clk_enable(rfkill->clk);
+
+		if (ret)
+			return ret;
+	}
 
 	gpiod_set_value_cansleep(rfkill->shutdown_gpio, !blocked);
 	gpiod_set_value_cansleep(rfkill->reset_gpio, !blocked);
-- 
2.43.0




