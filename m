Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133F77A39B9
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240115AbjIQTxh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240155AbjIQTxN (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:53:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965B5EE
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:53:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B70C433C8;
        Sun, 17 Sep 2023 19:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980388;
        bh=S8KM1Z+IhlTMHvCzMBsp73/plPCPlfIV44m8XavTalw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IWQ1dD0v8YGVAA0qyQeF7U/SpQ7f7jDg2rtmKBq69IRC6G4rPEXP/HoGsCRW+nYgv
         6l7ZsmSZ8gFeJAamqkajZq0jd+5IAcrLwbtsPhb9GdJwSM0hYxIBoTTpzREvEtF6zJ
         l81xWSjL/OAkVG/Z1d6z7GuXebHCJM5sxJ+ZqQaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Fangzhi Zuo <jerry.zuo@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.5 178/285] drm/amd/display: Temporary Disable MST DP Colorspace Property
Date:   Sun, 17 Sep 2023 21:12:58 +0200
Message-ID: <20230917191057.789210819@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fangzhi Zuo <jerry.zuo@amd.com>

commit 69a959610229ec31b534eaa5f6ec75965f321bed upstream.

Create MST colorsapce property for downstream device would trigger
warning message "RIP: 0010:drm_mode_object_add+0x8e/0xa0 [drm]"

After driver is loaded and drm device is registered, create
dp colorspace property triggers warning storm at
WARN_ON(!dev->driver->load && dev->registered && !obj_free_cb);

Temporary disabling MST dp colorspace property for now.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -7295,7 +7295,7 @@ void amdgpu_dm_connector_init_helper(str
 	if (connector_type == DRM_MODE_CONNECTOR_HDMIA) {
 		if (!drm_mode_create_hdmi_colorspace_property(&aconnector->base, supported_colorspaces))
 			drm_connector_attach_colorspace_property(&aconnector->base);
-	} else if (connector_type == DRM_MODE_CONNECTOR_DisplayPort ||
+	} else if ((connector_type == DRM_MODE_CONNECTOR_DisplayPort && !aconnector->mst_root) ||
 		   connector_type == DRM_MODE_CONNECTOR_eDP) {
 		if (!drm_mode_create_dp_colorspace_property(&aconnector->base, supported_colorspaces))
 			drm_connector_attach_colorspace_property(&aconnector->base);


