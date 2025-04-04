Return-Path: <stable+bounces-128196-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C4E2A7B33E
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6D6F3B7003
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C51D1EB5D4;
	Fri,  4 Apr 2025 00:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dA63Jy6O"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4761EB1A9;
	Fri,  4 Apr 2025 00:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725120; cv=none; b=d6DCmfm1ibMTvhE92kQ4yXb0mATLGIUbag4yE3ol2BItvFzGbonM86mm7ONwligO6J01puA3daijIRsDz3wSL+T0wtzvielJrH6Ul6sAv/OVrorHPrtyraqjiJ26OOGJTjbY38POCPpm/JyHoYeIm4oP++kmokOphu7YpytvVvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725120; c=relaxed/simple;
	bh=NaEjO+BlkUrQoTEtbguQMK6Ma5RjBdxH0W3MopbJg+k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QfXCk1sJihgEUbugTjDs+GxmhvB9pZKyHxDnmTAXe/YZNoRptnIznuA6MrLHME3lnKtXd2WnOnFWxPDom4GP9qo0OXKZ6VQMb3hTJXCeeYOV57GXQEdthtFcHr/Hd18LnDp0UaP+ZXuHg5hFrsmitKfUKpaN7WcD42X4Q8mCVbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dA63Jy6O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAECCC4CEE9;
	Fri,  4 Apr 2025 00:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725119;
	bh=NaEjO+BlkUrQoTEtbguQMK6Ma5RjBdxH0W3MopbJg+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dA63Jy6ONPIvzwRrHjnHwK+3ZU7eKJgcZbOoRMWqTbC2XwaGoLgVG8qRcZENQS67y
	 fXLPB2XBMHLADO9d5NNA8HWKZN6/1DGejG5D5zxR51fY8buFNdktdvd2D3eyq8626O
	 9jWm7srBNySMQDozKKMVkEEj7mAA3Ye7/Z3PSx3B07LMGFw2DwMrscwbnZDQD2BQsW
	 ZwR0XgI3GKaSv2jScA6fIp8Z0HOHLzBOC7Vgtf+cQN5nIMujLrVLiojlDCZp4Ivrhm
	 HyXB08bDMcoqge9Qf9kNmk9pceXFPgNyNaD0V0yvc8JcXXT95YBYN1nsKscfvs6mHb
	 llUJwC/rgEhyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiko Stuebner <heiko@sntech.de>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mturquette@baylibre.com,
	linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 12/22] clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec()
Date: Thu,  3 Apr 2025 20:04:41 -0400
Message-Id: <20250404000453.2688371-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000453.2688371-1-sashal@kernel.org>
References: <20250404000453.2688371-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Heiko Stuebner <heiko@sntech.de>

[ Upstream commit b20150d499b3ee5c2d632fbc5ac94f98dd33accf ]

of_clk_get_hw_from_clkspec() checks all available clock-providers by
comparing their of nodes to the one from the clkspec. If no matching
clock provider is found, the function returns -EPROBE_DEFER to cause a
re-check at a later date. If a matching clock provider is found, an
authoritative answer can be retrieved from it whether the clock exists
or not.

This does not take into account that the clock-provider may never
appear, because it's node is disabled. This can happen when a clock is
optional, provided by a separate block which never gets enabled.

One example of this happening is the rk3588's VOP, which has optional
additional display clocks coming from PLLs inside the hdmiphy blocks.
These can be used for better rates, but the system will also work
without them.

The problem around that is described in the followups to[1]. As we
already know the of node of the presumed clock provider, add a check via
of_device_is_available() whether this is a "valid" device node. This
prevents eternal defer loops.

Link: https://lore.kernel.org/dri-devel/20250215-vop2-hdmi1-disp-modes-v1-3-81962a7151d6@collabora.com/ [1]
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20250222223733.2990179-1-heiko@sntech.de
[sboyd@kernel.org: Reword commit text a bit]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/clk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index cf7720b9172ff..50faafbf5dda5 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5258,6 +5258,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
 	if (!clkspec)
 		return ERR_PTR(-EINVAL);
 
+	/* Check if node in clkspec is in disabled/fail state */
+	if (!of_device_is_available(clkspec->np))
+		return ERR_PTR(-ENOENT);
+
 	mutex_lock(&of_clk_mutex);
 	list_for_each_entry(provider, &of_clk_providers, link) {
 		if (provider->node == clkspec->np) {
-- 
2.39.5


