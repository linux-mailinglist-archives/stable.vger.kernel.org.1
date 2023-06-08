Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA5A7276D4
	for <lists+stable@lfdr.de>; Thu,  8 Jun 2023 07:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjFHFoJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 8 Jun 2023 01:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234126AbjFHFoH (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 8 Jun 2023 01:44:07 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2949D2D42
        for <stable@vger.kernel.org>; Wed,  7 Jun 2023 22:43:54 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-650c8cb68aeso63555b3a.3
        for <stable@vger.kernel.org>; Wed, 07 Jun 2023 22:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686203033; x=1688795033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0z3pV+senCuLUg/ELwUDbtVZJMRdHx2QzMCNpr/4wi0=;
        b=hORIKpB65YlVBAXscdBX3Lj0tHhloaQFGOJS6QuMKdLqLYiqPqS/pxpLMBLN+oN6Cz
         yQNjPcftA65OJTHA12uKK7Z/CPaqJ0jcSTBpNBj9Vg4GstWC7XQ0F9872R9MLBdOxdJm
         L0rxUpBE+nzfBGhJSYyeHlJ6eT+gcclRKQ61Qi4Iv8M4lNwDa2Jg/2AFOnvBqXctHHQ1
         aLAWxazQZEVJD8KM2+GLxmHgV02KujCu3QGcLYFjJJPoCXvRacRhBqT+GUwTKnohqXoP
         xVa36C84Mk7VMDopFiYXCsBDrLVqdQwSrBbty97X8asOZY+C5qgRGI5iW/jjYmAeQSAm
         pwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686203033; x=1688795033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0z3pV+senCuLUg/ELwUDbtVZJMRdHx2QzMCNpr/4wi0=;
        b=I6SmlWUD7C4kg4XJtKkYk5ivcaF6GDyjVvWHeYWQ7dU1QuZbrbXpSL+HLGVcnTTuaa
         Fl7PsagV9lVXw422qUgSMI9x4TFz0FvHvaEk0YxQeCsEYinnIomaEoDeq5G5qObaI/cZ
         1QvtOiLguTHfWM6dBuOrEMmo0wYYqqCi+6YGXFjUdJCRYC0tm54wt9NqC+uiNuArC9YM
         b++xqoSr0QNPxgYPgTQMwKN2gAmiKTeKoi+BOkxN55FRaK6RUsSsMwwJgQd1I0gSrd43
         3wGfjXvirlOt18120qg9WxGjfvDjLC0HyhNu/jilNV1zdDTDrVnmu836miXONF5iRiuv
         Bq1A==
X-Gm-Message-State: AC+VfDx37hkr7/u5b7kJz5tMBcY0wNZtaXfr5yVMgdAJ+O+jRUqF2iDN
        kW4huip4gqrbaTNvnFAvujk=
X-Google-Smtp-Source: ACHHUZ4lLdQTAzfT8UvydlK8UXY7YcVyboUrOsGiLgC3M0iqKX25kyypyMkSnBIgAeIX85Esob0Ttg==
X-Received: by 2002:a05:6a20:e687:b0:10b:78d6:a2c8 with SMTP id mz7-20020a056a20e68700b0010b78d6a2c8mr2640419pzb.15.1686203033481;
        Wed, 07 Jun 2023 22:43:53 -0700 (PDT)
Received: from twhmp6px (mxsmtp211.mxic.com.tw. [211.75.127.162])
        by smtp.gmail.com with ESMTPSA id o3-20020a170902d4c300b001a24cded097sm463808plg.236.2023.06.07.22.43.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 22:43:53 -0700 (PDT)
Received: from linux-patcher.mp600.macronix.com (linux-patcher [172.17.236.35])
        by twhmp6px (Postfix) with ESMTPS id 0153480671;
        Thu,  8 Jun 2023 13:44:14 +0800 (CST)
From:   Jaime Liao <jaimeliao.tw@gmail.com>
To:     gregkh@linuxfoundation.org, sashal@kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, stable@vger.kernel.org
Cc:     alvinzhou@mxic.com.tw, juliensu@mxic.com.tw,
        liangyanyu13@gmail.com, JaimeLiao <jaimeliao.tw@gmail.com>
Subject: [PATCH] mtd: spinand: macronix: Add support for serial NAND flash
Date:   Thu,  8 Jun 2023 13:43:50 +0800
Message-Id: <20230608054350.21191-1-jaimeliao.tw@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: JaimeLiao <jaimeliao.tw@gmail.com>

MX35LFxGE4AD have been merge into Linux kernel mainline

Commit ID : 5ece78de88739b4c68263e9f2582380c1fd8314f

For SPI-NAND flash support on Linux kernel LTS v5.4.y

Add SPI-NAND flash MX35LF2GE4AD and MX35LF4GE4AD in id tables.

Those two flase have been validate on Xilinx zynq-picozed board and

Linux kernel LTS v5.4.242.

Signed-off-by: JaimeLiao <jaimeliao.tw@gmail.com>
---
 drivers/mtd/nand/spi/macronix.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/mtd/nand/spi/macronix.c b/drivers/mtd/nand/spi/macronix.c
index 21def3f8fb36..bbb1d68bce4a 100644
--- a/drivers/mtd/nand/spi/macronix.c
+++ b/drivers/mtd/nand/spi/macronix.c
@@ -116,6 +116,22 @@ static const struct spinand_info macronix_spinand_table[] = {
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35LF2GE4AD", 0x26,
+		     NAND_MEMORG(1, 2048, 64, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
+	SPINAND_INFO("MX35LF4GE4AD", 0x37,
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&mx35lfxge4ab_ooblayout, NULL)),
 };
 
 static int macronix_spinand_detect(struct spinand_device *spinand)
-- 
2.25.1

