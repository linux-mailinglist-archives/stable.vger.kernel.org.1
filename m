Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2F31703BBA
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 20:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244968AbjEOSFz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 14:05:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244976AbjEOSFi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 14:05:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8D81DB31
        for <stable@vger.kernel.org>; Mon, 15 May 2023 11:03:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 986FA63090
        for <stable@vger.kernel.org>; Mon, 15 May 2023 18:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91EFDC433D2;
        Mon, 15 May 2023 18:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684173805;
        bh=Hf13nyguXXaPGcgEcjp/ke+LAzyZR1i4TTzswnk9gKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dVUFIuvhxGakX6gb2S/XYGs9D/h/n6BSYyKvcyNT866CTIsTXm61cgz6YucQu07fv
         4NhW7wCfD9efsUKg1WsCauT0jUfiKL9idzI4u8Q1qfUXDytNO+bukYilB77nY0qrmi
         rZoJ5FqkknNS/eC1JIeK/i7J+HDlqUHa4gu5SZJ8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 213/282] mailbox: zynq: Switch to flexible array to simplify code
Date:   Mon, 15 May 2023 18:29:51 +0200
Message-Id: <20230515161728.626005623@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161722.146344674@linuxfoundation.org>
References: <20230515161722.146344674@linuxfoundation.org>
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

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

[ Upstream commit 043f85ce81cb1714e14d31c322c5646513dde3fb ]

Using flexible array is more straight forward. It
  - saves 1 pointer in the 'zynqmp_ipi_pdata' structure
  - saves an indirection when using this array
  - saves some LoC and avoids some always spurious pointer arithmetic

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Jassi Brar <jaswinder.singh@linaro.org>
Stable-dep-of: f72f805e7288 ("mailbox: zynqmp: Fix counts of child nodes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mailbox/zynqmp-ipi-mailbox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mailbox/zynqmp-ipi-mailbox.c b/drivers/mailbox/zynqmp-ipi-mailbox.c
index 392df6b37bf55..1abeff7656462 100644
--- a/drivers/mailbox/zynqmp-ipi-mailbox.c
+++ b/drivers/mailbox/zynqmp-ipi-mailbox.c
@@ -110,7 +110,7 @@ struct zynqmp_ipi_pdata {
 	unsigned int method;
 	u32 local_id;
 	int num_mboxes;
-	struct zynqmp_ipi_mbox *ipi_mboxes;
+	struct zynqmp_ipi_mbox ipi_mboxes[];
 };
 
 static struct device_driver zynqmp_ipi_mbox_driver = {
@@ -635,7 +635,7 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	int num_mboxes, ret = -EINVAL;
 
 	num_mboxes = of_get_child_count(np);
-	pdata = devm_kzalloc(dev, sizeof(*pdata) + (num_mboxes * sizeof(*mbox)),
+	pdata = devm_kzalloc(dev, struct_size(pdata, ipi_mboxes, num_mboxes),
 			     GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
@@ -649,8 +649,6 @@ static int zynqmp_ipi_probe(struct platform_device *pdev)
 	}
 
 	pdata->num_mboxes = num_mboxes;
-	pdata->ipi_mboxes = (struct zynqmp_ipi_mbox *)
-			    ((char *)pdata + sizeof(*pdata));
 
 	mbox = pdata->ipi_mboxes;
 	for_each_available_child_of_node(np, nc) {
-- 
2.39.2



