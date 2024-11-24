Return-Path: <stable+bounces-94922-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230099D75DF
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 17:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 091E3B3F795
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C031BD9EA;
	Sun, 24 Nov 2024 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNCCL1nz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C118E76F;
	Sun, 24 Nov 2024 13:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455267; cv=none; b=oGgjF/eZBbCmKm0mEjQJk7SFAvUZuRoEgsAIm9EB3pB31Hoa1Rrt+77ovGFr5LKBpI+0k0/rfuQ33rj4NWg3RxTGvmA8m/U4YEW3q9b6GayawSmqZ8Clp2AhNJVk4zRhhoDYr9b/LXdxLBAoWwVbbVcN0kI57Yc3rYhip584bug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455267; c=relaxed/simple;
	bh=SFYFwHXBUJf7VvheI4s+eT8kQiHMDd5dPLCv8NQQKmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZbh/YhsYf+2dAzWtOiLZdMc2FNPB5El/d/TmHvrAoWCEAco+Cvq/+l4e0wmdZiCdcZa5Mz1lwlAu4DDrZAiRnMjMp2cWafHQJoLFxRXbyryeCitQKmykva7JlgwhO0tpALltgfW6YX26m+SI/4Fo/1DH/Ui51xmpocQ8yE3beU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNCCL1nz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6243FC4CECC;
	Sun, 24 Nov 2024 13:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455266;
	bh=SFYFwHXBUJf7VvheI4s+eT8kQiHMDd5dPLCv8NQQKmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dNCCL1nzGS+6KL6z+tEn31DLf66oTpxv7oOAkw0WHBAlyMcpwoTS6QFMD8bd/IfTR
	 GurTqIVqA/CkoY/MSPrTZVg6ZHk3ReAgyFtCs5cr5WqEPDpXJrzWXqURswt2kInZIC
	 WO7hCut4yl/PRptOSrIZEFJhkKOR7vFydVJo8eLLEAJ5iykqLVY++IbaFoAqm92BnV
	 DckKquwllhzZOkQQxqLIiY4FDSTDgBl9cUojCb4ZahSfZNL2nzvPbYtLP6M/dMKcyQ
	 Nk3g4bsikiY41RfNEO1wWl67mcLMb2K8u1e/pcJzcRz+RuLdceDAp9azUD7h6REhpV
	 h8Cl4fzC0U5Yw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Brahmajit Das <brahmajit.xyz@gmail.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dmitry.baryshkov@linaro.org,
	oleksandr@natalenko.name,
	rdunlap@infradead.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 026/107] drm/display: Fix building with GCC 15
Date: Sun, 24 Nov 2024 08:28:46 -0500
Message-ID: <20241124133301.3341829-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124133301.3341829-1-sashal@kernel.org>
References: <20241124133301.3341829-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.1
Content-Transfer-Encoding: 8bit

From: Brahmajit Das <brahmajit.xyz@gmail.com>

[ Upstream commit a500f3751d3c861be7e4463c933cf467240cca5d ]

GCC 15 enables -Werror=unterminated-string-initialization by default.
This results in the following build error

drivers/gpu/drm/display/drm_dp_dual_mode_helper.c: In function ‘is_hdmi_adaptor’:
drivers/gpu/drm/display/drm_dp_dual_mode_helper.c:164:17: error: initializer-string for array of
 ‘char’ is too long [-Werror=unterminated-string-initialization]
  164 |                 "DP-HDMI ADAPTOR\x04";
      |                 ^~~~~~~~~~~~~~~~~~~~~

After discussion with Ville, the fix was to increase the size of
dp_dual_mode_hdmi_id array by one, so that it can accommodate the NULL
line character. This should let us build the kernel with GCC 15.

Signed-off-by: Brahmajit Das <brahmajit.xyz@gmail.com>
Reviewed-by: Jani Nikula <jani.nikula@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241002092311.942822-1-brahmajit.xyz@gmail.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/display/drm_dp_dual_mode_helper.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
index 14a2a8473682b..c491e3203bf11 100644
--- a/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
+++ b/drivers/gpu/drm/display/drm_dp_dual_mode_helper.c
@@ -160,11 +160,11 @@ EXPORT_SYMBOL(drm_dp_dual_mode_write);
 
 static bool is_hdmi_adaptor(const char hdmi_id[DP_DUAL_MODE_HDMI_ID_LEN])
 {
-	static const char dp_dual_mode_hdmi_id[DP_DUAL_MODE_HDMI_ID_LEN] =
+	static const char dp_dual_mode_hdmi_id[DP_DUAL_MODE_HDMI_ID_LEN + 1] =
 		"DP-HDMI ADAPTOR\x04";
 
 	return memcmp(hdmi_id, dp_dual_mode_hdmi_id,
-		      sizeof(dp_dual_mode_hdmi_id)) == 0;
+		      DP_DUAL_MODE_HDMI_ID_LEN) == 0;
 }
 
 static bool is_type1_adaptor(uint8_t adaptor_id)
-- 
2.43.0


