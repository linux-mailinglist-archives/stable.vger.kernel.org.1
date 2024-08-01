Return-Path: <stable+bounces-65001-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C37F943D6C
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:58:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 223101C220D7
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD641A4FDC;
	Thu,  1 Aug 2024 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mjaIZDDs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9938016DEC7;
	Thu,  1 Aug 2024 00:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471903; cv=none; b=sVuhj5pvOJN7nnM2ZqeswER/PsNE87HNz4Qbp3qthlswTRhS5mj87SPhUT0PHVQtdPbWvLyXtyz9RELRpZFGpQnrurV1/hX/Zc5vJtDuRDLSm0wv+1+gl5Lm/wEhKorGeVt+ZnhyF8uXyRFxUv+zQl4KfP4+xsjZFt0/cAXIpoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471903; c=relaxed/simple;
	bh=GCYeZ+s1AD2VNXhrhF1gjDx7P1Cnb4MLBbCIKetoeSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NvdB8X1ot+K/fI2jg/lvWttF1d4JBJbQhXT5rCq6qGIh7+ZIH45zicRFpmy1ysOBGVA3HE3jDQ4Gh8pRB1tK4I3iZAZLM/TOjuLnoHObiYB2i5BEDXR23/w8dVB52oH9wIE1TFjz7QKMROLi3aj2csqHsyvIuvi0LPQVFh04xPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mjaIZDDs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4173C4AF0E;
	Thu,  1 Aug 2024 00:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471903;
	bh=GCYeZ+s1AD2VNXhrhF1gjDx7P1Cnb4MLBbCIKetoeSc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mjaIZDDsSP7wmB9+sFA2mJhQXn9hPCDO4DHAEZJq1lk2rO5qUcYd70CHjxErXQFCv
	 v8SgbeXxlnNjNPaSt4sPsycKkU3bTeJIpZ8SCUpWo4gSGSdBKfm5suobkPRfTyNOiI
	 OhM7DuCIjmgyfD4MnvnTrrNJR//nzM4LHJ7tswuD/rcwdvllKvOhdGia2Bi4K/fqDK
	 f+v7Ff3HOyApEDWu3KUYEBFKzsko+LYMHf412hcJNuHKf13RuxgOq0TvigWc0heFGp
	 lcaSi+EIrN/d/J1LUvdH07Yo/OvvjSluFYV/yAOl8l+JSd2k5WSYaGnbpoFZPdbf7m
	 tAXwU7CZR7TPQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Hamza Mahfooz <hamza.mahfooz@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 55/83] drm/amd/display: Skip wbscl_set_scaler_filter if filter is null
Date: Wed, 31 Jul 2024 20:18:10 -0400
Message-ID: <20240801002107.3934037-55-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit c4d31653c03b90e51515b1380115d1aedad925dd ]

Callers can pass null in filter (i.e. from returned from the function
wbscl_get_filter_coeffs_16p) and a null check is added to ensure that is
not the case.

This fixes 4 NULL_RETURNS issues reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
index 994fb732a7cb7..a0d437f0ce2ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_dwb_scl.c
@@ -690,6 +690,9 @@ static void wbscl_set_scaler_filter(
 	int pair;
 	uint16_t odd_coef, even_coef;
 
+	if (!filter)
+		return;
+
 	for (phase = 0; phase < (NUM_PHASES / 2 + 1); phase++) {
 		for (pair = 0; pair < tap_pairs; pair++) {
 			even_coef = filter[phase * taps + 2 * pair];
-- 
2.43.0


