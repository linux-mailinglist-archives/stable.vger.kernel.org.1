Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 574BD70C94C
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235281AbjEVTqk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjEVTqi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:46:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1EC119D
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6E94D62A82
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E0A4C433EF;
        Mon, 22 May 2023 19:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784784;
        bh=UQmITDHI6OxZN56ea6MlrFlpuovOQfioniSZ9PgydvY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XAd66zQlt5kG08ENyfjBGf3ERuZqAMM3njsaID4AEHqjgWfVOBQ2H7Uad2OTaLKhn
         AW+XbsdICWpOWqDWK7OpeJvkJf/fqVi56aDJgLTYEj6jHVbsbeMmLlwnczqAC9hYzC
         UqFapIt7i6HGeykrNnwM43ULtK//iVyJUUBj2Ma0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 202/364] drm/msm/dp: unregister audio driver during unbind
Date:   Mon, 22 May 2023 20:08:27 +0100
Message-Id: <20230522190417.778119330@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

[ Upstream commit 85c636284cb63b7740b4ae98881ace92158068d3 ]

while binding the code always registers a audio driver, however there
is no corresponding unregistration done in unbind. This leads to multiple
redundant audio platform devices if dp_display_bind and dp_display_unbind
happens multiple times during startup. On X13s platform this resulted in
6 to 9 audio codec device instead of just 3 codec devices for 3 dp ports.

Fix this by unregistering codecs on unbind.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Fixes: d13e36d7d222 ("drm/msm/dp: add audio support for Display Port on MSM")
Reviewed-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Patchwork: https://patchwork.freedesktop.org/patch/533324/
Link: https://lore.kernel.org/r/20230421145657.12186-1-srinivas.kandagatla@linaro.org
Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/msm/dp/dp_audio.c   | 12 ++++++++++++
 drivers/gpu/drm/msm/dp/dp_audio.h   |  2 ++
 drivers/gpu/drm/msm/dp/dp_display.c |  1 +
 3 files changed, 15 insertions(+)

diff --git a/drivers/gpu/drm/msm/dp/dp_audio.c b/drivers/gpu/drm/msm/dp/dp_audio.c
index 6666783e1468e..1245c7aa49df8 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.c
+++ b/drivers/gpu/drm/msm/dp/dp_audio.c
@@ -593,6 +593,18 @@ static struct hdmi_codec_pdata codec_data = {
 	.i2s = 1,
 };
 
+void dp_unregister_audio_driver(struct device *dev, struct dp_audio *dp_audio)
+{
+	struct dp_audio_private *audio_priv;
+
+	audio_priv = container_of(dp_audio, struct dp_audio_private, dp_audio);
+
+	if (audio_priv->audio_pdev) {
+		platform_device_unregister(audio_priv->audio_pdev);
+		audio_priv->audio_pdev = NULL;
+	}
+}
+
 int dp_register_audio_driver(struct device *dev,
 		struct dp_audio *dp_audio)
 {
diff --git a/drivers/gpu/drm/msm/dp/dp_audio.h b/drivers/gpu/drm/msm/dp/dp_audio.h
index 84e5f4a5d26ba..4ab78880af829 100644
--- a/drivers/gpu/drm/msm/dp/dp_audio.h
+++ b/drivers/gpu/drm/msm/dp/dp_audio.h
@@ -53,6 +53,8 @@ struct dp_audio *dp_audio_get(struct platform_device *pdev,
 int dp_register_audio_driver(struct device *dev,
 		struct dp_audio *dp_audio);
 
+void dp_unregister_audio_driver(struct device *dev, struct dp_audio *dp_audio);
+
 /**
  * dp_audio_put()
  *
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index bde1a7ce442ff..3f9a18410c0bb 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -326,6 +326,7 @@ static void dp_display_unbind(struct device *dev, struct device *master,
 	kthread_stop(dp->ev_tsk);
 
 	dp_power_client_deinit(dp->power);
+	dp_unregister_audio_driver(dev, dp->audio);
 	dp_aux_unregister(dp->aux);
 	dp->drm_dev = NULL;
 	dp->aux->drm_dev = NULL;
-- 
2.39.2



