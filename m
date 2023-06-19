Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B792735285
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjFSKf7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjFSKfa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:35:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C61610FB
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:35:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 890A860B62
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F878C433C8;
        Mon, 19 Jun 2023 10:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170925;
        bh=cIqPB5r/4AVddlnkE81WuNm20SMJe/X/kM6RAQwzdrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JHjZX/Eu4WjLKO58ohHr7b9rUVlDnkBfS2S3lEHPiotZVfAddsFhp7a0xDDgypYOh
         iGaQFcOMOINYgWC7+TEqnPSnbAC7Zs0v5KQsPvnCsBe/DQVa8R99mmTJ7/3UeVqmWS
         4+7Dqd61Gwlp1DxVrJIsF1+7QtyBOxJQtQN128jQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.3 084/187] drm/amd: Tighten permissions on VBIOS flashing attributes
Date:   Mon, 19 Jun 2023 12:28:22 +0200
Message-ID: <20230619102201.650728341@linuxfoundation.org>
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

commit 7ab1a4913d0051cf5196ef7987b5fa42c25e13b6 upstream.

Non-root users shouldn't be able to try to trigger a VBIOS flash
or query the flashing status.  This should be reserved for users with the
appropriate permissions.

Cc: stable@vger.kernel.org
Fixes: 8424f2ccb3c0 ("drm/amdgpu/psp: Add vbflash sysfs interface support")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -3592,13 +3592,13 @@ static ssize_t amdgpu_psp_vbflash_status
 }
 
 static const struct bin_attribute psp_vbflash_bin_attr = {
-	.attr = {.name = "psp_vbflash", .mode = 0664},
+	.attr = {.name = "psp_vbflash", .mode = 0660},
 	.size = 0,
 	.write = amdgpu_psp_vbflash_write,
 	.read = amdgpu_psp_vbflash_read,
 };
 
-static DEVICE_ATTR(psp_vbflash_status, 0444, amdgpu_psp_vbflash_status, NULL);
+static DEVICE_ATTR(psp_vbflash_status, 0440, amdgpu_psp_vbflash_status, NULL);
 
 int amdgpu_psp_sysfs_init(struct amdgpu_device *adev)
 {


