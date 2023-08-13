Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2883077AC0C
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjHMV2l (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjHMV2l (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:28:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6E510DB
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:28:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1153862A5E
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:28:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C2BC433C7;
        Sun, 13 Aug 2023 21:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962122;
        bh=LJEqOoy/Sac427ChNWJowBXAlVtp6oGnDaQCF7GZgJg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GriSVIqi9E+/ic2BlJbIfw6jZjdeEF7rp8zLa/2hQnYIuCjVOkoeYAFslKB2PDKf9
         pFq2IcVcTYcnGmhRNYouRc6m2og5NNxw2N5DDykuYAaEKP7pV48lOOBTNzHK+Rz8Yp
         3vMRrDfUWpUisDbAW2lkb0l23Y83IxJBvcBGtrVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Ido Schimmel <idosch@nvidia.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 120/206] selftests: forwarding: bridge_mdb: Make test more robust
Date:   Sun, 13 Aug 2023 23:18:10 +0200
Message-ID: <20230813211728.477522576@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211724.969019629@linuxfoundation.org>
References: <20230813211724.969019629@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ido Schimmel <idosch@nvidia.com>

commit 8b5ff37097775cdbd447442603957066dd2e4d02 upstream.

Some test cases check that the group timer is (or isn't) 0. Instead of
grepping for "0.00" grep for " 0.00" as the former can also match
"260.00" which is the default group membership interval.

Fixes: b6d00da08610 ("selftests: forwarding: Add bridge MDB test")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20230808141503.4060661-18-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/forwarding/bridge_mdb.sh |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/tools/testing/selftests/net/forwarding/bridge_mdb.sh
+++ b/tools/testing/selftests/net/forwarding/bridge_mdb.sh
@@ -617,7 +617,7 @@ __cfg_test_port_ip_sg()
 		grep -q "permanent"
 	check_err $? "Entry not added as \"permanent\" when should"
 	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "0.00"
+		grep -q " 0.00"
 	check_err $? "\"permanent\" entry has a pending group timer"
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
@@ -626,7 +626,7 @@ __cfg_test_port_ip_sg()
 		grep -q "temp"
 	check_err $? "Entry not added as \"temp\" when should"
 	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "0.00"
+		grep -q " 0.00"
 	check_fail $? "\"temp\" entry has an unpending group timer"
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
 
@@ -659,7 +659,7 @@ __cfg_test_port_ip_sg()
 		grep -q "permanent"
 	check_err $? "Entry not marked as \"permanent\" after replace"
 	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "0.00"
+		grep -q " 0.00"
 	check_err $? "Entry has a pending group timer after replace"
 
 	bridge mdb replace dev br0 port $swp1 $grp_key vid 10 temp
@@ -667,7 +667,7 @@ __cfg_test_port_ip_sg()
 		grep -q "temp"
 	check_err $? "Entry not marked as \"temp\" after replace"
 	bridge -d -s mdb show dev br0 vid 10 | grep "$grp_key" | \
-		grep -q "0.00"
+		grep -q " 0.00"
 	check_fail $? "Entry has an unpending group timer after replace"
 	bridge mdb del dev br0 port $swp1 $grp_key vid 10
 


