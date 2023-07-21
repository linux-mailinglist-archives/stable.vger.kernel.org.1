Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2514475CD5D
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjGUQKl (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGUQKi (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:10:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098A72D7C
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E25561D2D
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C8B0C433C7;
        Fri, 21 Jul 2023 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689955827;
        bh=/SP5wbYfVTjKpscCAyIdQf7jqut2FT8nOMNUMit9Nvw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oG+UDPTkIjjqclfuh8SbbkPYAjDK0NPl/nT3CeqdHrNxk836rwm7thSFWJ+3dwMAa
         PScnJFNRm2+XomBr3OiQ/92VFWFqc7btwZsGETqiFatEn3Py9kmQDVInvDA/FMhVk6
         4gu1/x5AloyeTYQeQsRTQH6OIw2nEk3Z5jnRGbfk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Sridhar Samudrala <sridhar.samudrala@intel.com>,
        Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
        Bharathi Sreenivas <bharathi.sreenivas@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 019/292] ice: Fix max_rate check while configuring TX rate limits
Date:   Fri, 21 Jul 2023 18:02:08 +0200
Message-ID: <20230721160529.631986546@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sridhar Samudrala <sridhar.samudrala@intel.com>

[ Upstream commit 5f16da6ee6ac32e6c8098bc4cfcc4f170694f9da ]

Remove incorrect check in ice_validate_mqprio_opt() that limits
filter configuration when sum of max_rates of all TCs exceeds
the link speed. The max rate of each TC is unrelated to value
used by other TCs and is valid as long as it is less than link
speed.

Fixes: fbc7b27af0f9 ("ice: enable ndo_setup_tc support for mqprio_qdisc")
Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Tested-by: Bharathi Sreenivas <bharathi.sreenivas@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index fcc027c938fda..eef7c1224887a 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -8114,10 +8114,10 @@ static int
 ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 			 struct tc_mqprio_qopt_offload *mqprio_qopt)
 {
-	u64 sum_max_rate = 0, sum_min_rate = 0;
 	int non_power_of_2_qcount = 0;
 	struct ice_pf *pf = vsi->back;
 	int max_rss_q_cnt = 0;
+	u64 sum_min_rate = 0;
 	struct device *dev;
 	int i, speed;
 	u8 num_tc;
@@ -8133,6 +8133,7 @@ ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 	dev = ice_pf_to_dev(pf);
 	vsi->ch_rss_size = 0;
 	num_tc = mqprio_qopt->qopt.num_tc;
+	speed = ice_get_link_speed_kbps(vsi);
 
 	for (i = 0; num_tc; i++) {
 		int qcount = mqprio_qopt->qopt.count[i];
@@ -8173,7 +8174,6 @@ ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 		 */
 		max_rate = mqprio_qopt->max_rate[i];
 		max_rate = div_u64(max_rate, ICE_BW_KBPS_DIVISOR);
-		sum_max_rate += max_rate;
 
 		/* min_rate is minimum guaranteed rate and it can't be zero */
 		min_rate = mqprio_qopt->min_rate[i];
@@ -8186,6 +8186,12 @@ ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 			return -EINVAL;
 		}
 
+		if (max_rate && max_rate > speed) {
+			dev_err(dev, "TC%d: max_rate(%llu Kbps) > link speed of %u Kbps\n",
+				i, max_rate, speed);
+			return -EINVAL;
+		}
+
 		iter_div_u64_rem(min_rate, ICE_MIN_BW_LIMIT, &rem);
 		if (rem) {
 			dev_err(dev, "TC%d: Min Rate not multiple of %u Kbps",
@@ -8223,12 +8229,6 @@ ice_validate_mqprio_qopt(struct ice_vsi *vsi,
 	    (mqprio_qopt->qopt.offset[i] + mqprio_qopt->qopt.count[i]))
 		return -EINVAL;
 
-	speed = ice_get_link_speed_kbps(vsi);
-	if (sum_max_rate && sum_max_rate > (u64)speed) {
-		dev_err(dev, "Invalid max Tx rate(%llu) Kbps > speed(%u) Kbps specified\n",
-			sum_max_rate, speed);
-		return -EINVAL;
-	}
 	if (sum_min_rate && sum_min_rate > (u64)speed) {
 		dev_err(dev, "Invalid min Tx rate(%llu) Kbps > speed (%u) Kbps specified\n",
 			sum_min_rate, speed);
-- 
2.39.2



