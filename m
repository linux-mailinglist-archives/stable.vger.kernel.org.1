Return-Path: <stable+bounces-16824-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78EF9840E91
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 18:17:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2997F283BF6
	for <lists+stable@lfdr.de>; Mon, 29 Jan 2024 17:17:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8544915A4AC;
	Mon, 29 Jan 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fVzHGt+U"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A1115A4A3;
	Mon, 29 Jan 2024 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706548306; cv=none; b=r5qhcrJv2QQ6E/KXEDQnu+oypg4bP5VpraYrysRlK4ILn7c/rlq4I0XevpviPEyv4m/CxFRefxd6atzHNYNQ4k58d/9yJeu63BxQQn+4+9M4fSexQqxeOAHZ10vyWdjAUTNsrAIOGZz1amt13rGO9OsgLldLEIUZ8TQScfsGKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706548306; c=relaxed/simple;
	bh=zHY2WpTalqm7lhl/ALGxAk8t2qtgcHZ2MKlVPWdCGss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PwIHNNps4kemprV2QVjljbIRsH3VLIzY/LnhGvxEdNBAd/rV2WhpAFJU+pzCR1yFYflQERDLUggKxdSmtyHsvnP8Ts4sCIEz5Dinvq+5IdWWacLomnKrNe29r9l3DlLoZncNMQBCA+yNOuh164xNrF+G8NI2XBRfnJBv6wuQMSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fVzHGt+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BC8AC433C7;
	Mon, 29 Jan 2024 17:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706548306;
	bh=zHY2WpTalqm7lhl/ALGxAk8t2qtgcHZ2MKlVPWdCGss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fVzHGt+UMweImhxtz48DWEUiRg++njavT5KfBsUbJjYZupAlwj50WD/EXUAOpNCyb
	 0H/NvVhXsZf+hVZBLFNtOot/4/pzGhrA1yuwW/1J8W4XtKlffIONmQ5LIwJNwH+aD4
	 GZFTYSnDQXPZlJNYaSqYWiOsJ/9/2l0rqJaeFtQc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 310/346] drm/bridge: sii902x: Fix probing race issue
Date: Mon, 29 Jan 2024 09:05:41 -0800
Message-ID: <20240129170025.595575969@linuxfoundation.org>
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

From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

[ Upstream commit 08ac6f132dd77e40f786d8af51140c96c6d739c9 ]

A null pointer dereference crash has been observed rarely on TI
platforms using sii9022 bridge:

[   53.271356]  sii902x_get_edid+0x34/0x70 [sii902x]
[   53.276066]  sii902x_bridge_get_edid+0x14/0x20 [sii902x]
[   53.281381]  drm_bridge_get_edid+0x20/0x34 [drm]
[   53.286305]  drm_bridge_connector_get_modes+0x8c/0xcc [drm_kms_helper]
[   53.292955]  drm_helper_probe_single_connector_modes+0x190/0x538 [drm_kms_helper]
[   53.300510]  drm_client_modeset_probe+0x1f0/0xbd4 [drm]
[   53.305958]  __drm_fb_helper_initial_config_and_unlock+0x50/0x510 [drm_kms_helper]
[   53.313611]  drm_fb_helper_initial_config+0x48/0x58 [drm_kms_helper]
[   53.320039]  drm_fbdev_dma_client_hotplug+0x84/0xd4 [drm_dma_helper]
[   53.326401]  drm_client_register+0x5c/0xa0 [drm]
[   53.331216]  drm_fbdev_dma_setup+0xc8/0x13c [drm_dma_helper]
[   53.336881]  tidss_probe+0x128/0x264 [tidss]
[   53.341174]  platform_probe+0x68/0xc4
[   53.344841]  really_probe+0x188/0x3c4
[   53.348501]  __driver_probe_device+0x7c/0x16c
[   53.352854]  driver_probe_device+0x3c/0x10c
[   53.357033]  __device_attach_driver+0xbc/0x158
[   53.361472]  bus_for_each_drv+0x88/0xe8
[   53.365303]  __device_attach+0xa0/0x1b4
[   53.369135]  device_initial_probe+0x14/0x20
[   53.373314]  bus_probe_device+0xb0/0xb4
[   53.377145]  deferred_probe_work_func+0xcc/0x124
[   53.381757]  process_one_work+0x1f0/0x518
[   53.385770]  worker_thread+0x1e8/0x3dc
[   53.389519]  kthread+0x11c/0x120
[   53.392750]  ret_from_fork+0x10/0x20

The issue here is as follows:

- tidss probes, but is deferred as sii902x is still missing.
- sii902x starts probing and enters sii902x_init().
- sii902x calls drm_bridge_add(). Now the sii902x bridge is ready from
  DRM's perspective.
- sii902x calls sii902x_audio_codec_init() and
  platform_device_register_data()
- The registration of the audio platform device causes probing of the
  deferred devices.
- tidss probes, which eventually causes sii902x_bridge_get_edid() to be
  called.
- sii902x_bridge_get_edid() tries to use the i2c to read the edid.
  However, the sii902x driver has not set up the i2c part yet, leading
  to the crash.

Fix this by moving the drm_bridge_add() to the end of the
sii902x_init(), which is also at the very end of sii902x_probe().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Fixes: 21d808405fe4 ("drm/bridge/sii902x: Fix EDID readback")
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/r/20240103-si902x-fixes-v1-1-b9fd3e448411@ideasonboard.com
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20240103-si902x-fixes-v1-1-b9fd3e448411@ideasonboard.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/bridge/sii902x.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index 2bdc5b439beb..69da73e414a9 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -1080,16 +1080,6 @@ static int sii902x_init(struct sii902x *sii902x)
 			return ret;
 	}
 
-	sii902x->bridge.funcs = &sii902x_bridge_funcs;
-	sii902x->bridge.of_node = dev->of_node;
-	sii902x->bridge.timings = &default_sii902x_timings;
-	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
-
-	if (sii902x->i2c->irq > 0)
-		sii902x->bridge.ops |= DRM_BRIDGE_OP_HPD;
-
-	drm_bridge_add(&sii902x->bridge);
-
 	sii902x_audio_codec_init(sii902x, dev);
 
 	i2c_set_clientdata(sii902x->i2c, sii902x);
@@ -1102,7 +1092,21 @@ static int sii902x_init(struct sii902x *sii902x)
 		return -ENOMEM;
 
 	sii902x->i2cmux->priv = sii902x;
-	return i2c_mux_add_adapter(sii902x->i2cmux, 0, 0, 0);
+	ret = i2c_mux_add_adapter(sii902x->i2cmux, 0, 0, 0);
+	if (ret)
+		return ret;
+
+	sii902x->bridge.funcs = &sii902x_bridge_funcs;
+	sii902x->bridge.of_node = dev->of_node;
+	sii902x->bridge.timings = &default_sii902x_timings;
+	sii902x->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+
+	if (sii902x->i2c->irq > 0)
+		sii902x->bridge.ops |= DRM_BRIDGE_OP_HPD;
+
+	drm_bridge_add(&sii902x->bridge);
+
+	return 0;
 }
 
 static int sii902x_probe(struct i2c_client *client)
@@ -1170,12 +1174,11 @@ static int sii902x_probe(struct i2c_client *client)
 }
 
 static void sii902x_remove(struct i2c_client *client)
-
 {
 	struct sii902x *sii902x = i2c_get_clientdata(client);
 
-	i2c_mux_del_adapters(sii902x->i2cmux);
 	drm_bridge_remove(&sii902x->bridge);
+	i2c_mux_del_adapters(sii902x->i2cmux);
 }
 
 static const struct of_device_id sii902x_dt_ids[] = {
-- 
2.43.0




