Return-Path: <stable+bounces-58729-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF4092B85E
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 13:33:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954AF281BD0
	for <lists+stable@lfdr.de>; Tue,  9 Jul 2024 11:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE20C156C61;
	Tue,  9 Jul 2024 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bc31MJeu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD8755E4C;
	Tue,  9 Jul 2024 11:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720524815; cv=none; b=pCgJt2tdhPZ6jvSzwBJu/PRJy8Pd0WCUNHMfoSs9NjHzl4EAlir2pEr5DZpiqh4RyiJpDlER49dx13tV7MQd5fivGnh49Z7i26FEkeW5c8QbpRPXic3G9nxVSY6LYzgQFRwbDZBb1amnbP6Fl1Vs3bwuUoLgz4aD2YeRC2wSsjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720524815; c=relaxed/simple;
	bh=lTU6DrrlVGKn3RzRivBSmdJVS8BMMbo2/jzeXjzt/IM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mu04F/VVx9uZZLVeHNyEAufsxjZNcxD8Gucfd4pGm4EmwE3Hoyq+X0HLJr3ex6TMmFbPql6VUpa8PpDBcQ2bT8gBd56QxpcH1ERGZ8O87WhANxEEi/ZzVudJcd0VSxWhnoaeLrzIDob54AozQOA7B2QBIEjgqioR9o2P6XC+ZSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Bc31MJeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A57C3277B;
	Tue,  9 Jul 2024 11:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720524815;
	bh=lTU6DrrlVGKn3RzRivBSmdJVS8BMMbo2/jzeXjzt/IM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bc31MJeur34hqnwVag+PJGCZISnQVsds/UevNv02H9Fp6WJWSlh49JKHrTnnz9HBr
	 Zn5f1gGSj4m811GLHeJcG0uInrkLzVm2xwHfONgm/xjDI+ADbNkgq6u8xCIUjW0Nvt
	 FWqMHxim5QmTDQMQKy8Hxq270pIDGZWtOSKlCTWw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Luca Weiss <luca.weiss@fairphone.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 085/102] clk: qcom: gcc-sm6350: Fix gpll6* & gpll7 parents
Date: Tue,  9 Jul 2024 13:10:48 +0200
Message-ID: <20240709110654.681951064@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240709110651.353707001@linuxfoundation.org>
References: <20240709110651.353707001@linuxfoundation.org>
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

From: Luca Weiss <luca.weiss@fairphone.com>

[ Upstream commit 3414f41a13eb41db15c558fbc695466203dca4fa ]

Both gpll6 and gpll7 are parented to CXO at 19.2 MHz and not to GPLL0
which runs at 600 MHz. Also gpll6_out_even should have the parent gpll6
and not gpll0.

Adjust the parents of these clocks to make Linux report the correct rate
and not absurd numbers like gpll7 at ~25 GHz or gpll6 at 24 GHz.

Corrected rates are the following:

  gpll7              807999902 Hz
  gpll6              768000000 Hz
     gpll6_out_even  384000000 Hz
  gpll0              600000000 Hz
     gpll0_out_odd   200000000 Hz
     gpll0_out_even  300000000 Hz

And because gpll6 is the parent of gcc_sdcc2_apps_clk_src (at 202 MHz)
that clock also reports the correct rate now and avoids this warning:

  [    5.984062] mmc0: Card appears overclocked; req 202000000 Hz, actual 6312499237 Hz

Fixes: 131abae905df ("clk: qcom: Add SM6350 GCC driver")
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Link: https://lore.kernel.org/r/20240508-sm6350-gpll-fix-v1-1-e4ea34284a6d@fairphone.com
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/qcom/gcc-sm6350.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6350.c b/drivers/clk/qcom/gcc-sm6350.c
index cf4a7b6e0b23a..0559a33faf00e 100644
--- a/drivers/clk/qcom/gcc-sm6350.c
+++ b/drivers/clk/qcom/gcc-sm6350.c
@@ -100,8 +100,8 @@ static struct clk_alpha_pll gpll6 = {
 		.enable_mask = BIT(6),
 		.hw.init = &(struct clk_init_data){
 			.name = "gpll6",
-			.parent_hws = (const struct clk_hw*[]){
-				&gpll0.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_fixed_fabia_ops,
@@ -124,7 +124,7 @@ static struct clk_alpha_pll_postdiv gpll6_out_even = {
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gpll6_out_even",
 		.parent_hws = (const struct clk_hw*[]){
-			&gpll0.clkr.hw,
+			&gpll6.clkr.hw,
 		},
 		.num_parents = 1,
 		.ops = &clk_alpha_pll_postdiv_fabia_ops,
@@ -139,8 +139,8 @@ static struct clk_alpha_pll gpll7 = {
 		.enable_mask = BIT(7),
 		.hw.init = &(struct clk_init_data){
 			.name = "gpll7",
-			.parent_hws = (const struct clk_hw*[]){
-				&gpll0.clkr.hw,
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
 			},
 			.num_parents = 1,
 			.ops = &clk_alpha_pll_fixed_fabia_ops,
-- 
2.43.0




