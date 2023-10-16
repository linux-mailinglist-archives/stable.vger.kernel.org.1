Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D51E7CAC4A
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJPOwn (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjJPOwm (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:52:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928AFE3
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:52:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B8AC433C7;
        Mon, 16 Oct 2023 14:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697467960;
        bh=tM0WFkSsq7d423ew8ogbcrltzza2IkZ3AD7LJ0U+FLg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MRixn0p3ROqVrH4UxVVPRyBj9vjupAZTmLBpczb008IC0fqG6mAz5un1+wcCsqJqT
         ijAoN8H7DipeXZq4RQGkLyvtw/6otAL9DDCRFX7ojHOFX2zC9Qapz8mbsSa2AajuVK
         aMcNXgZj0blFlTZL9P370tFIHCPWNnFpeg4Ms8h4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Simon Ser <contact@emersion.fr>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>, Lyude Paul <lyude@redhat.com>,
        Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>
Subject: [PATCH 6.5 124/191] drm/atomic-helper: relax unregistered connector check
Date:   Mon, 16 Oct 2023 10:41:49 +0200
Message-ID: <20231016084018.274522619@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Simon Ser <contact@emersion.fr>

commit 2b7947bd32e243c52870d54141d3b4ea6775e63d upstream.

The driver might pull connectors which weren't submitted by
user-space into the atomic state. For instance,
intel_dp_mst_atomic_master_trans_check() pulls in connectors
sharing the same DP-MST stream. However, if the connector is
unregistered, this later fails with:

    [  559.425658] i915 0000:00:02.0: [drm:drm_atomic_helper_check_modeset] [CONNECTOR:378:DP-7] is not registered

Skip the unregistered connector check to allow user-space to turn
off connectors one-by-one.

See this wlroots issue:
https://gitlab.freedesktop.org/wlroots/wlroots/-/issues/3407

Previous discussion:
https://lore.kernel.org/intel-gfx/Y6GX7z17WmDSKwta@ideak-desk.fi.intel.com/

Signed-off-by: Simon Ser <contact@emersion.fr>
Cc: stable@vger.kernel.org
Reviewed-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231005131623.114379-1-contact@emersion.fr
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_atomic_helper.c |   17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

--- a/drivers/gpu/drm/drm_atomic_helper.c
+++ b/drivers/gpu/drm/drm_atomic_helper.c
@@ -290,7 +290,8 @@ static int
 update_connector_routing(struct drm_atomic_state *state,
 			 struct drm_connector *connector,
 			 struct drm_connector_state *old_connector_state,
-			 struct drm_connector_state *new_connector_state)
+			 struct drm_connector_state *new_connector_state,
+			 bool added_by_user)
 {
 	const struct drm_connector_helper_funcs *funcs;
 	struct drm_encoder *new_encoder;
@@ -339,9 +340,13 @@ update_connector_routing(struct drm_atom
 	 * there's a chance the connector may have been destroyed during the
 	 * process, but it's better to ignore that then cause
 	 * drm_atomic_helper_resume() to fail.
+	 *
+	 * Last, we want to ignore connector registration when the connector
+	 * was not pulled in the atomic state by user-space (ie, was pulled
+	 * in by the driver, e.g. when updating a DP-MST stream).
 	 */
 	if (!state->duplicated && drm_connector_is_unregistered(connector) &&
-	    crtc_state->active) {
+	    added_by_user && crtc_state->active) {
 		drm_dbg_atomic(connector->dev,
 			       "[CONNECTOR:%d:%s] is not registered\n",
 			       connector->base.id, connector->name);
@@ -620,7 +625,10 @@ drm_atomic_helper_check_modeset(struct d
 	struct drm_connector *connector;
 	struct drm_connector_state *old_connector_state, *new_connector_state;
 	int i, ret;
-	unsigned int connectors_mask = 0;
+	unsigned int connectors_mask = 0, user_connectors_mask = 0;
+
+	for_each_oldnew_connector_in_state(state, connector, old_connector_state, new_connector_state, i)
+		user_connectors_mask |= BIT(i);
 
 	for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
 		bool has_connectors =
@@ -685,7 +693,8 @@ drm_atomic_helper_check_modeset(struct d
 		 */
 		ret = update_connector_routing(state, connector,
 					       old_connector_state,
-					       new_connector_state);
+					       new_connector_state,
+					       BIT(i) & user_connectors_mask);
 		if (ret)
 			return ret;
 		if (old_connector_state->crtc) {


