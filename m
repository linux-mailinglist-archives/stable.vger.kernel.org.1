Return-Path: <stable+bounces-167615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 12496B230D8
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:57:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D43B62358A
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F9412FE566;
	Tue, 12 Aug 2025 17:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZPoe2FM7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39582FDC2F;
	Tue, 12 Aug 2025 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021412; cv=none; b=gS5ip6nZ9ddFx8bqb79MPcTo9U7Wj8SfJXQAcVPL7qDjrxxxdS4zEy3x/lxE3I645AaBUM6YBQeVahPIjcHuFTyinBiiWTvqoNmSzUynjrXl/x1JOBL/wGDecCVPmXyT2ZHkX3+u9wD8CDC2dpN8QXGiFWXoQJ2Vo5EpQGCsH6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021412; c=relaxed/simple;
	bh=MjW/+o8szuDFyyIASkctf9XRpiDAL2eklHuVVJpTP5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICSIPhnkAWsPLUKcj9t5XtkGeaLV4zw8TqdOHSIJL5N+coyr1Pn76Gay5Mo+XKLPoOKysnQ62lztgQMBJCI+Ht6Nh+9y9XqjCOpRUdf9lq3fc9/WMibJXL/aT1jS4/seb+w4Kw6CQH8XP4tog7m5JZObfPtlwk4KEsdVhqrUNT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZPoe2FM7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495EEC4CEF6;
	Tue, 12 Aug 2025 17:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021412;
	bh=MjW/+o8szuDFyyIASkctf9XRpiDAL2eklHuVVJpTP5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZPoe2FM7YOG+zd0VEwp+Jse/Tq1dfAxg+6s5yqXCnxUcToxZTaNlixhgZjQsu+C54
	 nvLdaFY2ZMNqEMWgyAKK2ADwR+u3fAkx//3Fz0KB4atfU17wqZL2zg32rbYV6oJ0TY
	 307hnkbSA411TkJPiG1cilPp9J41lcStQT4Y+Ijg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rohit Visavalia <rohit.visavalia@amd.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 114/262] clk: xilinx: vcu: unregister pll_post only if registered correctly
Date: Tue, 12 Aug 2025 19:28:22 +0200
Message-ID: <20250812172957.955127756@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rohit Visavalia <rohit.visavalia@amd.com>

[ Upstream commit 3b0abc443ac22f7d4f61ddbbbbc5dbb06c87139d ]

If registration of pll_post is failed, it will be set to NULL or ERR,
unregistering same will fail with following call trace:

Unable to handle kernel NULL pointer dereference at virtual address 008
pc : clk_hw_unregister+0xc/0x20
lr : clk_hw_unregister_fixed_factor+0x18/0x30
sp : ffff800011923850
...
Call trace:
 clk_hw_unregister+0xc/0x20
 clk_hw_unregister_fixed_factor+0x18/0x30
 xvcu_unregister_clock_provider+0xcc/0xf4 [xlnx_vcu]
 xvcu_probe+0x2bc/0x53c [xlnx_vcu]

Fixes: 4472e1849db7 ("soc: xilinx: vcu: make pll post divider explicit")
Signed-off-by: Rohit Visavalia <rohit.visavalia@amd.com>
Link: https://lore.kernel.org/r/20250210113614.4149050-2-rohit.visavalia@amd.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/xilinx/xlnx_vcu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/xilinx/xlnx_vcu.c b/drivers/clk/xilinx/xlnx_vcu.c
index 60a3ed7c7263..299332818ba3 100644
--- a/drivers/clk/xilinx/xlnx_vcu.c
+++ b/drivers/clk/xilinx/xlnx_vcu.c
@@ -587,8 +587,8 @@ static void xvcu_unregister_clock_provider(struct xvcu_device *xvcu)
 		xvcu_clk_hw_unregister_leaf(hws[CLK_XVCU_ENC_MCU]);
 	if (!IS_ERR_OR_NULL(hws[CLK_XVCU_ENC_CORE]))
 		xvcu_clk_hw_unregister_leaf(hws[CLK_XVCU_ENC_CORE]);
-
-	clk_hw_unregister_fixed_factor(xvcu->pll_post);
+	if (!IS_ERR_OR_NULL(xvcu->pll_post))
+		clk_hw_unregister_fixed_factor(xvcu->pll_post);
 }
 
 /**
-- 
2.39.5




