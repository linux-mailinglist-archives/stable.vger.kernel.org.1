Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 486CF74C346
	for <lists+stable@lfdr.de>; Sun,  9 Jul 2023 13:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232781AbjGILaV (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 9 Jul 2023 07:30:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbjGILaU (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 9 Jul 2023 07:30:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122DB13D
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 04:30:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A572B60BB7
        for <stable@vger.kernel.org>; Sun,  9 Jul 2023 11:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6994C433C8;
        Sun,  9 Jul 2023 11:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688902218;
        bh=/4RfEn+jpl0Owc2wkeIg3lMpnkvife/eyeL+xhSMds8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nNj79MZWRKLXo2tMOUMlstl7933oTcZeusFdE0lN5P0wO3+p0t1h5MvKeD+kS+huY
         U2V0IHRmi+ADiwtzxFiUhfdgy21v6ZXtowImEGe5SQ/lo7AH2vcf9FdxowJ3Gf8PdX
         TXDHeQEXouLDvGbmkCEqdw+XjN+NYnJeADFlftlg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 297/431] arm64: dts: qcom: sm8250-edo: Panel framebuffer is 2.5k instead of 4k
Date:   Sun,  9 Jul 2023 13:14:05 +0200
Message-ID: <20230709111458.106253437@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230709111451.101012554@linuxfoundation.org>
References: <20230709111451.101012554@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Marijn Suijten <marijn.suijten@somainline.org>

[ Upstream commit 223ce29c8b7e5b00f01a68387aabeefd77d97f06 ]

The framebuffer configuration for edo pdx203, written in edo dtsi (which
is overwritten in pdx206 dts for its smaller panel) has to use a
1096x2560 configuration as this is what the panel (and framebuffer area)
has been initialized to.  Downstream userspace also has access to (and
uses) this 2.5k mode by default, and only switches the panel to 4k when
requested.

This is similar to commit be8de06dc397 ("arm64: dts: qcom:
sm8150-kumano: Panel framebuffer is 2.5k instead of 4k") which fixed the
same for the previous generation Sony platform.

Fixes: 69cdb97ef652 ("arm64: dts: qcom: sm8250: Add support for SONY Xperia 1 II / 5 II (Edo platform)")
Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Bjorn Andersson <andersson@kernel.org>
Link: https://lore.kernel.org/r/20230606211418.587676-1-marijn.suijten@somainline.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
index b9c982a059dfb..c0f22a3bea5ce 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo.dtsi
@@ -26,9 +26,10 @@ chosen {
 		framebuffer: framebuffer@9c000000 {
 			compatible = "simple-framebuffer";
 			reg = <0 0x9c000000 0 0x2300000>;
-			width = <1644>;
-			height = <3840>;
-			stride = <(1644 * 4)>;
+			/* pdx203 BL initializes in 2.5k mode, not 4k */
+			width = <1096>;
+			height = <2560>;
+			stride = <(1096 * 4)>;
 			format = "a8r8g8b8";
 			/*
 			 * That's a lot of clocks, but it's necessary due
-- 
2.39.2



