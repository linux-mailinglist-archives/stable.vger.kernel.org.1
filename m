Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A1E72C082
	for <lists+stable@lfdr.de>; Mon, 12 Jun 2023 12:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbjFLKxH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 12 Jun 2023 06:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234671AbjFLKws (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 12 Jun 2023 06:52:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71ECFA27D
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 03:37:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EA8D612E1
        for <stable@vger.kernel.org>; Mon, 12 Jun 2023 10:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20E6BC433D2;
        Mon, 12 Jun 2023 10:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686566236;
        bh=jMCHALi8KjHKdEPw/O+jtk5nI9YzTjePPGffa2ob4+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/GwR/WypVpHOECj4VdZPu2++vFLUj5lUJj/bC66n4jpEpMPhl953YEwiiNF56AZp
         SXpngJG8ZiNfEy8BxpiYJlgtBsyBJ0vduY/WSUD555gu2BwRv3vSiNsm87zPo19qRa
         8RCOp7yrrhxTSyeUMFY6cSLZzul2iCsgr3J5lAm0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Martin Liska <mliska@suse.cz>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.15 08/91] bonding (gcc13): synchronize bond_{a,t}lb_xmit() types
Date:   Mon, 12 Jun 2023 12:25:57 +0200
Message-ID: <20230612101702.423936119@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612101702.085813286@linuxfoundation.org>
References: <20230612101702.085813286@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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
 struct slave *bond_xmit_alb_slave_get(struct bonding *bond,
 				      struct sk_buff *skb);
 struct slave *bond_xmit_tlb_slave_get(struct bonding *bond,


