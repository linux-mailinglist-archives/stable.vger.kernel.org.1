Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A5870C774
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjEVT3z (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjEVT3v (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:29:51 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3411F185
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:29:40 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A624D5C0189;
        Mon, 22 May 2023 15:29:37 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 22 May 2023 15:29:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alyssa.is; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1684783777; x=1684870177; bh=HBoVS9lDn8F3CFO9DSEt13byj
        HvAYrLb93ANSRivQfI=; b=RwzeBUmQ7ANqsEWmhVZzqAibF9vs7vmx3Q6H/PjWt
        zRKYtyJa8P8XD39fqA11A9j/dXobqSNyXQiIgaDe0b2dtghiNdVDnC/tRghOhJa+
        H1jhe3oI6kvMww1Z8juIC3450mJRpSWiqukSYYaulzEpmqlH18hX2ORhuN8kfKgp
        vlEgNpWt4Bo9Esz2rLY9/0ONxZ/f6ri4i2omJqbc9hNtSSH+DdYoQrkL4kDbyX2S
        +K/6+29K50aQ97g1KlPZS/iqdCnv7g2KX9mH47nnM5aQrd8hnX1lXMQsKgVGFaj3
        XcVtsOp8as5V4qYjfnLOxW5LDy9CqZ1bJHwrlD97o78jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1684783777; x=1684870177; bh=HBoVS9lDn8F3CFO9DSEt13byjHvAYrLb93A
        NSRivQfI=; b=X7nOAG7oNhep/wdsrCTBkOPiDrOJYs9fNEwwle3RuSNoFfA7o0+
        QnmGZ+FZPxcawsWA+GsLtRVd7Ub9vxOVypCqMy7/zoVBl209kZh4vmGHJxulE2Bz
        1m8scICPk15w/B/m+bCQdwktEI3Qul3jPGCu0FtN6VIQwZ1TfMwKcmJ3o0l8/RJQ
        QasfgvKhevAj0ZyixceVcPBzvMj98u6JmSQ3bI8rbs1YZ9gcwGOf1Pe82NGMpiwK
        lwS4AvPXPtmpsjfqrsTCYaQ5S/hmrGignaYwZo/NOn5yto16q90NMLhYajeLfDod
        KTT1p9Oy1iJnPtGDTQjqHnpRAh7sPhnBhbA==
X-ME-Sender: <xms:ocJrZCk1lwjbxhkK6JMQcG0XJDeX4m2qOqNZ2ztoL0knYfToK8ZvYA>
    <xme:ocJrZJ2U5lkZT1tmdyE-CibWbmnNIb8T9Vzw41ch4NtOxp619-t_FP1zJBXPHQkMy
    dInmMLFEYutLXqncg>
X-ME-Received: <xmr:ocJrZAqtzo6CXqwE053BL7arm-IUwa1pYhJfQNwvhpJXxPnQZ_8s52hsTApSfTNQLLWw19rhjTxeH9G7rBTLcIiOrQe88cGQVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejuddguddvgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfggtggusehgtderredttddvnecuhfhrohhmpeetlhihshhs
    rgcutfhoshhsuceohhhisegrlhihshhsrgdrihhsqeenucggtffrrghtthgvrhhnpeehff
    egheelvdeugeduiedvkefhleegvdefleegfeevudeiieegvddvhfeitdeuffenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehhihesrghlhihssh
    grrdhish
X-ME-Proxy: <xmx:ocJrZGkVkvPisD--Tdqxf2Uk_uyeo8WExa21b85B4DslDS3XJz0CCg>
    <xmx:ocJrZA04f_szr7y616yhzqommW72nwa_Y3S4UQz7ZRysp1x6FbQdPw>
    <xmx:ocJrZNsnadQ0O0kXy2Y-zPfV-cTU27UMzUIYueVl6trnoQmwNDef7g>
    <xmx:ocJrZKo20H5Xl0pfIXfcRwNo-_xZN7g-i2bxKd1txZPxGHcOIeIsig>
Feedback-ID: i12284293:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 May 2023 15:29:36 -0400 (EDT)
Received: by x220.qyliss.net (Postfix, from userid 1000)
        id 63A674F6B; Mon, 22 May 2023 19:29:34 +0000 (UTC)
Date:   Mon, 22 May 2023 19:29:34 +0000
From:   Alyssa Ross <hi@alyssa.is>
To:     stable@vger.kernel.org
Cc:     Peng Zhang <zhangpeng.00@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        Tad <support@spotco.us>,
        Michael Keyes <mgkeyes@vigovproductions.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Robert Hensing <robert@hercules-ci.com>
Subject: Backport request: [PATCH] maple_tree: make maple state reusable
 after mas_empty_area()
Message-ID: <20230522192934.kz5gp7rp2jeycaqj@x220>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="wjxtelyvnyx74gz3"
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org


--wjxtelyvnyx74gz3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi, please backport commit 0257d9908d38c0b1669af4bb1bc4dbca1f273fe6 to
6.1.y onwards.  This patch fixes a regression which broke some programs,
like GHC (the Haskell compiler).  We've been shipping this patch in
NixOS unstable for the last couple of weeks, to positive results.

(The patch had "Cc: <stable@vger.kernel.org>" but from what I can tell
has not been selected for backporting.  Apologies if I've just missed
it.)

--wjxtelyvnyx74gz3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEH9wgcxqlHM/ARR3h+dvtSFmyccAFAmRrwpwACgkQ+dvtSFmy
ccD/7g/7BlQ3VME3ycFxsWrVaAawdGyWw1qrQVMSG7bANrnsbWKYz0adCc8xDghn
ljl/ugLFiUd1108T8uHCUXg6CB7qBOIrIB5pk3l+etaLZi5bHQnjhP8T8QjPLpdJ
dq2h/jkGNBbgnHunA3YjRiexbMbXr6g7KR9CZz9aVkVdH3uqRG5D8xlul5YkIIAl
Gjo3MFpBLbyLIEEE6Lkubea3y0Zu2NzEXnt/oJbEzU40v5vSKLYgl65LOYpGnVxw
Sa/mPyz46EWkqW6FYdLYj38CNdcJBX47hsqXdWGuxoKKtcUYoUtvotjFNZdB1Dhv
TqDNdMY0UJUll0I5hlzBnA2PD4QtbLiFzSRQIaEDm+sh2O+6TyE/0zWumPXv9nQn
2flpKejXbOTmUI6ndZi6gLU2Gu/9UwiA4peMMCsbL3KWeA9MVXZKp7UBgt3ZZUNB
OyZ3oqOTG9ThZHtBHOMVztgEpTp/RZC47cjzEFjdYY+lEGQ0hYQ+fedK8qg7irdp
OWJyr/gftXSR8v2ipQVn7YnsbRIk7eRA/kdq2iClHpyKhRqoB7BeFHEvRkE99Bmq
MrgGH3WMC6hJSOcv6QU6eMomirA2yNkG0vFXOKZYIWjFy1jppF1KDxgVnDK0oFev
XO0O6NmvTTWBQYwRSdWXm/zDsgpZXuupRo7jccn+HzgmwYebMIw=
=huCN
-----END PGP SIGNATURE-----

--wjxtelyvnyx74gz3--
