Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A197A3838
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbjIQTdW (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239752AbjIQTcz (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:32:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ABA519A
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:32:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E60C433CB;
        Sun, 17 Sep 2023 19:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694979160;
        bh=Rj9C1NbN1r6Tl+/Ueh9c+Ljy15oM4FmmeED6/Gb/y+o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffRnJv1QmccB2ezug5EYovtamk9m7wb3COCOQfUGPb1Wc98po2LOSCU1JxBQyOfye
         lPglsu1WGd2EsP2TiEY1OHZHMtGigkpkWRY/t+xVJme/lu+ntBUuEbaNrgyF+ppjKW
         LA8y8bfZWCtJhXXk0UMLoJLGvTbnQoXdTBAL9AKE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiang Yang <xiangyang3@huawei.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 232/406] IB/uverbs: Fix an potential error pointer dereference
Date:   Sun, 17 Sep 2023 21:11:26 +0200
Message-ID: <20230917191107.296370614@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiang Yang <xiangyang3@huawei.com>

[ Upstream commit 26b7d1a27167e7adf75b150755e05d2bc123ce55 ]

smatch reports the warning below:
drivers/infiniband/core/uverbs_std_types_counters.c:110
ib_uverbs_handler_UVERBS_METHOD_COUNTERS_READ() error: 'uattr'
dereferencing possible ERR_PTR()

The return value of uattr maybe ERR_PTR(-ENOENT), fix this by checking
the value of uattr before using it.

Fixes: ebb6796bd397 ("IB/uverbs: Add read counters support")
Signed-off-by: Xiang Yang <xiangyang3@huawei.com>
Link: https://lore.kernel.org/r/20230804022525.1916766-1-xiangyang3@huawei.com
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/core/uverbs_std_types_counters.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/infiniband/core/uverbs_std_types_counters.c b/drivers/infiniband/core/uverbs_std_types_counters.c
index b3c6c066b6010..c61b10fbf90a9 100644
--- a/drivers/infiniband/core/uverbs_std_types_counters.c
+++ b/drivers/infiniband/core/uverbs_std_types_counters.c
@@ -108,6 +108,8 @@ static int UVERBS_HANDLER(UVERBS_METHOD_COUNTERS_READ)(
 		return ret;
 
 	uattr = uverbs_attr_get(attrs, UVERBS_ATTR_READ_COUNTERS_BUFF);
+	if (IS_ERR(uattr))
+		return PTR_ERR(uattr);
 	read_attr.ncounters = uattr->ptr_attr.len / sizeof(u64);
 	read_attr.counters_buff = uverbs_zalloc(
 		attrs, array_size(read_attr.ncounters, sizeof(u64)));
-- 
2.40.1



