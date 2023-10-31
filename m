Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7107DCBCA
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235611AbjJaL1O (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235607AbjJaL1N (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:27:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44961C1
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:27:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C38E5C433C7;
        Tue, 31 Oct 2023 11:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698751630;
        bh=7TZYLJ53i696kqi/jVPQfxFDieU1UFetEotBFYZiqeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M6Qho3HDXHXQ7k/72mzj18PHNbCeL9Gb304wyFxbMjgrx7h6zENn5+2UeMkTbOz+6
         1mTMjbRuu8vnpxiMpVXkziS27JE1oNeRI5J2iM4y7UtchNUMDHuE6Gxbx8b94TCwQ1
         ed23Zb8O7xel51c9oJkAPnqtzQV9wyJBPD7gd8q6wXpc7ZS3f706GIgrc3lvxqvTfn
         WbLY0K28YzoylzJp6FmpS9nMwo5KZav56LVnL9xVw+l/94YTxoyYLtwBtc/vZQy04S
         u5+JNRpITwkSJexpCcWwhnPqUQjLbKOYRh/xNiAucfpEyv6HlSo2G4U2JOy1V2kk6n
         0wDGHdPutmvIw==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v5.15.y 5/6] rpmsg: glink: Release driver_override
Date:   Tue, 31 Oct 2023 11:25:39 +0000
Message-ID: <20231031112545.2277797-5-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031112545.2277797-1-lee@kernel.org>
References: <20231031112545.2277797-1-lee@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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

