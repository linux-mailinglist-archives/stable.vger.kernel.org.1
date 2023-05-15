Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E227037DE
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244149AbjEORYn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244084AbjEORY2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:24:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C1711605
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:23:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A55DF62C91
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:23:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A775C433D2;
        Mon, 15 May 2023 17:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171401;
        bh=IcUzBw2bJUhkxixdzg5JVu4DLN2PnXV8cHT1T81XTTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=snOPAKMlNmMp7DLHbL/g9Yvc/UOZNxNNxmPgZOVzqitfpiTxJzDz1E9lIZAz2NrqT
         u4wWVHxpApTKlRZj1gERV/FpFLWdcg3SAQ+v/I+82rBFeqiHbm8inxPI+7Y98uoXYc
         0JKkBudfEYM/0GMno48lc4De1sGLpXOxIPEWvHwk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
        Uma Shankar <uma.shankar@intel.com>,
        Animesh Manna <animesh.manna@intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Subject: [PATCH 6.2 170/242] drm/i915/color: Fix typo for Plane CSC indexes
Date:   Mon, 15 May 2023 18:28:16 +0200
Message-Id: <20230515161726.980272377@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161721.802179972@linuxfoundation.org>
References: <20230515161721.802179972@linuxfoundation.org>
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
@@ -7612,8 +7612,8 @@ enum skl_power_gate {
 
 #define _PLANE_CSC_RY_GY_1(pipe)	_PIPE(pipe, _PLANE_CSC_RY_GY_1_A, \
 					      _PLANE_CSC_RY_GY_1_B)
-#define _PLANE_CSC_RY_GY_2(pipe)	_PIPE(pipe, _PLANE_INPUT_CSC_RY_GY_2_A, \
-					      _PLANE_INPUT_CSC_RY_GY_2_B)
+#define _PLANE_CSC_RY_GY_2(pipe)	_PIPE(pipe, _PLANE_CSC_RY_GY_2_A, \
+					      _PLANE_CSC_RY_GY_2_B)
 #define PLANE_CSC_COEFF(pipe, plane, index)	_MMIO_PLANE(plane, \
 							    _PLANE_CSC_RY_GY_1(pipe) +  (index) * 4, \
 							    _PLANE_CSC_RY_GY_2(pipe) + (index) * 4)


