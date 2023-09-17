Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512B37A39D2
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240162AbjIQTym (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240190AbjIQTy0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:54:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D88F3
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:54:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83539C433C7;
        Sun, 17 Sep 2023 19:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980461;
        bh=iHFNubh9oG6MzJKPGf5stIQyYH+qBewnVirr+30LCpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bf0i0Or0NhrQEPLZcg3ImxG2s/zJhaYe9t4NtSRxLC8m/uaWyiTdKoi7pPYYv01EX
         Z3LeaXBQ+TLD4v5D/wD/Dm/3n/q6O/pv7ZxdrFFl71hVaGKnu45XHu+23CDMe3ZMqy
         lGSB5YyJMVlnnEAvIfjg6nH7BoQwQx3RTIG4wSVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hao Chen <chenhao418@huawei.com>,
        Jijie Shao <shaojijie@huawei.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 168/285] net: hns3: fix byte order conversion issue in hclge_dbg_fd_tcam_read()
Date:   Sun, 17 Sep 2023 21:12:48 +0200
Message-ID: <20230917191057.462477733@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hao Chen <chenhao418@huawei.com>

[ Upstream commit efccf655e99b6907ca07a466924e91805892e7d3 ]

req1->tcam_data is defined as "u8 tcam_data[8]", and we convert it as
(u32 *) without considerring byte order conversion,
it may result in printing wrong data for tcam_data.

Convert tcam_data to (__le32 *) first to fix it.

Fixes: b5a0b70d77b9 ("net: hns3: refactor dump fd tcam of debugfs")
Signed-off-by: Hao Chen <chenhao418@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index f01a7a9ee02ca..ff3f8f424ad90 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -1519,7 +1519,7 @@ static int hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, bool sel_x,
 	struct hclge_desc desc[3];
 	int pos = 0;
 	int ret, i;
-	u32 *req;
+	__le32 *req;
 
 	hclge_cmd_setup_basic_desc(&desc[0], HCLGE_OPC_FD_TCAM_OP, true);
 	desc[0].flag |= cpu_to_le16(HCLGE_COMM_CMD_FLAG_NEXT);
@@ -1544,22 +1544,22 @@ static int hclge_dbg_fd_tcam_read(struct hclge_dev *hdev, bool sel_x,
 			 tcam_msg.loc);
 
 	/* tcam_data0 ~ tcam_data1 */
-	req = (u32 *)req1->tcam_data;
+	req = (__le32 *)req1->tcam_data;
 	for (i = 0; i < 2; i++)
 		pos += scnprintf(tcam_buf + pos, HCLGE_DBG_TCAM_BUF_SIZE - pos,
-				 "%08x\n", *req++);
+				 "%08x\n", le32_to_cpu(*req++));
 
 	/* tcam_data2 ~ tcam_data7 */
-	req = (u32 *)req2->tcam_data;
+	req = (__le32 *)req2->tcam_data;
 	for (i = 0; i < 6; i++)
 		pos += scnprintf(tcam_buf + pos, HCLGE_DBG_TCAM_BUF_SIZE - pos,
-				 "%08x\n", *req++);
+				 "%08x\n", le32_to_cpu(*req++));
 
 	/* tcam_data8 ~ tcam_data12 */
-	req = (u32 *)req3->tcam_data;
+	req = (__le32 *)req3->tcam_data;
 	for (i = 0; i < 5; i++)
 		pos += scnprintf(tcam_buf + pos, HCLGE_DBG_TCAM_BUF_SIZE - pos,
-				 "%08x\n", *req++);
+				 "%08x\n", le32_to_cpu(*req++));
 
 	return ret;
 }
-- 
2.40.1



