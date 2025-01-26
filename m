Return-Path: <stable+bounces-110555-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9236DA1C9E5
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3788118843EB
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441581FA177;
	Sun, 26 Jan 2025 14:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDofPCFF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31D31FA16C;
	Sun, 26 Jan 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903343; cv=none; b=aCyO1wejTvau7JYDY3YOXKg3R5d7gsajBrTdDb4u3vUgNv5HkDT6CDOpu82I9KeAvJ29iRbOeiezNgFcPJPbR/mEfshntDVuDuyA+mB5IqHsTi5ggCmieHo19QbV2dx3GfybEZdoinErr0hQL8N2w5hp5RWH855lKUyj5CCjM4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903343; c=relaxed/simple;
	bh=FfOs3QdDZOZxFGBTzLJe9hXYYdfsWqaa3pMMKvQgAJQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i4HCm7aSru63nXsiM8Gkx45Q6rsMkhujgkTVG7sDDH2P/w/F5gCzS4Gdoit9RIZ9z1Lp8OEFfme9AIxdZeAnryUxyFBXpmt3sRz0W1KoxQ0Lo2i+jKFSS7/qasdOnofKGem0jjCjxnXaF2D4i0lBSj94pP83Jv68PgFAduO7NiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDofPCFF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A166EC4CEE4;
	Sun, 26 Jan 2025 14:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903342;
	bh=FfOs3QdDZOZxFGBTzLJe9hXYYdfsWqaa3pMMKvQgAJQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MDofPCFFEZqWZjc2QCB704vcv5kAYIc6WTylqMlv0YaAZzFYlpMsRPRUF/QvUyx8w
	 /E7TFbLSV5ANto5pc5KB2MEql5NC/g+UamCvrWFkJqVopqvzk4fRcAjB/rUiCecsJG
	 tqUclRONKhSK/dZR++nPj+zP56WPWHgT8PMdL97Nw7d9W+zrQT1ykrAE+fiM3ldtkq
	 OHaWp2L1A2IYGHrvmJQ6OsqTSMp0WDzqiBHX8uHUKuOJruZVD2qUPvcSe+gwnv+f0e
	 7mPu6eMb+l4SSmkQ3OWKaEne8gAeOSmiAT1afITdQL+spPmJ/N3jPDWQaW4FjPoAVf
	 pkDheMpUeyfXw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	dave.stevenson@raspberrypi.com,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 19/31] drm/vc4: hdmi: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:54:35 -0500
Message-Id: <20250126145448.930220-19-sashal@kernel.org>
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

[ Upstream commit 81a9a93b169a273ccc4a9a1ee56f17e9981d3f98 ]

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241206-drm-connector-eld-mutex-v2-10-c9bce1ee8bea@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 7e0a5ea7ab859..6b83d02b5d62a 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2192,9 +2192,9 @@ static int vc4_hdmi_audio_get_eld(struct device *dev, void *data,
 	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
 	struct drm_connector *connector = &vc4_hdmi->connector;
 
-	mutex_lock(&vc4_hdmi->mutex);
+	mutex_lock(&connector->eld_mutex);
 	memcpy(buf, connector->eld, min(sizeof(connector->eld), len));
-	mutex_unlock(&vc4_hdmi->mutex);
+	mutex_unlock(&connector->eld_mutex);
 
 	return 0;
 }
-- 
2.39.5


