Return-Path: <stable+bounces-128257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CED4A7B3FE
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5B7B7A7BAF
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354FD208969;
	Fri,  4 Apr 2025 00:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ef4fgmtk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2492208960;
	Fri,  4 Apr 2025 00:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725260; cv=none; b=NMWAGbrTCdzWY224IH/vmEEwvGo4skGbUSHrIfOm5CLv6qy6Fm88EjkrW/OpArcW+mXmKd3SV5s3S8klJWMqFdGEcUr4SNOt43bpjjSx8m187N/TZbg9VtTv1lMZHNuEbP9ybfDRhyHFD3/tFIohd+qqDfSGdq33pwyOs4ZW7pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725260; c=relaxed/simple;
	bh=F2cN1MgTS/MjxH5XVh/WnmOD1mzoQk4bMwQN5DGdgtY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NYqQnHbdBfkcJbdJghXp/Eils3uVTYdA/fUMaS127tIhWurYzQ5Oqjz9G/jSGGFt4n6eQ2xN4xeykVQfNHZbIZPBj7cevtZfjgmd0Fz0OlSHe9DCUsl2Zblqo7YeRfDnAPT7OBO/ikjroXerAyKWv54IyU2ko1uzDZ4PjoDmMqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ef4fgmtk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 575F9C4CEE9;
	Fri,  4 Apr 2025 00:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725259;
	bh=F2cN1MgTS/MjxH5XVh/WnmOD1mzoQk4bMwQN5DGdgtY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ef4fgmtkqv/7jZpwWlgbtJ4rq6GQ+SMFS5P3KDloRNW4H0LTQZ6FxltkaMgjDMvYY
	 5V6hgssDbenC71y8bcg2uaSLWa0m754Ny3EJ+AqDwry7uONFkShaMI6zl8PYGZ46qv
	 mQQBU3Tr+k+Co4Le7DEspoH12h0uD9Wljx83XQEvCp57vnpdT2vmi2Jgp9NZWI8ySo
	 kzvkbni2MJt0v2v/sRddFaOb3x9t3ZripU548WxKgdYrF6eDhZT8Tcmwtb8lsDkvMK
	 5zvSbp8MPTa42WBn+AV1y0dshC32m5SIh6Hxq+nVyrJxEqSBnTIThDYCuS8bT0ZUcO
	 d3qYiBpJgsZKg==
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
Subject: [PATCH AUTOSEL 5.15 4/8] clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec()
Date: Thu,  3 Apr 2025 20:07:22 -0400
Message-Id: <20250404000728.2689305-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000728.2689305-1-sashal@kernel.org>
References: <20250404000728.2689305-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.179
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
index dc2bcf58fc107..13f7e2ea644d9 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -4993,6 +4993,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
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


