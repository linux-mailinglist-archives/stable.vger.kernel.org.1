Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A89DE7DCBE0
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235618AbjJaLeO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235313AbjJaLeO (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:34:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2818797
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:34:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DBDC433C9;
        Tue, 31 Oct 2023 11:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698752051;
        bh=tVXnGwvO5fR+CF5KnOn0WEcuMn+QNJJ56kIBaTscQz0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BDHw3blZ9gEbmglP8q5HDmktWWA7bipdgZQf11RQrH+1E+RB7+C9ahgxk9Cu4Edoo
         HgMgX8NDSgoWhuZpwZ7YaqnzM2WdK+GrcclkT5S5/KPFQQuMJLYlteMQ87rcgWx9WY
         Fj2QKhEBib5cEgbpIkxpNj9gaglY8nGAZ/j6cIsHEN+kcxSvic35WERnK6Mbevupbw
         5xaXHW2ZxVHthn5oOwu1zzzVxcK1fnsegeXPIXlzSsyTsbcYfJEcG4PvFaXHMWulk5
         4EKPSAXoorZCgQD6BbnTCgahoSM/T1GGelJj/IaJLjBdEKO530XZ3PkDH46dz9W2rC
         7bSsFbSH3+C4A==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v5.10.y 5/6] rpmsg: glink: Release driver_override
Date:   Tue, 31 Oct 2023 11:33:53 +0000
Message-ID: <20231031113357.2282037-5-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031113357.2282037-1-lee@kernel.org>
References: <20231031113357.2282037-1-lee@kernel.org>
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
index e776d1bfc9767..28b6ae0e1a2fd 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1379,6 +1379,7 @@ static void qcom_glink_rpdev_release(struct device *dev)
 	struct glink_channel *channel = to_glink_channel(rpdev->ept);
 
 	channel->rpdev = NULL;
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
@@ -1607,6 +1608,7 @@ static void qcom_glink_device_release(struct device *dev)
 
 	/* Release qcom_glink_alloc_channel() reference */
 	kref_put(&channel->refcount, qcom_glink_channel_release);
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
-- 
2.42.0.820.g83a721a137-goog

