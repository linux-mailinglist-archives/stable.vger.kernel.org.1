Return-Path: <stable+bounces-131453-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F31E9A809D4
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 14:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FE474E7AE3
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B572527701E;
	Tue,  8 Apr 2025 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nePfzECP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBE0277017;
	Tue,  8 Apr 2025 12:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744116437; cv=none; b=W1PvteBseorByaUKQHGTgAe6Y+lN6MonhsMdvRKtxLebEWalS5TKkaZsvdsvoFozKxw27l8oUvsJBwTkVBNjPaHhthz9XoKqesxlof7m0d8h+lHSH81a+rMBAlG0Hp3V8CYF7yl5m4JQYpu090rxJqI8rEE5lRGoFUIERLjN4xY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744116437; c=relaxed/simple;
	bh=4oRj3v3UQTjFRAcfnmXl31eX2/rjKnrJn6+hLJIULjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hisFD0qslQWTDxED2Jz4kJQCpgqX5MoBIV0inb3Z9gmeJ2dMh6/T/A+RWXxVKRKhmI/zSSAQR335bag8HGLRnqiQ9Om2EJzGd7RCvnYZFg2BEiuxJdE0M6FeXS/oQlJKNyZSLCne9/ATmD6z0nDL0LTPufMBaqlh1ljwgELffAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nePfzECP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FD9C4CEFE;
	Tue,  8 Apr 2025 12:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744116437;
	bh=4oRj3v3UQTjFRAcfnmXl31eX2/rjKnrJn6+hLJIULjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nePfzECP0xw4sttV0gNM5DewA92gipux2l4vyiqQO+oPa8OPI/CU2reOTKsUBE0Yx
	 taW4VbWdsBJCwavkLffg2MLa/Z4mXfMYsXRV9fgJrOs88Pq4xLaLVd1L16phejxtEg
	 W1pYtKuF0AOscMXHFZk6diZbtANobRtlsDCCyXB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 141/423] clk: amlogic: gxbb: drop non existing 32k clock parent
Date: Tue,  8 Apr 2025 12:47:47 +0200
Message-ID: <20250408104849.012381216@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104845.675475678@linuxfoundation.org>
References: <20250408104845.675475678@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit 7915d7d5407c026fa9343befb4d3343f7a345f97 ]

The 32k clock reference a parent 'cts_slow_oscin' with a fixme note saying
that this clock should be provided by AO controller.

The HW probably has this clock but it does not exist at the moment in
any controller implementation. Furthermore, referencing clock by the global
name should be avoided whenever possible.

There is no reason to keep this hack around, at least for now.

Fixes: 14c735c8e308 ("clk: meson-gxbb: Add EE 32K Clock for CEC")
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://lore.kernel.org/r/20241220-amlogic-clk-gxbb-32k-fixes-v1-2-baca56ecf2db@baylibre.com
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/gxbb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 738317b3e274d..d9529de200ae4 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -1272,14 +1272,13 @@ static struct clk_regmap gxbb_cts_i958 = {
 	},
 };
 
+/*
+ * This table skips a clock named 'cts_slow_oscin' in the documentation
+ * This clock does not exist yet in this controller or the AO one
+ */
+static u32 gxbb_32k_clk_parents_val_table[] = { 0, 2, 3 };
 static const struct clk_parent_data gxbb_32k_clk_parent_data[] = {
 	{ .fw_name = "xtal", },
-	/*
-	 * FIXME: This clock is provided by the ao clock controller but the
-	 * clock is not yet part of the binding of this controller, so string
-	 * name must be use to set this parent.
-	 */
-	{ .name = "cts_slow_oscin", .index = -1 },
 	{ .hw = &gxbb_fclk_div3.hw },
 	{ .hw = &gxbb_fclk_div5.hw },
 };
@@ -1289,6 +1288,7 @@ static struct clk_regmap gxbb_32k_clk_sel = {
 		.offset = HHI_32K_CLK_CNTL,
 		.mask = 0x3,
 		.shift = 16,
+		.table = gxbb_32k_clk_parents_val_table,
 		},
 	.hw.init = &(struct clk_init_data){
 		.name = "32k_clk_sel",
-- 
2.39.5




