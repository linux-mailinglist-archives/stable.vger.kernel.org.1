Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13BAE7BDD28
	for <lists+stable@lfdr.de>; Mon,  9 Oct 2023 15:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376666AbjJINIC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 9 Oct 2023 09:08:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376701AbjJINIB (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 9 Oct 2023 09:08:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB78093
        for <stable@vger.kernel.org>; Mon,  9 Oct 2023 06:08:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ABD5C433C7;
        Mon,  9 Oct 2023 13:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696856880;
        bh=Od9kaKBFT2Fk/9r0AGKyrFUevwxLabknWCSyEwGPm6Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYzNyFBxrjXMT/qnyfI1WfwzHmmyW6Hfdmt8fn9iX4v31VcU83UKGUZP5dpmXrMru
         UpNopBzLjd/IixReVGVChqk6LjW3f+5YJIyJXEg4OQNmcuYVZOcf5NAa5o/5ktzU6+
         7oXgWXOo7rs/D2d/IFPWYlWtHVig4ByrbpsWzIrs=
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
Subject: [PATCH 6.5 022/163] net: release reference to inet6_dev pointer
Date:   Mon,  9 Oct 2023 14:59:46 +0200
Message-ID: <20231009130124.622192711@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231009130124.021290599@linuxfoundation.org>
References: <20231009130124.021290599@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2734,7 +2734,7 @@ void addrconf_prefix_rcv(struct net_devi
 	}
 
 	if (valid_lft != 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft)
-		return;
+		goto put;
 
 	/*
 	 *	Two things going on here:


