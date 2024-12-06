Return-Path: <stable+bounces-99552-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F269E7235
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AAEB618832E9
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B676148FE6;
	Fri,  6 Dec 2024 15:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cHM9Jqgg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BE053A7;
	Fri,  6 Dec 2024 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497568; cv=none; b=OvOfAmAiso/MuPINRZhvnhypvj00qlsNYkfkN+QeJEz95OQIKko7RjwOl0APtnlKoJSD8y9hsRzKfM7+D1dKiOctO937GL0J7dKAIV9Rc4FebRmOTrhGAxGOQOuJ+tnNPVsKaopX8t9q30Lcb9HP4cuyKhiBvtZLWqRs0nN+d4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497568; c=relaxed/simple;
	bh=Y/CWhFQhmeI3Ui49m+y1MuH4s7syNR21UGPbw/f8jTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QhwfuJ0bcQJqQNqIndXi7QgkJ4j5NGzN6eRbGAGs53tVK4PifaeJVsNOMYUu2gdnbMT4rR40OSWpda6gwc6fghPbgGaCPCgyiw0VD20NzYST/u39C9H+71m4Poy23MThzeISp5qtL12Nk1WWQ+6+p4RRCSZ7kISbcZadNCY6xYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cHM9Jqgg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC50C4CED1;
	Fri,  6 Dec 2024 15:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497566;
	bh=Y/CWhFQhmeI3Ui49m+y1MuH4s7syNR21UGPbw/f8jTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHM9Jqggsw8kIOBeQ5366GcsTsxGXvfdy2pI0jf0MU1vkpP7ydzCRZotYWPZ8yNrT
	 PTs6mHAKgXh8nq7lzHmZBUheUIKJd5HM1JSTV1PwRtQKZvM1mn7Hn/OcshuCraS9ps
	 Y2FzF9ekCnqQi5Msa4v1gP5DP3SqXpxtzrmqUqUc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sergio Paracuellos <sergio.paracuellos@gmail.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 327/676] clk: ralink: mtmips: fix clock plan for Ralink SoC RT3883
Date: Fri,  6 Dec 2024 15:32:26 +0100
Message-ID: <20241206143706.118926892@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sergio Paracuellos <sergio.paracuellos@gmail.com>

[ Upstream commit 33239152305567b3e9bf052f71fd4baecd626341 ]

Clock plan for Ralink SoC RT3883 needs an extra 'periph' clock to properly
set some peripherals that has this clock as their parent. When this driver
was mainlined we could not find any active users of this SoC so we cannot
perform any real tests for it. Now, one user of a Belkin f9k1109 version 1
device which uses this SoC appear and reported some issues in openWRT:
- https://github.com/openwrt/openwrt/issues/16054
The peripherals that are wrong are 'uart', 'i2c', 'i2s' and 'uartlite' which
has a not defined 'periph' clock as parent. Hence, introduce it to have a
properly working clock plan for this SoC.

Fixes: 6f3b15586eef ("clk: ralink: add clock and reset driver for MTMIPS SoCs")
Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
Link: https://lore.kernel.org/r/20240910044024.120009-2-sergio.paracuellos@gmail.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/ralink/clk-mtmips.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ralink/clk-mtmips.c b/drivers/clk/ralink/clk-mtmips.c
index 50a443bf79ecd..62f9801ecd3a4 100644
--- a/drivers/clk/ralink/clk-mtmips.c
+++ b/drivers/clk/ralink/clk-mtmips.c
@@ -267,6 +267,11 @@ static struct mtmips_clk_fixed rt305x_fixed_clocks[] = {
 	CLK_FIXED("xtal", NULL, 40000000)
 };
 
+static struct mtmips_clk_fixed rt3883_fixed_clocks[] = {
+	CLK_FIXED("xtal", NULL, 40000000),
+	CLK_FIXED("periph", "xtal", 40000000)
+};
+
 static struct mtmips_clk_fixed rt3352_fixed_clocks[] = {
 	CLK_FIXED("periph", "xtal", 40000000)
 };
@@ -779,8 +784,8 @@ static const struct mtmips_clk_data rt3352_clk_data = {
 static const struct mtmips_clk_data rt3883_clk_data = {
 	.clk_base = rt3883_clks_base,
 	.num_clk_base = ARRAY_SIZE(rt3883_clks_base),
-	.clk_fixed = rt305x_fixed_clocks,
-	.num_clk_fixed = ARRAY_SIZE(rt305x_fixed_clocks),
+	.clk_fixed = rt3883_fixed_clocks,
+	.num_clk_fixed = ARRAY_SIZE(rt3883_fixed_clocks),
 	.clk_factor = NULL,
 	.num_clk_factor = 0,
 	.clk_periph = rt5350_pherip_clks,
-- 
2.43.0




