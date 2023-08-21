Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F66782831
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 13:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHULss (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 07:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232146AbjHULsr (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 07:48:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CCEF90
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 04:48:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1C3B62367
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 11:48:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88FEC433C7;
        Mon, 21 Aug 2023 11:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692618525;
        bh=4DFC6QmN4Cpm7EnsLyhNemuNXb+38prtbRNPz+h3e3k=;
        h=Subject:To:Cc:From:Date:From;
        b=IrawjtaVTkWs16B4AmrFeiKLHSTvVtdGBx9o1lWsCdaDOoILlomXmYqNsHkq0t498
         Rs3K+tQjb/YPW9tJJYY21LrN+o58JE3mWZwXmFGiFoX2b2AcnFmRatvyJwgrCB8NWm
         dXD7Q6rTpg35toCiugzeh5Whk3dptsUrrOdnW+rw=
Subject: FAILED: patch "[PATCH] drm/amd/pm: disallow the fan setting if there is no fan on" failed to apply to 6.4-stable tree
To:     kenneth.feng@amd.com, alexander.deucher@amd.com, lijo.lazar@amd.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 21 Aug 2023 13:48:42 +0200
Message-ID: <2023082142-gizmo-recital-659c@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 6.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.4.y
git checkout FETCH_HEAD
git cherry-pick -x b6360a5ec31d160d58c1a64387b323b556cedca8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023082142-gizmo-recital-659c@gregkh' --subject-prefix 'PATCH 6.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b6360a5ec31d160d58c1a64387b323b556cedca8 Mon Sep 17 00:00:00 2001
From: Kenneth Feng <kenneth.feng@amd.com>
Date: Wed, 9 Aug 2023 18:06:05 +0800
Subject: [PATCH] drm/amd/pm: disallow the fan setting if there is no fan on
 smu 13.0.0

drm/amd/pm: disallow the fan setting if there is no fan on smu 13.0.0
V2: depend on pm.no_fan to check

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index fddcd834bcec..0fb6be11a0cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -331,6 +331,7 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
 	struct smu_13_0_0_powerplay_table *powerplay_table =
 		table_context->power_play_table;
 	struct smu_baco_context *smu_baco = &smu->smu_baco;
+	PPTable_t *pptable = smu->smu_table.driver_pptable;
 #if 0
 	PPTable_t *pptable = smu->smu_table.driver_pptable;
 	const OverDriveLimits_t * const overdrive_upperlimits =
@@ -371,6 +372,9 @@ static int smu_v13_0_0_check_powerplay_table(struct smu_context *smu)
 	table_context->thermal_controller_type =
 		powerplay_table->thermal_controller_type;
 
+	smu->adev->pm.no_fan =
+		!(pptable->SkuTable.FeaturesToRun[0] & (1 << FEATURE_FAN_CONTROL_BIT));
+
 	return 0;
 }
 

