Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7747BDD53
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376757AbjJINJ3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376750AbjJINJ2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:09:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D973694
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:09:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFFFC433C9;
        Mon,  9 Oct 2023 13:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856966;
        bh=4knjKtyhb8Q3scrMoKwVSkhzn2HGSkNztfck9y+mACQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L8D9C+Xh5LY2N5kPbyc3W1L+v7rlWm3xa6/ecpEcuKNL34Ky/L+DU22Wfr+neQX7Z
         sj2MYzi6NOOp9Rki0FXwudVmnIJQIf22WcI5ZsVsjuIujTr2D2lEwuVbiskOQIBitw
         H3QBB2KHJfwVerNEBLzIYqcFQERhFb7LSW3/Wdbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Tejas Upadhyay <tejas.upadhyay@intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>,
        =?UTF-8?q?Tapani=20P=C3=A4lli?= <tapani.palli@intel.com>,
        Mark Janes <mark.janes@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>
Subject: [PATCH 6.5 051/163] drm/i915: Dont set PIPE_CONTROL_FLUSH_L3 for aux inval
Date:   Mon,  9 Oct 2023 15:00:15 +0200
Message-ID: <20231009130125.445271267@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nirmoy Das <nirmoy.das@intel.com>

commit 128c20eda73bd3e78505c574fb17adb46195c98b upstream.

PIPE_CONTROL_FLUSH_L3 is not needed for aux invalidation
so don't set that.

Fixes: 78a6ccd65fa3 ("drm/i915/gt: Ensure memory quiesced before invalidation")
Cc: Jonathan Cavitt <jonathan.cavitt@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: <stable@vger.kernel.org> # v5.8+
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Cc: Matt Roper <matthew.d.roper@intel.com>
Cc: Tejas Upadhyay <tejas.upadhyay@intel.com>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: Prathap Kumar Valsan <prathap.kumar.valsan@intel.com>
Cc: Tapani Pälli <tapani.palli@intel.com>
Cc: Mark Janes <mark.janes@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Nirmoy Das <nirmoy.das@intel.com>
Acked-by: Matt Roper <matthew.d.roper@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
Tested-by: Tapani Pälli <tapani.palli@intel.com>
Reviewed-by: Andrzej Hajda <andrzej.hajda@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230926142401.25687-1-nirmoy.das@intel.com
(cherry picked from commit 03d681412b38558aefe4fb0f46e36efa94bb21ef)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -271,8 +271,17 @@ int gen12_emit_flush_rcs(struct i915_req
 		if (GRAPHICS_VER_FULL(rq->i915) >= IP_VER(12, 70))
 			bit_group_0 |= PIPE_CONTROL_CCS_FLUSH;
 
+		/*
+		 * L3 fabric flush is needed for AUX CCS invalidation
+		 * which happens as part of pipe-control so we can
+		 * ignore PIPE_CONTROL_FLUSH_L3. Also PIPE_CONTROL_FLUSH_L3
+		 * deals with Protected Memory which is not needed for
+		 * AUX CCS invalidation and lead to unwanted side effects.
+		 */
+		if (mode & EMIT_FLUSH)
+			bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
+
 		bit_group_1 |= PIPE_CONTROL_TILE_CACHE_FLUSH;
-		bit_group_1 |= PIPE_CONTROL_FLUSH_L3;
 		bit_group_1 |= PIPE_CONTROL_RENDER_TARGET_CACHE_FLUSH;
 		bit_group_1 |= PIPE_CONTROL_DEPTH_CACHE_FLUSH;
 		/* Wa_1409600907:tgl,adl-p */


