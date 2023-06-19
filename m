Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAC7D7353CA
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231731AbjFSKsv (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:48:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbjFSKsY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:48:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67D2E76
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39B4D60B86
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:48:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44280C433C0;
        Mon, 19 Jun 2023 10:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171696;
        bh=Zm9VRyR2riJzio3svaHdK8zEU3Lv217R/AfSrc1B3KE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oGBfmCF4OqvJTWaiqTWyDRrCewhcAk6++hSyWaKVEtrgTZwTMYgI1zIB35INXVY7E
         MFofuF2+sve/NEhPTGDBufaip6HhNyDKVG5Sxvmh3/Aek5c57cm6HSrzqP+wQj5Mn0
         gUaWZ3jUlPxg+/o1IktHHy+I+Pc6FfTzvNmEgeas=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 124/166] net: ethtool: correct MAX attribute value for stats
Date:   Mon, 19 Jun 2023 12:30:01 +0200
Message-ID: <20230619102200.846105944@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102154.568541872@linuxfoundation.org>
References: <20230619102154.568541872@linuxfoundation.org>
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
index bb57084ac524a..69f5bec347c20 100644
--- a/include/uapi/linux/ethtool_netlink.h
+++ b/include/uapi/linux/ethtool_netlink.h
@@ -761,7 +761,7 @@ enum {
 
 	/* add new constants above here */
 	__ETHTOOL_A_STATS_GRP_CNT,
-	ETHTOOL_A_STATS_GRP_MAX = (__ETHTOOL_A_STATS_CNT - 1)
+	ETHTOOL_A_STATS_GRP_MAX = (__ETHTOOL_A_STATS_GRP_CNT - 1)
 };
 
 enum {
-- 
2.39.2



