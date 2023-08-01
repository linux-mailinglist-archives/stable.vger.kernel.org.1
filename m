Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F5676AF61
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232837AbjHAJq7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbjHAJqc (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:46:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 983C1E49
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:45:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 769AA6126D
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:45:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89153C433C7;
        Tue,  1 Aug 2023 09:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883112;
        bh=7Mf8wvQQrHW024RmVALhiI1c7yA37AEAl9OfI5tfrNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SDroQAYIgUS63VsXyg/jBf2koXna2/GREUfnXv6CdhVOK3hc2BNhgZuVL/YVAgxXL
         hDx/wxGon1OUHNGc5Iba2cZsUfTcAyu1IdEcV6wgGfT7o1MCdyI72SHrE9OZfAQPyD
         flrVHfqJ7r2hztLqPyLfEY2Uo8oGjUqgZMbVeY6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Breno Leitao <leitao@debian.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 119/239] cxl/acpi: Fix a use-after-free in cxl_parse_cfmws()
Date:   Tue,  1 Aug 2023 11:19:43 +0200
Message-ID: <20230801091930.013223090@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230801091925.659598007@linuxfoundation.org>
References: <20230801091925.659598007@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 4cf67d3cc9994a59cf77bb9c0ccf9007fe916afe ]

KASAN and KFENCE detected an user-after-free in the CXL driver. This
happens in the cxl_decoder_add() fail path. KASAN prints the following
error:

   BUG: KASAN: slab-use-after-free in cxl_parse_cfmws (drivers/cxl/acpi.c:299)

This happens in cxl_parse_cfmws(), where put_device() is called,
releasing cxld, which is accessed later.

Use the local variables in the dev_err() instead of pointing to the
released memory. Since the dev_err() is printing a resource, change the open
coded print format to use the %pr format specifier.

Fixes: e50fe01e1f2a ("cxl/core: Drop ->platform_res attribute for root decoders")
Signed-off-by: Breno Leitao <leitao@debian.org>
Link: https://lore.kernel.org/r/20230714093146.2253438-1-leitao@debian.org
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cxl/acpi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 7e1765b09e04a..973d6747078c9 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -296,8 +296,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
 	else
 		rc = cxl_decoder_autoremove(dev, cxld);
 	if (rc) {
-		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
-			cxld->hpa_range.start, cxld->hpa_range.end);
+		dev_err(dev, "Failed to add decode range: %pr", res);
 		return 0;
 	}
 	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
-- 
2.40.1



