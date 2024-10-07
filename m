Return-Path: <stable+bounces-81381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10EFF9933E6
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 18:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421FE1C23752
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E50E91DC064;
	Mon,  7 Oct 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1EH2toxe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EB31DC73E
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 16:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728319798; cv=none; b=IfFsTryi+hnjkNpZzRmMr4yOQYKTyvyBqngS/T6KQ/nUtlt6eWmu2twG+CBCFwHO9iBm8Q8z+DkpNXLDlRfNW19PSD3mcUcLkbC4kUSssHItCxWrSW4FCQbVQ4kLs1Ot7BKqBfjmOu1RbII2vRA7q0shV1+Bpf7+tAY5+YYl/T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728319798; c=relaxed/simple;
	bh=1mBaai1gA12vZriq3Wz3wkAW3rmcT5bYjSYx5D4BbTs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=okCtd8eED9viNELsLCjg2hWaC4vistsWPyghA2hHPZ91+30nuqteVrGoIudIvj4TKKtn3WXWt5gXhUoT4Fd+Y0sMMpWLWpcZvg+vlzR0ugXnlE5aFU+WmHb1SmpjdamBYHKqIxn7KwacbVlTAWlVxT0cw5Q69rgIEyClk3ZzcZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1EH2toxe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F51BC4CEC6;
	Mon,  7 Oct 2024 16:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728319798;
	bh=1mBaai1gA12vZriq3Wz3wkAW3rmcT5bYjSYx5D4BbTs=;
	h=Subject:To:Cc:From:Date:From;
	b=1EH2toxeV8oDRlDwHgIbkNvcejBxWkiF5AQnISGu18CmVEjZeYrTQmgh7hWPASnD7
	 DEzCdGpcHc5XWVxfVlthOBkduxo5LS+3iMngf70kmRkGwZYlO6jWEGgrocKv/2R+Va
	 +W3QvzX9T3qGvqhUUjLBX1x0cO+yg+CxYeLYEt3o=
Subject: FAILED: patch "[PATCH] clk: qcom: dispcc-sm8250: use CLK_SET_RATE_PARENT for branch" failed to apply to 5.10-stable tree
To: dmitry.baryshkov@linaro.org,andersson@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 18:49:55 +0200
Message-ID: <2024100755-requisite-gratuity-37ef@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 0e93c6320ecde0583de09f3fe801ce8822886fec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100755-requisite-gratuity-37ef@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

0e93c6320ecd ("clk: qcom: dispcc-sm8250: use CLK_SET_RATE_PARENT for branch clocks")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e93c6320ecde0583de09f3fe801ce8822886fec Mon Sep 17 00:00:00 2001
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Sun, 4 Aug 2024 08:40:05 +0300
Subject: [PATCH] clk: qcom: dispcc-sm8250: use CLK_SET_RATE_PARENT for branch
 clocks

Add CLK_SET_RATE_PARENT for several branch clocks. Such clocks don't
have a way to change the rate, so set the parent rate instead.

Fixes: 80a18f4a8567 ("clk: qcom: Add display clock controller driver for SM8150 and SM8250")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240804-sm8350-fixes-v1-1-1149dd8399fe@linaro.org
Signed-off-by: Bjorn Andersson <andersson@kernel.org>

diff --git a/drivers/clk/qcom/dispcc-sm8250.c b/drivers/clk/qcom/dispcc-sm8250.c
index 5a09009b7289..eb78cd5439d0 100644
--- a/drivers/clk/qcom/dispcc-sm8250.c
+++ b/drivers/clk/qcom/dispcc-sm8250.c
@@ -849,6 +849,7 @@ static struct clk_branch disp_cc_mdss_dp_link1_intf_clk = {
 				&disp_cc_mdss_dp_link1_div_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -884,6 +885,7 @@ static struct clk_branch disp_cc_mdss_dp_link_intf_clk = {
 				&disp_cc_mdss_dp_link_div_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},
@@ -1009,6 +1011,7 @@ static struct clk_branch disp_cc_mdss_mdp_lut_clk = {
 				&disp_cc_mdss_mdp_clk_src.clkr.hw,
 			},
 			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
 			.ops = &clk_branch2_ops,
 		},
 	},


