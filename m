Return-Path: <stable+bounces-64036-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA81941BD3
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 18:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DB5281EA3
	for <lists+stable@lfdr.de>; Tue, 30 Jul 2024 16:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 699311898E0;
	Tue, 30 Jul 2024 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Abtr1dtb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF8217D8BB;
	Tue, 30 Jul 2024 16:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722358773; cv=none; b=WrfcGdUx4ncA/UBTrXvViCffWtOumwQ89nZ1SuLJrxxiVoW5AcvRh5ti8bS3v8HJzFGRmjrzkGbRTrRGwPcf3nqC7xVtBSJAWNbnvAjZ5CedPTQGiIO1IU1ztlViYHQrDFzXFRDs2MhHMLz/2LhDhk0s4fNXTrjAwp8eCyjS9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722358773; c=relaxed/simple;
	bh=onQdc2POXCs1w7Qmq+TDYwmXeZaq/jCFA3cpaQ8ao9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ27nJUSK5Ozg9irC9XbdAYWNr5Flwy0/hLZulzuxkv8ePCeo7ho2LLvC6OfvTJYeLMRA0D0bDnlksgIwc2fnEcT/tCtWV+wJm7fbYtbhPm6VkmRJPPX7h8kxOLUBU0A4IK+0Ir125xtNvSKdDWQxzozkrseICO3T97pRFf0siE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Abtr1dtb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DB7C4AF0A;
	Tue, 30 Jul 2024 16:59:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722358772;
	bh=onQdc2POXCs1w7Qmq+TDYwmXeZaq/jCFA3cpaQ8ao9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Abtr1dtb1voSLyylN29hZGppB79Dr8CH5upZ56A1DCaB4nhDJl6ijW7LHg47d1YQB
	 LCkPST+PlcTfmujUgduZOiKByjnv5R+Oo9BhnFKyreto6rQomtWQ3MmtgIPtYsCTU0
	 bFfUjyBg9jK7Yfl6oL9nC1lI1EVxqsiXJlnys/P8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Xianwei Zhao <xianwei.zhao@amlogic.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 395/809] clk: meson: s4: fix pwm_j_div parent clock
Date: Tue, 30 Jul 2024 17:44:31 +0200
Message-ID: <20240730151740.282898439@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240730151724.637682316@linuxfoundation.org>
References: <20240730151724.637682316@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xianwei Zhao <xianwei.zhao@amlogic.com>

[ Upstream commit c591745831e75b11ef19fb33c5c5a16e4d3f7fbf ]

Update peripherals pwm_j_div's parent clock to pwm_j_mux

Fixes: 57b55c76aaf1 ("clk: meson: S4: add support for Amlogic S4 SoC peripheral clock controller")
Signed-off-by: Xianwei Zhao <xianwei.zhao@amlogic.com>
Link: https://lore.kernel.org/r/20240516071612.2978201-1-xianwei.zhao@amlogic.com
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/s4-peripherals.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/s4-peripherals.c b/drivers/clk/meson/s4-peripherals.c
index 5e17ca50ab091..73340c7e815e7 100644
--- a/drivers/clk/meson/s4-peripherals.c
+++ b/drivers/clk/meson/s4-peripherals.c
@@ -2978,7 +2978,7 @@ static struct clk_regmap s4_pwm_j_div = {
 		.name = "pwm_j_div",
 		.ops = &clk_regmap_divider_ops,
 		.parent_hws = (const struct clk_hw *[]) {
-			&s4_pwm_h_mux.hw
+			&s4_pwm_j_mux.hw
 		},
 		.num_parents = 1,
 		.flags = CLK_SET_RATE_PARENT,
-- 
2.43.0




