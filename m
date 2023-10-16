Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038C27CA268
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232912AbjJPItb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjJPIt3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:49:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B769CB4
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:49:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04760C433CB;
        Mon, 16 Oct 2023 08:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697446165;
        bh=OvCtJMTKeMVdE3fTnUbkWB+VrjDZ2BRmlsUfSwhKPWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xzDNdeCbum2c5cIFsJceDynrzoq8SFontV/hUNKnPM50+ueTC4RNCegtu3U422hKd
         pNnmL3116l7i5yy8SqpNLbT2qzPXfHgLGNft9vzwM17w/dOjAmekRoCPLUeATfJxuO
         8AjhZqBm8nZv5gbC3ZB+ttFOIepvbwdGb1NC3z+c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 5.15 058/102] drm/amdgpu: add missing NULL check
Date:   Mon, 16 Oct 2023 10:40:57 +0200
Message-ID: <20231016083955.246359336@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian König <christian.koenig@amd.com>

commit ff89f064dca38e2203790bf876cc7756b8ab2961 upstream.

bo->tbo.resource can easily be NULL here.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2902
Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -221,7 +221,7 @@ static inline bool amdgpu_bo_in_cpu_visi
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_res_cursor cursor;
 
-	if (bo->tbo.resource->mem_type != TTM_PL_VRAM)
+	if (!bo->tbo.resource || bo->tbo.resource->mem_type != TTM_PL_VRAM)
 		return false;
 
 	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);


