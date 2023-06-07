Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51176726EDA
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjFGUxQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235317AbjFGUxM (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:53:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FA82113
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:53:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C801A64799
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D79FCC433D2;
        Wed,  7 Jun 2023 20:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686171185;
        bh=ADf5neXo9e5ChoGK7Rvxo9igDnCBcIC/ARWUh7/HMHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iVvG4RDL0fzKtVOE2UkVfhkMxM/3hGU38cI/3+RgnJTZA/6jUAtHRKZWUYZRgjw75
         GMlHmQUvsMvBhQB1/qMjtnp7pswsfWtv3DFpnDp0U2ErRHb1RHbQMhOPnhnUzWDV3p
         x7hyS4OUOSFGnb5r1BJXiSydTPn+MeG0bbokn3pk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Pedro Tammela <pctammela@mojatatu.com>,
        Simon Horman <simon.horman@corigine.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 22/99] net/netlink: fix NETLINK_LIST_MEMBERSHIPS length report
Date:   Wed,  7 Jun 2023 22:16:14 +0200
Message-ID: <20230607200900.951145749@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.195572674@linuxfoundation.org>
References: <20230607200900.195572674@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
index 31a3a562854fc..bf7e300e8c25d 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1780,7 +1780,7 @@ static int netlink_getsockopt(struct socket *sock, int level, int optname,
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



