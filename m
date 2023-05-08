Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621276FA7FE
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:36:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbjEHKg4 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:36:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjEHKge (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:36:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1362E28A89
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:36:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91128624B6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:36:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85077C433D2;
        Mon,  8 May 2023 10:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683542169;
        bh=gW+lWQ9tIJYeA/+8RpQLqbcV0FQy3caS1Caec1cjZ3w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oAar316ndmxisgnVn93GOFFo68mH2iNpMUJ4IravlzATj1Fuddt+VhqQ+jM4sQMAh
         D06aHVGB9YVgzw8SzEpihoIC04MZ+Qz/YWs8Bpr4tP2AFsnE5D8rJzvbUm56iMYx5b
         brnXHG/AQgINe9ZYgyt/vWBgo4ZDXZxOSPYECaXc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Sean Anderson <seanga2@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.2 317/663] net: sunhme: Fix uninitialized return code
Date:   Mon,  8 May 2023 11:42:23 +0200
Message-Id: <20230508094438.476408273@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094428.384831245@linuxfoundation.org>
References: <20230508094428.384831245@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Sean Anderson <seanga2@gmail.com>

[ Upstream commit d61157414d0a591d10d27d0ce5873916614e5e31 ]

Fix an uninitialized return code if we never found a qfe slot. It would be
a bug if we ever got into this situation, but it's good to return something
tracable.

Fixes: acb3f35f920b ("sunhme: forward the error code from pci_enable_device()")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Signed-off-by: Sean Anderson <seanga2@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/sun/sunhme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/sun/sunhme.c b/drivers/net/ethernet/sun/sunhme.c
index b0c7ab74a82ed..7cf8210ebbec3 100644
--- a/drivers/net/ethernet/sun/sunhme.c
+++ b/drivers/net/ethernet/sun/sunhme.c
@@ -2834,7 +2834,7 @@ static int happy_meal_pci_probe(struct pci_dev *pdev,
 	int i, qfe_slot = -1;
 	char prom_name[64];
 	u8 addr[ETH_ALEN];
-	int err;
+	int err = -ENODEV;
 
 	/* Now make sure pci_dev cookie is there. */
 #ifdef CONFIG_SPARC
-- 
2.39.2



