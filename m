Return-Path: <stable+bounces-95025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C0F9D7256
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCC9716371B
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 880A21CEEB8;
	Sun, 24 Nov 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWVtDp/Y"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464651CEE92;
	Sun, 24 Nov 2024 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455736; cv=none; b=nkwtNMQKqfbsdpR4b3Udauw/VxfJqXDJhytserpo4heqj6BdBnD3d6KPi5+CDo9F8MuJIs04dLnVaYc+aJAuYW6Np0GhIZ7LVzoJ64T0+2Jo5aE59NfPDc5pOzN4Lf2gcAqHaQNEX7PERmJKkWJe7EpZovTNMyPaM1iIexWqqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455736; c=relaxed/simple;
	bh=SFYFwHXBUJf7VvheI4s+eT8kQiHMDd5dPLCv8NQQKmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dDcDei5Pz5SP8FQ9yv9E4gtrxipiay8cnB4fXqh7OpDjIoil4Vn11cs68PM9Xk3bePCUJWW2DNRC/9pnkshGXIRuHifJ6sOipMa7Q4sDM1MdmdFDpPzvDq935jXKqrXpoUp2dcx1sJYDaPPg3kKVPPNdMzJvPiNfLtFkY2ScfL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWVtDp/Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC38C4CED1;
	Sun, 24 Nov 2024 13:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455736;
	bh=SFYFwHXBUJf7VvheI4s+eT8kQiHMDd5dPLCv8NQQKmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MWVtDp/Yg1q/iYNMm8iocgUuLfwCeWWoLA+HL7h2angqo5CHYR+IAlhiiKD1ZUR5J
	 oBi0QdLYwo+puzWu81O3vlpqqUnFy3qqrP0sAO7HGIPgLhRMBOdoamAK+IZ+brydjH
	 3SLO2GshZUSvwmTv1T/9tarcxGCFZ+NVAd64Gl4l4wbd0hMSN3p8Arm295o/R8akP/
	 0Fxx1WGHLleL0LT05vAZhQzCYzi/EM5LSWmtw0PyXi5UBvay9T2mKMx+QfDMReWNCs
	 w0TFQzpvI3NGxGKUvhUtI62co1pLoznCROzHVA2Hpdg4nvhEIr0A9Mod+btVPuqugn
	 tZZ1OpTEcp5ZA==
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
	rdunlap@infradead.org,
	oleksandr@natalenko.name,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.11 22/87] drm/display: Fix building with GCC 15
Date: Sun, 24 Nov 2024 08:38:00 -0500
Message-ID: <20241124134102.3344326-22-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134102.3344326-1-sashal@kernel.org>
References: <20241124134102.3344326-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
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


