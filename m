Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AEF76F3D2
	for <lists+stable@lfdr.de>; Thu,  3 Aug 2023 22:05:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjHCUFN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 3 Aug 2023 16:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbjHCUFL (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 3 Aug 2023 16:05:11 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD9F30FD
        for <stable@vger.kernel.org>; Thu,  3 Aug 2023 13:05:10 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-348c6696960so4878855ab.2
        for <stable@vger.kernel.org>; Thu, 03 Aug 2023 13:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691093109; x=1691697909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=r70XE7tntpu/9iC4HC9hoUyClzm7YEMBlDPVVBgQ5D0=;
        b=h0875WuCpv+YXLBkdLyMBF1S1IpId9+F/SK55g4IhbqBcWvhO3A0klMWkHGYIPnjVL
         VRBZyU/33Xx1EMFdgjzueYZ6jXKRdDI37sn2MeEgahVaAO9h/e3ZS4BHDJcrM0MVoYGa
         d+uZHPfLSHnaAxUBgaBjHlm9jx+emEfZhQg6FXasoO8XnKG7JrZ44zDsQh145NBi8NV/
         3pNdVWIt1WpPfnNlTxykSPypYhCTQh83kPi5/SFKrgMP25rOXe+PLREswcGs7Oxh6GPe
         A+fP8Ag5AWaosgOPBP2rhQbqt8avFL7VZ3XNX7UjdnIhzygZHFbncXPnwtF7vWJpCAu4
         +uhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691093109; x=1691697909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r70XE7tntpu/9iC4HC9hoUyClzm7YEMBlDPVVBgQ5D0=;
        b=AJPT3l3dQfk4OO34+eGyn8AxRajJSM/46rMirzt/jBcavlWOqTcgXqgrnLtH9cuY3a
         eVSkmluqmtAXe/O59uVUspHNq8xn19VXrhKREaCKnrtt8fwi1++DZG5JtuWmgKlYpXCF
         T7UFIrcLppt4QTZ80Q8T0S8Gfb+VkWpaY/WrJFu/8B0PX8RbTzNp7qW0Uc/tmINlMPzf
         h8uZoe9d5mOmYmGn+EtCV9XbgQgmNjRFfsx0l/YzH2aPHPr8pmew/C+qHH5GBuDtr/F1
         h/peU/KrhHH056G2XvWHaMKyhNopO112dsl/U2fFJ0jzh2v5uPut4K6tnmtuofuG7WR2
         xHKg==
X-Gm-Message-State: ABy/qLYP+62259JZELftc0mxOS0I6jUovfHIO8opzDKqMqQ3lVf15Vgq
        rxcNTEk+tdDHcZo73z0cdxHweE3mLbL+vLIcGGE=
X-Google-Smtp-Source: APBJJlELtFtZ+xKecGRC9U+2pyUmD6ccvIppnKww+wiS1OWFzPo5+FLKdsJ9nQGY8rAXZyk6hzZ4fw==
X-Received: by 2002:a05:6e02:1d05:b0:348:9e12:13f8 with SMTP id i5-20020a056e021d0500b003489e1213f8mr20879585ila.27.1691093109338;
        Thu, 03 Aug 2023 13:05:09 -0700 (PDT)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id r7-20020a028807000000b0042b56b57a50sm105779jai.171.2023.08.03.13.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 13:05:08 -0700 (PDT)
From:   Alex Elder <elder@linaro.org>
To:     stable@vger.kernel.org
Cc:     kuba@kernel.org, dianders@chromium.org, elder@kernel.org
Subject: [PATCH] net: ipa: only reset hashed tables when supported
Date:   Thu,  3 Aug 2023 15:05:06 -0500
Message-Id: <20230803200506.282159-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

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

Fixes: d338ae28d8a8 ("net: ipa: kill all other transaction lists")
Cc: <stable@vger.kernel.org>    # 6.1.x
Tested-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Alex Elder <elder@linaro.org>
---
 drivers/net/ipa/ipa_table.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ipa/ipa_table.c b/drivers/net/ipa/ipa_table.c
index 510ff2dc8999a..cd81dd916c29e 100644
--- a/drivers/net/ipa/ipa_table.c
+++ b/drivers/net/ipa/ipa_table.c
@@ -311,16 +311,15 @@ static int ipa_filter_reset(struct ipa *ipa, bool modem)
 	if (ret)
 		return ret;
 
-	ret = ipa_filter_reset_table(ipa, IPA_MEM_V4_FILTER_HASHED, modem);
-	if (ret)
-		return ret;
-
 	ret = ipa_filter_reset_table(ipa, IPA_MEM_V6_FILTER, modem);
+	if (ret || !ipa_table_hash_support(ipa))
+		return ret;
+
+	ret = ipa_filter_reset_table(ipa, IPA_MEM_V4_FILTER_HASHED, modem);
 	if (ret)
 		return ret;
-	ret = ipa_filter_reset_table(ipa, IPA_MEM_V6_FILTER_HASHED, modem);
 
-	return ret;
+	return ipa_filter_reset_table(ipa, IPA_MEM_V6_FILTER_HASHED, modem);
 }
 
 /* The AP routes and modem routes are each contiguous within the
@@ -329,11 +328,12 @@ static int ipa_filter_reset(struct ipa *ipa, bool modem)
  * */
 static int ipa_route_reset(struct ipa *ipa, bool modem)
 {
+	bool hash_support = ipa_table_hash_support(ipa);
 	struct gsi_trans *trans;
 	u16 first;
 	u16 count;
 
-	trans = ipa_cmd_trans_alloc(ipa, 4);
+	trans = ipa_cmd_trans_alloc(ipa, hash_support ? 4 : 2);
 	if (!trans) {
 		dev_err(&ipa->pdev->dev,
 			"no transaction for %s route reset\n",
@@ -350,12 +350,14 @@ static int ipa_route_reset(struct ipa *ipa, bool modem)
 	}
 
 	ipa_table_reset_add(trans, false, first, count, IPA_MEM_V4_ROUTE);
-	ipa_table_reset_add(trans, false, first, count,
-			    IPA_MEM_V4_ROUTE_HASHED);
-
 	ipa_table_reset_add(trans, false, first, count, IPA_MEM_V6_ROUTE);
-	ipa_table_reset_add(trans, false, first, count,
-			    IPA_MEM_V6_ROUTE_HASHED);
+
+	if (hash_support) {
+		ipa_table_reset_add(trans, false, first, count,
+				    IPA_MEM_V4_ROUTE_HASHED);
+		ipa_table_reset_add(trans, false, first, count,
+				    IPA_MEM_V6_ROUTE_HASHED);
+	}
 
 	gsi_trans_commit_wait(trans);
 
-- 
2.34.1

