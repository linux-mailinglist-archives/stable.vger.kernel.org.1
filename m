Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E417A3A1E
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:59:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240287AbjIQT67 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240293AbjIQT6o (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:58:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD513101
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:58:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0188C433C7;
        Sun, 17 Sep 2023 19:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694980718;
        bh=DiOt5lGoDxpcpaVyitKsaZk2ZI3LFV/jcW3m8keBteI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zljWDBCCihvWqCM0H2hfVq4mFMFcINNJ2h4LOpQKqJpBfrka7oDAvYNngXUwa8GST
         wCNo1zsbnPU/NXfhfdvsxds08mbpCX3xM4o2Qq/hOAQ7sDy0j7p7Ia05GyMKPQz2Ed
         cZs4ffUat61mrGl0jcUns7Kf41rwPkcPuCjCiETs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 274/285] veth: Update XDP feature set when bringing up device
Date:   Sun, 17 Sep 2023 21:14:34 +0200
Message-ID: <20230917191100.644470302@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191051.639202302@linuxfoundation.org>
References: <20230917191051.639202302@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toke Høiland-Jørgensen <toke@redhat.com>

[ Upstream commit 7a6102aa6df0d5d032b4cbc51935d1d4cda17254 ]

There's an early return in veth_set_features() if the device is in a down
state, which leads to the XDP feature flags not being updated when enabling
GRO while the device is down. Which in turn leads to XDP_REDIRECT not
working, because the redirect code now checks the flags.

Fix this by updating the feature flags after bringing the device up.

Before this patch:

NETDEV_XDP_ACT_BASIC:		yes
NETDEV_XDP_ACT_REDIRECT:	yes
NETDEV_XDP_ACT_NDO_XMIT:	no
NETDEV_XDP_ACT_XSK_ZEROCOPY:	no
NETDEV_XDP_ACT_HW_OFFLOAD:	no
NETDEV_XDP_ACT_RX_SG:		yes
NETDEV_XDP_ACT_NDO_XMIT_SG:	no

After this patch:

NETDEV_XDP_ACT_BASIC:		yes
NETDEV_XDP_ACT_REDIRECT:	yes
NETDEV_XDP_ACT_NDO_XMIT:	yes
NETDEV_XDP_ACT_XSK_ZEROCOPY:	no
NETDEV_XDP_ACT_HW_OFFLOAD:	no
NETDEV_XDP_ACT_RX_SG:		yes
NETDEV_XDP_ACT_NDO_XMIT_SG:	yes

Fixes: fccca038f300 ("veth: take into account device reconfiguration for xdp_features flag")
Fixes: 66c0e13ad236 ("drivers: net: turn on XDP features")
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
Link: https://lore.kernel.org/r/20230911135826.722295-1-toke@redhat.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/veth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 2db678c0082a3..fc0d0114d8c27 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1447,6 +1447,8 @@ static int veth_open(struct net_device *dev)
 		netif_carrier_on(peer);
 	}
 
+	veth_set_xdp_features(dev);
+
 	return 0;
 }
 
-- 
2.40.1



