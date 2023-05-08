Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 555766FA76B
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234669AbjEHKaU (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbjEHKaK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:30:10 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 18D9E24A8F
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:30:08 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id D3B7820EA26C;
        Mon,  8 May 2023 03:30:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3B7820EA26C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1683541807;
        bh=EWciGZ7qHIJXjOe/yZh0MoDZiARHWpsRBUkDF+Fawx4=;
        h=From:To:Cc:Subject:Date:From;
        b=Axnr6UyL426g59EY2a2uOBIVxy+oIsdx8v1hDn3PbUcoKjYBr/ZXIlta+1C/SALh1
         4YOYiteoG/V/tX68UV090EPM1S5tIDOsIPEZ7PNKZqA8pGRnwUZAzRGSscsKoFRmhX
         hq+J4V3RXMSEll3d5DE1ik6qDUTZ1NwR5eLUKjAo=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     stable@vger.kernel.org
Cc:     ssengar@linux.microsoft.com
Subject: [PATCH 5.15] drm/hyperv: Don't overwrite dirt_needed value set by host
Date:   Mon,  8 May 2023 03:30:02 -0700
Message-Id: <1683541802-14002-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

[ Upstream commit 19b5e6659eaf537ebeac90ae30c7df0296fe5ab9 ]

Existing code is causing a race condition where dirt_needed value is
already set by the host and gets overwritten with default value. Remove
this default setting of dirt_needed, to avoid overwriting the value
received in the channel callback set by vmbus_open. Removing this
setting also means the default value for dirt_needed is changed to false
as it's allocated by kzalloc which is similar to legacy hyperv_fb driver.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 00e53de4812b..584d3a73db96 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
@@ -198,8 +198,6 @@ static int hyperv_vmbus_probe(struct hv_device *hdev,
 	if (ret)
 		drm_warn(dev, "Failed to update vram location.\n");
 
-	hv->dirt_needed = true;
-
 	ret = hyperv_mode_config_init(hv);
 	if (ret)
 		goto err_vmbus_close;
-- 
2.34.1

