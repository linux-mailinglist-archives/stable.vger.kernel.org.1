Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B4D7A37C8
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 21:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239530AbjIQTYt (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 15:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239549AbjIQTYn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 15:24:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D3F118
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 12:24:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C37C433C8;
        Sun, 17 Sep 2023 19:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694978678;
        bh=yR3Y0b7w97sOgoFX6JUVZ1b/Sp5R17ACsC4swEO3Q/o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ugd/+cg0JGC6Rvwxn1NodcG4m2ZKyUNWtaQGGw1VLJPICOZAT4mmTDNrt+u+xGlHb
         yvUlCEZPQw3HliBC9h8LPdkhXTBztY4dYa9jwkz2Dxyo2/sJ76AgPTSmC/BJx1iuzz
         BQIUcS+i4nDBqGIz/R7PuwFb7smirKU2MRE7cw7o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 128/406] soc: qcom: ocmem: Add OCMEM hardware version print
Date:   Sun, 17 Sep 2023 21:09:42 +0200
Message-ID: <20230917191104.528739333@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191101.035638219@linuxfoundation.org>
References: <20230917191101.035638219@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Luca Weiss <luca@z3ntu.xyz>

[ Upstream commit e81a16e77259294cd4ff0a9c1fbe5aa0e311a47d ]

It might be useful to know what hardware version of the OCMEM block the
SoC contains. Add a debug print for that.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230509-ocmem-hwver-v3-1-e51f3488e0f4@z3ntu.xyz
Stable-dep-of: a7b484b1c933 ("soc: qcom: ocmem: Fix NUM_PORTS & NUM_MACROS macros")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/soc/qcom/ocmem.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
index 1dfdd0b9ba24d..ae023bef81b6f 100644
--- a/drivers/soc/qcom/ocmem.c
+++ b/drivers/soc/qcom/ocmem.c
@@ -76,6 +76,10 @@ struct ocmem {
 #define OCMEM_REG_GFX_MPU_START			0x00001004
 #define OCMEM_REG_GFX_MPU_END			0x00001008
 
+#define OCMEM_HW_VERSION_MAJOR(val)		FIELD_GET(GENMASK(31, 28), val)
+#define OCMEM_HW_VERSION_MINOR(val)		FIELD_GET(GENMASK(27, 16), val)
+#define OCMEM_HW_VERSION_STEP(val)		FIELD_GET(GENMASK(15, 0), val)
+
 #define OCMEM_HW_PROFILE_NUM_PORTS(val)		FIELD_PREP(0x0000000f, (val))
 #define OCMEM_HW_PROFILE_NUM_MACROS(val)	FIELD_PREP(0x00003f00, (val))
 
@@ -357,6 +361,12 @@ static int ocmem_dev_probe(struct platform_device *pdev)
 		}
 	}
 
+	reg = ocmem_read(ocmem, OCMEM_REG_HW_VERSION);
+	dev_dbg(dev, "OCMEM hardware version: %lu.%lu.%lu\n",
+		OCMEM_HW_VERSION_MAJOR(reg),
+		OCMEM_HW_VERSION_MINOR(reg),
+		OCMEM_HW_VERSION_STEP(reg));
+
 	reg = ocmem_read(ocmem, OCMEM_REG_HW_PROFILE);
 	ocmem->num_ports = OCMEM_HW_PROFILE_NUM_PORTS(reg);
 	ocmem->num_macros = OCMEM_HW_PROFILE_NUM_MACROS(reg);
-- 
2.40.1



