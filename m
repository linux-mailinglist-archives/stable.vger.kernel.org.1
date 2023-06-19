Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318D5735559
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 13:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjFSLDu (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 07:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbjFSLD1 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 07:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8AB1BEB
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 04:02:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB66760BA0
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 11:02:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68DDC433C9;
        Mon, 19 Jun 2023 11:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687172552;
        bh=bmUyoeaeEcyjZ4zOZ+43Ae8D+MVj0J803yJGKXcZaPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oOJJIhzXm0uTpdr6KozrxhMmJuGmncL3Sob7cze5qDlIRCQSOc0sqJhJJYJ25CMqy
         HJLuG2gqyMaAzY1+eZAup0h18CZTPeIg47eaqBJXYwuigfkZ71u/zx3PPqZDnkvPA/
         TjiqchdF0njBTSTGdq1bRLtXYUSieH4WdizeUAxU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 083/107] net: ethtool: correct MAX attribute value for stats
Date:   Mon, 19 Jun 2023 12:31:07 +0200
Message-ID: <20230619102145.367541181@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102141.541044823@linuxfoundation.org>
References: <20230619102141.541044823@linuxfoundation.org>
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

From: Jakub Kicinski <kuba@kernel.org>

[ Upstream commit 52f79609c0c5b25fddb88e85f25ce08aa7e3fb42 ]

When compiling YNL generated code compiler complains about
array-initializer-out-of-bounds. Turns out the MAX value
for STATS_GRP uses the value for STATS.

This may lead to random corruptions in user space (kernel
itself doesn't use this value as it never parses stats).

Fixes: f09ea6fb1272 ("ethtool: add a new command for reading standard stats")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/ethtool_netlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ethtool_netlink.h b/include/uapi/linux/ethtool_netlink.h
index f7204bdfe8db1..97e5d303810f2 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -743,7 +743,7 @@ enum {
 
 	/* add new constants above here */
 	__ETHTOOL_A_STATS_GRP_CNT,
-	ETHTOOL_A_STATS_GRP_MAX = (__ETHTOOL_A_STATS_CNT - 1)
+	ETHTOOL_A_STATS_GRP_MAX = (__ETHTOOL_A_STATS_GRP_CNT - 1)
 };
 
 enum {
-- 
2.39.2



