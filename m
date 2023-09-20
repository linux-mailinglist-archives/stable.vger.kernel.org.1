Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F4C7A7E74
	for <lists+stable@lfdr.de>; Wed, 20 Sep 2023 14:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbjITMSD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 20 Sep 2023 08:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235577AbjITMSC (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 20 Sep 2023 08:18:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E50CA3
        for <stable@vger.kernel.org>; Wed, 20 Sep 2023 05:17:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B4AC433CA;
        Wed, 20 Sep 2023 12:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695212266;
        bh=WGAOGvdBT7egE/L6hnA0Y+A1kDM/UpYojw4Ope5mXuU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dofm6TOcoYLKayA56SWxNuN4A0nvHGr/utFR9bahqwSlzmLcC41jtaZVhHea/JCJf
         0VHLEIssyUuvA1ZIYlGCneH/4p3KAKcCz4txtoLd/jnV6Jasmn7hSA7HdOHvrjlthR
         9C0oBe6y81xXaPD8KYMHdcA6vp/MOKKjgRZI5ZE8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alex Henrie <alexhenrie24@gmail.com>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 213/273] net: ipv6/addrconf: avoid integer underflow in ipv6_create_tempaddr
Date:   Wed, 20 Sep 2023 13:30:53 +0200
Message-ID: <20230920112853.043454947@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230920112846.440597133@linuxfoundation.org>
References: <20230920112846.440597133@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Henrie <alexhenrie24@gmail.com>

[ Upstream commit f31867d0d9d82af757c1e0178b659438f4c1ea3c ]

The existing code incorrectly casted a negative value (the result of a
subtraction) to an unsigned value without checking. For example, if
/proc/sys/net/ipv6/conf/*/temp_prefered_lft was set to 1, the preferred
lifetime would jump to 4 billion seconds. On my machine and network the
shortest lifetime that avoided underflow was 3 seconds.

Fixes: 76506a986dc3 ("IPv6: fix DESYNC_FACTOR")
Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5c5c5736f6892..5ffa8777ab098 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1321,7 +1321,7 @@ static int ipv6_create_tempaddr(struct inet6_ifaddr *ifp,
 	 * idev->desync_factor if it's larger
 	 */
 	cnf_temp_preferred_lft = READ_ONCE(idev->cnf.temp_prefered_lft);
-	max_desync_factor = min_t(__u32,
+	max_desync_factor = min_t(long,
 				  idev->cnf.max_desync_factor,
 				  cnf_temp_preferred_lft - regen_advance);
 
-- 
2.40.1



