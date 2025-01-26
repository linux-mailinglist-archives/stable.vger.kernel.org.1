Return-Path: <stable+bounces-110577-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE83A1CA0D
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDEE18829FF
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E59541FDE01;
	Sun, 26 Jan 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huH2OJTr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1FB1FDE2E;
	Sun, 26 Jan 2025 14:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903395; cv=none; b=k1/+tkCebaOySUEe8VBr3OpEZ/ePU3s3IgVx304tP1qnXyuin/c3/DRjRlYoTJAb77UabYQ0nNfCmdU4fx1yf0GPBI63G33fCxbfAlgLEAY4QH3j43bBehnP46E0tvosyMCIXf3pMwEePE3Dr2InI+UTeOyItdiG1ZG7n+GvVzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903395; c=relaxed/simple;
	bh=/5Oi9CSOL3jvwpW38YQkqWArt13/hsS9CBnqIU2w1Jo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o7pjNJCXDqBi0byU35CXTtFTNyH4YscaKWFZTM0tL3+fKqg01yUsFqzBT9tt5GgGznJIPQ1keS/C7018Fr8a/92aBETa7p65ioxsDKxfu5WRnmBKDmHZyqBLgOzdQuIVwgsW36trxWxdQxLT3NreTZjqfYwjthBN1um2euhf1n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huH2OJTr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529E3C4CED3;
	Sun, 26 Jan 2025 14:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903395;
	bh=/5Oi9CSOL3jvwpW38YQkqWArt13/hsS9CBnqIU2w1Jo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=huH2OJTr0GKKXCbGEYUdADqtRNpq62MPDRZM3IHosCBcUmZI+R05pMEeSg6EebXO4
	 UV1KxvQpVJX7eP0IPHnwMvcrPq2FXN8FmMZGovCDzx2aMfFOmjuI4QL57LmUKwFGIX
	 oggzjI/G1tUHrf6WGjAUQnB2as8k/X3lyW/E22vRckBFq68qfLh+R3WMB6qXAUGd6w
	 QTx5lH6hFu5QXF3vAASHcvdsENjKwt5gEgK+6U0vp2CnSnfRM0OeckIHN0ZiP6FbuQ
	 YSDW+M1wXWXt7tpinwHhwB3ZlXVbKAfp7xbA4IXvayjnjZOkWvl9ODkoxT86RWTVBJ
	 8eoc4i3ZFG0ew==
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
Subject: [PATCH AUTOSEL 6.6 10/17] drm/vc4: hdmi: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:56:05 -0500
Message-Id: <20250126145612.937679-10-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250126145612.937679-1-sashal@kernel.org>
References: <20250126145612.937679-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.74
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
index 1727d447786f1..541aba80c1449 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -2655,9 +2655,9 @@ static int vc4_hdmi_audio_get_eld(struct device *dev, void *data,
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


