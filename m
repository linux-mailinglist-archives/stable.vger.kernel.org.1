Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01316771B34
	for <lists+stable@lfdr.de>; Mon,  7 Aug 2023 09:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbjHGHKk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 7 Aug 2023 03:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjHGHKj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 7 Aug 2023 03:10:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4918095
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 00:10:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0BD0615B0
        for <stable@vger.kernel.org>; Mon,  7 Aug 2023 07:10:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBDFCC433C8;
        Mon,  7 Aug 2023 07:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691392237;
        bh=z5m3Ch0PdHby6lU9fGIEvXdAFIOVHtDhniXdXa8XYd0=;
        h=Subject:To:Cc:From:Date:From;
        b=x1zwS/+irUUacP5CSR//nlaO0Yo6Ab70LNf4f1kTQSkOqJzCbP9cm6bu3MJOQKkEw
         g4Ri7VvuhWnoSNsI5CWgX42ZX3w8hrioX6EO/SZuXvaXWEIusfCjpVWifBtmp+Mg7s
         TzXjhd1iteVXV0Jtkc9WawgJUbwp73F6QBG25WTk=
Subject: FAILED: patch "[PATCH] drm/i915/gt: Ensure memory quiesced before invalidation" failed to apply to 5.15-stable tree
To:     jonathan.cavitt@intel.com, andi.shyti@linux.intel.com,
        andrzej.hajda@intel.com, nirmoy.das@intel.com,
        stable@vger.kernel.org, tvrtko.ursulin@intel.com
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Mon, 07 Aug 2023 09:10:34 +0200
Message-ID: <2023080734-coherent-follow-2e84@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 78a6ccd65fa3a7cc697810db079cc4b84dff03d5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023080734-coherent-follow-2e84@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

78a6ccd65fa3 ("drm/i915/gt: Ensure memory quiesced before invalidation")
803efd297e31 ("drm/i915/xehp: compute engine pipe_control")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 78a6ccd65fa3a7cc697810db079cc4b84dff03d5 Mon Sep 17 00:00:00 2001
From: Jonathan Cavitt <jonathan.cavitt@intel.com>
Date: Tue, 25 Jul 2023 02:19:46 +0200
Subject: [PATCH] drm/i915/gt: Ensure memory quiesced before invalidation

All memory traffic must be quiesced before requesting
an aux invalidation on platforms that use Aux CCS.

Fixes: 972282c4cf24 ("drm/i915/gen12: Add aux table invalidate for all engines")
Requires: a2a4aa0eef3b ("drm/i915: Add the gen12_needs_ccs_aux_inv helper")
Signed-off-by: Jonathan Cavitt <jonathan.cavitt@intel.com>
Signed-off-by: Andi Shyti <andi.shyti@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
Reviewed-by: Nirmoy Das <nirmoy.das@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230725001950.1014671-4-andi.shyti@linux.intel.com
(cherry picked from commit ad8ebf12217e451cd19804b1c3e97ad56491c74a)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index 460c9225a50f..6210b38a2d38 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -214,7 +214,11 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 {
 	struct intel_engine_cs *engine = rq->engine;
 
-	if (mode & EMIT_FLUSH) {
+	/*
+	 * On Aux CCS platforms the invalidation of the Aux
+	 * table requires quiescing memory traffic beforehand
+	 */
+	if (mode & EMIT_FLUSH || gen12_needs_ccs_aux_inv(engine)) {
 		u32 flags = 0;
 		int err;
 		u32 *cs;

