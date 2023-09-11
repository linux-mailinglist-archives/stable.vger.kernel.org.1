Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AE779B534
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379603AbjIKWpE (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239332AbjIKOSH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:18:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D0FDE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:18:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85822C433C7;
        Mon, 11 Sep 2023 14:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441882;
        bh=5brf6djcu2tGil/3BEX53HC+md2Friu3Qq7cO3KfjDw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T8yUBiXXn8a6q0p2XI1GUpAk6Y62oJpyapWMr1weOgSXUA6gzK7PZuDW6SRvajNIV
         nGC7BUsZI5ocX0PMzGFOZJwf12Dy/Hyq0O3Mmh8N+TerGyisb9dGOKIIyjJ3fIckQT
         zV4MQzT4D19AizcU6oWuxGosok1siiSlaGtcadcw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 569/739] interconnect: qcom: bcm-voter: Use enable_maks for keepalive voting
Date:   Mon, 11 Sep 2023 15:46:08 +0200
Message-ID: <20230911134706.966839167@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Konrad Dybcio <konrad.dybcio@linaro.org>

[ Upstream commit 1a70ca71547be051769f0628aa09717694f508f0 ]

BCMs with an enable_mask expect to only have that specific value written
to them. The current implementation only works by miracle for BCMs with
enable mask == BIT(0), as the minimal vote we've been using so far just
so happens to be equal to that.

Use the correct value with keepalive voting.

Fixes: d8630f050d3f ("interconnect: qcom: Add support for mask-based BCMs")
Reported-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230811-topic-icc_fix_1he-v2-2-0620af8ac133@linaro.org
Signed-off-by: Georgi Djakov <djakov@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/interconnect/qcom/bcm-voter.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/interconnect/qcom/bcm-voter.c b/drivers/interconnect/qcom/bcm-voter.c
index d857eb8838b95..a2d437a05a11f 100644
--- a/drivers/interconnect/qcom/bcm-voter.c
+++ b/drivers/interconnect/qcom/bcm-voter.c
@@ -81,10 +81,10 @@ static void bcm_aggregate_mask(struct qcom_icc_bcm *bcm)
 	}
 
 	if (bcm->keepalive) {
-		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = 1;
-		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = 1;
-		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = 1;
-		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = 1;
+		bcm->vote_x[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
+		bcm->vote_x[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
+		bcm->vote_y[QCOM_ICC_BUCKET_AMC] = bcm->enable_mask;
+		bcm->vote_y[QCOM_ICC_BUCKET_WAKE] = bcm->enable_mask;
 	}
 }
 
-- 
2.40.1



