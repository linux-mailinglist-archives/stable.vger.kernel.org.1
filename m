Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CB56FA433
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 11:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233848AbjEHJ4m (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 05:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233847AbjEHJ4f (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 05:56:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F662ABE1
        for <stable@vger.kernel.org>; Mon,  8 May 2023 02:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DDE762253
        for <stable@vger.kernel.org>; Mon,  8 May 2023 09:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91532C433EF;
        Mon,  8 May 2023 09:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683539783;
        bh=aKv70BPDBnEqjeJtzk5NvHIUsw2Kg8+tzHAL8QL2NvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IDTXpA67wSKStbeTg736Qjx+cKcDLxNWNLeK3XJyskGw/Foxl00DblRDbPHqgxea6
         itVx0GfXnR2XWsYSUzKhHds2oUcK0u1+d67heXyBMT5sTRlbwP1X1UepEjr0kCe5v4
         5u+Yt4FjwEF2SEWssky2QGK8qxB6ZdwddwzdV2R4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Vetter <daniel@ffwll.ch>,
        Dom Cobley <popcornmix@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 134/611] drm/probe-helper: Cancel previous job before starting new one
Date:   Mon,  8 May 2023 11:39:36 +0200
Message-Id: <20230508094426.608904467@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Dom Cobley <popcornmix@gmail.com>

[ Upstream commit a8e47884f1906cd7440fafa056adc8817568e73e ]

Currently we schedule a call to output_poll_execute from
drm_kms_helper_poll_enable for 10s in future. Later we try to replace
that in drm_helper_probe_single_connector_modes with a 0s schedule with
delayed_event set.

But as there is already a job in the queue this fails, and the immediate
job we wanted with delayed_event set doesn't occur until 10s later.

And that call acts as if connector state has changed, reprobing modes.
This has a side effect of waking up a display that has been blanked.

Make sure we cancel the old job before submitting the immediate one.

Fixes: 162b6a57ac50 ("drm/probe-helper: don't lose hotplug event")
Acked-by: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Dom Cobley <popcornmix@gmail.com>
[Maxime: Switched to mod_delayed_work]
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20230127154052.452524-1-maxime@cerno.tech
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/drm_probe_helper.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index 69b0b2b9cc1c5..3b968ad187cf3 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -557,8 +557,9 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 		 */
 		dev->mode_config.delayed_event = true;
 		if (dev->mode_config.poll_enabled)
-			schedule_delayed_work(&dev->mode_config.output_poll_work,
-					      0);
+			mod_delayed_work(system_wq,
+					 &dev->mode_config.output_poll_work,
+					 0);
 	}
 
 	/* Re-enable polling in case the global poll config changed. */
-- 
2.39.2



