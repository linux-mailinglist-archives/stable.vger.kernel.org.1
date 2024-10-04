Return-Path: <stable+bounces-80921-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD4E990CC3
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 20:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47246281F66
	for <lists+stable@lfdr.de>; Fri,  4 Oct 2024 18:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69A4E1FE49D;
	Fri,  4 Oct 2024 18:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3IQtncK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B901FE49E;
	Fri,  4 Oct 2024 18:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066246; cv=none; b=aUjuHgX/oX5gf7Q92D4TWCbf7s7Bv8MqsH9Hh8+9rT1Tr2GYxbqICfIzehGqOGWkIn/ZRC9m9WSCD0VNagPJYVuTpfZG2ZpCw1eq07tBXOrAhRj/AOg6G9mdvhXpwgqIW54kGP0t496s8USalhj1MphTUG7dAhxQcN4Doun7H00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066246; c=relaxed/simple;
	bh=uaCsyk/8Q1WkDlCkvPx6grACTOhl/XaO4310uT5XGfg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k95046LXPjdS+5iOK+mVpbdnR/LNZvQI3P9PCgzRUteF5L7Rmz83/V2m/MloNl87L1WkWvJeWhq3bay6oDYOfqM1zV9vkEppA/4sZ78TdxwpPZqXXjLWfkuSGRSrambMUIwhL7IweBXlTPLGM1bLJ6C9btxZAauCaOv85hHgYV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3IQtncK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F704C4CEC6;
	Fri,  4 Oct 2024 18:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066245;
	bh=uaCsyk/8Q1WkDlCkvPx6grACTOhl/XaO4310uT5XGfg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h3IQtncKq73pc7NF//GpfBtCmGOPVwjlRo8dj7/3ocRodBr1bRkoZNxrF059wC1zL
	 tj3YeQViQJP9s0+0qceWIE91ScsVTU49zHeOKSoL+j4CwNA5essHaa0e9585/icKAP
	 6FALrS754z7byHHbplcXwUSeBI/VODpXe1fRgpHSD7ykJZDMkXF7mWviwKGSCR60jH
	 S2wnG+DVz6JvhWxiRANJ02WHNtCNyhuWaDI/bd/xDYl5mWI+nHNVFiK7SyLc/NXkk3
	 ss7vloLlwB0VR9JzgztWVSyOYHJonhqCNHrG1UCCMdzgs0LZNMl1QD/SWSSPbaB5cV
	 io4OSmxiy+L2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	thomas.hellstrom@linux.intel.com,
	rodrigo.vivi@intel.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 65/70] drm/xe/oa: Fix overflow in oa batch buffer
Date: Fri,  4 Oct 2024 14:21:03 -0400
Message-ID: <20241004182200.3670903-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: José Roberto de Souza <jose.souza@intel.com>

[ Upstream commit 6c10ba06bb1b48acce6d4d9c1e33beb9954f1788 ]

By default xe_bb_create_job() appends a MI_BATCH_BUFFER_END to batch
buffer, this is not a problem if batch buffer is only used once but
oa reuses the batch buffer for the same metric and at each call
it appends a MI_BATCH_BUFFER_END, printing the warning below and then
overflowing.

[  381.072016] ------------[ cut here ]------------
[  381.072019] xe 0000:00:02.0: [drm] Assertion `bb->len * 4 + bb_prefetch(q->gt) <= size` failed!
               platform: LUNARLAKE subplatform: 1
               graphics: Xe2_LPG / Xe2_HPG 20.04 step B0
               media: Xe2_LPM / Xe2_HPM 20.00 step B0
               tile: 0 VRAM 0 B
               GT: 0 type 1

So here checking if batch buffer already have MI_BATCH_BUFFER_END if
not append it.

v2:
- simply fix, suggestion from Ashutosh

Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240912153842.35813-1-jose.souza@intel.com
(cherry picked from commit 9ba0e0f30ca42a98af3689460063edfb6315718a)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/xe_bb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bb.c b/drivers/gpu/drm/xe/xe_bb.c
index 541361caff3b0..5cae7ecfc431e 100644
--- a/drivers/gpu/drm/xe/xe_bb.c
+++ b/drivers/gpu/drm/xe/xe_bb.c
@@ -65,7 +65,8 @@ __xe_bb_create_job(struct xe_exec_queue *q, struct xe_bb *bb, u64 *addr)
 {
 	u32 size = drm_suballoc_size(bb->bo);
 
-	bb->cs[bb->len++] = MI_BATCH_BUFFER_END;
+	if (bb->len == 0 || bb->cs[bb->len - 1] != MI_BATCH_BUFFER_END)
+		bb->cs[bb->len++] = MI_BATCH_BUFFER_END;
 
 	xe_gt_assert(q->gt, bb->len * 4 + bb_prefetch(q->gt) <= size);
 
-- 
2.43.0


