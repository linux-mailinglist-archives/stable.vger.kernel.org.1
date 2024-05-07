Return-Path: <stable+bounces-43251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7640D8BF095
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CAE281A09
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:08:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18F61353E2;
	Tue,  7 May 2024 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKONpd7b"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB2E1350EC;
	Tue,  7 May 2024 23:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122808; cv=none; b=bVDYbYih6s7XOHlGK1CuljzqtH58nqh1z0D6rRk2w0oR78NZZIpjIrNN+zzns2dxXyO5y+9RRrThFY5A7CTwEsclrJ6VavR8te+YoJHmOsnm5djhZbrg/O9gzrGP8vQij3CXWPNWZSyK9MhkjOqEX2OT2t7L0pAHWtT8tgmGYpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122808; c=relaxed/simple;
	bh=+RiuBApR4VmUwmiO5W+rxSWu8QrEJw7Lo7Dza+YXVn4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czX8W0q7LNaDnOZP5KePoxktSygeQuO91QhmMbwY2XP7FS5NDSCx74gGf6Ay+Yix1JI4huWFEXE34QzQfwS00z7CaoatPzDfZqQIvvSBiZyyrVdtWUncvAYl92dQN85WZLbjM/mnsU41EUMLvM9fcZUaenoQ5pESZAkJovVNkBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKONpd7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB7EC3277B;
	Tue,  7 May 2024 23:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122808;
	bh=+RiuBApR4VmUwmiO5W+rxSWu8QrEJw7Lo7Dza+YXVn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gKONpd7bHI/iI8g1LHSghbCRhNqmDe7yAn14A0EJNn9H3stAh+6kHndWymKePHAlz
	 QZwhC3sgNy1LtQIgJMWShOdCWbRkTIxuW9eHI7eaXyRAhJ4nQqJrYvuUz8N7O8saEZ
	 hp1BJe7dwpb8WZGfYCMiyy+Na4NDQWKaKp/sprYCvYitVC5kzDn80kqnX24jqHagPP
	 H0AgPT1GIFOo0MP8NnTcAkzUQzqYFhBrIpC7CTkUdnW9zwPelfUfidjRCSgBDGTEwU
	 DYEn7nhHNrhE8fvtFq8LauRQCxY8PhC5Sb1WFubtcqgxH+QrnC6hzTcKAqLUA7Sdq8
	 5fCgaRJNHqxeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Derek Foreman <derek.foreman@collabora.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	airlied@gmail.com,
	daniel@ffwll.ch,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 17/19] drm/etnaviv: fix tx clock gating on some GC7000 variants
Date: Tue,  7 May 2024 18:58:39 -0400
Message-ID: <20240507225910.390914-17-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225910.390914-1-sashal@kernel.org>
References: <20240507225910.390914-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.30
Content-Transfer-Encoding: 8bit

From: Derek Foreman <derek.foreman@collabora.com>

[ Upstream commit d7a5c9de99b3a9a43dce49f2084eb69b5f6a9752 ]

commit 4bce244272513 ("drm/etnaviv: disable tx clock gating for GC7000
rev6203") accidentally applied the fix for i.MX8MN errata ERR050226 to
GC2000 instead of GC7000, failing to disable tx clock gating for GC7000
rev 0x6023 as intended.

Additional clean-up further propagated this issue, partially breaking
the clock gating fixes added for GC7000 rev 6202 in commit 432f51e7deeda
("drm/etnaviv: add clock gating workaround for GC7000 r6202").

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index 9276756e1397d..371e1f2733f6f 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -632,8 +632,8 @@ static void etnaviv_gpu_enable_mlcg(struct etnaviv_gpu *gpu)
 	/* Disable TX clock gating on affected core revisions. */
 	if (etnaviv_is_model_rev(gpu, GC4000, 0x5222) ||
 	    etnaviv_is_model_rev(gpu, GC2000, 0x5108) ||
-	    etnaviv_is_model_rev(gpu, GC2000, 0x6202) ||
-	    etnaviv_is_model_rev(gpu, GC2000, 0x6203))
+	    etnaviv_is_model_rev(gpu, GC7000, 0x6202) ||
+	    etnaviv_is_model_rev(gpu, GC7000, 0x6203))
 		pmc |= VIVS_PM_MODULE_CONTROLS_DISABLE_MODULE_CLOCK_GATING_TX;
 
 	/* Disable SE and RA clock gating on affected core revisions. */
-- 
2.43.0


