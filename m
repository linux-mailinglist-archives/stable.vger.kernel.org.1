Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0C979B222
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358271AbjIKWI0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241080AbjIKPB3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:01:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9CC2125
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:01:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42CABC433C8;
        Mon, 11 Sep 2023 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444484;
        bh=w5/ykC5htjhcK9bK3UMZZD8F750ZMJkQD1hfYSzo1xk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Xs+ACBp8ISVrE9nvetQ92wDqXT+9ZFyHNyjLzfG9SnPjKxgaa28aC6g5hvCz4lws
         cUocQjl0L22/sQHmHqhlcodz3/wB7LtnWsj/k+Yr/0DKYGTilOnLcGad4Kn8mz8pEy
         N/VaL5MY4GvCqFPOoimLoD0vXxtmhdtweuYiTTl0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Kuniyuki Iwashima <kuniyu@amazon.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 001/600] Revert "bridge: Add extack warning when enabling STP in netns."
Date:   Mon, 11 Sep 2023 15:40:34 +0200
Message-ID: <20230911134633.668244209@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 7ebd00a5a20c48e6020d49a3b2afb3cdfd2da8b7 ]

This reverts commit 56a16035bb6effb37177867cea94c13a8382f745.

Since the previous commit, STP works on bridge in netns.

  # unshare -n
  # ip link add br0 type bridge
  # ip link add veth0 type veth peer name veth1

  # ip link set veth0 master br0 up
  [   50.558135] br0: port 1(veth0) entered blocking state
  [   50.558366] br0: port 1(veth0) entered disabled state
  [   50.558798] veth0: entered allmulticast mode
  [   50.564401] veth0: entered promiscuous mode

  # ip link set veth1 master br0 up
  [   54.215487] br0: port 2(veth1) entered blocking state
  [   54.215657] br0: port 2(veth1) entered disabled state
  [   54.215848] veth1: entered allmulticast mode
  [   54.219577] veth1: entered promiscuous mode

  # ip link set br0 type bridge stp_state 1
  # ip link set br0 up
  [   61.960726] br0: port 2(veth1) entered blocking state
  [   61.961097] br0: port 2(veth1) entered listening state
  [   61.961495] br0: port 1(veth0) entered blocking state
  [   61.961653] br0: port 1(veth0) entered listening state
  [   63.998835] br0: port 2(veth1) entered blocking state
  [   77.437113] br0: port 1(veth0) entered learning state
  [   86.653501] br0: received packet on veth0 with own address as source address (addr:6e:0f:e7:6f:5f:5f, vlan:0)
  [   92.797095] br0: port 1(veth0) entered forwarding state
  [   92.797398] br0: topology change detected, propagating

Let's remove the warning.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_stp_if.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index b65962682771f..75204d36d7f90 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -201,9 +201,6 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
 {
 	ASSERT_RTNL();
 
-	if (!net_eq(dev_net(br->dev), &init_net))
-		NL_SET_ERR_MSG_MOD(extack, "STP does not work in non-root netns");
-
 	if (br_mrp_enabled(br)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "STP can't be enabled if MRP is already enabled");
-- 
2.40.1



