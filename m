Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB2E7831C1
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjHUT45 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 15:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229869AbjHUT44 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 15:56:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9341FB
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 12:56:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5D95C64625
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 19:56:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C6CBC433C8;
        Mon, 21 Aug 2023 19:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692647813;
        bh=QW7zRVwCjzQAVUPL0SSz0nOOhoT0O1hoYQ2wqhlP4Fg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xeiD+o1EjkRnPAh3Vy3TuIrSi1XiyhEcptQDXfQy0jZY1BCTP823eAz5w52AbF9pc
         eVsBQg1kbDMzDnh90H20eY+Okykr65e6wh5vDapNqErye3b2lfake+aKkyw3cCKt2B
         cncnxsQrBhDcKjozgdQfasXNCciSqFEukpvJ4yzk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zev Weiss <zev@bewilderbeest.net>,
        Joel Stanley <joel@jms.id.au>, Arnd Bergmann <arnd@arndb.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 147/194] soc: aspeed: uart-routing: Use __sysfs_match_string
Date:   Mon, 21 Aug 2023 21:42:06 +0200
Message-ID: <20230821194129.180115574@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194122.695845670@linuxfoundation.org>
References: <20230821194122.695845670@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Zev Weiss <zev@bewilderbeest.net>

[ Upstream commit e4ad279ae345413d900d791f2f618d0a1cd0d791 ]

The existing use of match_string() caused it to reject 'echo foo' due
to the implicitly appended newline, which was somewhat ergonomically
awkward and inconsistent with typical sysfs behavior.  Using the
__sysfs_* variant instead provides more convenient and consistent
linefeed-agnostic behavior.

Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
Fixes: c6807970c3bc ("soc: aspeed: Add UART routing support")
Reviewed-by: Joel Stanley <joel@jms.id.au>
Link: https://lore.kernel.org/r/20230628083735.19946-2-zev@bewilderbeest.net
Signed-off-by: Joel Stanley <joel@jms.id.au>
Link: https://lore.kernel.org/r/20230810122941.231085-1-joel@jms.id.au
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/aspeed/aspeed-uart-routing.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/aspeed/aspeed-uart-routing.c b/drivers/soc/aspeed/aspeed-uart-routing.c
index ef8b24fd18518..59123e1f27acb 100644
--- a/drivers/soc/aspeed/aspeed-uart-routing.c
+++ b/drivers/soc/aspeed/aspeed-uart-routing.c
@@ -524,7 +524,7 @@ static ssize_t aspeed_uart_routing_store(struct device *dev,
 	struct aspeed_uart_routing_selector *sel = to_routing_selector(attr);
 	int val;
 
-	val = match_string(sel->options, -1, buf);
+	val = __sysfs_match_string(sel->options, -1, buf);
 	if (val < 0) {
 		dev_err(dev, "invalid value \"%s\"\n", buf);
 		return -EINVAL;
-- 
2.40.1



