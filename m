Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7329F7E24F0
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbjKFN0p (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjKFN0l (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:26:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7660DEA
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:26:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAACDC433C7;
        Mon,  6 Nov 2023 13:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277199;
        bh=a+tQjlZa1rvKEUBOikeXRZ+CFs8Nzg5ntUbowK1kFN4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zh9re5iymCB52eGgnNAqnno5rTC7QPKvUFvQRSQCHAh32lQgxuizJe1Cm82RB6c5A
         BIOaL1sDpE7T4D7qhS1DcxMoHvv7iKxeEVvoMvQSOchHHmH5RxyLIcVvuoT3eo54MR
         Zvtom8X3VRsABeo9HoVKmprvrBYxOtjRgzPmvWBI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, lee@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Lew <quic_clew@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 5.15 072/128] rpmsg: glink: Release driver_override
Date:   Mon,  6 Nov 2023 14:03:52 +0100
Message-ID: <20231106130312.401214989@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rpmsg/qcom_glink_native.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1395,6 +1395,7 @@ static void qcom_glink_rpdev_release(str
 	struct glink_channel *channel = to_glink_channel(rpdev->ept);
 
 	channel->rpdev = NULL;
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
@@ -1623,6 +1624,7 @@ static void qcom_glink_device_release(st
 
 	/* Release qcom_glink_alloc_channel() reference */
 	kref_put(&channel->refcount, qcom_glink_channel_release);
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 


