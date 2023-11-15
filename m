Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EE57ED0A4
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343824AbjKOT4w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:56:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343841AbjKOT4g (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:56:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AFE1B9
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:56:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC9AC433CC;
        Wed, 15 Nov 2023 19:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700078193;
        bh=wqXWy2jl2v3CE5SXUiBsX61V3NM891BouksDMaDpcpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IrtvKJoIrIAChfPHzBJNZlaMi9tcgszA4WeIbZhqh5OT9aOTbvgn6HrbLZL97ul3T
         qX2n7wXtZjrDQ+tDhzXcWEP8IRxe5mwGw1Aw6Nv7FHL6UNfV7s8BN5/XqEHzsmnFF9
         +wAOSRDDD8KAy6SlG4gmsLNuKdFMp7vZQiDCkM/4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Johnny Liu <johnliu@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 144/379] gpu: host1x: Correct allocated size for contexts
Date:   Wed, 15 Nov 2023 14:23:39 -0500
Message-ID: <20231115192653.632765237@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115192645.143643130@linuxfoundation.org>
References: <20231115192645.143643130@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johnny Liu <johnliu@nvidia.com>

[ Upstream commit e889a311f74f4ae8bd40755a2c58d02e1c684fef ]

Original implementation over allocates the memory size for the
contexts list. The size of memory for the contexts list is based
on the number of iommu groups specified in the device tree.

Fixes: 8aa5bcb61612 ("gpu: host1x: Add context device management code")
Signed-off-by: Johnny Liu <johnliu@nvidia.com>
Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230901115910.701518-1-cyndis@kapsi.fi
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/host1x/context.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/host1x/context.c b/drivers/gpu/host1x/context.c
index 047696432eb21..93c0c532fe5af 100644
--- a/drivers/gpu/host1x/context.c
+++ b/drivers/gpu/host1x/context.c
@@ -34,10 +34,10 @@ int host1x_memory_context_list_init(struct host1x *host1x)
 	if (err < 0)
 		return 0;
 
-	cdl->devs = kcalloc(err, sizeof(*cdl->devs), GFP_KERNEL);
+	cdl->len = err / 4;
+	cdl->devs = kcalloc(cdl->len, sizeof(*cdl->devs), GFP_KERNEL);
 	if (!cdl->devs)
 		return -ENOMEM;
-	cdl->len = err / 4;
 
 	for (i = 0; i < cdl->len; i++) {
 		struct iommu_fwspec *fwspec;
-- 
2.42.0



