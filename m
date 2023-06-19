Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355BD73538D
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjFSKqg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjFSKqG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:46:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDA310DE
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:45:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67B9B60B73
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:45:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C61BC433C0;
        Mon, 19 Jun 2023 10:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171547;
        bh=xg/w/o0y1XyJU7/F+wAVFl3bYQkP2mRkFeRz0oHhQtQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCTlAEjrWsFZU6USBu3WKedDEetUKiC5u6qJMe5pB4SvKxkLcqtBldjgk+htw0No6
         9mBVoZhadKSbIKMHZBHjJ9r7ye7Oy+MLUxUEmwTGEXMAlYN3USjUUuUiqbE2QCIkAH
         yYyeOSlqegmgse2CpyzLbZg9tS4pdCmXWmLpxWoE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>, Roman Li <roman.li@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.1 071/166] drm/amd/display: edp do not add non-edid timings
Date:   Mon, 19 Jun 2023 12:29:08 +0200
Message-ID: <20230619102158.203900182@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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

commit e749dd10e5f292061ad63d2b030194bf7d7d452c upstream.

[Why] most edp support only timings from edid. applying
non-edid timings, especially those timings out of edp
bandwidth, may damage edp.

[How] do not add non-edid timings for edp.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
Reviewed-by: Roman Li <roman.li@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6942,7 +6942,13 @@ static int amdgpu_dm_connector_get_modes
 				drm_add_modes_noedid(connector, 640, 480);
 	} else {
 		amdgpu_dm_connector_ddc_get_modes(connector, edid);
-		amdgpu_dm_connector_add_common_modes(encoder, connector);
+		/* most eDP supports only timings from its edid,
+		 * usually only detailed timings are available
+		 * from eDP edid. timings which are not from edid
+		 * may damage eDP
+		 */
+		if (connector->connector_type != DRM_MODE_CONNECTOR_eDP)
+			amdgpu_dm_connector_add_common_modes(encoder, connector);
 		amdgpu_dm_connector_add_freesync_modes(connector, edid);
 	}
 	amdgpu_dm_fbc_init(connector);


