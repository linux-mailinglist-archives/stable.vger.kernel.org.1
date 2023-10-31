Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112127DC998
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 10:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343910AbjJaJag (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 05:30:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343905AbjJaJaf (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 05:30:35 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0777DA
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 02:30:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD1BC433C9;
        Tue, 31 Oct 2023 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698744632;
        bh=nL+HF4ttIyjEwalrFvaCepa5okoVRcPS2vOEbNz9H9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QfwWtwBYzbOg5lGdtd2ejzXGpIgJEMWjHH06dfk1JQYD8oKMhMbkVTMJ7/kwNw0/0
         SYp1GqVcH8h9jZIQPurnE1YDdHGjZk8bkgUZQojQmpiu3KBk3NBVvJhyZ7skFNlSUQ
         2DYc6jtDwRFQIO44b9fI43uRNvMJvkG3YOgSFT0Pjjb7pUF1UsCuTBtgsTd6CIh4ph
         JjfMpoJXFmZMaxVkSvDAUgO/Lbo4SaxTVkcgxKJtp5rwHFu5xgMtVg/RaTyxjTLMt5
         F9C4YtrtFGwOk660y7stJG/LfxTGS9I2ctKYeD3rt0rwM59PnI8S8tFUUXlyO7e0Sw
         KTu1HAJd2wTuQ==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v4.19.y 5/6] rpmsg: glink: Release driver_override
Date:   Tue, 31 Oct 2023 09:30:14 +0000
Message-ID: <20231031093018.2233640-5-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031093018.2233640-1-lee@kernel.org>
References: <20231031093018.2233640-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Bjorn Andersson <quic_bjorande@quicinc.com>

commit fb80ef67e8ff6a00d3faad4cb348dafdb8eccfd8 upstream.

Upon termination of the rpmsg_device, driver_override needs to be freed
to avoid leaking the potentially assigned string.

Fixes: 42cd402b8fd4 ("rpmsg: Fix kfree() of static memory on setting driver_override")
Fixes: 39e47767ec9b ("rpmsg: Add driver_override device attribute for rpmsg_device")
Reviewed-by: Chris Lew <quic_clew@quicinc.com>
Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230109223931.1706429-1-quic_bjorande@quicinc.com
Signed-off-by: Lee Jones <lee@kernel.org>
Change-Id: Ifc377cb3847accb80b52bb00e8ed769208fc6870
---
 drivers/rpmsg/qcom_glink_native.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 02e39778d3c6b..48d2fb187a1bf 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1379,6 +1379,7 @@ static void qcom_glink_rpdev_release(struct device *dev)
 	struct glink_channel *channel = to_glink_channel(rpdev->ept);
 
 	channel->rpdev = NULL;
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
-- 
2.42.0.820.g83a721a137-goog

