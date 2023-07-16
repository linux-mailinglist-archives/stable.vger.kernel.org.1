Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA5D7556BA
	for <lists+stable@lfdr.de>; Sun, 16 Jul 2023 22:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbjGPUx3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 16 Jul 2023 16:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjGPUx3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 16 Jul 2023 16:53:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40665E9
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 13:53:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D1BAD60EAE
        for <stable@vger.kernel.org>; Sun, 16 Jul 2023 20:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC335C433C7;
        Sun, 16 Jul 2023 20:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689540807;
        bh=gI2ZjQvq+hZZPXqFl8t9KQZn5Va1jyfYc9qJjKh1Sws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ALjb7Zo1lCwT2QPm4BEK6jzY5QwnZ585uKZLx3ubZwJ1Xt5e7EQ2oBN+xi/IIMUad
         tZSXd91+lcJNo2uAs/uVlxT5xie5H4vtiEgaoitlubO8xTSr/2glFuxre9PQT7zNAT
         rl8rVcF4R60FOXDrtWmbDx2pKt+fNJbzTLEOAoyY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ashutosh Dixit <ashutosh.dixit@intel.com>,
        Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
        Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 467/591] drm/i915/guc/slpc: Apply min softlimit correctly
Date:   Sun, 16 Jul 2023 21:50:06 +0200
Message-ID: <20230716194935.986683261@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230716194923.861634455@linuxfoundation.org>
References: <20230716194923.861634455@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vinay Belgaumkar <vinay.belgaumkar@intel.com>

[ Upstream commit 3e49de73fb89272dea01ba420c7ccbcf6b96aed7 ]

The scenario being fixed here is depicted in the following sequence-

modprobe i915
echo 1 > /sys/class/drm/card0/gt/gt0/slpc_ignore_eff_freq
echo 300 > /sys/class/drm/card0/gt_min_freq_mhz (RPn)
cat /sys/class/drm/card0/gt_cur_freq_mhz --> cur == RPn as expected
echo 1 > /sys/kernel/debug/dri/0/gt0/reset --> reset
cat /sys/class/drm/card0/gt_min_freq_mhz --> cached freq is RPn
cat /sys/class/drm/card0/gt_cur_freq_mhz --> it's not RPn, but RPe!!

When SLPC reinitializes, it sets SLPC min freq to efficient frequency.
Even if we disable efficient freq post that, we should restore the cached
min freq (via H2G) for it to take effect.

v2: Clarify commit message (Ashutosh)

Fixes: 95ccf312a1e4 ("drm/i915/guc/slpc: Allow SLPC to use efficient frequency")
Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Signed-off-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Signed-off-by: Daniele Ceraolo Spurio <daniele.ceraolospurio@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230621014257.1769564-1-vinay.belgaumkar@intel.com
(cherry picked from commit da86b2b13f1d1ca26745b951ac94421f3137539a)
Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c
index fdd895f73f9f1..72ba1c758ca79 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_slpc.c
@@ -580,7 +580,7 @@ static int slpc_set_softlimits(struct intel_guc_slpc *slpc)
 		if (unlikely(ret))
 			return ret;
 		slpc_to_gt(slpc)->defaults.min_freq = slpc->min_freq_softlimit;
-	} else if (slpc->min_freq_softlimit != slpc->min_freq) {
+	} else {
 		return intel_guc_slpc_set_min_freq(slpc,
 						   slpc->min_freq_softlimit);
 	}
-- 
2.39.2



