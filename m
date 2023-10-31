Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0A27DD53B
	for <lists+stable@lfdr.de>; Tue, 31 Oct 2023 18:48:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376568AbjJaRsc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 31 Oct 2023 13:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376525AbjJaRs2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 31 Oct 2023 13:48:28 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C1AB4
        for <stable@vger.kernel.org>; Tue, 31 Oct 2023 10:48:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE568C433C9;
        Tue, 31 Oct 2023 17:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698774501;
        bh=4XvI3QtFfS+WTTSQmDaHxfdjqoCoGfm+4Y8v8GEExO8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xTsWlJLzqWsFyt29iGxDuRSVH88lqk787YoIT+aTBBt4AL/9AKy2jE0tQN77djx4P
         vqJlCNwCdP0BPuXrjIJj17zj6TTqOQmmgp9oc/VMI1OzAv6mA97R42UtvDe6Bj25tk
         1QL4z3SnactuuFMopmn9CHOYfZeICwv2u6DcMDNQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 060/112] net: ieee802154: adf7242: Fix some potential buffer overflow in adf7242_stats_show()
Date:   Tue, 31 Oct 2023 18:01:01 +0100
Message-ID: <20231031165903.217312378@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031165901.318222981@linuxfoundation.org>
References: <20231031165901.318222981@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit ca082f019d8fbb983f03080487946da714154bae ]

strncat() usage in adf7242_debugfs_init() is wrong.
The size given to strncat() is the maximum number of bytes that can be
written, excluding the trailing NULL.

Here, the size that is passed, DNAME_INLINE_LEN, does not take into account
the size of "adf7242-" that is already in the array.

In order to fix it, use snprintf() instead.

Fixes: 7302b9d90117 ("ieee802154/adf7242: Driver for ADF7242 MAC IEEE802154")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ieee802154/adf7242.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ieee802154/adf7242.c b/drivers/net/ieee802154/adf7242.c
index a03490ba2e5b3..cc7ddc40020fd 100644
--- a/drivers/net/ieee802154/adf7242.c
+++ b/drivers/net/ieee802154/adf7242.c
@@ -1162,9 +1162,10 @@ static int adf7242_stats_show(struct seq_file *file, void *offset)
 
 static void adf7242_debugfs_init(struct adf7242_local *lp)
 {
-	char debugfs_dir_name[DNAME_INLINE_LEN + 1] = "adf7242-";
+	char debugfs_dir_name[DNAME_INLINE_LEN + 1];
 
-	strncat(debugfs_dir_name, dev_name(&lp->spi->dev), DNAME_INLINE_LEN);
+	snprintf(debugfs_dir_name, sizeof(debugfs_dir_name),
+		 "adf7242-%s", dev_name(&lp->spi->dev));
 
 	lp->debugfs_root = debugfs_create_dir(debugfs_dir_name, NULL);
 
-- 
2.42.0



