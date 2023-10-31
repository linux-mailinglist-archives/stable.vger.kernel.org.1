Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726F37DC939
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 10:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343803AbjJaJPh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 05:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343793AbjJaJPg (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 05:15:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA95A2
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 02:15:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D309C433CD;
        Tue, 31 Oct 2023 09:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698743734;
        bh=GSoyzCtJ7MAwUIPg5M118fbfA415xAVi4hIYkX8HmSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+ib8/XYYJkzlKH9G2LAdXUX95AC8AaLsj2KrxHHfk87D1+qQU9V0AOySSyEvaWPs
         UFKpPYIVd/je9Uo/bVic0Hduf16+u79wIfrQbwxzW0Fp3LFsrjak+wogewxxLlTWXx
         +bY7D/Pfk7RchMCFmfmzP7xZ/iDDkYpAKYeBUD47dJL0t0Dt1nBvvYF48VpvVy/CLK
         pY7gKJkbntOMhI5OmZmv4aUqe8zwMpQ07Mhueu1eGEB/tcYGwi6W2xh2ozC2UXEV1Y
         fEcv0A4qmjQXWxl+hBTBEkRQULF2ehdUr6OY2P1iYQJ8l3kDBVuAL/9rsrJQYF7xI8
         cwBJhvumpUHJw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 5/6] rpmsg: glink: Release driver_override
Date:   Tue, 31 Oct 2023 09:15:16 +0000
Message-ID: <20231031091521.2223075-5-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031091521.2223075-1-lee@kernel.org>
References: <20231031091521.2223075-1-lee@kernel.org>
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
Change-Id: Ifaef186e79c35b32b49b0908102881c0e7dc13cf
---
 drivers/rpmsg/qcom_glink_native.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index d37fd1f431fe4..35e7291aa9696 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1395,6 +1395,7 @@ static void qcom_glink_rpdev_release(struct device *dev)
 	struct glink_channel *channel = to_glink_channel(rpdev->ept);
 
 	channel->rpdev = NULL;
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
@@ -1623,6 +1624,7 @@ static void qcom_glink_device_release(struct device *dev)
 
 	/* Release qcom_glink_alloc_channel() reference */
 	kref_put(&channel->refcount, qcom_glink_channel_release);
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
-- 
2.42.0.820.g83a721a137-goog

