Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72DED726E42
	for <lists+stable@lfdr.de>; Wed,  7 Jun 2023 22:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235099AbjFGUtN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 7 Jun 2023 16:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbjFGUsu (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 7 Jun 2023 16:48:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A362D4C
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 13:48:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4926A646D4
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 20:48:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C235C4339B;
        Wed,  7 Jun 2023 20:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686170908;
        bh=7Cz8Dnpu06YjU9uSRurtKxpOQHGwnWz9u2VS9twgqzc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jHr0G9W9zeXAFgCVmAhMVWlS1ev8vyXtXObGiRRt295DuS0LD1GoenWGt200XOMyE
         77nD8T4lqAQt5q33BnNTx5m+Iu43pQKf0TXlQk6lZrlut9kqpvg5UQWFgKn8/0oaUL
         adJW127bxD1YQ6K7IFchgLczmh6DgDmXvT6lbxtU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Andreas Svensson <andreas.svensson@axis.com>,
        Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 030/120] net: dsa: mv88e6xxx: Increase wait after reset deactivation
Date:   Wed,  7 Jun 2023 22:15:46 +0200
Message-ID: <20230607200901.861390609@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230607200900.915613242@linuxfoundation.org>
References: <20230607200900.915613242@linuxfoundation.org>
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

From: Andreas Svensson <andreas.svensson@axis.com>

[ Upstream commit 3c27f3d53d588618d81d30d6712459a3cc9489b8 ]

A switch held in reset by default needs to wait longer until we can
reliably detect it.

An issue was observed when testing on the Marvell 88E6393X (Link Street).
The driver failed to detect the switch on some upstarts. Increasing the
wait time after reset deactivation solves this issue.

The updated wait time is now also the same as the wait time in the
mv88e6xxx_hardware_reset function.

Fixes: 7b75e49de424 ("net: dsa: mv88e6xxx: wait after reset deactivation")
Signed-off-by: Andreas Svensson <andreas.svensson@axis.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/r/20230530145223.1223993-1-andreas.svensson@axis.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 321c821876f65..8b2c8546f4c99 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5547,7 +5547,7 @@ static int mv88e6xxx_probe(struct mdio_device *mdiodev)
 		goto out;
 	}
 	if (chip->reset)
-		usleep_range(1000, 2000);
+		usleep_range(10000, 20000);
 
 	err = mv88e6xxx_detect(chip);
 	if (err)
-- 
2.39.2



