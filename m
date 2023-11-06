Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 954347E2471
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232424AbjKFNV5 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:21:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjKFNV4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:21:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3998BBF
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:21:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C326C433C9;
        Mon,  6 Nov 2023 13:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276913;
        bh=LB9KvV6X9/FVdTVtFUImVAhx3+d2zTiarKdTzvE0Qa0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hsn4jG2y41G6odRNIpUfNDmq1vLcUsMYikeWt8VX46ogsfIt69162owRSsI3utQYC
         CawjLIl18RoY1S+6Vm46mMYoU//7lVoqHqBhKrQ+dUEWtEHmxLd8vPvCS4l49mYKwo
         L5dMeheoIVS6hA5h+GFgtpWDblD16I5o7bxeXWhE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org, lee@kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Chris Lew <quic_clew@quicinc.com>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH 5.4 48/74] rpmsg: glink: Release driver_override
Date:   Mon,  6 Nov 2023 14:04:08 +0100
Message-ID: <20231106130303.394332690@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.687882731@linuxfoundation.org>
References: <20231106130301.687882731@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

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
 drivers/rpmsg/qcom_glink_native.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1379,6 +1379,7 @@ static void qcom_glink_rpdev_release(str
 	struct glink_channel *channel = to_glink_channel(rpdev->ept);
 
 	channel->rpdev = NULL;
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 


