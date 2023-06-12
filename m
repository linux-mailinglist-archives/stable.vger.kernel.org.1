Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1ADF72C035
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbjFLKuk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjFLKuK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:50:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0248D7ED7
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:35:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AE718623E1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F32C433EF;
        Mon, 12 Jun 2023 10:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566101;
        bh=gu+woyY600EgFNCOX5M7aN+WcWbBcb/QrxPZoXv4bwo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lZOk2aoBELqJ0NGgxp0bEkWhuySd56FIFKYgJ9JxhlPdOPjuonC5mOPlxSS+S41lR
         DORQ0sGqk9xP245vIdKk22Dn12sp0LjB26bJTZ99Ms+Slgdzsle+IvMdAaoIEOH26W
         515SveZ5hJP7AQz9WcffeTnqNurx6mwdBVilW2g8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, fuyufan <fuyufan@huawei.com>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Maxime Ripard <maxime@cerno.tech>,
        Fedor Pchelkin <pchelkin@ispras.ru>
Subject: [PATCH 5.10 65/68] drm/atomic: Dont pollute crtc_state->mode_blob with error pointers
Date:   Mon, 12 Jun 2023 12:26:57 +0200
Message-ID: <20230612101701.146235464@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
References: <20230612101658.437327280@linuxfoundation.org>
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

commit 439cf34c8e0a8a33d8c15a31be1b7423426bc765 upstream.

Make sure we don't assign an error pointer to crtc_state->mode_blob
as that will break all kinds of places that assume either NULL or a
valid pointer (eg. drm_property_blob_put()).

Cc: stable@vger.kernel.org
Reported-by: fuyufan <fuyufan@huawei.com>
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20220209091928.14766-1-ville.syrjala@linux.intel.com
Acked-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_atomic_uapi.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- a/drivers/gpu/drm/drm_atomic_uapi.c
+++ b/drivers/gpu/drm/drm_atomic_uapi.c
@@ -75,15 +75,17 @@ int drm_atomic_set_mode_for_crtc(struct
 	state->mode_blob = NULL;
 
 	if (mode) {
+		struct drm_property_blob *blob;
+
 		drm_mode_convert_to_umode(&umode, mode);
-		state->mode_blob =
-			drm_property_create_blob(state->crtc->dev,
-		                                 sizeof(umode),
-		                                 &umode);
-		if (IS_ERR(state->mode_blob))
-			return PTR_ERR(state->mode_blob);
+		blob = drm_property_create_blob(crtc->dev,
+						sizeof(umode), &umode);
+		if (IS_ERR(blob))
+			return PTR_ERR(blob);
 
 		drm_mode_copy(&state->mode, mode);
+
+		state->mode_blob = blob;
 		state->enable = true;
 		DRM_DEBUG_ATOMIC("Set [MODE:%s] for [CRTC:%d:%s] state %p\n",
 				 mode->name, crtc->base.id, crtc->name, state);


