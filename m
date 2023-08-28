Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCFD78AA2D
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjH1KTe (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjH1KTS (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:19:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 367FDD7
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:18:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F476371C
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0F26C433C7;
        Mon, 28 Aug 2023 10:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217936;
        bh=yfUUj19JEYQ9yptldE2Uf+55/4mxUbvBneJ1lQcPGdw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0XYaTW0YT6cWqvLtPGoocFw8XC02KXGLLLkRm0fs9Yqynp//LDqS8J5zga8ZeV2n+
         TnQ5DEySUj+dtFdMQgdZoG5R0ogFrZmI/kqttdpPmSPToHRIibxxiNiRuGqPsxVS+w
         i73aC5ImpFWqtCmh2/R46T6W3/H0WzP1CxxrMDoI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Zhengchao Shao <shaozhengchao@huawei.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.4 035/129] selftests: bonding: do not set port down before adding to bond
Date:   Mon, 28 Aug 2023 12:11:54 +0200
Message-ID: <20230828101158.554184023@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hangbin Liu <liuhangbin@gmail.com>

[ Upstream commit be809424659c2844a2d7ab653aacca4898538023 ]

Before adding a port to bond, it need to be set down first. In the
lacpdu test the author set the port down specifically. But commit
a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
changed the operation order, the kernel will set the port down _after_
adding to bond. So all the ports will be down at last and the test failed.

In fact, the veth interfaces are already inactive when added. This
means there's no need to set them down again before adding to the bond.
Let's just remove the link down operation.

Fixes: a4abfa627c38 ("net: rtnetlink: Enslave device before bringing it up")
Reported-by: Zhengchao Shao <shaozhengchao@huawei.com>
Closes: https://lore.kernel.org/netdev/a0ef07c7-91b0-94bd-240d-944a330fcabd@huawei.com/
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Link: https://lore.kernel.org/r/20230817082459.1685972-1-liuhangbin@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh     | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
index 47ab90596acb2..6358df5752f90 100755
--- a/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
+++ b/tools/testing/selftests/drivers/net/bonding/bond-break-lacpdu-tx.sh
@@ -57,8 +57,8 @@ ip link add name veth2-bond type veth peer name veth2-end
 
 # add ports
 ip link set fbond master fab-br0
-ip link set veth1-bond down master fbond
-ip link set veth2-bond down master fbond
+ip link set veth1-bond master fbond
+ip link set veth2-bond master fbond
 
 # bring up
 ip link set veth1-end up
-- 
2.40.1



