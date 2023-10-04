Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A437B8A92
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244459AbjJDSgz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244601AbjJDSgn (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:36:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8169A7
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:36:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAE9C433C8;
        Wed,  4 Oct 2023 18:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696444599;
        bh=d9w+4Bf5hUq1xJerrZiUBWKFxJpO+ZulvELIAYfxqrI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pu4KLe2Ml5x9CNMBJvzMLtn72mzEi02AzdET/U/cSRpY/fQ/uc+QXO7Z4LM6lnGX2
         G9zWOiQiOl3W+xB9mABYlMd6ntlP3czt7Y1yshLOobfMVGD4B8HW9xdNnN+WPxSqaq
         d7FKQvbcYB3rM3mBKglDgaP5EIsZk9oMzd6GFh/8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Bjorn Andersson <quic_bjorande@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Bruce Ashfield <bruce.ashfield@gmail.com>,
        Jon Mason <jon.mason@arm.com>, Jon Mason <jdmason@kudzu.us>,
        Ross Burton <ross@burtonini.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mikko Rapeli <mikko.rapeli@linaro.org>
Subject: [PATCH 6.5 279/321] arm64: defconfig: remove CONFIG_COMMON_CLK_NPCM8XX=y
Date:   Wed,  4 Oct 2023 19:57:04 +0200
Message-ID: <20231004175242.209170353@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikko Rapeli <mikko.rapeli@linaro.org>

commit 7d3e4e9d3bde9c8bd8914d47ddaa90e0d0ffbcab upstream.

There is no code for this config option and enabling it in defconfig
causes warnings from tools which are detecting unused and obsolete
kernel config flags since the flag will be completely missing from
effective build config after "make olddefconfig".

Fixes yocto kernel recipe build time warning:

WARNING: [kernel config]: This BSP contains fragments with warnings:
...
[INFO]: the following symbols were not found in the active
configuration:
     - CONFIG_COMMON_CLK_NPCM8XX

The flag was added with commit 45472f1e5348c7b755b4912f2f529ec81cea044b
v5.19-rc4-15-g45472f1e5348 so 6.1 and 6.4 stable kernel trees are
affected.

Fixes: 45472f1e5348c7b755b4912f2f529ec81cea044b ("arm64: defconfig: Add Nuvoton NPCM family support")
Cc: stable@kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Tomer Maimon <tmaimon77@gmail.com>
Cc: Bruce Ashfield <bruce.ashfield@gmail.com>
Cc: Jon Mason <jon.mason@arm.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Ross Burton <ross@burtonini.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Mikko Rapeli <mikko.rapeli@linaro.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/configs/defconfig |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1145,7 +1145,6 @@ CONFIG_COMMON_CLK_S2MPS11=y
 CONFIG_COMMON_CLK_PWM=y
 CONFIG_COMMON_CLK_RS9_PCIE=y
 CONFIG_COMMON_CLK_VC5=y
-CONFIG_COMMON_CLK_NPCM8XX=y
 CONFIG_COMMON_CLK_BD718XX=m
 CONFIG_CLK_RASPBERRYPI=m
 CONFIG_CLK_IMX8MM=y


