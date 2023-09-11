Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FAD79B8A1
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245694AbjIKVL3 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242198AbjIKPYs (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:24:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3C7D8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:24:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41DBCC433C8;
        Mon, 11 Sep 2023 15:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445883;
        bh=eVTFQ6CrxaLrGrCfE/McUcTa/v4TIbnRMbVK9eBm438=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0PovGGWP6iFT2Q6xY+XJsnzy3b46qVx/gSbWunx3j2QSdpaI3SqC3CVe0Bze4yNZ8
         9V7uI3yxHgbW+pWiW3doA5hd0zhjSCJr2QVzqAl4hhVeFUE8TXXbMTfDRw77/MW1A4
         vPlp9YvrRU7nYGSBP+N5dkTg48F1Xfhc84A3hNCM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jiasheng Jiang <jiasheng@iscas.ac.cn>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 505/600] rpmsg: glink: Add check for kstrdup
Date:   Mon, 11 Sep 2023 15:48:58 +0200
Message-ID: <20230911134648.526804010@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiasheng Jiang <jiasheng@iscas.ac.cn>

[ Upstream commit b5c9ee8296a3760760c7b5d2e305f91412adc795 ]

Add check for the return value of kstrdup() and return the error
if it fails in order to avoid NULL pointer dereference.

Fixes: b4f8e52b89f6 ("rpmsg: Introduce Qualcomm RPM glink driver")
Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Link: https://lore.kernel.org/r/20230619030631.12361-1-jiasheng@iscas.ac.cn
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rpmsg/qcom_glink_native.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_native.c b/drivers/rpmsg/qcom_glink_native.c
index 67e7664efb0dc..cb8f65c1d4e3b 100644
--- a/drivers/rpmsg/qcom_glink_native.c
+++ b/drivers/rpmsg/qcom_glink_native.c
@@ -224,6 +224,10 @@ static struct glink_channel *qcom_glink_alloc_channel(struct qcom_glink *glink,
 
 	channel->glink = glink;
 	channel->name = kstrdup(name, GFP_KERNEL);
+	if (!channel->name) {
+		kfree(channel);
+		return ERR_PTR(-ENOMEM);
+	}
 
 	init_completion(&channel->open_req);
 	init_completion(&channel->open_ack);
-- 
2.40.1



