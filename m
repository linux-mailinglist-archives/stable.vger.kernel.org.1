Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E94F6755128
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 21:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbjGPTxX (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 15:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjGPTxW (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 15:53:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8734A199
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 12:53:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2283E60E65
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 19:53:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB5EC433C8;
        Sun, 16 Jul 2023 19:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689537200;
        bh=H3RTGC3DD0ahaWugNBydCwVfi2D0OgnzzpElM7xWMsQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AczxdOvq8QGP1q42inWhAzKReV4btBPQlvMaguLAU2ZsunjwrUgpmrDibZmS1P4J8
         Zjb5S8xyWnC0uF5sMl6DwxnTYZOZ0k/gjBh2Fnj+1T09yS0cGQO4DwU5T4Il0w2KXw
         Geg+tR6gufpsE08Ex8dfLZxBrUMaJtW8G2puKxRc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hersen Wu <hersenxs.wu@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 012/800] Revert "drm/amd/display: edp do not add non-edid timings"
Date:   Sun, 16 Jul 2023 21:37:45 +0200
Message-ID: <20230716194949.391486148@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194949.099592437@linuxfoundation.org>
References: <20230716194949.099592437@linuxfoundation.org>
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

From: Hersen Wu <hersenxs.wu@amd.com>

commit d6149086b45e150c170beaa4546495fd1880724c upstream.

This change causes regression when eDP and external display in mirror
mode. When external display supports low resolution than eDP, use eDP
timing to driver external display may cause corruption on external
display.

This reverts commit e749dd10e5f292061ad63d2b030194bf7d7d452c.

Cc: stable@vger.kernel.org
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2655
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7196,13 +7196,7 @@ static int amdgpu_dm_connector_get_modes
 				drm_add_modes_noedid(connector, 1920, 1080);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
-		/* most eDP supports only timings from its edid,
-		 * usually only detailed timings are available
-		 * from eDP edid. timings which are not from edid
-		 * may damage eDP
-		 */
-		if (connector->connector_type != DRM_MODE_CONNECTOR_eDP)
-			amdgpu_dm_connector_add_common_modes(encoder, connector);
+		amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);


