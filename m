Return-Path: <stable+bounces-164590-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FC6B107E7
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 12:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD3AE4E7903
	for <lists+stable@lfdr.de>; Thu, 24 Jul 2025 10:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 200E6267732;
	Thu, 24 Jul 2025 10:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b="IVZvlrzM"
X-Original-To: stable@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A3C2676E9;
	Thu, 24 Jul 2025 10:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753353625; cv=none; b=tLzj/79ZXCyhZ+PzUS88TiWlpsNaqeFUjcx5OxSD9S4BirrlInzcAogzzpu6JIdyqeH+yPqupp9w7/nMUlwNAHpdJ4N7DiffKy5DJAQF30uKTMVUagiz9m9E7P6DFre7/aVGsZEXOCLitLUs/HOnUTSSyc1QWZgHUK90LpRDUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753353625; c=relaxed/simple;
	bh=0vefUBiAWQYh2/3REMI7EF97twDh4DDuzRSmvvySUiU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g4hFWrkK+Lwxv+DFJ8N+Z0vq6707uNlP8OSI72tuiD9iOnMMCr/T2VOawzfARUjAY0kxaVQl0MRwBz5YkiiBKjERnehipS3wDx5RlCK/RaiqPIOGplQw3mcnjit6BTs0vKt2cUQHD+Iu+A6x47PoyKc83sNapFRF3+r49qjTi0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b=IVZvlrzM; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
DKIM-Signature: v=1; a=rsa-sha256; d=aladdin.ru; s=mail; c=simple/simple;
	t=1753352697; h=from:subject:to:date:message-id;
	bh=0vefUBiAWQYh2/3REMI7EF97twDh4DDuzRSmvvySUiU=;
	b=IVZvlrzM7XgROlM2SvvSleF3Z4ZrFYTtzyDrPbeVBCmEJ/V2dNFwVdTWpX3OV6lzkW/V7w+FV28
	OAEtMGbHy0IJyJCo+EX1c4DIgrziMlH7zrHxS2g76b3OqLV3moS3hvqh3Ptqkr3Cqf1+2hspCxbB9
	Cp+Il7vDkPM/OzLKtW6DLnxfC2VIj0lEtAnfAGPR+U9yEUxY9v/6O8KSDSqQlni0pJf37WH1OMziZ
	VqXj8i2aAlkhCqr06cWaGh7FsZQPVImiLmJ9hiJSyF81ESBJX+SXzf0sS3VFlzKL77Nk6o682AIwi
	M8plSBHPJuKsL/KXSS17vqxi+20fPH307i3A==
From: Daniil Dulov <d.dulov@aladdin.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Harry Wentland
	<harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
	<siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
	<airlied@linux.ie>, Simona Vetter <simona@ffwll.ch>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, "Rodrigo
 Siqueira" <rodrigo.siqueira@amd.com>, Jerry Zuo <jerry.zuo@amd.com>, Alex
 Hung <alex.hung@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 5.10] drm/amd/display: Pass non-null to dcn20_validate_apply_pipe_split_flags
Date: Thu, 24 Jul 2025 13:24:48 +0300
Message-ID: <20250724102449.63028-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

From: Alex Hung <alex.hung@amd.com>

commit 5559598742fb4538e4c51c48ef70563c49c2af23 upstream.

[WHAT & HOW]
"dcn20_validate_apply_pipe_split_flags" dereferences merge, and thus it
cannot be a null pointer. Let's pass a valid pointer to avoid null
dereference.

This fixes 2 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Daniil: Changes to dcn21_fast_validate_bw() were dropped since the function
  is not inplemented in 5.10.y. Also dcn20 and dcn21 were moved from
  drivers/gpu/drm/amd/display/dc to drivers/gpu/drm/amd/display/dc/resource
  since commit 8b8eed05a1c6 ("drm/amd/display: Refactor resource into component
  directory"). The path is changed accordingly to apply the patch on 5.10.y ]
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
Backport fix for CVE-2024-49923

 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index b4bff3b3d842..029aba780d83 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -2847,6 +2847,7 @@ bool dcn20_fast_validate_bw(
 {
 	bool out = false;
 	int split[MAX_PIPES] = { 0 };
+	bool merge[MAX_PIPES] = { false };
 	int pipe_cnt, i, pipe_idx, vlevel;
 
 	ASSERT(pipes);
@@ -2869,7 +2870,7 @@ bool dcn20_fast_validate_bw(
 	if (vlevel > context->bw_ctx.dml.soc.num_states)
 		goto validate_fail;
 
-	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, NULL);
+	vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
 
 	/*initialize pipe_just_split_from to invalid idx*/
 	for (i = 0; i < MAX_PIPES; i++)
-- 
2.34.1


