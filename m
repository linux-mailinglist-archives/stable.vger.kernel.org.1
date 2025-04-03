Return-Path: <stable+bounces-128034-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA92A7AE82
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 22:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA7053B18B4
	for <lists+stable@lfdr.de>; Thu,  3 Apr 2025 20:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880AA2080D2;
	Thu,  3 Apr 2025 19:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXhf4OI7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319511C32EA;
	Thu,  3 Apr 2025 19:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743707810; cv=none; b=qkIDA3bvTKlrgLAG8z1yi++MtflpflrxRqlZ6nLV13+40xpfn6JjLmcCc1p7LyhbRGkV0qcsov7tJcr9rs3XXs6OWBhwXVye7FwL2yNHbhEmISZyJF5M8ISZO9dDLeF+YtwPj0ZuFl7sB5pqObJ3cEmoWEktcMxEB+XM464Ugn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743707810; c=relaxed/simple;
	bh=1tOergcQPQmBPN1Wh3qhLnXuccrvTqaC5KkWRfWsEVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JBWzxzf2kcP/sxQvhbQCdTwz4mMIcixKE95djNFaxMAZGUkpVlTJZugX0hPX/lRbSNmq3qczW+qunlHUqFJucBrUo78yosM5NNqy50x3wmn4lbLQ2eTPLbwuo9gA4SSqP4HW+cRkgG1dJTRzSpMLZ0BM+klhFy5zHjCJktbot6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXhf4OI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB5BC4CEEC;
	Thu,  3 Apr 2025 19:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743707809;
	bh=1tOergcQPQmBPN1Wh3qhLnXuccrvTqaC5KkWRfWsEVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXhf4OI7u+4AClOYpMDIsc7YScgtwii1f7psc+lD2+lGG8X1YOcZ5cmG0u7dlzmiO
	 R7dYPh/n8/nEV29x+SmMj3pNijHl6d+wJ6mTI0rGoJKejCzr+cI+Tk6vQcN3T4mQwK
	 i0uwsHG1wAw+7bWo8mpWBIAUiURGcNjySWNVWqVOczPndcmv0MhWpZSZArtRGJBnFM
	 TqV5AKVpEgT89Jr3UA3J68dP0v8wYx3wFqYGeNfv1s0WxMZCzece3L3VhWk/6xKF7j
	 yhgtUy3zYlIpBklM8/UhnzBbAwE7tnMH28vOh1u0T+UPKJuricoANoeBOTl/VlztBB
	 gwlq9CewqZv0Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leonid Arapov <arapovl839@gmail.com>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>,
	krzysztof.kozlowski@linaro.org,
	linux@treblig.org,
	tzimmermann@suse.de,
	u.kleine-koenig@baylibre.com,
	linux-omap@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 33/37] fbdev: omapfb: Add 'plane' value check
Date: Thu,  3 Apr 2025 15:15:09 -0400
Message-Id: <20250403191513.2680235-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250403191513.2680235-1-sashal@kernel.org>
References: <20250403191513.2680235-1-sashal@kernel.org>
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

From: Leonid Arapov <arapovl839@gmail.com>

[ Upstream commit 3e411827f31db7f938a30a3c7a7599839401ec30 ]

Function dispc_ovl_setup is not intended to work with the value OMAP_DSS_WB
of the enum parameter plane.

The value of this parameter is initialized in dss_init_overlays and in the
current state of the code it cannot take this value so it's not a real
problem.

For the purposes of defensive coding it wouldn't be superfluous to check
the parameter value, because some functions down the call stack process
this value correctly and some not.

For example, in dispc_ovl_setup_global_alpha it may lead to buffer
overflow.

Add check for this value.

Found by Linux Verification Center (linuxtesting.org) with SVACE static
analysis tool.

Signed-off-by: Leonid Arapov <arapovl839@gmail.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
index c3329c8b4c169..7ddbb3422ea8b 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
@@ -2738,9 +2738,13 @@ int dispc_ovl_setup(enum omap_plane plane, const struct omap_overlay_info *oi,
 		bool mem_to_mem)
 {
 	int r;
-	enum omap_overlay_caps caps = dss_feat_get_overlay_caps(plane);
+	enum omap_overlay_caps caps;
 	enum omap_channel channel;
 
+	if (plane == OMAP_DSS_WB)
+		return -EINVAL;
+
+	caps = dss_feat_get_overlay_caps(plane);
 	channel = dispc_ovl_get_channel_out(plane);
 
 	DSSDBG("dispc_ovl_setup %d, pa %pad, pa_uv %pad, sw %d, %d,%d, %dx%d ->"
-- 
2.39.5


