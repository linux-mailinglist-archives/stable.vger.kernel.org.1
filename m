Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92E9783366
	for <lists+stable@lfdr.de>; Mon, 21 Aug 2023 22:23:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjHUUJO (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 21 Aug 2023 16:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjHUUJN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 21 Aug 2023 16:09:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC2F184
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 13:09:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 299B364A62
        for <stable@vger.kernel.org>; Mon, 21 Aug 2023 20:09:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 328C3C433C7;
        Mon, 21 Aug 2023 20:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692648550;
        bh=eRpsNbnQ3kJ4uz7G3fp5zkl1k5LKpgowjroTaPcAryY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tLAO3nvLQMsnLGxnp+AWUcjcBJaEoKmAeoMWUsn7EraZTs4KpgHgjocl5EWdpkrLX
         7LmkD/36a5lu6XXwj6MNiV3mceMfYNzBYPdpZ06GvOd+4hQ4TRFtKX+tUkJYz4w84E
         dIf+4FM7NCqQCcABmsg67Rbbjs6uYc0IO04rNCTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Shazad Hussain <quic_shazhuss@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 6.4 214/234] dt-bindings: pinctrl: qcom,sa8775p-tlmm: add gpio function constant
Date:   Mon, 21 Aug 2023 21:42:57 +0200
Message-ID: <20230821194138.334690774@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230821194128.754601642@linuxfoundation.org>
References: <20230821194128.754601642@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Shazad Hussain <quic_shazhuss@quicinc.com>

commit f00295e890bbc8780cd2076ee17bc7a08a53091c upstream.

Alternative function 'gpio' is not listed in the constants for pin
configuration, so adding this constant to the list.

Cc: stable@vger.kernel.org
Fixes: 9a2aaee23c79 ("dt-bindings: pinctrl: describe sa8775p-tlmm")
Signed-off-by: Shazad Hussain <quic_shazhuss@quicinc.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Link: https://lore.kernel.org/r/20230719110344.19983-1-quic_shazhuss@quicinc.com
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 .../devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
index e608a4f1bcae..e119a226a4b1 100644
--- a/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
@@ -87,7 +87,7 @@ $defs:
                 emac0_mdc, emac0_mdio, emac0_ptp_aux, emac0_ptp_pps, emac1_mcg0,
                 emac1_mcg1, emac1_mcg2, emac1_mcg3, emac1_mdc, emac1_mdio,
                 emac1_ptp_aux, emac1_ptp_pps, gcc_gp1, gcc_gp2, gcc_gp3,
-                gcc_gp4, gcc_gp5, hs0_mi2s, hs1_mi2s, hs2_mi2s, ibi_i3c,
+                gcc_gp4, gcc_gp5, gpio, hs0_mi2s, hs1_mi2s, hs2_mi2s, ibi_i3c,
                 jitter_bist, mdp0_vsync0, mdp0_vsync1, mdp0_vsync2, mdp0_vsync3,
                 mdp0_vsync4, mdp0_vsync5, mdp0_vsync6, mdp0_vsync7, mdp0_vsync8,
                 mdp1_vsync0, mdp1_vsync1, mdp1_vsync2, mdp1_vsync3, mdp1_vsync4,
-- 
2.41.0



