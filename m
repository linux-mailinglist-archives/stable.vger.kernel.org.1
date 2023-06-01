Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0FB719DCA
	for <lists+stable@lfdr.de>; Thu,  1 Jun 2023 15:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbjFAN01 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Thu, 1 Jun 2023 09:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbjFAN0L (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 1 Jun 2023 09:26:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9635E55
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 06:25:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9E9E64480
        for <stable@vger.kernel.org>; Thu,  1 Jun 2023 13:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D85DBC433D2;
        Thu,  1 Jun 2023 13:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685625958;
        bh=6L1FH87cUecgL5LYQp4bLmJjpU5ULusIFhjuAeVV14Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q4f6mIRPBzm1VCc5cD54orlgd3zc6nuF1pOPUqC1Vir+VGChJGGWuSht25chSIuse
         dhgejicKYGIGY/r3cRolvJgCADCHKGNRjPusTP43yqvcuR7PxOnxrWktvYphte4MY7
         3KPEqc8gwFBZPiBwgTcOrJ8geEpWQiaw5fr7YkDQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 03/45] spi: spi-geni-qcom: Select FIFO mode for chip select
Date:   Thu,  1 Jun 2023 14:20:59 +0100
Message-Id: <20230601131938.858591135@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601131938.702671708@linuxfoundation.org>
References: <20230601131938.702671708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>

[ Upstream commit 4c329f5da7cfa366bacfda1328a025dd38951317 ]

Spi geni driver switches between FIFO and DMA modes based on xfer length.
FIFO mode relies on M_CMD_DONE_EN interrupt for completion while DMA mode
relies on XX_DMA_DONE.
During dynamic switching, if FIFO mode is chosen, FIFO related interrupts
are enabled and DMA related interrupts are disabled. And viceversa.
Chip select shares M_CMD_DONE_EN interrupt with FIFO to check completion.
Now, if a chip select operation is preceded by a DMA xfer, M_CMD_DONE_EN
interrupt would have been disabled and hence it will never receive one
resulting in timeout.

For chip select, in addition to setting the xfer mode to FIFO,
select_mode() to FIFO so that required interrupts are enabled.

Fixes: e5f0dfa78ac7 ("spi: spi-geni-qcom: Add support for SE DMA mode")
Suggested-by: Praveen Talari <quic_ptalari@quicinc.com
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com
Reviewed-by: Douglas Anderson <dianders@chromium.org
Link: https://lore.kernel.org/r/1683626496-9685-1-git-send-email-quic_vnivarth@quicinc.com
Signed-off-by: Mark Brown <broonie@kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/spi/spi-geni-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index babb039bcb431..b106faf21a723 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -294,6 +294,8 @@ static void spi_geni_set_cs(struct spi_device *slv, bool set_flag)
 	mas->cs_flag = set_flag;
 	/* set xfer_mode to FIFO to complete cs_done in isr */
 	mas->cur_xfer_mode = GENI_SE_FIFO;
+	geni_se_select_mode(se, mas->cur_xfer_mode);
+
 	reinit_completion(&mas->cs_done);
 	if (set_flag)
 		geni_se_setup_m_cmd(se, SPI_CS_ASSERT, 0);
-- 
2.39.2



