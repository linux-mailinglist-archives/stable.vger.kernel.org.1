Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36C4C7CAB5E
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjJPOZV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:25:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjJPOZU (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:25:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD75183
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:25:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3EE3C433C8;
        Mon, 16 Oct 2023 14:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697466318;
        bh=otljVOzm/L4zXfNOVytjG9YmYl5uMN2gc1yqwJP5WSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x6hw93f/pYTh95fuIn7HV4zBDS3ZOTeaNiDepEfBZ4nDaNKJ5LIj4ECsTJZKy+fPP
         /mfaJt3BjCnC6fBunazxrRaA2AfwFYhoq79tk6JcXN/QZ+Sm8XsqxsWuzOjo+NMWum
         e/eNuq46qhFq70skhINdjXJXF43V9PvB0nid5XN4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Mathias Krause <minipli@grsecurity.net>,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 005/191] drm/i915: Register engines early to avoid type confusion
Date:   Mon, 16 Oct 2023 10:39:50 +0200
Message-ID: <20231016084015.527257951@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mathias Krause <minipli@grsecurity.net>

[ Upstream commit 6007265ad70a87aa9b4eea79b5e5828da452cfd8 ]

Commit 1ec23ed7126e ("drm/i915: Use uabi engines for the default engine
map") switched from using for_each_engine() to for_each_uabi_engine() to
iterate over the user engines. While this seems to be a sensible change,
it's only safe to do when the engines are actually chained using the
rb-tree structure which is not the case during early driver
initialization where it can be either a lock-less list or regular
double-linked list.

In fact, the modesetting initialization code may end up calling
default_engines() through the fb helper code while the engines list
is still llist_node-based:

  i915_driver_probe() ->
    intel_display_driver_probe() ->
      intel_fbdev_init() ->
        drm_fb_helper_init() ->
          drm_client_init() ->
            drm_client_open() ->
              drm_file_alloc() ->
                i915_driver_open() ->
                  i915_gem_open() ->
                    i915_gem_context_open() ->
                      i915_gem_create_context() ->
                        default_engines()

Using for_each_uabi_engine() in default_engines() is therefore wrong, as
it would try to interpret the llist as rb-tree, making it find no engine
at all, as the rb_left and rb_right members will still be NULL, as they
haven't been initialized yet.

To fix this type confusion register the engines earlier and at the same
time reduce the amount of code that has to deal with the intermediate
llist state.

Reported-by: sanity checks in grsecurity
Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Fixes: 1ec23ed7126e ("drm/i915: Use uabi engines for the default engine map")
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230928182019.10256-2-minipli@grsecurity.net
[tursulin: fixed commit tag typo]
(cherry picked from commit 2b562f032fc2594fb3fac22b7a2eb3c1969a7ba3)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/i915_gem.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_gem.c b/drivers/gpu/drm/i915/i915_gem.c
index 1f65bb33dd212..a8551ce322de2 100644
--- a/drivers/gpu/drm/i915/i915_gem.c
+++ b/drivers/gpu/drm/i915/i915_gem.c
@@ -1199,6 +1199,13 @@ int i915_gem_init(struct drm_i915_private *dev_priv)
 			goto err_unlock;
 	}
 
+	/*
+	 * Register engines early to ensure the engine list is in its final
+	 * rb-tree form, lowering the amount of code that has to deal with
+	 * the intermediate llist state.
+	 */
+	intel_engines_driver_register(dev_priv);
+
 	return 0;
 
 	/*
@@ -1246,8 +1253,6 @@ int i915_gem_init(struct drm_i915_private *dev_priv)
 void i915_gem_driver_register(struct drm_i915_private *i915)
 {
 	i915_gem_driver_register__shrinker(i915);
-
-	intel_engines_driver_register(i915);
 }
 
 void i915_gem_driver_unregister(struct drm_i915_private *i915)
-- 
2.40.1



