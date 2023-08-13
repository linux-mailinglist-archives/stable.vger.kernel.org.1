Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC61077AC86
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjHMVeN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:34:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjHMVeF (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:34:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD6210DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:34:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7307662C75
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB52C433C8;
        Sun, 13 Aug 2023 21:34:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962445;
        bh=91a//ZPt+Ufn40txO1MRK3Xk6hh7et4Z3OCnk954LOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q4Yd4imoUL2JX1ldE8dL0dOA4a5/WxrFPLUCorRRUefQeIJl1KcXXao9CoDXpF60i
         aYoZNHyeDCT2nnOTLt3Dmrbu0jKze5QnD+6G/2N4v+ODuKfP/VZbH/8TfUCnj8x1rB
         Nvyhuqjz7ua6l1k9w9DXPZf2eJnOGPeobTlUr7To=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Peichen Huang <peichen.huang@amd.com>,
        Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.1 032/149] drm/amd/display: limit DPIA link rate to HBR3
Date:   Sun, 13 Aug 2023 23:17:57 +0200
Message-ID: <20230813211719.767586367@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
User-Agent: quilt/0.67
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

From: Peichen Huang <peichen.huang@amd.com>

commit 0e69ef6ea82e8eece7d2b2b45a0da9670eaaefff upstream.

[Why]
DPIA doesn't support UHBR, driver should not enable UHBR
for dp tunneling

[How]
limit DPIA link rate to HBR3

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Peichen Huang <peichen.huang@amd.com>
Reviewed-by: Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -1141,6 +1141,11 @@ static bool detect_link_and_local_sink(s
 					(link->dpcd_caps.dongle_type !=
 							DISPLAY_DONGLE_DP_HDMI_CONVERTER))
 				converter_disable_audio = true;
+
+			/* limited link rate to HBR3 for DPIA until we implement USB4 V2 */
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+					link->reported_link_cap.link_rate > LINK_RATE_HIGH3)
+				link->reported_link_cap.link_rate = LINK_RATE_HIGH3;
 			break;
 		}
 


