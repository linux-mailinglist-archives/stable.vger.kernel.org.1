Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0520B75D3F6
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 21:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231974AbjGUTQY (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 15:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbjGUTQX (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 15:16:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38AB31BF4
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 12:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66CA261D70
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 19:16:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785A2C433C8;
        Fri, 21 Jul 2023 19:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689966980;
        bh=mYol58Tm4Eyzr9ylW6hARbB9cKpEcLx84V2v0iU5YGc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HnJW34uFIjPz12ii1hC+MTmLzxu/SVxBLS7Q96bDGFKbIFJ4udCXpfomTM2krZ+WZ
         JxzH96zSMx2GtwfFfhVefxa43vxsL3f2lLBA6/Q4tTMIqhwns9yjS3gxr+1FWY84PY
         vuty36COJMa4wZLtHX2Pro3L8zcuy0bQLOAQdPgY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Subject: [PATCH 5.15 506/532] soundwire: qcom: fix storing port config out-of-bounds
Date:   Fri, 21 Jul 2023 18:06:50 +0200
Message-ID: <20230721160642.073408499@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160614.695323302@linuxfoundation.org>
References: <20230721160614.695323302@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 490937d479abe5f6584e69b96df066bc87be92e9 upstream.

The 'qcom_swrm_ctrl->pconfig' has size of QCOM_SDW_MAX_PORTS (14),
however we index it starting from 1, not 0, to match real port numbers.
This can lead to writing port config past 'pconfig' bounds and
overwriting next member of 'qcom_swrm_ctrl' struct.  Reported also by
smatch:

  drivers/soundwire/qcom.c:1269 qcom_swrm_get_port_config() error: buffer overflow 'ctrl->pconfig' 14 <= 14

Fixes: 9916c02ccd74 ("soundwire: qcom: cleanup internal port config indexing")
Cc: <stable@vger.kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202305201301.sCJ8UDKV-lkp@intel.com/
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20230601102525.609627-1-krzysztof.kozlowski@linaro.org
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/soundwire/qcom.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -146,7 +146,8 @@ struct qcom_swrm_ctrl {
 	u32 intr_mask;
 	u8 rcmd_id;
 	u8 wcmd_id;
-	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS];
+	/* Port numbers are 1 - 14 */
+	struct qcom_swrm_port_config pconfig[QCOM_SDW_MAX_PORTS + 1];
 	struct sdw_stream_runtime *sruntime[SWRM_MAX_DAIS];
 	enum sdw_slave_status status[SDW_MAX_DEVICES + 1];
 	int (*reg_read)(struct qcom_swrm_ctrl *ctrl, int reg, u32 *val);


