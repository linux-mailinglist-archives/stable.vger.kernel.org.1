Return-Path: <stable+bounces-64844-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AFF7943ABC
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 02:19:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B9DF1C21B23
	for <lists+stable@lfdr.de>; Thu,  1 Aug 2024 00:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A488F70;
	Thu,  1 Aug 2024 00:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oOtNJbPd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F0E634;
	Thu,  1 Aug 2024 00:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722471020; cv=none; b=RGoF5IGBXnK0hWT9rjzD9kvhu7CKNhRZ93rwZPTRnYB/GR2D0spNJb3AhPU68fRo4iwOmEsbQnkfEWzwP9elnl/nOWAatjJk6KaEgh9RUWZKfoIJknfXAKovfchsNkQWInRyj/ydzBlDCsrsosLwQgm70kXDm2KUGvm5AaZF49Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722471020; c=relaxed/simple;
	bh=9uq9hU9Kf4NkxDp1BJZg/eWYxzZPlBlb+KcL7Ctq3xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NHBwxSmLxCHOgnEH+pk1FPUBql8cO9hKnkBzdS5CK5AkHxJNL5U7vwruAljpp3OVpi9cdFypS77I+D3PHWAD59vTt+QvnQ2vnJ8lUaYHQ1rLmGngymQLDvBmHmSQ10mZ3P5/nJYLvD6n+sPQpywKhM2ClUTLnv8ETM/a7NECJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oOtNJbPd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D43FC116B1;
	Thu,  1 Aug 2024 00:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722471019;
	bh=9uq9hU9Kf4NkxDp1BJZg/eWYxzZPlBlb+KcL7Ctq3xY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oOtNJbPdNls+Z9ygIOlqdvWHm6XmXga9/JG35hrZ8JFFk1tyhEuqK+xhD1YW9Qis4
	 wM6bj0hMqRO5l2WCcYdlofANilT28CmxR5u+5IDJtkNGIDwTRv4/wyfrMlbb2hoDeO
	 tjQKnNyP4yYUFkYeTRyQx/N2cIpg7vLlLGbw22hLP9BBTS8Qya8ZlGwwqbsAozYvcu
	 NEQBhCvC/Mk9fariOnHtVZnLI9KYipFeXPUhP4nYCyGdXlFT34EkIHzyq80g071zrz
	 bDdquZ2WJJ97BuOSmZT40pwUJoso7wQwfQkcJrOmzAx1jIvsDuUTN8sJ+muVaJe0SX
	 sd+WHcdd5Sxdw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
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
	hamza.mahfooz@amd.com,
	lewis.huang@amd.com,
	mghaddar@amd.com,
	michael.strauss@amd.com,
	srinivasan.shanmugam@amd.com,
	Bhawanpreet.Lakha@amd.com,
	amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.10 019/121] drm/amd/display: Skip updating link encoder for unknown eng_id
Date: Wed, 31 Jul 2024 19:59:17 -0400
Message-ID: <20240801000834.3930818-19-sashal@kernel.org>
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

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit efabdce3db9f3d306084c8946983f3d895810a6b ]

This prevents accessing to negative index of link_encoders array.

This fixes an OVERRUN issue reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/link/link_factory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_factory.c b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
index cf22b8f28ba6c..2c3f5d6622851 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_factory.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_factory.c
@@ -390,7 +390,7 @@ static void link_destruct(struct dc_link *link)
 		 * the dynamic assignment of link encoders to streams. Virtual links
 		 * are not assigned encoder resources on creation.
 		 */
-		if (link->link_id.id != CONNECTOR_ID_VIRTUAL) {
+		if (link->link_id.id != CONNECTOR_ID_VIRTUAL && link->eng_id != ENGINE_ID_UNKNOWN) {
 			link->dc->res_pool->link_encoders[link->eng_id - ENGINE_ID_DIGA] = NULL;
 			link->dc->res_pool->dig_link_enc_count--;
 		}
-- 
2.43.0


