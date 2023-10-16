Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73A507CA21A
	for <lists+stable@lfdr.de>; Mon, 16 Oct 2023 10:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjJPIp6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 16 Oct 2023 04:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231796AbjJPIp5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 16 Oct 2023 04:45:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1EEA2
        for <stable@vger.kernel.org>; Mon, 16 Oct 2023 01:45:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDCB9C433C7;
        Mon, 16 Oct 2023 08:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697445955;
        bh=hd+FRxApNTeTGOxa47NO/2h1/l0VP6cGqMURQXwuY5k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNr8Yowgk2FJhNQTpbMT8EHXm5+NKhh7Q+KwyyjYavWmNxtplLbAuwF2jRFqb/uU7
         occah8vHZycU+ID6i1QZJzZhiKf4yHD4VamxXjyeM8s8T5gB2r/ePqLp6y0RQsLSwb
         HvfXG4isO9DyC9RuBD7wsxsh1M4pY+OiAI2+sLiE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        David Ahern <dsahern@kernel.org>,
        Simon Horman <horms@kernel.org>,
        Patrick Rohr <prohr@google.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 045/102] net: release reference to inet6_dev pointer
Date:   Mon, 16 Oct 2023 10:40:44 +0200
Message-ID: <20231016083954.899878565@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231016083953.689300946@linuxfoundation.org>
References: <20231016083953.689300946@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Patrick Rohr <prohr@google.com>

commit 5cb249686e67dbef3ffe53887fa725eefc5a7144 upstream.

addrconf_prefix_rcv returned early without releasing the inet6_dev
pointer when the PIO lifetime is less than accept_ra_min_lft.

Fixes: 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA lifetimes")
Cc: Maciej Żenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: David Ahern <dsahern@kernel.org>
Cc: Simon Horman <horms@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Maciej Żenczykowski <maze@google.com>
Signed-off-by: Patrick Rohr <prohr@google.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/addrconf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2737,7 +2737,7 @@ void addrconf_prefix_rcv(struct net_devi
 	}
 
 	if (valid_lft != 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft)
-		return;
+		goto put;
 
 	/*
 	 *	Two things going on here:


