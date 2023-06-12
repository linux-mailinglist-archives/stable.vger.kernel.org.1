Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156ED72C22C
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 13:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237444AbjFLLDP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 07:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236980AbjFLLCx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 07:02:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA6F1980
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:50:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 694D962509
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:50:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57201C4339B;
        Mon, 12 Jun 2023 10:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686567034;
        bh=8q4cCCD57cFwAHi9U0kl0fKA/wjjMTO0Ad6fGbboLtA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YQm9I0yhxm2vSvPfaMzGiHgoCmwaWAoxSDThTowoqvWre5t9GE2Drt1hmJvN6oZ7y
         tferyXvr+S2KVjFOwgeADjk7pYyEwz6xmUyO8kb1w8qd5gzySZtQ691r2Td484uuwo
         Jwa4MZmayvCXZVeIi6o/AFjy1hLSbxT62cgjFUNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Dan Carpenter <dan.carpenter@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 126/160] soc: qcom: rmtfs: Fix error code in probe()
Date:   Mon, 12 Jun 2023 12:27:38 +0200
Message-ID: <20230612101720.822321978@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101715.129581706@linuxfoundation.org>
References: <20230612101715.129581706@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 7b374a2fc8665bfb8a0d93b617463cc0732f533a ]

Return an error code if of_property_count_u32_elems() fails.  Don't
return success.

Fixes: e656cd0bcf3d ("soc: qcom: rmtfs: Optionally map RMTFS to more VMs")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/76b21a14-70ff-4ca9-927d-587543c6699c@kili.mountain
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/rmtfs_mem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
index 0d31377f178d5..d4bda086c141a 100644
--- a/drivers/soc/qcom/rmtfs_mem.c
+++ b/drivers/soc/qcom/rmtfs_mem.c
@@ -234,6 +234,7 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
 		num_vmids = 0;
 	} else if (num_vmids < 0) {
 		dev_err(&pdev->dev, "failed to count qcom,vmid elements: %d\n", num_vmids);
+		ret = num_vmids;
 		goto remove_cdev;
 	} else if (num_vmids > NUM_MAX_VMIDS) {
 		dev_warn(&pdev->dev,
-- 
2.39.2



