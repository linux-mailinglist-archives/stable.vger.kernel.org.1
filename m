Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC7176120A
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjGYK65 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233858AbjGYK6M (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:58:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE6D30D7
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7063D61648
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:55:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BB7FC433C8;
        Tue, 25 Jul 2023 10:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282527;
        bh=S31snx7GFg/oaF6O2rW/pZcSVMfGR4uWJlfGvvQMfRo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xiM2izIwrnoPDY90ORwxPz0j3WsT/8QT8QkOOnUeQyH9ZTdZOwNj3nVpoHd8/NqJj
         oxZ71Z6cMjIRIok7g1BB44Chst5wDgJv8iv2EcMD4hJYfBttUmgIyvUqBRMbHPgNNu
         BCpFu3nlOyj2BQY+IOTH5FHaHGDUWnDTn75w7OZc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Hao Chen <chenhao418@huawei.com>,
        kernel test robot <lkp@intel.com>,
        Hao Lan <lanhao@huawei.com>, Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 133/227] net: hns3: fix strncpy() not using dest-buf length as length issue
Date:   Tue, 25 Jul 2023 12:45:00 +0200
Message-ID: <20230725104520.349741363@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104514.821564989@linuxfoundation.org>
References: <20230725104514.821564989@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Hao Chen <chenhao418@huawei.com>

[ Upstream commit 1cf3d5567f273a8746d1bade00633a93204f80f0 ]

Now, strncpy() in hns3_dbg_fill_content() use src-length as copy-length,
it may result in dest-buf overflow.

This patch is to fix intel compile warning for csky-linux-gcc (GCC) 12.1.0
compiler.

The warning reports as below:

hclge_debugfs.c:92:25: warning: 'strncpy' specified bound depends on
the length of the source argument [-Wstringop-truncation]

strncpy(pos, items[i].name, strlen(items[i].name));

hclge_debugfs.c:90:25: warning: 'strncpy' output truncated before
terminating nul copying as many bytes from a string as its length
[-Wstringop-truncation]

strncpy(pos, result[i], strlen(result[i]));

strncpy() use src-length as copy-length, it may result in
dest-buf overflow.

So,this patch add some values check to avoid this issue.

Signed-off-by: Hao Chen <chenhao418@huawei.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/lkml/202207170606.7WtHs9yS-lkp@intel.com/T/
Signed-off-by: Hao Lan <lanhao@huawei.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../ethernet/hisilicon/hns3/hns3_debugfs.c    | 31 ++++++++++++++-----
 .../hisilicon/hns3/hns3pf/hclge_debugfs.c     | 29 ++++++++++++++---
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index d385ffc218766..32bb14303473b 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -438,19 +438,36 @@ static void hns3_dbg_fill_content(char *content, u16 len,
 				  const struct hns3_dbg_item *items,
 				  const char **result, u16 size)
 {
+#define HNS3_DBG_LINE_END_LEN	2
 	char *pos = content;
+	u16 item_len;
 	u16 i;
 
+	if (!len) {
+		return;
+	} else if (len <= HNS3_DBG_LINE_END_LEN) {
+		*pos++ = '\0';
+		return;
+	}
+
 	memset(content, ' ', len);
-	for (i = 0; i < size; i++) {
-		if (result)
-			strncpy(pos, result[i], strlen(result[i]));
-		else
-			strncpy(pos, items[i].name, strlen(items[i].name));
+	len -= HNS3_DBG_LINE_END_LEN;
 
-		pos += strlen(items[i].name) + items[i].interval;
+	for (i = 0; i < size; i++) {
+		item_len = strlen(items[i].name) + items[i].interval;
+		if (len < item_len)
+			break;
+
+		if (result) {
+			if (item_len < strlen(result[i]))
+				break;
+			strscpy(pos, result[i], strlen(result[i]));
+		} else {
+			strscpy(pos, items[i].name, strlen(items[i].name));
+		}
+		pos += item_len;
+		len -= item_len;
 	}
-
 	*pos++ = '\n';
 	*pos++ = '\0';
 }
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
index a0b46e7d863eb..233c132dc513e 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_debugfs.c
@@ -88,16 +88,35 @@ static void hclge_dbg_fill_content(char *content, u16 len,
 				   const struct hclge_dbg_item *items,
 				   const char **result, u16 size)
 {
+#define HCLGE_DBG_LINE_END_LEN	2
 	char *pos = content;
+	u16 item_len;
 	u16 i;
 
+	if (!len) {
+		return;
+	} else if (len <= HCLGE_DBG_LINE_END_LEN) {
+		*pos++ = '\0';
+		return;
+	}
+
 	memset(content, ' ', len);
+	len -= HCLGE_DBG_LINE_END_LEN;
+
 	for (i = 0; i < size; i++) {
-		if (result)
-			strncpy(pos, result[i], strlen(result[i]));
-		else
-			strncpy(pos, items[i].name, strlen(items[i].name));
-		pos += strlen(items[i].name) + items[i].interval;
+		item_len = strlen(items[i].name) + items[i].interval;
+		if (len < item_len)
+			break;
+
+		if (result) {
+			if (item_len < strlen(result[i]))
+				break;
+			strscpy(pos, result[i], strlen(result[i]));
+		} else {
+			strscpy(pos, items[i].name, strlen(items[i].name));
+		}
+		pos += item_len;
+		len -= item_len;
 	}
 	*pos++ = '\n';
 	*pos++ = '\0';
-- 
2.39.2



