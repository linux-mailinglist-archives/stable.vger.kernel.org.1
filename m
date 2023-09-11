Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17EA79B67A
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353667AbjIKVsB (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbjIKORj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:17:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7DC3DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:17:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21301C433C7;
        Mon, 11 Sep 2023 14:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694441854;
        bh=2tpsvFs4U3Ici1GmdJd8B/tbHn68HNdg4iMgOUtvduU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g9SRmsH4Y77A5963Rqk33JRKxfQDnH01OJM/SYCt/s5Gx6BRgxgG2vw6YW8QRH3yj
         fNtGpG2Inv//7L1BJ5RJIbeObmfKvUE0DNnHerlYhU5jVvEfhrlVoIs2mMPxFQZFDl
         6hzYPdxHb1a1+d4L7zjTl7IbRJXJ3/kFkaNQJRa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Suzuki K Poulose <suzuki.poulose@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 560/739] coresight: platform: acpi: Ignore the absence of graph
Date:   Mon, 11 Sep 2023 15:45:59 +0200
Message-ID: <20230911134706.721707970@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suzuki K Poulose <suzuki.poulose@arm.com>

[ Upstream commit 3a2888aa1f962c55ca36119aebe67355c7bf54e4 ]

Some components may not have graph connections for describing
the trace path. e.g., ETE, where it could directly use the per
CPU TRBE. Ignore the absence of graph connections

Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
Link: https://lore.kernel.org/r/20230710062500.45147-6-anshuman.khandual@arm.com
Stable-dep-of: 1a9e02673e25 ("coresight: Fix memory leak in acpi_buffer->pointer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwtracing/coresight/coresight-platform.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index 3e2e135cb8f6d..c8940314cceb8 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -669,8 +669,12 @@ static int acpi_coresight_parse_graph(struct device *dev,
 	struct coresight_connection *new_conn;
 
 	graph = acpi_get_coresight_graph(adev);
+	/*
+	 * There are no graph connections, which is fine for some components.
+	 * e.g., ETE
+	 */
 	if (!graph)
-		return -ENOENT;
+		return 0;
 
 	nlinks = graph->package.elements[2].integer.value;
 	if (!nlinks)
-- 
2.40.1



