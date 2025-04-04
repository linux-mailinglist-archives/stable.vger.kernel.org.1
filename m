Return-Path: <stable+bounces-128249-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F10A7B3D5
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 02:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35DC23B89F7
	for <lists+stable@lfdr.de>; Fri,  4 Apr 2025 00:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B132066FD;
	Fri,  4 Apr 2025 00:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxEltcQF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D522066F3;
	Fri,  4 Apr 2025 00:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743725239; cv=none; b=KODqsAbVrD8/qOe4c0aQUuDtgCJ8njrtlfUDvp1RPuGtuBbOBk62Bup3Ygu5c7GgK+HkbFvkEwL2sa8KZcNroTZmSuiK/6/p/5F/qpr2w6qVnYs12sebaWmSQMGrHT9YZru/JdlrvIOyiABjR89sx/mHe3Og67VgWOPKAV3pT2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743725239; c=relaxed/simple;
	bh=6H51TRq+4b6VBaT6ZCYfYPIOtcNrp00Og6veSVLaOEk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nEBOHzfXKIDiSFw3hsjba5qwBPhtF+Ndt/NFgQ2BOeGOokh82qmiAHtFhqykpZd0TpgWwk1uVX64m8E23VnsfJSxMRIsiTuG70/ZJPMkTFUEexTDzzIlqPIih132xKAjoc3wnwLbsFpOtK8PYHT90mYwfn6Tiy5pY3Ax8LVtzxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxEltcQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B8DDC4CEE3;
	Fri,  4 Apr 2025 00:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743725236;
	bh=6H51TRq+4b6VBaT6ZCYfYPIOtcNrp00Og6veSVLaOEk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IxEltcQFvWSVbQuRnOA8YrNqiQvD3u3BPwDEHxCtYNdI3Nt5Jr77BPegEWSLllLbw
	 Ht4G+PycpaYjxJ1rgoEwijI/QFhGvvd5ZkpmjjAmtsv7E4xzfm7u35862FJsR3GTEz
	 Mhj0xa83SjILmYHZYmYpL9OF6yqPIWc6hIWEgBX4ewgqsctseJSCV4Jk/4O4glX74l
	 CmDurQdUsztFDRaWJo02LCspup7VwA9fCEj/st1/1TxDrs11pJUjZGUN4y2d7cdX2B
	 KDlCGXBp/5Sg1a0eULi5GP3tgfGSjtQwP8HTbApL3/TdRF0+XERyc0tl3rw9eLGxz/
	 dtNXwBvECnJAw==
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
Subject: [PATCH AUTOSEL 6.1 06/10] clk: check for disabled clock-provider in of_clk_get_hw_from_clkspec()
Date: Thu,  3 Apr 2025 20:06:56 -0400
Message-Id: <20250404000700.2689158-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250404000700.2689158-1-sashal@kernel.org>
References: <20250404000700.2689158-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.132
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
index 8ecbb8f494655..5a01ba04e47cf 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -5128,6 +5128,10 @@ of_clk_get_hw_from_clkspec(struct of_phandle_args *clkspec)
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


