Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F6770C83F
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjEVThB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjEVTgu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:36:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BC5188
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:36:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D4001620EB
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:36:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEDC7C4339B;
        Mon, 22 May 2023 19:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784186;
        bh=/od0+ycQAvyz2b3XIiAqfglAprJVzfDoaLz1VT4cpyA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N+3Wx230eZ7AOmHMb9jRBcnrY7yPp3+1Y5I+1e523OrQuL1yTaevEmKuT53CJT47+
         wPeT7C5YkNMeG+EGk3tgSWYj/yfJ/6raDlKHNN/ZDGPQcw4G3RIbDT+bZV5ovSEVUc
         UDZSJrdyXstHZp9geDghsiKEE0xvdgMX+awU0au8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jack Xiao <Jack.Xiao@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 291/292] drm/amd/amdgpu: introduce gc_*_mes_2.bin v2
Date:   Mon, 22 May 2023 20:10:48 +0100
Message-Id: <20230522190413.222777995@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Jack Xiao <Jack.Xiao@amd.com>

commit 97998b893c3000b27a780a4982e16cfc8f4ea555 upstream.

To avoid new mes fw running with old driver, rename
mes schq fw to gc_*_mes_2.bin.

v2: add MODULE_FIRMWARE declaration
v3: squash in fixup patch

Signed-off-by: Jack Xiao <Jack.Xiao@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c |   26 ++++++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/mes_v11_0.c  |   10 +++++-----
 2 files changed, 27 insertions(+), 9 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mes.c
@@ -1432,13 +1432,31 @@ int amdgpu_mes_init_microcode(struct amd
 	struct amdgpu_firmware_info *info;
 	char ucode_prefix[30];
 	char fw_name[40];
+	bool need_retry = false;
 	int r;
 
-	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix, sizeof(ucode_prefix));
-	snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
-		ucode_prefix,
-		pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
+	amdgpu_ucode_ip_version_decode(adev, GC_HWIP, ucode_prefix,
+				       sizeof(ucode_prefix));
+	if (adev->ip_versions[GC_HWIP][0] >= IP_VERSION(11, 0, 0)) {
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
+			 ucode_prefix,
+			 pipe == AMDGPU_MES_SCHED_PIPE ? "_2" : "1");
+		need_retry = true;
+	} else {
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes%s.bin",
+			 ucode_prefix,
+			 pipe == AMDGPU_MES_SCHED_PIPE ? "" : "1");
+	}
+
 	r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe], fw_name);
+	if (r && need_retry && pipe == AMDGPU_MES_SCHED_PIPE) {
+		snprintf(fw_name, sizeof(fw_name), "amdgpu/%s_mes.bin",
+			 ucode_prefix);
+		DRM_INFO("try to fall back to %s\n", fw_name);
+		r = amdgpu_ucode_request(adev, &adev->mes.fw[pipe],
+					 fw_name);
+	}
+
 	if (r)
 		goto out;
 
--- a/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mes_v11_0.c
@@ -32,15 +32,15 @@
 #include "v11_structs.h"
 #include "mes_v11_api_def.h"
 
-MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_0_mes1.bin");
-MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_1_mes1.bin");
-MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_2_mes1.bin");
-MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_3_mes1.bin");
-MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes.bin");
+MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes_2.bin");
 MODULE_FIRMWARE("amdgpu/gc_11_0_4_mes1.bin");
 
 static int mes_v11_0_hw_fini(void *handle);


