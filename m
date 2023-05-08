Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5B76FAD49
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235971AbjEHLdT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236005AbjEHLdC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:33:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C174E30E69
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:32:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 17D0B630CD
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06558C433EF;
        Mon,  8 May 2023 11:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683545516;
        bh=UXqE0aF+Dgzy9JzQ6TuSK4YCephGJml1toDoiacqo0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ridc6MTOk4R71lp3Jy67frxD1wm3K2l6Tnaute1Q0IaYfExUE39Osm62/Ylsrx2GU
         hmset/k1ELw0t0ZeC0u1pH2kzvMGjfwAqvezxG8FS9uFsWgY7vHW/MCMebSedq7FYV
         qFLVPn3/zul6N7wwArEVJA6wRpCOzwrY05gD6iCg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15 036/371] soundwire: qcom: correct setting ignore bit on v1.5.1
Date:   Mon,  8 May 2023 11:43:57 +0200
Message-Id: <20230508094813.521074650@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit bd934f77eeac377e81ddac8673803e7334b82d3d upstream.

According to the comment and to downstream sources, the
SWRM_CONTINUE_EXEC_ON_CMD_IGNORE in SWRM_CMD_FIFO_CFG_ADDR register
should be set for v1.5.1 and newer, so fix the >= operator.

Fixes: 542d3491cdd7 ("soundwire: qcom: set continue execution flag for ignored commands")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230222140343.188691-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soundwire/qcom.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -640,7 +640,7 @@ static int qcom_swrm_init(struct qcom_sw
 
 	ctrl->reg_write(ctrl, SWRM_MCP_BUS_CTRL, SWRM_MCP_BUS_CLK_START);
 	/* Configure number of retries of a read/write cmd */
-	if (ctrl->version > 0x01050001) {
+	if (ctrl->version >= 0x01050001) {
 		/* Only for versions >= 1.5.1 */
 		ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CFG_ADDR,
 				SWRM_RD_WR_CMD_RETRIES |


