Return-Path: <stable+bounces-110523-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAC2A1C9A8
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7229D188568E
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12CE1F2394;
	Sun, 26 Jan 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTi2ERuv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECD91F153F;
	Sun, 26 Jan 2025 14:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903257; cv=none; b=l12pCU6X2RzY+iT8W6lZQuyGyjz3cZuyft5owJeNjRe0LOrdMiE2VfYg9QOrqa47kgNaR4xclRKcoN3ADLc5drchdpA8NB4WLKZXPmwmvgBdzIs4ssJ76ItxxHehZvTRfnrq1izMZ0nyyUhMMu0+FkLM6E+4Fbhb7X45dTcBDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903257; c=relaxed/simple;
	bh=g913gO6xT4GXclS18ziqOPs81ttbwmSm1HwBTY5c6gI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C9Fu5SibnoYOA0KnVFr0eVynJklfyR3tlZ9iMlyRr59YbjuiRdb/7q7yoEFHqURjSHwWOc1nQBXwLvLQiLNnsC2JjLoufTFjQdEt8d0X/9AQIPd9PqgrXT6TFpp1OzSRZ2O1/KD5iiG24cT19NNKbEwIIEnb9qPIT87ZtM9+qcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTi2ERuv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6E8C4CED3;
	Sun, 26 Jan 2025 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903257;
	bh=g913gO6xT4GXclS18ziqOPs81ttbwmSm1HwBTY5c6gI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTi2ERuv3bZEvvhm+Vuyk6ypI0vYmSsYlNeG10Ex1KleResfOsMw/Qb00vuzfcK7p
	 VRafLFhgMTrEqPWnQKbEB2eghPAkTXf5GmYmq9JaLjFgHx29RUt6LiYgDEiJnRUHkK
	 8dcYAO8NgRYK5rn+EhaEtBah/gXkB765wzAqWq1VZjXcXuhTaDC89ulVN8pIqrrl8E
	 ybFVwzTkfkwE4MjacTkXReVKkuhMQD68a7XuOH2zoJygBoAs+J2kDrCXzclz+Ibf6L
	 /AAo7llQJVbR9wkiyiFNLuopnfQn7Wrhy5YhH3cUHcK2Isfy4qe9jzRCg4TaBNwcwP
	 HEdS6NLL7zdUw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>,
	Sasha Levin <sashal@kernel.org>,
	alain.volmat@foss.st.com,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 21/34] drm/sti: hdmi: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:52:57 -0500
Message-Id: <20250126145310.926311-21-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145310.926311-1-sashal@kernel.org>
References: <20250126145310.926311-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

[ Upstream commit e99c0b517bcd53cf61f998a3c4291333401cb391 ]

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Acked-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20241206-drm-connector-eld-mutex-v2-9-c9bce1ee8bea@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index 21b46a6465f08..f8bbae6393ef8 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1225,7 +1225,9 @@ static int hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf, size
 	struct drm_connector *connector = hdmi->drm_connector;
 
 	DRM_DEBUG_DRIVER("\n");
+	mutex_lock(&connector->eld_mutex);
 	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+	mutex_unlock(&connector->eld_mutex);
 
 	return 0;
 }
-- 
2.39.5


