Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EC2775D32
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjHILet (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjHILes (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:34:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD821FD8
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:34:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A67CA634B7
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:34:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8C6C433C9;
        Wed,  9 Aug 2023 11:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580887;
        bh=URYyrGHGWo8Jp4kN9fMZ1jLdgXcNjrTwQWaG7ZbdGpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p9S9/DPY4xG+5N+Pn0O507qoemEYKffokX9a7uzWyLeQ9fzAWMbnMFfK/qjK3Eid1
         Tb+x+ElrQxjtHilt9fRoLOCxSG/59oM9p9n0z1TRTT6E7eK0wqCvWoKUFzYcUsKvEH
         +dx0smXJm3d5I++BFRXrWU9oP3HPSYrwAE4kLQhw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Guangbin Huang <huangguangbin2@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 030/201] net: hns3: reconstruct function hclge_ets_validate()
Date:   Wed,  9 Aug 2023 12:40:32 +0200
Message-ID: <20230809103644.844736199@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103643.799166053@linuxfoundation.org>
References: <20230809103643.799166053@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Guangbin Huang <huangguangbin2@huawei.com>

[ Upstream commit 161ad669e6c23529415bffed5cb3bfa012e46cb4 ]

This patch reconstructs function hclge_ets_validate() to reduce the code
cycle complexity and make code more concise.

Signed-off-by: Guangbin Huang <huangguangbin2@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: 882481b1c55f ("net: hns3: fix wrong bw weight of disabled tc issue")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../hisilicon/hns3/hns3pf/hclge_dcb.c         | 47 ++++++++++++++-----
 1 file changed, 35 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
index 5bab885744fc8..c75794552a1a7 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_dcb.c
@@ -105,26 +105,30 @@ static int hclge_dcb_common_validate(struct hclge_dev *hdev, u8 num_tc,
 	return 0;
 }
 
-static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
-			      u8 *tc, bool *changed)
+static u8 hclge_ets_tc_changed(struct hclge_dev *hdev, struct ieee_ets *ets,
+			       bool *changed)
 {
-	bool has_ets_tc = false;
-	u32 total_ets_bw = 0;
-	u8 max_tc = 0;
-	int ret;
+	u8 max_tc_id = 0;
 	u8 i;
 
 	for (i = 0; i < HNAE3_MAX_USER_PRIO; i++) {
 		if (ets->prio_tc[i] != hdev->tm_info.prio_tc[i])
 			*changed = true;
 
-		if (ets->prio_tc[i] > max_tc)
-			max_tc = ets->prio_tc[i];
+		if (ets->prio_tc[i] > max_tc_id)
+			max_tc_id = ets->prio_tc[i];
 	}
 
-	ret = hclge_dcb_common_validate(hdev, max_tc + 1, ets->prio_tc);
-	if (ret)
-		return ret;
+	/* return max tc number, max tc id need to plus 1 */
+	return max_tc_id + 1;
+}
+
+static int hclge_ets_sch_mode_validate(struct hclge_dev *hdev,
+				       struct ieee_ets *ets, bool *changed)
+{
+	bool has_ets_tc = false;
+	u32 total_ets_bw = 0;
+	u8 i;
 
 	for (i = 0; i < HNAE3_MAX_TC; i++) {
 		switch (ets->tc_tsa[i]) {
@@ -158,7 +162,26 @@ static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
 	if (has_ets_tc && total_ets_bw != BW_PERCENT)
 		return -EINVAL;
 
-	*tc = max_tc + 1;
+	return 0;
+}
+
+static int hclge_ets_validate(struct hclge_dev *hdev, struct ieee_ets *ets,
+			      u8 *tc, bool *changed)
+{
+	u8 tc_num;
+	int ret;
+
+	tc_num = hclge_ets_tc_changed(hdev, ets, changed);
+
+	ret = hclge_dcb_common_validate(hdev, tc_num, ets->prio_tc);
+	if (ret)
+		return ret;
+
+	ret = hclge_ets_sch_mode_validate(hdev, ets, changed);
+	if (ret)
+		return ret;
+
+	*tc = tc_num;
 	if (*tc != hdev->tm_info.num_tc)
 		*changed = true;
 
-- 
2.39.2



