Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2D275CF26
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:27:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbjGUQ1t (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbjGUQ1d (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:27:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D874C1A
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:24:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7EB461D42
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:24:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D93C433C7;
        Fri, 21 Jul 2023 16:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956649;
        bh=DtnIluKV9lEKWp06u9tJP/B05JmMk+0HLeohL+d63/k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Hid/tZFKuQHNE3YyqZT38iQsNwfZBVEvkE0MnfghcXziNJYkTNurkiYGNT+1S1sKJ
         xOJ8lMldAdA9jygP050Csburz8xF3SToANOiInU6rPDs1BcpKEtmFEfthCxNaYZIbl
         JWGTcVS79tKemrt7wv3dTys/rqDUjYLObCsrZ000=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Yinjun Zhang <yinjun.zhang@corigine.com>,
        Simon Horman <simon.horman@corigine.com>,
        Louis Peens <louis.peens@corigine.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.4 224/292] nfp: clean mc addresses in application firmware when closing port
Date:   Fri, 21 Jul 2023 18:05:33 +0200
Message-ID: <20230721160538.492485791@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
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

From: Yinjun Zhang <yinjun.zhang@corigine.com>

commit cc7eab25b1cf3f9594fe61142d3523ce4d14a788 upstream.

When moving devices from one namespace to another, mc addresses are
cleaned in software while not removed from application firmware. Thus
the mc addresses are remained and will cause resource leak.

Now use `__dev_mc_unsync` to clean mc addresses when closing port.

Fixes: e20aa071cd95 ("nfp: fix schedule in atomic context when sync mc address")
Cc: stable@vger.kernel.org
Signed-off-by: Yinjun Zhang <yinjun.zhang@corigine.com>
Acked-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Louis Peens <louis.peens@corigine.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Message-ID: <20230705052818.7122-1-louis.peens@corigine.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index 49f2f081ebb5..6b1fb5708434 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -53,6 +53,8 @@
 #include "crypto/crypto.h"
 #include "crypto/fw.h"
 
+static int nfp_net_mc_unsync(struct net_device *netdev, const unsigned char *addr);
+
 /**
  * nfp_net_get_fw_version() - Read and parse the FW version
  * @fw_ver:	Output fw_version structure to read to
@@ -1084,6 +1086,9 @@ static int nfp_net_netdev_close(struct net_device *netdev)
 
 	/* Step 2: Tell NFP
 	 */
+	if (nn->cap_w1 & NFP_NET_CFG_CTRL_MCAST_FILTER)
+		__dev_mc_unsync(netdev, nfp_net_mc_unsync);
+
 	nfp_net_clear_config_and_disable(nn);
 	nfp_port_configure(netdev, false);
 
-- 
2.41.0



