Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 392E2703531
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243235AbjEOQ4d (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243227AbjEOQ4c (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:56:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7125FD5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:56:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46ABE62A12
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:56:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39440C433D2;
        Mon, 15 May 2023 16:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169784;
        bh=gHwocGite3FnJHIeWjDsd9hljM4pRdYxv0OaXT2IviM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nYLtXjErXZD3dJxlFo7ukqCOy8VjZnp0sURV+EDJcH4/8ZDSlI6V3rnfhtQVeNacK
         40bCmO6/qJCb1UNbKcaPm/hKvqoA64hFLly6Wpg1yvmdW7TDbID+LwVszPaeRKKA6k
         KOdPIfClu4JR4l9u//NIV8BjIU5u0z4OZGsrhi2A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Animesh Manna <animesh.manna@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 6.3 169/246] drm/i915/color: Fix typo for Plane CSC indexes
Date:   Mon, 15 May 2023 18:26:21 +0200
Message-Id: <20230515161727.703043200@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.610123835@linuxfoundation.org>
References: <20230515161722.610123835@linuxfoundation.org>
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

From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

commit 2efc8e1001acfdc143cf2d25a08a4974c322e2a8 upstream.

Replace _PLANE_INPUT_CSC_RY_GY_2_* with _PLANE_CSC_RY_GY_2_*
for Plane CSC

Fixes: 6eba56f64d5d ("drm/i915/pxp: black pixels on pxp disabled")

Cc: <stable@vger.kernel.org>

Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Signed-off-by: Animesh Manna <animesh.manna@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230330150104.2923519-1-chaitanya.kumar.borah@intel.com
(cherry picked from commit e39c76b2160bbd005587f978d29603ef790aefcd)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/i915_reg.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/i915/i915_reg.h
+++ b/drivers/gpu/drm/i915/i915_reg.h
@@ -7596,8 +7596,8 @@ enum skl_power_gate {
 
 #define _PLANE_CSC_RY_GY_1(pipe)	_PIPE(pipe, _PLANE_CSC_RY_GY_1_A, \
 					      _PLANE_CSC_RY_GY_1_B)
-#define _PLANE_CSC_RY_GY_2(pipe)	_PIPE(pipe, _PLANE_INPUT_CSC_RY_GY_2_A, \
-					      _PLANE_INPUT_CSC_RY_GY_2_B)
+#define _PLANE_CSC_RY_GY_2(pipe)	_PIPE(pipe, _PLANE_CSC_RY_GY_2_A, \
+					      _PLANE_CSC_RY_GY_2_B)
 #define PLANE_CSC_COEFF(pipe, plane, index)	_MMIO_PLANE(plane, \
 							    _PLANE_CSC_RY_GY_1(pipe) +  (index) * 4, \
 							    _PLANE_CSC_RY_GY_2(pipe) + (index) * 4)


