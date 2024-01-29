Return-Path: <stable+bounces-16888-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D63840ED5
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:19:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AB721F26C80
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31A7161B4C;
	Mon, 29 Jan 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eZZmmbY7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80464158D87;
	Mon, 29 Jan 2024 17:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548353; cv=none; b=MZcNpTUST3MQ1V5lqdXGdLwRDSs+vlc1xEu41mxFPOh96MWrdhtj+n3j0ZzuOCsmLQVsZZ8THBChw1oJ5oxlisbhv+63dzWH/uvoiPfoi+rW3x4iiWKiEpg/gmesPC3wAlfIoWqjruZAg0di97eRrSv6oAh2r5OA3IGN7ZUA6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548353; c=relaxed/simple;
	bh=RiOVFU0MbE1IJXt0CVy+enmX7HYXOGtDW1usjQWG0Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uf9ZHB6iKLrZgT3VxM7J9M0rMzvQmAN4c/4S8jIF6v9uSKUNT8b/dsvYJFjaneH6EWFf38USWp7iIIUwd3cWVVyVpR6pyfQB7DZss11zNQ/bqHh+A3DIXu3a43XUNns4eZDFR61Y0SNKz+HhOOpYCFKozA8AYo2+17i07zBrVHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eZZmmbY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46937C433F1;
	Mon, 29 Jan 2024 17:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548353;
	bh=RiOVFU0MbE1IJXt0CVy+enmX7HYXOGtDW1usjQWG0Bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eZZmmbY7xe4cLHC21Q5aBX1YzfaWfaEmOEgXDdNdX9A21vqm2S8GCoixDUmJn274e
	 s8yPOFHw0tcnNED3Wx3uDnJfhRpeDtEG55A7g1zuB/35CskQC8E7M/HGck1tE0jV7Z
	 fwZbEfHSrb2eCZHkjjUPd2Zj94MUucv9b+jj6zlw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pin-yen Lin <treapking@chromium.org>,
	Douglas Anderson <dianders@chromium.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 312/346] drm/bridge: parade-ps8640: Ensure bridge is suspended in .post_disable()
Date: Mon, 29 Jan 2024 09:05:43 -0800
Message-ID: <20240129170025.653582492@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240129170016.356158639@linuxfoundation.org>
References: <20240129170016.356158639@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pin-yen Lin <treapking@chromium.org>

[ Upstream commit 26db46bc9c675e43230cc6accd110110a7654299 ]

The ps8640 bridge seems to expect everything to be power cycled at the
disable process, but sometimes ps8640_aux_transfer() holds the runtime
PM reference and prevents the bridge from suspend.

Prevent that by introducing a mutex lock between ps8640_aux_transfer()
and .post_disable() to make sure the bridge is really powered off.

Fixes: 826cff3f7ebb ("drm/bridge: parade-ps8640: Enable runtime power management")
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240109120528.1292601-1-treapking@chromium.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/parade-ps8640.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/gpu/drm/bridge/parade-ps8640.c b/drivers/gpu/drm/bridge/parade-ps8640.c
index fb5e9ae9ad81..166bfc725ef4 100644
--- a/drivers/gpu/drm/bridge/parade-ps8640.c
+++ b/drivers/gpu/drm/bridge/parade-ps8640.c
@@ -107,6 +107,7 @@ struct ps8640 {
 	struct device_link *link;
 	bool pre_enabled;
 	bool need_post_hpd_delay;
+	struct mutex aux_lock;
 };
 
 static const struct regmap_config ps8640_regmap_config[] = {
@@ -345,6 +346,7 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
 	struct device *dev = &ps_bridge->page[PAGE0_DP_CNTL]->dev;
 	int ret;
 
+	mutex_lock(&ps_bridge->aux_lock);
 	pm_runtime_get_sync(dev);
 	ret = _ps8640_wait_hpd_asserted(ps_bridge, 200 * 1000);
 	if (ret) {
@@ -354,6 +356,7 @@ static ssize_t ps8640_aux_transfer(struct drm_dp_aux *aux,
 	ret = ps8640_aux_transfer_msg(aux, msg);
 	pm_runtime_mark_last_busy(dev);
 	pm_runtime_put_autosuspend(dev);
+	mutex_unlock(&ps_bridge->aux_lock);
 
 	return ret;
 }
@@ -475,7 +478,18 @@ static void ps8640_atomic_post_disable(struct drm_bridge *bridge,
 	ps_bridge->pre_enabled = false;
 
 	ps8640_bridge_vdo_control(ps_bridge, DISABLE);
+
+	/*
+	 * The bridge seems to expect everything to be power cycled at the
+	 * disable process, so grab a lock here to make sure
+	 * ps8640_aux_transfer() is not holding a runtime PM reference and
+	 * preventing the bridge from suspend.
+	 */
+	mutex_lock(&ps_bridge->aux_lock);
+
 	pm_runtime_put_sync_suspend(&ps_bridge->page[PAGE0_DP_CNTL]->dev);
+
+	mutex_unlock(&ps_bridge->aux_lock);
 }
 
 static int ps8640_bridge_attach(struct drm_bridge *bridge,
@@ -624,6 +638,8 @@ static int ps8640_probe(struct i2c_client *client)
 	if (!ps_bridge)
 		return -ENOMEM;
 
+	mutex_init(&ps_bridge->aux_lock);
+
 	ps_bridge->supplies[0].supply = "vdd12";
 	ps_bridge->supplies[1].supply = "vdd33";
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ps_bridge->supplies),
-- 
2.43.0




