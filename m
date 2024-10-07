Return-Path: <stable+bounces-81209-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A73A99234D
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 05:59:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A54F283CD1
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 03:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C23143A1AC;
	Mon,  7 Oct 2024 03:59:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from lechuck.jsg.id.au (jsg.id.au [193.114.144.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B7738F97
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 03:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.114.144.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728273567; cv=none; b=lT5o8YH3kLdHlkBSQne8EaAwhsdeEv6hl5wet2grpBBScL+GnhwHZCqqRiw9C+buq11GrsklHWLJe+JNcdLkqlRmP6hcfRC3ul8S40wnD/6fv33njHyIhqQGQ4cJM67dbl3h2gEB7U2+o9F+7X6Wtfy2aE72Q9kTqTIC9amokpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728273567; c=relaxed/simple;
	bh=8gMvPgrCvzA61EIDjy3qIP5ktXb4VELgJOkp+VqWim8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tzT3yvSY+eNXmcspDDxvrv4c/GLlywTkA5+BY/HWt6V+WdrKByiD85Euu3JAdIGPim6UBCybwpgWCH+OWnxcq2F9gFj5ut1JxLm0GtoD14ENiyyj4eTptyHqA0DPZ0OwjplX5UEiMK64Yd2cAYJIbikuFRIuSGMPbIBkvZFZBtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au; spf=pass smtp.mailfrom=jsg.id.au; arc=none smtp.client-ip=193.114.144.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jsg.id.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jsg.id.au
Received: from largo.jsg.id.au (largo.jsg.id.au [192.168.1.44])
	by lechuck.jsg.id.au (OpenSMTPD) with ESMTPS id 259a6079 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 14:59:22 +1100 (AEDT)
Received: from largo.jsg.id.au (localhost [127.0.0.1])
	by largo.jsg.id.au (OpenSMTPD) with ESMTP id f022e239;
	Mon, 7 Oct 2024 14:59:22 +1100 (AEDT)
From: Jonathan Gray <jsg@jsg.id.au>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org
Subject: [PATCH 6.11.y] Revert "drm/amd/display: Skip Recompute DSC Params if no Stream on Link"
Date: Mon,  7 Oct 2024 14:59:22 +1100
Message-ID: <20241007035922.55322-1-jsg@jsg.id.au>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit d45c64d933586d409d3f1e0ecaca4da494b1d9c6.

duplicated a change made in 6.11-rc3
50e376f1fe3bf571d0645ddf48ad37eb58323919

Cc: stable@vger.kernel.org # 6.11
Signed-off-by: Jonathan Gray <jsg@jsg.id.au>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 6c72709aa258..dd6217b3a0d6 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -1344,9 +1344,6 @@ static bool is_dsc_need_re_compute(
 	DRM_DEBUG_DRIVER("%s: MST_DSC check on %d streams in current dc_state\n",
 			 __func__, dc->current_state->stream_count);
 
-	if (new_stream_on_link_num == 0)
-		return false;
-
 	/* check current_state if there stream on link but it is not in
 	 * new request state
 	 */
-- 
2.46.1


