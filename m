Return-Path: <stable+bounces-64997-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647B0943D64
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:57:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CB882835BD
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:57:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 902D71C5E93;
	Thu,  1 Aug 2024 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rp6zm/O5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D5741C5E68;
	Thu,  1 Aug 2024 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471884; cv=none; b=iDqKJ0GXdpUM275WF0cTSBmSF6KaWUKhZK2KtFOolacXZQv8tl0i4yNfcstO5h59emAAcJawnPC57z0upn7ledMKwMizf8cMf8RFIjOVm8uAz2cAtSUaBbPUi0Vq55nl08w/av52+w9rP12v1lhsJrjriZbj7A71NSfZs+HHFDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471884; c=relaxed/simple;
	bh=33K2KQ2UCBY2K6eR3q27pBpmbJri+Oj+oWH2YTGzw2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HZF1BkJCryQrvoKC5GJzAJxpauoLo61AvOhwHj97NwV04Ss7LrHlJ7H/fDStdkvo5UtdDRZ50/oZWPe2WX/16BPvjFmosiRU8UKmTKbvoBV8zu8VSGxBasOszW+wFU7+NtdxpR7XbyRzzASuehvIH9+/DSzDYCNvGok8FxoG7aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rp6zm/O5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51382C32786;
	Thu,  1 Aug 2024 00:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471884;
	bh=33K2KQ2UCBY2K6eR3q27pBpmbJri+Oj+oWH2YTGzw2g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rp6zm/O50hUO5j8+psm2Sohn9lZbWLXaYK9jfihfDlQ1UYjyOkH3n8VINCE2zFp/W
	 OalwymPexHD0HZC+3AMHCEzhswP9o44l+1gGpI7Uvq9kMDxmhVjQ7oa7amHCmDaXxK
	 PGEqLR7yl+oBVX1iUGfm7IQOZmJwnKGA+0dSvCFTgCgEE5NxNYQRI/DH46OYW6aIYB
	 iZuH74MOTXSTZOeOZMvag4VZNjwB28lhmax775RkxvSnc7v5tR5Cn5Eow3v+DLp3/i
	 Uw21u2TjiVFvmQth9bj5DifYt3DeGYKQ7BGnV5KZLtrhV0/TcUg65E0ITonIw1t8zc
	 7EEe8u9WxTiWw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: winstang <winstang@amd.com>,
	Alvin Lee <alvin.lee2@amd.com>,
	Zaeem Mohamed <zaeem.mohamed@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>,
	harry.wentland@amd.com,
	sunpeng.li@amd.com,
	Rodrigo.Siqueira@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	daniel@ffwll.ch,
	wenjing.liu@amd.com,
	jun.lei@amd.com,
	alex.hung@amd.com,
	hamza.mahfooz@amd.com,
	george.shen@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 51/83] drm/amd/display: added NULL check at start of dc_validate_stream
Date: Wed, 31 Jul 2024 20:18:06 -0400
Message-ID: <20240801002107.3934037-51-sashal@kernel.org>
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

From: winstang <winstang@amd.com>

[ Upstream commit 26c56049cc4f1705b498df013949427692a4b0d5 ]

[Why]
prevent invalid memory access

[How]
check if dc and stream are NULL

Co-authored-by: winstang <winstang@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
Signed-off-by: winstang <winstang@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 84923c5400d32..733e445331ea5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3927,6 +3927,9 @@ void resource_build_bit_depth_reduction_params(struct dc_stream_state *stream,
 
 enum dc_status dc_validate_stream(struct dc *dc, struct dc_stream_state *stream)
 {
+	if (dc == NULL || stream == NULL)
+		return DC_ERROR_UNEXPECTED;
+
 	struct dc_link *link = stream->link;
 	struct timing_generator *tg = dc->res_pool->timing_generators[0];
 	enum dc_status res = DC_OK;
-- 
2.43.0


