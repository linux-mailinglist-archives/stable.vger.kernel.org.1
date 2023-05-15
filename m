Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 340427033B8
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242849AbjEOQkn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242880AbjEOQkd (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:40:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4AC170C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:40:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 526F56287F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4768BC433EF;
        Mon, 15 May 2023 16:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168831;
        bh=iJbzYw6RmxdfyncJqJbNK5q/D6ZHfDuaKk4WM23dIOw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yHP+DqiOXP/Ip0zwcySQsZYHjd6RuS9LUxu6K4Pp0GuXtGxCfjE69UX9Sy/smyRSK
         Wsa8N1E9EFimBrOvMCaTEhyMdsaCC+53voriECndwML4IXU9U0cRbvkXcglM64x1Lp
         a2JwaZE/XVuF5JF4BpkCUigBgx70/HUlv8eCwm7c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Daniel Vetter <daniel@ffwll.ch>,
        Dom Cobley <popcornmix@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 027/191] drm/probe-helper: Cancel previous job before starting new one
Date:   Mon, 15 May 2023 18:24:24 +0200
Message-Id: <20230515161708.158022145@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161707.203549282@linuxfoundation.org>
References: <20230515161707.203549282@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index c0b26135dbd5b..f9e0594ee7024 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -459,8 +459,9 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
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



