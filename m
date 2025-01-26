Return-Path: <stable+bounces-110554-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05AE8A1CA10
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 300573AA78D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F413F1FA15D;
	Sun, 26 Jan 2025 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQnSJ2q1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B341A1AD3E0;
	Sun, 26 Jan 2025 14:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903341; cv=none; b=BNAZ9kTnDIBGrlXPsMNVzHBEfNBFdWOFvBSXAX65OBAjjWTKgcPXKG3rSmYcbYRVrTTm8H8qcGocqODIKOm5A2oD1/QeArC2baiHZWOg/oKT0U1b91hwNyDIr6A3glRDyqq5iPy6CKQQ5ETVkoin7uHiCwYAN3MJbp0Hw6cxMM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903341; c=relaxed/simple;
	bh=E6eskXtNKGqY6mkbJuUK27kMepWR2x2b9c2rs0dxXCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UfgOZqCj6YcQHXHATNpHFd7yhLFvbrHVJ6DgMWBcT7KoimbnXPCTptmQqCapKrKM1l9ursRNePis4lHmG2mSwLmQyByi77AJw74T33+mFj/xBufKg87rBcgcZMmJgHneAbzhiNWU/o0dcTRtA19svzbLQYDPG+nOb+k+87qoltM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQnSJ2q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E87A1C4CED3;
	Sun, 26 Jan 2025 14:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903341;
	bh=E6eskXtNKGqY6mkbJuUK27kMepWR2x2b9c2rs0dxXCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lQnSJ2q1gDgBMCscAlbgaGTHG5HOPFOA7i6eDE7YMWaN8CdWoD1Kva973sJGLSF2i
	 QVlVj8cFJBZmD1xFWltqcvMkP0XN2Ks+itAJuiZJ3aifeQ3bq1Cuo9Jyu9WUA84zxH
	 AsVO5MXzBA/w9IjP4+k9kt0MGR9E//rPhPltN/G8g4sCB2H4gPIRbfleTzc9WLnLkK
	 j1zPZTbmyEtIi/Zo3PlditWCKnCSissFuv0HShPwkDvw2bL7/C395HQzNHV2QcIq8U
	 ixds4+BBQ+VnMsYOkQiBOyumLnYddPVC6YK6DEOc4qYndeASe4beGhX+qunqRvLpPg
	 ykhvpRpeOA08w==
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
Subject: [PATCH AUTOSEL 6.12 18/31] drm/sti: hdmi: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:54:34 -0500
Message-Id: <20250126145448.930220-18-sashal@kernel.org>
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
index 847470f747c0e..3c8f3532c7972 100644
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


