Return-Path: <stable+bounces-110601-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01315A1CA4C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:22:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97AD81882083
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F5A203705;
	Sun, 26 Jan 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qzsskw/9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A2B1DA60B;
	Sun, 26 Jan 2025 14:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903447; cv=none; b=Rezp2KJqb8xI+YUIuemcJgMU+txt3EEW8ukzFCYYxdYyu63kiwA97OWSAZbKgVx5BDEYuXkZsmumRYoC+SdmOyb5M69nxEH6g5cSbGFt9ichYgYUe5I3vhsVRRuCDguktFBzFvUBsqjy9VeJQx8cif0G2yD6/nP1KAqsEQFqsm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903447; c=relaxed/simple;
	bh=4SRF8G0chdTqi7IqSsbwmIj53SwnXriDnsd9U6DDGwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uoGTLauGMKC5fYDwW5DDBoMJFazpEbCUzNfgLHhbe7H74mlifD3WKHi6MGilPFkrOqqv74fUJrYi3w3f3JADj+f4hUcIkeBZZ6xL6jSoTyI8MmYi7Bp5yLPvyfBp5dJjh8EWahUDAZvvTrQxQmOAIpxzUEyvf8SERNXdnMnqLhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qzsskw/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C392EC4CED3;
	Sun, 26 Jan 2025 14:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903447;
	bh=4SRF8G0chdTqi7IqSsbwmIj53SwnXriDnsd9U6DDGwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qzsskw/9A+Y+rdti7x+I4VsDhTd2yk06dLwYeiPRB+gxKyGa76CPtEbo08SF2fHaS
	 LDlShqTZsz3lLa2WGc1gcnMpPxElaL0jKaLJP1wpZ2nhqPGr7ZM5hLGP1x8SzuCMaw
	 UWcFv6xIrMLIsgvC3rQsg1a8wKog4uo83U5gtBahtzELth3IXgJSNolUdKgybpVkns
	 5UIphtox+1XxGke8mOcxTQ44C2jCwgZjLQQno9mfbRP/wOWslkuQjJ/jBHQ5+zBuP0
	 cwlsWA3mM8i6Ww+zSYdcIEzkhdg+457Vl/JS+DFJRwmDOxQpJcVhqxJln4yjnitZ58
	 +KZogqj9S5w+A==
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
Subject: [PATCH AUTOSEL 5.4 2/2] drm/sti: hdmi: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:57:23 -0500
Message-Id: <20250126145723.947855-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145723.947855-1-sashal@kernel.org>
References: <20250126145723.947855-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.289
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
index c5547fedebe30..ce7cc84499f45 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -1214,7 +1214,9 @@ static int hdmi_audio_get_eld(struct device *dev, void *data, uint8_t *buf, size
 	struct drm_connector *connector = hdmi->drm_connector;
 
 	DRM_DEBUG_DRIVER("\n");
+	mutex_lock(&connector->eld_mutex);
 	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
+	mutex_unlock(&connector->eld_mutex);
 
 	return 0;
 }
-- 
2.39.5


