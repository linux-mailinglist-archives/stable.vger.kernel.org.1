Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474CB72BFCE
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:47:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbjFLKrV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235028AbjFLKrI (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:47:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3958E9
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:31:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BBD461492
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:31:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D497C433D2;
        Mon, 12 Jun 2023 10:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686565901;
        bh=YK/odd9bvZAOlLY+HKc93Kjg978I/OM0V4/guLyocHU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KZCVK+wWt47AApNjW0x/2jIAIAE9RmcflFCN1i/7x+TTNJ2J3/Qz3syg79j1E4yT6
         +8J5vW8X+r5taR0CBPmo12qKpc3V09ESJtDQ07TgcCUxujh2YY81GwzxAKxAGVOCeo
         H1B7w/ZRpaJQacTqCAGnExSo4c8zMsuJTzmcTQgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Liska <mliska@suse.cz>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 34/45] bonding (gcc13): synchronize bond_{a,t}lb_xmit() types
Date:   Mon, 12 Jun 2023 12:26:28 +0200
Message-ID: <20230612101656.040317214@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101654.644983109@linuxfoundation.org>
References: <20230612101654.644983109@linuxfoundation.org>
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

From: Jiri Slaby (SUSE) <jirislaby@kernel.org>

commit 777fa87c7682228e155cf0892ba61cb2ab1fe3ae upstream.

Both bond_alb_xmit() and bond_tlb_xmit() produce a valid warning with
gcc-13:
  drivers/net/bonding/bond_alb.c:1409:13: error: conflicting types for 'bond_tlb_xmit' due to enum/integer mismatch; have 'netdev_tx_t(struct sk_buff *, struct net_device *)' ...
  include/net/bond_alb.h:160:5: note: previous declaration of 'bond_tlb_xmit' with type 'int(struct sk_buff *, struct net_device *)'

  drivers/net/bonding/bond_alb.c:1523:13: error: conflicting types for 'bond_alb_xmit' due to enum/integer mismatch; have 'netdev_tx_t(struct sk_buff *, struct net_device *)' ...
  include/net/bond_alb.h:159:5: note: previous declaration of 'bond_alb_xmit' with type 'int(struct sk_buff *, struct net_device *)'

I.e. the return type of the declaration is int, while the definitions
spell netdev_tx_t. Synchronize both of them to the latter.

Cc: Martin Liska <mliska@suse.cz>
Cc: Jay Vosburgh <j.vosburgh@gmail.com>
Cc: Veaceslav Falico <vfalico@gmail.com>
Cc: Andy Gospodarek <andy@greyhouse.net>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Link: https://lore.kernel.org/r/20221031114409.10417-1-jirislaby@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/bond_alb.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/include/net/bond_alb.h
+++ b/include/net/bond_alb.h
@@ -156,8 +156,8 @@ int bond_alb_init_slave(struct bonding *
 void bond_alb_deinit_slave(struct bonding *bond, struct slave *slave);
 void bond_alb_handle_link_change(struct bonding *bond, struct slave *slave, char link);
 void bond_alb_handle_active_change(struct bonding *bond, struct slave *new_slave);
-int bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
-int bond_tlb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
+netdev_tx_t bond_alb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
+netdev_tx_t bond_tlb_xmit(struct sk_buff *skb, struct net_device *bond_dev);
 void bond_alb_monitor(struct work_struct *);
 int bond_alb_set_mac_address(struct net_device *bond_dev, void *addr);
 void bond_alb_clear_vlan(struct bonding *bond, unsigned short vlan_id);


