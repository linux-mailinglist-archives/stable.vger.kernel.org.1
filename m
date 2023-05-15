Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5820E70385C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243353AbjEORcJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:32:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242625AbjEORbe (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:31:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A30D14E70
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6A6762CF6
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A3AC433EF;
        Mon, 15 May 2023 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171694;
        bh=3vLdLPB3pcM1IWnqjkfSjDouRNOjFoxsNHVOaWvc284=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xT1hfVtbySch8e5ZCCfxE7TkyOL7C0917GkrC+Au2DJ20XJMELOwWDwvJsWVAh9BX
         2iC7+rFEyY7l21vHWLpsoO8SrM4Mu+LLhfyETS+rHC/HkW0/+HmbHJa9+OTfPt/XQM
         fVTDOEO827ZpsEtG2S8w/rhrDRIIMM3tOFEzByTY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Saurabh Sengar <ssengar@linux.microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 018/134] drm/hyperv: Dont overwrite dirt_needed value set by host
Date:   Mon, 15 May 2023 18:28:15 +0200
Message-Id: <20230515161703.604152837@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

From: Saurabh Sengar <ssengar@linux.microsoft.com>

[ Upstream commit 19b5e6659eaf537ebeac90ae30c7df0296fe5ab9 ]

Existing code is causing a race condition where dirt_needed value is
already set by the host and gets overwritten with default value. Remove
this default setting of dirt_needed, to avoid overwriting the value
received in the channel callback set by vmbus_open. Removing this
setting also means the default value for dirt_needed is changed to false
as it's allocated by kzalloc which is similar to legacy hyperv_fb driver.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/1662996766-19304-1-git-send-email-ssengar@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_drv.c b/drivers/gpu/drm/hyperv/hyperv_drm_drv.c
index 00e53de4812bb..584d3a73db96c 100644
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
2.39.2



