Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C71716FA609
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 12:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjEHKPb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 06:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbjEHKPa (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 06:15:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B5619413
        for <stable@vger.kernel.org>; Mon,  8 May 2023 03:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AA5662472
        for <stable@vger.kernel.org>; Mon,  8 May 2023 10:15:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B77C433D2;
        Mon,  8 May 2023 10:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683540928;
        bh=+HBhPyas3qgnFIzGUyho7JggeuDIy9lpNXuOlBjEDb4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYEMIU8CC9QdF+NmlzqfhdVbfc8pxS9CeI3cLkQBc78zvnwu3L3euxVTLiQwJnz+x
         nIv76fBb1MlnshE+Hsp9A8fIaDSVwN8d0EF2L3742skfmKaSWBVBlUx++VB/Hs6Wck
         KysQJdm35n/KlNKT+taYw/YJ3VNfMNdhwE29j7vY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Lee Jones <lee@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 550/611] mfd: arizona-spi: Add missing MODULE_DEVICE_TABLE
Date:   Mon,  8 May 2023 11:46:32 +0200
Message-Id: <20230508094439.882775188@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094421.513073170@linuxfoundation.org>
References: <20230508094421.513073170@linuxfoundation.org>
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

From: Charles Keepax <ckeepax@opensource.cirrus.com>

[ Upstream commit 972c91fd7beddc3f19c8c855f6e60e7dbd435cbd ]

This patch adds missing MODULE_DEVICE_TABLE definition
which generates correct modalias for automatic loading
of this driver when it is built as a module.

Fixes: 3f65555c417c ("mfd: arizona: Split of_match table into I2C and SPI versions")
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Lee Jones <lee@kernel.org>
Link: https://lore.kernel.org/r/20230323134138.834369-1-ckeepax@opensource.cirrus.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/arizona-spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/arizona-spi.c b/drivers/mfd/arizona-spi.c
index 941b0267d09d4..5c4af05ed0440 100644
--- a/drivers/mfd/arizona-spi.c
+++ b/drivers/mfd/arizona-spi.c
@@ -277,6 +277,7 @@ static const struct of_device_id arizona_spi_of_match[] = {
 	{ .compatible = "cirrus,cs47l24", .data = (void *)CS47L24 },
 	{},
 };
+MODULE_DEVICE_TABLE(of, arizona_spi_of_match);
 #endif
 
 static struct spi_driver arizona_spi_driver = {
-- 
2.39.2



