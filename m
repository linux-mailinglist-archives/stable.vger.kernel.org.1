Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CAC7DCC07
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 12:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344024AbjJaLmM (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 07:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344003AbjJaLmM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 07:42:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6212597
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 04:42:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7E24C433CB;
        Tue, 31 Oct 2023 11:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698752530;
        bh=o2p8Ei43NpQsae2kbu4BovVfQeELwp2o9Sdx9GFSmCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AXCF4gaGDrrnrBUCIpAba/xScTOAH3WRP9vM923H+IGvmVLDsKnWqZqSMKTJAql6m
         LPXO9AXne0SUYDIhqskX5QuZGxRv2IeV3LzTIFhf2DPpdf7xDjhfwHhZ6TjHQGERn6
         00mkd9x5y0lqK4/pM/h5jb6SZunIgP7q52CCxlgJJ2nm8FWwjZq54pFg704e9Y0cKh
         cQ2xP2/8bTIXVUjWG643gcA7JsZ/GdNI5LVpXBqN9NxCCK5e2z9JCrzW8NbFtF5P2k
         vbEdz61gok5NKy5WveQYVBZu3gS4GJF5bkc3qQUd6JWLmaglIDW3chxWyTzOyz9+Al
         eiINumjqExo5Q==
From:   Lee Jones <lee@kernel.org>
To:     lee@kernel.org
Cc:     stable@vger.kernel.org,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Chris Lew <quic_clew@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>
Subject: [PATCH v4.14.y 4/5] rpmsg: glink: Release driver_override
Date:   Tue, 31 Oct 2023 11:41:49 +0000
Message-ID: <20231031114155.2289410-4-lee@kernel.org>
X-Mailer: git-send-email 2.42.0.820.g83a721a137-goog
In-Reply-To: <20231031114155.2289410-1-lee@kernel.org>
References: <20231031114155.2289410-1-lee@kernel.org>
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
(cherry picked from commit fb80ef67e8ff6a00d3faad4cb348dafdb8eccfd8)
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rpmsg/qcom_glink_native.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index c1dfad2986859..8ee814d6dddce 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -1354,6 +1354,7 @@ static void qcom_glink_rpdev_release(struct device *dev)
 	struct glink_channel *channel = to_glink_channel(rpdev->ept);
 
 	channel->rpdev = NULL;
+	kfree(rpdev->driver_override);
 	kfree(rpdev);
 }
 
-- 
2.42.0.820.g83a721a137-goog

