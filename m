Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5607A7B88
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 13:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbjITLxJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 07:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjITLxH (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 07:53:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEF3AD
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 04:53:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 774DCC433C8;
        Wed, 20 Sep 2023 11:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695210781;
        bh=b0pI8QF9dNR9egM/XNf/eJxNYQU4g8fSrg+p5jwLhpk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1t7ateqmXeQuDvDZorM7jKd6z7giPhYhVW+MiYnwXbvJfazCc5cM0zB0+nrcbsBZ5
         mPsjPjBu5OTiagEbqf60rCUVpqx0TOlPyVea3fPAFbH5e0ZYjehHM47dIqQhxGORWm
         Cx13dPL4gxQX+XoTHejMEIHrAYm4ej+ToVoK1Tqk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Deucher <alexander.deucher@amd.com>,
        Simon Pilkington <simonp.git@gmail.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 6.5 202/211] drm/radeon: make fence wait in suballocator uninterrruptable
Date:   Wed, 20 Sep 2023 13:30:46 +0200
Message-ID: <20230920112852.128341215@linuxfoundation.org>
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

From: Alex Deucher <alexander.deucher@amd.com>

commit dcbad727513d277144aee482b2ffbcd2255c37aa upstream.

Commit 254986e324ad ("drm/radeon: Use the drm suballocation manager implementation.")
made the fence wait in amdgpu_sa_bo_new() interruptible but there is no
code to handle an interrupt. This caused the kernel to randomly explode
in high-VRAM-pressure situations so make it uninterruptible again.

Fixes: 254986e324ad ("drm/radeon: Use the drm suballocation manager implementation.")
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2769
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
CC: stable@vger.kernel.org # 6.4+
CC: Simon Pilkington <simonp.git@gmail.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230906195517.1345717-1-alexander.deucher@amd.com
Signed-off-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/radeon/radeon_sa.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/radeon/radeon_sa.c
+++ b/drivers/gpu/drm/radeon/radeon_sa.c
@@ -123,7 +123,7 @@ int radeon_sa_bo_new(struct radeon_sa_ma
 		     unsigned int size, unsigned int align)
 {
 	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
-						   GFP_KERNEL, true, align);
+						   GFP_KERNEL, false, align);
 
 	if (IS_ERR(sa)) {
 		*sa_bo = NULL;


