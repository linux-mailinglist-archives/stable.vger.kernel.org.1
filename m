Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC827037DA
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbjEORYj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244175AbjEORYV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:24:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5473D10E7D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:23:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34A6F61FA1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23645C433D2;
        Mon, 15 May 2023 17:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171388;
        bh=KuEl3I79LaBi7SqK/raDUlCtJXUfEp1kHM1zSWQhnyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aQIGEKffvSPNs0Bfz8feCK4o8X+pSltTfitOc3AvLGnL0zbRtAEJ7HonXSYZh/Wo4
         WJMZqTKsf3cJQGJlvWiIPd3/apV6+QhxPr5/hOOEAe/Fhc6Fz55KizkmpDIsITiILS
         y7ypM/fFZw/u3sHSqC2wT9LNzteK/VAGaE5p7ORg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.2 193/242] drm/amdgpu: fix an amdgpu_irq_put() issue in gmc_v9_0_hw_fini()
Date:   Mon, 15 May 2023 18:28:39 +0200
Message-Id: <20230515161727.738049312@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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

From: Hamza Mahfooz <hamza.mahfooz@amd.com>

commit 922a76ba31adf84e72bc947267385be420c689ee upstream.

As made mention of in commit 08c677cb0b43 ("drm/amdgpu: fix
amdgpu_irq_put call trace in gmc_v10_0_hw_fini") and commit 13af556104fa
("drm/amdgpu: fix amdgpu_irq_put call trace in gmc_v11_0_hw_fini"). It
is meaningless to call amdgpu_irq_put() for gmc.ecc_irq. So, remove it
from gmc_v9_0_hw_fini().

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2522
Fixes: 3029c855d79f ("drm/amdgpu: Fix desktop freezed after gpu-reset")
Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1963,7 +1963,6 @@ static int gmc_v9_0_hw_fini(void *handle
 	if (adev->mmhub.funcs->update_power_gating)
 		adev->mmhub.funcs->update_power_gating(adev, false);
 
-	amdgpu_irq_put(adev, &adev->gmc.ecc_irq, 0);
 	amdgpu_irq_put(adev, &adev->gmc.vm_fault, 0);
 
 	return 0;


