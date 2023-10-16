Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB657CAC7B
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 16:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbjJPOzT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 10:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbjJPOzS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 10:55:18 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87561AB
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 07:55:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D5A7C433C7;
        Mon, 16 Oct 2023 14:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697468116;
        bh=nxupJ6cgNl4jpoaayktBN5gTryxujA0Jkw1mRRy/XI0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h6bipm9bh+um3vzNc+VdV3PETSHTb9yxbsKLgldT9uVqlVmtk2sQtpCfGWqJl3W+j
         zI1O7CXO5DIGIaw+RkxCYTjiNJ+SUzsrzA62IkvLL6AfcXDLyd+JvHW+5pRBZndPRo
         zxGEjLZAPkHXsgMqB8/thVj8oSirksaDQ/6mJI1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Bjorn Andersson <andersson@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Andrew Halaney <ahalaney@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.5 161/191] power: supply: qcom_battmgr: fix enable request endianness
Date:   Mon, 16 Oct 2023 10:42:26 +0200
Message-ID: <20231016084019.133345271@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016084015.400031271@linuxfoundation.org>
References: <20231016084015.400031271@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

From: Johan Hovold <johan+linaro@kernel.org>

commit 8894b432548851f705f72ff135d3dcbd442a18d1 upstream.

Add the missing endianness conversion when sending the enable request so
that the driver will work also on a hypothetical big-endian machine.

This issue was reported by sparse.

Fixes: 29e8142b5623 ("power: supply: Introduce Qualcomm PMIC GLINK power supply")
Cc: stable@vger.kernel.org	# 6.3
Cc: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Andrew Halaney <ahalaney@redhat.com>
Link: https://lore.kernel.org/r/20230929101649.20206-1-johan+linaro@kernel.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/qcom_battmgr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
index a05fd00711f6..ec163d1bcd18 100644
--- a/drivers/power/supply/qcom_battmgr.c
+++ b/drivers/power/supply/qcom_battmgr.c
@@ -1282,9 +1282,9 @@ static void qcom_battmgr_enable_worker(struct work_struct *work)
 {
 	struct qcom_battmgr *battmgr = container_of(work, struct qcom_battmgr, enable_work);
 	struct qcom_battmgr_enable_request req = {
-		.hdr.owner = PMIC_GLINK_OWNER_BATTMGR,
-		.hdr.type = PMIC_GLINK_NOTIFY,
-		.hdr.opcode = BATTMGR_REQUEST_NOTIFICATION,
+		.hdr.owner = cpu_to_le32(PMIC_GLINK_OWNER_BATTMGR),
+		.hdr.type = cpu_to_le32(PMIC_GLINK_NOTIFY),
+		.hdr.opcode = cpu_to_le32(BATTMGR_REQUEST_NOTIFICATION),
 	};
 	int ret;
 
-- 
2.42.0



