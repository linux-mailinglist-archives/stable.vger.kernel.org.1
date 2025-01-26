Return-Path: <stable+bounces-110549-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1404A1C9EA
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B17A4168E25
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8871F9EA1;
	Sun, 26 Jan 2025 14:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnzlG8zA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6F7156C76;
	Sun, 26 Jan 2025 14:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903329; cv=none; b=lBjejMYehtMGqve21TTFpN1K4O9cgE85t6FF03XHO+HW/so/13gUIwm9ica4OMYJuE14zW+DjkV48NdB4Nr7AEB83TeCDOt/jVIOMH7CeTOYYvnG2PfnibUan55p1ItsO6zrdKoJLK8E1QuHthlGcx3W3se22DTcaz40jIxw9P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903329; c=relaxed/simple;
	bh=n+zT/91wQRIjD4biaVx54GDDMTbZ0O75vA1N+LQ7aqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mqPnuggmuWnWZABVVrjqlQ87E/vAg6Ed2OPpT4mIzVIfue0YVNP1t5X2OHObrcLKyMW+ocH6eUpQYtsDJr1ww5asqSCPCVzRGvexXI0CLSnN5jpCoahz0g6vn8onK9iuiEjuPGs2JsCZTJbNyTGlGQXm/xY03lK7YgqsjQtejc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnzlG8zA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2488CC4CED3;
	Sun, 26 Jan 2025 14:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903329;
	bh=n+zT/91wQRIjD4biaVx54GDDMTbZ0O75vA1N+LQ7aqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HnzlG8zAAbV/hHZMJBoAcLEO9jp0bGPP5uIR29pxgUg5WHacu8saIKJwLuacNvHqx
	 7wMHdISBsWiCdMWcuSWO+CGjruYn+ySN0iKvh8CUBnG9C+P/hGkoPrOtyyW57BdyHZ
	 3eVo25WpGmkgGBKC6ncXOY2cIquTcjLmuMqUkjIKj67jNXJonyDiCDoo2pJ5zOjRmd
	 OIGvvE3aygmqLgEIaSJwMZ2lBEnZbhh1uHJ3m4x0gNzW3ZPZYlINNQOl776cWFlwSs
	 Gt95MjU6swEV80x235ixsq+ZEhl/gWSFyRbwDm4WiwFUFFKLWnMgQ9iDPItlBUovXb
	 nVBJWogNCoBfg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Maxime Ripard <mripard@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	andrzej.hajda@intel.com,
	neil.armstrong@linaro.org,
	rfoss@kernel.org,
	maarten.lankhorst@linux.intel.com,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	dianders@chromium.org,
	laurent.pinchart@ideasonboard.com,
	jani.nikula@intel.com,
	xji@analogixsemi.com,
	treapking@chromium.org,
	sui.jingfeng@linux.dev,
	yuanhsinte@chromium.org,
	robh@kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.12 13/31] drm/bridge: anx7625: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:54:29 -0500
Message-Id: <20250126145448.930220-13-sashal@kernel.org>
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

[ Upstream commit e72bf423a60afd744d13e40ab2194044a3af5217 ]

Reading access to connector->eld can happen at the same time the
drm_edid_to_eld() updates the data. Take the newly added eld_mutex in
order to protect connector->eld from concurrent access.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20241206-drm-connector-eld-mutex-v2-2-c9bce1ee8bea@linaro.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/analogix/anx7625.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index a2675b121fe44..c036bbc92ba96 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2002,8 +2002,10 @@ static int anx7625_audio_get_eld(struct device *dev, void *data,
 		memset(buf, 0, len);
 	} else {
 		dev_dbg(dev, "audio copy eld\n");
+		mutex_lock(&ctx->connector->eld_mutex);
 		memcpy(buf, ctx->connector->eld,
 		       min(sizeof(ctx->connector->eld), len));
+		mutex_unlock(&ctx->connector->eld_mutex);
 	}
 
 	return 0;
-- 
2.39.5


