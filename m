Return-Path: <stable+bounces-77496-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168F0985DCD
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D7E9287722
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F9C204912;
	Wed, 25 Sep 2024 12:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bakhi7AS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ACA1B4C3B;
	Wed, 25 Sep 2024 12:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266029; cv=none; b=UcG+6e2WDpz//K0ploMrAtHimiA+iXbxBQ3KmZzsmgORZeF0NDDWa5arJkMdy56MhZdEXz9XOzksVIHxqxJyXMXoJ3yHFo7Hw5GuwGsWoD1vtUa9X/bbTfGS1fxsdmEqCsSyUokYCoWr0YekNTpV5Mz1Vf/v+vCqnMjcg5Fi3co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266029; c=relaxed/simple;
	bh=vc6yD9jjehmseCavxHBwU7jeCBx7Sc9m0zuowjSxheo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhU202QeChM3KHA1eezmujhSkqq++YUNxj71zbLIt7xjkveheCMyEhR1rJ8RMS6xbQNOjF1+zaDoE5BOCoycQyJjAlMhEGZlhcHLi5l7zFPGtU49Biv+WfQDYmk6vxe0ikwpi+kNJRzA2pmM++cPnl8OZ6f7PXdifPLDBf58S30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bakhi7AS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA9B2C4CEC3;
	Wed, 25 Sep 2024 12:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266028;
	bh=vc6yD9jjehmseCavxHBwU7jeCBx7Sc9m0zuowjSxheo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bakhi7ASpVXaQO67pvzUBPsAU9NJkkSlJCccccgLZlKOux74LmDJFSx6mdF9ZNsTo
	 m+5EqfATHm7QZxJ1MDI5S/64Py8ZnHsoRsoLfgfU6jLKL0qhEPgc2Nzzjf0efexRp7
	 YXK6y7LBdxkzJpMfC0paAuZrypuqaGeIeu5mpAPSshkOWWcv2HuZ0SdIabCndY2jIj
	 hITPgC9/yDqP86/NqqtGM2rwuKqqeCEXimohehOVYJQAwzTWSI1erhLWTGqfYdWWbG
	 DOB04uRi8ul+O4sWtfcccm9C7NAqMwMLd2RhZM06Dg0vK3qeGgeAng9frL4fkR7jfH
	 I37VXcOmNf6Ww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
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
	alvin.lee2@amd.com,
	george.shen@amd.com,
	dillon.varone@amd.com,
	aurabindo.pillai@amd.com,
	gabe.teeger@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 151/197] drm/amd/display: Check stream before comparing them
Date: Wed, 25 Sep 2024 07:52:50 -0400
Message-ID: <20240925115823.1303019-151-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925115823.1303019-1-sashal@kernel.org>
References: <20240925115823.1303019-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.11
Content-Transfer-Encoding: 8bit

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
index 7462c34793799..58f6155fecc5a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3134,6 +3134,8 @@ static bool are_stream_backends_same(
 bool dc_is_stream_unchanged(
 	struct dc_stream_state *old_stream, struct dc_stream_state *stream)
 {
+	if (!old_stream || !stream)
+		return false;
 
 	if (!are_stream_backends_same(old_stream, stream))
 		return false;
-- 
2.43.0


