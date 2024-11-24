Return-Path: <stable+bounces-95160-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52A7D9D73C6
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 15:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 172EB287D0E
	for <lists+stable@lfdr.de>; Sun, 24 Nov 2024 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1E711E0DFE;
	Sun, 24 Nov 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVZLs84B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D35622C5FF;
	Sun, 24 Nov 2024 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732456209; cv=none; b=naL8DJ5mwEFaj99QgaNqIiEt5prySJPztqTD6nBTmCiObiQHSvqaTtxjXMNHxyiv5gRYcMs6yegX5eQBWYZPoJVOo962YmVFZoEQup6vNfwVD2n96nFeRNqPu/wPJdiyAMg5IX33XM9A6EY9dW7cRY4wvOOnwVOVwakcQhQ+OkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732456209; c=relaxed/simple;
	bh=v2AETwvszsaxg3r7uA01/4mHUF0zeFnmwO/A5luv1MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlZvBpsZZ0wCljX6/7Hyy63Jhitt1xfXBBJdaEsPxtNbGZNJE3kk3hS/6TinhR/j8KjUBVrbRd5UiFmIr6IcrVXmU2TaAq9SgD9Gbv3VtMl3B6yfx/YOygX01oAXtCFSGUX4gLoQXxpFDRW6Igv6a93oVeHEwL7nmnKJDiQi4Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVZLs84B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8884C4CECC;
	Sun, 24 Nov 2024 13:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732456209;
	bh=v2AETwvszsaxg3r7uA01/4mHUF0zeFnmwO/A5luv1MM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GVZLs84BsTGmnMlgkPjN4TgUc0gp2EHL/RIeF5bGhGUVmRrUm+95t6Zweav0NkGsu
	 eUtD8OzmkNbfOR8BlWzY2m30G3iBaCuFdrJZhl0M4MEdLPJR2xhZkHrb4Ev5MDTWX7
	 YBmr9mY0TsgJ/QysrJlu8lwAi4WHIG+fxF7j/YcTDeWzyEtPjtzdcl1vmqxTtHnf/Q
	 VX+U1mv3kdiXve/aUvZ0Pn0ymmO+BpLOYa4xRzBZkVWyKb2hefluXyUmL6z1OovG6E
	 mQjYrJUkM1Ei/dKd6gFaPZV3x0VmRB91P+8QcxjLj40QOWlU+2iROch7EvAfCIigBY
	 zx1FeMqZQlq8g==
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
Subject: [PATCH AUTOSEL 6.1 09/48] drm/display: Fix building with GCC 15
Date: Sun, 24 Nov 2024 08:48:32 -0500
Message-ID: <20241124134950.3348099-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241124134950.3348099-1-sashal@kernel.org>
References: <20241124134950.3348099-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.119
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
index bd61e20770a5b..719da3610310f 100644
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


