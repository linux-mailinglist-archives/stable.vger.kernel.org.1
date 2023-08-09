Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2A0775885
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 12:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbjHIKxe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 06:53:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232657AbjHIKxW (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 06:53:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BE630E7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 03:51:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 53CE063136
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 10:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E1BC433C7;
        Wed,  9 Aug 2023 10:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691578276;
        bh=mQ6prVLlLK6mIl/u46607q4NZkfys8D0FvBUrmR/n4k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGcp8gF07xOIU1k3oPxMOmZy8tRUoFmgXYdOo6lM/cKx3btOr5fizrgNForq7+Y6S
         1VD92kSqXbHE/ZpRpSUcYl6HmE5rpXBfanCc1bYaNNRQ0Pgy4JfE+I6NywmrSsJm3b
         55UwLsK6Al4UoAyUX06Lda3nwrFhYK2Uo2l6idYc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Jonathan Cavitt <jonathan.cavitt@intel.com>,
        Andi Shyti <andi.shyti@linux.intel.com>,
        Nirmoy Das <nirmoy.das@intel.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 160/165] drm/i915/gt: Ensure memory quiesced before invalidation
Date:   Wed,  9 Aug 2023 12:41:31 +0200
Message-ID: <20230809103648.010951136@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103642.720851262@linuxfoundation.org>
References: <20230809103642.720851262@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Jonathan Cavitt <jonathan.cavitt@intel.com>

[ Upstream commit 78a6ccd65fa3a7cc697810db079cc4b84dff03d5 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/gen8_engine_cs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
index c5b926e3f20d7..6e914c3f5019a 100644
--- a/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
+++ b/drivers/gpu/drm/i915/gt/gen8_engine_cs.c
@@ -193,7 +193,11 @@ int gen12_emit_flush_rcs(struct i915_request *rq, u32 mode)
 {
 	struct intel_engine_cs *engine = rq->engine;
 
-	if (mode & EMIT_FLUSH) {
+	/*
+	 * On Aux CCS platforms the invalidation of the Aux
+	 * table requires quiescing memory traffic beforehand
+	 */
+	if (mode & EMIT_FLUSH || gen12_needs_ccs_aux_inv(engine)) {
 		u32 flags = 0;
 		u32 *cs;
 
-- 
2.40.1



