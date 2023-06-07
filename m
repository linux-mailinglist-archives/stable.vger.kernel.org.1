Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B97726D1C
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234364AbjFGUjP (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbjFGUjG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:39:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D79C2704
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:38:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AAAF645BA
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:38:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD2EC433EF;
        Wed,  7 Jun 2023 20:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170320;
        bh=vNo4OWyYJoTDOTHwzUM/B7G0kzbFgw7i2hamJgM8wNQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GQ8wLjltapsUJza988U0lLDevxhNNcEBQBR23QXANZfMsdXHvgj606bNOAxKmtNBo
         qrGtO/7vgMIkzDr7bjY/ilSmR77zXSetxa7NmMV4SnncIoVz0ocKrDZOEXEJZ9c/MM
         tulbC0hW3iUCkbk03Es2vi0Of/OdrbOttLFOItH4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pedro Tammela <pctammela@mojatatu.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 040/225] net/netlink: fix NETLINK_LIST_MEMBERSHIPS length report
Date:   Wed,  7 Jun 2023 22:13:53 +0200
Message-ID: <20230607200915.659464305@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200913.334991024@linuxfoundation.org>
References: <20230607200913.334991024@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Pedro Tammela <pctammela@mojatatu.com>

[ Upstream commit f4e4534850a9d18c250a93f8d7fbb51310828110 ]

The current code for the length calculation wrongly truncates the reported
length of the groups array, causing an under report of the subscribed
groups. To fix this, use 'BITS_TO_BYTES()' which rounds up the
division by 8.

Fixes: b42be38b2778 ("netlink: add API to retrieve all group memberships")
Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Link: https://lore.kernel.org/r/20230529153335.389815-1-pctammela@mojatatu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netlink/af_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index d1b19618890b7..6d493a0ccf399 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1768,7 +1768,7 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
 				break;
 			}
 		}
-		if (put_user(ALIGN(nlk->ngroups / 8, sizeof(u32)), optlen))
+		if (put_user(ALIGN(BITS_TO_BYTES(nlk->ngroups), sizeof(u32)), optlen))
 			err = -EFAULT;
 		netlink_unlock_table();
 		return err;
-- 
2.39.2



