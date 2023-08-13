Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9A677AD19
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjHMVsF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjHMVrZ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:47:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBBC92D5B
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:47:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 613A561C1D
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:47:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70E26C433C8;
        Sun, 13 Aug 2023 21:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963243;
        bh=Ha50qv6q6E5q6ViIdFSLAQz/O7uNZBMWrQY5OAsjhUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mPjMCO4JrR3+SSczk2/h/So5G6ZB3G1rdkDiMuNNSc7Ha13aK8t43Cm8oI6oFQUkN
         qKdo3hLuyFuWF8v3AHZuquIR/PqgSPDmITFLropBU18KDC7UaxnbCKG9ueRk2njutd
         HOxVJpdcVwcZFaSReJ2sluOhGUBsmGG++21c5QlA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Olaf Skibbe <news@kravcenko.com>,
        Lyude Paul <lyude@redhat.com>,
        Karol Herbst <kherbst@redhat.com>
Subject: [PATCH 5.4 16/39] drm/nouveau/disp: Revert a NULL check inside nouveau_connector_get_modes
Date:   Sun, 13 Aug 2023 23:20:07 +0200
Message-ID: <20230813211705.394206421@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
References: <20230813211704.796906808@linuxfoundation.org>
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

From: Karol Herbst <kherbst@redhat.com>

commit d5712cd22b9cf109fded1b7f178f4c1888c8b84b upstream.

The original commit adding that check tried to protect the kenrel against
a potential invalid NULL pointer access.

However we call nouveau_connector_detect_depth once without a native_mode
set on purpose for non LVDS connectors and this broke DP support in a few
cases.

Cc: Olaf Skibbe <news@kravcenko.com>
Cc: Lyude Paul <lyude@redhat.com>
Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/238
Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/245
Fixes: 20a2ce87fbaf8 ("drm/nouveau/dp: check for NULL nv_connector->native_mode")
Signed-off-by: Karol Herbst <kherbst@redhat.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230805101813.2603989-1-kherbst@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -955,7 +955,7 @@ nouveau_connector_get_modes(struct drm_c
 	/* Determine display colour depth for everything except LVDS now,
 	 * DP requires this before mode_valid() is called.
 	 */
-	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS && nv_connector->native_mode)
+	if (connector->connector_type != DRM_MODE_CONNECTOR_LVDS)
 		nouveau_connector_detect_depth(connector);
 
 	/* Find the native mode if this is a digital panel, if we didn't


