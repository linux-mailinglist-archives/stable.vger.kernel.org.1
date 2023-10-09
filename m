Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6097F7BDD59
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376765AbjJINJk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376778AbjJINJh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:09:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED13B9C
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:09:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA381C433C7;
        Mon,  9 Oct 2023 13:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856972;
        bh=FNk55jDiMxkxetK6BAQtw71JnC9GF5QkmSRsWwQEPe0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjGxg31bKp+cedWpmHOAjJxok9yl38GjkgW6tsztpj4a4qErfIE//wM82gqcxIrFB
         jhVMQuo4bD5aFkIDgISsu0wytaj/Qz3EsHYGjRgDII+Q+A+fiKdOP2mtuIfzpWlG18
         OwWs7vdQ8HFYJwzT+JmzzP8GFgcc5OdqkGTx+Nvo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jun Ma <Jun.Ma2@amd.com>,
        David Perry <David.Perry@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.5 052/163] drm/amd: Fix detection of _PR3 on the PCIe root port
Date:   Mon,  9 Oct 2023 15:00:16 +0200
Message-ID: <20231009130125.473204757@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit 134b8c5d8674e7cde380f82e9aedfd46dcdd16f7 upstream.

On some systems with Navi3x dGPU will attempt to use BACO for runtime
PM but fails to resume properly.  This is because on these systems
the root port goes into D3cold which is incompatible with BACO.

This happens because in this case dGPU is connected to a bridge between
root port which causes BOCO detection logic to fail.  Fix the intent of
the logic by looking at root port, not the immediate upstream bridge for
_PR3.

Cc: stable@vger.kernel.org
Suggested-by: Jun Ma <Jun.Ma2@amd.com>
Tested-by: David Perry <David.Perry@amd.com>
Fixes: b10c1c5b3a4e ("drm/amdgpu: add check for ACPI power resources")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2308,7 +2308,7 @@ static int amdgpu_device_ip_early_init(s
 		adev->flags |= AMD_IS_PX;
 
 	if (!(adev->flags & AMD_IS_APU)) {
-		parent = pci_upstream_bridge(adev->pdev);
+		parent = pcie_find_root_port(adev->pdev);
 		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
 	}
 


