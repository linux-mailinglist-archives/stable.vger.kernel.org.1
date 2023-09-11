Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3A079BAC3
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239096AbjIKVlL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241926AbjIKPSG (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:18:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311DAFA
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:18:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676F7C433C8;
        Mon, 11 Sep 2023 15:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445480;
        bh=V0GJWpnoLKNj4nHhg5lweOybXCxITJocfRhvjA+g95A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZkyPPX6nryYYEHm9zClnF8o5UTX1ZSmG1AOyJdriBJruWpdE7Rs5WCIC5YOXSrGd8
         nMaLLJlXV5whyMr1XO1HniSDrSqU09S085lf1jCTkkejAgGi5rnILTnbH+WKjj6cUj
         B/Qy5xjmQwXaNFWaQWEBEGCpS2mCA83InL3iWgYg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sven Peter <sven@svenpeter.dev>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Eric Curtin <ecurtin@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 335/600] PCI: apple: Initialize pcie->nvecs before use
Date:   Mon, 11 Sep 2023 15:46:08 +0200
Message-ID: <20230911134643.577843800@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Sven Peter <sven@svenpeter.dev>

[ Upstream commit d8650c0c2aa2e413594e4cb0faafa9958c1d7782 ]

The apple_pcie_setup_port() function computes ilog2(pcie->nvecs) to set
up the number of MSIs available for each port. However, it's called
before apple_msi_init(), which initializes pcie->nvecs.

Luckily, pcie->nvecs is part of kzalloc()-ed structure and, as such,
initialized as zero. ilog2(0) happens to be 0xffffffff which then simply
configures more MSIs in hardware than we have. This doesn't break
anything because we never hand out those vectors.

Thus, swap the order of the two calls so that the correctly initialized
value is then used.

[kwilczynski: commit log]
Link: https://lore.kernel.org/linux-pci/20230311133453.63246-1-sven@svenpeter.dev
Fixes: 476c41ed4597 ("PCI: apple: Implement MSI support")
Signed-off-by: Sven Peter <sven@svenpeter.dev>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
Reviewed-by: Eric Curtin <ecurtin@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/pcie-apple.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
index 66f37e403a09c..2340dab6cd5bd 100644
--- a/drivers/pci/controller/pcie-apple.c
+++ b/drivers/pci/controller/pcie-apple.c
@@ -783,6 +783,10 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 	cfg->priv = pcie;
 	INIT_LIST_HEAD(&pcie->ports);
 
+	ret = apple_msi_init(pcie);
+	if (ret)
+		return ret;
+
 	for_each_child_of_node(dev->of_node, of_port) {
 		ret = apple_pcie_setup_port(pcie, of_port);
 		if (ret) {
@@ -792,7 +796,7 @@ static int apple_pcie_init(struct pci_config_window *cfg)
 		}
 	}
 
-	return apple_msi_init(pcie);
+	return 0;
 }
 
 static int apple_pcie_probe(struct platform_device *pdev)
-- 
2.40.1



