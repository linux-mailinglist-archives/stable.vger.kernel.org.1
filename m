Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE6FD79BFF8
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379565AbjIKWot (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242176AbjIKPYS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:24:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329C8D8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:24:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E1CDC433C8;
        Mon, 11 Sep 2023 15:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445852;
        bh=aV/I8juPyPyfTlbXrY3gqXAIo/N7V7xqpERtbR+Zsm0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p+PvOH/M8v1EMJ3+3nqaIIYgbGm9hWr5z2qSfv3/Axnq7HIYRAVLCrxKo9tyjycJq
         vse1LCf45TsZ/wewdHsxpQwwagxTPr/OYC/y1DOR53vrrT8zkoMWK5kDrJ18Ug4VXn
         LPgaUqyfvAcYzAAL91bRnhVZxBoY/lwgXHMFrJLY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 495/600] platform/x86/amd/pmf: Fix a missing cleanup path
Date:   Mon, 11 Sep 2023 15:48:48 +0200
Message-ID: <20230911134648.241497826@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 4dbd6e61adc7e52dd1c9165f0ccaa90806611e40 ]

On systems that support slider notifications but don't otherwise support
granular slider the SPS cleanup path doesn't run.

This means that loading/unloading/loading leads to failures because
the sysfs files don't get setup properly when reloaded.

Add the missing cleanup path.

Fixes: 33c9ab5b493a ("platform/x86/amd/pmf: Notify OS power slider update")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230823185421.23959-1-mario.limonciello@amd.com
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/x86/amd/pmf/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index 8a38cd94a605d..d10c097380c56 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -322,7 +322,8 @@ static void amd_pmf_init_features(struct amd_pmf_dev *dev)
 
 static void amd_pmf_deinit_features(struct amd_pmf_dev *dev)
 {
-	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
+	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR) ||
+	    is_apmf_func_supported(dev, APMF_FUNC_OS_POWER_SLIDER_UPDATE)) {
 		power_supply_unreg_notifier(&dev->pwr_src_notifier);
 		amd_pmf_deinit_sps(dev);
 	}
-- 
2.40.1



