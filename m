Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C94287A7B6A
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234743AbjITLv6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjITLv4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:51:56 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50666CA
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:51:49 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FBDDC433CC;
        Wed, 20 Sep 2023 11:51:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210708;
        bh=EO07YlRIVSBpvp80E7NjcnsUr0bJb1a0DOmRvz4QVvo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=liPGuKV2cvr9z1+TdzaCtHCccMbCQ0Lqhbapdk8y/opPp1klGMye4g9FGG7Jpulsp
         5pgAw89nxolmR3LBSAjfLoEwNdYLXkmeB5I1jUrS/CeY+xdI8FPrDFcQoG7Q6DnHRf
         xd4TVxAZRg78+zb59OwRzh/pr6fQsu7vukUW07+I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Simon Pilkington <simonp.git@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 6.5 175/211] drm/amd: Make fence wait in suballocator uninterruptible
Date:   Wed, 20 Sep 2023 13:30:19 +0200
Message-ID: <20230920112851.306966386@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112845.859868994@linuxfoundation.org>
References: <20230920112845.859868994@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Pilkington <simonp.git@gmail.com>

commit e2884fe84a83c562346eb9d92783a3576ce67177 upstream.

Commit c103a23f2f29
("drm/amd: Convert amdgpu to use suballocation helper.")
made the fence wait in amdgpu_sa_bo_new() interruptible but there is no
code to handle an interrupt. This caused the kernel to randomly explode
in high-VRAM-pressure situations so make it uninterruptible again.

Signed-off-by: Simon Pilkington <simonp.git@gmail.com>
Fixes: c103a23f2f29 ("drm/amd: Convert amdgpu to use suballocation helper.")
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2761
CC: stable@vger.kernel.org # 6.4+
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -81,7 +81,7 @@ int amdgpu_sa_bo_new(struct amdgpu_sa_ma
 		     unsigned int size)
 {
 	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
-						   GFP_KERNEL, true, 0);
+						   GFP_KERNEL, false, 0);
 
 	if (IS_ERR(sa)) {
 		*sa_bo = NULL;


