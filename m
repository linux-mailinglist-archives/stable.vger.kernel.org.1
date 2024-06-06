Return-Path: <stable+bounces-48724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B16738FEA36
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:18:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAA4D1C24155
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3000419EEA7;
	Thu,  6 Jun 2024 14:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nDVXwRWO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E445B19EEA1;
	Thu,  6 Jun 2024 14:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683116; cv=none; b=CQvPmPkbSDlCTIfizTdVPZCRf7MH9FoYGcIOd8nuSsa93qRNnyTfEqJlLDr9ExZOQmaLQ3P4zFHbM6FAsdU2zCEB2frNZCZ5+l+M4ip9B//7R1GO+NvTssBPfVVNpC+nH5fTzVwMN321GO7dk3F7524TcJ7VeWFeFMC1vYtB8ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683116; c=relaxed/simple;
	bh=o4SKiWa0uZBdcivBJiBumXor8sX+9HTCgTTXBbRRhPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKx9P3O5zVBOKThaO+zxgFxRVV1OZWCmyS6ImMXlZ40FUOY+HiwmABYhO6Xvxu9Ey4AIF7vs36dlkt699DGJlK0ZOHXVA4Q0EdTpN9IIT1RklxJASo9sntNIy2VaGVZol+hvTawrvS1PvCRF8ULIQC8HaWaKd+bBos58pfVs6s4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nDVXwRWO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1006C32781;
	Thu,  6 Jun 2024 14:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683115;
	bh=o4SKiWa0uZBdcivBJiBumXor8sX+9HTCgTTXBbRRhPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDVXwRWOY6Rnb0M4xZ9RUoAX6E5jXK3VA0o3AzjZp7jcINaNk3upeZZ7w+r8QHfbB
	 bfDvi07JHlN4YkUxbZwwT7ttZXIz4GRx6X5kXbTUEWvUm1CpG3bLCAC5ZlhSHjrTyl
	 ZZYuGei72pLeOIVOgyeOT+RiV8zJHLH05mK6QSwA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Derek Foreman <derek.foreman@collabora.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 050/744] drm/etnaviv: fix tx clock gating on some GC7000 variants
Date: Thu,  6 Jun 2024 15:55:22 +0200
Message-ID: <20240606131734.046731645@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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




