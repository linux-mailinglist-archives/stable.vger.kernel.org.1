Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2914B713DEF
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjE1TaV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjE1TaT (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:30:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05388A3
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 888DA61D4F
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A67C5C433EF;
        Sun, 28 May 2023 19:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302218;
        bh=2DBTToYIxCmJtsTvy4uY/RwMz0EtYANGVkbPiACxozw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c4Zfca24wsjQLBDtrkvtFRIGRUMRxod5zUi3YbbRo8NYymeVlhosUF/aTov7XRtT1
         3DbOWfQx4AfPcs2eKA0vxZi5LxHZWikJNccvfaAY2OIPi2YjEc+45vYYV7KNa8dki9
         xEH+lKv2fQE7/oWvVbVsJxk5k1fbvw4YDgumjk7s=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aaron Liu <aaron.liu@amd.com>,
        Jesse zhang <jesse.zhang@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.3 047/127] drm/amdgpu: dont enable secure display on incompatible platforms
Date:   Sun, 28 May 2023 20:10:23 +0100
Message-Id: <20230528190837.879072720@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jesse Zhang <jesse.zhang@amd.com>

commit 7fc602dbfd548045862df096910b7d21e6d300bf upstream.

[why]
[drm] psp gfx command LOAD_TA(0x1) failed and response status is (0x7)
[drm] psp gfx command INVOKE_CMD(0x3) failed and response status is (0x4)
amdgpu 0000:04:00.0: amdgpu: Secure display: Generic Failure.

[how]
don't enable secure display on incompatible platforms

Suggested-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Jesse zhang <jesse.zhang@amd.com>
Reviewed-by: Aaron Liu <aaron.liu@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/psp_v10_0.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/psp_v10_0.c
@@ -57,7 +57,13 @@ static int psp_v10_0_init_microcode(stru
 	if (err)
 		return err;
 
-	return psp_init_ta_microcode(psp, ucode_prefix);
+	err = psp_init_ta_microcode(psp, ucode_prefix);
+	if ((adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 1, 0)) &&
+		(adev->pdev->revision == 0xa1) &&
+		(psp->securedisplay_context.context.bin_desc.fw_version >= 0x27000008)) {
+		adev->psp.securedisplay_context.context.bin_desc.size_bytes = 0;
+	}
+	return err;
 }
 
 static int psp_v10_0_ring_create(struct psp_context *psp,


