Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B603270352E
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243210AbjEOQ43 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbjEOQ42 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:56:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877BD6E9A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:56:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1BE9C62A01
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:56:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16774C433EF;
        Mon, 15 May 2023 16:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684169778;
        bh=C1EHBejhltQUJsb+n597kPRcWUmcmrDTBbB4j7w2Thc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tY0RhuhfUsAXXlmq7EHFF0drLJkwDW8aUeasLiRGgPNATnut+IfIXeJTmitsUp/Ni
         o8zrf4tp7qLV3LF2zuCY64lppvxKhw42FVCrHSxMtaLvLqUYCdMECDStyMaZuv7pae
         qzN0yR1evFBZ8xyJ4CEIY8PCo+EG8dyS9DShT77g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Robert Foss <rfoss@kernel.org>
Subject: [PATCH 6.3 168/246] drm/bridge: lt8912b: Fix DSI Video Mode
Date:   Mon, 15 May 2023 18:26:20 +0200
Message-Id: <20230515161727.673967895@linuxfoundation.org>
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

commit f435b7ef3b360d689df2ffa8326352cd07940d92 upstream.

LT8912 DSI port supports only Non-Burst mode video operation with Sync
Events and continuous clock on clock lane, correct dsi mode flags
according to that removing MIPI_DSI_MODE_VIDEO_BURST flag.

Cc: <stable@vger.kernel.org>
Fixes: 30e2ae943c26 ("drm/bridge: Introduce LT8912B DSI to HDMI bridge")
Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Reviewed-by: Robert Foss <rfoss@kernel.org>
Signed-off-by: Robert Foss <rfoss@kernel.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230330093131.424828-1-francesco@dolcini.it
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/bridge/lontium-lt8912b.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -504,7 +504,6 @@ static int lt8912_attach_dsi(struct lt89
 	dsi->format = MIPI_DSI_FMT_RGB888;
 
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
-			  MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_MODE_LPM |
 			  MIPI_DSI_MODE_NO_EOT_PACKET;
 


