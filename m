Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6209761163
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233750AbjGYKum (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233751AbjGYKuX (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:50:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035C31FD3
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:50:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE1656165D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:50:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD047C433C8;
        Tue, 25 Jul 2023 10:50:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282205;
        bh=aXsBD8vEtU4R9P40FIRXk5xuGyk9gGsfxT2EMAqxmaA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Cl5N/BgXIeh/vk9El1sCa3LDvQ4pqALkwFUH3NT7jMZFG21oR3RU5ihbcGxFHh+Yr
         sYQj7yTq7T3oyvrXF1XbQ9JYCSzIhXwHHiNmfiF4LxNG+dqs11Y15avvv9HfHUDMvS
         D0zqJNX/cwdiI4ML0uP9sRs+m4Yh9u6QtLQDkuGk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kenneth Feng <kenneth.feng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.4 046/227] drm/amdgpu/pm: make mclk consistent for smu 13.0.7
Date:   Tue, 25 Jul 2023 12:43:33 +0200
Message-ID: <20230725104516.709048419@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alex Deucher <alexander.deucher@amd.com>

commit 068c8bb10f37bb84824625dbbda053a3a3e0d6e1 upstream.

Use current uclk to be consistent with other dGPUs.

Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -940,7 +940,7 @@ static int smu_v13_0_7_read_sensor(struc
 		break;
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
 		ret = smu_v13_0_7_get_smu_metrics_data(smu,
-						       METRICS_AVERAGE_UCLK,
+						       METRICS_CURR_UCLK,
 						       (uint32_t *)data);
 		*(uint32_t *)data *= 100;
 		*size = 4;


