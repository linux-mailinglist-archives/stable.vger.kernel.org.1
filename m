Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E217B8A9F
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244481AbjJDShF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244536AbjJDShD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:37:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791FCF0
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:36:56 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906AEC433C7;
        Wed,  4 Oct 2023 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444616;
        bh=uznB3vNT3MYlhUeNlGRBWpY8cmpFZ/cDVamsEhsg2TQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UK3cTkmYhvSSuPoan8/FzF7ekHf6oNLvKPCJCHBN0kq/sxkAR/GmuUxrDTHPer92h
         mf5Qvn5f2NOsxOK+8vmnGXh+nLEZiQW0aMIvrN4NHPGYezeaOJ5rYKC8sBJFpwbtc0
         y7zUP7cyOLHEqXZPkn0iZ/C9X0LbjAU9iMuUuXDg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Neil Armstrong <narmstrong@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH 6.5 314/321] drm/meson: fix memory leak on ->hpd_notify callback
Date:   Wed,  4 Oct 2023 19:57:39 +0200
Message-ID: <20231004175243.827229020@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jani Nikula <jani.nikula@intel.com>

commit 099f0af9d98231bb74956ce92508e87cbcb896be upstream.

The EDID returned by drm_bridge_get_edid() needs to be freed.

Fixes: 0af5e0b41110 ("drm/meson: encoder_hdmi: switch to bridge DRM_BRIDGE_ATTACH_NO_CONNECTOR")
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: stable@vger.kernel.org # v5.17+
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Link: https://patchwork.freedesktop.org/patch/msgid/20230914131015.2472029-1-jani.nikula@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/meson/meson_encoder_hdmi.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -332,6 +332,8 @@ static void meson_encoder_hdmi_hpd_notif
 			return;
 
 		cec_notifier_set_phys_addr_from_edid(encoder_hdmi->cec_notifier, edid);
+
+		kfree(edid);
 	} else
 		cec_notifier_phys_addr_invalidate(encoder_hdmi->cec_notifier);
 }


