Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F3A76AFC0
	for <lists+stable@lfdr.de>; Tue,  1 Aug 2023 11:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233653AbjHAJuC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 1 Aug 2023 05:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233389AbjHAJtt (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 1 Aug 2023 05:49:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6FF1713
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 02:49:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5CA5614FC
        for <stable@vger.kernel.org>; Tue,  1 Aug 2023 09:49:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DD1C433C7;
        Tue,  1 Aug 2023 09:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690883341;
        bh=Q4BiTurSuxHTTKVYLid99KNugupWWkCPNRl+fcUm9xc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uqmC/vN5zqYXmmZk2+/oz7PmuiXJKSv3wcXam58Qg5WWjqdXrWybC5XwUa8DS1niu
         oCEm4t7KSPL17C7Pcek5WmOXp9gkanjNVvHoY29Ulfdwkh9XiUkEY64n0WweLOrqF9
         DzKhsJn6o0+u5wshiGe0OV1fggILzvyWzOt9kPnQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Douglas Anderson <dianders@chromium.org>,
        Alex Elder <elder@linaro.org>, Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 202/239] net: ipa: only reset hashed tables when supported
Date:   Tue,  1 Aug 2023 11:21:06 +0200
Message-ID: <20230801091933.085541350@linuxfoundation.org>
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

From: Alex Elder <elder@linaro.org>

commit e11ec2b868af2b351c6c1e2e50eb711cc5423a10 upstream.

Last year, the code that manages GSI channel transactions switched
from using spinlock-protected linked lists to using indexes into the
ring buffer used for a channel.  Recently, Google reported seeing
transaction reference count underflows occasionally during shutdown.

Doug Anderson found a way to reproduce the issue reliably, and
bisected the issue to the commit that eliminated the linked lists
and the lock.  The root cause was ultimately determined to be
related to unused transactions being committed as part of the modem
shutdown cleanup activity.  Unused transactions are not normally
expected (except in error cases).

The modem uses some ranges of IPA-resident memory, and whenever it
shuts down we zero those ranges.  In ipa_filter_reset_table() a
transaction is allocated to zero modem filter table entries.  If
hashing is not supported, hashed table memory should not be zeroed.
But currently nothing prevents that, and the result is an unused
transaction.  Something similar occurs when we zero routing table
entries for the modem.

By preventing any attempt to clear hashed tables when hashing is not
supported, the reference count underflow is avoided in this case.

Note that there likely remains an issue with properly freeing unused
transactions (if they occur due to errors).  This patch addresses
only the underflows that Google originally reported.

Cc: <stable@vger.kernel.org> # 6.1.x
Fixes: d338ae28d8a8 ("net: ipa: kill all other transaction lists")
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Alex Elder <elder@linaro.org>
Link: https://lore.kernel.org/r/20230724224055.1688854-1-elder@linaro.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ipa/ipa_table.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -273,16 +273,15 @@ static int ipa_filter_reset(struct ipa *
 	if (ret)
 		return ret;
 
-	ret = ipa_filter_reset_table(ipa, true, false, modem);
-	if (ret)
+	ret = ipa_filter_reset_table(ipa, false, true, modem);
+	if (ret || !ipa_table_hash_support(ipa))
 		return ret;
 
-	ret = ipa_filter_reset_table(ipa, false, true, modem);
+	ret = ipa_filter_reset_table(ipa, true, false, modem);
 	if (ret)
 		return ret;
-	ret = ipa_filter_reset_table(ipa, true, true, modem);
 
-	return ret;
+	return ipa_filter_reset_table(ipa, true, true, modem);
 }
 
 /* The AP routes and modem routes are each contiguous within the
@@ -291,12 +290,13 @@ static int ipa_filter_reset(struct ipa *
  * */
 static int ipa_route_reset(struct ipa *ipa, bool modem)
 {
+	bool hash_support = ipa_table_hash_support(ipa);
 	u32 modem_route_count = ipa->modem_route_count;
 	struct gsi_trans *trans;
 	u16 first;
 	u16 count;
 
-	trans = ipa_cmd_trans_alloc(ipa, 4);
+	trans = ipa_cmd_trans_alloc(ipa, hash_support ? 4 : 2);
 	if (!trans) {
 		dev_err(&ipa->pdev->dev,
 			"no transaction for %s route reset\n",
@@ -313,10 +313,12 @@ static int ipa_route_reset(struct ipa *i
 	}
 
 	ipa_table_reset_add(trans, false, false, false, first, count);
-	ipa_table_reset_add(trans, false, true, false, first, count);
-
 	ipa_table_reset_add(trans, false, false, true, first, count);
-	ipa_table_reset_add(trans, false, true, true, first, count);
+
+	if (hash_support) {
+		ipa_table_reset_add(trans, false, true, false, first, count);
+		ipa_table_reset_add(trans, false, true, true, first, count);
+	}
 
 	gsi_trans_commit_wait(trans);
 


