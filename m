Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2948270C948
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjEVTq0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:46:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbjEVTqS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:46:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DC9DC
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:46:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3AFC62A05
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DF7C433EF;
        Mon, 22 May 2023 19:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784776;
        bh=St5QlSY1Lhp1rWCSmBbrz/VUEdthoS+jnsfhFhr72hk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JZ3BwAQoSZPwgxZ0fq3hZAalffLoiZ6RZW3sehmw3ISbOxF0soInKMFSjcakIfacx
         chkEqpQJaCKpkGYaS10WNOFzhSXlNAMzjBIjZrlbc+NiauDGQWE59aPhTsoRnNA9cM
         zcmxwlEpbb4wu1O1RiuDHUe72YaJgHQ9IUjwqN3w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Leon Romanovsky <leonro@nvidia.com>,
        Simon Horman <simon.horman@corigine.com>,
        Eric Dumazet <edumazet@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 199/364] xfrm: release all offloaded policy memory
Date:   Mon, 22 May 2023 20:08:24 +0100
Message-Id: <20230522190417.705464429@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Leon Romanovsky <leonro@nvidia.com>

[ Upstream commit 94b95dfaa814f565d92f5a65f0ff12a483095522 ]

Failure to add offloaded policy will cause to the following
error once user will try to reload driver.

Unregister_netdevice: waiting for eth3 to become free. Usage count = 2

This was caused by xfrm_dev_policy_add() which increments reference
to net_device. That reference was supposed to be decremented
in xfrm_dev_policy_free(). However the latter wasn't called.

 unregister_netdevice: waiting for eth3 to become free. Usage count = 2
 leaked reference.
  xfrm_dev_policy_add+0xff/0x3d0
  xfrm_policy_construct+0x352/0x420
  xfrm_add_policy+0x179/0x320
  xfrm_user_rcv_msg+0x1d2/0x3d0
  netlink_rcv_skb+0xe0/0x210
  xfrm_netlink_rcv+0x45/0x50
  netlink_unicast+0x346/0x490
  netlink_sendmsg+0x3b0/0x6c0
  sock_sendmsg+0x73/0xc0
  sock_write_iter+0x13b/0x1f0
  vfs_write+0x528/0x5d0
  ksys_write+0x120/0x150
  do_syscall_64+0x3d/0x90
  entry_SYSCALL_64_after_hwframe+0x46/0xb0

Fixes: 919e43fad516 ("xfrm: add an interface to offload policy")
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index 103af2b3e986f..af8fbcbfbe691 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1978,6 +1978,7 @@ static int xfrm_add_policy(struct sk_buff *skb, struct nlmsghdr *nlh,
 
 	if (err) {
 		xfrm_dev_policy_delete(xp);
+		xfrm_dev_policy_free(xp);
 		security_xfrm_policy_free(xp->security);
 		kfree(xp);
 		return err;
-- 
2.39.2



