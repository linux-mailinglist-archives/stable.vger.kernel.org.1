Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA4F9713DED
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230204AbjE1TaQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjE1TaP (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:30:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313ABA7
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:30:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA21B61D4A
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:30:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D28F0C433D2;
        Sun, 28 May 2023 19:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302213;
        bh=1Ig8BMvkRJpcP8F17hoOAFO/uCOYzFEkcIE5+D5NYEg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WJWoFYhsCQyfJxCfzDnM1EToFiRMPX6TbCaIlvEcu2jkXGFKEV4rAOGKV8qRZBvtV
         6HwRwfkNUAdrUmbjGLI01jkYSXuc0kTWHEjwr1IkJl0kKuvWx+FLHyI22AvYbTfnLz
         ipcn9iYmcVZbxYQAxEcBUqFNpDAMlDmOL/uP0/iU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Phil Oester <kernel@linuxace.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH 6.3 045/127] drm/mgag200: Fix gamma lut not initialized.
Date:   Sun, 28 May 2023 20:10:21 +0100
Message-Id: <20230528190837.818789183@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190836.161231414@linuxfoundation.org>
References: <20230528190836.161231414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jocelyn Falempe <jfalempe@redhat.com>

commit ad81e23426a651eb89a4b306e1c4169e6308c124 upstream.

When mgag200 switched from simple KMS to regular atomic helpers,
the initialization of the gamma settings was lost.
This leads to a black screen, if the bios/uefi doesn't use the same
pixel color depth.

v2: rebase on top of drm-misc-fixes, and add Cc stable tag.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=2171155
Fixes: 1baf9127c482 ("drm/mgag200: Replace simple-KMS with regular atomic helpers")
Cc: <stable@vger.kernel.org>
Tested-by: Phil Oester <kernel@linuxace.com>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230510131034.284078-1-jfalempe@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -640,6 +640,11 @@ void mgag200_crtc_helper_atomic_enable(s
 	if (funcs->pixpllc_atomic_update)
 		funcs->pixpllc_atomic_update(crtc, old_state);
 
+	if (crtc_state->gamma_lut)
+		mgag200_crtc_set_gamma(mdev, format, crtc_state->gamma_lut->data);
+	else
+		mgag200_crtc_set_gamma_linear(mdev, format);
+
 	mgag200_enable_display(mdev);
 
 	if (funcs->enable_vidrst)


