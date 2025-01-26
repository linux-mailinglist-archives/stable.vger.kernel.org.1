Return-Path: <stable+bounces-110517-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF34A1C99A
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 16:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F73F18868EE
	for <lists+stable@lfdr.de>; Sun, 26 Jan 2025 15:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286C61E0E0C;
	Sun, 26 Jan 2025 14:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coe40f6B"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80431A7046;
	Sun, 26 Jan 2025 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737903242; cv=none; b=u4Z5PdryL8rWjfrTS3dzTTlYdvBu1a0K5lKX28fR1nGzNuKZUCKSq3PagjRgCYUCH+WD4aS2Y4r5HDstNA/kVgaJBnN3L+IynCBcAqnoGaGqNIo2b2MfiT8AVRqHZGOTXfgXfsB9fyNn3c0QYWOgjAFLsQ+gg7FKyMhfvQXDQvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737903242; c=relaxed/simple;
	bh=n+zT/91wQRIjD4biaVx54GDDMTbZ0O75vA1N+LQ7aqg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JlLG4/UactVR53OvRbHLw8U4nduH+rsux0iOQ0c4dzvQwfgojzppydoedrsG0IYSxf2lEfGNE+aIOD3AdcDvfjZ/4RX7WM8lAmM2rGdI2IHwuOsLWQPENWZ8nJJI3F12qfOgi6y1TBQDpWgceADBbCyAcfqXRQWEX+07fi+Gyd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coe40f6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B60BC4CEE4;
	Sun, 26 Jan 2025 14:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737903242;
	bh=n+zT/91wQRIjD4biaVx54GDDMTbZ0O75vA1N+LQ7aqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=coe40f6BTuhhGwWec/RcCHJnEDfBUhol1o9nWtPqJcLdCW1295ngrE2AVADXJLoCf
	 duV6K/7YXBMwJ/nVALr15HNUxysXPeUAz0wQA95r3lxLEUtGTwGx5DgjP6I9DrZzud
	 8KXnEVbN1GppEcsrEGPO0VvB2Nnyy6UXWZjV630l4+ODkwscpJP2mXUd+lIBd9vStF
	 xjF60JN7BEVydiqpJAjZqT+qP3RqepA9jlI3ZsTYx1caRgFYBv0nN99CxIdGPmDR6b
	 KTxryb3SOorfsSHG/OJd7BDkEgj7sd5w8NUgFttI/MfX7t9eSGrFIxjtlJOBlkqtaf
	 hw7v0e3gkN4Ww==
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
	sui.jingfeng@linux.dev,
	treapking@chromium.org,
	u.kleine-koenig@baylibre.com,
	xji@analogixsemi.com,
	yuanhsinte@chromium.org,
	robh@kernel.org,
	dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.13 15/34] drm/bridge: anx7625: use eld_mutex to protect access to connector->eld
Date: Sun, 26 Jan 2025 09:52:51 -0500
Message-Id: <20250126145310.926311-15-sashal@kernel.org>
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


