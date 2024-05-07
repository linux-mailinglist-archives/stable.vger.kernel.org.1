Return-Path: <stable+bounces-43229-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DBB8BF059
	for <lists+stable@lfdr.de>; Wed,  8 May 2024 01:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A59CB1F216BE
	for <lists+stable@lfdr.de>; Tue,  7 May 2024 23:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCB6812DD98;
	Tue,  7 May 2024 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tg5CH+9u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2A512D1EF;
	Tue,  7 May 2024 22:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715122708; cv=none; b=VHytRpA56Uz4lnKOfmt16x0diRDwPAS8AJNK0bPLlRDuEQyYzXUlANp+NORLjr9UcGhADaNlj2GDMjHvjsuwCTJdU59e54zu9xf7TAxFVZ09YcwfEbZxwkDc0zPC3kWV4u7jo8crpu7A70MivX+Tc1beSAS6hpfp6Jhl7AvnIK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715122708; c=relaxed/simple;
	bh=mpjbINDW+2/d3FdYR5rsR9d7Larq23IABHZvwgNlCbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxtKVBJ6tDQVFreJyw/FAaVHBChJcAdAL4ri4h+nY4RzB6fP6io3QdFWbuvl9AdPRDRMH8AfOl5C+sk4V+KemiRIMLVvyDL/y3Ir5zItszy36E6y600MR1JcfSywYhB0hVDLPPneFEQHcMVjAzB7JtoKsGwjMbNzDK+ZffJf2+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tg5CH+9u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DC18C4AF67;
	Tue,  7 May 2024 22:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715122708;
	bh=mpjbINDW+2/d3FdYR5rsR9d7Larq23IABHZvwgNlCbk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tg5CH+9utiASQl7G9wkgELfEEGYFcbzQiGydxi0L8Gp8f/VFlP5S/jRejv/S8Tub/
	 pcIVjOG3Y4og1YbwED5PSM+Cn4D4FlKK3Uc4HmDLkz9UrTaW1Wz3YFeQ5EJBs/1z2z
	 xKDGzS3lTS8/vNeLinvdVnl3siUtYmO69L8ZtxAySS7mjHooAiADPrQry9lA0YTlAw
	 aNFi0EawUdVW9HGBJSHo4yYQ2cq/WFoPKq431vlJ/7HPt9i4il7TQqlbwPgAkzZkQh
	 Mvd8Phkk8OYOx+WsL2/dq6L6oYZjrAAzFBrrXN2TuPPxgkQmm/8E2PLn1n2bkk3LSc
	 gNVcTMU7uawkA==
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
Subject: [PATCH AUTOSEL 6.8 19/23] drm/etnaviv: fix tx clock gating on some GC7000 variants
Date: Tue,  7 May 2024 18:56:45 -0400
Message-ID: <20240507225725.390306-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240507225725.390306-1-sashal@kernel.org>
References: <20240507225725.390306-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.9
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
index 9b8445d2a128f..89cb6799b547f 100644
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


