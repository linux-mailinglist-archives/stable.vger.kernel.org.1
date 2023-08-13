Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64E677ACB5
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjHMVgK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjHMVgJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:36:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB11D10E3
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FEE062D35
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B92C433C7;
        Sun, 13 Aug 2023 21:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691962570;
        bh=LCN13f/maaKH/wIUK5yVyf7CBCaaoLCsJZ92DFP6SW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xxRwgs/r7GpGsc2QPIA9ed1IqR6+AyvHnjNzNRH+ZEP2+tM9moprN9dDrCwSNclj8
         w9uS83JK5KqgMwFJDSdmpSqg4OAzBP9m/zaO7xD9EAhrec2syfL8V6zCJNSxrUU/Vd
         huI0lQQjBYRuEB2epR9i7zaOYQhzhELrbJsmzaQ0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 077/149] selftests: forwarding: ethtool: Skip when using veth pairs
Date:   Sun, 13 Aug 2023 23:18:42 +0200
Message-ID: <20230813211721.100076887@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211718.757428827@linuxfoundation.org>
References: <20230813211718.757428827@linuxfoundation.org>
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

commit 60a36e21915c31c0375d9427be9406aa8ce2ec34 upstream.

Auto-negotiation cannot be tested with veth pairs, resulting in
failures:

 # ./ethtool.sh
 TEST: force of same speed autoneg off                               [FAIL]
         error in configuration. swp1 speed Not autoneg off
 [...]

Fix by skipping the test when used with veth pairs.

Fixes: 64916b57c0b1 ("selftests: forwarding: Add speed and auto-negotiation test")
Reported-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Closes: https://lore.kernel.org/netdev/adc5e40d-d040-a65e-eb26-edf47dac5b02@alu.unizg.hr/
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Tested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20230808141503.4060661-8-idosch@nvidia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/forwarding/ethtool.sh |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/testing/selftests/net/forwarding/ethtool.sh
+++ b/tools/testing/selftests/net/forwarding/ethtool.sh
@@ -286,6 +286,8 @@ different_speeds_autoneg_on()
 	ethtool -s $h1 autoneg on
 }
 
+skip_on_veth
+
 trap cleanup EXIT
 
 setup_prepare


