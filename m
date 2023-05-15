Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A99107036C6
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243777AbjEORNy (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243816AbjEORNa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:13:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4DCA5C8
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:11:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCF2562B5C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C70D5C433EF;
        Mon, 15 May 2023 17:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170709;
        bh=7OUK97C5iHsWr2QaPyn8rk8/bCc8lvYudI710fn/FRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FwUJkHQj3VtL2UPxzwqvzzRXTrF2xzIaMBwaa9x8ZNvb+mhAg26FUprIUfZMDx21Q
         RX0OUscaF+YFTBltZVLJsjt1FdzArmxFOg5Fj86CpR/WuUwzOT79SGvExs9yXTBLP7
         L7Lnt+TGAclsORwDsrwiZ2CFUaQynCTYr8jtzVwg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Lijo Lazar <lijo.lazar@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 178/239] drm/amd: Add a new helper for loading/validating microcode
Date:   Mon, 15 May 2023 18:27:21 +0200
Message-Id: <20230515161727.007875544@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Mario Limonciello <mario.limonciello@amd.com>

commit 2210af50ae7f4104269dfde7bafbbfbacdbe1a2b upstream.

All microcode runs a basic validation after it's been loaded. Each
IP block as part of init will run both.

Introduce a wrapper for request_firmware and amdgpu_ucode_validate.
This wrapper will also remap any error codes from request_firmware
to -ENODEV.  This is so that early_init will fail if firmware couldn't
be loaded instead of the IP block being disabled.

Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c |   36 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h |    3 ++
 2 files changed, 39 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -1091,3 +1091,39 @@ void amdgpu_ucode_ip_version_decode(stru
 
 	snprintf(ucode_prefix, len, "%s_%d_%d_%d", ip_name, maj, min, rev);
 }
+
+/*
+ * amdgpu_ucode_request - Fetch and validate amdgpu microcode
+ *
+ * @adev: amdgpu device
+ * @fw: pointer to load firmware to
+ * @fw_name: firmware to load
+ *
+ * This is a helper that will use request_firmware and amdgpu_ucode_validate
+ * to load and run basic validation on firmware. If the load fails, remap
+ * the error code to -ENODEV, so that early_init functions will fail to load.
+ */
+int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
+			 const char *fw_name)
+{
+	int err = request_firmware(fw, fw_name, adev->dev);
+
+	if (err)
+		return -ENODEV;
+	err = amdgpu_ucode_validate(*fw);
+	if (err)
+		dev_dbg(adev->dev, "\"%s\" failed to validate\n", fw_name);
+
+	return err;
+}
+
+/*
+ * amdgpu_ucode_release - Release firmware microcode
+ *
+ * @fw: pointer to firmware to release
+ */
+void amdgpu_ucode_release(const struct firmware **fw)
+{
+	release_firmware(*fw);
+	*fw = NULL;
+}
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.h
@@ -543,6 +543,9 @@ void amdgpu_ucode_print_sdma_hdr(const s
 void amdgpu_ucode_print_psp_hdr(const struct common_firmware_header *hdr);
 void amdgpu_ucode_print_gpu_info_hdr(const struct common_firmware_header *hdr);
 int amdgpu_ucode_validate(const struct firmware *fw);
+int amdgpu_ucode_request(struct amdgpu_device *adev, const struct firmware **fw,
+			 const char *fw_name);
+void amdgpu_ucode_release(const struct firmware **fw);
 bool amdgpu_ucode_hdr_version(union amdgpu_firmware_header *hdr,
 				uint16_t hdr_major, uint16_t hdr_minor);
 


