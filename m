Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C67527DCC00
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343844AbjJaLkK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343743AbjJaLkJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:40:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA1E91
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:40:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07593C433C9;
        Tue, 31 Oct 2023 11:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698752407;
        bh=PGZMTdKnNEd2GjFexVExVLABt279x3BkHx72vWmzG7M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sc5fL3nT8xcE9NiGV9LFzou/S4XLG3xHcfyZtsBPcza+CeOPINa4C5spcW4IWWs2K
         BDhOFm7nTaksuBpkU8u1Vl5saK56wAQgJlofaDRZ2EPFfQ/JYHLnfJCNHLJo2NKjJ5
         jxkU71ruHvi+5Q6q/CMoZHUTecpyF437u52ncplt0elEAWrgSZeAdvR5rp0gtyeIKR
         WZQc/vPKl83Xp5wS3q9uXN5Fb0htJaeqQTXzHMSUvU4L1Z9pHTGf94o2rga5RJF8nI
         03cppVWa0SO4LnapC2ixhuzdTHmkwGoaT66NgqKcTVAt2e9rpMeHvur9fk2npyWv7l
         UZM3REkwkG6Ug==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v4.19.y 5/6] rpmsg: glink: Release driver_override
Date:   Tue, 31 Oct 2023 11:39:51 +0000
Message-ID: <20231031113956.2287681-5-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031113956.2287681-1-lee@kernel.org>
References: <20231031113956.2287681-1-lee@kernel.org>
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

