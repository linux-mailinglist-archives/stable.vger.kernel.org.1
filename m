Return-Path: <stable+bounces-82328-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C5E994C32
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:51:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93C891F22458
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E0F1DE4FA;
	Tue,  8 Oct 2024 12:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lon+L8bd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0E31DE3C1;
	Tue,  8 Oct 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728391895; cv=none; b=NiWF6qG4LTbOEsNyAgomdRh64PJ8UNRX5xIPsrhy6ylNaftrx6TrJkAfli4SxkJUO2RaEH/2jeXyQkz9VcvsBlxWiTGX4UmAwZetNxz5gjgeEG+UByUJp1br9DahoADaez35cPmu7hDITg5HdLocwWLLWksgh+0Fj1yOkCbIdew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728391895; c=relaxed/simple;
	bh=KkWrog+W6vLySSNIlbnAs8FZA3ALH00pfWWlCT0bpkU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYrSM9UmkF4qQWQ6RnD7a759NHnK/i5FjmrBIZHMdx2pBhW7KLCGatu26inVh8PpcuLSeCBxf2RoTCrtu+qQaHpu8i8XNlyFBZ0lNY6o14y3U5MbYDhOUCDF1xACc8gZKC9wrjRW3I2ifsv5/y+cnq9AFe5PGdgvG3u5MwWhVy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lon+L8bd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2D9C4CEC7;
	Tue,  8 Oct 2024 12:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728391894;
	bh=KkWrog+W6vLySSNIlbnAs8FZA3ALH00pfWWlCT0bpkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lon+L8bdK4CLumY50S5cenAEYABll+hknCTD8asdc44n88v2T07tGvMJJNbmO890C
	 oc0E4jVc6mlsNt4Qk9f2jKiArv+1wpPiZu5eaVN+J0e8VI7IH52H2iYn8QxOGQIil3
	 CXnBo6HZIXIGvDui0UB0ITSGvyGw3xegaUjSL1sU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 255/558] drm/amd/display: Check stream before comparing them
Date: Tue,  8 Oct 2024 14:04:45 +0200
Message-ID: <20241008115712.370230296@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 35ff747c86767937ee1e0ca987545b7eed7a0810 ]

[WHAT & HOW]
amdgpu_dm can pass a null stream to dc_is_stream_unchanged. It is
necessary to check for null before dereferencing them.

This fixes 1 FORWARD_NULL issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 67794497457d3..913adca531fc4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3241,6 +3241,8 @@ static bool are_stream_backends_same(
 bool dc_is_stream_unchanged(
 	struct dc_stream_state *old_stream, struct dc_stream_state *stream)
 {
+	if (!old_stream || !stream)
+		return false;
 
 	if (!are_stream_backends_same(old_stream, stream))
 		return false;
-- 
2.43.0




