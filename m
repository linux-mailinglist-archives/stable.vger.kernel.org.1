Return-Path: <stable+bounces-110543-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28151A1C9E1
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DF111683AC
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3E1189F57;
	Sun, 26 Jan 2025 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHVfkIQc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB851898ED;
	Sun, 26 Jan 2025 14:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903311; cv=none; b=SDnSHezfJ1lkqybVD/WNcuZ7++F20P19mBZX8g/BdKoMXgtNazMjwvidlC40OwS3maIXMhW34BK5ORFR/kRj1twPRchdPk31aaEOZt6/Eo53nWrafxlXd9djMzF+O3w/VyJ9Bp8pEcx/aOwndhX8ZTsjASE7KlUJU73XA6/9+3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903311; c=relaxed/simple;
	bh=cSU342SHfm5sEU97zxcpswrgFA+24zyFUoMzYMVW89Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PVVWwfxMbOKlD9Bd/KTA1/Qj9Vfb1QN3g3vK5+L+YFJwModZsv/lDlbnVzcz+xMqSjCdq1qR0PakF1ZMQAa+vnfdijMrr+OyUTeWFmaWQtkhjtfdXtNQ/iiLZUFWk7XCmlhuIIuuPdZxidicNgjfFtj01Bt4s9fqKcvRBdqh7iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHVfkIQc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A999BC4CED3;
	Sun, 26 Jan 2025 14:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903311;
	bh=cSU342SHfm5sEU97zxcpswrgFA+24zyFUoMzYMVW89Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cHVfkIQcffM33cEtsAJGEf79PlWWjEb+torDt7SNes/Zluikmo2CSTztptCrgH2yO
	 wq/7cjp8dPESKQuj7+Jb1XpPGCXE10Sv+ON+V6XFl5j5NC2ZEBLKoPemfg+aFqTYOO
	 g5LNYy9ZpgFzuJt40PPE6IG2i9wdUbHF27DHjblBKtKKvWdsHbATkN1NSOcZRePpC/
	 4tgCAVEsoEJaLR4TXA00qa4px+HNbPbLzuNWw4GYdWo5eDKJ+5kMQO4HmIZ7b3x2i8
	 tKdSNBveHrHAB4TL3XiE7G/zvbmA7W1GyVMB0he+sDi+QS3XXuJeBQymktMcHh0IRx
	 y93n6dqLKkYJg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dave.stevenson@raspberrypi.com,
	victor.liu@nxp.com,
	ruanjinjie@huawei.com,
	quic_jjohnson@quicinc.com,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 07/31] drm/tests: hdmi: handle empty modes in find_preferred_mode()
Date: Sun, 26 Jan 2025 09:54:23 -0500
Message-Id: <20250126145448.930220-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145448.930220-1-sashal@kernel.org>
References: <20250126145448.930220-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.11
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit d3314efd6ebf335a3682b1d6b1b81cdab3d8254a ]

If the connector->modes list is empty, then list_first_entry() returns a
bogus entry. Change that to use list_first_entry_or_null().

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241130-hdmi-mode-valid-v5-1-742644ec3b1f@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
index 294773342e710..1e77689af6549 100644
--- a/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
+++ b/drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c
@@ -46,7 +46,7 @@ static struct drm_display_mode *find_preferred_mode(struct drm_connector *connec
 	struct drm_display_mode *mode, *preferred;
 
 	mutex_lock(&drm->mode_config.mutex);
-	preferred = list_first_entry(&connector->modes, struct drm_display_mode, head);
+	preferred = list_first_entry_or_null(&connector->modes, struct drm_display_mode, head);
 	list_for_each_entry(mode, &connector->modes, head)
 		if (mode->type & DRM_MODE_TYPE_PREFERRED)
 			preferred = mode;
-- 
2.39.5


