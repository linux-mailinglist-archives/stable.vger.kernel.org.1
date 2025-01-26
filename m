Return-Path: <stable+bounces-110571-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 694ACA1CA1C
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:17:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2C2162D9E
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5677C1FCF47;
	Sun, 26 Jan 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HMxaxU8a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1468C1D5AAD;
	Sun, 26 Jan 2025 14:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903382; cv=none; b=uk4kHcgphQcMZmKisr5RIq6h0illXSRn/YRv3dYj5frV6nqCdSYIAz8b+QWERB+gxKMgsvBJ8Rh6ZBub7G3rRv+9OTG05IqAUqzwgKy3lr2q0ZJ53qnszFN9MMFkXv+JsoOSetINoZ0izeEqBaBeWMf3O0uuNfO4qYaHIZkg5Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903382; c=relaxed/simple;
	bh=x9qDZHqbuiQ7Ayq0nDGahD9H28T7XReiDJACRkz8x78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hSMaxvFq3DnUrByzZJvAEfgW0uHPL9UtU3BiI7CkeXFXB/dS6b9pxJTzEhFIDZnUapcrhZIIoNW58bkFjuyM3hGee0lE2jQ1pgGfap8kPIYTAj09KA5C7gpp6mHLGZt8oI8khBoZz18UwQZT3rm6NzyEHdsONWBSPyi44VG84XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HMxaxU8a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF634C4CEE4;
	Sun, 26 Jan 2025 14:56:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903382;
	bh=x9qDZHqbuiQ7Ayq0nDGahD9H28T7XReiDJACRkz8x78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HMxaxU8abC2wtBPPR/ff/Y9hGrEpCcSGFAq+NhZ+3ROOYT8SvwnwsINUHBgpUCYiK
	 8NJdqyddhhaDgpQBmrEwQEbSrVLuxAOx8RtdypK5PVWaPqh5ja25Ga1TsJIL4EPUyn
	 +1bK1mbfoiT4p62CcJ55/Mkqc75J2ln5jHXIw+2lLSUzN5Uo8xe77ICRdi99baXgic
	 b5ygoU2iQzEU6N6ukP5QdnvbxowtsuqRkb64fb7vRFkiL8SzsGkvTrH/2dW46NDqoy
	 t7WZ7Yw8kCzPRkOVr/nmgm5HE4nE3/AvurglnZqvF6tEnMhSuEYpMO43zMl7+3zp+L
	 dpGPylg44kH4w==
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
	nfraprado@collabora.com,
	u.kleine-koenig@baylibre.com,
	sui.jingfeng@linux.dev,
	xji@analogixsemi.com,
	yuanhsinte@chromium.org,
	robh@kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 04/17] drm/bridge: anx7625: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:55:59 -0500
Message-Id: <20250126145612.937679-4-sashal@kernel.org>
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
index 412c6575e87b7..ddf944651c55a 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2014,8 +2014,10 @@ static int anx7625_audio_get_eld(struct device *dev, void *data,
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


