Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA5176FAA52
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbjEHLBi (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjEHLBO (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:01:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BBFD2E82C
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CECE61F39
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:00:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E78FDC433D2;
        Mon,  8 May 2023 11:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683543609;
        bh=TEaVhIydNQnLKiXJhWZpgFVvnkilYZ6X5krCV07KMXs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nSayjb7o1BOnkvd4OBGq+jLCcUZrKp+r0IzaBgy6m7nVHy43qrvWMk/bfHdB4Ivda
         LV7VNDbzr7YIWTnTotnNPNWLg4bbdvyzTjPzymxKaHzAfdCwRpxCtPGeDJxrXEeTb1
         9qDJA4VjJ+nXslBvYTD2lShcsQ1h5W/ZhujYBjxQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.3 115/694] mtd: core: provide unique name for nvmem device, take two
Date:   Mon,  8 May 2023 11:39:10 +0200
Message-Id: <20230508094436.205100643@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Michael Walle <michael@walle.cc>

commit 1cd9ceaa5282ff10ea20a7fbadde5a476a1cc99e upstream.

Commit c048b60d39e1 ("mtd: core: provide unique name for nvmem device")
tries to give the nvmem device a unique name, but fails badly if the mtd
device doesn't have a "struct device" associated with it, i.e. if
CONFIG_MTD_PARTITIONED_MASTER is not set. This will result in the name
"(null)-user-otp", which is not unique. It seems the best we can do is
to use the compatible name together with a unique identifier added by
the nvmem subsystem by using NVMEM_DEVID_AUTO.

Fixes: c048b60d39e1 ("mtd: core: provide unique name for nvmem device")
Cc: stable@vger.kernel.org
Signed-off-by: Michael Walle <michael@walle.cc>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://lore.kernel.org/linux-mtd/20230308082021.870459-1-michael@walle.cc
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/mtdcore.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -888,8 +888,8 @@ static struct nvmem_device *mtd_otp_nvme
 
 	/* OTP nvmem will be registered on the physical device */
 	config.dev = mtd->dev.parent;
-	config.name = kasprintf(GFP_KERNEL, "%s-%s", dev_name(&mtd->dev), compatible);
-	config.id = NVMEM_DEVID_NONE;
+	config.name = compatible;
+	config.id = NVMEM_DEVID_AUTO;
 	config.owner = THIS_MODULE;
 	config.type = NVMEM_TYPE_OTP;
 	config.root_only = true;
@@ -905,7 +905,6 @@ static struct nvmem_device *mtd_otp_nvme
 		nvmem = NULL;
 
 	of_node_put(np);
-	kfree(config.name);
 
 	return nvmem;
 }


