Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26E5C703694
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243806AbjEORLi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243768AbjEORLQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D03E736
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:09:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 339A862B32
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:09:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28947C433D2;
        Mon, 15 May 2023 17:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684170566;
        bh=7CcgZ+EbgcYVHvFBCtgsjJy9Qw4JfDR0nUUgQWpqON0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cDzstCVQnMbWbcBxCjsWN6dnG3jYSDoac5j4++pl/i/enDoF/XuDP/7c7xGBfXoWZ
         To3/gudPPJTGJYyABCA06NzviPz01lD890LIuZOvmQ1QizCG1gGGBRQEbXaS5Vx9Ml
         or8PLNx3kbnijWA3ZnGEhy7M9dVvO2rHknc4lD/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Lin.Cao" <lincao12@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 171/239] drm/amdgpu: Fix vram recover doesnt work after whole GPU reset (v2)
Date:   Mon, 15 May 2023 18:27:14 +0200
Message-Id: <20230515161726.801364251@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.545370111@linuxfoundation.org>
References: <20230515161721.545370111@linuxfoundation.org>
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

From: Lin.Cao <lincao12@amd.com>

commit 6c032c37ac3ef3b7df30937c785ecc4da428edc0 upstream.

v1: Vmbo->shadow is used to back vram bo up when vram lost. So that we
should set shadow as vmbo->shadow to recover vmbo->bo
v2: Modify if(vmbo->shadow) shadow = vmbo->shadow as if(!vmbo->shadow)
continue;

Fixes: e18aaea733da ("drm/amdgpu: move shadow_list to amdgpu_bo_vm")
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Lin.Cao <lincao12@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4483,7 +4483,11 @@ static int amdgpu_device_recover_vram(st
 	dev_info(adev->dev, "recover vram bo from shadow start\n");
 	mutex_lock(&adev->shadow_list_lock);
 	list_for_each_entry(vmbo, &adev->shadow_list, shadow_list) {
-		shadow = &vmbo->bo;
+		/* If vm is compute context or adev is APU, shadow will be NULL */
+		if (!vmbo->shadow)
+			continue;
+		shadow = vmbo->shadow;
+
 		/* No need to recover an evicted BO */
 		if (shadow->tbo.resource->mem_type != TTM_PL_TT ||
 		    shadow->tbo.resource->start == AMDGPU_BO_INVALID_OFFSET ||


