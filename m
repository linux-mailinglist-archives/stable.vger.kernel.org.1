Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F71B70388C
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244230AbjEORdG (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244220AbjEORcn (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:32:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90B3120AF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:30:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6611462D26
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:30:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565A6C4339B;
        Mon, 15 May 2023 17:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171815;
        bh=tnC4lwuwPgeTeCfB1Zpo5LYpopv1f3DDYtn2ZhIv9BQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ju49CPokQYOro5DkPWz79wnWCA+RybXOSrS863WmUewZQGu+DVyPTUct0n3K+pXML
         FX/b5iWNPXWv11ObIwD3lQDqK3DB5WeTtzVuXgfFlUg8C71FuEhDyEsNyRR+nxNhoU
         DhwoAiCTQH+CmIFBubftInmy89T7MNw5UDZ4yoSA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, James Cowgill <james.cowgill@blaize.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH 5.15 088/134] drm/panel: otm8009a: Set backlight parent to panel device
Date:   Mon, 15 May 2023 18:29:25 +0200
Message-Id: <20230515161706.091600184@linuxfoundation.org>
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

From: James Cowgill <james.cowgill@blaize.com>

commit ab4f869fba6119997f7630d600049762a2b014fa upstream.

This is the logical place to put the backlight device, and it also
fixes a kernel crash if the MIPI host is removed. Previously the
backlight device would be unregistered twice when this happened - once
as a child of the MIPI host through `mipi_dsi_host_unregister`, and
once when the panel device is destroyed.

Fixes: 12a6cbd4f3f1 ("drm/panel: otm8009a: Use new backlight API")
Signed-off-by: James Cowgill <james.cowgill@blaize.com>
Cc: stable@vger.kernel.org
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230412173450.199592-1-james.cowgill@blaize.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/panel/panel-orisetech-otm8009a.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -444,7 +444,7 @@ static int otm8009a_probe(struct mipi_ds
 		       DRM_MODE_CONNECTOR_DSI);
 
 	ctx->bl_dev = devm_backlight_device_register(dev, dev_name(dev),
-						     dsi->host->dev, ctx,
+						     dev, ctx,
 						     &otm8009a_backlight_ops,
 						     NULL);
 	if (IS_ERR(ctx->bl_dev)) {


