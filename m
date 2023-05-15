Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F747038B0
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243930AbjEOReK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243997AbjEORdy (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:33:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB4C49F5
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:31:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A90C962D5A
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5F4C433D2;
        Mon, 15 May 2023 17:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171900;
        bh=OS/0TrytQFg/zb1q7nr/0ZmHojUHwONBC8iw3eH7D8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bW/7DNRDLSHXofSRfs+6WkcgcDqTJF59/vAYh1Y/k0taHulQciWN66thWfsHGVci9
         BihNOzsp7k/02cttTmzNAvnr6Ms+rLOwYVZbSsXRp6/0WYQXcG0iAvaOFas5RMKKUY
         /0rKmf4xe9DQKvi359AsNCNKH1JteucVQjyL5Yvk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Robert Foss <rfoss@kernel.org>
Subject: [PATCH 5.15 084/134] drm/bridge: lt8912b: Fix DSI Video Mode
Date:   Mon, 15 May 2023 18:29:21 +0200
Message-Id: <20230515161705.970534179@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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
@@ -494,7 +494,6 @@ static int lt8912_attach_dsi(struct lt89
 	dsi->format = MIPI_DSI_FMT_RGB888;
 
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO |
-			  MIPI_DSI_MODE_VIDEO_BURST |
 			  MIPI_DSI_MODE_LPM |
 			  MIPI_DSI_MODE_NO_EOT_PACKET;
 


