Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37800775902
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbjHIK4l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:56:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjHIK4i (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:56:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0975E1FFB
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:56:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 924FC62835
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:56:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF5AC433C8;
        Wed,  9 Aug 2023 10:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578597;
        bh=5i2VyFYv+hz667X3iYDfE8amJrEqdi5Klgawjc0BnFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MlSn8imQTd0/9NReo0vEUJxfIKJ1fhmNwhs7StOk+YKv63TSE2TKVJb4GfiLassBW
         XaLkgT+fJ6Eiw/7d04CU3LL7ByWQ31I5TMF81cSCPRrkiX2MgVQqwzaPn84oksSUiE
         ZD+D3ZfpvQKd+C/H/B9ThoUDP8OFqdWn9NIcz7xs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <Harry.Wentland@amd.com>,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Melissa Wen <mwen@igalia.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 6.1 117/127] drm/amd/display: Ensure that planes are in the same order
Date:   Wed,  9 Aug 2023 12:41:44 +0200
Message-ID: <20230809103640.485807800@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.615294317@linuxfoundation.org>
References: <20230809103636.615294317@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

commit bb46a6a9bab134b9d15043ea8fa9d6c276e938b8 upstream.

The function dc_update_planes_and_stream handles multiple cases where DC
needs to remove and add planes in the commit tail phase. After Linux
started to use this function, some of the IGT kms_plane started to fail;
one good example to illustrate why the new sequence regressed IGT is the
subtest plane-position-hole which has the following diagram as a
template:

 +--------------------+        +-----------------------+
 | +-----+            |        | +-----+               |
 | |     |            |        | | +-----+             |
 | |  +--+            | ==>    | | |   | |             |
 | |__|               |        | +-|---+ |             |
 |                    |        |   +-----+             |
 |                    |        |                       |
 +--------------------+        +-----------------------+
   (a) Final image                (b) Composed image

IGT expects image (a) as the final result of two plane compositions as
described in figure (b). After the migration to the new sequence, the
last plane order is changed, and DC generates the following image:

+---------------------+
| +-----+             |
| |     |             |
| |     |             |
| +-----+             |
|                     |
+---------------------+

Notice that the generated image by DC is different because the small
square that should be composed on top of the primary plane is below the
primary plane. For this reason, the CRC will mismatch with the expected
value. Since the function dc_add_all_planes_for_stream re-append all the
new planes back to the dc_validation_set, this commit ensures that the
original sequence is maintained. After this change, all CI tests in all
ASICs start to pass again.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Suggested-by: Melissa Wen <mwen@igalia.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -351,6 +351,19 @@ static inline bool is_dc_timing_adjust_n
 		return false;
 }
 
+static inline void reverse_planes_order(struct dc_surface_update *array_of_surface_update,
+					int planes_count)
+{
+	int i, j;
+	struct dc_surface_update surface_updates_temp;
+
+	for (i = 0, j = planes_count - 1; i < j; i++, j--) {
+		surface_updates_temp = array_of_surface_update[i];
+		array_of_surface_update[i] = array_of_surface_update[j];
+		array_of_surface_update[j] = surface_updates_temp;
+	}
+}
+
 /**
  * update_planes_and_stream_adapter() - Send planes to be updated in DC
  *
@@ -367,6 +380,8 @@ static inline bool update_planes_and_str
 						    struct dc_stream_update *stream_update,
 						    struct dc_surface_update *array_of_surface_update)
 {
+	reverse_planes_order(array_of_surface_update, planes_count);
+
 	/*
 	 * Previous frame finished and HW is ready for optimization.
 	 */


