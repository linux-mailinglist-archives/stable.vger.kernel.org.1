Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE657611EE
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 12:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbjGYK5h (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 06:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbjGYK5H (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 06:57:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A444486
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 03:54:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5202F6165D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 10:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCFAC433CA;
        Tue, 25 Jul 2023 10:54:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690282479;
        bh=W1rBc2J+WGXrSNgXXJbKcIJ7GeX5xt0sqhAXLvxEDsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UHTn8+NB5X6l7lXfjSQ/NAI6OkkfjrFyTSDhKTTKTDwLqzLsaUCLWYLLhs5KyTD3U
         iRWHNCCPmTz84czWhHPyqHWj5tPzR1xiIe/Z/uLtW1y1bQrkryUabac+C6RukTZwjh
         PsAhVHXHA6vKbtshgUYXAUzX6X8NHraX+MaIli1c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yangtao Li <frank.li@vivo.com>,
        Helge Deller <deller@gmx.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 145/227] fbdev: imxfb: Removed unneeded release_mem_region
Date:   Tue, 25 Jul 2023 12:45:12 +0200
Message-ID: <20230725104520.884963034@linuxfoundation.org>
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

From: Yangtao Li <frank.li@vivo.com>

[ Upstream commit 45fcc058a75bf5d65cf4c32da44a252fbe873cd4 ]

Remove unnecessary release_mem_region from the error path to prevent
mem region from being released twice, which could avoid resource leak
or other unexpected issues.

Fixes: b083c22d5114 ("video: fbdev: imxfb: Convert request_mem_region + ioremap to devm_ioremap_resource")
Signed-off-by: Yangtao Li <frank.li@vivo.com>
Signed-off-by: Helge Deller <deller@gmx.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/imxfb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 5fbcb78a9caee..c8b1c73412d36 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -1043,7 +1043,6 @@ static int imxfb_probe(struct platform_device *pdev)
 failed_map:
 failed_ioremap:
 failed_getclock:
-	release_mem_region(res->start, resource_size(res));
 failed_of_parse:
 	kfree(info->pseudo_palette);
 failed_init:
-- 
2.39.2



