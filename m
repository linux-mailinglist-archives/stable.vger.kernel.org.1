Return-Path: <stable+bounces-128271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF5DA7B41E
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:32:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C027A189B5E7
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D871419D8B2;
	Fri,  4 Apr 2025 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUtHOAF3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FA121CC5F;
	Fri,  4 Apr 2025 00:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725300; cv=none; b=YI6OJUWEQfVq9z+j1KZRAeMPhGkg9sONDGYnqOrvNbr1c5hcgyrK+YLTdsZ2KjWMSqrdFEQyY3Z8BVtS1uSN/YxbCdVlE8291FBh7vjd2x3k6ZifEeBas+bErOuhj+u4hIf0EUJrplqzVM/6KIynmpj35EKLAShTmn4P84E59AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725300; c=relaxed/simple;
	bh=33HMVPuk/lOrNcVuJK/s1l/HE5LH4t7VwHK418H+oA0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V1+OhN301xaI2RQqScDSC4yCNzFDvM6Yb2PkLvOGPiVPW0iIX8RecmKAjBsRt7RyeYGrizzBl4T5goyojTi8S7IgyE9Wbqqqh+u86JWFr2XaAtfNuHej2bs4mf9gfsNNVXh4qPtm9J9At8ACBFN6w21saAvu+3ONEYEOFe8NRoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUtHOAF3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D610C4CEE9;
	Fri,  4 Apr 2025 00:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725300;
	bh=33HMVPuk/lOrNcVuJK/s1l/HE5LH4t7VwHK418H+oA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUtHOAF3p/fn0ujJVw8ABM3Lp2HiiWH5QXqUaGm+WG8kr0EiTIS6e2vV9ctL65arL
	 /OtpGf6B0UsX2UuoRoxGocCZBbc/08vq0QthDdTDr3oHW7Qwcu2YuFrAKJem8N/874
	 uJ35s8gM+4iqwf5pWIJcBN8eg2yLteXiuOL5y9O3tLBDjxUyPZJ83FkLAmoxSh/YRF
	 5/KBLyhH+e1qRn//dIw/cMbEBZ+P6OZ20O36TZ1+iJWGUDoHoEglAcOimUTCigQAJ+
	 7j60ixaQYNNNb2pMFaDDsJH86ypjURCQOmSTLK2kAfW9RDQtlfdFI/OW23Xr/+DQ7X
	 ve0oyiOm6zcDQ==
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
Subject: [PATCH AUTOSEL 5.4 4/6] clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec()
Date: Thu,  3 Apr 2025 20:08:05 -0400
Message-Id: <20250404000809.2689525-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000809.2689525-1-sashal@kernel.org>
References: <20250404000809.2689525-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.291
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
index 56be3f97c265a..6ef5bf61fdd47 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4727,6 +4727,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
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


