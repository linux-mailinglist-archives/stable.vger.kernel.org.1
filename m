Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EC476AF5F
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjHAJq6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjHAJo6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:44:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780281BD
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:42:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F3AB9614FF
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:42:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 102DEC433C8;
        Tue,  1 Aug 2023 09:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690882966;
        bh=MZnXpx9dRTQM+9OT+78YOBTpervD520XISPh+SST6mU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0gWlg991qva/TBQqfLAh3s11lC7zyad2sIrk7j7wgzmf2wG2U7OJUkh++NpanIbYk
         ZWNSl/mv9SRwjUk9d1R4smONAZ4GZgGVWjfhdSsr183gh8Voli7nOLB6wbUHjt5rAw
         DHOPOIIX+0nGi45U6HSiytZtd4V7CwzETjHjmHUE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sean Wang <sean.ns.wang@amd.com>,
        Marc Rossi <Marc.Rossi@amd.com>,
        Hamza Mahfooz <Hamza.Mahfooz@amd.com>,
        "Tsung-hua (Ryan) Lin" <Tsung-hua.Lin@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 038/239] drm/amd/display: Set minimum requirement for using PSR-SU on Phoenix
Date:   Tue,  1 Aug 2023 11:18:22 +0200
Message-ID: <20230801091926.959825361@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit cd2e31a9ab93d13c412a36c6e26811e0f830985b ]

The same parade TCON issue can potentially happen on Phoenix, and the same
PSR resilience changes have been ported into the DMUB firmware.

Don't allow running PSR-SU unless on the newer firmware.

Cc: stable@vger.kernel.org
Cc: Sean Wang <sean.ns.wang@amd.com>
Cc: Marc Rossi <Marc.Rossi@amd.com>
Cc: Hamza Mahfooz <Hamza.Mahfooz@amd.com>
Cc: Tsung-hua (Ryan) Lin <Tsung-hua.Lin@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c | 5 +++++
 drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h | 2 ++
 drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c    | 1 +
 3 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
index 48a06dbd9be78..f161aeb7e7c4a 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
@@ -60,3 +60,8 @@ const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs = {
 	{ DMUB_DCN31_FIELDS() },
 #undef DMUB_SF
 };
+
+bool dmub_dcn314_is_psrsu_supported(struct dmub_srv *dmub)
+{
+	return dmub->fw_version >= DMUB_FW_VERSION(8, 0, 16);
+}
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
index 674267a2940e9..f213bd82c9110 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
@@ -30,4 +30,6 @@
 
 extern const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs;
 
+bool dmub_dcn314_is_psrsu_supported(struct dmub_srv *dmub);
+
 #endif /* _DMUB_DCN314_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 0f43a05a41874..0dab22d794808 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -229,6 +229,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 	case DMUB_ASIC_DCN316:
 		if (asic == DMUB_ASIC_DCN314) {
 			dmub->regs_dcn31 = &dmub_srv_dcn314_regs;
+			funcs->is_psrsu_supported = dmub_dcn314_is_psrsu_supported;
 		} else if (asic == DMUB_ASIC_DCN315) {
 			dmub->regs_dcn31 = &dmub_srv_dcn315_regs;
 		} else if (asic == DMUB_ASIC_DCN316) {
-- 
2.39.2



