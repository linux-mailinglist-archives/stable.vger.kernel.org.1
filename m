Return-Path: <stable+bounces-84907-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 518B199D2CC
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 17:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C3B8AB28062
	for <lists+stable@lfdr.de>; Mon, 14 Oct 2024 15:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943231AC885;
	Mon, 14 Oct 2024 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="D7wkjVxY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 502E91CF7C6;
	Mon, 14 Oct 2024 15:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728919635; cv=none; b=uCLiQZH3yxHmiQfgD4XDsrtQtSFqDVKlxuODGGzRcM1gZLz31Gw1hJKdYWv36mdVHcu9ucRdn7pmomgrIXzTTImhvLiPocfCwX1UXTmdFXN10SPEAX8NL9VVsaUReQO4n46a+k/xIu3chG5/qUlxG5lgXltWVQ9vc2s7txfk2MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728919635; c=relaxed/simple;
	bh=iE67nwFiQr5inrYHh2VVHKzB3CtGpxYaGBpRvbwNvR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N9JY7F23dfDzGZCuPPZ5P9is4pKBu+dgu/aUKGYqniqFXXW2EHUcf31Ui0dNIDZR98KGKBuRK5jQGxUgK2M55AW8O021PtmWwQy09n7K1w3JT9h6A3FdS2ST/FnjD20LQnKSUlI2ZsGTzcqJ06XVTLZQ/VV2OCvoRcMD5C5Hi3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=D7wkjVxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBA0C4CED0;
	Mon, 14 Oct 2024 15:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728919634;
	bh=iE67nwFiQr5inrYHh2VVHKzB3CtGpxYaGBpRvbwNvR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D7wkjVxYSJD1Wgsrbp5nhYYds3EYojABE5PDjQ0gz0xbFEdBMvuhyg16cE54JVjLe
	 4ffNdN+QyZJcMzVGF/OK2uOzZlTzFMDg2KF/3Lr3L7Kpxq0bLPZ6/E8tdAkVGJ/E6I
	 WoaHoT8/rS+dMCas1bg4ym9/4iQ3w5+RuOT/iWy8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Stefan Wahren <stefan.wahren@i2se.com>,
	Peng Fan <peng.fan@nxp.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH 6.1 662/798] clk: imx6ul: fix "failed to get parent" error
Date: Mon, 14 Oct 2024 16:20:16 +0200
Message-ID: <20241014141244.060130988@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014141217.941104064@linuxfoundation.org>
References: <20241014141217.941104064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Oleksij Rempel <o.rempel@pengutronix.de>

commit f420f47e56c67587d9bc8f94267327b6fb214c1d upstream.

On some configuration we may get following error:
[    0.000000] imx:clk-gpr-mux: failed to get parent (-EINVAL)

This happens if selector is configured to not supported value. To avoid
this warnings add dummy parents for not supported values.

Fixes: 4e197ee880c2 ("clk: imx6ul: add ethernet refclock mux support")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/r/20230310164523.534571-1-o.rempel@pengutronix.de
Tested-by: Stefan Wahren <stefan.wahren@i2se.com>
Reported-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/imx/clk-imx6ul.c |   10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

--- a/drivers/clk/imx/clk-imx6ul.c
+++ b/drivers/clk/imx/clk-imx6ul.c
@@ -95,14 +95,16 @@ static const struct clk_div_table video_
 	{ }
 };
 
-static const char * enet1_ref_sels[] = { "enet1_ref_125m", "enet1_ref_pad", };
+static const char * enet1_ref_sels[] = { "enet1_ref_125m", "enet1_ref_pad", "dummy", "dummy"};
 static const u32 enet1_ref_sels_table[] = { IMX6UL_GPR1_ENET1_TX_CLK_DIR,
-					    IMX6UL_GPR1_ENET1_CLK_SEL };
+					    IMX6UL_GPR1_ENET1_CLK_SEL, 0,
+					    IMX6UL_GPR1_ENET1_TX_CLK_DIR | IMX6UL_GPR1_ENET1_CLK_SEL };
 static const u32 enet1_ref_sels_table_mask = IMX6UL_GPR1_ENET1_TX_CLK_DIR |
 					     IMX6UL_GPR1_ENET1_CLK_SEL;
-static const char * enet2_ref_sels[] = { "enet2_ref_125m", "enet2_ref_pad", };
+static const char * enet2_ref_sels[] = { "enet2_ref_125m", "enet2_ref_pad", "dummy", "dummy"};
 static const u32 enet2_ref_sels_table[] = { IMX6UL_GPR1_ENET2_TX_CLK_DIR,
-					    IMX6UL_GPR1_ENET2_CLK_SEL };
+					    IMX6UL_GPR1_ENET2_CLK_SEL, 0,
+					    IMX6UL_GPR1_ENET2_TX_CLK_DIR | IMX6UL_GPR1_ENET2_CLK_SEL };
 static const u32 enet2_ref_sels_table_mask = IMX6UL_GPR1_ENET2_TX_CLK_DIR |
 					     IMX6UL_GPR1_ENET2_CLK_SEL;
 



