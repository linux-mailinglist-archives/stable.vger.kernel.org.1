Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3074D7E24C2
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232512AbjKFNYz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:24:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbjKFNYz (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:24:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E03A9
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:24:52 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 236F5C433C7;
        Mon,  6 Nov 2023 13:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699277092;
        bh=1+6spfi3390Jkf0oVMnFTOJgd1oCKJ3QbQbboih/qFE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RYFmtC/ZizQM6KcPBKHSv8uz58egwAMyQ8ujmXBaTv3CCM4HOn2iRe1d3EIbXOJJE
         AhFPSBX2RbIJmtr4dbm2Q2TZ9ceJZ7bZeQQ3jOTvaOhlTmiC6lTB4yAhJxnyofJ3Qc
         8KW5/z0ahL2Xv0ukZS1M3hgx1nZWRfhqHUbsdtBA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 036/128] gtp: uapi: fix GTPA_MAX
Date:   Mon,  6 Nov 2023 14:03:16 +0100
Message-ID: <20231106130310.773733412@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130309.112650042@linuxfoundation.org>
References: <20231106130309.112650042@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pablo Neira Ayuso <pablo@netfilter.org>

[ Upstream commit adc8df12d91a2b8350b0cd4c7fec3e8546c9d1f8 ]

Subtract one to __GTPA_MAX, otherwise GTPA_MAX is off by 2.

Fixes: 459aa660eb1d ("gtp: add initial driver for datapath of GPRS Tunneling Protocol (GTP-U)")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/gtp.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/gtp.h b/include/uapi/linux/gtp.h
index 79f9191bbb24c..82d0e58ec3ce2 100644
--- a/include/uapi/linux/gtp.h
+++ b/include/uapi/linux/gtp.h
@@ -32,6 +32,6 @@ enum gtp_attrs {
 	GTPA_PAD,
 	__GTPA_MAX,
 };
-#define GTPA_MAX (__GTPA_MAX + 1)
+#define GTPA_MAX (__GTPA_MAX - 1)
 
 #endif /* _UAPI_LINUX_GTP_H_ */
-- 
2.42.0



