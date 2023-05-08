Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFED96FABE6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbjEHLSk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbjEHLSi (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:18:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2349837856
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:18:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF6C462C45
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B964EC433EF;
        Mon,  8 May 2023 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544717;
        bh=lTG+luMd77Qh27EKX3RVGrLrVXezVnKX5cn20xcRt4w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rznEdBpQAakaSAa0nAnRiOq9bckjsw0Q9wDpTgGM2eEfCu9YgAx2ajkBxIBoKv389
         lq0Yy9abWS2Ddlq6wsP5ncqZ2n4f/CvsMW0IdlHfeVW94ED4M5G7NKYJOH+ZeS/CQV
         Wt+dUgsIfm9yKFuKNBWKfCT5dUFW7ColUtBvTBlo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 501/694] spi: f_ospi: Add missing spi_mem_default_supports_op() helper
Date:   Mon,  8 May 2023 11:45:36 +0200
Message-Id: <20230508094450.325689962@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

[ Upstream commit bc43c5ec1a97772269785d19f62d32c91ac5fc36 ]

The .supports_op() callback function returns true by default after
performing driver-specific checks. Therefore the driver cannot apply
the buswidth in devicetree.

Call spi_mem_default_supports_op() helper to handle the buswidth
in devicetree.

Fixes: 1b74dd64c861 ("spi: Add Socionext F_OSPI SPI flash controller driver")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Link: https://lore.kernel.org/r/20230322023101.24490-1-hayashi.kunihiko@socionext.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-sn-f-ospi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-sn-f-ospi.c b/drivers/spi/spi-sn-f-ospi.c
index 333b22dfd8dba..0aedade8908c4 100644
--- a/drivers/spi/spi-sn-f-ospi.c
+++ b/drivers/spi/spi-sn-f-ospi.c
@@ -561,7 +561,7 @@ static bool f_ospi_supports_op(struct spi_mem *mem,
 	if (!f_ospi_supports_op_width(mem, op))
 		return false;
 
-	return true;
+	return spi_mem_default_supports_op(mem, op);
 }
 
 static int f_ospi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
-- 
2.39.2



