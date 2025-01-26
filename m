Return-Path: <stable+bounces-110587-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2627A1CA2D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:18:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11CAD1881BDA
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D42811FF7C3;
	Sun, 26 Jan 2025 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uOvfOLK6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914611FF7BB;
	Sun, 26 Jan 2025 14:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903417; cv=none; b=lBEVWz0OCEH2S4Ut851IntaPqqfm0Tkct7yIDJ3rgmUKB2sSsgEVcoWkYmL3YW4A29RFKj2FXI8bmyuEtPk4msWIZoCrCHrH1Oa/X9iSvvWLQVhRFOM/PdXoy2cqG/RCqqa9i2Jkt6NuXP3OQxnhE+D79UJzeYV7ly0g7On9FfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903417; c=relaxed/simple;
	bh=1bo2GecgpSTPHTxmCsIzWDUvlu0mvNWQk1qBwHKKAvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MhT0yjfIqervE0wPg9YsSsIcMSpPWNj4+A+zLboiQkwfwso07OIIY0BitlRxP0uNUcMREvfyxW1fVOx7RNPKQoi4j4ixHVMiwv+uzp+iY7gbjN7qZXPm8r9O4hMj3ySTsI1f9ycc4ej6ngdmgLMEFBZfN0nJRzOK0eWqHAxZkRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uOvfOLK6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BCCC4CEE5;
	Sun, 26 Jan 2025 14:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903417;
	bh=1bo2GecgpSTPHTxmCsIzWDUvlu0mvNWQk1qBwHKKAvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uOvfOLK6+M99qFj+DrBrvFZepOlftHnWV1F8OEpynGLgpX3OvTVWXPJrhuk0jpBZL
	 P3noSo8A8aHYL34W+Cc2IzYxBr/23svneI9KJZxSFPmsqAvEyneLUIbG+skv5md61b
	 TEre1B0M7socFMiuHaHHyPTF/78lR/rCGz6Z+ffcWRwSXGKp1SJQRR+Wzglbb8DyLl
	 LkhYh7d9ozB18ERJj1Sb4M4SOza+dm0cU4pt1PJGyLR0/b16bLA9fc9WSWw6JMHCa9
	 0q3sahmwIbSCudFOTxmS0dNqJdyb0aewKcvviKIwkTFimBhYcbCw5xfUJkq22zzRLk
	 +5rVImOVNogQA==
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
Subject: [PATCH AUTOSEL 6.1 3/9] drm/sti: hdmi: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:56:45 -0500
Message-Id: <20250126145651.943149-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145651.943149-1-sashal@kernel.org>
References: <20250126145651.943149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.127
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
index 8539fe1fedc4c..fdb28e05720ad 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1220,7 +1220,9 @@ static int hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf, size
 	struct drm_connector *connector = hdmi->drm_connector;
 
 	DRM_DEBUG_DRIVER("\n");
+	mutex_lock(&connector->eld_mutex);
 	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+	mutex_unlock(&connector->eld_mutex);
 
 	return 0;
 }
-- 
2.39.5


