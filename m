Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C185B713D33
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjE1TWx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:22:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjE1TWw (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:22:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA5FDC
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:22:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1CEF61B6C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:22:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1961FC433D2;
        Sun, 28 May 2023 19:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685301769;
        bh=+bFim097sq3y4rbAbkJeIuEPyHgK1+iH50YopvUkemA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vZY4I9BAHOW61h6fFHpwCnCYl6tcxEZxtoxLVKUqNvaXr/eQOYgv84/1oOUdE8A+t
         KZK6WoZX6lkAKbS27s4YJ3KfSbVqPOX2fbAo4RVZv90/pd3YwKQXDZ9qkdRV9Cfz3b
         sQqeGBxC5Pb2sPn07A0NTKMb8j/P2GYTrlGBuVFQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nick Child <nnac123@linux.ibm.com>,
        Piotr Raczynski <piotr.raczynski@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 028/161] net: Catch invalid index in XPS mapping
Date:   Sun, 28 May 2023 20:09:12 +0100
Message-Id: <20230528190838.077832924@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nick Child <nnac123@linux.ibm.com>

[ Upstream commit 5dd0dfd55baec0742ba8f5625a0dd064aca7db16 ]

When setting the XPS value of a TX queue, warn the user once if the
index of the queue is greater than the number of allocated TX queues.

Previously, this scenario went uncaught. In the best case, it resulted
in unnecessary allocations. In the worst case, it resulted in
out-of-bounds memory references through calls to `netdev_get_tx_queue(
dev, index)`. Therefore, it is important to inform the user but not
worth returning an error and risk downing the netdevice.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
Reviewed-by: Piotr Raczynski <piotr.raczynski@intel.com>
Link: https://lore.kernel.org/r/20230321150725.127229-1-nnac123@linux.ibm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/dev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index c5561c88a8364..0cc0809628b08 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2244,6 +2244,8 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 	bool active = false;
 	unsigned int nr_ids;
 
+	WARN_ON_ONCE(index >= dev->num_tx_queues);
+
 	if (dev->num_tc) {
 		/* Do not allow XPS on subordinate device directly */
 		num_tc = dev->num_tc;
-- 
2.39.2



