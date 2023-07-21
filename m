Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F078675BFB4
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 09:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjGUH21 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 03:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGUH20 (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 03:28:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB17189
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 00:28:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DD3D61136
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 07:28:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2AD9C433C8;
        Fri, 21 Jul 2023 07:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689924504;
        bh=2ng2huH1S2rk0CHNMsqavH3R5cC5VYivMBoqRP5EEM8=;
        h=Subject:To:Cc:From:Date:From;
        b=rAwrQAOSM0oY4BoYq/4r45vZ6yN2LAzyaMtq/UY+i328g7NltX4SxWJZ9OI1YCayM
         +Z1iw7x4L8/VBqOWN16sApqFTzZ0MMKq7jTiN9TclPtEXuJdBR6u7xB5+U0gIMMlmL
         hEuR7LaZ/ffTi4cMeewGqhAFgKpI0EJ3CFM/vtis=
Subject: FAILED: patch "[PATCH] drm/amd/display: Set minimum requirement for using PSR-SU on" failed to apply to 6.1-stable tree
To:     mario.limonciello@amd.com, Hamza.Mahfooz@amd.com,
        Marc.Rossi@amd.com, Tsung-hua.Lin@amd.com,
        alexander.deucher@amd.com, sean.ns.wang@amd.com, sunpeng.li@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Fri, 21 Jul 2023 09:28:21 +0200
Message-ID: <2023072121-hypnotism-wheat-48ff@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x cd2e31a9ab93d13c412a36c6e26811e0f830985b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023072121-hypnotism-wheat-48ff@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

cd2e31a9ab93 ("drm/amd/display: Set minimum requirement for using PSR-SU on Phoenix")
c35b6ea8f2ec ("drm/amd/display: Set minimum requirement for using PSR-SU on Rembrandt")
268182606f26 ("drm/amd/display: Update correct DCN314 register header")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cd2e31a9ab93d13c412a36c6e26811e0f830985b Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Fri, 23 Jun 2023 10:05:21 -0500
Subject: [PATCH] drm/amd/display: Set minimum requirement for using PSR-SU on
 Phoenix

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

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.c
index 48a06dbd9be7..f161aeb7e7c4 100644
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
index 674267a2940e..f213bd82c911 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_dcn314.h
@@ -30,4 +30,6 @@
 
 extern const struct dmub_srv_dcn31_regs dmub_srv_dcn314_regs;
 
+bool dmub_dcn314_is_psrsu_supported(struct dmub_srv *dmub);
+
 #endif /* _DMUB_DCN314_H_ */
diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 7a31e3e27bab..bdaf43892f47 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -228,6 +228,7 @@ static bool dmub_srv_hw_setup(struct dmub_srv *dmub, enum dmub_asic asic)
 	case DMUB_ASIC_DCN316:
 		if (asic == DMUB_ASIC_DCN314) {
 			dmub->regs_dcn31 = &dmub_srv_dcn314_regs;
+			funcs->is_psrsu_supported = dmub_dcn314_is_psrsu_supported;
 		} else if (asic == DMUB_ASIC_DCN315) {
 			dmub->regs_dcn31 = &dmub_srv_dcn315_regs;
 		} else if (asic == DMUB_ASIC_DCN316) {

