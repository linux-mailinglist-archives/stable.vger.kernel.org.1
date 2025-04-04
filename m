Return-Path: <stable+bounces-128233-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F13A7B3B3
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB710189D0ED
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFC5200127;
	Fri,  4 Apr 2025 00:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NJAIcEmF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929263FF1;
	Fri,  4 Apr 2025 00:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725203; cv=none; b=oEzigHRWuubZr8GuzbsOOuK+4gEMQqGbyNHkowyXkIQACacrQ1oPmdIui3PRtVlhHDlVUjdUGvDGLpRt2mqn2A7iFcbez2LaVKKwywGbqC5fDazYVIOCS/e0qkojXK23+yJ/OHukqIZhnC+ka9rhFzr4pj0s+4zCbvOJISaARVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725203; c=relaxed/simple;
	bh=CUq0G/E1vqO3bDKwxsPSdPm3GOuDCkn4hZez8/KtrCg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V7+4NDiC9+lV/n8xkMtzcDgHXtO5tFbRSn4BS9zPtwZKJDRdRCW3KdMZee8aVX/qGdNoQeLyGr+zPlojaZM9GtjIAMVB/dd5gN4MxbErltqXmCsWAcn1Y706ZizNc5Fn915rtzyDICqOYamqev4sOrv3iTTbdiwnTx3/RRyMNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NJAIcEmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A4FC4CEF0;
	Fri,  4 Apr 2025 00:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725202;
	bh=CUq0G/E1vqO3bDKwxsPSdPm3GOuDCkn4hZez8/KtrCg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NJAIcEmF4xexico9cPqlbj7Snn9yuS62Y+wpwEdLqRQZtPJXxMxBqe+4loc1o34eD
	 XYJdzZK6IQ8/PHKPruaL9rYqexdNVGuBUTjCFG45rSsVi5eZ9tPFk69S6KrkWdzk1n
	 oejRky+w0WgNL/RMwswndSyt1S5/OBU5lwasRJ2ffu2PXZqbbIo+ghWpB5SA4cRDsb
	 MmuVC2V2Cxg5JoWzrAs51v7QMcqtIP3NXWV1pPRg8S96y9eNmOGmJdLlNb4siEQ5ZZ
	 5tGFzqYhaMbvg4C2LAp4M1XTXy8eTEOFGYjCvyruKv5tFAkGAyMRTisWr4WLq9tRYC
	 POaAqpsdtysyQ==
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
Subject: [PATCH AUTOSEL 6.6 07/16] clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec()
Date: Thu,  3 Apr 2025 20:06:15 -0400
Message-Id: <20250404000624.2688940-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000624.2688940-1-sashal@kernel.org>
References: <20250404000624.2688940-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.85
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
index 5bbd036f5295f..8474099e2cac1 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5216,6 +5216,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
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


