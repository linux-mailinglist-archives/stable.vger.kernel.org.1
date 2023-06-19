Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198BA735283
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjFSKfq (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjFSKfV (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:35:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88C7DE7C
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:35:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 268CC60B0D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:35:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D782C433C0;
        Mon, 19 Jun 2023 10:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170919;
        bh=s9mrKwL6HcmwOo2sdypbeGAs4lUW4dfeHZAYUaQRDYA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h77SK0rs+maGIqP39mSCeXer0BYD8qrB+JuKObDIeQerCV/Y1WLQCkN5r72UPYToM
         2LVIjgkCv+7FrMkUl+7EOF7a/dQhRZ+DLoYCSi5LC+Ih9wnLztCAg+0TLIqOnlh09p
         CFCBy6bXKjmEI8eesKYr1yuArsham1ROK8bHvIyQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.3 083/187] drm/amd: Make sure image is written to trigger VBIOS image update flow
Date:   Mon, 19 Jun 2023 12:28:21 +0200
Message-ID: <20230619102201.610617892@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

commit 3eb1a3a04056ba3df3205e169b8acc9da0c65a94 upstream.

The VBIOS image update flow requires userspace to:
1) Write the image to `psp_vbflash`
2) Read `psp_vbflash`
3) Poll `psp_vbflash_status` to check for completion

If userspace reads `psp_vbflash` before writing an image, it's
possible that it causes problems that can put the dGPU into an invalid
state.

Explicitly check that an image has been written before letting a read
succeed.

Cc: stable@vger.kernel.org
Fixes: 8424f2ccb3c0 ("drm/amdgpu/psp: Add vbflash sysfs interface support")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3538,6 +3538,9 @@ static ssize_t amdgpu_psp_vbflash_read(s
 	void *fw_pri_cpu_addr;
 	int ret;
 
+	if (adev->psp.vbflash_image_size == 0)
+		return -EINVAL;
+
 	dev_info(adev->dev, "VBIOS flash to PSP started");
 
 	ret = amdgpu_bo_create_kernel(adev, adev->psp.vbflash_image_size,


