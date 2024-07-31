Return-Path: <stable+bounces-64873-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A95943B59
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E79B28319B
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A9414430D;
	Thu,  1 Aug 2024 00:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f0Jmjed7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A26143C4E;
	Thu,  1 Aug 2024 00:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471256; cv=none; b=sQHUtWXNDVlMQjRKz9CSwthKp2GVhlF7aS2o1RPEaLHSfjzHUOWD7RZhyaGqHlPKR/T0GLDCi292Cwx7Y2qCDLaBzTBZXAvo0QHxxzHu8ldJNIkZ3df8NRh9eVpwGt6vz9WHA22nbVxvdDyhioeP5/4as9mA2HyfXTDYKWehrIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471256; c=relaxed/simple;
	bh=X1ygmkzR7iQ9ChJg9ifR7HYOC9jn7JAbiVAuHWbZjDg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NM8+V23lQZR34CrySbDfGFDfajbaxd85xbd6Hy4GcSVrNIHgh7QDqILKO7T9ooz/EOWRHrwF3pt2o+2OaHPdoqSnybhmw2jZ9wKHOIkoaMNHAh3vdKBYCx0+GUNBt7QxVmwfwY9ARiXqehZgJZMS+JCr1aizJ96xvqZFsoleCbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f0Jmjed7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E4EC116B1;
	Thu,  1 Aug 2024 00:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471255;
	bh=X1ygmkzR7iQ9ChJg9ifR7HYOC9jn7JAbiVAuHWbZjDg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f0Jmjed7D4a2+25IAxfqensLSFh9L3DIfYBdu8MUsePyuLhPWZ1jjV+SbPmz5RlUO
	 rh82Cds7BI1B15bJaBeYhu7wG6hx1GvN/qafoZK3OjF2Py9+X0SiBAPHEelJBa3De8
	 qaltfOGj36OYLFZztNSNROVlwTkxLuIx6IWGW2T88y/fREk/stL7MV1v62q2JYxG2l
	 taT4jFh0dnensB5GKBPhruP6oAgNKBAuFmzqNPZzg4EpL6WBPLARJh1dYQWTKaljWz
	 fM+VdvnvSeWPaMLglmCKsQI8/hvVHBw6IWEPyBPHwSqxRVG897Yndks8bflELZfcZZ
	 J7fQSY8iyWx6Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicholas Susanto <nicholas.susanto@amd.com>,
	Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
	Roman Li <roman.li@amd.com>,
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
	charlene.liu@amd.com,
	alex.hung@amd.com,
	daniel.miess@amd.com,
	dillon.varone@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 048/121] drm/amd/display: Fix pipe addition logic in calc_blocks_to_ungate DCN35
Date: Wed, 31 Jul 2024 19:59:46 -0400
Message-ID: <20240801000834.3930818-48-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801000834.3930818-1-sashal@kernel.org>
References: <20240801000834.3930818-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
Content-Transfer-Encoding: 8bit

From: Nicholas Susanto <nicholas.susanto@amd.com>

[ Upstream commit 3aec7a5af4d6248b7462b7d1eb597f06d35f5ee0 ]

[Why]

Missing check for when there is new pipe configuration but both cur_pipe
and new_pipe are both populated causing update_state of DSC for that
instance not being updated correctly.

This causes some display mode changes to cause underflow since DSCCLK
is still gated when the display requires DSC.

[How]

Added another condition in the new pipe addition branch that checks if
there is a new pipe configuration and if it is not the same as cur_pipe.
cur_pipe does not necessarily have to be NULL to go in this branch.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Nicholas Susanto <nicholas.susanto@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 5f60da72c6f58..68ac4dee79f79 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1095,7 +1095,8 @@ void dcn35_calc_blocks_to_ungate(struct dc *dc, struct dc_state *context,
 			continue;
 
 		if ((!cur_pipe->plane_state && new_pipe->plane_state) ||
-			(!cur_pipe->stream && new_pipe->stream)) {
+			(!cur_pipe->stream && new_pipe->stream) ||
+			(cur_pipe->stream != new_pipe->stream && new_pipe->stream)) {
 			// New pipe addition
 			for (j = 0; j < PG_HW_PIPE_RESOURCES_NUM_ELEMENT; j++) {
 				if (j == PG_HUBP && new_pipe->plane_res.hubp)
-- 
2.43.0


